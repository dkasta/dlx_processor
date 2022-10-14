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
    signal EN1: std_logic := '0';
    signal npc_out_if : std_logic_vector(RISC_BIT - 1 downto 0);
    signal instruction_fetched : std_logic_vector(RISC_BIT - 1 downto 0);
    signal ir_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal npc_out_id : std_logic_vector(RISC_BIT - 1 downto 0);
    signal a_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal b_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal imm_reg_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_id : std_logic_vector(RISC_BIT-1 downto 0);
    signal alu_out : std_logic_vector(RISC_BIT - 1 downto 0);
    signal b_reg_out_ex : std_logic_vector(RISC_BIT - 1 downto 0);
    signal rd_out_ex : std_logic_vector(4 downto 0);
    signal alu_out_mem : std_logic_vector(RISC_BIT - 1 downto 0);
    signal wb_stage_out : std_logic_vector(RISC_BIT - 1 downto 0);
    

    component DLX
    generic(IR_SIZE      : integer := 32;       -- Instruction Register Size
            PC_SIZE      : integer := 32);       -- Program Counter Size
    port( clk : IN std_logic;
          reset : IN std_logic;
          EN1: IN std_logic;
          npc_out_if : OUT std_logic_vector(RISC_BIT - 1 downto 0);
          instruction_fetched : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          ir_out : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          npc_out_id: OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          a_reg_out: OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          b_reg_out: OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          imm_reg_out: OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          rd_out_id: OUT  std_logic_vector(4 downto 0);
          alu_out : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          b_reg_out_ex : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          rd_out_ex : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          alu_out_mem : OUT  std_logic_vector(RISC_BIT - 1 downto 0);
          wb_stage_out: OUT  std_logic_vector(RISC_BIT - 1 downto 0); );
    end component;

begin
  -- instance of DLX

  U1 : DLX
  generic map(SIZE_IR, SIZE_PC)
  port map( clk => clk,
            reset => reset,
            EN1 => EN1,
            npc_out_if => npc_out_if,
            instruction_fetched => instruction_fetched,
            ir_out => ir_out,
            npc_out_id => npc_out_id,
            a_reg_out => a_reg_out,
            b_reg_out => b_reg_out,
            imm_reg_out => imm_reg_out,
            rd_out_id => rd_out_id,
            alu_out => alu_out,
            b_reg_out_ex => b_reg_out_ex,
            rd_out_ex => rd_out_ex,
            alu_out_mem => alu_out_mem,
            wb_stage_out => );

  PCLOCK : process(clk)
	begin
		clk <= not(clk) after 1 ns;
	end process;

	reset <= '0' after 3 ns;
  EN1 <= '1' after 10 ns;


end behavioural;

configuration CFG_TB_DLX of tb_dlx_top  is
	for behavioural
    for U1 : DLX
      use configuration WORK.CFG_DLX;
    end for;
	end for;
end CFG_TB_DLX;
