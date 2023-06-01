library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.muAica_pkg.all;


entity muAica is
  port
  (
    clk     : in    std_logic;    -- clock input
    rst_bt  : in    std_logic;    -- reset input (it's gonna pass through debounce logic)
    intr    : in    std_logic
    --- UART
  );
end entity muAica;

architecture behavior of muAica is

  COMPONENT bt_debounce is
    port
    (
      clk   : in  std_logic;
      bt_in : in  std_logic;
      bt_out: out std_logic
    );
  end COMPONENT bt_debounce;

  -- System reset
  signal  rst_int : std_logic := '1';
  signal  rst_db  : std_logic;
  signal  rst     : std_logic;

  -- Memory
  signal  addr_inst : std_logic_vector(n-1 downto 2);
  signal  mem_idata : std_logic_vector(n-1 downto 0);
  signal  mem_iaddr : std_logic_vector(n-1 downto 0);
  signal  core_idata : std_logic_vector(n-1 downto 0);
  signal  core_daddr : std_logic_vector(n-1 downto 0);
  signal  core_ddata : std_logic_vector(n-1 downto 0);
  signal  data_in_inst : std_logic_vector(n-1 downto 0);
  signal  addr_data : std_logic_vector(n-1 downto 0);
  signal  data_data1 : std_logic_vector(n-1 downto 0);
  
  signal  data_out : std_logic_vector(n-1 downto 0);  -- data memory output
  signal  data_in : std_logic_vector(n-1 downto 0); -- data memory input
  signal  wbe       : std_logic_vector(3 downto 0);
  
  constant RISCV_INSTRUCTION_OFFSET    : std_logic_vector(31 downto 0) := x"00000000";
  constant RISCV_DATA_OFFSET           : std_logic_vector(31 downto 0) := x"00000000";

  -- Core control to/from Cache
  signal  stall_icache  : std_logic;
  signal  valid_iaddr   : std_logic;
  signal  wait_i        : std_logic;
  signal  valid_daddr   : std_logic;
  signal  sb_en         : std_logic;
  signal  sh_en         : std_logic;
  signal  we            : std_logic;
  
  signal  ce_data            : std_logic;
  
  signal  io_intr     : std_logic;
  
  
  
begin

  ------------------------------------------------
  --- System Reset Process
  rst_internal :	process (clk)
  begin
    if (rising_edge(clk)) then
      if (rst_db = '1') then
        rst_int <= '0';
      end if;
    end if;
  end process rst_internal;

  rst <= rst_db OR rst_int; -- system reset

-- Port Map
  -- core instance
  AICA_CORE: entity work.core(behavior)
  port map(
    rst           => rst ,
    clk           => clk ,
    intr          => intr,
    we            => we ,
    stall_icache  => stall_icache,
    valid_iaddr   => valid_iaddr,
    valid_daddr   => valid_daddr,
    wait_i        => '0',
    wait_d        => '0',
    sb_en         => sb_en ,
    sh_en         => sh_en ,
    addr_icache   => addr_inst ,
    data_icache   => core_idata ,
    addr_dcache   => core_daddr , 
    data_dcache   => core_ddata
  );


  
  MEMORY_CONTROL:	entity work.MemoryCtrl(behavioral)
	port map (
		clock	=> clk,
		rst		=> rst,
		core_iaddr => addr_inst,
		core_idata => core_idata,
		valid_iaddr => valid_iaddr,
		stall_icache => stall_icache,
		inst_addr => mem_iaddr,
		inst_data => mem_idata,
		-- Data memory, from core 
		core_daddr 	=> core_daddr,
		core_ddata	=> core_ddata,
		valid_daddr => valid_daddr,
		we			=> we,
		sb_en		=> sb_en,
		sh_en		=> sh_en,
		-- To data memory
		addr_data	=> addr_data,
		mem_data_in		=> data_in,
		mem_data_out	=> data_out, 
		wbe    		=> wbe,
		ce			=> ce_data
	);
  
  INSTRUCTION_MEMORY: entity work.Memory(behavioral)
	generic map (
		SIZE            => 4096,                                  -- Memory depth 
		ADDR_WIDTH		=> 32,
		COL_WIDTH		=> 8,
		NB_COL			=> 4,
		imageFileName   => "code.txt",
		OFFSET          => UNSIGNED(RISCV_INSTRUCTION_OFFSET)   -- initial address (mapped to memory address 0x00000000)
	)
	port map (
		clock           => clk,
		wbe				=> "0000", -- we ?
		ce              => '1',
		address         => mem_iaddr, --instructionAddress(31 downto 2), -- Converts byte address to word address     
		data_i          => data_in_inst,
		data_o          => mem_idata
	);
	
DATA_MEMORY: entity work.Memory(behavioral)
	generic map (
		SIZE            => 4096,                         -- Memory depth 
		ADDR_WIDTH		=> 32,
		COL_WIDTH		=> 8,
		NB_COL			=> 4,
		imageFileName   => "data.txt",
		OFFSET          => UNSIGNED(RISCV_DATA_OFFSET)  -- initial address
	)
	port map (
		clock           => clk,
		wbe				=> wbe, -- we ?
		ce              => ce_data,
		address         => addr_data, --dataAddress(31 downto 2),    -- Converts byte address to word address 
		data_i          => data_in,
		data_o          => data_out
	);   
	

  ---------------------------------------------
  ----- RESET BUTTON DEBOUNCE
  rst_bt_debounce_i:  bt_debounce
  port map
  (
    clk     => clk,
    bt_in   => rst_bt,
    bt_out  => rst_db
  );

end architecture behavior;
