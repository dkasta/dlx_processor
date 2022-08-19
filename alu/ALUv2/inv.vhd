library IEEE;
use IEEE.std_logic_1164.all; 

entity iv is
	Port ( A: in std_logic;
	       Y: out std_logic);
end iv;

architecture behavioral of iv is

begin
	Y <= not(A);
	
end behavioral;

