library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.globals.all;
use work.myTypes.all;
entity DataPath is
generic(nbit_data: integer :=32;
        nbit_addr_rf: integer :=5);
	port(
	       Clk,Rst: in std_logic;
	       --data in input
	       INP1,INP2: in std_logic_vector(nbit_data-1 downto 0);
	       --address in input to register file
	       RS1,RS2,RD: in std_logic_vector(nbit_addr_rf-1 downto 0);
	       --result of datapath
	       output:out std_logic_vector(nbit_data-1 downto 0);
	       ---pipe stage 1
	       EN1:in std_logic; --enable for the 1 stage og pipeline
	       RF1,RF2,WF1: in std_logic; -- signals for enabling register file
	       
	       --pipe stage 2
	       EN2: in std_logic; --enable for the second stage
	       S1,S2: in std_logic; --selector for the 2 mux input of the alu
	       ALU_signal: in aluOp; --alu1 and alu2 in the draw control signal for the alu
	       --pipe stage 3
	       EN3:in std_logic;--enable signal for the third stage
	       S3:in std_logic;--selection signal for end mux
	       RM,WM:in std_logic --enable signal for dram
	       );
end DataPath;

architecture structural of DataPath is
component alu is
  port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
        operand_B : in std_logic_vector(NumBitALU-1 downto 0);
        type_alu_operation : in aluOp;
        output : out std_logic_vector(NumBitALU-1 downto 0);
        cout : out std_logic);
end component;
component register_generic is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              EN: in std_logic;
              CK:    in std_logic;
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
component DRAM is
  port(clk : IN std_logic;
       address : IN std_logic_vector(BIT_DRAM-1 downto 0);
       data_in : IN std_logic_vector(BIT_DRAM-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       en: in std_logic;
       data_out : OUT std_logic_vector(BIT_DRAM-1 downto 0);
       address_error : OUT std_logic);
end component;
component register_file is
  generic( numBit_data: integer := NumBitData;
	         numBit_address: integer := NumBitAddress;
	         numBit_registers: integer := NumBitRegisterFile);
  port (  clk:              in std_logic;
          rst:              in std_logic;
	        Write_enable:     in std_logic;
	        Write_address:    in std_logic_vector(numBit_address-1 downto 0);
 	        Read_one_address:	in std_logic_vector(numBit_address-1 downto 0);
 	        Read_two_address: in std_logic_vector(numBit_address-1 downto 0);
 	        Data_in:          in std_logic_vector(numBit_data-1 downto 0);
          Data_one_out:	    out std_logic_vector(numBit_data-1 downto 0);
 	        Data_two_out:	    out std_logic_vector(numBit_data-1 downto 0));
end component;
--pipeline1
signal data_out1_A,data_out2_B: std_logic_vector(nbit_data-1 downto 0);-- two data in output
signal data_write_rf:std_logic_vector(nbit_data-1 downto 0); --data to write in the rf
signal address_write_rf:std_logic_vector(nbit_addr_rf-1 downto 0);--from register pip2 to rf
--pipeline2
signal mux1_in1,mux1_in2: std_logic_vector(nbit_data-1 downto 0); -- two inputs of the first mux of alu
signal mux2_in1,mux2_in2: std_logic_vector(nbit_data-1 downto 0); --two inputs of the second mux of alu
signal addr_wr_rd2:std_logic_vector(nbit_addr_rf-1 downto 0);--from rd1 to rd2
signal data_alu_1,data_alu_2: std_logic_vector(nbit_data-1 downto 0); --two data for the alu
signal alu_output:std_logic_vector(nbit_data-1 downto 0);
signal alu_cout:std_logic;
--pipeline 3
signal address_dram,data_dram:std_logic_vector(nbit_data-1 downto 0);
signal mux3_in1:std_logic_vector(nbit_data-1 downto 0);
signal error: std_logic;
begin
-- first stage
RF: register_file port map(clk=>Clk,rst=>Rst,Write_enable=>WF1,Write_address=>address_write_rf,Read_one_address=>RS1,Read_two_address=>RS2,Data_in=>data_write_rf,Data_one_out=>data_out1_A,Data_two_out=>data_out2_B);
in1: register_generic generic map(NBIT=>nbit_data) port map(D=>INP1,EN=>EN1,CK=>Clk,RESET=>Rst,Q=>mux1_in1);
A: register_generic generic map(NBIT=>nbit_data) port map(D=>data_out1_A,EN=>EN1,CK=>Clk,RESET=>Rst,Q=>mux1_in2);
in2: register_generic generic map(NBIT=>nbit_data) port map(D=>INP2,EN=>EN1,CK=>Clk,RESET=>Rst,Q=>mux2_in2);
B: register_generic generic map(NBIT=>nbit_data) port map(D=>data_out2_B,EN=>EN1,CK=>Clk,RESET=>Rst,Q=>mux2_in1);
rd1: register_generic generic map(NBIT=>nbit_addr_rf)port map(D=>RD,EN=>EN1,CK=>Clk,RESET=>Rst,Q=>addr_wr_rd2);

--second stage
mux1:MUX21_GENERIC generic map(NBIT=>nbit_data) port map(A=>mux1_in1,B=>mux1_in2,SEL=>S1,Y=>data_alu_1);
mux2:MUX21_GENERIC generic map(NBIT=>nbit_data) port map(A=>mux2_in1,B=>mux2_in2,SEL=>S2,Y=>data_alu_2);
alu1:alu   port map(operand_A=>data_alu_1,operand_B=>data_alu_2,type_alu_operation=>ALU_signal,output=>alu_output,cout=>alu_cout);
aluout:register_generic generic map(NBIT=>nbit_data) port map(D=>alu_output,EN=>EN2,CK=>Clk,RESET=>Rst,Q=>address_dram);
me:register_generic generic map(NBIT=>nbit_data) port map(D=>mux2_in1,EN=>EN2,CK=>Clk,RESET=>Rst,Q=>data_dram);
rd2: register_generic generic map(NBIT=>nbit_addr_rf)port map(D=>addr_wr_rd2,EN=>EN2,CK=>Clk,RESET=>Rst,Q=>address_write_rf);

--third stage
data_memory: DRAM port map(clk=>Clk,address=>address_dram,data_in=>data_dram,write_enable=>WM,read_enable=>RM,reset=>Rst,en=>EN3,data_out=>mux3_in1,address_error=>error);
mux3:MUX21_GENERIC generic map(NBIT=>nbit_data) port map(A=>mux3_in1,B=>address_dram,SEL=>S3,Y=>data_write_rf);
out1:register_generic generic map(NBIT=>nbit_data) port map(D=>data_write_rf,EN=>EN3,CK=>Clk,RESET=>Rst,Q=>output);

end structural;