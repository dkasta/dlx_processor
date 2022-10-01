library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_logic_unit_T2 is
end tb_logic_unit_T2;

architecture Behavioral of tb_logic_unit_T2 is

component logic_t2

  generic (NBIT: integer := 32);
    port (R1, R2         : in  std_logic_vector(NBIT-1 downto 0); 
          S0, S1, S2, S3 : in  std_logic;                         
          Y              : out std_logic_vector(NBIT-1 downto 0));
         
end component;

signal R1_s, R2_s, Y_s: std_logic_vector(32-1 downto 0);
signal S0_s, S1_s, S2_s, S3_s: std_logic;

begin

CompToTest: logic_t2 port map (R1_s, R2_s, S0_s, S1_s, S2_s, S3_s, Y_s);
    proc: process
        begin
        
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "11111111111111111111111111111111";
            -- AND op
            S0_s <= '0'; 
            S1_s <= '0';
            S2_s <= '0';
            S3_s <= '1';
            
            wait for 5 ns;
            
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- NAND op
            S0_s <= '1'; 
            S1_s <= '1';
            S2_s <= '1';
            S3_s <= '0';
            
            wait for 5 ns;
            
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- OR op
            S0_s <= '0'; 
            S1_s <= '1';
            S2_s <= '1';
            S3_s <= '1';            
            
            wait for 5 ns;
            
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- NOR op
            S0_s <= '1'; 
            S1_s <= '0';
            S2_s <= '0';
            S3_s <= '0';
                        
            wait for 5 ns;

            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- XOR op
            S0_s <= '0'; 
            S1_s <= '1';
            S2_s <= '1';
            S3_s <= '0';
                        
            wait for 5 ns;
            
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- XNR op
            S0_s <= '1'; 
            S1_s <= '0';
            S2_s <= '0';
            S3_s <= '1';
                        
            wait for 5 ns;
            
            R1_s <= "11111111111111111111111111111111";
            R2_s <= "10000000000000000000000000000001";
            -- testing a random not available operation
            S0_s <= '1'; 
            S1_s <= '1';
            S2_s <= '1';
            S3_s <= '1';
                        
            wait;
        

    end process;


end Behavioral;
