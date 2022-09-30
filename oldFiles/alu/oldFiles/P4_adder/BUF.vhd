library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BUF is
	generic(N: integer);
	port(I: in std_logic_vector(N-1 downto 0);
		 O: out std_logic_vector(N-1 downto 0));
end BUF;

architecture behavioral of BUF is
begin
	O <= I;
end behavioral;
