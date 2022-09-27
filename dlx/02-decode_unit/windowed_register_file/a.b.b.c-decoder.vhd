library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;
entity decoder is 
    generic(numBit_address: integer := NumBitAddress; -- bit numbers of address 5
            windowsbit: integer:= 2;                --log2(num_windows)
            numreg_global: integer:=8; --number of register in the global block
            numreg_inlocout: integer:=8; --number of register in each block in local out
	        num_windows: integer:= 4); --number of total windows
    port(clk:   in std_logic;
         rst:   in std_logic;
         wr:    in std_logic;
         rw1:   in std_logic_vector(numBit_address-1 downto 0); --selection signal for the decoder
         cwp:   in std_logic_vector(windowsbit-1 downto 0); 
         enable_reg: out std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0); --enable for all the registers

         );
end decoder;

architecture dataflow of decoder is
signal decoder_choose: std_logic_vector(2**numBit_address-1 downto 0);
begin
    --decoder process 
    process(wr,clk,rst)
    begin
        if(rst='1') then
            decoder_choose<=(OTHERS=>'0');
        elsif(rising_edge(clk) AND wr='1') then                             -- global   in1/out0  local   out1/in2
            decoder_choose<=(to_integer(unsigned(rw1))=> '1', OTHERS=>'0'); -- 00000000 00000000 00000000 00000000 
        end if;                                                                01234567
    end process;
    -- enable the correct physical register
    process(decoder_choose)
    begin
    --controllo global facendo un and di 1 con le prime numreg_global cifre di decoder_choose
        if((decoder_choose(numreg_global-1 downto 0) AND (numreg_global-1 downto 0 => '1')) /=(numreg_global-1 downto 0 => '0')) then
            enable_reg<=decoder_choose(numreg_global-1 downto 0)&(2*numreg_inlocout*num_windows-1 downto 0 =>'0'); 
        else
    --aggiunta zeri a seconda della windows attiva
        
        end if;
    end process;
end dataflow;