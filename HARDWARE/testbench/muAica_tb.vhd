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

  constant half_period : time := 10 ns; -- 50 MHZ

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
             x"00" after 87950 ns,
             x"00" after 174810 ns,
             x"94" after 261670 ns,  -- 00000094 
             x"13" after 348530 ns,
             x"01" after 435390 ns,
             x"40" after 522250 ns,
             x"73" after 609110 ns,  -- 73400113
             x"13" after 695970 ns, 
             x"01" after 782830 ns, 
             x"C1" after 869690 ns, 
             x"FF" after 956550 ns,  -- FFC10113
             x"23" after 1043410 ns,
             x"20" after 1130270 ns,
             x"11" after 1217130 ns,
             x"00" after 1309990 ns, -- 00112023
             x"37" after 1396810 ns,
             x"1F" after 1483810 ns,
             x"00" after 1570810 ns,
             x"00" after 1657810 ns, -- 00001F37
             x"13" after 1744810 ns,
             x"0F" after 1831810 ns,
             x"0F" after 1918810 ns,
             x"80" after 2005810 ns, -- 800F0F13
             x"73" after 2092810 ns,
             x"20" after 2179810 ns,
             x"4F" after 2266810 ns,
             x"30" after 2353810 ns, -- 304F2073
             x"73" after 2440810 ns,
             x"60" after 2527810 ns,
             x"44" after 2614810 ns,
             x"30" after 2701810 ns, -- 30446073
             x"73" after 2788810 ns, 
             x"60" after 2875810 ns,   
             x"04" after 2962810 ns,
             x"30" after 3049810 ns, -- 30046073
             x"73" after 3136810 ns,
             x"10" after 3223810 ns,
             x"10" after 3310810 ns,
             x"34" after 3397810 ns, -- 34101073
             x"73" after 3484810 ns,
             x"10" after 3571810 ns,
             x"20" after 3658810 ns,
             x"34" after 3745810 ns, -- 34201073
             x"EF" after 3832810 ns,
             x"00" after 3919810 ns,
             x"00" after 4006810 ns,
             x"01" after 4093810 ns, -- 010000EF
             x"83" after 4180810 ns,
             x"20" after 4267810 ns,
             x"01" after 4354810 ns,
             x"00" after 4441810 ns, -- 00012083
             x"13" after 4528810 ns,
             x"01" after 4615810 ns,
             x"41" after 4702810 ns,
             x"00" after 4789810 ns, -- 00410113
             x"67" after 4876810 ns,
             x"80" after 4963810 ns,
             x"00" after 5050810 ns,
             x"00" after 5137810 ns, -- 00008067
             x"13" after 5224810 ns,
             x"01" after 5311810 ns,
             x"01" after 5398810 ns,
             x"FF" after 5485810 ns, -- FF010113
             x"23" after 5572810 ns,
             x"26" after 5659810 ns,
             x"81" after 5746810 ns,
             x"00" after 5833810 ns, -- 00812623
             x"13" after 5920810 ns,
             x"04" after 6007810 ns,
             x"01" after 6094810 ns,
             x"01" after 6181810 ns, -- 01010413
             x"93" after 6268810 ns,
             x"07" after 6355810 ns,
             x"70" after 6442810 ns,
             x"00" after 6529810 ns, -- 00700793
             x"23" after 6616810 ns,
             x"2A" after 6703810 ns,
             x"F4" after 6790810 ns,
             x"FE" after 6877810 ns, -- FEF42A23
             x"93" after 6964810 ns,
             x"07" after 7051810 ns,
             x"10" after 7138810 ns, 
             x"00" after 7225810 ns, -- 00100793
             x"23" after 7312810 ns,
             x"28" after 7399810 ns,
             x"F4" after 7486810 ns,
             x"FE" after 7573810 ns, -- FEF42823
             x"6F" after 7660810 ns,
             x"00" after 7747810 ns,
             x"00" after 7834810 ns,
             x"02" after 7921810 ns, -- 0200006F
             x"03" after 8008810 ns,
             x"27" after 8095810 ns,
             x"44" after 8182810 ns,
             x"FF" after 8269810 ns, -- FF442703
             x"83" after 8356810 ns,
             x"27" after 8443810 ns,
             x"04" after 8530810 ns,
             x"FF" after 8617810 ns, -- FF042783
             x"B3" after 8704810 ns,
             x"47" after 8791810 ns,
             x"F7" after 8878810 ns,
             x"02" after 8965810 ns, -- 02F747B3
             x"23" after 9052810 ns,
             x"2A" after 9139810 ns,
             x"F4" after 9226810 ns,
             x"FE" after 9313810 ns, -- FEF42A23
             x"83" after 9400810 ns,
             x"27" after 9487810 ns,
             x"04" after 9574810 ns,
             x"FF" after 9661810 ns, -- FF042783
             x"93" after 9748810 ns,
             x"87" after 9835810 ns,
             x"17" after 9922810 ns,
             x"00" after 10009810 ns, -- 00178793
             x"23" after 10096810 ns,
             x"28" after 10183810 ns,
             x"F4" after 10270810 ns,
             x"FE" after 10357810 ns, -- FEF42823
             x"03" after 10444810 ns,
             x"27" after 10531810 ns,
             x"04" after 10618810 ns,
             x"FF" after 10705810 ns, -- FF042703
             x"93" after 10792810 ns,
             x"07" after 10879810 ns,
             x"20" after 10966810 ns,
             x"00" after 11053810 ns, -- 00200793
             x"E3" after 11140810 ns,
             x"DE" after 11227810 ns,
             x"E7" after 11314810 ns,
             x"FC" after 11401810 ns, -- FCE7DEE3
             x"83" after 11488810 ns,
             x"27" after 11575810 ns,
             x"44" after 11662810 ns,
             x"FF" after 11749810 ns, -- FF442783
             x"13" after 11836810 ns,
             x"85" after 11923810 ns,
             x"07" after 12010810 ns,
             x"00" after 12097810 ns, -- 00078513
             x"03" after 12184810 ns,
             x"24" after 12271810 ns,
             x"C1" after 12358810 ns,
             x"00" after 12445810 ns, -- 00C12403
             x"13" after 12532810 ns,
             x"01" after 12619810 ns,
             x"01" after 12706810 ns,
             x"01" after 12793810 ns, -- 01010113
             x"67" after 12880810 ns,
             x"80" after 12967810 ns,
             x"00" after 13054810 ns,
             x"00" after 13141810 ns, -- 00008067
             x"00" after 13228810 ns,
             x"00" after 13315810 ns,
             x"00" after 13402810 ns,
             x"04" after 13489810 ns, -- 04000000
             x"7B" after 13576810 ns,
             x"00" after 13663810 ns,
             x"00" after 13750810 ns,
             x"00" after 13837810 ns; -- 0000007B

  tx_dv <= '0', '1' after 1115 ns, '0' after 1165 ns,   -- 00 / 86860
                '1' after 87950 ns, '0' after 88000 ns,   -- 00
                '1' after 174810 ns, '0' after 174860 ns, -- 00
                '1' after 261670 ns, '0' after 261720 ns, -- 94 , finish sending size
                '1' after 348530 ns, '0' after 348580 ns,
                '1' after 435390 ns, '0' after 435440 ns,
                '1' after 522250 ns, '0' after 522300 ns,
                '1' after 609110 ns, '0' after 609160 ns,  -- 73400113
                '1' after 695970 ns, '0' after 696030 ns, 
                '1' after 782830 ns, '0' after 782880 ns, 
                '1' after 869690 ns, '0' after 869740 ns, 
                '1' after 956550 ns, '0' after 956600 ns,  -- FFC10113
                '1' after 1043410 ns, '0' after 1043460 ns,
                '1' after 1130270 ns, '0' after 1130320 ns,
                '1' after 1217130 ns, '0' after 1217180 ns,
                '1' after 1309990 ns, '0' after 1310040 ns, -- 00112023
                '1' after 1396810 ns, '0' after 1396860 ns,
                '1' after 1483810 ns, '0' after 1483860 ns,
                '1' after 1570810 ns, '0' after 1570860 ns,
                '1' after 1657810 ns, '0' after 1657860 ns, -- 00001F37
                '1' after 1744810 ns, '0' after 1744860 ns,
                '1' after 1831810 ns, '0' after 1831860 ns,
                '1' after 1918810 ns, '0' after 1918860 ns,
                '1' after 2005810 ns, '0' after 2005860 ns, -- 800F0F13
                '1' after 2092810 ns, '0' after 2092860 ns,
                '1' after 2179810 ns, '0' after 2179860 ns,
                '1' after 2266810 ns, '0' after 2266860 ns,
                '1' after 2353810 ns, '0' after 2353860 ns, -- 304F2073
                '1' after 2440810 ns, '0' after 2440860 ns,
                '1' after 2527810 ns, '0' after 2527860 ns,
                '1' after 2614810 ns, '0' after 2614860 ns,
                '1' after 2701810 ns, '0' after 2701860 ns, -- 30446073
                '1' after 2788810 ns, '0' after 2788860 ns, 
                '1' after 2875810 ns, '0' after 2875860 ns,
                '1' after 2962810 ns, '0' after 2962860 ns,
                '1' after 3049810 ns, '0' after 3049860 ns, -- 30046073
                '1' after 3136810 ns, '0' after 3136860 ns,
                '1' after 3223810 ns, '0' after 3223860 ns,
                '1' after 3310810 ns, '0' after 3310860 ns,
                '1' after 3397810 ns, '0' after 3397860 ns, -- 34101073
                '1' after 3484810 ns, '0' after 3484860 ns,
                '1' after 3571810 ns, '0' after 3571860 ns,
                '1' after 3658810 ns, '0' after 3658860 ns,
                '1' after 3745810 ns, '0' after 3745860 ns, -- 34201073
                '1' after 3832810 ns, '0' after 3832860 ns,
                '1' after 3919810 ns, '0' after 3919860 ns,
                '1' after 4006810 ns, '0' after 4006860 ns,
                '1' after 4093810 ns, '0' after 4093860 ns, -- 010000EF
                '1' after 4180810 ns, '0' after 4180860 ns,
                '1' after 4267810 ns, '0' after 4267860 ns,
                '1' after 4354810 ns, '0' after 4354860 ns,
                '1' after 4441810 ns, '0' after 4441860 ns, -- 00012083
                '1' after 4528810 ns, '0' after 4528860 ns,
                '1' after 4615810 ns, '0' after 4615860 ns,
                '1' after 4702810 ns, '0' after 4702860 ns,
                '1' after 4789810 ns, '0' after 4789860 ns, -- 00410113
                '1' after 4876810 ns, '0' after 4876860 ns,
                '1' after 4963810 ns, '0' after 4963860 ns,
                '1' after 5050810 ns, '0' after 5050860 ns,
                '1' after 5137810 ns, '0' after 5137860 ns, -- 00008067
                '1' after 5224810 ns, '0' after 5224860 ns,
                '1' after 5311810 ns, '0' after 5311860 ns,
                '1' after 5398810 ns, '0' after 5398860 ns,
                '1' after 5485810 ns, '0' after 5485860 ns, -- FF010113
                '1' after 5572810 ns, '0' after 5572860 ns,
                '1' after 5659810 ns, '0' after 5659860 ns,
                '1' after 5746810 ns, '0' after 5746860 ns,
                '1' after 5833810 ns, '0' after 5833860 ns, -- 00812623
                '1' after 5920810 ns, '0' after 5920860 ns,
                '1' after 6007810 ns, '0' after 6007860 ns,
                '1' after 6094810 ns, '0' after 6094860 ns,
                '1' after 6181810 ns, '0' after 6181860 ns, -- 01010413
                '1' after 6268810 ns, '0' after 6268860 ns, 
                '1' after 6355810 ns, '0' after 6355860 ns,
                '1' after 6442810 ns, '0' after 6442860 ns,
                '1' after 6529810 ns, '0' after 6529860 ns, -- 01700793
                '1' after 6616810 ns, '0' after 6616860 ns,
                '1' after 6703810 ns, '0' after 6703860 ns,
                '1' after 6790810 ns, '0' after 6790860 ns,
                '1' after 6877810 ns, '0' after 6877860 ns, -- FEF42A23
                '1' after 6964810 ns, '0' after 6964860 ns,
                '1' after 7051810 ns, '0' after 7051860 ns,
                '1' after 7138810 ns, '0' after 7138860 ns,
                '1' after 7225810 ns, '0' after 7225860 ns, -- 00100793
                '1' after 7312810 ns, '0' after 7312860 ns,
                '1' after 7399810 ns, '0' after 7399860 ns,
                '1' after 7486810 ns, '0' after 7486860 ns,
                '1' after 7573810 ns, '0' after 7573860 ns, -- FEF42823
                '1' after 7660810 ns, '0' after 7660860 ns,
                '1' after 7747810 ns, '0' after 7747860 ns,
                '1' after 7834810 ns, '0' after 7834860 ns,
                '1' after 7921810 ns, '0' after 7921860 ns, -- 0200006F
                '1' after 8008810 ns, '0' after 8008860 ns,
                '1' after 8095810 ns, '0' after 8095860 ns,
                '1' after 8182810 ns, '0' after 8182860 ns,
                '1' after 8269810 ns, '0' after 8269860 ns, -- FF442703
                '1' after 8356810 ns, '0' after 8356860 ns,
                '1' after 8443810 ns, '0' after 8443860 ns,
                '1' after 8530810 ns, '0' after 8530860 ns,
                '1' after 8617810 ns, '0' after 8617860 ns, -- FF042783
                '1' after 8704810 ns, '0' after 8704860 ns,
                '1' after 8791810 ns, '0' after 8791860 ns,
                '1' after 8878810 ns, '0' after 8878860 ns,
                '1' after 8965810 ns, '0' after 8965860 ns, -- 02F747B3
                '1' after 9052810 ns, '0' after 9052860 ns,
                '1' after 9139810 ns, '0' after 9139860 ns,
                '1' after 9226810 ns, '0' after 9226860 ns,
                '1' after 9313810 ns, '0' after 9313860 ns, -- FEF42A23
                '1' after 9400810 ns, '0' after 9400860 ns,
                '1' after 9487810 ns, '0' after 9487860 ns,
                '1' after 9574810 ns, '0' after 9574860 ns,
                '1' after 9661810 ns, '0' after 9661860 ns, -- FF042783
                '1' after 9748810 ns, '0' after 9748860 ns,
                '1' after 9835810 ns, '0' after 9835860 ns,
                '1' after 9922810 ns, '0' after 9922860 ns,
                '1' after 10009810 ns, '0' after 10009860 ns, -- 00178793
                '1' after 10096810 ns, '0' after 10096860 ns,
                '1' after 10183810 ns, '0' after 10183860 ns,
                '1' after 10270810 ns, '0' after 10270860 ns,
                '1' after 10357810 ns, '0' after 10357860 ns, -- FEF42823
                '1' after 10444810 ns, '0' after 10444860 ns,
                '1' after 10531810 ns, '0' after 10531860 ns,
                '1' after 10618810 ns, '0' after 10618860 ns,
                '1' after 10705810 ns, '0' after 10705860 ns, -- FF042703
                '1' after 10792810 ns, '0' after 10792860 ns,
                '1' after 10879810 ns, '0' after 10879860 ns,
                '1' after 10966810 ns, '0' after 10966860 ns,
                '1' after 11053810 ns, '0' after 11053860 ns, -- 00B00793
                '1' after 11140810 ns, '0' after 11140860 ns,
                '1' after 11227810 ns, '0' after 11227860 ns,
                '1' after 11314810 ns, '0' after 11314860 ns,
                '1' after 11401810 ns, '0' after 11401860 ns, -- FCE7DEE3
                '1' after 11488810 ns, '0' after 11488860 ns,
                '1' after 11575810 ns, '0' after 11575860 ns,
                '1' after 11662810 ns, '0' after 11662860 ns,
                '1' after 11749810 ns, '0' after 11749860 ns, -- 00000793
                '1' after 11836810 ns, '0' after 11836860 ns,
                '1' after 11923810 ns, '0' after 11923860 ns,
                '1' after 12010810 ns, '0' after 12010860 ns,
                '1' after 12097810 ns, '0' after 12097860 ns, -- 00078513
                '1' after 12184810 ns, '0' after 12184860 ns,
                '1' after 12271810 ns, '0' after 12271860 ns,
                '1' after 12358810 ns, '0' after 12358860 ns,
                '1' after 12445810 ns, '0' after 12445860 ns, -- 00C12403
                '1' after 12532810 ns, '0' after 12532860 ns,
                '1' after 12619810 ns, '0' after 12619860 ns,
                '1' after 12706810 ns, '0' after 12706860 ns,
                '1' after 12793810 ns, '0' after 12793860 ns, -- 01010113
                '1' after 12880810 ns, '0' after 12880860 ns,
                '1' after 12967810 ns, '0' after 12967860 ns,
                '1' after 13054810 ns, '0' after 13054860 ns,
                '1' after 13141810 ns, '0' after 13141860 ns, -- 00008067
                '1' after 13228810 ns, '0' after 13228860 ns,
                '1' after 13315810 ns, '0' after 13315860 ns,
                '1' after 13402810 ns, '0' after 13402860 ns,
                '1' after 13489810 ns, '0' after 13489860 ns, -- 04000000
                '1' after 13576810 ns, '0' after 13576860 ns,
                '1' after 13663810 ns, '0' after 13663860 ns,
                '1' after 13750810 ns, '0' after 13750860 ns,
                '1' after 13837810 ns, '0' after 13837860 ns; -- 0000007B


 -- intr_sig <= '0', '1' after 1000 ns, '0' after 1050 ns;
 -- port_io_sig(30 downto 27) <= "0000", "1000" after 8000 ns;
  --port_io_sig(3 downto 0) <= "1111";
  port_io_sig(30 downto 0) <= (others => 'Z');
  port_io_sig(31) <= '0'; --, '1' after 15000 ns, '0' after 16000 ns;

end architecture behavior;
