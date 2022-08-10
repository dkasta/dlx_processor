-- read and write ram synchronous memory used as data memory by the dlx memory stage
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity DRAM is
  port(clk : IN std_logic;
       address : IN std_logic_vector(BIT_DRAM-1 downto 0);
       data_in : IN std_logic_vector(BIT_DRAM-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       data_out : OUT std_logic_vector(BIT_DRAM-1 downto 0);
       address_error : OUT std_logic);
end DRAM;

architecture BEHAVIORAL of DRAM is

    type memory_matrix is array(BIT_DRAM-1 downto 0) of std_logic_vector(BIT_DRAM-1 downto 0); -- define dram matrix
    signal data : memory_matrix := (others => (others => '0')); -- Initialize my data memory to 0;
  
    begin
        read_and_write: process (clk)
        begin
            if rising_edge(clk) then
                if Reset = '1' then
                    -- Synchronous reset to clear memory
                    data  <= (others => (others => '0'));
                    data_out <= (others => '0');
                    address_error <= '0';
                elsif write_enable = '1' then -- Synchronous Write
                    data(to_integer(unsigned(address))) <= data_in;
                    address_error <= '0';
                elsif read_enable = '1' then
                    data_out <= data(to_integer(unsigned(address)));
                end if;
            end if;
   end process;

  end BEHAVIORAL;
