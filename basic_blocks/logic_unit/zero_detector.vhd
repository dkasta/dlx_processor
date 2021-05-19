library ieee;
use ieee.std_logic_1164.all;

entity zero_detector is

 generic (N_BIT: integer := 32);
 
 port (A : in std_logic_vector (N_BIT-1 downto 0);
       Y : out std_logic);
 
end zero_detector;

architecture behavioral of zero_detector is

constant all_zeros : std_logic_vector(A'range) := (others => '0');
    
begin
process(A)
    begin
    
        if (A = all_zeros) then
            Y <= '1';
        else 
            Y <= '0';
        end if;
        
end process;
end behavioral;
