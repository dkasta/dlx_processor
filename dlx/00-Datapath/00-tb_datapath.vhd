library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;
use WORK.myTypes.all;
use WORK.all;

entity tb_datapath is
end tb_datapath;

architecture behavioural of tb_datapath is

  signal IR_IN  : std_logic_vector(NBIT-1 downto 0) := (others => '0');  --RTYPE ADD RS1 1 RS2 2 RD 3
signal to_IRAM_address_signal : std_logic_vector(NBIT-1 downto 0);
  signal  npc_out_if_signal : std_logic_vector(NBIT-1 downto 0);
  signal  instruction_fetched_signal : std_logic_vector(NBIT-1 downto 0);
 signal   ir_out_signal : std_logic_vector(NBIT-1 downto 0);
 signal   npc_out_id_signal : std_logic_vector(NBIT-1 downto 0);
  signal  a_reg_out_signal : std_logic_vector(NBIT-1 downto 0);
  signal  b_reg_out_signal : std_logic_vector(NBIT-1 downto 0);
 signal   imm_reg_out_signal : std_logic_vector(NBIT-1 downto 0);
  signal  rd_out_id_signal : std_logic_vector(5-1 downto 0);
  signal  alu_out_signal : std_logic_vector(NBIT-1 downto 0);
 signal   b_reg_out_ex_signal : std_logic_vector(NBIT-1 downto 0);
 signal   rd_out_ex_signal : std_logic_vector(5-1 downto 0);
 signal   DRAM_addr_signal : std_logic_vector(NBIT-1 downto 0);
 signal   DRAM_data_in_signal : std_logic_vector(NBIT-1 downto 0);
 signal   alu_out_mem_signal : std_logic_vector(NBIT-1 downto 0);
signal    wb_stage_out_signal : std_logic_vector(NBIT-1 downto 0);
 signal   FLUSH_signal : std_logic_vector(1 downto 0);

  signal clk : std_logic := '0';
  signal reset : std_logic := '1';
  signal EN1 : std_logic := '0';

component datapath
  generic( numbit: integer := BIT_RISC);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           ------------------------------------------------------------------
           -- IF input
           EN1:                   in std_logic;
           to_IR:                 in std_logic_vector(numbit - 1 downto 0); -- In from IRAM
           ------------------------------------------------------------------
           -- ID input
           jal_mux_control:        in std_logic;
           write_enable:          in std_logic;
           rd1_enable:            in std_logic;
           rd2_enable:            in std_logic;
           call:                  in std_logic;
           ret:                   in std_logic;
           imm_mux_control:        in std_logic;
           EN2:                   in std_logic;
           ------------------------------------------------------------------
           -- EXE input
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(4 downto 0);
           EN3:                    in std_logic;
           -----------------------------------------------------------------
           -- MEM input
           mux_mem_control:       in std_logic;
           EN4:       in std_logic;
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
           DRAM_addr:             out std_logic_vector(numbit - 1 downto 0);
           DRAM_data_in:           out std_logic_vector(numbit - 1 downto 0);
           alu_out_mem:           out std_logic_vector(numbit - 1 downto 0);

           wb_stage_out:          out std_logic_vector(numbit - 1 downto 0);
           FLUSH:                  out std_logic_vector (1 downto 0)
           );
end component;

begin
  -- instance of DLX

  U1 : datapath
  generic map(32)
  port map( clk => clk,
           reset => reset,
           ------------------------------------------------------------------
           -- IF input
           EN1 => EN1,
           to_IR => IR_IN,
           ------------------------------------------------------------------
           -- ID input
           jal_mux_control => '1',
           write_enable => '0',
           rd1_enable => '1',
           rd2_enable => '1',
           call => '0',
           ret => '1',
           imm_mux_control => '0',
           EN2 => '1',
           ------------------------------------------------------------------
           -- EXE input
           mux_one_control => '1',     
           mux_two_control => '0',
           alu_control => "00001",
           EN3 => '1',
           -----------------------------------------------------------------
           -- MEM input
           mux_mem_control => '0',
           EN4 => '1',
           DRAM_to_mux => "00000000000000000000000000000000",
           ------------------------------------------------------------------
           -- WB input 
           mux_wb_control => '1',
           ------------------------------------------------------------------
           -- IF output
           to_IRAM => to_IRAM_address_signal,
           npc_out_if => npc_out_if_signal,
           instruction_fetched => instruction_fetched_signal,
           ir_out => ir_out_signal,

           ------------------------------------------------------------------
           -- ID output
           npc_out_id => npc_out_id_signal,
           a_reg_out => a_reg_out_signal,
           b_reg_out => b_reg_out_signal,
           imm_reg_out => imm_reg_out_signal,
           rd_out_id => rd_out_id_signal,
           ------------------------------------------------------------------
           -- EXE output
           alu_out => alu_out_signal,
           b_reg_out_ex => b_reg_out_ex_signal,
           rd_out_ex => rd_out_ex_signal,
           ------------------------------------------------------------------
           --MEM output
           DRAM_addr => DRAM_addr_signal,
           DRAM_data_in => DRAM_data_in_signal,
           alu_out_mem => alu_out_mem_signal,

           wb_stage_out => wb_stage_out_signal,
           FLUSH => FLUSH_signal
           );

  PCLOCK : process(clk)
	begin
		clk <= not(clk) after 1 ns;
	end process;

	reset <= '0' after 3 ns;
  EN1 <= '1' after 10 ns;

IR_IN <= "00000000010000110000100000100000" after 10 ns, "00101000001000010000000000001010" after 15 ns; --"00100000011000110000000000001010" after 7 ns, "00000000011000010010000000100000" after 9 ns, "00010100001000001111111111110000" after 11 ns, "00001011111111111111111111111100" after 13 ns;

end behavioural;

 