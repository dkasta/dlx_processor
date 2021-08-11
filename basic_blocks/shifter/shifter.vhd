library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-- The T2 shifter is organized in three levels. The first level prepares 8 possible "masks", each already
-- shifted of 0,8,16 left or right. The second level performs a coarse grain shift, that is it chooses 
-- among the 8 masks the nearest to the shift to be applied. The choice is operated using bit 5,4,3 of operand B
-- The third level receives such mask and implements the real shift according to bits 2,1,0 of operand B.

--signal sel selects the type of shifting operations:
--00: shift logic left (SLL SLLI)
--01: shift logic right (SRL SRLI)
--10: shift arithmetic right (SRA SRAI)


entity shifter is
	port(A : in std_logic_vector(32-1 downto 0);
	     B : in std_logic_vector(32-1 downto 0);
	     sel : in std_logic_vector(1 downto 0);
	     C : out std_logic_vector(32-1 downto 0));
end shifter;


architecture struct of shifter is

component first_level is
	port(A : in std_logic_vector(32-1 downto 0);
	     sel : in std_logic_vector(1 downto 0);
	     mask00 : out std_logic_vector(38 downto 0);
	     mask08 : out std_logic_vector(38 downto 0);
	     mask16 : out std_logic_vector(38 downto 0));
end component;


component second_level is
	port(sel : in std_logic_vector(1 downto 0);
	     mask00 : in std_logic_vector(38 downto 0);
	     mask08 : in std_logic_vector(38 downto 0);
	     mask16 : in std_logic_vector(38 downto 0);
	     Y : out std_logic_vector(38 downto 0));
end component;


component third_level is
	port(sel : in std_logic_vector(2 downto 0);
	     A : in std_logic_vector(38 downto 0);
	     Y : out std_logic_vector(32-1 downto 0));
end component;

signal m0, m8, m16, y : std_logic_vector(38 downto 0);
signal s3 : std_logic_vector(2 downto 0);

begin

	process(sel, s3, B, A)
		begin
		
		case sel is
		
            when "00" => 
              s3 <= B(2 downto 0);
              
            when "01" => 
              s3 <= not(B(2 downto 0));
              
            when "10" =>
              s3 <= not(B(2 downto 0));
            
            when others => 
              s3 <= "XXX";
		  
		end case;
	end process;

first : first_level port map(A, sel, m0, m8, m16);
second : second_level port map(B(4 downto 3), m0, m8, m16, y);
third : third_level port map(s3, y, C);

end struct;
