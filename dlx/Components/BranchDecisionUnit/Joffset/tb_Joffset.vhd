library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_JOFFSET is
end TB_JOFFSET;

architecture TEST of TB_JOFFSET is

  signal joffsetin : std_logic_vector(25 downto 0);
  signal joffsetout : std_logic_vector(31 downto 0);

  component JOFFSET
  port(JOFFSET_IN : IN std_logic_vector(25 downto 0);
       JOFFSET_OUT : OUT std_logic_vector(31 downto 0));
  end component;

  begin

    DUT : JOFFSET
    port map(joffsetin,joffsetout);

    joffsetin <= (others => '0'), (others => '1') after 10 ns;

end TEST;

configuration CFG_TB_JOFFSET of TB_JOFFSET is
  for TEST
    for DUT: JOFFSET
      use configuration WORK.CFG_JOFFSET;
    end for;
  end for;
end CFG_TB_JOFFSET;
