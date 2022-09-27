library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity MUX21_GENERIC is
  generic( NBIT : integer := Bit_Mux21);
  port(    A:   in std_logic_vector(NBIT-1 downto 0);
           B:   in std_logic_vector(NBIT-1 downto 0);
           SEL: in std_logic;
           Y:   out std_logic_vector(NBIT-1 downto 0));
end MUX21_GENERIC;

architecture structural of MUX21_GENERIC is

  signal SEL_INV : std_logic_vector(NBIT-1 downto 0);
  signal NAND_ONE_OUT : std_logic_vector(NBIT-1 downto 0);
  signal NAND_TWO_OUT : std_logic_vector(NBIT-1 downto 0);

  component NAND2
  port( A: in std_logic;
        B: in std_logic;
        Y: out std_logic);
  end component;

  component IVX
  port( A: in std_logic;
        Y: out std_logic);
  end component;

   begin

     MUX_GENERATE : for i in 0 to NBIT-1 generate
       UIV : IVX
       port map(SEL,SEL_INV(i));
       UND1 : NAND2
       port map(A(i),SEL_INV(i),NAND_ONE_OUT(i));
       UND2 : NAND2
       port map(B(i),SEL,NAND_TWO_OUT(i));
       UND3 : NAND2
       port map(NAND_ONE_OUT(i),NAND_TWO_OUT(i),Y(i));
    end generate MUX_GENERATE;

end structural;

