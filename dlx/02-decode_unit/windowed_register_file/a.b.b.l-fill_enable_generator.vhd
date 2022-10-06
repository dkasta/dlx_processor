library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.globals.all;

entity fill_enable_generator is
    generic(
        numreg_inlocout: integer := Numreg_IN_LOC_OUT
    );
    port(
        clk:        in std_logic;
        rst:        in std_logic;
        en:         in std_logic;
        ready:  in std_logic;
        done:       out std_logic;
        occupied:    out std_logic;
        address_mem: out std_logic_vector(2*numreg_inlocout-1 downto 0); 
    );
end fill_enable_generator;

architecture beh of enable_generator is

    signal curr_addr: std_logic_vector(2*numreg_inlocout-1 downto 0); 
    signal next_addr: std_logic_vector(2*numreg_inlocout-1 downto 0); 

begin

    process(curr_addr, enable)
    begin
    --if enable is 1 to start and until the first enable is reached
        if (enable = '1' or (curr_addr(0) = '0')) then
            next_addr <=curr_addr(0) & curr_addr(2*numreg_inlocout-1 downto 1) ;
        end if;

    end process;

    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                curr_addr <= '1' & (2*numreg_inlocout-1 downto 1 =>'0');
            elsif (ram_ready = '1') then
                curr_addr <= next_addr;
            end if;
        end if;
    end process;

    address_mem <= curr_addr;
    --finish when the first enable is performed and the memory is ready
    done <= curr_addr(0) and ready;
    --until the first enable is reached the generator is occupied
    occupied <= not curr_addr(0);
end beh;