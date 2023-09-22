library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_mealy is
    port (
        clk: in std_logic;
        reset_n: in std_logic;
        data_serial : in std_logic;
        data_valid : in std_logic;
        data_out: out std_logic
    );
end sequence_detector_mealy;




architecture behavioural of sequence_detector_mealy is


    -- Define a enumeration type for the states
    type state_type is (s_init, s_1, s_10, s_101);
    
    -- Define the needed internal signals
    signal current_state, next_state: state_type;

begin
            
    -- purpose: Implements the registers for the sequence decoder
    -- type : sequential
    registers: process (clk, reset_n)
    begin
        if reset_n = '0' then
            current_state <= s_init;
            
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;
    
    
    
    -- purpose: Implements the next_state logic as well as the output logic
    -- type : combinational
    combinational: process (current_state, data_serial) -- fill out the sensitivity list
    begin

        --case current_state is
        --    when s_init =>
        --        --next_state <= s_init when data_serial = '0' else s_1;
        --        if data_serial = '0' then
        --            next_state <= s_init; 
        --        else
        --            next_state <= s_1;
        --        end if;
        --        
        --    when s_1 => 
        --        --next_state <= s_10 when data_serial = '0' else s_1;
        --        if data_serial = '0' then
        --            next_state <= s_10;
        --        else
        --            next_state <= s_1; 
        --        end if;
        --          
        --    when s_10 =>
        --        --next_state <= s_init when data_serial = '0' else s_101;
        --        if data_serial = '0' then
        --            next_state <= s_init;   
        --        else
        --            next_state <= s_101;
        --        end if;
        --        
        --    when s_101 =>
        --        --next_state <= s_10 when data_serial = '0' else s_1;
        --        --data_out <= '1' when data_serial = '0' else '0';
        --        if data_serial = '0' then
        --            next_state <= s_10;
        --            data_out <= '1';
        --        else
        --            next_state <= s_1;
        --        end if;
        --        
        --end case;
        
        
        data_out <= '0';

        
        if current_state = s_init then
            if data_serial = '0' then
                next_state <= s_init; 
            else
                next_state <= s_1;
            end if;
            
        elsif current_state = s_1 then
            if data_serial = '0' then
                next_state <= s_10;
            else
                next_state <= s_1; 
            end if;
              
        elsif current_state = s_10 then
            if data_serial = '0' then
                next_state <= s_init;   
            else
                next_state <= s_101;
            end if;
        
        elsif current_state = s_101 then 
            if data_serial = '0' then
                next_state <= s_10;
                data_out <= '1';
            else
                next_state <= s_1;
            end if;
            
        end if;
        
        
        
    end process;

end behavioural;
