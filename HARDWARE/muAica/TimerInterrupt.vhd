------------------------------------------------------------------------------
-- DESIGN UNIT  : Timer Interrupt                                      		--
-- DESCRIPTION  :                                                           --
--              :                                                           --
-- AUTHOR       : Victor Hugo Canello Klafke                                --
-- CREATED      : August, 2023                                              --
-- VERSION      : 1.0                                                       --
-- HISTORY      : Version 1.0 - August, 2023  - Victor Hugo Canello Klafke  --
------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity TimerInterrupt  is
    generic (
        BASE_CLOCK_ADDR    : std_logic_vector(7 downto 0); -- Set up the clock frequency
        TIMER_VAL_ADDR     : std_logic_vector(7 downto 0); -- Set up the count in ms
		ENABLE_ADDR        : std_logic_vector(7 downto 0)  -- Enable / Disable
    );
    port (  
        clk         : in std_logic;
        rst         : in std_logic; 
        data_in     : in std_logic_vector (31 downto 0);
        address     : in std_logic_vector (7 downto 0);
        ce          : in std_logic;
        intr        : out std_logic -- To processor
    );
end TimerInterrupt ;


architecture Behavioral of TimerInterrupt  is

	signal base_clock_reg : integer := 50000; -- Default to 50 MHz (50000 Khz)
    signal timer_val_reg  : integer := 0; 		 -- Default to 0 ms
    signal enable_reg     : std_logic := '0';

	signal target_count_a : integer := 0;
    signal target_count_b : integer := 0;
    signal counter_a  : std_logic_vector(31 downto 0) := (others => '0');
    signal counter_b  : std_logic_vector(31 downto 0) := (others => '0');
	
	signal target_not_zero : std_logic;
	
	signal enBaseClock  : std_logic;
	signal enTimerVal   : std_logic;
	signal enEnableReg  : std_logic;
	
	signal intr_sig		: std_logic;

   
begin

	enBaseClock <= '1' when address = BASE_CLOCK_ADDR and ce = '1' else '0';
	enTimerVal  <= '1' when address = TIMER_VAL_ADDR  and ce = '1' else '0';
	enEnableReg <= '1' when address = ENABLE_ADDR 	  and ce = '1' else '0';
	
	intr <= intr_sig AND target_not_zero;
	
	target_not_zero <= '1' when (target_count_b /= 0) else '0';
	
	-----------------------------------------
    --       Reset / reg input logic       --
    -----------------------------------------
    process(clk, rst)
    begin
        if rst = '1' then
			enable_reg <= '0';
            target_count_a <= 0;
            target_count_b <= 0;
        elsif rising_edge(clk) then
			
			if enBaseClock = '1' then
				base_clock_reg <=  to_integer(unsigned(data_in));
			end if;
			
			if enTimerVal = '1' then
				timer_val_reg <=  to_integer(unsigned(data_in));
			end if;
			
			if enEnableReg = '1' then
				enable_reg <= data_in(0);
				-- Compute target count value based on user input
				target_count_a <= base_clock_reg;
                target_count_b <= timer_val_reg;
			end if;

            if intr_sig = '1' then 
                enable_reg <= '0';
            end if;
			
        end if;
    end process;
   
    --------------------------------
    --           Counter          --
    --------------------------------
    process(clk, rst)
    begin
        if rst = '1' then   
            counter_a <= (others => '0');
            counter_b <= (others => '0');
            intr_sig <= '0';
        elsif rising_edge(clk) then
			if enable_reg = '1' then
            
                -- Inner counter 
                if counter_a >= target_count_a then
                    counter_b <= counter_b + 1;
                    
					counter_a <= (others => '0');
					
                    intr_sig <= '0';
                else
                    counter_a <= counter_a + 1;
                    intr_sig <= '0';
                end if;
                
                -- outer counter 
                if counter_b >= target_count_b then 
					counter_b <= (others => '0');
					counter_a <= (others => '0');
                    intr_sig <= '1';
                else
                    intr_sig <= '0';
                end if;
                
            else
                counter_a <= (others => '0');
                counter_b <= (others => '0');
                intr_sig <= '0';
           end if;
        end if;
    end process;
        
end Behavioral;