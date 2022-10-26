library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity MUX2TO1BRANCH is
generic( NBIT : integer := BIT_RISC);
port( A      : in  std_logic_vector(NBIT-1 downto 0);
      B      : in  std_logic_vector(NBIT-1 downto 0);
      SEL    : in  std_logic_vector(2 downto 0);
      Y      : out std_logic_vector(NBIT-1 downto 0));
end MUX2TO1BRANCH;

architecture behavioural of MUX2TO1BRANCH is

begin
MUXTWOTOONEBRANCH : process(A,B,SEL)
begin
  case SEL is
    when "111" => Y <= B ;
    when others => Y <= A;
  end case;
end process MUXTWOTOONEBRANCH;
end behavioural;