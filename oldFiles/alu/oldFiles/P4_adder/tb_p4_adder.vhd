library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.constants.all;

entity tb_p4_adder is
end tb_p4_adder;

architecture test of tb_p4_adder is
	component P4_adder is
		generic (NBIT:	integer;
			 NBIT_PER_BLOCK: integer);
		port ( A: in std_logic_vector(NBIT-1 downto 0);
			B : in	std_logic_vector(NBIT-1 downto 0);
			Cin : in std_logic;
			S : out	std_logic_vector(NBIT-1 downto 0);
			Cout :	out std_logic);
	end component;
   
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Cin : std_logic := '0';
   signal S : std_logic_vector(31 downto 0);
   signal Cout : std_logic;
	
begin
adder: P4_adder generic map(NBIT, NBIT_PER_BLOCK) 
	port map (A=>A, B=>B, Cin=>Cin, S=>S, Cout => Cout);
	
proc: process 

   begin		
      wait for 10 ns;
	
		Cin <= '0';
		A <= x"00000001";
		B <= x"00000001";
		wait for 10 ns;

		Cin <= '1';
		A <= x"00000000";
		B <= x"00000000";
		wait for 10 ns;
		
-- Test special case: cin=1, a=-1, b=0
		Cin <= '1';
		A <= x"FFFFFFFF";
		B <= x"00000000";
		wait for 10 ns;

		Cin <= '0';
		A <= x"FFFFFFFF";
		B <= x"00000000";
		wait for 10 ns;

-- Test special case: cin =1, a=-65536, b=65535
		Cin <= '1';
		A <= x"FFFF0000";
		B <= x"0000FFFF";
		wait for 10 ns;	
		
		Cin <= '0';
		A <= x"0000BA0E";
		B <= x"0000AD00";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"0000FF0E";
		B <= x"0000FFF0";
		wait for 10 ns;
		
		Cin <= '1';
		A <= x"000FFF0E";
		B <= x"00F10050";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"0000BC9E";
		B <= x"000065F0";
		wait for 10 ns;
		
		Cin <= '1';
		A <= x"0000FFFF";
		B <= x"0000FFFF";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"0020FF0E";
		B <= x"0010CCF0";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"00F0BB0E";
		B <= x"00F0CCF0";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"0F00670E";
		B <= x"0FF076F0";
		wait for 10 ns;

		Cin <= '1';
		A <= x"0F00BB0E";
		B <= x"0FF0AAFA";
		wait for 10 ns;
		
		Cin <= '0';
		A <= x"FFFFFFFF";
		B <= x"FFFFFFFF";
		wait for 10 ns;
		
      wait;
   end process;
end test;

