library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;
use WORK.myTypes.all;
use WORK.all;

entity tb_dlx_top is
end tb_dlx_top;

architecture behavioural of tb_dlx_top is
    constant SIZE_IR      : integer := 32;       -- Instruction Register Size
    constant SIZE_PC      : integer := 32;       -- Program Counter Size
    constant SIZE_ALU_OPC : integer := 6;        -- ALU Op Code Word Size in case explicit coding is used
    signal clk: std_logic := '0';
    signal reset: std_logic := '1';
    signal npc_out_if : std_logic_vector(RISC_BIT - 1 downto 0);
    signal instruction_fetched : std_logic_vector(RISC_BIT - 1 downto 0);
    signal ir_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_id : std_logic_vector(4 downto 0);
    signal npc_out_id : std_logic_vector(RISC_BIT - 1 downto 0);
    signal a_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal b_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal imm_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal alu_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_ex : std_logic_vector(4 downto 0);
    signal b_reg_out_ex : std_logic_vector(RISC_BIT - 1 downto 0);
    signal memory_stage_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_mem : std_logic_vector(4 downto 0);
    signal alu_out_mem : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_wb : std_logic_vector(4 downto 0);
    signal wb_stage_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal address_error : std_logic;
    signal npc_out_bpu : std_logic_vector(RISC_BIT - 1 downto 0);
    signal MUXA_CONTROL, MUXB_CONTROL, DRAM_WE, DRAM_RE, WB_MUX_SEL, RF_WE , JAL_SEL: std_logic;
    signal ALU_OPCODE : std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
    signal alu_forwarding_one, alu_forwarding_two, mem_forwarding_one, mem_forwarding_two : std_logic;
    signal alu_forwarding_value, mem_forwarding_value : std_logic_vector(RISC_BIT - 1 downto 0);

    component DLX
    generic(IR_SIZE      : integer := 32;       -- Instruction Register Size
            PC_SIZE      : integer := 32);       -- Program Counter Size
    port(clk : IN std_logic;
         reset : IN std_logic;
         npc_out_bpu : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         npc_out_if : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         instruction_fetched : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         ir_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         rd_out_id : OUT std_logic_vector(4 downto 0);
         npc_out_id : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         a_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         b_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         imm_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         alu_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         rd_out_ex : OUT std_logic_vector(4 downto 0);
         b_reg_out_ex : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         rd_out_mem : OUT std_logic_vector(4 downto 0);
         memory_stage_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         alu_out_mem : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         rd_out_wb : OUT std_logic_vector(4 downto 0);
         wb_stage_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         address_error : OUT std_logic;
         MUXA_CONTROL : OUT std_logic;
         MUXB_CONTROL : OUT std_logic;
         ALU_OPCODE : OUT std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
         DRAM_WE : OUT std_logic;
         DRAM_RE : OUT std_logic;
         WB_MUX_SEL : OUT std_logic;
         JAL_SEL : OUT std_logic;
         RF_WE : OUT std_logic;
         alu_forwarding_one : OUT std_logic;
         mem_forwarding_one : OUT std_logic;
         alu_forwarding_two : OUT std_logic;
         mem_forwarding_two : OUT std_logic;
         alu_forwarding_value : OUT std_logic_vector(IR_SIZE - 1 downto 0);
         mem_forwarding_value : OUT std_logic_vector(IR_SIZE - 1 downto 0));
    end component;

begin
  -- instance of DLX

  U1 : DLX
  generic map(SIZE_IR, SIZE_PC)
  port map(clk => clk,  --in
           reset => reset,  --in
           npc_out_bpu => npc_out_bpu,  --out
           npc_out_if => npc_out_if, 
           instruction_fetched => instruction_fetched,
           ir_out => ir_out,
           rd_out_id => rd_out_id,
           npc_out_id => npc_out_id,
           a_reg_out => a_reg_out,
           b_reg_out => b_reg_out,
           imm_reg_out => imm_reg_out,
           alu_out => alu_out,
           rd_out_ex => rd_out_ex,
           b_reg_out_ex => b_reg_out_ex,
           rd_out_mem => rd_out_mem,
           memory_stage_out => memory_stage_out,
           alu_out_mem => alu_out_mem,
           rd_out_wb => rd_out_wb,
           wb_stage_out => wb_stage_out,
           address_error => address_error,
           MUXA_CONTROL => MUXA_CONTROL,
           MUXB_CONTROL => MUXB_CONTROL,
           ALU_OPCODE => ALU_OPCODE,
           DRAM_WE => DRAM_WE,
           DRAM_RE => DRAM_RE,
           WB_MUX_SEL => WB_MUX_SEL,
           JAL_SEL => JAL_SEL,
           RF_WE => RF_WE,
           alu_forwarding_one => alu_forwarding_one,
           mem_forwarding_one => mem_forwarding_one,
           alu_forwarding_two => alu_forwarding_two,
           mem_forwarding_two => mem_forwarding_two,
           alu_forwarding_value => alu_forwarding_value,
           mem_forwarding_value => mem_forwarding_value);

  PCLOCK : process(clk)
	begin
		clk <= not(clk) after 1 ns;
	end process;

	reset <= '0' after 3 ns;

end behavioural;

configuration CFG_TB_DLX of tb_dlx_top  is
	for behavioural
    for U1 : DLX
      use configuration WORK.CFG_DLX;
    end for;
	end for;
end CFG_TB_DLX;
