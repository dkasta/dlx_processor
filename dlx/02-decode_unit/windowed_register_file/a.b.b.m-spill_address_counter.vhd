library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.globals.all;

entity address_counter is
    generic(
        N:          integer := NumBitAddress
    );
    port(
        clk:        in std_logic;
        rst:        in std_logic;
        en:         in std_logic;
        ready:      in std_logic;
        done:       out std_logic;
        occupied:    out std_logic;
        addr:       out std_logic_vector(N-1 downto 0)
    );
end address_counter;

architecture struct of address_counter is

    signal curr_addr: std_logic_vector(N-1 downto 0);
    signal next_addr: std_logic_vector(N-1 downto 0);

begin

    process(curr_addr, en)
    begin
        if (en = '1' or (curr_addr /= (N-1 downto 0=>'1'))) then
            next_addr <= std_logic_vector(unsigned(curr_addr)+1);
        end if;

    end process;

    process(clk)
    begin

        if (rising_edge(clk)) then
            if (rst = '1') then
                curr_addr <= (others => '0');
            elsif (ready = '1') then
                curr_addr <= next_addr;
            end if;
        end if;

    end process;
    addr <= curr_addr;
    process(curr_addr)
    begin
        if (curr_addr /= (N-1 downto 0=>'1')) then
            occupied<='1';
            done<='0';
        else
            occupied<='0';
            done<='1';
        end if;
    end process;
end struct;