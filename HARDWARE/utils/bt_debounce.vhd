library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bt_debounce is
  port(
    clk     : in  std_logic;
    bt_in   : in  std_logic;
    bt_out  : out std_logic
  );
end entity bt_debounce;

architecture behavior of bt_debounce is

  -- counter
  -- (2^22) ~= 4.194 M, so we use the msb as a overflow flag, which says when
  -- the count is done, at ~2.097M. With ~2.097M * 10nano seconds, we got ~20.97ms
  signal  n_c   : integer := 22;
  signal  count : std_logic_vector(n_c-1 downto 0);

  -- temporary button ff
  signal  Q1    : std_logic;
  signal  Q2    : std_logic;
  signal  Q3    : std_logic := '0'; -- output have a known initial state

begin

  ----------------------------------------------------------------------
  ----------------------------------------------------------------------
  ----------------------------------------------------------------------
  -- IGNORED BY SYNTHESIS
  -- synthesis translate_off
  n_c <= 1;
  -- synthesis translate_on
  ----------------------------------------------------------------------
  ----------------------------------------------------------------------
  ----------------------------------------------------------------------

  bt_out <= Q3;

  -- Button FF 1
  process(clk)
  begin
    if (rising_edge(clk)) then
      Q1 <= bt_in;
    end if;
  end process;

  -- Button FF 2
  process(clk)
  begin
    if (rising_edge(clk)) then
      Q2 <= Q1;
    end if;
  end process;

  -- Counter process
  process(clk)
  begin
    if (rising_edge(clk)) then
      if (Q1 /= Q2) then
        count <= (others => '0');
      elsif (count(n_c-1) = '0') then
        count <= std_logic_vector(UNSIGNED(count) + "0000000000000000000001");
      end if;
    end if;
  end process;

  -- Button output process
  process(clk)
  begin
    if (rising_edge(clk)) then
      if (count(n_c-1) = '1') then
        Q3 <= Q2;
      end if;
    end if;
  end process;

end architecture behavior;
