library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.muAica_pkg.all;


entity muAica is
  port
  (
    clk     : in    std_logic;    -- clock input
    rst_bt  : in    std_logic;    -- reset input (it's gonna pass through debounce logic)
    port_io : inout std_logic_vector (n-1 downto 0); -- configurable IO port

    tx      : out std_logic;
	tx_active : out std_logic
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
  signal  addr_prph : std_logic_vector(7 downto 0);
  

  signal  data_o_dm : std_logic_vector(n-1 downto 0);  -- Data memory

  signal  data_bus : std_logic_vector(n-1 downto 0);  -- Data memory / peripherals bus
  signal  data_in : std_logic_vector(n-1 downto 0); -- Data memory / peripherals input
  signal  wbe       : std_logic_vector(3 downto 0);
  
  constant RISCV_INSTRUCTION_OFFSET    : std_logic_vector(31 downto 0) := x"00000000";
  constant RISCV_DATA_OFFSET           : std_logic_vector(31 downto 0) := x"00000000";

  -- Core control to/from Cache
  signal  stall_icache  : std_logic;
  signal  valid_iaddr   : std_logic;
  signal  valid_daddr   : std_logic;
  signal  sb_en         : std_logic;
  signal  sh_en         : std_logic;
  signal  we            : std_logic;
  signal  wait_d        : std_logic;
  signal  ce_inst        : std_logic;
  
  -- Peripherals
  
  signal  data_i_bdP : std_logic_vector(n-1 downto 0);  -- bidirectional port data in
  signal  data_o_bdP : std_logic_vector(n-1 downto 0);  -- bidirectional port data out
  

  signal itrBus		: std_logic_vector(n-1 downto 0); -- Configurable interrupt signal bus from BDPort to PIC

  signal irq_s    : std_logic_vector(7 downto 0); -- Used to concatenate internal interrupt signals with the itr bus

  signal  data_o_PIC    : std_logic_vector(7 downto 0);  -- PIC data out
  
  signal  ce_dm         : std_logic; -- Data memory enable
  signal  ce_bdP        : std_logic; -- Bidirectional port enable
  signal  ce_PIC        : std_logic; -- PIC enable
  
  signal  intr_p        : std_logic; -- PIC -> Core intr signal

  signal  tx_done : std_logic; -- TX -> PIC
  signal  tx_dv   : std_logic; -- Memory ctrl enable / we to tx
  
  
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
    intr          => intr_p,
    we            => we ,
    stall_icache  => stall_icache,
    valid_iaddr   => valid_iaddr,
    valid_daddr   => valid_daddr,
    wait_i        => wait_d,
    wait_d        => wait_d,
    sb_en         => sb_en ,
    sh_en         => sh_en ,
    addr_icache   => addr_inst ,
    data_icache   => core_idata ,
    addr_dcache   => core_daddr , 
    data_dcache   => core_ddata
  );

  --core_ddata <= data_o_bdP when (ce_bdP = '1' AND we = '0') else 
  --              (others => 'Z');

  MEMORY_CONTROL:	entity work.MemoryCtrl(behavioral)
	port map (
		clock	=> clk,
		rst		=> rst,
    
    -- Interface to core (instruction memory)
		core_iaddr => addr_inst,
		core_idata => core_idata,
		valid_iaddr => valid_iaddr,
		stall_icache => stall_icache,

    -- Interface to instruction memory
    ce_inst   => ce_inst,
		inst_addr => mem_iaddr,
		inst_data => mem_idata,

		-- Interface to core (data memory)
		core_daddr 	=> core_daddr,
		core_ddata	=> core_ddata,
		valid_daddr => valid_daddr,
		we			=> we,
		sb_en		=> sb_en,
		sh_en		=> sh_en,
    wait_d  => wait_d,

		-- Interface with data memory / peripherals
		addr_data	=> addr_data,
    addr_prph => addr_prph,
		data_in		=> data_bus,
		data_out	=> data_in, 
		wbe    		=> wbe,
		ce_dm			=> ce_dm,
    ce_bdP    => ce_bdP,
    ce_PIC    => ce_PIC,
    ce_TX     => tx_dv
	);
  
data_bus <=   data_o_bdP when ce_bdP = '1' else
              x"000000" & data_o_PIC when ce_PIC = '1' else
              data_o_dm;

------------------------------------------------------
-- Peripherals
--
  BD_PORT : entity work.BDPort(behavioral)
  generic map (
      DATA_WIDTH => n,
      PORT_DATA_ADDR   => "00000010",
      PORT_CONFIG_ADDR => "00000001",
      PORT_ENABLE_ADDR => "00000000",
      PORT_ITR_ADDR    => "00000011"
  )
  port map (
      clk => clk, 
      rst => rst,

      address => addr_prph,
      data_i  => data_i_bdP,
      data_o  => data_o_bdP,

      ce => ce_bdP,
      rw => we,

      itr_o => itrBus,

      port_io => port_io
  );

  data_i_bdP <= data_in when (ce_bdP = '1' AND we = '1') else
                (others => 'Z');

  PIC: entity work.InterruptController
	generic map (
		IRQ_ID_ADDR		=> "00000000",
		INT_ACK_ADDR	=> "00000001",
		MASK_ADDR		  => "00000010"
	)
	port map (  
		clk 	   => clk,
		rst 	   => rst,			
		data_in  => data_in(7 downto 0),
		data_out => data_o_PIC,
		address  => addr_prph,
		rw		   => we,
		ce		   => ce_PIC,
		intr 	   => intr_p,
		irq		   => irq_s
	);

  irq_s <= itrBus(31 downto 25) & tx_done;
  
    
  UART_TX: entity work.UART_TX_v1
  port map(
    i_Clk       => clk,
    i_TX_DV     => tx_dv,
    i_TX_Byte   => data_in(7 downto 0),
    o_TX_Active => tx_active,
    o_TX_Serial => tx,
    o_TX_Done   => tx_done
  );

------------------------------------------------------
-- Memories
--
  INSTRUCTION_MEMORY: entity work.Memory(behavioral)
	generic map (
		SIZE            => 4096,                                  -- Memory depth 
		ADDR_WIDTH		  => 32,
		COL_WIDTH		    => 8,
		NB_COL		    	=> 4,
		imageFileName   => "code.txt",
		OFFSET          => UNSIGNED(RISCV_INSTRUCTION_OFFSET)   -- initial address (mapped to memory address 0x00000000)
	)
	port map (
		clock     => clk,
		wbe				=> "0000", -- we ?
		ce        => ce_inst,
		address   => mem_iaddr,  
		data_i    => data_in_inst,
		data_o    => mem_idata
	);
	
DATA_MEMORY: entity work.Memory(behavioral)
	generic map (
		SIZE            => 4096,                         -- Memory depth 
		ADDR_WIDTH		  => 32,
		COL_WIDTH		    => 8,
		NB_COL			    => 4,
		imageFileName   => "data.txt",
		OFFSET          => UNSIGNED(RISCV_DATA_OFFSET)  -- initial address
	)
	port map (
		clock     => clk,
		wbe				=> wbe, -- we ?
		ce        => ce_dm,
		address   => addr_data, 
		data_i    => data_in,
		data_o    => data_o_dm
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
