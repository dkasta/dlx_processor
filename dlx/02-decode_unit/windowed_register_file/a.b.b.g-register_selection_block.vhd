library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;
entity sel_block is
generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
         numreg_inlocout: integer:=8; --number of register in each block in local out
         windowsbit: integer:=2; 
	     num_windows: integer:= 4); --number of total windows
    port(
        tot_reg:    in std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); -- all 0 first register (first windows)
        curr_win:   in std_logic_vector(windowsbit-1 downto 0);
        out_reg:    out std_logic_vector(numBit_data*3*numreg_inlocout-1 downto 0) -- 
    );
end sel_block;
architecture beh of sel_block is
begin
    process(tot_reg,curr_win)
    begin
        --for each windows the correct registers are selected
        --0 out_reg= tot_reg(numBit_data*3*numreg_inlocout-1 downto 0)
        --1 out_reg= tot_reg(numBit_data*5*numreg_inlocout-1 downto numBit_data*2*numreg_inlocout)
        --2 out_reg= tot_reg(numBit_data*7*numreg_inlocout-1 downto numBit_data*4*numreg_inlocout)
        --3 out_reg= tot_reg(numBit_data*9*numreg_inlocout-1 downto numBit_data*6*numreg_inlocout)
        --4 out_reg= tot_reg(numBit_data*10*numreg_inlocout-1 downto numBit_data*8*numreg_inlocout)&tot_reg(numBit_data*numreg_inlocout-1 downto 0)
        --i out_reg= tot_reg(numBit_data*(3+(2*i))*numreg_inlocout-1 downto numBit_data*2*i*numreg_inlocout)
        if(to_integer(unsigned(curr_win))+1/=num_windows) then
            out_reg<=tot_reg(numBit_data*(3+(2*to_integer(unsigned(curr_win))))*numreg_inlocout-1 downto numBit_data*2*to_integer(unsigned(curr_win))*numreg_inlocout);
        else
            out_reg= tot_reg(numBit_data*(2+(2*to_integer(unsigned(curr_win))))*numreg_inlocout-1 downto numBit_data*2*to_integer(unsigned(curr_win))*numreg_inlocout)&tot_reg(numBit_data*numreg_inlocout-1 downto 0);
        end if;
    end process;
end beh;