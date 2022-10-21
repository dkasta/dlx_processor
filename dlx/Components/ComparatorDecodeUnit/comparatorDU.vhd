library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;


entity COMPARATORDU is
    generic ( NBIT : integer := Bit_Register;
              OPCODE_SIZE : integer := OP_CODE_SIZE);
        port ( opcode_in : in std_logic_vector(OPCODE_SIZE - 1 downto 0);
            data_in : in std_logic_vector(NBIT-1 downto 0);
            nop_add : in std_logic;
            data_out : out std_logic_vector(1 downto 0));
end COMPARATORDU;

architecture BEHAVIOURAL of COMPARATORDU is
begin

    proc: process(opcode_in, data_in, nop_add)
        variable branch_flag : integer;  
        begin
            if(nop_add = '0') then
                if (opcode_in = ITYPE_BEQZ) then 
                    if (data_in = (NBIT - 1 downto 0 => '0') ) then

                        data_out <= "00";
                    else
                        data_out <= "10";
                    end if;
                elsif (opcode_in = ITYPE_BNEZ) then 
                    if (data_in /= (NBIT - 1 downto 0 => '0')) then
                        data_out <= "00";
                    else
                        data_out <= "10";
                    end if;
                elsif (opcode_in = JTYPE_J) then 
                    data_out <= "00";
                elsif (opcode_in = JTYPE_JAL) then 
                    data_out <= "00";
                elsif (opcode_in = JTYPE_RET) then 
                    data_out <= "01";
                elsif (opcode_in = JTYPE_CALL) then
                    data_out <= "01";
                else
                    data_out <= "10";
                end if;
            else
                data_out <= "11";
            end if;
    end process;

end BEHAVIOURAL;
