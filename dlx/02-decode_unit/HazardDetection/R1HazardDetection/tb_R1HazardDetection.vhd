library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_R1_HAZARD_DETECTION is
end TB_R1_HAZARD_DETECTION;

architecture TEST of TB_R1_HAZARD_DETECTION is

  signal clk : std_logic := '1';
  signal reset : std_logic := '1';
  signal OPCODE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000000";
  signal RD_REG_IN : std_logic_vector(4 downto 0);
  signal alu_forwarding_one : std_logic;
  signal mem_forwarding_one : std_logic;
  signal reg_one : std_logic_vector(4 downto 0);
  signal reg_two : std_logic_vector(4 downto 0);
  signal reg_three : std_logic_vector(4 downto 0);
  signal TYPE_OUT : std_logic_vector(4 downto 0);
  signal RS1_REG_IN : std_logic_vector(4 downto 0);
  signal RS1_OUT : std_logic_vector(4 downto 0);
  signal rs1_one : std_logic_vector(4 downto 0);
  signal rs1_two : std_logic_vector(4 downto 0);
  signal rs1_three : std_logic_vector(4 downto 0);

  component R1_HAZARD_DETECTION
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS1_REG_IN : IN std_logic_vector(4 downto 0);
       RD_REG_IN : IN std_logic_vector(4 downto 0);
       TYPE_OUT : OUT std_logic_vector(4 downto 0);
       reg_one : OUT std_logic_vector(4 downto 0);
       reg_two : OUT std_logic_vector(4 downto 0);
       reg_three : OUT std_logic_vector(4 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       RS1_OUT : OUT std_logic_vector(4 downto 0);
       rs1_one : OUT std_logic_vector(4 downto 0);
       rs1_two : OUT std_logic_vector(4 downto 0);
       rs1_three : OUT std_logic_vector(4 downto 0));
  end component;

  begin
    DUT : R1_HAZARD_DETECTION
    port map(clk,reset,OPCODE,RS1_REG_IN,RD_REG_IN,TYPE_OUT,reg_one,reg_two,reg_three,alu_forwarding_one,mem_forwarding_one,RS1_OUT,rs1_one,rs1_two,rs1_three);

    OPCODE <= "000001" after 10 ns, "001110" after 40 ns;

    RD_REG_IN <= "00000", "00010" after 2 ns, "00101" after 4 ns, "00100" after 6 ns, "00011" after 8 ns, "00000" after 10 ns, "11111" after 12 ns, "00000" after 14 ns, "11100" after 40 ns;
    RS1_REG_IN <= "00000", "00010" after 4 ns, "00101" after 6 ns, "00101" after 8 ns, "00101" after 10 ns, "11111" after 12 ns, "00111" after 14 ns, "10101" after 16 ns, "11100" after 18 ns;

    clk <= not clk after 1 ns;
    reset <= '0' after 2 ns;

end TEST;