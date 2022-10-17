library IEEE;
use IEEE.std_logic_1164.all;
USE WORK.GLOBALS.ALL;
entity AND2 is
  port ( A: in std_logic_vector(NumBitData-1 downto 0);
         B: in std_logic;
         Y: out std_logic_vector(NumBitData-1 downto 0));
end AND2;

architecture behavioral of AND2 is
  begin
    Y <= (A and (NumBitData-1 downto 0=> B));
end behavioral;
