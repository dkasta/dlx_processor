library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity second_level is
	port(sel : in std_logic_vector(1 downto 0);
	     mask00 : in std_logic_vector(38 downto 0);
	     mask08 : in std_logic_vector(38 downto 0);
	     mask16 : in std_logic_vector(38 downto 0);
	     Y : out std_logic_vector(38 downto 0));
end second_level;

architecture behav of second_level is

begin 
	process(sel, mask00, mask08, mask16)
		begin
		
		case sel is
		
			when "00" =>
				Y <= mask00;
				
			when "01" =>
				Y <= mask08;
				
			when "10" =>
				Y <= mask16;
				
			when others => 
			     Y <= x"000000000" & "000";
			     
		end case;
	end process;

end behav;
