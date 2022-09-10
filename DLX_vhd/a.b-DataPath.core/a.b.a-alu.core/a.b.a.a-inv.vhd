library ieee;
use ieee.std_logic_1164.all;

entity IVX is

  port(A : in  std_logic;
       Y : out std_logic);
       
end entity;

architecture Behavioral of IVX is
  begin
  
    Y <= not A;
    
end architecture;
