library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity tb_write_back_unit is
end tb_write_back_unit;

architecture TEST of tb_write_back_unit is

  constant NBIT : integer := BIT_RISC;
  signal s_LMD : std_logic_vector(NBIT-1 downto 0);
  signal s_ALU_OUT : std_logic_vector(NBIT-1 downto 0);
  signal s_CONTROL : std_logic;
  signal s_WB_OUT : std_logic_vector(NBIT-1 downto 0);
  signal s_RD_IN : std_logic_vector(4 downto 0) := "00111";
  signal s_RD_OUT : std_logic_vector(4 downto 0);
  signal s_JAL_SEL : std_logic := '0';

  component write_back_unit
  generic(N : integer := BIT_RISC);
  port(LMD : IN std_logic_vector(N-1 downto 0);
      ALUOUT : IN std_logic_vector(N-1 downto 0);
      RD_IN : IN std_logic_vector(4 downto 0);
      CONTROL : IN std_logic;
      JAL_SEL : IN std_logic;
      RD_OUT : OUT std_logic_vector(4 downto 0);
      WB_OUT : OUT std_logic_vector(N-1 downto 0));
  end component;

  begin
    DUT : write_back_unit
    generic map(NBIT)
    port map(s_LMD, s_ALU_OUT, s_RD_IN, s_CONTROL, s_JAL_SEL, s_RD_OUT, s_WB_OUT);

    s_LMD <= "00001111000011110000111100001111";
    s_ALU_OUT <= "11110000111100001111000011110000";
    s_CONTROL <= '0', '1' after 5 ns;
    s_JAL_SEL <= '1' after 20 ns;

end TEST;