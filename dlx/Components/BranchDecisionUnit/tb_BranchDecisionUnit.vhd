library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_BRANCHDECISIONUNIT is
end TB_BRANCHDECISIONUNIT;

architecture TEST of TB_BRANCHDECISIONUNIT is

  signal OPCODE : std_logic_vector(5 downto 0) := (others => '0');
  signal JOFFSET : std_logic_vector(25 downto 0) := (others => '0');
  signal BOFFSET : std_logic_vector(15 downto 0) := (others => '0');
  signal NPC_IN : std_logic_vector(31 downto 0);
  signal NPC_OUT : std_logic_vector(31 downto 0);
  signal REG1_IN : std_logic_vector(31 downto 0) := (others => '0');
  signal REG2_IN : std_logic_vector(31 downto 0) := (others => '0');

  component BRANCHDECISIONUNIT
  port(OPCODE : IN std_logic_vector(5 downto 0);
       JOFFSET_IN : IN std_logic_vector(25 downto 0);
       BOFFSET_IN : IN std_logic_vector(15 downto 0);
       NPC_IN : IN std_logic_vector(31 downto 0);
       REG1_IN : IN std_logic_vector(31 downto 0);
       REG2_IN : IN std_logic_vector(31 downto 0);
       NPC_OUT : OUT std_logic_vector(31 downto 0));
  end component;

  begin

    DUT : BRANCHDECISIONUNIT
    port map(OPCODE,JOFFSET,BOFFSET,NPC_IN,REG1_IN,REG2_IN,NPC_OUT);

    OPCODE <= "000010" after 2 ns, "000100" after 14 ns, "000101" after 18 ns, "111111" after 24 ns, "000011" after 40 ns, "010010" after 44 ns, "010011" after 48 ns;
    JOFFSET <= "11111111111111111111111100" after 2 ns, "11111111110000000011111111" after 14 ns, "11111111110000111100001111" after 18 ns, "11111111111111111111111111" after 24 ns;
    BOFFSET <= "1111111111110000" after 2 ns, "0000000011111111" after 14 ns, "0000111100001111" after 18 ns, "1111111111111111" after 24 ns;
    NPC_IN <= "00000000000000000000000000101000";
    REG1_IN <= (others => '1') after 6 ns, (others => '0') after 10 ns, "00000000000000000000000000001111" after 40 ns;

end TEST;