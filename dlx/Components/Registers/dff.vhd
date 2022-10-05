-- positive edge triggered flip flop D with syncronous reset
library ieee;
use ieee.std_logic_1164.all;

entity DFF is
	Port (	D :		in	std_logic;
			CK :	in	std_logic;
			RESET :	in	std_logic;
			ENABLE : in std_logic;
			Q :		out	std_logic);
end DFF;

architecture behavioral of DFF is 				
	begin
		Process_synch : process(CK,RESET)
						begin
	  						if CK'event and CK='1' then 	
	    					if RESET='1' then 
	      						Q <= '0';
	    					else
								if ENABLE = '1' then 
	      							Q <= D;
								else
									Q <= '0'; 
								end if;
	    					end if;
	  						end if;
						end process;
end behavioral;

