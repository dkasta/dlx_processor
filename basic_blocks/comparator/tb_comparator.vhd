library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity tb_comparator is
end tb_comparator;

architecture Behavioral of tb_comparator is

component comparator
  generic (NBIT: integer := 32);
  port (C : in std_logic;
       sum : in std_logic_vector(NBIT-1 downto 0);
       sign : in std_logic;
       gt : out std_logic;
       get : out std_logic;
       lt : out std_logic;
       let : out std_logic;
       eq : out std_logic;
       neq : out std_logic);
       
end component;

signal C_s, sign_s, gt_s, get_s, lt_s, let_s, eq_s, neq_s : std_logic;
signal sum_s : std_logic_vector(32-1 downto 0);

begin

CompToTest: comparator port map (C_s, sum_s, sign_s, gt_s, get_s, lt_s, let_s, eq_s, neq_s);


proc: process
    begin
    
        sum_s <= "00000000000000000000000000001011";
        sign_s <= '1';
        C_s <= '0';
    
        wait for 3 ns;
        
        sum_s <= "00000000000000000000000000001110";
        sign_s <= '0';
        C_s <= '0';
        
        wait for 3 ns;
        
        sum_s <= "00000000000000000000000000000000";

    
    
        wait;
        
end process;

end Behavioral;
