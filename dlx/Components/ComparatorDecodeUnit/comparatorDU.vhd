library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;


entity COMPARATOR is
    generic ( NBIT : integer := Bit_Register;
              OPCODE_SIZE : integer := OP_CODE_SIZE);
        port ( opcode_in : in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
            data_in : in std_logic_vector(NBIT-1 downto 0);
            data_out : out std_logic);
end COMPARATOR;

architecture BEHAVIOURAL of COMPARATOR is
begin

    proc: process(opcode_in, data_in)
        begin
            if (opcode_in = ITYPE_BEQZ) then 
                if (data_in = (NBIT - 1 downto 0 => '0') ) then
                    data_out <= '1';
                else
                    data_out <= '0';
                end if;
            elsif (opcode_in = ITYPE_BNEZ) then 
                if (data_in /= (NBIT - 1 downto 0 => '0')) then
                    data_out <= '1';
                else
                    data_out <= '0';
                end if;
            elsif (opcode_in = JTYPE_J) then 
                data_out <= '1';
            elsif (opcode_in = JTYPE_JAL) then 
                data_out <= '1';
            else
                data_out <= '0';
            end if;
    end process;

end BEHAVIOURAL;
