library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.core_pkg.all;
use work.map_pkg.all;

entity MemoryCtrl is
  port(
    clock   	 : in std_logic;
	rst			 : in std_logic;
		
  -- Instruction memory, from core 
    core_iaddr 	 : in  std_logic_vector(n-1 downto 2);
    core_idata	 : out  std_logic_vector(n-1 downto 0);
	valid_iaddr  : in std_logic;
	stall_icache : in std_logic;
	wait_i		 : out std_logic;

  -- To instruction memory 
	inst_addr	  : out std_logic_vector(n-1 downto 0);
	inst_data	  : in std_logic_vector(n-1 downto 0);
	inst_data_out : out std_logic_vector(n-1 downto 0);
	inst_wbe	  : out std_logic_vector(3 downto 0);
	ce_inst		  : out std_logic;
	
  -- Data memory, from core 
    core_daddr 	 : in  std_logic_vector(n-1 downto 0);
    core_ddata	 : inout  std_logic_vector(n-1 downto 0);
	valid_daddr  : in std_logic;
	we 			 : in std_logic;
    sb_en        : in std_logic;
    sh_en        : in std_logic;
    wait_d       : out std_logic;
	
  -- Interface with Data Memory / Peripherals
	addr_data	 : out std_logic_vector(n-1 downto 0);
	addr_prph	 : out std_logic_vector(7 downto 0);
    wbe    		 : out  std_logic_vector(3 downto 0);
	data_out 	 : out  std_logic_vector(n-1 downto 0);
	data_in 	 : in std_logic_vector(n-1 downto 0);
    ce_dm	     : out std_logic;
	ce_bdP	     : out std_logic;
	ce_PIC		 : out std_logic;
	wr_TX		 : out std_logic;
	rd_TX		 : out std_logic;
	ce_RX		 : out std_logic;
	rd_RX_dv	 : out std_logic;
	ce_Timer	 : out std_logic;
	ce_Watchdog  : out std_logic
  );
end entity MemoryCtrl;

architecture behavioral of MemoryCtrl is

	type State is (st_Idle, st_Mem_Exec, st_Prph_Exec, st_RaW, st_Mem_Wait, st_Mem_Instr_Access);

	signal currentState : State;

	signal addr_data_reg 		: std_logic_vector(n-1 downto 0);
	signal  data_reg    : std_logic_vector(n-1 downto 0);

	----------------------------------------------------

	signal  data_sig    : std_logic_vector(n-1 downto 0);
	signal  wbe_sig    	:  std_logic_vector(3 downto 0);
	signal 	wbe_extended : std_logic_vector(n-1 downto 0);
	signal  be_sig    	:  std_logic_vector(3 downto 0);

	-- Instruction memory signals
	signal  addr_imem		: std_logic_vector(n-1 downto 0);
	signal  lastValidiAddr	: std_logic_vector(n-1 downto 0);
	signal  addr_instr_wr	: std_logic_vector(n-1 downto 0);
	signal  inst_data_reg   : std_logic_vector(n-1 downto 0);
	signal 	out_inst_data_reg : std_logic;

	-- Data memory signals 

	signal  byte_sel    	: std_logic_vector(1 downto 0);
	signal	output_reg		: std_logic := '0';
	signal  data_out_sig	: std_logic_vector(n-1 downto 0);
	signal  data_core_sig	: std_logic_vector(n-1 downto 0);
	signal  last_wr_sig		: std_logic_vector(n-1 downto 0);
	signal  last_wr_addr	: std_logic_vector(n-1 downto 0);
	signal  last_wr_data	: std_logic_vector(n-1 downto 0);

	-- Peripherals signals
	signal  addr_p		    : std_logic_vector(7 downto 0);
	signal	prph_en			: std_logic;

	signal instr_mem_access	: std_logic;

	signal wait_sig			: std_logic;
    
begin
    
	-- Instruction memory 
	addr_imem <= "00" & core_iaddr;
    inst_addr <= addr_instr_wr when instr_mem_access = '1' OR currentState = st_Mem_Instr_Access else 
				 addr_imem when stall_icache = '0' else
				 lastValidiAddr;
				
	core_idata <= inst_data when out_inst_data_reg = '0' else 
				 inst_data_reg;

	-- Output to instruction memory
	inst_data_out <= core_ddata when (currentState = st_Mem_Instr_Access and we = '1') else 
					 x"00000000";

	-- Instruction memory write enable
	inst_wbe <= "1111" when (currentState = st_Mem_Instr_Access and we = '1') else 
				"0000";

	-- This signal is enabled when we have a "Instruction memory access" address coming through
	instr_mem_access <= '1' when (core_daddr(31) = '1' AND  core_daddr(28) = '1' AND valid_daddr = '1') else
					'0';
					
	-- Stop processor from fetching new instructions while we write/read  instruction memory
	wait_i <=  '1' when instr_mem_access = '1' OR currentState = st_Mem_Instr_Access else 
				'0';

	-- Address that is used to write to the instruction memory
	addr_instr_wr <= "000000" & core_daddr(27 downto 2) when instr_mem_access = '1' else 
					 "000000" & addr_data_reg(27 downto 2) when currentState = st_Mem_Instr_Access else 
					x"00000000";

	-- /Instruction memory
	
	-------------------------------------------------------------------------------------------------
	-- Data memory
	--

	ce_dm <= '1' when (((currentState = st_Idle AND valid_daddr = '1' AND core_daddr(31) = '0') OR currentState = st_Mem_Exec) AND prph_en = '0') OR (currentState = st_RaW AND valid_daddr = '1') 
						OR (currentState = st_Prph_Exec AND valid_daddr = '1' AND core_daddr(31) = '0')  OR (currentState = st_Mem_Instr_Access AND valid_daddr = '1' and core_daddr(31) = '0') OR currentState = st_Mem_Wait else
			 '0';	
	
	-- Byte enable, used for r/w to assemble incoming / outgoing words correctly
	-- 'byte_sel' based on the 2lsb of 'lastValiddAddr'
	be_sig <= "0000" when (rst = '1') else
           "1111" when (sb_en = '0' AND sh_en = '0')                        else -- SW
           "0001" when (sb_en = '1' AND sh_en = '0' AND byte_sel = "00")    else -- SB
           "0010" when (sb_en = '1' AND sh_en = '0' AND byte_sel = "01")    else -- SB
           "0100" when (sb_en = '1' AND sh_en = '0' AND byte_sel = "10")    else -- SB
           "1000" when (sb_en = '1' AND sh_en = '0' AND byte_sel = "11")    else -- SB
           "0011" when (sb_en = '0' AND sh_en = '1' AND byte_sel(1) = '0')  else -- SH
           "1100" when (sb_en = '0' AND sh_en = '1' AND byte_sel(1) = '1')  else -- SH
           "0000";
		  		
	------------------------------------------------------------------------------------------------
	-- Data going out to core 
	--
	
	-- Aica core expects data being loaded to be in the lsb.
	data_core_sig <= x"0000"   & data_in(15 downto 0)	when be_sig = "0011" else 
					 x"0000"   & data_in(n-1 downto 16) when be_sig = "1100" else 
					 x"000000" & data_in(15 downto 8) 	when be_sig = "0010" else
					 x"000000" & data_in(23 downto 16) 	when be_sig = "0100" else
					 x"000000" & data_in(n-1 downto 24) when be_sig = "1000" else
					 data_in;		
	
	-- This signal is used when we have a read after write.
		-- Aica core expects data being loaded to be in the lsb.
	last_wr_sig <= x"0000"   & last_wr_data(15 downto 0)	when be_sig = "0011" else 
					x"0000"   & last_wr_data(n-1 downto 16) when be_sig = "1100" else 
					x"000000" & last_wr_data(15 downto 8) 	when be_sig = "0010" else
					x"000000" & last_wr_data(23 downto 16) 	when be_sig = "0100" else
					x"000000" & last_wr_data(n-1 downto 24) when be_sig = "1000" else
					last_wr_data;
		
	-- Out to core 
		-- data_reg_sig goes out when doing read after write
	core_ddata <= data_core_sig when (((currentState = st_Mem_Exec AND addr_data_reg(n-1 downto 0) /= last_wr_addr(n-1 downto 0)) OR currentState = st_Prph_Exec) AND we = '0') else 
					last_wr_sig when currentState = st_RaW OR (currentState = st_Mem_Exec AND addr_data_reg(n-1 downto 0) = last_wr_addr(n-1 downto 0) AND we = '0')		    else
					inst_data when (currentState = st_Mem_Instr_Access and we = '0') else  
				  (others => 'Z');
	------------------------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------------------------
	-- Data coming in from core 
	--
		
	data_sig <= core_ddata when (currentState = st_Mem_Exec OR currentState = st_Prph_Exec OR currentState = st_Mem_Wait) AND we = '1' else (others => '0');
	
	    -- Write enable to data memory
	wbe_sig <= "0000" when (we = '0' OR rst = '1' OR currentState = st_Mem_Instr_Access) else
           be_sig;
		   
		   
	wbe_extended <= wbe_sig(3) & wbe_sig(3) & wbe_sig(3) & wbe_sig(3) & 
					wbe_sig(3) & wbe_sig(3) & wbe_sig(3) & wbe_sig(3) & 
					wbe_sig(2) & wbe_sig(2) & wbe_sig(2) & wbe_sig(2) & 
					wbe_sig(2) & wbe_sig(2) & wbe_sig(2) & wbe_sig(2) & 
					wbe_sig(1) & wbe_sig(1) & wbe_sig(1) & wbe_sig(1) & 
					wbe_sig(1) & wbe_sig(1) & wbe_sig(1) & wbe_sig(1) & 
					wbe_sig(0) & wbe_sig(0) & wbe_sig(0) & wbe_sig(0) &
					wbe_sig(0) & wbe_sig(0) & wbe_sig(0) & wbe_sig(0);
		   
	
	
	-- Memory writes data expecting that values are in the positions enabled by wbe
	-- but the aica core always places the data in the lsb of the signal.
	data_out_sig <= 		  data_sig(15 downto 0) & x"0000"  	when wbe_sig = "1100" else 
				x"0000" & data_sig(7 downto 0)  & x"00" 	when wbe_sig = "0010" else 
				x"00"   & data_sig(7 downto 0)  & x"0000"   when wbe_sig = "0100" else 
				data_sig(7 downto 0) 		    & x"000000"	when wbe_sig = "1000" else 
				data_sig;	-- "1111", "0001", "0011"
				
	
	-- Out to mem 
	data_out <= data_out_sig; --when ((currentState = st_Mem_Exec OR currentState = st_Prph_Exec OR currentState = st_Mem_Wait) AND we = '1') else 
				--(others => '0');

	wbe <= wbe_sig when currentState /= st_Mem_Wait else 
			"0000";
	
	--
	------------------------------------------------------------------------------------------------
	


	prph_en <= (core_daddr(31) AND  not core_daddr(28)) when (currentState = st_Idle AND valid_daddr = '1') else 
				(addr_data_reg(31) AND not addr_data_reg(28)); --when currentState /= st_Idle; -- MSB of addr controls access to peripherals. 0: memory, 1: peripherals

	-- Used to address the peripheral being accessed
	addr_p <= --core_daddr(19 downto 12) when ((valid_daddr = '1' AND we = '0') AND prph_en = '1') else 
			  addr_data_reg(19 downto 12) when prph_en = '1' else
			  (others => '0');

	addr_prph <= addr_data_reg(11 downto 4) when currentState = st_Prph_Exec else
		         core_daddr(11 downto 4); --when currentState = st_Idle AND valid_daddr = '1';

	-- Data Memory enable
	--ce_dm <= '1' when currentState = st_Load else 
	--		 '0';
	
	-- Bidirectional Port enable
	ce_bdP <= '1' when (currentState = st_Prph_Exec AND addr_p = BDPort_Addr) 	else 
			  '0';

	-- PIC enable
	ce_PIC <= '1' when (currentState = st_Prph_Exec AND addr_p = PIC_Addr) else 
			  '0';

	-- TX enable write
	wr_TX <= '1' when (currentState = st_Prph_Exec AND addr_p = TX_Addr AND we = '1') else 
			 '0';

	-- TX enable read
	rd_TX <= '1' when (currentState = st_Prph_Exec AND addr_p = TX_Addr AND we = '0') else 
			 '0';

	-- RX enable
	ce_RX <= '1' when (currentState = st_Prph_Exec AND addr_p = RX_Addr) else 
		     '0';

	-- read RX dv signal
	rd_RX_dv <= '1' when (currentState = st_Prph_Exec AND addr_p = RX_DV_Addr) else 
			 '0';
					
	-- Timer enable
	ce_Timer <= '1' when (currentState = st_Prph_Exec AND addr_p = Timer_Addr AND we = '1') else 
	'0';	

	-- Watchdog enable
	ce_Watchdog <= '1' when (currentState = st_Prph_Exec AND addr_p = Watchdog_Addr AND we = '1') else 
	'0';
	

	--wait_d <= '0';
	ce_inst <= '1' when currentState /= st_Mem_Wait else 
				'0';

	addr_data <= "00" & core_daddr(n-1 downto 2) when ((currentState = st_Idle OR 
														currentState = st_RaW OR 
														(currentState = st_Prph_Exec  AND core_daddr(31) = '0') OR 
														(currentState = st_Mem_Exec AND core_daddr(31) = '0' AND we = '0') OR 
														(currentState = st_Mem_Instr_Access AND core_daddr(31) = '0')) 
														AND valid_daddr = '1') else 
				 "00" & addr_data_reg(n-1 downto 2) when (currentState = st_Mem_Exec OR currentState = st_Mem_Wait) else 
				 (others => '0'); 

	wait_d <= '1' when wait_sig = '1' else 
				'0';

	StateReg: process (clock, rst)
	begin
		if rst = '1' then 
			currentState <= st_Idle;
			out_inst_data_reg <= '0';
		elsif rising_edge(clock) then 

			-- instruction addr reg
			if valid_iaddr = '1' AND stall_icache = '0'  then 
				lastValidiAddr <= addr_imem;
			end if;

			-- instruction data reg
			if instr_mem_access = '1' then 
				inst_data_reg  <= inst_data;
			end if;

			-- Instruction data reg output control

			if out_inst_data_reg = '1' then 
				out_inst_data_reg <= '0';
			end if;

			if valid_daddr = '1' AND currentState /= st_Mem_Wait then 
				addr_data_reg <= core_daddr;
				-- Select bytes that are enabled for reading / writing
				byte_sel <= core_daddr(1 downto 0);
			end if;


			wait_sig <= '0';

			CASE currentState is 
				-- Idle / reset state
				WHEN st_Idle => 
				
					if valid_daddr = '1' AND core_daddr(31) = '0' then 					
						currentState <= st_Mem_Exec;		
					elsif valid_daddr = '1' AND core_daddr(31) = '1' AND core_daddr(28) = '0' then -- Peripherals enable
						currentState <= st_Prph_Exec;
					elsif valid_daddr = '1' AND core_daddr(31) = '1' AND core_daddr(28) = '1' then -- Write to instruction memory
						currentState <= st_Mem_Instr_Access;
						wait_sig <= '0';
					else
						currentState <= st_Idle;
					end if;
				
				-- Executing a data memory read / write
				WHEN st_Mem_Exec =>


					if valid_daddr = '1' AND core_daddr(31) = '1' then 
						currentState <= st_Prph_Exec;
					elsif valid_daddr = '1' AND we = '1' AND addr_data_reg(n-1 downto 0) /= core_daddr(n-1 downto 0) then
						currentState <= st_Mem_Wait;
						wait_sig <= '1';
					elsif valid_daddr = '1' AND we = '1' AND addr_data_reg(n-1 downto 2) = core_daddr(n-1 downto 2) then
						currentState <= st_RaW;
					elsif valid_daddr = '1' AND we = '1' AND addr_data_reg(n-1 downto 2) /= core_daddr(n-1 downto 2) then
						currentState <= st_Mem_Wait;
						wait_sig <= '1';
					elsif valid_daddr = '1' then 
						currentState <= st_Mem_Exec;
					else
						currentState <= st_Idle;
					end if;
				
					if we = '1' then 
						last_wr_addr <= addr_data_reg(n-1 downto 0);
						last_wr_data <=  (data_out_sig AND wbe_extended) OR (data_in AND not wbe_extended);
						data_reg <= (data_out_sig AND wbe_extended) OR (data_in AND not wbe_extended);
					end if;

				-- Executing a peripheral read / write
				WHEN st_Prph_Exec =>

					if valid_daddr = '1' AND we = '1' AND addr_data_reg(n-1 downto 2) = core_daddr(n-1 downto 2) then
						currentState <= st_RaW;
						--byte_sel <= core_daddr(1 downto 0);
					elsif valid_daddr = '1' AND core_daddr(31) = '1' then 
						currentState <= st_Prph_Exec;
					elsif valid_daddr = '1' AND core_daddr(31) = '0' then
						currentState <= st_Mem_Exec;
					else
						currentState <= st_Idle;
					end if;

					if we = '1' then 
						data_reg <= (data_out_sig AND wbe_extended) OR (data_in AND not wbe_extended);
					end if;

				WHEN st_RaW =>		
				
					if valid_daddr = '1'  AND core_daddr(31) = '0' then
						currentState <= st_Mem_Exec;
					elsif valid_daddr = '1' AND core_daddr(31) = '1' then 
						currentState <= st_Prph_Exec;
					else
						currentState <= st_Idle;
					end if;

				WHEN st_Mem_Wait =>
						
					currentState <= st_Mem_Exec;
					wait_sig <= '0';

				WHEN st_Mem_Instr_Access =>

					if valid_daddr = '1' AND core_daddr(31) = '0' then 					
						currentState <= st_Mem_Exec;		
					else 
						currentState <= st_Idle;
					end if;

						wait_sig <= '0';
						out_inst_data_reg <= '1';
					

			end CASE;

		end if;
	end process;

end architecture behavioral;