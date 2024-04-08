library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataBuffer is
    Port ( clk          : in  STD_LOGIC;
           rst          : in  STD_LOGIC;
           data_in      : in  STD_LOGIC_VECTOR(7 downto 0);
           data_av      : in  STD_LOGIC;
           re_en       : in  STD_LOGIC; -- Signal to read/consume the data
           data_out     : out STD_LOGIC_VECTOR(7 downto 0);
           data_o_ready : out STD_LOGIC);
end DataBuffer;

architecture Behavioral of DataBuffer is
    signal temp_data : STD_LOGIC_VECTOR(7 downto 0);
    signal data_ready : STD_LOGIC := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            temp_data <= (others => '0');
            data_ready <= '0';
        elsif rising_edge(clk) then
            if data_av = '1' then
                -- Capture the incoming data
                temp_data <= data_in;
                data_ready <= '1';
            elsif re_en = '1' and data_ready = '1' then
                -- Clear the data ready signal when read enable is asserted and data is ready
                data_ready <= '0';
            end if;
        end if;
    end process;

    -- Output assignments
    data_out <= temp_data;
    data_o_ready <= data_ready;

end Behavioral;
