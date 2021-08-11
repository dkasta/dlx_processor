library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity first_level is
	port(A : in std_logic_vector(32-1 downto 0);
	     sel : in std_logic_vector(1 downto 0);
	     mask00 : out std_logic_vector(38 downto 0);
	     mask08 : out std_logic_vector(38 downto 0);
	     mask16 : out std_logic_vector(38 downto 0));
end first_level;

architecture behav of first_level is

	begin 

	process(sel, A)
		begin
		
		case sel is
			when "00" =>
			
				mask00 <= A & "0000000";
				mask08 <= A(23 downto 0) & x"000" & "000";
				mask16 <= A(15 downto 0) & x"00000" & "000";
				
			when "01" =>
			
				mask00 <= "0000000" & A;
				mask08 <= x"000" & "000" & A(31 downto 8);
				mask16 <= x"00000" & "000" & A(31 downto 16) ;
				
			when "10" =>
			
				mask00 <= (38 downto 32 => A(31)) & A;
				mask08 <= (38 downto 24 => A(31)) & A(31 downto 8);
				mask16 <= (38 downto 16 => A(31)) & A(31 downto 16);

			when others => 
			
			     mask00 <= x"000000000" & "000";
				 mask08 <= x"000000000" & "000";
				 mask16 <= x"000000000" & "000";
				 
		end case;
	end process;

end behav;
