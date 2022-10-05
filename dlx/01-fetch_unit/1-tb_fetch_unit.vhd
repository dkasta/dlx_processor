--connected the npc out to pc in to simulate a program running
--unit works as expected

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;

entity tb_fetch_unit is
end tb_fetch_unit;

architecture behavioural of tb_fetch_unit is

  constant NBIT : integer := I_SIZE;
  signal TB_PC : std_logic_vector(NBIT-1 downto 0) := (others => '0');
  signal TB_TO_IRAM : std_logic_vector(NBIT-1 downto 0);
  signal TB_TO_IR : std_logic_vector(NBIT-1 downto 0) := (others => '0');
  signal TB_NPC_OUT : std_logic_vector(NBIT-1 downto 0);
  signal TB_INSTRUCTION_REG_OUT : std_logic_vector(NBIT-1 downto 0);
  signal TB_RESET : std_logic := '1';
  signal TB_CLOCK : std_logic := '0';
  signal TB_TO_IR_signal : std_logic_vector(NBIT-1 downto 0) := (others => '0');
  signal TB_EN_PC : std_logic := '0';
  
  component fetch_unit
  generic(numbit : integer := I_SIZE);
  port(to_IR : IN std_logic_vector(numbit-1 downto 0);
       clk : IN std_logic;
       rst : IN std_logic;
       EN1:  IN std_logic;
       to_IRAM : OUT std_logic_vector(numbit - 1 downto 0);
       npc_out : OUT std_logic_vector(numbit-1 downto 0);
       instr_reg_out : OUT std_logic_vector(numbit-1 downto 0);
       instr_fetched:   OUT std_logic_vector(numbit-1 downto 0));
  end component;

  begin
    DUT : fetch_unit
    generic map(NBIT)
    port map(to_IR => TB_TO_IR,
             clk => TB_CLOCK,
             rst => TB_RESET,
             EN1 => TB_EN_PC,
             to_IRAM => TB_TO_IRAM,
             npc_out => TB_NPC_OUT,
             instr_reg_out => TB_INSTRUCTION_REG_OUT,
             instr_fetched => TB_TO_IR_signal);

    --TB_TO_IR <= (others => '1') after 2 ns;
    TB_RESET <= '1', '0' after 11 ns;
    TB_EN_PC <= '0', '1' after 13 ns;
    PCLOCK : process(TB_CLOCK)
    begin
      TB_CLOCK <= not(TB_CLOCK) after 1 ns;
    end process;

end behavioural;

