library IEEE;

use IEEE.STD_LOGIC_1164.all;

entity BDPort_tb is
end BDPort_tb;

architecture behavioral of BDPort_tb is
    signal clk, rst, ce_bdP, we : std_logic := '0';
    signal port_io  : std_logic_vector(31 downto 0); 
    
    signal  data_i_bdP : std_logic_vector(31 downto 0);
    signal  data_o_bdP : std_logic_vector(31 downto 0);
    signal  addr_prph : std_logic_vector(7 downto 0);

begin

    BD_PORT : entity work.BDPort(behavioral)
    generic map (
        DATA_WIDTH       => 32,
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
  
        port_io => port_io
    );
    
    rst <= '1', '0' after 10ns;
    clk <= (not clk) after 5ns;

    data_i_bdP <= x"00000001", x"0000000f" after 20 ns, x"00000004" after 40 ns;
    addr_prph <= x"01", x"00" after 20 ns, x"02" after 40 ns;
    ce_bdP <= '0', '1' after 10 ns, '0' after 90 ns;
    we <= '0', '1' after 10 ns, '0' after 70 ns;

    port_io(31 downto 1) <= (others => 'Z');--, '1' after 90 ns;
    port_io(0) <= 'Z', '1' after 50 ns, '0' after 80 ns, '1' after 100 ns;

    end architecture;
