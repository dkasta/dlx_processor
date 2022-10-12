--connect all the datapath components to achieve the final datapath structure
--explanation for the datapth is found on the report.pdf

library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

entity datapath is
  generic( numbit: integer := RISC_BIT);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           ------------------------------------------------------------------
           -- IF input
           EN1:                   in std_logic;
           to_IR:                 in std_logic_vector(numbit - 1 downto 0); -- In from IRAM
           ------------------------------------------------------------------
           -- ID input
           write_enable:          in std_logic;
           rd1_enable:            in std_logic;
           rd2_enable:            in std_logic;
           call:                  in std_logic;
           ret:                   in std_logic;
           EN2:                   in std_logic;
           ------------------------------------------------------------------
           -- EXE input
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(3 downto 0);
           EN3                    in std_logic;
           -----------------------------------------------------------------
           -- MEM input
           mux_mem_control:       in std_logic;
           DRAM_to_mux:           in std_logic_vector(numbit - 1 downto 0);
           ------------------------------------------------------------------
           -- WB input 
           mux_wb_control:        in std_logic;
           ------------------------------------------------------------------
           -- IF output
           to_IRAM:               out std_logic_vector(numbit - 1 downto 0); -- To IRAM
           npc_out_if:            out std_logic_vector(numbit - 1 downto 0);
           instruction_fetched:   out std_logic_vector(numbit - 1 downto 0);
           ir_out:                out std_logic_vector(numbit - 1 downto 0);

           ------------------------------------------------------------------
           -- ID output
           npc_out_id:            out std_logic_vector(numbit - 1 downto 0);
           a_reg_out:             out std_logic_vector(numbit - 1 downto 0);
           b_reg_out:             out std_logic_vector(numbit - 1 downto 0);
           imm_reg_out:           out std_logic_vector(numbit - 1 downto 0);
           rd_out_id:             out std_logic_vector(4 downto 0);
           ------------------------------------------------------------------
           -- EXE output
           alu_out:               out std_logic_vector(numbit - 1 downto 0);
           b_reg_out_ex:          out std_logic_vector(numbit - 1 downto 0);
           rd_out_ex:             out std_logic_vector(4 downto 0);
           ------------------------------------------------------------------
           --MEM output
           DRAM_addr:             out std_logic_vector(4 downto 0);
           DRAM_data_in           out std_logic_vector(numbit - 1 downto 0);
           alu_out_mem:           out std_logic_vector(numbit - 1 downto 0);

           memory_stage_out:      out std_logic_vector(numbit - 1 downto 0);
           wb_stage_out:          out std_logic_vector(numbit - 1 downto 0);
           rd_out_wb:             out std_logic_vector(4 downto 0);
           npc_out_bpu:           out std_logic_vector(numbit - 1 downto 0)
           FLUSH                  out std_logic;
           );
end datapath;

architecture structural of datapath is

  signal instrfetchedsigal : std_logic_vector(numbit - 1 downto 0);
  signal iroutsignal : std_logic_vector(numbit - 1 downto 0);
  signal npcoutifsignal : std_logic_vector(numbit - 1 downto 0);

  signal rdinidsignal : std_logic_vector(4 downto 0);
  signal rdoutidsignal : std_logic_vector(4 downto 0);
  signal npcoutidsignal : std_logic_vector(numbit - 1 downto 0);
  signal aregsignal : std_logic_vector(numbit - 1 downto 0);
  signal bregsignal : std_logic_vector(numbit - 1 downto 0);
  signal immregsignal : std_logic_vector(numbit - 1 downto 0);

  signal rdoutexsignal : std_logic_vector(4 downto 0);
  signal aluoutsignal : std_logic_vector(numbit - 1 downto 0);

  signal memstageoutsignal : std_logic_vector(numbit - 1 downto 0);
  signal rdoutmemsignal : std_logic_vector(4 downto 0);
  signal aluoutmemsignal : std_logic_vector(numbit - 1 downto 0);

  signal rdoutwbsignal : std_logic_vector(4 downto 0);
  signal wbstageoutsignal : std_logic_vector(numbit - 1 downto 0);
  signal enable_PC_signal : std_logic;

  signal aluforwardingonesignal : std_logic;
  signal aluforwardingtwosignal : std_logic;
  signal memforwardingonesignal : std_logic;
  signal memforwardingtwosignal : std_logic;

  signal npcoutbpusignal : std_logic_vector(numbit - 1 downto 0);
  signal NPC_branch_jump_signal: std_logic_vector(numbit - 1 downto 0);
  signal comparator_out_to_mux_signal: std_logic;
  signal b_reg_out_signal: std_logic_vector(numbit - 1 downto 0);
  
--signal for dram
  signal inmemsignal : std_logic_vector(numbit - 1 downto 0);
  signal outmemsignal : std_logic_vector(numbit - 1 downto 0); 
  signal addressmemsignal: std_logic_vector(numbit-1 downto 0); 
  signal rd_memsignal:     std_logic;
  signal wr_memsignal:  std_logic;
  signal ram_ready: std_logic;

  component fetch_unit
    generic(numbit : integer := I_SIZE);
    port(to_IR : IN std_logic_vector(numbit-1 downto 0);
         clk : IN std_logic;
         rst : IN std_logic;
         EN1:  IN std_logic;
         comparator_out_to_mux: in std_logic;
         NPC_branch_jump    in std_logic_vector(numbit-1 downto 0);
         to_IRAM : OUT std_logic_vector(numbit - 1 downto 0);
         npc_out : OUT std_logic_vector(numbit-1 downto 0);
         instr_reg_out : OUT std_logic_vector(numbit-1 downto 0);
         instr_fetched:   OUT std_logic_vector(numbit-1 downto 0));
    end component;

component decode_unit is
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
end component;


    
component execution_unit
  generic( numbit: integer := BIT_RISC);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           npc_in:                in std_logic_vector(numbit-1 downto 0);
           a_reg_in:              in std_logic_vector(numbit-1 downto 0);
           b_reg_in:              in std_logic_vector(numbit-1 downto 0);
           imm_reg_in:            in std_logic_vector(numbit-1 downto 0);
           rd_reg_in:             in std_logic_vector(4 downto 0);
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(3 downto 0);
           EN3:                   in std_logic;
           execution_stage_out:   out std_logic_vector(numbit-1 downto 0);
           b_reg_out:             out std_logic_vector(numbit-1 downto 0);
           rd_reg_out:            out std_logic_vector(4 downto 0));
 end component;

component memory_unit
generic( numbit: integer := BIT_RISC);
port(   alu_in:            in std_logic_vector(numbit - 1 downto 0);
        rd_reg_in:         in std_logic_vector(4 downto 0);
        b_reg_in:          in std_logic_vector(numbit - 1 downto 0);
        reset:             in std_logic;
        clk:               in std_logic;
        mux_mem_control:   in std_logic;
        EN4:               in std_logic;
        DRAM_to_mux:       in std_logic_vector(numbit - 1 downto 0);
        alu_out:           out std_logic_vector(numbit - 1 downto 0);
        rd_reg_out:        out std_logic_vector(4 downto 0);
        b_reg_out:         out std_logic_vector(numbit-1 downto 0);
        DRAM_addr:         out std_logic_vector(numbit-1 downto 0););
end component;

component write_back_unit
generic( N: integer := BIT_RISC);
port(    LMD:     in std_logic_vector(N-1 downto 0);
         ALUOUT:  in std_logic_vector(N-1 downto 0);
         RD_IN:   in std_logic_vector(4 downto 0);
         CONTROL: in std_logic;
         RD_OUT:  out std_logic_vector(4 downto 0);
         WB_OUT:  out std_logic_vector(N-1 downto 0));
end component;

  begin
    --IF signals
    instruction_fetched <= instrfetchedsigal;
    npc_out_if <= npcoutifsignal;
    ir_out <= iroutsignal;
    
    --ID signals
    rd_out_id <= rdoutidsignal;
    npc_out_id <= npcoutidsignal;
    a_reg_out <= aregsignal;
    b_reg_out <= bregsignal;
    imm_reg_out <= immregsignal;

    --EX signals
    rd_out_ex <= rdoutexsignal;
    alu_out <= aluoutsignal;
    --MEM signals
    rd_out_mem <= rdoutmemsignal;
    memory_stage_out <= memstageoutsignal;
    alu_out_mem <= aluoutmemsignal;
    --WB signals
    rd_out_wb <= rdoutwbsignal;
    wb_stage_out <= wbstageoutsignal;


    npc_out_bpu <= npcoutbpusignal;

    alu_forwarding_one <= aluforwardingonesignal;
    mem_forwarding_one <= memforwardingonesignal;
    alu_forwarding_two <= aluforwardingtwosignal;
    mem_forwarding_two <= memforwardingtwosignal;

    alu_forwarding_value <= aluoutsignal;
    mem_forwarding_value <= aluoutmemsignal;

    FETCH : FETCH_STAGE
    generic map(numbit)
    port map(clk => clk, 
             rst => reset, 
             EN1 => EN1,
             comparator_out_to_mux => comparator_out_to_mux_signal,
             NPC_branch_jump => NPC_branch_jump_signal,
             to_IR => to_IR,
             to_IRAM => to_IRAM, 
             npc_out => npcoutifsignal, 
             instr_reg_out => iroutsignal, 
             instr_fetched => instrfetchedsigal);

    FLUSH <= comparator_out_to_mux_signal;

    DECODE : decode_unit
    generic map( numbit=>numbit,
           numbitdata=>numbit,
           numaddr=>numbit)
    port map( clk => clk, 
              rst => reset, 
              write_enable => write_enable, 
              rd1_enable => rd1_enable,
              rd2_enable => rd2_enable,
              call => call,
              ret => ret,
              EN2 => EN2,
              in_IR => iroutsignal,
              WB_STAGE_IN => wbstageoutsignal,
              NPC_IN => npcoutifsignal,
              RD_IN => rdinidsignal,
              instr_fetched => instrfetchedsigal,
              RD_OUT => rdoutidsignal,
              NPC_OUT => npcoutidsignal,
              A_REG_OUT => aregsignal,
              B_REG_OUT => bregsignal,
              IMM_REG_OUT => immregsignal,
              inmem => inmemsignal,
              outmem => outmemsignal,
              addressmem=>addressmemsignal,
              rd_mem=>rd_memsignal,
              wr_mem=>wr_memsignal,
              ramr=>ram_ready,
              NPC_branch_jump => NPC_branch_jump_signal,
              comparator_out => comparator_out_to_mux_signal 
            );
end decode_unit;

EXECUTE : EXECUTION_STAGE
generic map(numbit)
port map( clk => clk,
          reset => reset,
          npc_in => npcoutidsignal,
          a_reg_in => aregsignal,
          b_reg_in => bregsignal,
          imm_reg_in => immregsignal,
          rd_reg_in => rdoutidsignal,
          mux_one_control => mux_one_control,
          mux_two_control => mux_two_control,
          alu_control => alu_control,
          EN3 => EN3,
          execution_stage_out => aluoutsignal,
          b_reg_out => b_reg_out_signal,
          rd_reg_out => rdoutexsignal);

MEMORY : MEMORY_STAGE
generic map(numbit)
port map( alu_in => aluoutsignal,
          rd_reg_in => rdoutexsignal,
          b_reg_in => b_reg_out_signal,
          reset => reset,
          clk => clk,
          mux_mem_control => mux_mem_control,
          EN4 => EN4,
          DRAM_to_mux => DRAM_to_mux,
          alu_out => aluoutmemsignal,
          rd_reg_out => rdoutmemsignal,
          b_reg_out => DRAM_data_in,
          DRAM_addr => DRAM_addr);

WRITEBACK : WRITE_BACK_STAGE
generic map(numbit)
port map( LMD => aluoutmemsignal,
          ALUOUT => aluoutmemsignal,
          mux_wb_control => mux_wb_control,
          RD_OUT => rdinidsignal,
          WB_OUT => wbstageoutsignal);

end structural;


