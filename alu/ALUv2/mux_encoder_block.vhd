library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- The entity encoder_block implements the Booth's Algorithm Look Up Table and the
-- associated 5x1 multiplexer.
-- Logical left is used in order to perform moltiplication by 2.

-- The amount of needed left shift is defined usign OFFSET variable
-- in particular, according to the value of 2*i (where i goes from 0 to N/2 - (number of needed Adders)), 
-- OFFSET assumes values: 0,4,16,64... note that, wherever it is needed, OFFSET+1 is calculated in order to
-- perform intermediate values like 2,8,32

-- sel signal, generated from the encoder, is used to select the correct operation operations
-- according to LUT Booth's algorithm 

-- Whenever it is needed to generate a neagtive value, a NOT operaration is performed along with the setting of carry to 1 so that
-- the rca can implement a sum in 2's complement.

entity mux_encoder_block is

	generic (N: integer := 16; OFFSET: integer := 0);

	port (A: in	std_logic_vector(N-1 downto 0);
		  sel: in std_logic_vector(2 downto 0);
		  output: out std_logic_vector(N-1 downto 0);
		  carry: out std_logic);

end mux_encoder_block;

architecture behavioral of mux_encoder_block is

begin

	encode: process(A, sel)
		 --temporary signals are used to perform intermediate operations on A operands
		 --in particular tmp_sig_A operates a conversion to make shifting possible 
		 variable tmp_sig_A, tmp_sig_output: unsigned(N-1 downto 0);

	begin

		case(sel) is
			--when sel is 000 or 111, the output is 0
			when "000" | "111" 	=>
				output <= (others=>'0'); 
				carry <= '0';

			--when sel is 001 or 010, the output is +A/+4A/+16A/+64A...
			when "001" | "010" 	=>
				tmp_sig_A := unsigned(A);
				tmp_sig_output := tmp_sig_A sll OFFSET;
				output <= std_logic_vector(tmp_sig_output);
				carry <= '0';

			--when sel is 011, the output is +2A/+8A/+32A/+128A...
			when "011" =>
				tmp_sig_A := unsigned(A);
				tmp_sig_output := tmp_sig_A sll (OFFSET + 1);
				output <= std_logic_vector(tmp_sig_output);
				carry <= '0';

			--when sel is 101 or 110, the output is -A/-4A/-16A/-64A...
			when "101" | "110" 	=>
				tmp_sig_A := unsigned(A);
				tmp_sig_output := tmp_sig_A sll OFFSET;
				output	<= not std_logic_vector(tmp_sig_output);
				carry	<= '1';								
								
			--when sel is 100, the output is -2A/-8A/-32A/-128A...
			when "100" =>
				tmp_sig_A := unsigned(A);
				tmp_sig_output := tmp_sig_A sll (OFFSET + 1);
				output <= not std_logic_vector(tmp_sig_output);	
				carry	<= '1';								

			when others => null;

		end case;
	end process;
end behavioral;

