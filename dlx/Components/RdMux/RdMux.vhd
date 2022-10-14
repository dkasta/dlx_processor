--tested OK
--outputs a different input depending on the OPCODE in
--it is used to have the right rd depending on r-type or I-tpye operation

library IEEE;
use IEEE.std_logic_1164.all;
use WORK.myTypes.all;
use WORK.globals.all;

entity RDMUX is
  port( rtype_in:  in std_logic_vector(4 downto 0);
        itype_in:  in std_logic_vector(4 downto 0);
        opcode_in: in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
        rd_out:    out std_logic_vector(4 downto 0));
end RDMUX;

architecture BEHAVIORAL of RDMUX is
  begin
    process(opcode_in,rtype_in,itype_in)
    begin
      if(opcode_in <= RTYPE) then
        rd_out <= rtype_in;
      elsif (opcode_in = ITYPE_ADDI) or (opcode_in = ITYPE_ANDI) or (opcode_in = ITYPE_LW) or (opcode_in = ITYPE_ORI) or (opcode_in = ITYPE_SGEI) or (opcode_in = ITYPE_SLEI) or (opcode_in = ITYPE_SLLI) or (opcode_in = ITYPE_SNEI) or (opcode_in = ITYPE_SRLI) or (opcode_in = ITYPE_SUBI) or (opcode_in = ITYPE_SW) or (opcode_in = ITYPE_XORI) then
        rd_out <= itype_in;
      end if;
    end process;
end BEHAVIORAL;


