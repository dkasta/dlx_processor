library IEEE;
use IEEE.std_logic_1164.all;
use work.globals.all;

entity ND2 is
  port ( A: in std_logic;
         B: in std_logic;
         Y: out std_logic);
end ND2;

architecture behavioral of ND2 is
  begin
    Y <= not (A and B);
end behavioral;
