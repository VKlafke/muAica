library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.muAica_pkg.all;

entity aica_tb is
end entity aica_tb;

architecture behavior of aica_tb is

  -- processor top module component
  COMPONENT muAica is
    port (
      clk       : in    std_logic;
      rst_bt    : in    std_logic;
      intr      : in    std_logic
    );
  end COMPONENT muAica;

  -- System clock and reset
  signal  clk   : std_logic;
  signal  rst_bt: std_logic;

  constant half_period : time := 5 ns;

  signal  intr_sig: std_logic;

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
    intr    => intr_sig
  );


  intr_sig <= '0', '1' after 300 ns, '0' after 350 ns;

end architecture behavior;
