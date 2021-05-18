library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_unit is

    generic (N: integer := 32);
    
    Port (logic_op_A, logic_op_B    : in  STD_LOGIC_VECTOR(N-1 downto 0);  
          logic_sel                 : in  STD_LOGIC_VECTOR(2 downto 0);
          logic_output              : out  STD_LOGIC_VECTOR(N-1 downto 0));
        
end logic_unit;

architecture Behavioral of logic_unit is

begin

    process(logic_op_A, logic_op_B, logic_sel)
        begin
            case(logic_sel) is
            
                when "000" => -- AND op
                    logic_output <= logic_op_A AND logic_op_B;
                when "001" => -- OR op
                    logic_output <= logic_op_A OR logic_op_B;
                when "010" => -- XOR op
                    logic_output <= logic_op_A XOR logic_op_B;
                when "011" => -- NOR op
                    logic_output <= logic_op_A NOR logic_op_B;
                when "100" => -- NAND op
                    logic_output <= logic_op_A NAND logic_op_B;
                when "101" => -- XNOR op
                    logic_output <= logic_op_A XNOR logic_op_B;
                when others => 
                    logic_output <= (others => '0');
        
             end case;
 end process;
 
end Behavioral;
