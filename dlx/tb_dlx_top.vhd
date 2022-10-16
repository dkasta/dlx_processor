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
    signal clk: std_logic := '0';
    signal reset: std_logic := '1';
    signal EN1: std_logic := '0';
    signal npc_out_if_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal instruction_fetched_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal ir_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal npc_out_id_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal a_reg_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal b_reg_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal imm_reg_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal rd_out_id_signal : std_logic_vector(4 downto 0);
    signal alu_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal b_reg_out_ex_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal rd_out_ex_signal : std_logic_vector(4 downto 0);
    signal alu_out_mem_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal wb_stage_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
    signal rd_out_wb_signal : std_logic_vector(4 downto 0);

    component DLX
    generic(IR_SIZE      : integer := 32;       -- Instruction Register Size
            PC_SIZE      : integer := 32);       -- Program Counter Size
    port( clk : IN std_logic;
          reset : IN std_logic;
          EN1: IN std_logic;
          npc_out_if : OUT std_logic_vector(BIT_RISC - 1 downto 0);
          instruction_fetched : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          ir_out : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          npc_out_id: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          a_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          b_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          imm_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          rd_out_id: OUT  std_logic_vector(4 downto 0);
          alu_out : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          b_reg_out_ex : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          rd_out_ex : OUT  std_logic_vector(4 downto 0);
          alu_out_mem : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          wb_stage_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
          rd_out_wb:   out std_logic_vector(4 downto 0)
          );
    end component;

begin
  -- instance of DLX

  U1 : DLX
  generic map(SIZE_IR, SIZE_PC)
  port map( clk => clk,
            reset => reset,
            EN1 => EN1,
            npc_out_if => npc_out_if_signal,
            instruction_fetched => instruction_fetched_signal,
            ir_out => ir_out_signal,
            npc_out_id => npc_out_id_signal,
            a_reg_out => a_reg_out_signal,
            b_reg_out => b_reg_out_signal,
            imm_reg_out => imm_reg_out_signal,
            rd_out_id => rd_out_id_signal,
            alu_out => alu_out_signal,
            b_reg_out_ex => b_reg_out_ex_signal,
            rd_out_ex => rd_out_ex_signal,
            alu_out_mem => alu_out_mem_signal,
            rd_out_wb => rd_out_wb_signal,
            wb_stage_out => wb_stage_out_signal);

  PCLOCK : process(clk)
	begin
		clk <= not(clk) after 1 ns;
	end process;

	reset <= '0' after 3 ns;
  EN1 <= '1' after 9 ns;


end behavioural;

 