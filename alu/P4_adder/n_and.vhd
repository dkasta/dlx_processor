library IEEE;
use IEEE.std_logic_1164.all; 
use WORK.constants.all; 

entity n_and is
	Port ( A: in std_logic;
	       B: in std_logic;
	       Y: out std_logic);
end n_and;


architecture behavioral of n_and is

begin
	Y <= not( A and B);

end behavioral;



