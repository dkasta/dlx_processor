library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.constants.all; -- libreria WORK user-defined

entity CSblock is
	generic(NBIT_PER_BLOCK: integer);
	Port(   A: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	        B: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	      Cin: in std_logic;
	        S: out std_logic_vector(NBIT_PER_BLOCK-1 downto 0));
end entity CSblock;

architecture structural of CSblock is
	component rca is
	generic (NBIT_PER_BLOCK :  integer);
	Port (  A: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	        B: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	       Ci: in std_logic;
		S: out std_logic_vector(NBIT_PER_BLOCK-1 downto 0));
	end component rca;

	component mux21 is
	generic(NBIT_PER_BLOCK: integer);
	Port (  A: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	        B: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	      SEL: in std_logic;
		Y: out std_logic_vector(NBIT_PER_BLOCK-1 downto 0));
	end component mux21;

 signal RCA1toMUX, RCA2toMUX: std_logic_vector(NBIT_PER_BLOCK-1 downto 0);

begin

	RCA1: rca generic map(NBIT_PER_BLOCK) port map(A, B, '0', RCA1toMUX);
	RCA2: rca generic map(NBIT_PER_BLOCK) port map(A, B, '1', RCA2toMUX);
       MUX21_LABEL: mux21 generic map(NBIT_PER_BLOCK) port map (RCA2toMUX, RCA1toMUX, Cin, S);

end architecture;


