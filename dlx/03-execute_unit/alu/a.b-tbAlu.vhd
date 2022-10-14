library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;


entity TB_ALU is
end TB_ALU;

architecture TEST of TB_ALU is

	signal s_type_alu_operation: std_logic_vector(ALU_OPC_SIZE-1 downto 0);
	signal s_operand_A: std_logic_vector(NumBitALU-1 downto 0);
	signal s_operand_B: std_logic_vector(NumBitALU-1 downto 0);
	signal s_output: std_logic_vector(NumBitALU-1 downto 0);

	component alu
        port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
              operand_B : in std_logic_vector(NumBitALU-1 downto 0);
              type_alu_operation : in std_logic_vector(ALU_OPC_SIZE-1 downto 0);
              output : out std_logic_vector(NumBitALU-1 downto 0);
              cout : out std_logic);
	end component;
	
begin

	DUT : alu
	Port Map (s_operand_A, s_operand_B, s_type_alu_operation, s_output);
	   testing_proc: process
        begin
    
            s_operand_A <= X"00000007";
            s_operand_B <= X"00000002";
            
            
------------------------------------------------------------------greater------------------------------------------------------------------            
            s_type_alu_operation <= GTOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in GTUOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= GTUOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in GTUOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= GETOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in GTUOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= GETUOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in GTUOP";
            
            wait for 10 ns;
-----------------------------------------------------------------------------------------------------------------------------------------                                               
            
------------------------------------------------------------------lower------------------------------------------------------------------            
            s_type_alu_operation <= LTOP;
            wait for 5 ns;
            assert s_output = X"00000000" report "error in LTOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= LTUOP;
            wait for 5 ns;
            assert s_output = X"00000000" report "error in LTUOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= LETOP;
            wait for 5 ns;
            assert s_output = X"00000000" report "error in LETOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= LETUOP;
            wait for 5 ns;
            assert s_output = X"00000000" report "error in LETUOP";
            
            wait for 10 ns;            
-----------------------------------------------------------------------------------------------------------------------------------------                                               

------------------------------------------------------------------logicals------------------------------------------------------------------   
            s_type_alu_operation <= ANDOP;
            wait for 5 ns;
            assert s_output = X"00000002" report "error in ANDOP";
            
            wait for 10 ns;  

            s_type_alu_operation <= NANDOP;
            wait for 5 ns;
            assert s_output = X"FFFFFFFD" report "error in NANDOP";
            
            wait for 10 ns; 

            s_type_alu_operation <= OROP;
            wait for 5 ns;
            assert s_output = X"00000007" report "error in OROP";
            
            wait for 10 ns;  

            s_type_alu_operation <= NOROP;
            wait for 5 ns;
            assert s_output = X"FFFFFFF8" report "error in NOROP";
            
            wait for 10 ns;  

            s_type_alu_operation <= XOROP;
            wait for 5 ns;
            assert s_output = X"00000005" report "error in XOROP";
            
            wait for 10 ns;              

            s_type_alu_operation <= XNOROP;
            wait for 5 ns;
            assert s_output = X"FFFFFFFA" report "error in XNOROP";

            wait for 10 ns;              
-----------------------------------------------------------------------------------------------------------------------------------------         

------------------------------------------------------------------add/sub/mul------------------------------------------------------------------   
            s_type_alu_operation <= ADDOP;
            wait for 5 ns;
            assert s_output = X"00000009" report "error in ADDOP";
            
            wait for 10 ns;
                        
            s_type_alu_operation <= SUBOP;
            wait for 5 ns;
            assert s_output = X"00000005" report "error in SUBOP";
            
            wait for 10 ns;
            
            s_type_alu_operation <= MULOP;
            wait for 5 ns;
            assert s_output = X"0000000E" report "error in MULOP";
            
            wait for 10 ns;
-----------------------------------------------------------------------------------------------------------------------------------------                                               

------------------------------------------------------------------shift------------------------------------------------------------------            
            s_type_alu_operation <= SLLOP;
            wait for 5 ns;
            assert s_output = X"0000001C" report "error in SLLOP";

            wait for 10 ns;

            s_type_alu_operation <= SRLOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in SRLOP";

            wait for 10 ns;

            s_type_alu_operation <= SRAOP;
            wait for 5 ns;
            assert s_output = X"00000001" report "error in SRAOP";
            wait for 10 ns;
-----------------------------------------------------------------------------------------------------------------------------------------                                               
            
            s_type_alu_operation <= LHIOP;
            wait for 5 ns;
            --assert s_output = X"00000001" report "error in LHIOP";
            
            
            wait;
        end process;
end TEST;