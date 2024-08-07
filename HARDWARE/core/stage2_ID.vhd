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

  type CodeRegion is (BOOTLOADER, TRAP_ENTRY, K_TRAP_ENTRY, W_STVEC, HEX2ASCII, TRAP_HANDLER, TRAP_REENTRY,KERNEL_EXCP_HANDLER, KERNEL_FUNC, K_RX_CALLBACK, KERNEL_FUNC2, KERNEL_M_EXT, K_BDPORT_S, K_UART_TX, K_UART_RX, ASCII_2_INT, MAIN, USER, OTHER);

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
                  K_TRAP_ENTRY  when (unsigned(ifid.pc) >= to_unsigned(86, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(161, ifid.pc'length)) else 
                  W_STVEC       when (unsigned(ifid.pc) >= to_unsigned(162, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(171, ifid.pc'length)) else 
                  HEX2ASCII    when (unsigned(ifid.pc) >= to_unsigned(172, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(220, ifid.pc'length)) else 
                  TRAP_HANDLER  when (unsigned(ifid.pc) >= to_unsigned(221, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(270, ifid.pc'length)) else 
                  TRAP_REENTRY  when (unsigned(ifid.pc) >= to_unsigned(271, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(303, ifid.pc'length)) else
                  KERNEL_EXCP_HANDLER  when (unsigned(ifid.pc) >= to_unsigned(304, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(690, ifid.pc'length)) else 
                  KERNEL_FUNC  when (unsigned(ifid.pc) >= to_unsigned(691, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(865, ifid.pc'length)) else 
                -- K_EINTR_HS    when (unsigned(ifid.pc) >= to_unsigned(367, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(393, ifid.pc'length)) else 
                 -- K_EINTR_DEF   when (unsigned(ifid.pc) >= to_unsigned(394, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(408, ifid.pc'length)) else 
                 -- K_BDPORT_S    when (unsigned(ifid.pc) >= to_unsigned(409, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(429, ifid.pc'length)) else 
                  K_UART_TX     when (unsigned(ifid.pc) >= to_unsigned(866, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(897, ifid.pc'length)) else 
                  K_UART_RX     when (unsigned(ifid.pc) >= to_unsigned(898, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(920, ifid.pc'length)) else 
                  K_RX_CALLBACK    when (unsigned(ifid.pc) >= to_unsigned(921, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(958, ifid.pc'length)) else 
                  KERNEL_FUNC2   when (unsigned(ifid.pc) >= to_unsigned(959, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(1014, ifid.pc'length)) else 
                  KERNEL_M_EXT   when (unsigned(ifid.pc) >= to_unsigned(1015, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(1604, ifid.pc'length)) else 
                  MAIN          when (unsigned(ifid.pc) >= to_unsigned(1605, ifid.pc'length) and unsigned(ifid.pc) <= to_unsigned(1778, ifid.pc'length)) else 
                  USER          when (unsigned(ifid.pc) >= to_unsigned(1779, ifid.pc'length)) else 
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
