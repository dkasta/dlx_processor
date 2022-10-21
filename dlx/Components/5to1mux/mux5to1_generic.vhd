library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity MUX51_GENERIC is
generic( NBIT : integer := BIT_RISC);
port( A      : in  std_logic_vector(NBIT-1 downto 0);
      B      : in  std_logic_vector(NBIT-1 downto 0);
      C      : in  std_logic_vector(NBIT-1 downto 0);
      D      : in  std_logic_vector(NBIT-1 downto 0);
      E      : in  std_logic_vector(NBIT-1 downto 0);
      SEL    : in  std_logic_vector(2 downto 0);
      Y      : out std_logic_vector(NBIT-1 downto 0));
end MUX51_GENERIC;

architecture behavioural of MUX51_GENERIC is

begin
FIVETOONEMUX : process(A,B,C,D,E,SEL)
begin
  case SEL is
    when "000" => Y <= A ;
    when "101" => Y <= B ;
    when "110" => Y <= C ;
    when "111" => Y <= D ;
    when "011" => Y <= E ;
    when others => Y <= (others => '0');
  end case;
end process FIVETOONEMUX;
end behavioural;