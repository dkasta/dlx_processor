library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use WORK.globals.all;


entity adder_sub is
	generic (N: integer := 32);
	port (A: In	std_logic_vector(N-1  downto 0);
		  B: In	std_logic_vector(N-1  downto 0);
		  Ci: In std_logic;
		  Cout: Out	std_logic;
    Sum: out std_logic_vector(N-1 downto 0));
end adder_sub;


architecture struct of adder_sub is


component p4_adder is
		generic (NBIT: integer;
			     NBIT_PER_BLOCK: integer);
		port (A: in std_logic_vector(NBIT-1 downto 0);
		      B: in std_logic_vector(NBIT-1 downto 0);
		      Cin: in std_logic;
		      S: out std_logic_vector(NBIT-1 downto 0);
		      Cout: out std_logic);
end component;

component generic_xor is
    generic (N: integer := 32);
    port (A: in std_logic_vector (N-1 downto 0);
          B: in std_logic;
          Y: out std_logic_vector (N-1 downto 0));
end component;

signal B_in: std_logic_vector(NBIT-1 downto 0);

begin

xor_g : generic_xor generic map (N) port map (B, Ci, B_in);
add : p4_adder generic map (NBIT, NBIT_PER_BLOCK) port map (A, B_in, Ci, Sum, Cout);

end struct;
