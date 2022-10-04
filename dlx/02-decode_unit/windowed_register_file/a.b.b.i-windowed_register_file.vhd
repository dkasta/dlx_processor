library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.utils.all;

entity wrf is
    generic(
         numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
         numBit_data: integer := NumBitData; -- numero di bit dei registri
         numreg_inlocout: integer:=8; --number of register in each block in local out
         numreg_global: integer:=8 --number of register in the global block
        num_windows: integer:= 4); --number of total windows
    port( 
        
        -- to external
        clk: 		IN std_logic;
        rst: 	    IN std_logic;
        en: 	    IN std_logic;
        rd1: 		IN std_logic;
        rd2: 		IN std_logic;
        WR: 		IN std_logic;
        rw1: 	IN std_logic_vector(numBit_address - 1 downto 0); 
        ADD_RD1: 	IN std_logic_vector(numBit_address - 1 downto 0);
        ADD_RD2: 	IN std_logic_vector(numBit_address - 1 downto 0);
        DATAIN: 	IN std_logic_vector(numBit_data- 1 downto 0);
        --RAM_READY:  IN std_logic;
        out_reg_1: 		OUT std_logic_vector(numBit_data - 1 downto 0);
	    out_reg_2: 		OUT std_logic_vector(numBit_data - 1 downto 0);

        -- Other I/O
        --CALL:       IN std_logic;
        --RET:        IN std_logic;
        --FILL:       OUT std_logic; -- POP towards memory
        --SPILL:      OUT std_logic; -- PUSH towards memory

        -- TO MEMORY
        out_mem:  OUT std_logic_vector(NBIT_DATA - 1 downto 0);
        in_mem:  IN std_logic_vector(NBIT_DATA - 1 downto 0)

    );
end wrf;
architecture structural of wrf is

component decoder is 
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
end component;

component physical_register_file is
  generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
	         numreg_global: integer:=8; --number of register in the global block
           numreg_inlocout: integer:=8; --number of register in each block in local out
	         num_windows: integer:= 4); --number of total windows
	         
  port (  clk:              in std_logic;
          rst:              in std_logic;
          en:               in std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0); --enable for all the registers
 	      Data_in1:         in std_logic_vector(numBit_data-1 downto 0); --data from the cu
          Data_in2:         in std_logic_vector(numBit_data-1 downto 0); --data from the memory
          Data_out_reg:	    out std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); 
          Data_out_global:  out std_logic_vector(numBit_data*numreg_global-1 downto 0);
          swp_en:           in std_logic); --enable for the mux (choose if the data come from the memory or the cu)
end component;

component cwp_swp is
generic(windowsbit: integer:=2); -- bit of input of each port of the mux
    port(curr: in std_logic_vector(windowsbit-1 downto 0);
         nex: out std_logic_vector(windowsbit-1 downto 0);
         sel: in std_logic_vector(1 downto 0));
end component;

component sel_block is
generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
         numreg_inlocout: integer:=8; --number of register in each block in local out
         windowsbit: integer:=2; 
	     num_windows: integer:= 4); --number of total windows
    port(
        tot_reg:    in std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); -- all 0 first register (first windows)
        curr_win:   in std_logic_vector(windowsbit-1 downto 0);
        out_reg:    out std_logic_vector(numBit_data*3*numreg_inlocout-1 downto 0) -- 
    );
end component;

component mux_out is
generic(
         numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
         numBit_data: integer := NumBitData; -- numero di bit dei registri
         numreg_inlocout: integer:=8; --number of register in each block in local out
         numreg_global: integer:=8 --number of register in the global block
	     ); 
    port(
        add_read:   in std_logic_vector(numBit_address-1 downto 0);
        out_reg:    in std_logic_vector(numBit_data-1 downto 0); 
        in_reg:     in std_logic_vector(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto 0) 
    );
end component;
component register_generic is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              CK:    in std_logic;
	            EN:    in std_logic;
              RESET: in std_logic;
              Q:     out std_logic_vector(NBIT-1 downto 0));
end component;
signal curr_cwp,next_cwp,curr_swp,next_swp: std_logic_vector(windowsbit-1 downto 0); 
signal address_mem_s: std_logic_vector(2*numreg_inlocout-1 downto 0); 
signal enable_regs: std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0)
signal tot_regs: std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); 
signal global_reg: std_logic_vector(numBit_data*numreg_global-1 downto 0);
signal swp_en_s: std_logic; --TODO capire come fare enable 1 from memory 0 from input
signal input_mux_rd: std_logic_vector(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto 0);
signal sel_cwp,sel_swp:std_logic_vector(1 downto 0);--TODO
begin

dec: decoder generic map(numBit_address => NumBitAddress,windowsbit=> 2,numreg_global=>8,numreg_inlocout=>8,num_windows=> 4)
        port map(clk=>clk,rst=>rst,wr=>wr,rw1=>rw1,cwp=>curr_cwp,swp=>curr_swp,address_mem=>address_mem_s,enable_reg=>enable_regs);
phy: physical_register_file generic map ( numBit_data=> NumBitData,numreg_global=>8,numreg_inlocout=>8,num_windows=> 4)	         
        port map(  clk=>clk,rst=>rst,en=>enable_regs,Data_in1=>DATAIN,Data_in2=>in_mem,Data_out_reg=>tot_regs,Data_out_global=>global_reg,swp_en=>swp_en_s);
sel: sel_block generic map ( numBit_data=> NumBitData,numreg_inlocout=>8,windowsbit=>2,num_windows=> 4)
        port map(tot_reg=>tot_regs,curr_win=>curr_cwp,out_reg=>input_mux_rd(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto numBit_data*numreg_global ));
muxout1: mux_out generic map(numBit_address=> NumBitAddress,numBit_data=> NumBitData,numreg_inlocout=>8,numreg_global=>8 ) 
        port map(add_read=>ADD_RD1,out_reg=>out_reg_1,in_reg=>input_mux_rd);
muxout2: mux_out generic map(numBit_address=> NumBitAddress,numBit_data=> NumBitData,numreg_inlocout=>8,numreg_global=>8 ) 
        port map(add_read=>ADD_RD2,out_reg=>out_reg_2,in_reg=>input_mux_rd);
next_cwp: cwp_swp generic map(windowsbit=>2) port map (curr=>curr_cwp,nex=>next_cwp,sel=>sel_cwp);
cwp: register_generic generic map (NBIT => windowsbit) port map(D=>curr_cwp,CK=>clk,EN=>'1',RESET=>rst,Q:next_cwp);
next_swp: cwp_swp generic map(windowsbit=>2) port map (curr=>curr_swp,nex=>next_swp,sel=>sel_swp);
swp: register_generic generic map (NBIT => windowsbit) port map(D=>curr_swp,CK=>clk,EN=>'1',RESET=>rst,Q:next_swp);
--TODO
swp_en_s<='0';
sel_cwp<="00";
sel_swp<="00";
end structural;