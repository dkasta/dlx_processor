library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BOOTHMUL is

	generic (N: integer := 16);

	port (A: in	std_logic_vector(N-1 downto 0);
		  B: in std_logic_vector(N-1 downto 0);
		  P: out std_logic_vector(2*N-1 downto 0));

end BOOTHMUL;


architecture arch of BOOTHMUL is	
	--N/2 - 1 = number of adders
	type SignalVector is array (N/2-1 downto 0) of std_logic_vector(2*N-1 downto 0); --matrix signal to connect components
	signal encoder:	std_logic_vector(N downto 0);	--encoder vector
	signal A_in: std_logic_vector(2*N - 1 downto 0):= (others => '0');

	signal mux_sig: SignalVector;	--auxiliary signal for mux outup
	signal sum_sign: SignalVector; --auxiliary signal for rca outup

	-- carry_sig allows signed multiplication by implementing 2's complement without an adder.
	signal carry_sig:	std_logic_vector(N/2-1 downto 0);

	-- A_in_signed allows to have a signed version of first operand A, it allows to make 2's complement operations
	signal A_in_signed:	std_logic_vector(N-1 downto 0);

	-- cout signal allows to use standard version of RCA
	signal cout: std_logic;

	component mux_encoder_block

		generic(N: integer := 16; OFFSET: integer := 0);

		port (A: in	std_logic_vector(N-1 downto 0);
			  sel: in std_logic_vector(2 downto 0);
			  output: out std_logic_vector(N-1 downto 0);
			  carry : out std_logic);

	end component;

	component RCA is 

		generic (NBIT :  Integer := 16);

		port (A: in	std_logic_vector(NBIT-1 downto 0);
			  B: in	std_logic_vector(NBIT-1 downto 0);
		      Ci: in std_logic;
		      S: out std_logic_vector(NBIT-1 downto 0);
		      Co: out std_logic);

	end component; 

begin

	-- According to Booth's algorithm, first bit of encoder vector is 0
	encoder <= B & '0';

	A_in_signed <= (others => A(N-1));
	A_in <= A_in_signed & A; -- A_in is now the signed version of operand A

	adding: for i in 0 to N/2 - 1 generate

		encoding: mux_encoder_block

			generic map(2*N, 2*i) 

			port map (A_in, encoder((2*i+2) downto 2*i), mux_sig(i), carry_sig(i)); -- 2*i+2 downto 2*i allows to take the correct triplet of encoder values
		
		-- First RCA is different from the others, it doesn't receive the output of the prevoius RCA, but only the output of the first multiplexer and its carry
		special_case: if i = 0 generate

						first_rca: RCA

						generic map(2*N)
						port map(mux_sig(i), (others =>'0'), carry_sig(i), sum_sign(i), cout);

		end generate;
			
		-- Standard RCA receives the previous carry output, the mux and its carry
		condition: if i /= 0 generate

						other_rca: RCA 

						generic map(2*N)
						port map(sum_sign(i-1), mux_sig(i), carry_sig(i), sum_sign(i), cout);

		end generate;

	end generate;

	P <= sum_sign(N/2 - 1);

end architecture;


