library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.core_pkg.all;

entity MemoryCtrl is
  port(
    clock   	 : in std_logic;
	rst			 : in std_logic;
		
  -- Instruction memory, from core 
    core_iaddr 	 : in  std_logic_vector(n-1 downto 2);
    core_idata	 : out  std_logic_vector(n-1 downto 0);
	valid_iaddr  : in std_logic;
	stall_icache : in std_logic;

  -- To instruction memory 
	inst_addr	 : out std_logic_vector(n-1 downto 0);
	inst_data	 : in std_logic_vector(n-1 downto 0);
	
  -- Data memory, from core 
    core_daddr 	 : in  std_logic_vector(n-1 downto 0);
    core_ddata	 : inout  std_logic_vector(n-1 downto 0);
	valid_daddr  : in std_logic;
	we 			 : in std_logic;
    sb_en        : in std_logic;
    sh_en        : in std_logic;
	
  -- To data memory
	addr_data	 : out std_logic_vector(n-1 downto 0);
	mem_data_in		 : out  std_logic_vector(n-1 downto 0);
	mem_data_out	 : in std_logic_vector(n-1 downto 0);
    wbe    		 : out  std_logic_vector(3 downto 0);
    ce		     : out std_logic
  );
end entity MemoryCtrl;

architecture behavioral of MemoryCtrl is


signal  data_reg    : std_logic_vector(n-1 downto 0);
signal  data_sig    : std_logic_vector(n-1 downto 0);
signal  wbe_sig    	:  std_logic_vector(3 downto 0);
signal 	wbe_extended : std_logic_vector(n-1 downto 0);
signal  be_sig    	:  std_logic_vector(3 downto 0);

-- Instruction memory signals
signal  addr_imem	: std_logic_vector(n-1 downto 0);
signal  lastValidiAddr	: std_logic_vector(n-1 downto 0);

-- Data memory signals 

signal  byte_sel    	: std_logic_vector(1 downto 0);
signal	output_reg		: std_logic := '0';
signal  lastValiddAddr	: std_logic_vector(n-1 downto 0);
signal  data_in_sig		: std_logic_vector(n-1 downto 0);
signal  data_core_sig	: std_logic_vector(n-1 downto 0);
signal  data_reg_sig	: std_logic_vector(n-1 downto 0);
    
begin
    
	-- Instruction memory 
	addr_imem <= "00" & core_iaddr;
    inst_addr <= addr_imem when stall_icache = '0' else
				lastValidiAddr;
				
	core_idata <= inst_data;
	-- /Instruction memory
	
	-------------------------------------------------------------------------------------------------
	-- Data memory
	--
	
	-- Select bytes that are enabled for reading / writing
	byte_sel <= lastValiddAddr(1 downto 0);
	
	-- Convert byte addressed memory address to word addressed
	addr_data <= "00" & core_daddr(n-1 downto 2) when (valid_daddr = '1' AND we = '0') else 
				"00" & lastValiddAddr(n-1 downto 2);
	

	
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
	data_core_sig <= x"0000"  & mem_data_out(15 downto 0)	when be_sig = "0011" else 
					x"0000"   & mem_data_out(n-1 downto 16) when be_sig = "1100" else 
					x"000000" & mem_data_out(15 downto 8) 	when be_sig = "0010" else
					x"000000" & mem_data_out(23 downto 16) 	when be_sig = "0100" else
					x"000000" & mem_data_out(n-1 downto 24) when be_sig = "1000" else
					mem_data_out;		
	
	-- This signal is used when we have a read after write.
		-- Aica core expects data being loaded to be in the lsb.
	data_reg_sig <= x"0000"   & data_reg(15 downto 0)	when be_sig = "0011" else 
					x"0000"   & data_reg(n-1 downto 16) when be_sig = "1100" else 
					x"000000" & data_reg(15 downto 8) 	when be_sig = "0010" else
					x"000000" & data_reg(23 downto 16) 	when be_sig = "0100" else
					x"000000" & data_reg(n-1 downto 24) when be_sig = "1000" else
					data_reg;
		
	-- Out to core 
		-- data_reg_sig goes out when doing read after write 
	core_ddata <= data_core_sig when (we = '0' AND output_reg = '0') else 
					data_reg_sig  when output_reg = '1'
					else (others => 'Z');
	--
	------------------------------------------------------------------------------------------------
	
	------------------------------------------------------------------------------------------------
	-- Data coming in from core 
	--
		
	data_sig <= core_ddata when we = '1' else (others => 'Z');
	
	    -- Write enable
	wbe_sig <= "0000" when (we = '0' OR rst = '1') else
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
	data_in_sig <= 		  data_sig(15 downto 0) & x"0000"  	when wbe_sig = "1100" else 
				x"0000" & data_sig(7 downto 0)  & x"00" 	when wbe_sig = "0010" else 
				x"00"   & data_sig(7 downto 0)  & x"0000"   when wbe_sig = "0100" else 
				data_sig(7 downto 0) 		    & x"000000"	when wbe_sig = "1000" else 
				data_sig;	-- "1111", "0001", "0011"
				
	
	-- Out to mem 
	mem_data_in <= data_in_sig;
	wbe <= wbe_sig;
	
	--
	------------------------------------------------------------------------------------------------
	
	ce <= '1' when (valid_daddr = '1' OR we = '1') else 
			'0';
  
  process (clock)
    begin
        if rising_edge(clock) then
		
		-- Instruction memory
			if valid_iaddr = '1' AND stall_icache = '0' then 
				lastValidiAddr <= addr_imem;
			end if;
		
		-- Data memory 
            if valid_daddr = '1' then
				data_reg <= (data_in_sig AND wbe_extended) OR (mem_data_out AND (NOT wbe_extended));
				lastValiddAddr <= core_daddr;
                --data_reg <= data_sig;
            end if;
			
		 -- Collision detection, Read after Write
			if (wbe_sig /= "0000" AND valid_daddr = '1') then 
				output_reg <= '1';
			end if;
			
			if output_reg = '1' then
				output_reg <= '0';
			end if;
			
        end if;
    end process;

end architecture behavioral;