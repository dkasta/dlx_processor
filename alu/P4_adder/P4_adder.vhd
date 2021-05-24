library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.constants.all;

entity P4_adder is
		generic ( NBIT: integer;
			  NBIT_PER_BLOCK: integer);
		port (  A: in std_logic_vector(NBIT-1 downto 0);
		        B: in std_logic_vector(NBIT-1 downto 0);
		      Cin: in std_logic;
		        S: out std_logic_vector(NBIT-1 downto 0);
		     Cout: out std_logic);
end P4_adder;

architecture structural of P4_adder is

	component carry_generator is
		generic( NBIT: integer;
			 NBIT_PER_BLOCK : integer;
			 NBLOCKS: integer);
		port(  A: in std_logic_vector(NBIT-1 downto 0);
		       B: in std_logic_vector(NBIT-1 downto 0);
		     Cin: in std_logic;
		      Co: out std_logic_vector((NBIT/NBIT_PER_BLOCK)-1 downto 0));
	end component carry_generator;

	component sum_generator is
		generic( NBIT_PER_BLOCK: integer;
			 NBLOCKS: integer);
		port( A: in std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
		      B: in std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0);
		     Ci: in std_logic_vector(NBLOCKS-1 downto 0);
	       	      S: out std_logic_vector(NBIT_PER_BLOCK*NBLOCKS-1 downto 0));
 	end component sum_generator;


signal carry_to_sum, to_sum: std_logic_vector(NBLOCKS-1 downto 0);

begin
	to_sum <= carry_to_sum(NBLOCKS-2 downto 0)&Cin;

	carry_gen:  carry_generator generic map(NBIT, NBIT_PER_BLOCK, NBLOCKS) port map(A, B, Cin, carry_to_sum); --the MSB of carry_out output is fed as Cout of h etop elvel entity
        sum_gen:   sum_generator generic map(NBIT_PER_BLOCK, NBLOCKS) port map(A, B, to_sum, S);

	Cout <= carry_to_sum(NBLOCKS-1);

end structural;
