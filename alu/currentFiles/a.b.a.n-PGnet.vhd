library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PGnet is
	port(a: in std_logic;
	     b: in std_logic;
	     pg: out std_logic_vector(1 downto 0));
end PGnet;

architecture behavioral of PGnet is
begin
	pg(1) <= a xor b;	--P
	pg(0) <= a and b;	--G
end behavioral;
