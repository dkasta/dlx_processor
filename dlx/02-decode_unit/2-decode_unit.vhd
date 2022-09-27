library ieee;
use ieee.std_logic_1164.all;
use wotk.globals.all;
use work.myTypes.all;

entity decode_unit is
  generic( numbit: integer := BIT_RISC);
  	 port( 	clk: 			            in std_logic;
           	rst: 			            in std_logic;
       	   	write_enable: 		    in std_logic;
            in_IR:    			      in std_logic_vector(numbit-1 downto 0);
       	   	WB_STAGE_IN: 		      in std_logic_vector(numbit-1 downto 0);
       	   	NPC_IN: 			        in std_logic_vector(numbit-1 downto 0);
           	RD_IN: 			          in std_logic_vector(4 downto 0);
       	   	instr_fetched:        in std_logic_vector(BIT_RISC - 1 downto 0);
       	   	NPC_OUT_BPU: 		      out std_logic_vector(numbit - 1 downto 0);
       	   	RD_OUT: 			        out std_logic_vector(4 downto 0);
       	   	NPC_OUT: 			        out std_logic_vector(numbit-1 downto 0);
       	   	A_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	B_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	IMM_REG_OUT: 		      out std_logic_vector(numbit-1 downto 0);
       	   	alu_forwarding_one:   out std_logic;
    		    mem_forwarding_one:   out std_logic;
       		  alu_forwarding_two:   out std_logic;
       	  	mem_forwarding_two:   out std_logic);
end decode_unit;

architecture structural of decode_unit is



     component register_file
       generic(numBit_data:        integer := NumBitData;
	          numBit_address:     integer := NumBitAddress;
	          numBit_registers:   integer := NumBitRegisterFile);
       port(   CK:	             in std_logic;
               Reset:            in std_logic;
               Write_enable:     in std_logic;
               Write_address:    in std_logic_vector(numBit_address-1 downto 0);
               Read_one_address: in std_logic_vector(numBit_address-1 downto 0);
               Read_two_address: in std_logic_vector(numBit_address-1 downto 0);
               Data_in:          in std_logic_vector(numBit_data-1 downto 0);
               Data_one_out:     out std_logic_vector(numBit_data-1 downto 0);
               Data_two_out:     out std_logic_vector(numBit_data-1 downto 0));
     end component;

     component register_generic
       generic(NBIT:  integer := Bit_Register);
  	  port( D:    in std_logic_vector(NBIT-1 downto 0);
       	    CK:   in std_logic;
       	    ESET: in std_logic;
     	      Q:    out std_logic_vector(NBIT-1 downto 0));
     end component;

     component SIGN_EXTENTION
       port(   D: in std_logic_vector(15 downto 0);
               Q: out std_logic_vector(31 downto 0));
     end component;

     component RDMUX
       port(   rtype_in:  in std_logic_vector(4 downto 0);
               itype_in:  in std_logic_vector(4 downto 0);
               opcode_in: in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
               rd_out:    out std_logic_vector(4 downto 0));
     end component;

     component HAZARD_DETECTION
       port(   clk:                in std_logic;
               reset:              in std_logic;
               OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
               RD_REG_IN_ITYPE:    in std_logic_vector(4 downto 0);
               RD_REG_IN_RTYPE:    in std_logic_vector(4 downto 0);
               RS1_REG_IN:         in std_logic_vector(4 downto 0);
               RS2_REG_IN:         in std_logic_vector(4 downto 0);
               alu_forwarding_one: out std_logic;
               mem_forwarding_one: out std_logic;
               alu_forwarding_two: out std_logic;
               mem_forwarding_two: out std_logic;
               RD_OUT:             out std_logic_vector(4 downto 0));
     end component;

     component BRANCHDECISIONUNIT
       port(   OPCODE:       in std_logic_vector(5 downto 0);
               JOFFSET_IN:   in std_logic_vector(25 downto 0);
               BOFFSET_IN:   in std_logic_vector(15 downto 0);
               NPC_IN:       in std_logic_vector(31 downto 0);
               REG1_IN:      in std_logic_vector(31 downto 0);
               REG2_IN:      in std_logic_vector(31 downto 0);
               NPC_OUT:      out std_logic_vector(31 downto 0));
     end component;

  signal sign_extention_signal : std_logic_vector(31 downto 0);
  signal RF_ONE_OUT : std_logic_vector(numbit-1 downto 0);
  signal RF_TWO_OUT : std_logic_vector(numbit-1 downto 0);
  signal rdmux_out : std_logic_vector(4 downto 0);
  signal npc_latch_out : std_logic_vector(numbit-1 downto 0);

  begin

  SIGN_REG : SIGN_EXTENTION
  port map(in_IR(15 downto 0),sign_extention_signal);

  RF : REGISTER_FILE
  generic map(numbit,5,numbit)
  port map(clk,rst,write_enable,RD_IN,in_IR(25 downto 21),in_IR(20 downto 16),WB_STAGE_IN,RF_ONE_OUT,RF_TWO_OUT);

  REG_A : REGISTER_GENERIC
  generic map(numbit)
  port map(RF_ONE_OUT,clk,rst,A_REG_OUT);

  REG_B : REGISTER_GENERIC
  generic map(numbit)
  port map(RF_TWO_OUT,clk,rst,B_REG_OUT);

  IMMREG : REGISTER_GENERIC
  generic map(numbit)
  port map(sign_extention_signal,clk,rst,IMM_REG_OUT);

  npc_latch_out <= NPC_IN;

  NPC_REG : REGISTER_GENERIC
  generic map(numbit)
  port map(npc_latch_out,clk,rst,NPC_OUT);

  RDMUX_MUX : RDMUX
  port map(in_IR(15 downto 11),in_IR(20 downto 16),in_IR(31 downto 26),rdmux_out);

  RD_REG : REGISTER_GENERIC
  generic map(5)
  port map(rdmux_out,clk,rst,RD_OUT);

  HAZARD : HAZARD_DETECTION
  port map(clk,rst,instr_fetched(31 downto 26),instr_fetched(20 downto 16),instr_fetched(15 downto 11),instr_fetched(25 downto 21),instr_fetched(20 downto 16),alu_forwarding_one,mem_forwarding_one,alu_forwarding_two,mem_forwarding_two,open);

  BRANCHUNIT : BRANCHDECISIONUNIT
  port map(in_IR(31 downto 26),in_IR(25 downto 0),in_IR(15 downto 0),npc_latch_out,RF_ONE_OUT,RF_TWO_OUT,NPC_OUT_BPU);

end structural;
