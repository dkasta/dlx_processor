library IEEE;
use IEEE.std_logic_1164.all;
use work.globals.all;

entity NAND2 is
  port ( A: in std_logic;
         B: in std_logic;
         Y: out std_logic);
end NAND2;

architecture behavioral of NAND2 is
  begin
    Y <= not (A and B);
end behavioral;
