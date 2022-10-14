library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity MUX31_GENERIC is
generic( NBIT : integer := BIT_RISC);
port( A      : in  std_logic_vector(NBIT-1 downto 0);
      B      : in  std_logic_vector(NBIT-1 downto 0);
      C      : in  std_logic_vector(NBIT-1 downto 0);
      SEL    : in  std_logic_vector(1 downto 0);
      Y      : out std_logic_vector(NBIT-1 downto 0));
end MUX31_GENERIC;

architecture behavioural of MUX31_GENERIC is

begin
THREETOONEMUX : process(A,B,C,SEL)
begin
  case SEL is
    when "00" => Y <= A ;
    when "01" => Y <= B ;
    when "10" => Y <= C ;
    when others => Y <= (others => '0');
  end case;
end process THREETOONEMUX;
end behavioural;