library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;


entity ADDRESSCOMPARATOR is
    generic ( ADDRESS_BIT : integer := NumBitAddress);
        port ( write_address : in std_logic_vector(ADDRESS_BIT-1 downto 0);
               read_address : in std_logic_vector(ADDRESS_BIT-1 downto 0);
               write_enable : in std_logic;
               mux_sel : out std_logic);
end ADDRESSCOMPARATOR;

architecture BEHAVIOURAL of ADDRESSCOMPARATOR is
begin

    proc: process(write_address, read_address, write_enable) 
        begin
            if(write_address = read_address) and (write_enable = '1') then
                mux_sel <= '1';
            else
                mux_sel <= '0';
            end if;
    end process;

end BEHAVIOURAL;
