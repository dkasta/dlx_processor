
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity physical_register_file is
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
end physical_register_file;

architecture structural of physical_register_file is
  component register_generic is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              CK:    in std_logic;
	            EN:    in std_logic;
              RESET: in std_logic;
              Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;
  component MUX21_GENERIC is
  generic( NBIT : integer := Bit_Mux21);
  port(    A:   in std_logic_vector(NBIT-1 downto 0);
           B:   in std_logic_vector(NBIT-1 downto 0);
           SEL: in std_logic;
           Y:   out std_logic_vector(NBIT-1 downto 0));
  end component;
  type bus_register is array(0 to num_windows-1) of std_logic_vector(numBit_data-1 downto 0);
  signal bus_data_register: bus_register;
  begin
    GLOBAL_BLOCK: for i in 0 to numreg_global-1 generate
      GLOB_REG:  register_generic generic map(NBIT=>numBit_data) port map(D=>Data_in1,CK=>clk,EN=>en(i),RESET=>rst,Q=>Data_out_global((i+1)*numBit_data-1 downto i*numBit_data));
    end generate GLOBAL_BLOCK;
    MUX_REG: for i in numreg_global to ((numreg_global + (numreg_inlocout*2)*num_windows)-1) generate
      --generate of the mux for the input and local block, generate it each time there is a new block input
        MUX: if((i-numreg_global)mod 2*numreg_inlocout = 0) generate
          MUX_I: MUX21_GENERIC generic map( NBIT=>numBit_data) port map(A=>Data_in1,B=>Data_in2,SEL=>swp_en,Y=>bus_data_register((i-numreg_global)/2*numreg_inlocout));
        end generate MUX;
      -- generate each register for the physical register file
        REG: register_generic generic map(NBIT=>numBit_data) port map(D=>bus_data_register((i-numreg_global)/2*numreg_inlocout),CK=>clk,EN=>en(i),RESET=>rst,Q=>Data_out_reg((i-numreg_global+1)*numBit_data-1 downto (i-numreg_global)*numBit_data));
    end generate MUX_REG;
	
   end structural;