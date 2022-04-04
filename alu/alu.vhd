library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.constants.all;

entity alu is
	generic ( NBIT: integer);
	 port (   In_OP: in std_logic_vector(NBIT_OPCODE-1 downto 0);
	           In_A: in std_logic_vector(NBIT - 1 downto 0);
	           In_B: in std_logic_vector(NBIT - 1 downto 0);
	        Out_DATA: out std_logic_vector(NBIT - 1 downto 0));
end alu;

architecture structural of alu is
	
	--------------------------------------------------------------

	component P4_adder is
		generic ( NBIT: integer;
			  NBIT_PER_BLOCK: integer);
		port ( A: in std_logic_vector(NBIT - 1 downto 0);
		       B: in std_logic_vector(NBIT - 1 downto 0);
		       Cin: in std_logic;
		       S: out std_logic_vector(NBIT - 1 downto 0);
		       Cout: out std_logic);
	end component P4_adder;

	-------------------------------------------------------------

	-- adder signals
	signal C_IN:	std_logic;
	signal B_ADDER:	std_logic_vector(NBIT - 1 downto 0);
	signal SUM:	std_logic_vector(NBIT - 1 downto 0);
	signal C_OUT:	std_logic;


begin

	-- sum 
	B_ADDER	<= In_B when In_OP = FUNC_ADD;
	C_IN	<= '0' when  In_OP = FUNC_ADD;
	--subtraction
	B_ADDER	<= NOT In_B when In_OP = FUNC_SUB;
	C_IN	<= '1' when  In_OP = FUNC_SUB;

	adder: P4_adder
		generic map (NBIT => NBIT, NBIT_PER_BLOCK => NBIT_PER_BLOCK)
		port map (A => In_A, B => B_ADDER, Cin => C_IN, S => SUM, Cout => C_OUT);

	
	output_sel: process(SUM)
	begin
		Out_DATA <= (others => '0');
		case In_OP is
			
			when FUNC_ADD | FUNC_SUB => 
				Out_DATA <= SUM;
			when others => null;
		end case;
	end process output_sel;
end structural;

