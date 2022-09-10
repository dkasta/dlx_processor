library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;

entity rca is
	generic (NBIT_PER_BLOCK:  integer);
	Port (A: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
		  B: in std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
	      Ci: in std_logic;
		  S: out std_logic_vector(NBIT_PER_BLOCK-1 downto 0));
end rca;

architecture structural of rca is

  signal STMP: std_logic_vector(NBIT_PER_BLOCK-1 downto 0);
  signal CTMP: std_logic_vector(NBIT_PER_BLOCK downto 0);

  component fa
  Port (A: in std_logic;
	    B: in std_logic;
	    Ci: in std_logic;
	    S: out std_logic;
	   Co: out std_logic);
  end component;

begin

  CTMP(0) <= Ci;
  S <= STMP;

  ADDER1: for i in 1 to NBIT_PER_BLOCK generate
    	FAI : fa Port Map (A(i-1), B(i-1), CTMP(i-1), STMP(i-1), CTMP(i));
  end generate;

end;



