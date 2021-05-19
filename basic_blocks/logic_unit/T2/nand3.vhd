library ieee;
use ieee.std_logic_1164.all;

entity NAND3 is
  port(A, B, C : in  std_logic;
       Y 	   : out std_logic);
end entity;

architecture structural of NAND3 is

  component IVX
      port(A : in  std_logic;
           Y : out std_logic);
  end component;
  
  component NAND2
      port(A, B : in  std_logic;
           Y 	: out std_logic);
  end component;
  
  signal s1, s2: std_logic;
  
begin

  NAND_D  : NAND2 port map (A, B, s1);
  IVX_E   : IVX port map (s1, s2);
  NAND_Y  : NAND2 port map (s2, C, Y);
  
end architecture;
