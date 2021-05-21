library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity comparator is
  generic (NBIT: integer := 32);
  port (C : in std_logic;
       sum : in std_logic_vector(NBIT-1 downto 0);
       sign : in std_logic;                     -- *sign* is used to support signed number too. sign <= A(31) xor B(31). 
                                                -- If operands have different different signs, *sign* makes difference. 
                                                -- If not, the comparator works as the operand had same sign
       gt : out std_logic;                      -- greater than
       get : out std_logic;                     -- greater equal than
       lt : out std_logic;                      -- less than
       let : out std_logic;                     -- less equal than
       eq : out std_logic;                      -- equal
       neq : out std_logic);                    -- not equal
       
       
end comparator;

architecture behav of comparator is

  signal Z, nC : std_logic;

begin

  Z <= '1' when sum = "00000000000000000000000000000000" else '0';          --zero detector
  
  nC <= C xor sign;         

  gt <= nC and (not Z);
  get <= nC;
  lt <= not nC;
  let <= (not nC) or Z;
  eq <= Z;
  neq <= not Z;

end behav;
