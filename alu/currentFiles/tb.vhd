library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes1.all;


entity TB_ALU is
end TB_ALU;

architecture TEST of TB_ALU is

	signal s_type_alu_operation: aluOp;
	signal s_operand_A: std_logic_vector(NumBitALU-1 downto 0);
	signal s_operand_B: std_logic_vector(NumBitALU-1 downto 0);
	signal s_output: std_logic_vector(NumBitALU-1 downto 0);

	component alu
        port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
              operand_B : in std_logic_vector(NumBitALU-1 downto 0);
              type_alu_operation : in aluOp;
              output : out std_logic_vector(NumBitALU-1 downto 0);
              cout : out std_logic);
	end component;
	
begin

	DUT : alu
	Port Map (s_operand_A, s_operand_B, s_type_alu_operation, s_output);
	   testing_proc: process
        begin
    
            s_operand_A <= X"00000002";
            s_operand_B <= X"00000007";
            
            
            s_type_alu_operation <= GTUOP;
            wait for 5 ns;
            assert s_output = X"0000" report "error in GTUOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= ADDOP;
            wait for 5 ns;
            assert s_output = X"00000009" report "error in ADDOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= SUBOP;
            wait for 5 ns;
            assert s_output = X"FFFFFFFB" report "error in SUBOP";

            s_type_alu_operation <= MULOP;
            wait for 5 ns;
            assert s_output = X"0000000E" report "error in MULOP";



            wait;
        end process;
end TEST;