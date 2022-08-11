library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_BOFFSET is
end TB_BOFFSET;

architecture TEST of TB_BOFFSET is

  signal boffsetin : std_logic_vector(15 downto 0);
  signal boffsetout : std_logic_vector(31 downto 0);

  component BOFFSET
  port(BOFFSET_IN : IN std_logic_vector(15 downto 0);
       BOFFSET_OUT : OUT std_logic_vector(31 downto 0));
  end component;

  begin

    DUT : BOFFSET
    port map(boffsetin,boffsetout);

    boffsetin <= (others => '0'), (others => '1') after 10 ns;

end TEST;