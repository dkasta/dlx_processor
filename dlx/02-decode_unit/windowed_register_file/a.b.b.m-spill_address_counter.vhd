
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.globals.all;

entity address_counter is
    generic(
        N:              integer := NumBitAddress;
        num_inlocout:   integer := Numreg_in_loc_out
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
    type State_type is (INIT,WAIT_STATE,SUM,FINISH);
    signal curr_state,next_state: State_type;
begin

    process(curr_addr,curr_state,en,ready)
    begin
        case curr_state is
            when INIT       =>  done<='0'; occupied<='0'; next_addr<=(others =>'0');
                                    next_state<=wait_state;
            WHEN WAIT_STATE =>  done<='0';
                                if(en='1' and ready='1')then
                                    occupied<='1';
                                    next_state<=sum;
                                else
                                    next_state<=wait_state;
                                end if;
            when SUM        =>  done<='0'; occupied<='1'; next_addr<=std_logic_vector(unsigned(curr_addr)+1);
                                if( en='1' and ready='1') then
                                     if(to_integer(unsigned(curr_addr))< 2*num_inlocout-1)then
                                            next_state<=sum;
                                     else next_state<=finish;
                                     end if;
                                else next_state<= wait_state;
                                end if;
            when finish     =>  done<='1'; occupied<='0'; next_state<=init;
        end case;
    end process;

    process(clk)
    begin

        if (rising_edge(clk)) then
            if (rst = '1') then
                curr_addr <= (others => '0');
                curr_state<=init;
            else
                curr_addr <= next_addr;
                curr_state<=next_State;
            end if;
        end if;

    end process;
    addr <= curr_addr;
end struct;