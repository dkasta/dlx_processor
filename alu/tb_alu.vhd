library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.constants.all;

entity tb_alu is
end tb_alu;

architecture test of tb_alu is

	component alu is
		generic (NBIT:	integer);
		port ( In_OP: in std_logic_vector(NBIT_OPCODE-1 downto 0);
	           	In_A: in std_logic_vector(NBIT - 1 downto 0);
	           	In_B: in std_logic_vector(NBIT - 1 downto 0);
	       	    Out_DATA: out std_logic_vector(NBIT - 1 downto 0));
	end component;
   
   signal signal_In_OP : std_logic_vector(NBIT_OPCODE-1 downto 0);
   signal signal_In_A : std_logic_vector(NBIT-1 downto 0) := (others => '0');
   signal signal_In_B : std_logic_vector(NBIT-1 downto 0) := (others => '0');
   signal signal_Out_DATA: std_logic_vector(NBIT-1 downto 0) := (others => '0');
	
begin
alutest : alu generic map(NBIT) 
	port map (In_OP => signal_In_OP, In_A => signal_In_A, In_B => signal_In_B, Out_DATA => signal_Out_DATA);
	
proc: process 

   begin		
      wait for 10 ns;
		
		signal_In_OP <= "00000000001"; 
		signal_In_A <= x"00000001";
		signal_In_B <= x"00000001";
		wait for 10 ns;
		
		signal_In_OP <= "00000000010"; 
		signal_In_A <= x"00000001";
		signal_In_B <= x"00000001";
		wait for 10 ns;
	
		
      wait;
   end process;
end test;

