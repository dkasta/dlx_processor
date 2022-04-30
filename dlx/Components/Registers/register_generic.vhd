-- RESET is active high, so if RESET is 1 the register has '0' at the output
--test : tested OK, the component works as expected

library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;

entity register_generic is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              CK:    in std_logic;
              RESET: in std_logic;
              Q:     out std_logic_vector(NBIT-1 downto 0));
end register_generic;

architecture structural of register_generic is

  component DFF is
  port (	D:      in	std_logic;
		      CK:	    in	std_logic;
		      RESET:  in	std_logic;
		      Q:	    out	std_logic);
  end component;

  begin
    Register_generate : for i in 0 to NBIT-1 generate
      UFD : DFF
            port map( D(i), CK, RESET, Q(i));
    end generate Register_generate;
end structural;



