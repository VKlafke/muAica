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
      port_io   : inout std_logic_vector (n-1 downto 0); -- configurable IO port
      tx        : out std_logic;
	    rx: in std_logic
    );
  end COMPONENT muAica;

  -- System clock and reset
  signal  clk   : std_logic;
  signal  rst_bt: std_logic;

  constant half_period : time := 5 ns;

  signal  intr_sig : std_logic;
  signal  port_io_sig  : std_logic_vector (n-1 downto 0); -- interface with microcontroller port

  signal tx_s : std_logic; -- tx signal
  signal rx_s : std_logic;

  signal tx_dv : std_logic;
  signal tx_active_s : std_logic;
  signal tx_done :std_logic;
  signal data_tx : std_logic_vector(7 downto 0);

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
      rst_bt <= '1'; wait for 50 ns;
      rst_bt <= '0'; wait for 20 sec;
      rst_bt <= '1'; wait for 100 ns;
      rst_bt <= '0'; wait for 10 sec;
    end loop;
  end process rst_button;

-- Port Map
  MICRO_AICA: muAica
  port map(
    clk     => clk,
    rst_bt  => rst_bt,
    port_io => port_io_sig,
    tx      => tx_s,
	  rx		=> rx_s
  );
  
 -- rx_s <= '0';

  -- Send data to rx
  TX_DATA_SEND: entity work.UART_TX_v1
  port map(
    i_Clk       => clk,
    i_TX_DV     => tx_dv,
    i_TX_Byte   => data_tx,
    o_TX_Active => tx_active_s,
    o_TX_Serial => rx_s,
    o_TX_Done   => tx_done
  );


  --:10180000130101FC232E810213040104232204FC92

  data_tx <= x"00", 
             x"AC" after 178785 ns,  -- x"AC" 
             x"73" after 222205 ns,
             x"00" after 265625 ns,
             x"01" after 309045 ns,
             x"13" after 352465 ns, -- 73000113
             x"00" after 395885 ns, 
             x"40" after 439305 ns, 
             x"00" after 482725 ns, 
             x"ef" after 526145 ns, -- 004000ef
             x"fc" after 569565 ns, 
             x"01" after 612985 ns, 
             x"01" after 656405 ns, 
             x"13" after 699825 ns, -- fc010113
             x"02" after 743245 ns, 
             x"81" after 786665 ns, 
             x"2e" after 830085 ns, 
             x"23" after 873505 ns, -- 02812e23
             x"04" after 916925 ns, 
             x"01" after 960345 ns, 
             x"04" after 1003765 ns, 
             x"13" after 1047185 ns, -- 04010413
             x"fc" after 1090605 ns, 
             x"04" after 1134025 ns, 
             x"22" after 1177445 ns, 
             x"23" after 1220865 ns, -- fc042223
             x"fc" after 1264285 ns, 
             x"04" after 1307705 ns, 
             x"24" after 1351125 ns, 
             x"23" after 1394545 ns, -- fc042423
             x"fc" after 1437965 ns, 
             x"04" after 1481385 ns, 
             x"26" after 1524805 ns, 
             x"23" after 1568225 ns, -- fc042623
             x"fc" after 1611645 ns, 
             x"04" after 1655065 ns, 
             x"28" after 1698485 ns, 
             x"23" after 1741905 ns, -- fc042823
             x"fc" after 1785325 ns, 
             x"04" after 1828745 ns, 
             x"2a" after 1872165 ns, 
             x"23" after 1915585 ns, -- fc042a23
             x"fc" after 1959005 ns, 
             x"04" after 2002425 ns, 
             x"2c" after 2045845 ns, 
             x"23" after 2089265 ns, -- fc042c23
             x"fc" after 2132685 ns, 
             x"04" after 2176105 ns, 
             x"2e" after 2219525 ns, 
             x"23" after 2262945 ns, -- fc042e23
             x"fe" after 2306365 ns, 
             x"04" after 2349785 ns, 
             x"20" after 2393205 ns, 
             x"23" after 2436625 ns, -- fe042023
             x"fe" after 2480045 ns, 
             x"04" after 2523465 ns, 
             x"22" after 2566885 ns, 
             x"23" after 2610305 ns, -- fe042223
             x"fe" after 2653725 ns, 
             x"04" after 2697145 ns, 
             x"24" after 2740565 ns, 
             x"23" after 2783985 ns, -- fe042423
             x"fe" after 2827405 ns, 
             x"04" after 2870825 ns, 
             x"26" after 2914245 ns, 
             x"23" after 2957665 ns, -- fe042623
             x"fe" after 3001085 ns, 
             x"04" after 3044505 ns, 
             x"28" after 3087925 ns, 
             x"23" after 3131345 ns, -- fe042823
             x"fe" after 3174765 ns, 
             x"04" after 3218185 ns, 
             x"2a" after 3261605 ns, 
             x"23" after 3305025 ns, -- fe042a23
             x"04" after 3348445 ns, 
             x"40" after 3391865 ns, 
             x"00" after 3435285 ns, 
             x"6f" after 3478705 ns, -- 0440006f
             x"ff" after 3522125 ns, 
             x"44" after 3565545 ns, 
             x"27" after 3608965 ns, 
             x"83" after 3652385 ns, -- ff442783
             x"00" after 3695805 ns, 
             x"17" after 3739225 ns, 
             x"87" after 3782645 ns, 
             x"13" after 3826065 ns, -- 00178713
             x"40" after 3869485 ns, 
             x"40" after 3912905 ns, 
             x"06" after 3956325 ns, 
             x"93" after 3999745 ns, -- 40400693
             x"ff" after 4043165 ns, 
             x"44" after 4086585 ns, 
             x"27" after 4130005 ns, 
             x"83" after 4173425 ns, -- ff442783
             x"00" after 4216845 ns, 
             x"27" after 4260265 ns, 
             x"97" after 4303685 ns, 
             x"93" after 4347105 ns, -- 00279793
             x"00" after 4390525 ns, 
             x"f6" after 4433945 ns, 
             x"87" after 4477365 ns, 
             x"b3" after 4520785 ns, -- 00f687b3
             x"00" after 4564205 ns, 
             x"e7" after 4607625 ns, 
             x"a0" after 4651045 ns, 
             x"23" after 4694465 ns, -- 00e7a023
             x"ff" after 4737885 ns, 
             x"44" after 4781305 ns, 
             x"27" after 4824725 ns, 
             x"83" after 4868145 ns, -- ff442783
             x"00" after 4911565 ns, 
             x"27" after 4954985 ns, 
             x"97" after 4998405 ns, 
             x"93" after 5041825 ns, -- 00279793
             x"ff" after 5085245 ns, 
             x"87" after 5128665 ns, 
             x"87" after 5172085 ns, 
             x"93" after 5215505 ns, -- ff878793 
             x"00" after 5258925 ns, 
             x"87" after 5302345 ns, 
             x"87" after 5345765 ns, 
             x"b3" after 5389185 ns, -- 008787b3
             x"ff" after 5432605 ns, 
             x"44" after 5476025 ns, 
             x"27" after 5519445 ns, 
             x"03" after 5562865 ns, -- ff442703
             x"fc" after 5606285 ns, 
             x"e7" after 5649705 ns, 
             x"a6" after 5693125 ns, 
             x"23" after 5736545 ns, -- fce7a623
             x"ff" after 5779965 ns, 
             x"44" after 5823385 ns, 
             x"27" after 5866805 ns, 
             x"83" after 5910225 ns, -- ff442783
             x"00" after 5953645 ns, 
             x"17" after 5997065 ns, 
             x"87" after 6040485 ns, 
             x"93" after 6083905 ns, -- 00178793 
             x"fe" after 6127325 ns, 
             x"f4" after 6170745 ns, 
             x"2a" after 6214165 ns, 
             x"23" after 6257585 ns, -- fef42a23
             x"ff" after 6301005 ns, 
             x"44" after 6344425 ns, 
             x"27" after 6387845 ns, 
             x"03" after 6431265 ns, --  ff442703
             x"00" after 6474685 ns, 
             x"b0" after 6518105 ns, 
             x"07" after 6561525 ns, 
             x"93" after 6604945 ns, -- 00b00793
             x"fa" after 6648365 ns, 
             x"e7" after 6691785 ns, 
             x"dc" after 6735205 ns, 
             x"e3" after 6778625 ns, -- fae7dce3
             x"00" after 6822045 ns, 
             x"00" after 6865465 ns, 
             x"07" after 6908885 ns, 
             x"93" after 6952305 ns, -- 00000793
             x"00" after 6995725 ns,
             x"07" after 7039145 ns, 
             x"85" after 7082565 ns, 
             x"13" after 7125985 ns, -- 00078513
             x"03" after 7169405 ns, 
             x"c1" after 7212825 ns, 
             x"24" after 7256245 ns,
             x"03" after 7299665 ns, -- 03c12403
             x"04" after 7343085 ns, 
             x"01" after 7386505 ns,
             x"01" after 7429925 ns, 
             x"13" after 7473345 ns, -- 04010113
             x"00" after 7516765 ns,
             x"00" after 7560185 ns,
             x"80" after 7603605 ns,
             x"67" after 7647025 ns, -- 00008067
             x"00" after 7690445 ns,   -- START OF .DATA
             x"00" after 7733865 ns,
             x"00" after 7777285 ns,
             x"04" after 7820705 ns, -- .data size 
             x"AB" after 7864125 ns,
             x"CD" after 7907545 ns,
             x"EF" after 7950965 ns,
             x"12" after 7994385 ns; -- 0xABCDEF12

  tx_dv <= '0', '1' after 45900 ns, '0' after 46000 ns,   -- 00
                '1' after 91940 ns, '0' after 92000 ns,   -- 00
                '1' after 135345 ns, '0' after 135400 ns, -- 00
                '1' after 178785 ns, '0' after 178800 ns, -- 08 , finish sending size
                '1' after 222205 ns, '0' after 222250 ns,
                '1' after 265625 ns, '0' after 265700 ns,
                '1' after 309045 ns, '0' after 309100 ns,
                '1' after 352465 ns, '0' after 352500 ns, -- 73000113
                '1' after 395885 ns, '0' after 395900 ns, 
                '1' after 439305 ns, '0' after 439400 ns, 
                '1' after 482725 ns, '0' after 482780 ns, 
                '1' after 526145 ns, '0' after 526200 ns, -- 004000ef 
                '1' after 569565 ns, '0' after 569600 ns, 
                '1' after 612985 ns, '0' after 613000 ns, 
                '1' after 656405 ns, '0' after 656500 ns, 
                '1' after 699825 ns, '0' after 699900 ns, --fc010113
                '1' after 743245 ns, '0' after 743300 ns, 
                '1' after 786665 ns, '0' after 786700 ns, 
                '1' after 830085 ns, '0' after 830150 ns, 
                '1' after 873505 ns, '0' after 873600 ns, -- 02812e23
                '1' after 916925 ns, '0' after 917000 ns, 
                '1' after 960345 ns, '0' after 960400 ns, 
                '1' after 1003765 ns, '0' after 1003800 ns, 
                '1' after 1047185 ns, '0' after 1047200 ns,  -- 04010413
                '1' after 1090605 ns, '0' after 1090700 ns, 
                '1' after 1134025 ns, '0' after 1134100 ns, 
                '1' after 1177445 ns, '0' after 1177500 ns, 
                '1' after 1220865 ns, '0' after 1228900 ns,  --fc042223
                '1' after 1264285 ns, '0' after 1264350 ns, 
                '1' after 1307705 ns, '0' after 1307800 ns, 
                '1' after 1351125 ns, '0' after 1351200 ns, 
                '1' after 1394545 ns, '0' after 1394600 ns,  --fc042423
                '1' after 1437965 ns, '0' after 1438000 ns, 
                '1' after 1481385 ns, '0' after 1481400 ns, 
                '1' after 1524805 ns, '0' after 1524900 ns, 
                '1' after 1568225 ns, '0' after 1568300 ns,  --fc042623
                '1' after 1611645 ns, '0' after 1611700 ns, 
                '1' after 1655065 ns, '0' after 1655130 ns, 
                '1' after 1698485 ns, '0' after 1698550 ns, 
                '1' after 1741905 ns, '0' after 1742000 ns,  --fc042823
                '1' after 1785325 ns, '0' after 1785400 ns, 
                '1' after 1828745 ns, '0' after 1828800 ns, 
                '1' after 1872165 ns, '0' after 1872200 ns, 
                '1' after 1915585 ns, '0' after 1915650 ns,  --fc042a23
                '1' after 1959005 ns, '0' after 1959100 ns, 
                '1' after 2002425 ns, '0' after 2002500 ns, 
                '1' after 2045845 ns, '0' after 2045910 ns, 
                '1' after 2089265 ns, '0' after 2089310 ns,  --fc042c23
                '1' after 2132685 ns, '0' after 2132750 ns, 
                '1' after 2176105 ns, '0' after 2176200 ns, 
                '1' after 2219525 ns, '0' after 2219600 ns, 
                '1' after 2262945 ns, '0' after 2263050 ns,  --fc042e23
                '1' after 2306365 ns, '0' after 2306400 ns, 
                '1' after 2349785 ns, '0' after 2349850 ns, 
                '1' after 2393205 ns, '0' after 2393300 ns, 
                '1' after 2436625 ns, '0' after 2436700 ns,  --fe042023
                '1' after 2480045 ns, '0' after 2480120 ns, 
                '1' after 2523465 ns, '0' after 2523500 ns, 
                '1' after 2566885 ns, '0' after 2566920 ns, 
                '1' after 2610305 ns, '0' after 2610400 ns,  --fe042223
                '1' after 2653725 ns, '0' after 2653800 ns, 
                '1' after 2697145 ns, '0' after 2697200 ns, 
                '1' after 2740565 ns, '0' after 2740600 ns, 
                '1' after 2783985 ns, '0' after 2784050 ns,  --fe042423
                '1' after 2827405 ns, '0' after 2827500 ns, 
                '1' after 2870825 ns, '0' after 2870900 ns, 
                '1' after 2914245 ns, '0' after 2914300 ns, 
                '1' after 2957665 ns, '0' after 2957700 ns,  --fe042623
                '1' after 3001085 ns, '0' after 3001150 ns, 
                '1' after 3044505 ns, '0' after 3044600 ns, 
                '1' after 3087925 ns, '0' after 3088050 ns, 
                '1' after 3131345 ns, '0' after 3131420 ns,  --fe042823
                '1' after 3174765 ns, '0' after 3174800 ns, 
                '1' after 3218185 ns, '0' after 3218220 ns, 
                '1' after 3261605 ns, '0' after 3261700 ns, 
                '1' after 3305025 ns, '0' after 3305120 ns,  --fe042a23
                '1' after 3348445 ns, '0' after 3348520 ns, 
                '1' after 3391865 ns, '0' after 3391920 ns, 
                '1' after 3435285 ns, '0' after 3435330 ns, 
                '1' after 3478705 ns, '0' after 3478800 ns,  -- 0440006f
                '1' after 3522125 ns, '0' after 3522200 ns, 
                '1' after 3565545 ns, '0' after 3565600 ns, 
                '1' after 3608965 ns, '0' after 3609120 ns, 
                '1' after 3652385 ns, '0' after 3652420 ns,  --ff442783
                '1' after 3695805 ns, '0' after 3695900 ns, 
                '1' after 3739225 ns, '0' after 3739320 ns, 
                '1' after 3782645 ns, '0' after 3782720 ns, 
                '1' after 3826065 ns, '0' after 3826120 ns,  -- 00178713
                '1' after 3869485 ns, '0' after 3869550 ns, 
                '1' after 3912905 ns, '0' after 3913000 ns, 
                '1' after 3956325 ns, '0' after 3956400 ns, 
                '1' after 3999745 ns, '0' after 3999800 ns,  -- 40000693
                '1' after 4043165 ns, '0' after 4043220 ns, 
                '1' after 4086585 ns, '0' after 4086650 ns, 
                '1' after 4130005 ns, '0' after 4130100 ns, 
                '1' after 4173425 ns, '0' after 4173500 ns,  --ff442783
                '1' after 4216845 ns, '0' after 4216900 ns, 
                '1' after 4260265 ns, '0' after 4260320 ns, 
                '1' after 4303685 ns, '0' after 4303750 ns, 
                '1' after 4347105 ns, '0' after 4347200 ns,  -- 00279793
                '1' after 4390525 ns, '0' after 4390620 ns, 
                '1' after 4433945 ns, '0' after 4434050 ns, 
                '1' after 4477365 ns, '0' after 4477400 ns, 
                '1' after 4520785 ns, '0' after 4520820 ns,  -- 00f687b3
                '1' after 4564205 ns, '0' after 4564300 ns, 
                '1' after 4607625 ns, '0' after 4607700 ns, 
                '1' after 4651045 ns, '0' after 4651120 ns, 
                '1' after 4694465 ns, '0' after 4694520 ns,  -- 00e7a023
                '1' after 4737885 ns, '0' after 4737950 ns, 
                '1' after 4781305 ns, '0' after 4781400 ns, 
                '1' after 4824725 ns, '0' after 4824800 ns, 
                '1' after 4868145 ns, '0' after 4868220 ns,  --ff442783
                '1' after 4911565 ns, '0' after 4911620 ns, 
                '1' after 4954985 ns, '0' after 4955020 ns, 
                '1' after 4998405 ns, '0' after 4998500 ns, 
                '1' after 5041825 ns, '0' after 5041900 ns,  -- 00279793
                '1' after 5085245 ns, '0' after 5085300 ns, 
                '1' after 5128665 ns, '0' after 5128720 ns, 
                '1' after 5172085 ns, '0' after 5172160 ns, 
                '1' after 5215505 ns, '0' after 5215600 ns,  --ff878793
                '1' after 5258925 ns, '0' after 5259050 ns, 
                '1' after 5302345 ns, '0' after 5302420 ns, 
                '1' after 5345765 ns, '0' after 5345820 ns, 
                '1' after 5389185 ns, '0' after 5389250 ns,  -- 008787b3
                '1' after 5432605 ns, '0' after 5432700 ns, 
                '1' after 5476025 ns, '0' after 5476100 ns, 
                '1' after 5519445 ns, '0' after 5519500 ns, 
                '1' after 5562865 ns, '0' after 5562920 ns,  --ff442703
                '1' after 5606285 ns, '0' after 5606320 ns, 
                '1' after 5649705 ns, '0' after 5649800 ns, 
                '1' after 5693125 ns, '0' after 5693200 ns, 
                '1' after 5736545 ns, '0' after 5736600 ns,  --fce7a623
                '1' after 5779965 ns, '0' after 5780050 ns, 
                '1' after 5823385 ns, '0' after 5823420 ns, 
                '1' after 5866805 ns, '0' after 5866900 ns, 
                '1' after 5910225 ns, '0' after 5910300 ns,  --ff442783
                '1' after 5953645 ns, '0' after 5953700 ns, 
                '1' after 5997065 ns, '0' after 5997120 ns, 
                '1' after 6040485 ns, '0' after 6040530 ns, 
                '1' after 6083905 ns, '0' after 6084000 ns,  -- 00178793
                '1' after 6127325 ns, '0' after 6127400 ns, 
                '1' after 6170745 ns, '0' after 6170820 ns, 
                '1' after 6214165 ns, '0' after 6214230 ns, 
                '1' after 6257585 ns, '0' after 6257630 ns,  --fef42a23
                '1' after 6301005 ns, '0' after 6301100 ns, 
                '1' after 6344425 ns, '0' after 6344500 ns, 
                '1' after 6387845 ns, '0' after 6387920 ns, 
                '1' after 6431265 ns, '0' after 6431320 ns,  --ff442703
                '1' after 6474685 ns, '0' after 6474750 ns, 
                '1' after 6518105 ns, '0' after 6518200 ns, 
                '1' after 6561525 ns, '0' after 6561600 ns, 
                '1' after 6604945 ns, '0' after 6605050 ns,  -- 00b00793
                '1' after 6648365 ns, '0' after 6648420 ns, 
                '1' after 6691785 ns, '0' after 6691850 ns, 
                '1' after 6735205 ns, '0' after 6735300 ns, 
                '1' after 6778625 ns, '0' after 6778700 ns,  --fae7dce3
                '1' after 6822045 ns, '0' after 6822120 ns, 
                '1' after 6865465 ns, '0' after 6865520 ns, 
                '1' after 6908885 ns, '0' after 6908985 ns, 
                '1' after 6952305 ns, '0' after 6952400 ns,  -- 00000793
                '1' after 6995725 ns, '0' after 6995800 ns, 
                '1' after 7039145 ns, '0' after 7039220 ns, 
                '1' after 7082565 ns, '0' after 7082630 ns, 
                '1' after 7125985 ns, '0' after 7126050 ns,  -- 00078513
                '1' after 7169405 ns, '0' after 7169500 ns, 
                '1' after 7212825 ns, '0' after 7212900 ns, 
                '1' after 7256245 ns, '0' after 7256300 ns, 
                '1' after 7299665 ns, '0' after 7299720 ns,  -- 03c12403
                '1' after 7343085 ns, '0' after 7343160 ns, 
                '1' after 7386505 ns, '0' after 7386600 ns, 
                '1' after 7429925 ns, '0' after 7430050 ns, 
                '1' after 7473345 ns, '0' after 7473420 ns,  -- 04010113
                '1' after 7516765 ns, '0' after 7516820 ns, 
                '1' after 7560185 ns, '0' after 7560240 ns, 
                '1' after 7603605 ns, '0' after 7603700 ns, 
                '1' after 7647025 ns, '0' after 7647100 ns,  -- 00008067
                '1' after 7690445 ns, '0' after 7694500 ns,   -- START OF .DATA
                '1' after 7733865 ns, '0' after 7733900 ns,
                '1' after 7777285 ns, '0' after 7777330 ns,
                '1' after 7820705 ns, '0' after 7820800 ns, -- .data size 
                '1' after 7864125 ns, '0' after 7864200 ns,
                '1' after 7907545 ns, '0' after 7907600 ns,
                '1' after 7950965 ns, '0' after 7951020 ns,
                '1' after 7994385 ns, '0' after 7994430 ns; -- 0xABCDEF12

 -- intr_sig <= '0', '1' after 1000 ns, '0' after 1050 ns;
 -- port_io_sig(30 downto 27) <= "0000", "1000" after 8000 ns;
  --port_io_sig(3 downto 0) <= "1111";
  port_io_sig(30 downto 0) <= (others => 'Z');
  port_io_sig(31) <= '0'; --, '1' after 15000 ns, '0' after 16000 ns;

end architecture behavior;
