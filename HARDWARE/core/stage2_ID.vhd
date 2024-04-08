library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.core_pkg.all;

entity stage2_ID is
  port(
    rst           : in  std_logic;
    clk           : in  std_logic;
    -- cache signals
    wait_d        : in  std_logic;
    -- stage stall/flush flag
    flush_branch  : in  std_logic;
    flush_excp    : in  std_logic;
    stall_id_if   : out std_logic;
    -- signals from stage EX and WB
    ex2id         : in  data_ex2id;
    wb2id         : in  data_wb2id;
    -- stage pipeline register, IF/ID and ID/EX
    ifid          : in  regs_ifid;
    idex          : out regs_idex
  );
end entity stage2_ID;

architecture behavior of stage2_ID is

  type CodeRegion is (BOOTLOADER, TRAP_ENTRY, ECALLS, TRAP_HANDLER, K_EINTR_DISP, K_EINTR_HS, K_EINTR_DEF, K_BDPORT_S, K_UART_TX, K_RX_CALLBACK, ASCII_2_INT, MAIN, USER, OTHER);

  signal codeRegion_s : CodeRegion;

  -- Flush ID flag
  signal  flush_id  : std_logic;

  -- Instruction fields
  alias   id_imm    : std_logic_vector(31 downto 7)       is  ifid.instr(31 downto 7);
  alias   id_funct7 : std_logic_vector(6 downto 0)        is  ifid.instr(31 downto 25); -- R type
  alias   id_rs2    : std_logic_vector(n_reg-1 downto 0)  is  ifid.instr(24 downto 20);
  alias   id_rs1    : std_logic_vector(n_reg-1 downto 0)  is  ifid.instr(19 downto 15);
  alias   id_funct3 : std_logic_vector(2 downto 0)        is  ifid.instr(14 downto 12);
  alias   id_rd     : std_logic_vector(n_reg-1 downto 0)  is  ifid.instr(11 downto 7);
  alias   id_opcode : std_logic_vector(6 downto 0)        is  ifid.instr(6 downto 0);

  -- Control unit output
  signal  id_regfile_w_t  : std_logic;
  signal  id_regfile_w    : std_logic;
  signal  id_regfile_src0 : std_logic;
  signal  id_branch_unc   : std_logic;
  signal  id_branch       : std_logic;
  signal  id_branch_src   : std_logic;
  signal  id_mem_r        : std_logic;
  signal  id_mem_w        : std_logic;
  signal  id_csr_en       : std_logic;
  signal  id_alu_op       : std_logic_vector(1 downto 0);
  signal  id_alu_oprb     : std_logic;
  signal  id_instr_excp   : std_logic;

  -- Imm unit
  signal  imm_out         : std_logic_vector(n-1 downto 0);

  -- Hazard unit
  signal  stall_bubble    : std_logic;

  -- Register file output
  signal  id_data_rs1     : std_logic_vector(n-1 downto 0);
  signal  id_data_rs2     : std_logic_vector(n-1 downto 0);

  -- PC value, set to 0 if the instr. is a LUI, so we can add to the immediate signal
  signal  id_pc           : std_logic_vector(n_pc-1 downto 0);
  signal  lui_flag        : std_logic;
  signal  lui_and         : std_logic_vector(n_pc-1 downto 0);

  -- Saved PC value, used as CSR mepc input
  signal  id_pc_csr       : std_logic_vector(n_pc-1 downto 0);

  -- Illegal / not implemented instruction
  signal  id_instr_not_impl : std_logic;


begin

  --------
  -- Stage ID flush
  flush_id <= flush_branch OR flush_excp;

  codeRegion_s <= BOOTLOADER    when (unsigned(ifid.pc) < to_unsigned(7, ifid.pc'length)) else
                  TRAP_ENTRY    when (unsigned(ifid.pc) >= to_unsigned(7, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(85, ifid.pc'length)) else 
                  ECALLS        when (unsigned(ifid.pc) >= to_unsigned(86, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(113, ifid.pc'length)) else 
                  TRAP_HANDLER  when (unsigned(ifid.pc) >= to_unsigned(165, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(505, ifid.pc'length)) else 
                 -- K_EINTR_DISP  when (unsigned(ifid.pc) >= to_unsigned(329, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(366, ifid.pc'length)) else 
                -- K_EINTR_HS    when (unsigned(ifid.pc) >= to_unsigned(367, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(393, ifid.pc'length)) else 
                 -- K_EINTR_DEF   when (unsigned(ifid.pc) >= to_unsigned(394, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(408, ifid.pc'length)) else 
                 -- K_BDPORT_S    when (unsigned(ifid.pc) >= to_unsigned(409, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(429, ifid.pc'length)) else 
                  K_UART_TX     when (unsigned(ifid.pc) >= to_unsigned(642, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(673, ifid.pc'length)) else 
                 -- K_RX_CALLBACK when (unsigned(ifid.pc) >= to_unsigned(553, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(561, ifid.pc'length)) else 
                 -- ASCII_2_INT   when (unsigned(ifid.pc) >= to_unsigned(562, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(614, ifid.pc'length)) else 
                  MAIN          when (unsigned(ifid.pc) >= to_unsigned(1024, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(1207, ifid.pc'length)) else 
                  USER          when (unsigned(ifid.pc) >= to_unsigned(1800, ifid.pc'length)) else 
                  OTHER; 

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------- Hazard Unit: detect data hazard due to loads, example:
------  lw  x1,DATA
------  add x3,x2,x1  -> add need the new x1 value, but can't get it through
------                  the current forwarding, so we stall the pipeline for 1 clock period
----- => stall_id_if is the flag for the stage IF, and stall_bubble for the ID

  stall_bubble <=	'1' when ((ex2id.mem_r = '1' AND id_mem_w = '0' AND (ex2id.rd = id_rs1 OR ex2id.rd = id_rs2)) OR 
                            (ex2id.mem_r = '1' AND id_mem_w = '1' AND (ex2id.rd = id_rs1 OR ex2id.rd = id_rs2))) else
                  '0';

  stall_id_if  <= stall_bubble AND (NOT(flush_id));
    -- the stall signal act different in stage 1 and 2:
    -- stage1: disable write (pipeline register, pc, bht, etc.) => stall
    -- stage2: sends a NOP to the next stage => bubble

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------- Control Logic
  --------------------------------------
  --- We reset the 'RegFile_W' control signal if reg. dest = x0,
  id_regfile_w <= '0' when (id_rd = "00000") else
                  id_regfile_w_t;

  --------------------------------------
  --- The PC value is set to 0, so we can use add to the immediate signal in a LUI instr.,
  --- it is possible since the PC value doesnt matter for that instruction
  lui_flag <= '0' when (id_opcode(6 downto 2) = lui_op) else '1';
  lui_and	 <= (others => lui_flag);

  id_pc    <= ifid.pc AND lui_and;

  id_pc_csr <= ifid.pc;

  --------------------------------------
  -- Check for instructions that weren't implemented
  -- raise exception so we can deal with them through software
  id_instr_not_impl <= '1' when (id_funct7 = "0000001" AND id_opcode(6 downto 2) = opreg_op) else -- Check for 'M' extension (MUL/DIV/REM)
                        '0';

------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------- Pipeline Register
  -- on a reset, flush or invalid instruction, only the control signals are used (the ones needed)
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        idex.branch_stt <= (others => '0');
        idex.pipe_fill  <= '0';
        idex.regfile_w  <= '0';
        idex.branch_unc <= '0';
        idex.branch     <= '0';
        idex.mem_r      <= '0';
        idex.mem_w      <= '0';
        idex.csr_en     <= '0';
        idex.instr_excp <= '0';

      elsif (wait_d = '1') then
        null;

      elsif (flush_id = '1' OR stall_bubble = '1') then
        idex.branch_stt <= (others => '0');
        idex.pipe_fill  <= '0';
        idex.regfile_w  <= '0';
        idex.branch_unc <= '0';
        idex.branch     <= '0';
        idex.mem_r      <= '0';
        idex.mem_w      <= '0';
        idex.csr_en     <= '0';
        idex.instr_excp <= '0';

      else
        idex.branch_stt   <= ifid.branch_stt;
        idex.pipe_fill    <= ifid.pipe_fill;
        -- pipeline register, ctrl signals
        idex.regfile_w    <= id_regfile_w;
        idex.regfile_src0 <= id_regfile_src0;
        idex.branch_unc   <= id_branch_unc;
        idex.branch       <= id_branch;
        idex.branch_src   <= id_branch_src;
        idex.mem_r        <= id_mem_r;
        idex.mem_w        <= id_mem_w;
        idex.csr_en       <= id_csr_en;
        idex.instr_excp   <= id_instr_excp OR id_instr_not_impl; -- Check for lsb(2:0) and MUL/DIV/REM
        idex.alu_op       <= id_alu_op;
        -- pipeline register, others fields
        idex.pc           <= id_pc;
        idex.pc_csr       <= id_pc_csr;
        idex.data_rs1     <= id_data_rs1;
        idex.data_rs2     <= id_data_rs2;
        idex.imm          <= imm_out;
        idex.funct3       <= id_funct3;
        idex.rs1          <= id_rs1;
        idex.rs2          <= id_rs2;
        idex.rd           <= id_rd;

      end if;
    end if;
  end process;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
  -- register file instance
  RegFile_i: RegFile
  port map(
    rst       => rst,
    clk       => clk,
    ------------------------------
    rs1       => id_rs1,
    rs2       => id_rs2,
    data_rs1  => id_data_rs1,
    data_rs2  => id_data_rs2,
    ------------------------------
    rd        => wb2id.rd,
    data_rd   => wb2id.data_rd,
    RegFile_W => wb2id.regfile_w
  );

  -- immediate unit instance
  Imm_unit_i: Imm_unit
  port map(
    opcode    => id_opcode(6 downto 2),
    imm_field => id_imm,
    imm_out   => imm_out
  );

  -- control unit instance
  Ctrl_unit_i: Ctrl_unit
  port map(
    id_opcode     => id_opcode,
    -----------------------------
    regfile_w     => id_regfile_w_t,
    regfile_src0  => id_regfile_src0,
    branch_unc    => id_branch_unc,
    branch        => id_branch,
    branch_src    => id_branch_src,
    mem_r         => id_mem_r,
    mem_w         => id_mem_w,
    csr_en        => id_csr_en,
    alu_op        => id_alu_op,
    instr_excp    => id_instr_excp
  );

end architecture behavior;
