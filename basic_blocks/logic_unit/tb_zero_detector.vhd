library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_zero_detector is
end tb_zero_detector;

architecture Behavioral of tb_zero_detector is

component zero_detector

    generic (N_BIT: integer := 4);

    port (A : in std_logic_vector(4-1 downto 0);
          Y : out std_logic);

end component;

signal A_s: std_logic_vector(4-1 downto 0);
signal Y_s: std_logic;

begin

CompToTest: zero_detector port map (A_s, Y_s);

   proc: process
        begin
        
            A_s <= "1111";
            
            wait for 5 ns;
            
            A_s <= "1001";

            wait for 5 ns;
            
            A_s <= "0000";

            wait;
            
    end process;


end Behavioral;