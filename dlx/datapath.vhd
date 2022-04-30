--connect all the datapath components to achieve the final datapath structure
--explanation for the datapth is found on the report.pdf

library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

entity datapath is
  generic( numbit: integer := RISC_BIT);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           write_enable:          in std_logic;
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(3 downto 0);
           to_ir:                 in std_logic_vector(numbit - 1 downto 0);
           to_mem_stage_reg:      in std_logic_vector(numbit - 1 downto 0);
           wb_control:            in std_logic;
           jal_sel:               in std_logic;
           to_iram:               out std_logic_vector(numbit - 1 downto 0);
           npc_out_if:            out std_logic_vector(numbit - 1 downto 0);
           npc_out_bpu:           out std_logic_vector(numbit - 1 downto 0);
           instruction_fetched:   out std_logic_vector(numbit - 1 downto 0);
           ir_out:                out std_logic_vector(numbit - 1 downto 0);
           rd_out_id:             out std_logic_vector(4 downto 0);
           npc_out_id:            out std_logic_vector(numbit - 1 downto 0);
           a_reg_out:             out std_logic_vector(numbit - 1 downto 0);
           b_reg_out:             out std_logic_vector(numbit - 1 downto 0);
           imm_reg_out:           out std_logic_vector(numbit - 1 downto 0);
           alu_out:               out std_logic_vector(numbit - 1 downto 0);
           rd_out_ex:             out std_logic_vector(4 downto 0);
           b_reg_out_ex:          out std_logic_vector(numbit - 1 downto 0);
           rd_out_mem:            out std_logic_vector(4 downto 0);
           memory_stage_out:      out std_logic_vector(numbit - 1 downto 0);
           alu_out_mem:           out std_logic_vector(numbit - 1 downto 0);
           wb_stage_out:          out std_logic_vector(numbit - 1 downto 0);
           rd_out_wb:             out std_logic_vector(4 downto 0);
           alu_forwarding_one:    out std_logic;
           mem_forwarding_one:    out std_logic;
           alu_forwarding_two:    out std_logic;
           mem_forwarding_two:    out std_logic;
           alu_forwarding_value:  out std_logic_vector(numbit - 1 downto 0);
           mem_forwarding_value:  out std_logic_vector(numbit - 1 downto 0));
end datapath;

architecture structural of datapath is

  signal instrfetchedsigal : std_logic_vector(numbit - 1 downto 0);
  signal iroutsignal : std_logic_vector(numbit - 1 downto 0);
  signal npcoutifsignal : std_logic_vector(numbit - 1 downto 0);

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

  signal aluforwardingonesignal : std_logic;
  signal aluforwardingtwosignal : std_logic;
  signal memforwardingonesignal : std_logic;
  signal memforwardingtwosignal : std_logic;

  signal npcoutbpusignal : std_logic_vector(numbit - 1 downto 0);

  component fetch_unit
  generic( numbit : integer := BIT_RISC);
  port(   program_counter: in std_logic_vector(numbit-1 downto 0);
       	  to_IR:		       in std_logic_vector(numbit-1 downto 0);
       	  clk:			       in std_logic;
       	  rst:	 	  	     in std_logic;
       	  to_IRAM:     	   out std_logic_vector(numbit - 1 downto 0);
       	  npc_out:		     out std_logic_vector(numbit-1 downto 0);
       	  instr_reg_out:   out std_logic_vector(numbit-1 downto 0);
       	  instr_fetched:   out std_logic_vector(numbit-1 downto 0));
  end component;

component decode_unit is
  generic( numbit: integer := BIT_RISC);
  	 port( clk:                in std_logic;
           rst: 			         in std_logic;
       	   write_enable:   	   in std_logic;
           in_IR:    		       in std_logic_vector(numbit-1 downto 0);
       	   WB_STAGE_IN: 	     in std_logic_vector(numbit-1 downto 0);
       	   NPC_IN: 	           in std_logic_vector(numbit-1 downto 0);
           RD_IN: 		         in std_logic_vector(4 downto 0);
       	   instr_fetched:      in std_logic_vector(BIT_RISC - 1 downto 0);
       	   NPC_OUT_BPU: 	     out std_logic_vector(numbit - 1 downto 0);
       	   RD_OUT: 	           out std_logic_vector(4 downto 0);
       	   NPC_OUT: 	         out std_logic_vector(numbit-1 downto 0);
       	   A_REG_OUT: 	       out std_logic_vector(numbit-1 downto 0);
       	   B_REG_OUT: 	       out std_logic_vector(numbit-1 downto 0);
       	   IMM_REG_OUT:	       out std_logic_vector(numbit-1 downto 0);
       	   alu_forwarding_one: out std_logic;
    	     mem_forwarding_one: out std_logic;
       	   alu_forwarding_two: out std_logic;
       	   mem_forwarding_two: out std_logic);
end component;

  component execution_unit
  generic( numbit: integer := BIT_RISC);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           alu_forwarding_one:    in std_logic;
           mem_forwarding_one:    in std_logic;
           alu_forwarding_two:    in std_logic;
           mem_forwarding_two:    in std_logic;
           alu_forwarding_value:  in std_logic_vector(numbit - 1 downto 0);
           mem_forwarding_value:  in std_logic_vector(numbit - 1 downto 0);
           npc_in:                in std_logic_vector(numbit-1 downto 0);
           a_reg_in:              in std_logic_vector(numbit-1 downto 0);
           b_reg_in:              in std_logic_vector(numbit-1 downto 0);
           imm_reg_in:            in std_logic_vector(numbit-1 downto 0);
           rd_reg_in:             in std_logic_vector(4 downto 0);
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(3 downto 0);
           execution_stage_out:   out std_logic_vector(numbit-1 downto 0);
           b_reg_out:             out std_logic_vector(numbit-1 downto 0);
           rd_reg_out:            out std_logic_vector(4 downto 0));
  end component;

  component memory_unit
  generic( numbit: integer := BIT_RISC);
  port(    alu_in:            in std_logic_vector(numbit - 1 downto 0);
           rd_reg_in:         in std_logic_vector(4 downto 0);
           reset:             in std_logic;
           clk:               in std_logic;
           to_mem_stage_reg:  in std_logic_vector(numbit - 1 downto 0);
           rd_reg_out:        out std_logic_vector(4 downto 0);
           memory_stage_out:  out std_logic_vector(numbit-1 downto 0);
           alu_out:           out std_logic_vector(numbit - 1 downto 0));
  end component;

  component write_back_unit
  generic( N: integer := BIT_RISC);
  port(    LMD:     in std_logic_vector(N-1 downto 0);
           ALUOUT:  in std_logic_vector(N-1 downto 0);
           RD_IN:   in std_logic_vector(4 downto 0);
           CONTROL: in std_logic;
           JAL_SEL: in std_logic;
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
    port map(npcoutbpusignal, to_ir, clk, reset, to_iram, npcoutifsignal, iroutsignal, instrfetchedsigal);

    DECODE : DECODE_STAGE
    generic map(numbit)
    port map(clk, reset, write_enable, iroutsignal, wbstageoutsignal, npcoutifsignal, rdoutwbsignal, instrfetchedsigal, npcoutbpusignal, rdoutidsignal, npcoutidsignal,
     aregsignal, bregsignal, immregsignal, aluforwardingonesignal, memforwardingonesignal, aluforwardingtwosignal, memforwardingtwosignal);

    EXECUTE : EXECUTION_STAGE
    generic map(numbit)
    port map(aluforwardingonesignal, memforwardingonesignal, aluforwardingtwosignal, memforwardingtwosignal, aluoutsignal, aluoutmemsignal, npcoutidsignal, aregsignal,
     bregsignal, immregsignal, rdoutidsignal, mux_one_control, mux_two_control, alu_control, clk, reset, aluoutsignal, b_reg_out_ex, rdoutexsignal);

    MEMORY : MEMORY_STAGE
    generic map(numbit)
    port map(aluoutsignal, rdoutexsignal, reset, clk, to_mem_stage_reg, rdoutmemsignal, memstageoutsignal, aluoutmemsignal);

    WRITEBACK : WRITE_BACK_STAGE
    generic map(numbit)
    port map(memstageoutsignal, aluoutmemsignal, rdoutmemsignal, wb_control, jal_sel, rdoutwbsignal, wbstageoutsignal);

end structural;


