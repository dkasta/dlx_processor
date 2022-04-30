library ieee;
use ieee.std_logic_1164.all;

entity DFF is
	Port (	D :		in	std_logic;
			CK :	in	std_logic;
			RESET :	in	std_logic;
			Q :		out	std_logic);
end DFF;

architecture behavioral of DFF is 				-- flip flop D with syncronous reset
	begin
		Process_synch : process(CK,RESET)
						begin
	  						if CK'event and CK='1' then 	-- positive edge triggered:
	    					if RESET='1' then 				-- active high reset
	      						Q <= '0';
	    					else
	      						Q <= D; 		-- input is written on output
	    					end if;
	  						end if;
						end process;
end behavioral;

