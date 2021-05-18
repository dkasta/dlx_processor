library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_logic_unit is
end tb_logic_unit;

architecture Behavioral of tb_logic_unit is

component logic_unit

    generic (N: integer := 4);
    
    port (logic_op_A, logic_op_B    : in  std_logic_vector(N-1 downto 0);  
          logic_sel                 : in  std_logic_vector(2 downto 0);
          logic_output              : out  std_logic_vector(N-1 downto 0));
         
end component;

signal logic_op_A_s, logic_op_B_s, logic_output_s: std_logic_vector(4-1 downto 0);
signal logic_sel_s: std_logic_vector(2 downto 0);

begin

CompToTest: logic_unit port map (logic_op_A_s, logic_op_B_s, logic_sel_s, logic_output_s);
    proc: process
        begin
        
            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "000";    -- AND op
            
            wait for 5 ns;
            
            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "001";    -- OR op
            
            wait for 5 ns;

            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "010";    -- XOR op
            
            wait for 5 ns;
            
            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "011";    -- NOR op
            
            wait for 5 ns;

            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "100";    -- NAND op
            
            wait for 5 ns;
            
            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "101";    -- XNOR op
            
            wait for 5 ns;
            
            -- testing a random not available operation
            logic_op_A_s <= "1111";
            logic_op_B_s <= "1001";
            logic_sel_s <= "111";    -- none op
            
            wait;
        

    end process;


end Behavioral;
