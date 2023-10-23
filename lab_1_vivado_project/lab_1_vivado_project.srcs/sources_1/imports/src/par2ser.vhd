library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity par2ser is
    port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_parallel: in std_logic_vector(3 downto 0);
        data_serial: out std_logic
    );
end par2ser;

architecture behavioural of par2ser is
    
    -- Define the needed internal signals
    signal current_sample_shifter, next_sample_shifter : std_logic_vector(3 downto 0);
    signal current_counter, next_counter : unsigned(1 downto 0);
    signal conversion_start : std_logic;

begin

    -- purpose: Implements the registers for the sequence decoder
    -- type : sequential
    registers: process (clk, reset_n)
    begin
        if reset_n = '0' then
            current_sample_shifter <= (others => '0');
            current_counter        <= (others => '0');
            
        elsif rising_edge(clk) then
            current_sample_shifter <= next_sample_shifter;
            current_counter <= next_counter;
        end if;
        
    end process;
    
    
    
    -- increment code
    next_counter <= current_counter + 1;
    
    
    -- output logic
    --data_serial <= current_sample_shifter(3);  -- MSB first
    data_serial <= current_sample_shifter(0);  -- LSB first
    

    
    set_conversion_start: process(current_counter)
    begin    
        if current_counter = "01" then
            conversion_start <= '1';
            
        else
            conversion_start <= '0';
    
        end if;    
    end process;


    combinational_shifter: process(conversion_start, data_parallel, current_sample_shifter) -- fill out the sensitivity list
    begin
        -- default values (why needed?)
        --
 next_sample_shifter <= current_sample_shifter;
        --next_sample_shifter <= (others => '0');

        -- write the code for parallel to serial conversion
	
       
       -- Load from parallel data
       if conversion_start = '1' then
           next_sample_shifter <= data_parallel;
           
       
       -- Load from previous shift register
       else
           -- MSB first (wrong?)
           --next_sample_shifter(3) <= current_sample_shifter(2);
           --next_sample_shifter(2) <= current_sample_shifter(1);
           --next_sample_shifter(1) <= current_sample_shifter(0);
           --next_sample_shifter(0) <= '0';
           
           -- LSB first
           next_sample_shifter <= current_sample_shifter(3 downto 1) & '0';
           next_sample_shifter(0) <= current_sample_shifter(1);
           next_sample_shifter(1) <= current_sample_shifter(2);
           next_sample_shifter(2) <= current_sample_shifter(3);
           next_sample_shifter(3) <= '0';



       end if;
       
    end process;
    
end behavioural;
