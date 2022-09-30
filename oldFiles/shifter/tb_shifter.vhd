library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb is
end tb;

architecture Behavioral of tb is

component shifter
	port(A : in std_logic_vector(32-1 downto 0);
	     B : in std_logic_vector(32-1 downto 0);
	     sel : in std_logic_vector(1 downto 0);
	     C : out std_logic_vector(32-1 downto 0));
end component;

signal A_s, B_s, C_s : std_logic_vector(32-1 downto 0);
signal sel_s: std_logic_vector(1 downto 0);

begin

comptotest: shifter port map (A_s, B_s, sel_s, C_s);


process
begin
    
    A_s <= "00000000000000000000000000000101";
    B_s <= "00000000000000000000000000000001";
    sel_s <= "00";

    
    wait for 10 ns;
        
        
    A_s <= "00000000000000000000000000000101";
    B_s <= "00000000000000000000000000000001";
    sel_s <= "01";

    
    wait for 10 ns;
    
    
    
    A_s <= "10000000000000000000000001100000";
    B_s <= "00000000000000000000000000000100";
    sel_s <= "10";

    
    wait;
    
    
end process;



end Behavioral;
