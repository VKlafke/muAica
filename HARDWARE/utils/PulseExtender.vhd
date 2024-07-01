library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- For using unsigned numerical operations

entity PulseExtender is
    Port (
        clk         : in  std_logic;         -- Clock input
        rst         : in  std_logic;         -- Reset input, active high
        pulse_in    : in  std_logic;         -- Input pulse to be extended
        pulse_out   : out std_logic          -- Extended pulse
    );
end PulseExtender;

architecture Behavioral of PulseExtender is
    constant PULSE_WIDTH : natural := 100;  -- Number of cycles to extend the pulse
    signal counter : unsigned(3 downto 0); -- 4-bit counter for up to 16 cycles
    signal pulse_active : std_logic := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            pulse_out <= '0';
            pulse_active <= '0';
        elsif rising_edge(clk) then
            if pulse_in = '1' then
                counter <= (others => '0');
                pulse_active <= '1';
                pulse_out <= '1';
            elsif pulse_active = '1' then
                if counter = unsigned'("0000") + (PULSE_WIDTH - 2) then -- Explicit conversion and proper calculation
                    pulse_out <= '0';  -- End of extended pulse
                    pulse_active <= '0';
                else
                    counter <= counter + 1;
                    pulse_out <= '1';  -- Keep extending the pulse
                end if;
            else
                pulse_out <= '0';
            end if;
        end if;
    end process;
end Behavioral;