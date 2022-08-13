library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;
use WORK.myTypes.all;

entity TB_RDMUX is
end TB_RDMUX;

architecture TEST of TB_RDMUX is

  signal rtype_in : std_logic_vector(4 downto 0);
  signal itype_in : std_logic_vector(4 downto 0);
  signal opcode_in : std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal rd_out : std_logic_vector(4 downto 0);

  component RDMUX
  port(rtype_in : IN std_logic_vector(4 downto 0);
       itype_in : IN std_logic_vector(4 downto 0);
       opcode_in : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       rd_out : OUT std_logic_vector(4 downto 0));
  end component;

  begin

    DUT : RDMUX
    port map(rtype_in,itype_in,opcode_in,rd_out);

    rtype_in <= "00000", "00001" after 1 ns, "00000" after 3 ns;
    itype_in <= "00000", "11110" after 3 ns, "00001" after 5 ns;
    opcode_in <= "000000", "000001" after 2 ns, "111110" after 4 ns, "000000" after 6 ns;

  end TEST;