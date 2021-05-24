library ieee;
use ieee.std_logic_1164.all;

package CONSTANTS is
   constant IVDELAY : time := 0.1 ns;
   constant NDDELAY : time := 0.2 ns;
   constant NDDELAYRISE : time := 0.6 ns;
   constant NDDELAYFALL : time := 0.4 ns;
   constant NRDELAY : time := 0.2 ns;
   constant DRCAS : time := 0 ns;
   constant DRCAC : time := 0 ns;
   constant numBit : integer := 4;
   constant tp_mux : time := 0.5 ns;
   constant NBIT_PER_BLOCK : integer := 4;
   constant NBIT: integer := 32;
   constant NBLOCKS : integer := NBIT/NBIT_PER_BLOCK;
   constant N : integer := 2;
   constant NBIT_OPCODE: integer := 11;
   constant FUNC_ADD: std_logic_vector(NBIT_OPCODE-1 downto 0) := "00000000001";
   constant FUNC_SUB: std_logic_vector(NBIT_OPCODE-1 downto 0) := "00000000010";

end CONSTANTS;
