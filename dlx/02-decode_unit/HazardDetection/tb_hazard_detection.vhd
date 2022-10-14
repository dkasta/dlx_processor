library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_HAZARD_DETECTION is
end TB_HAZARD_DETECTION;

architecture TEST of TB_HAZARD_DETECTION is

  signal clk : std_logic := '0';
  signal reset : std_logic := '1';
  signal OPCODE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000001";
  signal RD_REG_IN_ITYPE : std_logic_vector(4 downto 0);
  signal RD_REG_IN_RTYPE : std_logic_vector(4 downto 0);
  signal RS1_REG_IN : std_logic_vector(4 downto 0);
  signal RS2_REG_IN : std_logic_vector(4 downto 0);
  signal alu_forwarding_one : std_logic;
  signal mem_forwarding_one : std_logic;
  signal alu_forwarding_two : std_logic;
  signal mem_forwarding_two : std_logic;
  signal RD_OUT : std_logic_vector(4 downto 0);

  component HAZARD_DETECTION
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RD_REG_IN_ITYPE : IN std_logic_vector(4 downto 0);
       RD_REG_IN_RTYPE : IN std_logic_vector(4 downto 0);
       RS1_REG_IN : IN std_logic_vector(4 downto 0);
       RS2_REG_IN : IN std_logic_vector(4 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic;
       RD_OUT : OUT std_logic_vector(4 downto 0));
  end component;

  begin
    DUT : HAZARD_DETECTION
    port map(clk,reset,OPCODE,RD_REG_IN_ITYPE,RD_REG_IN_RTYPE,RS1_REG_IN,RS2_REG_IN,alu_forwarding_one,mem_forwarding_one,alu_forwarding_two,mem_forwarding_two,RD_OUT);

    OPCODE <= "000000", "001000" after 3 ns, "010101" after 5 ns,"001000" after 7 ns, "010101" after 9 ns;
    RD_REG_IN_ITYPE <= "00000" , "00001" after 3 ns, "00000" after 5 ns, "00010" after 7 ns, "00000" after 9 ns;
    RD_REG_IN_RTYPE <= "00000" , "00000" after 3 ns, "00000" after 5 ns, "00000" after 7 ns, "00000" after 9 ns;
    RS1_REG_IN <= "00000", "00000" after 3 ns, "00000" after 5 ns, "00001" after 7 ns, "00000" after 9 ns;
    RS2_REG_IN <= "00000", "00001" after 3 ns, "00000" after 5 ns, "00010" after 7 ns, "00000" after 9 ns;


    clk <= not clk after 1 ns;
    reset <= '0' after 3 ns;

end TEST;
