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
         swp:   in std_logic_vector(windowsbit-1 downto 0);
         address_mem: in std_logic_vector(2*numreg_inlocout-1 downto 0); 
         enable_reg: out std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0) --enable for all the registers

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
        elsif(rising_edge(clk)) then
            if(wr='1') then                             
                decoder_choose<=(to_integer(unsigned(rw1))=> '1', OTHERS=>'0');  
            else 
                decoder_choose<=(OTHERS=>'0');
            end if;
        end if;                                                               
    end process;
    -- enable the correct physical register
    process(decoder_choose)
    begin
    --controllo global facendo un and di 1 con le prime numreg_global cifre di decoder_choose
        if((decoder_choose(numreg_global-1 downto 0) AND (numreg_global-1 downto 0 => '1')) /=(numreg_global-1 downto 0 => '0')) then
            enable_reg<=(2*numreg_inlocout*num_windows-1 downto 0 =>'0') & decoder_choose(numreg_global-1 downto 0); 
            --aggiunta dell'enable per tot gloab register + tutti gli altri zeri
        else
            --aggiunta degli zeri per i global 
            enable_reg(numreg_global-1 downto 0)<=(numreg_global-1 downto 0 =>'0');
            --controllo che sia input o local
            if((decoder_choose((2*numreg_inlocout+numreg_global)-1 downto numreg_global) AND (2*numreg_inlocout-1 downto 0 => '1')) /=(2*numreg_inlocout-1 downto 0 => '0')) then
            --aggiunta zeri a seconda della windows attiva
                enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto numreg_global)<=((num_windows - 1 - to_integer(unsigned(cwp)))*2*numreg_inlocout-1 downto 0 =>'0')&(decoder_choose((2*numreg_inlocout+numreg_global)-1 downto numreg_global)&(2*to_integer(unsigned(cwp))*numreg_inlocout-1 downto 0 => '0'));
                    --i -> devo aggiungere 2*i*numreg_inlocout zeri  e (num_windows-1-i)*2*numreg_inlocout alla "fine"
                    --0 -> devo aggiungere 0 zeri all'inizio e 16*3 zeri alla fine 
                    --1 -> devo aggiungere 16 zeri all'inizio e 16*2 zeri alla fine
                    --2 -> devo aggiungere 16*2 zeri all'inizio e 16 zeri alla fine
                    --3 -> devo aggiungere 16*3 zeri all'inizio e 0 zeri alla fine
            --controllo che sia output
            elsif((decoder_choose(2**numBit_address-1 downto (2*numreg_inlocout+numreg_global))AND (numreg_inlocout-1 downto 0 => '1')) /= (numreg_inlocout-1 downto 0 => '0')) then 
            --controllo che non sia ultima windows
                if(to_integer(unsigned(cwp))+1/=num_windows) then 
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto numreg_global)<=(numreg_inlocout-1+2*numreg_inlocout*(num_windows - to_integer(unsigned(cwp))-2) downto 0 =>'0') & decoder_choose((3*numreg_inlocout+numreg_global)-1 downto 2*numreg_inlocout+numreg_global)&(2*numreg_inlocout*(to_integer(unsigned(cwp))+1)-1 downto 0 =>'0');
                --devo salvare output in register file
                        --0 -> devo aggiungere 16 zeri all'inizio e 8+(16*2) zeri alla fine 
                        --1 -> devo aggiungere 16*2 zeri all'inizio e 8+16 zeri alla fine
                        --2 -> devo aggiungere 16*3 zeri all'inizio e 8 zeri alla fine
                        --i -> 16*(cwp+1) + registri output + 8+(16*(num_windows-cwp-2))
                else
                     --3 -> devo aggiungere 0 zeri all'inizio e 8+16*3 zeri alla fine
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto numreg_global)<=(numreg_inlocout+(2*numreg_inlocout*(num_windows-1))-1 downto 0 => '0')&decoder_choose((3*numreg_inlocout+numreg_global)-1 downto 2*numreg_inlocout+numreg_global);

                end if;
            else
            --fill operation
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto numreg_global)<=((num_windows - 1 - to_integer(unsigned(swp)))*2*numreg_inlocout-1 downto 0 =>'0')&(address_mem & (2*to_integer(unsigned(swp))*numreg_inlocout-1 downto 0 => '0'));
                    --i -> devo aggiungere 2*i*numreg_inlocout zeri  e (num_windows-1-i)*2*numreg_inlocout alla "fine"
                    --0 -> devo aggiungere 0 zeri all'inizio e 16*3 zeri alla fine 
                    --1 -> devo aggiungere 16 zeri all'inizio e 16*2 zeri alla fine
                    --2 -> devo aggiungere 16*2 zeri all'inizio e 16 zeri alla fine
                    --3 -> devo aggiungere 16*3 zeri all'inizio e 0 zeri alla fine
            end if;
        end if;
    end process;
end dataflow;