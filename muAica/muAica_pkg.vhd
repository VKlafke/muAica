library ieee;
use ieee.std_logic_1164.all;

package muAica_pkg is

  constant n : integer := 32;
  constant n_ram      : integer := 16;
  constant n_ramaddr  : integer := 23;


---------------------------
-- COMPONENT
	-- RV32I Core
  COMPONENT core
  port(
    clk           : in     std_logic;
    rst           : in     std_logic;
    intr          : in     std_logic;
    we			      : out    std_logic;
    stall_icache  : out    std_logic;
    valid_iaddr   : out    std_logic;
    valid_daddr   : out    std_logic;
    wait_i        : in     std_logic;
    wait_d        : in     std_logic;
    sb_en         : out    std_logic;
    sh_en         : out    std_logic;
    addr_icache   : out    std_logic_vector(n-1 downto 2);
    data_icache   : in     std_logic_vector(n-1 downto 0);
    addr_dcache   : out    std_logic_vector(n-1 downto 0);
    data_dcache   : inout  std_logic_vector(n-1 downto 0)
  );
  end COMPONENT core;

end package muAica_pkg;
