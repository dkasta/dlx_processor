library IEEE;
use IEEE.std_logic_1164.all;
use work.globals.all;               

entity IV is
  port ( A: in std_logic;
         Y: out std_logic);
end IV;

architecture behavioral of IV is
  begin
    Y <= not(A);
end behavioral;
