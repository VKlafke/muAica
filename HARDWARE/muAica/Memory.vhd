--
-- Single-Port BRAM with Byte-wide Write Enable
-- 2x8-bit write
-- Read-First mode
-- Single-process description
-- Compact description of the write with a for-loop statement
-- Column width and number of columns easily configurable
--
-- 
-- Download: http://www.xilinx.com/txpatches/pub/documentation/misc/xstug_examples.zip
-- File: HDL_Coding_Techniques/rams/bytewrite_ram_1b.vhd
--
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all; 
use std.textio.all;
use work.Util_pkg.all;

entity Memory is
    generic (
        SIZE            : integer := 1024;      -- Memory depth
        ADDR_WIDTH      : integer := 32;        -- Address bus width
        COL_WIDTH       : integer := 8;         -- Data width (word)
        NB_COL          : integer := 4;         -- Number of bytes in a word
        imageFileName   : string := "UNUSED";   -- Memory content to be loaded
        OFFSET          : UNSIGNED(31 downto 0) := x"00000000"
    );
    port (
        clock   : in std_logic;
        wbe     : in std_logic_vector(NB_COL-1 downto 0);
        ce      : in std_logic;
        address : in std_logic_vector(ADDR_WIDTH-1 downto 0);
        data_i  : in std_logic_vector(NB_COL*COL_WIDTH-1 downto 0);
        data_o  : out std_logic_vector(NB_COL*COL_WIDTH-1 downto 0)
    );
end Memory;

architecture behavioral of Memory is
    type Memory is array (0 to SIZE - 1) of std_logic_vector (NB_COL*COL_WIDTH-1 downto 0);
    
    impure function MemoryLoad (imageFileName : in string) return Memory is
        file imageFile : text;
        variable fileLine : line;
        variable memoryArray : Memory;
        variable data_str : string(1 to 8);
		variable i : integer := 0;
    begin   
        if imageFileName /= "UNUSED" then
            file_open(imageFile, imageFileName, READ_MODE);
            
            for i in 1 to SIZE loop
                if NOT (endfile(imageFile)) then
                    readline (imageFile, fileLine);
                    read (fileLine, data_str);
                    memoryArray(i-1) := StringToStdLogicVector(data_str);
                   -- i := i + 1;
                 else
                    exit;
                 end if;
            end loop;
			file_close(imageFile);
        end if;
        
        return memoryArray;
    end function;
    
    signal memoryArray : Memory := MemoryLoad(imageFileName);
    
    signal arrayAddress : integer;
    
begin
    
    arrayAddress <= TO_INTEGER(UNSIGNED(address) - OFFSET(31 downto 2));
    
    process (clock)
    begin
        if rising_edge(clock) then
            if ce = '1' then
                data_o <= memoryArray(arrayAddress);
                for i in 0 to NB_COL-1 loop
                    if wbe(i) = '1' then
                        memoryArray(arrayAddress)((i+1)*COL_WIDTH-1 downto i*COL_WIDTH) <= data_i((i+1)*COL_WIDTH-1 downto i*COL_WIDTH);
                    end if;
                end loop;
            end if;
        end if;
    end process;
end behavioral;