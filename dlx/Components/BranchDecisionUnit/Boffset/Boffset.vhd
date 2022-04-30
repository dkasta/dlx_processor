library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity BOFFSET is
  port(BOFFSET_IN : IN std_logic_vector(15 downto 0);
       BOFFSET_OUT : OUT std_logic_vector(31 downto 0));
end BOFFSET;

architecture BEHAVIORAL of BOFFSET is

  signal boff : std_logic_vector(15 downto 0);
  signal boffout : std_logic_vector(31 downto 0);

  begin

    boff <= BOFFSET_IN;
    BOFFSET_OUT <= boffout;

    JOFFSETPROCESS : process(boff)
    begin
      if(boff(15) = '1') then
        boffout <= "1111111111111111" & boff;
      else
        boffout <= "0000000000000000" & boff;
      end if;
    end process;

end BEHAVIORAL;

configuration CFG_BOFFSET of BOFFSET is
  for BEHAVIORAL
  end for;
end CFG_BOFFSET;
