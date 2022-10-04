library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;
entity mux_out is
generic(
         numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
         numBit_data: integer := NumBitData; -- numero di bit dei registri
         numreg_inlocout: integer:=8; --number of register in each block in local out
         numreg_global: integer:=8 --number of register in the global block
	     ); 
    port(
        add_read:   in std_logic_vector(numBit_address-1 downto 0);
        out_reg:    out std_logic_vector(numBit_data-1 downto 0); 
        in_reg:     in std_logic_vector(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto 0) 
    );
end mux_out;
architecture beh of mux_out is
--riorganizzare l'input in modo che abbia ogni input nbitdata bit
type ndata_array is array(0 to numreg_global+3*numreg_inlocout-1) of std_logic_vector(numBit_data-1 downto 0);
signal reg: ndata_array;
begin
    --fill reg
    process(in_reg)
    begin
        for i in 0 to numreg_global+3*numreg_inlocout-1 loop
            --0 numBit_data-1 to 0
            --1 numBit_data*2-1 to numBit_data
            --2 numBit_data*3-1 to numBit_data*2 ...
            --i numBit_data*(i+1)-1 to numBit_data*i
            reg(i)<= in_reg(numBit_data*(i+1)-1 downto numBit_data*i);
        end loop;
    end process;
    --select register
    process(add_read)
    begin
        out_reg<=reg(to_integer(unsigned(add_read)));
    end process;

end beh;