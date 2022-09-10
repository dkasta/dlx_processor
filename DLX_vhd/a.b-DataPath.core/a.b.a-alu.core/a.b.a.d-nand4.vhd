library ieee;
use ieee.std_logic_1164.all;

entity NAND4 is
  port(A, B, C, D : in  std_logic;
       Y 	   : out std_logic);
end entity;

architecture structural of NAND4 is

component IVX
    port(A : in  std_logic;
         Y : out std_logic);
end component;
  
component NAND2
    port(A,B : in  std_logic;
         Y 	: out std_logic);
end component;
  
signal s1, s2, s3, s4: std_logic;
    begin

      NAND1_1  : NAND2 port map (A, B, s1);
      NAND_2  : NAND2 port map (C, D, s2);
      IVX_1   : IVX port map (s1, s3);
      IVX_2   : IVX port map (s2, s4);
      NAND_3  : NAND2 port map (s3, s4, Y);
  
end architecture;
