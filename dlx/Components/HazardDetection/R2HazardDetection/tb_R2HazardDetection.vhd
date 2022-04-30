library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_R2_HAZARD_DETECTION is
end TB_R2_HAZARD_DETECTION;

architecture TEST of TB_R2_HAZARD_DETECTION is

  signal clk : std_logic := '1';
  signal reset : std_logic := '1';
  signal OPCODE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000000";
  signal RD_REG_IN : std_logic_vector(4 downto 0);
  signal alu_forwarding_two : std_logic;
  signal mem_forwarding_two : std_logic;
  signal reg_one : std_logic_vector(4 downto 0);
  signal reg_two : std_logic_vector(4 downto 0);
  signal reg_three : std_logic_vector(4 downto 0);
  signal TYPE_OUT : std_logic_vector(4 downto 0);
  signal RS2_REG_IN : std_logic_vector(4 downto 0);
  signal RS2_OUT : std_logic_vector(4 downto 0);
  signal rs2_one : std_logic_vector(4 downto 0);
  signal rs2_two : std_logic_vector(4 downto 0);
  signal rs2_three : std_logic_vector(4 downto 0);

  component R2_HAZARD_DETECTION
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS2_REG_IN : IN std_logic_vector(4 downto 0);
       RD_REG_IN : IN std_logic_vector(4 downto 0);
       TYPE_OUT : OUT std_logic_vector(4 downto 0);
       reg_one : OUT std_logic_vector(4 downto 0);
       reg_two : OUT std_logic_vector(4 downto 0);
       reg_three : OUT std_logic_vector(4 downto 0);
       RS2_OUT : OUT std_logic_vector(4 downto 0);
       rs2_one : OUT std_logic_vector(4 downto 0);
       rs2_two : OUT std_logic_vector(4 downto 0);
       rs2_three : OUT std_logic_vector(4 downto 0);
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic);
  end component;

  begin
    DUT : R2_HAZARD_DETECTION
    port map(clk,reset,OPCODE,RS2_REG_IN,RD_REG_IN,TYPE_OUT,reg_one,reg_two,reg_three,RS2_OUT,rs2_one,rs2_two,rs2_three,alu_forwarding_two,mem_forwarding_two);

    OPCODE <= "000001" after 40 ns;

    RD_REG_IN <= "00000", "00010" after 4 ns, "00101" after 6 ns, "00100" after 8 ns, "00011" after 10 ns, "00000" after 12 ns, "11111" after 14 ns, "00000" after 16 ns;
    RS2_REG_IN <= "00000", "00010" after 6 ns, "00101" after 8 ns, "00101" after 10 ns, "00101" after 12 ns, "11111" after 14 ns, "00111" after 16 ns, "10101" after 18 ns, "11100" after 20 ns;

    clk <= not clk after 1 ns;
    reset <= '0' after 4 ns;

end TEST;

configuration CFG_TB_R2_HAZARD_DETECTION of TB_R2_HAZARD_DETECTION is
  for TEST
    for DUT: R2_HAZARD_DETECTION
      use configuration WORK.CFG_R2_HAZARD_DETECTION;
    end for;
  end for;
end CFG_TB_R2_HAZARD_DETECTION;
