library IEEE;
use IEEE.std_logic_1164.all;
use work.globals.all;               

entity IVX is
  port ( A: in std_logic;
         Y: out std_logic);
end IVX;

architecture behavioral of IVX is
  begin
    Y <= not(A);
end behavioral;
