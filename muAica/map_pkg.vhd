library ieee;
use ieee.std_logic_1164.all;

----------------------------------
-- Package with memory sections start, and end address

package map_pkg is

  --------- text and sdata sections, used with cache
  constant  TEXT_start  : std_logic_vector(31 downto 0) := x"0000_0000";  -- with boot section
  constant  TEXT_end    : std_logic_vector(31 downto 0) := x"0010_FFFF";
  constant  SDATA_start : std_logic_vector(31 downto 0) := x"0011_0000";
  constant  SDATA_end   : std_logic_vector(31 downto 0) := x"FFFE_FFFF";

  --------- io section
  constant  IO_start  : std_logic_vector(31 downto 0) := x"FFFF_0000";
  constant  IO_end    : std_logic_vector(31 downto 0) := x"FFFF_FFFF";

  -- 16lsb of io devices
  constant  LSB_UART_CTRL : std_logic_vector(15 downto 0) := x"0000";
  constant  LSB_UART_DATA : std_logic_vector(15 downto 0) := x"0001";
  constant  LSB_UART_BD   : std_logic_vector(15 downto 0) := x"0002";
  constant  LSB_TIMER0    : std_logic_vector(15 downto 0) := x"0004"; --4bytes alig

end package map_pkg;
