library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;
use work.myTypes.all;
use IEEE.numeric_std.all;

entity decode_unit is
  generic( numbit: integer := BIT_RISC;
           numbitdata: integer :=NumBitMemoryWord;
           numaddr: integer := NumMemBitAddress);
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
            imm_mux_control       in std_logic;
            jal_mux_control       in std_logic;
       	   	--NPC_OUT_BPU: 		      out std_logic_vector(numbit - 1 downto 0);
       	   	RD_OUT: 			        out std_logic_vector(4 downto 0);
       	   	NPC_OUT: 			        out std_logic_vector(numbit-1 downto 0);
       	   	A_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	B_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
       	   	IMM_REG_OUT: 		      out std_logic_vector(numbit-1 downto 0);
       	   	--alu_forwarding_one:   out std_logic;
    		    --mem_forwarding_one:   out std_logic;
       		  --alu_forwarding_two:   out std_logic;
            outmem:               out std_logic_vector(numbitdata-1 downto 0); --to dmem
            inmem:                in std_logic_vector(numbitdata-1 downto 0) --from dmem
            addressmem:           out std_logic_vector(numaddr-1 downto 0); --address from wrf_cu
            rd_mem:               out std_logic;
            wr_mem:               out std_logic;
            ramr:                 in std_logic;
            NPC_branch_jump       out std_logic_vector(numbit-1 downto 0);
            comparator_out        out std_logic;
       	  	--mem_forwarding_two:   out std_logic
            );
end decode_unit;

architecture structural of decode_unit is

--  component REGISTER_FILE
--    generic (numBit_data : integer := NumBitData;
--             numBit_address : integer := NumBitAddress;
--             numBit_registers : integer := NumBitRegisterFile);
--    port ( clk :	IN std_logic;
--           rst : IN std_logic;
--           Write_enable : IN std_logic;
--           Write_address : IN std_logic_vector(numBit_address-1 downto 0);
--           Read_one_address :	IN std_logic_vector(numBit_address-1 downto 0);
--           Read_two_address : IN std_logic_vector(numBit_address-1 downto 0);
--           Data_in : IN std_logic_vector(numBit_data-1 downto 0);
--           Data_one_out :	OUT std_logic_vector(numBit_data-1 downto 0);
--           Data_two_out :	OUT std_logic_vector(numBit_data-1 downto 0));
--    end component;
      component wrf_fsm is
            generic(  NBIT : integer := NumBitMemoryWord;
                      NADDR : integer :=  NumMemBitAddress );
          port( clk:          in std_logic;
                rst:          in std_logic;
                push:         in std_logic;
                done_fill:    in std_logic;
                done_spill:   in std_logic;
                pop:          in std_logic;
                ram_ready:    in std_logic;
                address:      out std_logic_vector(NADDR-1 downto 0);
                register_in:  in std_logic_vector(Nbit-1 downto 0);
                register_out: out std_logic_vector(Nbit-1 downto 0);
                datamem_in:   in std_logic_vector(Nbit-1 downto 0);
                datamem_out:  out std_logic_vector(Nbit-1 downto 0);
                read:         out std_logic;
                write:        out std_logic);
      component wrf_fsm;

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
            done_fill_cu:   OUT std_logic;
            done_spill_cu:  OUT std_logic;
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
            RAM_READY:  IN std_logic

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
       port(   data_in: in std_logic_vector(15 downto 0);
               data_out: out std_logic_vector(31 downto 0));
     end component;

     component RDMUX
       port(   rtype_in:  in std_logic_vector(4 downto 0);
               itype_in:  in std_logic_vector(4 downto 0);
               opcode_in: in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
               rd_out:    out std_logic_vector(4 downto 0));
     end component;

     component MUX21_GENERIC 
      generic( NBIT : integer := Bit_Mux21);
      port(    A:   in std_logic_vector(NBIT-1 downto 0);
               B:   in std_logic_vector(NBIT-1 downto 0);
               SEL: in std_logic;
               Y:   out std_logic_vector(NBIT-1 downto 0));
     end component;

     component COMPARATOR 
      generic ( NBIT : integer := Bit_Register;
                OPCODE_SIZE : integer := OP_CODE_SIZE);
      port( opcode_in : in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
            data_in :   in std_logic_vector(NBIT-1 downto 0);
            data_out :  out std_logic);
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

  signal sign_extention_16 : std_logic_vector(31 downto 0);
  signal sign_extention_26 : std_logic_vector(31 downto 0);
  signal RF_ONE_OUT : std_logic_vector(numbit-1 downto 0);
  signal RF_TWO_OUT : std_logic_vector(numbit-1 downto 0);
  signal rdmux_out : std_logic_vector(4 downto 0);
  signal imm_mux_out : std_logic_vector(numbit-1 downto 0);
  signal sign_extention_mux_out: std_logic_vector(numbit-1 downto 0);
  signal signal_comparator_out : std_logic;
  signal RF_write_address : std_logic_vector(4 downto 0);
  signal REGA_read_address : std_logic_vector(4 downto 0);

  --signal npc_latch_out : std_logic_vector(numbit-1 downto 0);

  --signal for connecting wrf to wrf_fsm
  signal done_fill : std_logic;
  signal done_spill: std_logic; 
  signal pop: std_logic; 
  signal push: std_logic;
  signal reg_in,reg_out: std_logic_vector(numbitdata-1 downto 0);

  begin

  SIGN_REG_16 : SIGN_EXTENTION
  port map( data_in => in_IR(15 downto 0),
            data_out => sign_extention_16);
  
  SIGN_REG_26 : SIGN_EXTENTION
  port map( data_in => in_IR(25 downto 0),
            data_out => sign_extention_26);
  
  IMM_MUX : MUX21_GENERIC
  generic map(numbit)
  port map ( A => sign_extention_16, 
             B => sign_extention_26, 
             SEL => imm_mux_control, 
             Y => sign_extention_mux_out);

  COMP : COMPARATOR
  generic map (numbit, OP_CODE_SIZE)
  port map ( opcode_in => in_IR(31 downto 26), 
             data_in => RF_ONE_OUT,
             data_out => signal_comparator_out);
  
  comparator_out <= signal_comparator_out;
  --RF : REGISTER_FILE
  --generic map(numbit,5,numbit)
  --port map( clk => clk,
  --          rst => rst,
  --          Write_enable => write_enable,
  --          Write_address => RD_IN,
  --          Read_one_address => in_IR(25 downto 21),
  --          Read_two_address => in_IR(20 downto 16),
  --          Data_in => WB_STAGE_IN,
  --          Data_one_out => RF_ONE_OUT,
  --          Data_two_out => RF_TWO_OUT);
  
  
   RF: wrf
    generic map( numBit_address => NumBitAddress,
                 numBit_data => NumBitData,
                 windowsbit => Windows_Bit,
                 numreg_inlocout => Numreg_IN_LOC_OUT, 
                 numreg_global => Numreg_g,
                 num_windows=>  tot_windows)
    port map( call => call,
          done_fill_cu => done_fill,
          done_spill_cu => done_spill,
          ret => ret,
          clk => clk,
          rst => rst,
          rd1 => rd1_enable,
          rd2 => rd2_enable,
          WR => write_enable,
          rw1 => RF_write_address,
          ADD_RD1 => REGA_read_address,
          ADD_RD2 => in_IR(20 downto 16),
          DATAIN => WB_STAGE_IN,
          out_reg_1 => RF_ONE_OUT,
          out_reg_2 => RF_TWO_OUT,
          out_mem => reg_in,
          pop_mem => pop,
          push_mem => push,
          RAM_READY => ramr,
          in_mem => reg_out
          );

  WRF_CU: wrf_fsm
      generic map (  NBIT=>NumBitMemoryWord, NADDR=> NumMemBitAddress);
    port( clk=>clk,
          rst=>rst,
          push=>push,
          done_fill=>done_fill,
          done_spill=>done_spill,
          pop=>pop,
          ram_ready=>ramr,
          address=>addressmem,
          register_in=>reg_in,
          register_out=>reg_out,
          datamem_in=>inmem,
          datamem_out=>outmem,
          read=>rd_mem,
          write=>wr_mem);
end wr;

  DATA_IN_MUX : MUX21_GENERIC
  generic map(5)
  port map ( A => "11111", 
             B => RD_IN, 
             SEL => jal_mux_control, 
             Y => RF_write_address);

 REGA_MUX : MUX21_GENERIC
 generic map(5)
 port map ( A => "11111", 
            B => in_IR(25 downto 21), 
            SEL => ret, 
            Y => REGA_read_address);
  
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
  port map( D => sign_extention_mux_out,
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


  NPC_branch_jump <= std_logic_vector(unsigned(NPC_IN) + unsigned(sign_extention_mux_out));


  --HAZARD : HAZARD_DETECTION
  --port map(clk,rst,instr_fetched(31 downto 26),instr_fetched(20 downto 16),instr_fetched(15 downto 11),instr_fetched(25 downto 21),instr_fetched(20 downto 16),alu_forwarding_one,mem_forwarding_one,alu_forwarding_two,mem_forwarding_two,open);

  --BRANCHUNIT : BRANCHDECISIONUNIT
  --port map(in_IR(31 downto 26),in_IR(25 downto 0),in_IR(15 downto 0),npc_latch_out,RF_ONE_OUT,RF_TWO_OUT,NPC_OUT_BPU);

end structural;
