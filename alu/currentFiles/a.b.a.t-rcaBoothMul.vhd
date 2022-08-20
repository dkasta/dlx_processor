library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rca_booth is 

	generic (NBIT :  Integer := 16);

	port (A: in	std_logic_vector(NBIT-1 downto 0);
		  B: in	std_logic_vector(NBIT-1 downto 0);
          Ci: in std_logic;
          S: out std_logic_vector(NBIT-1 downto 0);
          Co: out std_logic);
end rca_booth; 


architecture BEHAVIORAL of rca_booth is
  
  signal s1 : std_logic_vector(NBIT downto 0);

begin
  
  s1 <= (('0' & A) + ('0' & B) + ("0000" & Ci));
  S <= s1(NBIT-1 downto 0);
  Co <= s1(NBIT);

end BEHAVIORAL;

