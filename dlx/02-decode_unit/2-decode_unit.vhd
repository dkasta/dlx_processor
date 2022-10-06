library ieee;
use ieee.std_logic_1164.all;
use wotk.globals.all;
use work.myTypes.all;

entity decode_unit is
  generic( numbit: integer := BIT_RISC);
  	 port( 	clk: 			            in std_logic;
           	rst: 			            in std_logic;
       	   	write_enable: 		    in std_logic;
            rd1_enable:           in std_logic;
            rd2_enable:           in std_logic;
            call:                 in std_logic; --call to a subroutine
            ret:                  in std_logic; --return to a subroutine
            EN2:                  in std_logic;
            in_IR:    			      in std_logic_vector(numbit-1 downto 0);
       	   	WB_STAGE_IN: 		      in std_logic_vector(numbit-1 downto 0);
       	   	NPC_IN: 			        in std_logic_vector(numbit-1 downto 0);
           	RD_IN: 			          in std_logic_vector(4 downto 0);
       	   	instr_fetched:        in std_logic_vector(BIT_RISC - 1 downto 0);
       	   	--NPC_OUT_BPU: 		      out std_logic_vector(numbit - 1 downto 0);
       	   	RD_OUT: 			        out std_logic_vector(4 downto 0);
       	   	NPC_OUT: 			        out std_logic_vector(numbit-1 downto 0);
       	   	A_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	B_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	IMM_REG_OUT: 		      out std_logic_vector(numbit-1 downto 0);
       	   	--alu_forwarding_one:   out std_logic;
    		    --mem_forwarding_one:   out std_logic;
       		  --alu_forwarding_two:   out std_logic;
            outmem:               out std_logic_vector(31 downto 0); --to dram wrf
            inmem:                in std_logic_vector(31 downto 0); --from dram wrf
       	  	--mem_forwarding_two:   out std_logic
            );
end decode_unit;

architecture structural of decode_unit is



     component wrf is
        generic(
            numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
            numBit_data: integer := NumBitData; -- numero di bit dei registri
            windowsbit: integer:=Windows_Bit;
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
            numreg_global: integer:=Numreg_g; --number of register in the global block
            num_windows: integer:= tot_windows); --number of total windows
        port( 
            
            -- to external
            clk: 		IN std_logic;
            rst: 	    IN std_logic;

            --control signals

            rd1: 		    IN std_logic;
            rd2: 		    IN std_logic;
            WR: 		    IN std_logic;
            call:           IN std_logic; -- 1 if there is a call to another subroutine
            ret:            IN std_logic; --1 if there is a retur to another subroutine
            done_fill_cu:   IN std_logic;
            done_spill_cu:  IN std_logic;
            --address and data

            rw1: 	IN std_logic_vector(numBit_address - 1 downto 0); 
            ADD_RD1: 	IN std_logic_vector(numBit_address - 1 downto 0);
            ADD_RD2: 	IN std_logic_vector(numBit_address - 1 downto 0);
            DATAIN: 	IN std_logic_vector(numBit_data- 1 downto 0);
            out_reg_1: 		OUT std_logic_vector(numBit_data - 1 downto 0);
            out_reg_2: 		OUT std_logic_vector(numBit_data - 1 downto 0);

            -- for MEMORY
            pop_mem:    OUT std_logic;
            push_mem:   OUT std_logic;
            out_mem:  OUT std_logic_vector(numBit_data - 1 downto 0);
            in_mem:  IN std_logic_vector(numBit_data - 1 downto 0);
            RAM_READY:  IN std_logic;

        );
    end component;

      component register_generic is
        generic (NBIT : integer := Bit_Register);
            port(   D:      in std_logic_vector(NBIT-1 downto 0);
                    CK:     in std_logic;
                    RESET:  in std_logic;
                    ENABLE: in std_logic;
                    Q:      out std_logic_vector(NBIT-1 downto 0));
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

     --component HAZARD_DETECTION
     --  port(   clk:                in std_logic;
     --          reset:              in std_logic;
     --          OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
     --          RD_REG_IN_ITYPE:    in std_logic_vector(4 downto 0);
     --          RD_REG_IN_RTYPE:    in std_logic_vector(4 downto 0);
     --          RS1_REG_IN:         in std_logic_vector(4 downto 0);
     --          RS2_REG_IN:         in std_logic_vector(4 downto 0);
     --          alu_forwarding_one: out std_logic;
     --          mem_forwarding_one: out std_logic;
     --          alu_forwarding_two: out std_logic;
     --          mem_forwarding_two: out std_logic;
     --          RD_OUT:             out std_logic_vector(4 downto 0));
     --end component;

     --component BRANCHDECISIONUNIT
     --  port(   OPCODE:       in std_logic_vector(5 downto 0);
     --          JOFFSET_IN:   in std_logic_vector(25 downto 0);
     --          BOFFSET_IN:   in std_logic_vector(15 downto 0);
     --          NPC_IN:       in std_logic_vector(31 downto 0);
     --          REG1_IN:      in std_logic_vector(31 downto 0);
     --          REG2_IN:      in std_logic_vector(31 downto 0);
     --          NPC_OUT:      out std_logic_vector(31 downto 0));
     --end component;

  signal sign_extention_signal : std_logic_vector(31 downto 0);
  signal RF_ONE_OUT : std_logic_vector(numbit-1 downto 0);
  signal RF_TWO_OUT : std_logic_vector(numbit-1 downto 0);
  signal rdmux_out : std_logic_vector(4 downto 0);
  --signal npc_latch_out : std_logic_vector(numbit-1 downto 0);
  signal done_fill,done_spill,pop,push,ramr: std_logic
  begin

  SIGN_REG : SIGN_EXTENTION
  port map(in_IR(15 downto 0),sign_extention_signal);
  --RF : REGISTER_FILE
  --generic map(numbit,5,numbit)
  --port map(clk,rst,write_enable,RD_IN,in_IR(25 downto 21),in_IR(20 downto 16),WB_STAGE_IN,RF_ONE_OUT,RF_TWO_OUT);
  
  
  RF: wrf
    generic map( numBit_address => NumBitAddress,
                 numBit_data => NumBitData,
                 windowsbit => Windows_Bit,
                 numreg_inlocout => Numreg_IN_LOC_OUT, 
                 numreg_global => Numreg_g,
                 num_windows=>  tot_windows)
    port( call => call,
          done_fill_cu => done_fill,
          done_spill_cu => done_spill,
          ret => ret,
          clk => clk,
          rst => rst,
          rd1 => rd1_enable,
          rd2 => rd2_enable,
          WR => write_enable,
          rw1 => RD_IN,
          ADD_RD1 => in_IR(25 downto 21),
          ADD_RD2 => in_IR(20 downto 16),
          DATAIN => WB_STAGE_IN,
          out_reg_1 => RF_ONE_OUT,
          out_reg_2 => RF_TWO_OUT,
          out_mem => outmem,
          pop_mem => pop,
          push_mem => push,
          RAM_READY => ramr,
          in_mem => inmem
          );

  
  
  REG_A : REGISTER_GENERIC
  generic map(numbit)
  port map( D => RF_ONE_OUT,
            CK => clk,
            RESET => rst, 
            ENABLE => EN2, 
            Q => A_REG_OUT);

  REG_B : REGISTER_GENERIC
  generic map(numbit)
  port map( D => RF_TWO_OUT,
            CK => clk,
            RESET => rst, 
            ENABLE => EN2,
            Q => B_REG_OUT);

  IMMREG : REGISTER_GENERIC
  generic map(numbit)
  port map( D => sign_extention_signal,
            CK => clk,
            RESET => rst, 
            ENABLE => EN2,
            Q => IMM_REG_OUT);

  --npc_latch_out <= NPC_IN;

  NPC_REG : REGISTER_GENERIC
  generic map(numbit)
  port map( D => NPC_IN,
            CK => clk,
            RESET => rst, 
            ENABLE => EN2,
            Q => NPC_OUT);

  RDMUX_MUX : RDMUX
  port map( rtype_in => in_IR(15 downto 11),
            itype_in => in_IR(20 downto 16),
            opcode_in => in_IR(31 downto 26),
            rd_out => rdmux_out);

  RD_REG : REGISTER_GENERIC
  generic map(5)
  port map( D => rdmux_out,
            CK => clk,
            RESET => rst, 
            ENABLE => EN2,
            Q => RD_OUT);

  --HAZARD : HAZARD_DETECTION
  --port map(clk,rst,instr_fetched(31 downto 26),instr_fetched(20 downto 16),instr_fetched(15 downto 11),instr_fetched(25 downto 21),instr_fetched(20 downto 16),alu_forwarding_one,mem_forwarding_one,alu_forwarding_two,mem_forwarding_two,open);

  --BRANCHUNIT : BRANCHDECISIONUNIT
  --port map(in_IR(31 downto 26),in_IR(25 downto 0),in_IR(15 downto 0),npc_latch_out,RF_ONE_OUT,RF_TWO_OUT,NPC_OUT_BPU);

end structural;
