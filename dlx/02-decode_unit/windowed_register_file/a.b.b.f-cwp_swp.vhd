library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;
entity cwp_swp is
generic(windowsbit: integer:=2); -- bit of input of each port of the mux
    port(curr: in std_logic_vector(windowsbit-1 downto 0);
         nex: out std_logic_vector(windowsbit-1 downto 0);
         sel: in std_logic_vector(1 downto 0));
end cwp_swp;
architecture beh of cwp_swp is
begin
    process(curr,sel)
    begin
        case sel is
            when "01" => if(curr = (others=>'1')) then 
                            nex<=(others=>'0');
                         else nex<= curr+1; --curr+1 
                         end if;
            when "10" => if(curr = (others=>'0')) then 
                            nex<=(others=>'1');
                         else nex<= curr-1; --curr-1 
                         end if;
            when others => nex<=curr;--curr
        end case;
    end process;
end beh;