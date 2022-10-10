--- positive edge triggered flip flop D with syncronous reset
library ieee;
use ieee.std_logic_1164.all;

entity DFF_wrf is
	Port (	D :		in	std_logic;
		EN:	in std_logic;
			CK :	in	std_logic;
			RESET :	in	std_logic;
			Q :		out	std_logic);
end DFF_wrf;

architecture behavioral of DFF_wrf is 				
	begin
		Process_synch : process(CK,RESET)
						begin
	  					if rising_edge(CK) then 	
	    						if RESET='1' then 
	      							Q <= '0';
	    						elsif(EN ='1')then
	      							Q <= D; 
	    						end if;
	  					end if;
				end process;
end behavioral;




