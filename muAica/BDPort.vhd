library IEEE;
use IEEE.std_logic_1164.all;

entity BDPort  is
    generic (
        DATA_WIDTH          : integer;    -- Port width in bits
        PORT_DATA_ADDR      : std_logic_vector(7 downto 0);     
        PORT_CONFIG_ADDR    : std_logic_vector(7 downto 0);     
        PORT_ENABLE_ADDR    : std_logic_vector(7 downto 0);     
        PORT_ITR_ADDR       : std_logic_vector(7 downto 0)
    );
    port (  
        clk         : in std_logic;
        rst         : in std_logic; 
        
        -- Processor interface
        data_i      : in std_logic_vector (DATA_WIDTH-1 downto 0);
        data_o      : out std_logic_vector (DATA_WIDTH-1 downto 0);
        address     : in std_logic_vector (7 downto 0);     
        rw          : in std_logic; -- 0: read; 1: write
        ce          : in std_logic;
        itr_o       : out std_logic_vector (DATA_WIDTH-1 downto 0);
        
        -- External interface
        port_io     : inout std_logic_vector (DATA_WIDTH-1 downto 0)
    );
end BDPort ;


architecture behavioral of BDPort is
	signal PortData, PortConfig : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal PortEnable, Synch 	: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal ITREnable            : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal d_PortData, d_Synch  : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal enPortData, enPortConfig  : std_logic;
    signal enPortEnable, enITREnable : std_logic;
	
begin
	
	GEND_PORTDATA: for I in 0 to DATA_WIDTH-1 generate
        d_PortData(I) <= data_i(I) when (PortConfig(I) = '0' and PortEnable(I) = '1') else Synch(I);
    end generate GEND_PORTDATA;
	
	--d_PortData(0)   <= data_i(0)  when PortConfig(0)  = '0' and PortEnable(0)  = '1' else Synch(0);
	--d_PortData(1)   <= data_i(1)  when PortConfig(1)  = '0' and PortEnable(1)  = '1' else Synch(1);
	--d_PortData(2)   <= data_i(2)  when PortConfig(2)  = '0' and PortEnable(2)  = '1' else Synch(2);
	--d_PortData(3)   <= data_i(3)  when PortConfig(3)  = '0' and PortEnable(3)  = '1' else Synch(3);
	--d_PortData(4)   <= data_i(4)  when PortConfig(4)  = '0' and PortEnable(4)  = '1' else Synch(4);
	--d_PortData(5)   <= data_i(5)  when PortConfig(5)  = '0' and PortEnable(5)  = '1' else Synch(5);
	--d_PortData(6)   <= data_i(6)  when PortConfig(6)  = '0' and PortEnable(6)  = '1' else Synch(6);
	--d_PortData(7)   <= data_i(7)  when PortConfig(7)  = '0' and PortEnable(7)  = '1' else Synch(7);
	--d_PortData(8)   <= data_i(8)  when PortConfig(8)  = '0' and PortEnable(8)  = '1' else Synch(8);
	--d_PortData(9)   <= data_i(9)  when PortConfig(9)  = '0' and PortEnable(9)  = '1' else Synch(9);
	--d_PortData(10)  <= data_i(10) when PortConfig(10) = '0' and PortEnable(10) = '1' else Synch(10);
	--d_PortData(11)  <= data_i(11) when PortConfig(11) = '0' and PortEnable(11) = '1' else Synch(11);
	--d_PortData(12)  <= data_i(12) when PortConfig(12) = '0' and PortEnable(12) = '1' else Synch(12);
	--d_PortData(13)  <= data_i(13) when PortConfig(13) = '0' and PortEnable(13) = '1' else Synch(13);
	--d_PortData(14)  <= data_i(14) when PortConfig(14) = '0' and PortEnable(14) = '1' else Synch(14);
	--d_PortData(15)  <= data_i(15) when PortConfig(15) = '0' and PortEnable(15) = '1' else Synch(15);
		
	
	enPortData   <= '1' when address = PORT_DATA_ADDR   and ce = '1' and rw = '1' else '0';
	enPortConfig <= '1' when address = PORT_CONFIG_ADDR and ce = '1' and rw = '1' else '0';
	enPortEnable <= '1' when address = PORT_ENABLE_ADDR and ce = '1' and rw = '1' else '0';
	enITREnable  <= '1' when address = PORT_ITR_ADDR    and ce = '1' and rw = '1' else '0';
	
	process(clk, rst)
	
	begin
		if rst = '1' then
			PortEnable <= (others=>'0');
			PortData <= (others => '0');
		elsif rising_edge(clk) then
			for I in 0 to DATA_WIDTH-1 loop
				if enPortData = '1' or PortConfig(I) = '1' then
					PortData(I)   <= d_PortData(I);
				end if;
			end loop;
			
			if enPortConfig = '1' then
				PortConfig <= data_i;
			end if;
			
			if enPortEnable = '1' then
				PortEnable <= data_i;
			end if;
			
			if enITREnable = '1' then
				ITREnable <= data_i;
			end if;
			
			Synch <= d_Synch;
			
		end if;
	end process;
	 
   GENPORT_IO: for I in 0 to DATA_WIDTH-1 generate
        port_io(I)   <= PortData(I) when PortConfig(I) = '0' and PortEnable(I) = '1' else 'Z';
    end generate GENPORT_IO;
	
	
	--port_io(0)   <= PortData(0)  when PortConfig(0)  = '0' and PortEnable(0)  = '1' else 'Z';
	--port_io(1)   <= PortData(1)  when PortConfig(1)  = '0' and PortEnable(1)  = '1' else 'Z';
	--port_io(2)   <= PortData(2)  when PortConfig(2)  = '0' and PortEnable(2)  = '1' else 'Z';
	--port_io(3)   <= PortData(3)  when PortConfig(3)  = '0' and PortEnable(3)  = '1' else 'Z';
	--port_io(4)   <= PortData(4)  when PortConfig(4)  = '0' and PortEnable(4)  = '1' else 'Z';
	--port_io(5)   <= PortData(5)  when PortConfig(5)  = '0' and PortEnable(5)  = '1' else 'Z';
	--port_io(6)   <= PortData(6)  when PortConfig(6)  = '0' and PortEnable(6)  = '1' else 'Z';
	--port_io(7)   <= PortData(7)  when PortConfig(7)  = '0' and PortEnable(7)  = '1' else 'Z';
	--port_io(8)   <= PortData(8)  when PortConfig(8)  = '0' and PortEnable(8)  = '1' else 'Z';
	--port_io(9)   <= PortData(9)  when PortConfig(9)  = '0' and PortEnable(9)  = '1' else 'Z';
	--port_io(10)  <= PortData(10) when PortConfig(10) = '0' and PortEnable(10) = '1' else 'Z';
	--port_io(11)  <= PortData(11) when PortConfig(11) = '0' and PortEnable(11) = '1' else 'Z';
	--port_io(12)  <= PortData(12) when PortConfig(12) = '0' and PortEnable(12) = '1' else 'Z';
	--port_io(13)  <= PortData(13) when PortConfig(13) = '0' and PortEnable(13) = '1' else 'Z';
	--port_io(14)  <= PortData(14) when PortConfig(14) = '0' and PortEnable(14) = '1' else 'Z';
	--port_io(15)  <= PortData(15) when PortConfig(15) = '0' and PortEnable(15) = '1' else 'Z';
	
	GEND_SYNCH: for I in 0 to DATA_WIDTH-1 generate
        d_Synch(I)   <= port_io(I)  when PortConfig(I)  = '1' and PortEnable(I)  = '1' else 'Z';
    end generate GEND_SYNCH; 
	
	--d_Synch(0)   <= port_io(0)  when PortConfig(0)  = '1' and PortEnable(0)  = '1' else 'Z';
	--d_Synch(1)   <= port_io(1)  when PortConfig(1)  = '1' and PortEnable(1)  = '1' else 'Z';
	--d_Synch(2)   <= port_io(2)  when PortConfig(2)  = '1' and PortEnable(2)  = '1' else 'Z';
	--d_Synch(3)   <= port_io(3)  when PortConfig(3)  = '1' and PortEnable(3)  = '1' else 'Z';
	--d_Synch(4)   <= port_io(4)  when PortConfig(4)  = '1' and PortEnable(4)  = '1' else 'Z';
	--d_Synch(5)   <= port_io(5)  when PortConfig(5)  = '1' and PortEnable(5)  = '1' else 'Z';
	--d_Synch(6)   <= port_io(6)  when PortConfig(6)  = '1' and PortEnable(6)  = '1' else 'Z';
	--d_Synch(7)   <= port_io(7)  when PortConfig(7)  = '1' and PortEnable(7)  = '1' else 'Z';
	--d_Synch(8)   <= port_io(8)  when PortConfig(8)  = '1' and PortEnable(8)  = '1' else 'Z';
	--d_Synch(9)   <= port_io(9)  when PortConfig(9)  = '1' and PortEnable(9)  = '1' else 'Z';
	--d_Synch(10)  <= port_io(10) when PortConfig(10) = '1' and PortEnable(10) = '1' else 'Z';
    --d_Synch(11)  <= port_io(11) when PortConfig(11) = '1' and PortEnable(11) = '1' else 'Z';
	--d_Synch(12)  <= port_io(12) when PortConfig(12) = '1' and PortEnable(12) = '1' else 'Z';
	--d_Synch(13)  <= port_io(13) when PortConfig(13) = '1' and PortEnable(13) = '1' else 'Z';
	--d_Synch(14)  <= port_io(14) when PortConfig(14) = '1' and PortEnable(14) = '1' else 'Z';
	--d_Synch(15)  <= port_io(15) when PortConfig(15) = '1' and PortEnable(15) = '1' else 'Z';
	

    GENITR_O: for I in 0 to DATA_WIDTH-1 generate
        itr_o(I) <= PortData(I) and PortConfig(I) and PortEnable(I) and ITREnable(I);
	end generate GENITR_O;
	
	data_o <= PortData   when address = PORT_DATA_ADDR else
			  PortConfig when address = PORT_CONFIG_ADDR else
			  PortEnable;
			  
	
end Behavioral;
