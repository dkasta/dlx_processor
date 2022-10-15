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
        ready:      in std_logic;
        done:       out std_logic;
        occupied:    out std_logic;
        address_mem: out std_logic_vector(2*numreg_inlocout-1 downto 0)
    );
end fill_enable_generator;

architecture beh of fill_enable_generator is

    signal curr_addr: std_logic_vector(2*numreg_inlocout-1 downto 0); 
    signal next_addr: std_logic_vector(2*numreg_inlocout-1 downto 0); 
    type statetype is (init,freeze,shift,finish);
    signal curr_state,next_state: statetype;
begin

    process(curr_addr,curr_state,en,ready)
    begin
            case curr_state is
                when init   =>  done<='0'; occupied<='0'; next_addr<=(others=>'0');
                                next_state<=freeze;
                when freeze => next_addr<=curr_addr;
                                done<='0'; 
                                if(en='1' and ready='1')then
                                    occupied<='1';
                                    next_state<=shift;
                                    
                                else
                                    next_state<=freeze;
                                   
                                end if;
                when shift  =>  done<='0'; occupied<='1'; 
                                if(curr_addr =(2*numreg_inlocout-1 downto 0 =>'0') ) then
                                    next_addr<='1'&curr_addr(2*numreg_inlocout-1 downto 1);
                                 else
                                    next_addr<=curr_addr(0)&curr_addr(2*numreg_inlocout-1 downto 1);
                                 end if;
                                if( en='1' and ready='1') then
                                     if(curr_addr(0)/='1')then
                                            next_state<=shift;
                                     else next_state<=finish;
                                     end if;
                                else next_state<= freeze;
                                end if;
                when finish => done<='1'; occupied<='0'; next_state<=init;
            end case;
    end process;

    process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                curr_addr <= (others=>'0');
                curr_state<=init;
            else
                curr_addr <= next_addr;
                curr_state<=next_state;
            end if;
        end if;
    end process;
    address_mem <= curr_addr;
end beh;