library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity encoder is
    generic (N: integer:= Windows_Bit);
	port( 
		  SEL : in std_logic_vector(N-1 downto 0);
		  S : out std_logic_vector(2**N-1 downto 0));
end encoder;

architecture COMPOR of encoder is
begin
	process(sel)
	begin
        S<=(to_integer(unsigned(sel)) =>'1', others=>'0');
	end process;
end COMPOR;