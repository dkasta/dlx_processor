library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity physical_register_file is
  generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
	          windowsbit: integer:=Windows_Bit;
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
            numreg_global: integer:=Numreg_g; --number of register in the global block
            num_windows: integer:= tot_windows); --number of total windows
	         
  port (  clk:              in std_logic;
          rst:              in std_logic;
          en:               in std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0); --enable for all the registers
 	      Data_in1:         in std_logic_vector(numBit_data-1 downto 0); --data from the cu
          Data_in2:         in std_logic_vector(numBit_data-1 downto 0); --data from the memory
          Data_out_reg:	    out std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); 
          Data_out_global:  out std_logic_vector(numBit_data*numreg_global-1 downto 0);
          data31:            in std_logic_vector(numBit_data-1 downto 0); --data for the 31 register
          wr_internal:      in std_logic;
          swp_en:           in std_logic_vector(windowsbit-1 downto 0)); --enable for the mux (choose if the data come from the memory or the cu)
end physical_register_file;

architecture structural of physical_register_file is
  component register_generic_wrf is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              CK:    in std_logic;
	            EN:    in std_logic;
              RESET: in std_logic;
              Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;
  component AND2 is
  port(A: in std_logic_vector(NumBitData-1 downto 0);
        B: in std_logic;
        Y:out std_logic_vector(NumBitData-1 downto 0));
  end component;
  component MUX21_GENERIC is
  generic( NBIT : integer := Bit_Mux21);
  port(    A:   in std_logic_vector(NBIT-1 downto 0);
           B:   in std_logic_vector(NBIT-1 downto 0);
           SEL: in std_logic;
           Y:   out std_logic_vector(NBIT-1 downto 0));
  end component;
  component encoder is
    generic (N: integer := Windows_Bit);
	  port( 
		  SEL : in std_logic_vector(N-1 downto 0);
		  S : out std_logic_vector(2**N-1 downto 0));
  end component;

  type bus_register is array(0 to num_windows-1) of std_logic_vector(numBit_data-1 downto 0);
  signal bus_data_register: bus_register;
  signal registers_31:bus_register;
  signal real_enable: std_logic_vector(num_windows-1 downto 0);
  signal swp: std_logic_vector(windowsbit-1 downto 0);
  type bus_global is array(0 to numreg_global-1) of std_logic_vector(numBit_data-1 downto 0);
  type registers_data is array(0 to 2*numreg_inlocout*num_windows-1) of std_logic_vector(numBit_data-1 downto 0);
  signal reg_global: bus_global;
  signal reg_data: registers_data;
  begin
    GLOBAL_BLOCK: for i in 0 to numreg_global-1 generate
        AND_GEN: and2 port map(A=>Data_in1,B=>en(i),Y=>reg_global(i));
      GLOB_REG:  register_generic_wrf generic map(NBIT=>numBit_data) port map(D=>reg_global(i),CK=>clk,EN=>en(i),RESET=>rst,Q=>Data_out_global((i+1)*numBit_data-1 downto i*numBit_data));
    end generate GLOBAL_BLOCK;
    MUX: for i in 0 to num_windows-1 generate
      --generate of the mux for the input and local block, generate it each time there is a new block input
          MUX_I: MUX21_GENERIC generic map( NBIT=>numBit_data) port map(A=>Data_in1,B=>Data_in2,SEL=>real_enable(i),Y=>bus_data_register(i));
    end generate MUX;
    REG: for i in 0 to 2*numreg_inlocout*num_windows-1 generate
      -- generate each register for the physical register file
      if_reg:if(i mod(2*numreg_inlocout)=numreg_inlocout-1) generate
        MUX_REG: MUX21_GENERIC generic map( NBIT=>numBit_data) port map(A=>bus_data_register(i/(2*numreg_inlocout)),B=>data31,SEL=>wr_internal,Y=>registers_31(i/(2*numreg_inlocout)));
        AND_GEN: and2 port map(A=>registers_31(i/(2*numreg_inlocout)),B=>en(i+numreg_global),Y=>reg_data(i));
        REG_I:register_generic_wrf generic map(NBIT=>numBit_data) port map(D=>reg_data(i),CK=>clk,EN=>en(i+numreg_global),RESET=>rst,Q=>Data_out_reg(numBit_data*(i+1)-1 downto numBit_data*i));
      end generate if_reg;
      if_reg2:if(not(i mod(2*numreg_inlocout)=numreg_inlocout-1)) generate
        AND_GEN: and2 port map(A=>bus_data_register(i/(2*numreg_inlocout)),B=>en(i+numreg_global),Y=>reg_data(i));
        REG_I:register_generic_wrf generic map(NBIT=>numBit_data) port map(D=>reg_data(i),CK=>clk,EN=>en(i+numreg_global),RESET=>rst,Q=>Data_out_reg(numBit_data*(i+1)-1 downto numBit_data*i));
      end generate if_reg2;
    end generate REG;
    swp<=std_logic_vector(unsigned(swp_en)-1) when swp_en /= (windowsbit-1 downto 0 =>'0') else (others=>'0');
    ENCODER1: encoder generic map(N=>windowsbit) port map(sel=>swp,S=>real_enable);
   end structural;