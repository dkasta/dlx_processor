library ieee;
use ieee.std_logic_1164.all;

entity NAND2 is

  port(A, B : in  std_logic;
       Y 	: out std_logic);
       
end entity;

architecture behevioral of NAND2 is
    begin

        Y <= A nand B;
        
end architecture;
