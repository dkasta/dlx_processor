library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;
entity decoder is 
    generic(numBit_address: integer := NumBitAddress; -- bit numbers of address 5
            windowsbit: integer:=Windows_Bit;
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
            numreg_global: integer:=Numreg_g; --number of register in the global block
            num_windows: integer:= tot_windows); --number of total windows
    port(clk:   in std_logic;
         rst:   in std_logic;
         wr:    in std_logic;
         push:  IN std_logic;
         rw1:   in std_logic_vector(numBit_address-1 downto 0); --selection signal for the decoder
         cwp:   in std_logic_vector(windowsbit-1 downto 0); 
         swp:   in std_logic_vector(windowsbit-1 downto 0);
         address_mem: in std_logic_vector(2*numreg_inlocout-1 downto 0); 
         wr_internal: in std_logic;
         call: in std_logic;
         enable: out std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0) --enable for all the registers

         );
end decoder;

architecture dataflow of decoder is
signal decoder_choose: std_logic_vector(2**numBit_address-1 downto 0);
signal enable_reg: std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0); --enable for all the registers

begin

	process(rw1)
    begin
      if(rst='1') then
            decoder_choose<=(OTHERS=>'0');
        elsif(wr='1') then
                   decoder_choose<= (others => '0');
                decoder_choose(TO_INTEGER(unsigned(rw1))) <= '1';
		else decoder_choose<=(OTHERS=>'0');
       end if;                                                               
    end process;
    enable<=enable_reg;
    -- enable the correct physical register
    process(wr_internal,decoder_choose,address_mem,swp)

    begin
    
        --priority to fill
        if(to_integer(unsigned(swp)) /= 0 and enable_reg(numreg_global+2*numreg_inlocout*to_integer(unsigned(swp-1)))/='1') then
            --fill operation della finestra precedente
            enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)<=((num_windows - to_integer(unsigned(swp)))*2*numreg_inlocout-1 downto 0 =>'0')& address_mem &(2*to_integer(unsigned(swp)-1)*numreg_inlocout-1 downto 0 => '0')&(numreg_global-1 downto 0 =>'0');
                        --i -> devo aggiungere 2*(i-1)*numreg_inlocout zeri  e (num_windows-i)*2*numreg_inlocout alla "fine"
                        --swp=1 -> devo aggiungere 0 zeri all'inizio e 16*3 zeri alla fine
                        --swp=2 -> devo aggiungere 16 zeri all'inizio e 16*2 zeri alla fine
                        --swp=3 -> devo aggiungere 16*2 zeri all'inizio e 16 zeri alla fine
        elsif(wr ='0') then
            if(call='1') then 
                if(to_integer(unsigned(cwp))+1/=(num_windows-1)) then 
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)<=(((num_windows+1-2*((to_integer(unsigned(cwp))+1) mod num_windows))*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+2*(((to_integer(unsigned(cwp))+1) mod num_windows)+1)*numreg_inlocout+numreg_inlocout-2 downto 0 =>'0'));
                -- cwp=0 numreg_global + 4*numreg zeri +numreg-1 zeri & 1 + 3 * numreg_inlocout zeri cwp=1
                -- cwp=1 numreg_global + 6*numreg_inlocout zeri + numreg_inlocout-1 zeri & 1 + numreg_inlocout zeri cwp=2
                --cwp=3  numreg_global + 2*numreg_inlocout zeri + numreg_inlocout-1 zeri & 1 + 5* numreg_inlocout zeri cwp=0
                --cwp=i  ((num_windows+1-2*cwp)*Numreg_in_loc_out-1 downto 0 =>'0') & 1 & (numreg_global+2*(cwp+1)*numreg_inlocout+numreg_inlocout-2 downto 0 =>'0')
                else
                --cwp=2 numreg_global +numreg-1 zeri +1 + 7 Numreg_in_loc_out zeri
                --(((num_windows-1)*2+1)*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+numreg_inlocout-2 downto 0 =>'0');
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)<=((((num_windows-1)*2+1)*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+numreg_inlocout-2 downto 0 =>'0'));
                end if;
            elsif(wr_internal='1') then
                if(to_integer(unsigned(cwp))+1/=num_windows) then 
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)<=(((num_windows+1-2*to_integer(unsigned(cwp)))*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+2*(to_integer(unsigned(cwp))+1)*numreg_inlocout+numreg_inlocout-2 downto 0 =>'0'));
                -- cwp=0 numreg_global + 2*numreg zeri +numreg-1 zeri & 1 + 5 * numreg_inlocout zeri
                -- cwp=1 numreg_global + 4*numreg_inlocout zeri + numreg_inlocout-1 zeri & 1 + 3 * numreg_inlocout zeri
                --cwp=2 numreg_global+6*numreg_inlocout + numreg_inlocout-1 zeri & 1 + 1 * numreg_inlocout zeri
                --cwp=i  ((num_windows+1-2*cwp)*Numreg_in_loc_out-1 downto 0 =>'0') & 1 & (numreg_global+2*(cwp+1)*numreg_inlocout+numreg_inlocout-2 downto 0 =>'0')
                else
                --cwp=3 numreg_global +numreg-1 zeri +1 + 7 Numreg_in_loc_out zeri
                --(((num_windows-1)*2+1)*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+numreg_inlocout-2 downto 0 =>'0');
                    enable_reg(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)<=((((num_windows-1)*2+1)*numreg_inlocout-1 downto 0 =>'0')&'1'&(numreg_global+numreg_inlocout-2 downto 0 =>'0'));
                end if;
            else
            enable_reg<=(others=>'0');
            end if;
        elsif(push /= '1') then --if there is not the spill you can write
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
                end if;
            end if;
            --write in the jump even if there is a write
            if(call='1')then
                enable_reg((numreg_global+(to_integer(unsigned(cwp))+2)*2*numreg_inlocout+numreg_inlocout-1)mod(numreg_global+2*num_windows*numreg_inlocout))<='1';
            elsif(wr_internal='1')then
                --scrivere nel 31simo registro nella specifica cwp
                enable_reg((numreg_global+(to_integer(unsigned(cwp))+1)*2*numreg_inlocout+numreg_inlocout-1)mod(numreg_global+2*num_windows*numreg_inlocout))<='1';
            end if;
         end if;
    end process;
end dataflow;
