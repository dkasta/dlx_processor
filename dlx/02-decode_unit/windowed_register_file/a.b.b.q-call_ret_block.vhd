library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity call_ret_block is
    port(   
            clk: in std_logic;
            rst: in std_logic;
            call_from_wrf: out std_logic;
            ret_from_wrf: out std_logic;
            call:           IN std_logic; -- 1 if there is a call to another subroutine
            ret:            IN std_logic --1 if there is a retur to another subroutine
        );
end call_ret_block;
architecture fsm of call_ret_block is
    type statetype is (INIT_STATE,START_CALL_STATE,START_RET_STATE);
    signal currstate,nextstate: statetype;
    begin 
    process(clk,rst)
    begin
        if(rst='1') then
            currstate<=INIT_STATE;
        elsif(rising_edge(clk)) then
            currstate<=nextstate;
        end if;
    end process;
    process(call,ret,currstate)
    begin
        case(currstate) is
            when INIT_STATE=> call_from_wrf<='0'; ret_from_wrf<='0';
                              if(call='1') then nextstate<=START_CALL_STATE;
                              elsif(ret='1') then nextstate<=START_RET_STATE;
                              else nextstate<=INIT_STATE;
                              end if;
            when START_CALL_STATE=> call_from_wrf<='1'; nextstate<=INIT_STATE;
            when START_RET_STATE=> ret_from_wrf<='1'; nextstate<=INIT_STATE;
        end case;

    end process;
end fsm;
