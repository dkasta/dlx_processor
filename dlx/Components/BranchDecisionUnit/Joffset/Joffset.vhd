library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity JOFFSET is
  port(JOFFSET_IN : IN std_logic_vector(25 downto 0);
       JOFFSET_OUT : OUT std_logic_vector(31 downto 0));
end JOFFSET;

architecture BEHAVIORAL of JOFFSET is

  signal joff : std_logic_vector(25 downto 0);
  signal joffout : std_logic_vector(31 downto 0);

  begin

    joff <= JOFFSET_IN;
    JOFFSET_OUT <= joffout;

    JOFFSETPROCESS : process(joff)
    begin
      if(joff(25) = '1') then
        joffout <= "111111" & joff;
      else
        joffout <= "000000" & joff;
      end if;
    end process;

end BEHAVIORAL;

configuration CFG_JOFFSET of JOFFSET is
  for BEHAVIORAL
  end for;
end CFG_JOFFSET;
