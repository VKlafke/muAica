library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.muAica_pkg.all;

entity muAica_tb is
end entity muAica_tb;

architecture behavior of muAica_tb is

  -- processor top module component
  COMPONENT muAica is
    port (
      clk       : in    std_logic;
      rst_bt    : in    std_logic;
      port_io : inout std_logic_vector (n-1 downto 0) -- configurable IO port
    );
  end COMPONENT muAica;

  -- System clock and reset
  signal  clk   : std_logic;
  signal  rst_bt: std_logic;

  constant half_period : time := 5 ns;

  signal  intr_sig : std_logic;
  signal  port_io_sig  : std_logic_vector (n-1 downto 0); -- interface with microcontroller port

begin

  -- Clock process: 100 MHz
  signal_clk : process
  begin
    clk <= '0'; wait for half_period;
    loop
      clk <= '1'; wait for half_period;
      clk <= '0'; wait for half_period;
    end loop;
  end process signal_clk;

  -- Clock
  rst_button : process -- debounce should be disabled inside 'aica/bt_debounce' (stability time ~0)
  begin
    rst_bt <= '0'; wait for 100 ns;
    loop
      rst_bt <= '1'; wait for 100 ns;
      rst_bt <= '0'; wait for 10 sec;
      rst_bt <= '1'; wait for 100 ns;
      rst_bt <= '0'; wait for 2 sec;
    end loop;
  end process rst_button;

-- Port Map
  MICRO_AICA: muAica
  port map(
    clk     => clk,
    rst_bt  => rst_bt,
    port_io => port_io_sig
  );


 -- intr_sig <= '0', '1' after 1000 ns, '0' after 1050 ns;
  port_io_sig(31 downto 28) <= "0000", "1000" after 900 ns, "0000" after 1200 ns;
  port_io_sig(27 downto 0) <= (others => 'Z');
-- port_io_sig(3 downto 0) <= x"1";

end architecture behavior;
