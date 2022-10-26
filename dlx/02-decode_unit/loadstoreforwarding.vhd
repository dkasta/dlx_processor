library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;


entity LS_FORWARDING is 
        port ( opcode_in : in std_logic_vector(5 downto 0);
               rd1_addr : in std_logic_vector(4 downto 0);
               rd2_addr: in std_logic_vector(4 downto 0);
               rd_out_exe : in std_logic_vector(4 downto 0);
               rd_out_mem : in std_logic_vector(4 downto 0);
               rd_out_wb : in std_logic_vector(4 downto 0);
               LMUX : out std_logic_vector(1 downto 0);
               SMUX : out std_logic_vector(1 downto 0));
end LS_FORWARDING;

architecture BEHAVIOURAL of LS_FORWARDING is

begin

    LS_proc: process(opcode_in, rd1_addr, rd2_addr, rd_out_exe, rd_out_mem, rd_out_wb)
    
        begin
            if (opcode_in = ITYPE_LW) then 
                if (rd1_addr = rd_out_exe) and (rd1_addr /= rd_out_mem) and (rd1_addr /= rd_out_wb) then
                    LMUX <= "11";
                elsif (rd1_addr = rd_out_exe) and (rd1_addr = rd_out_mem) and (rd1_addr = rd_out_wb) then
                    LMUX <= "11";
                elsif (rd1_addr /= rd_out_exe) and (rd1_addr = rd_out_mem) and (rd1_addr /= rd_out_wb) then
                    LMUX <= "01";
                elsif (rd1_addr /= rd_out_exe) and (rd1_addr /= rd_out_mem) and (rd1_addr = rd_out_wb) then
                    LMUX <= "10";
                elsif (rd1_addr = rd_out_exe) and (rd1_addr = rd_out_mem) and (rd1_addr /= rd_out_wb) then
                    LMUX <= "11";
                elsif (rd1_addr = rd_out_exe) and (rd1_addr /= rd_out_mem) and (rd1_addr = rd_out_wb) then
                    LMUX <= "11";
                else
                    LMUX <= "00";
                end if;
            elsif (opcode_in = ITYPE_SW) then
                if (rd2_addr = rd_out_exe) and (rd2_addr /= rd_out_mem) and (rd2_addr /= rd_out_wb) then
                    SMUX <= "11";
                elsif (rd2_addr = rd_out_exe) and (rd2_addr = rd_out_mem) and (rd2_addr = rd_out_wb) then
                    SMUX <= "11";
                elsif (rd2_addr /= rd_out_exe) and (rd2_addr = rd_out_mem) and (rd2_addr /= rd_out_wb) then
                    SMUX <= "01";
                elsif (rd2_addr /= rd_out_exe) and (rd2_addr /= rd_out_mem) and (rd2_addr = rd_out_wb) then
                    SMUX <= "10";
                elsif (rd2_addr = rd_out_exe) and (rd2_addr = rd_out_mem) and (rd2_addr /= rd_out_wb) then
                    SMUX <= "11";
                elsif (rd2_addr = rd_out_exe) and (rd2_addr /= rd_out_mem) and (rd2_addr = rd_out_wb) then
                    SMUX <= "11";
                else 
                    SMUX <= "00";
                end if;
            else 
                    LMUX <= "00";
                    SMUX <= "00";
            end if;
    end process;

end BEHAVIOURAL;
