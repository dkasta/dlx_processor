-- generic register with syncronous reset described structurally using
-- positive edge triggered flip flop D

library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;

entity register_generic is
  generic (NBIT : integer := Bit_Register);
      port(   D:     in std_logic_vector(NBIT-1 downto 0);
              CK:    in std_logic;
	      EN:    in std_logic;
              RESET: in std_logic;
              Q:     out std_logic_vector(NBIT-1 downto 0));
end register_generic;

architecture structural of register_generic is

  component DFF is
  port (	D:      in	std_logic;
		en:	in std_logic;
		      CK:	    in	std_logic;
		      RESET:  in	std_logic;
		      Q:	    out	std_logic);
  end component;

  begin
    Register_generate : for i in 0 to NBIT-1 generate
      UFD : DFF
            port map( D=>D(i),en=>EN, CK=>CK, RESET=>RESET, Q=>Q(i));
    end generate Register_generate;
end structural;



