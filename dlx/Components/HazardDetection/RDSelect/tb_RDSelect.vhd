library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_RD_SELECT is
end TB_RD_SELECT;

architecture TEST of TB_RD_SELECT is

  signal OPCODE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000000";
  signal RD_REG_IN_RTYPE : std_logic_vector(4 downto 0);
  signal RD_REG_IN_ITYPE : std_logic_vector(4 downto 0);
  signal RD_OUT : std_logic_vector(4 downto 0);

  component RDSELECT
  port(OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RD_REG_IN_RTYPE : IN std_logic_vector(4 downto 0);
       RD_REG_IN_ITYPE : IN std_logic_vector(4 downto 0);
       RD_OUT : OUT std_logic_vector(4 downto 0));
  end component;

  begin
    DUT : RDSELECT
    port map(OPCODE,RD_REG_IN_RTYPE,RD_REG_IN_ITYPE,RD_OUT);

    OPCODE <= "000001" after 10 ns;

    RD_REG_IN_RTYPE <= "00000" , "00010" after 2 ns, "00011" after 4 ns, "00100" after 12 ns, "00101" after 14 ns;
    RD_REG_IN_ITYPE <= "00000", "00010" after 6 ns, "00011" after 8 ns, "00100" after 12 ns, "00101" after 14 ns;

end TEST;

configuration CFG_TB_RD_SELECT of TB_RD_SELECT is
  for TEST
    for DUT: RDSELECT
      use configuration WORK.CFG_RD_SELECT;
    end for;
  end for;
end CFG_TB_RD_SELECT;
