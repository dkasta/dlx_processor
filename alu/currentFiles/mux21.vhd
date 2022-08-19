library IEEE;
use IEEE.std_logic_1164.all;

entity mux21 is
	generic (NBIT_PER_BLOCK: integer);
	Port (A: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
          B: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	      SEL: in std_logic;
		  Y: out std_logic_vector(NBIT_PER_BLOCK-1 downto 0));
end mux21;

architecture structural of mux21 is

	component n_and
	     Port( A: in std_logic;
		   B: in std_logic;
	    	   Y: out std_logic);
	end component;

	component iv
		Port ( A: in std_logic;
		       Y: out std_logic);
	end component;

	signal y1, y2: std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	signal sb: std_logic;

begin

	UIV : iv Port Map ( sel, sb);

	C1:for i in 0 to NBIT_PER_BLOCK-1 generate
	     UND1 : n_and Port Map( A(i), SEL, y1(i));
	     UND2 : n_and Port Map( B(i), sb, y2(i));
	     UND3 : n_and Port Map( y1(i), y2(i), Y(i));
	   end generate;

end structural;

