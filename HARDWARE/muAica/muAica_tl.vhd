library IEEE;
use IEEE.std_logic_1164.all;        

entity muAica_tl is
	port(
		clk : in std_logic;  -- On-board (LOC = V10)
		rst : in std_logic;	 -- Button (LOC = C9)
		
		port_io : inout std_logic_vector(31 downto 0);
		
		tx		: out std_logic;
		
		rx		: in std_logic;
        
        test    : out std_logic
	);
end muAica_tl;

architecture behavioral of muAica_tl is
    
      signal clk_d, intr : std_logic := '0';  
	  signal port_io_sig	: std_logic_vector(31 downto 0);
	  
	  signal tx_s	: std_logic;
	  signal tx_a   : std_logic;
	  signal rst_s : std_logic;
      signal test_sig : std_logic;

begin

	CLK_MNG: entity work.ClockManager
		port map (
			  clk_in		=> clk,
			  clk_div2	=> clk_d
		);

    
    PROCESSOR: entity work.muAica 
        port map (
            clk         => clk_d, 
            rst_bt      => rst, 
            port_io 	=> port_io_sig,
			tx		=> tx_s,
			rx		=> rx
        );  
		
	port_io <= port_io_sig;
	
	tx <= tx_s;
    
    test <= test_sig;
    
	--port_io(3 downto 0) <= switch_in(3 downto 0);
	--led_out <= port_io(31 downto 28);
    
end behavioral;