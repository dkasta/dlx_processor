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
            alu_branch_out: in std_logic_vector(NBIT-1 downto 0);
            nop_add : in std_logic;
            data_out : out std_logic_vector(2 downto 0));
end COMPARATORDU;

architecture BEHAVIOURAL of COMPARATORDU is
signal bnez_flag: std_logic := '0';
signal beqz_flag: std_logic := '0';

begin

    proc: process(opcode_in, data_in, nop_add, alu_branch_out)
    
        begin
            if(nop_add = '0') then
                if (opcode_in = ITYPE_BEQZ) then 
                    if (beqz_flag = '1') and (alu_branch_out = "00000000000000000000000000000001") then
                        data_out <= "000";
                        beqz_flag <= '0';  
                    else
                        data_out <= "111";
                        beqz_flag <= '1';
                    end if;
                elsif (opcode_in = ITYPE_BNEZ) then 
                    if (bnez_flag = '1') and (alu_branch_out = "00000000000000000000000000000001") then
                        data_out <= "000";
                        bnez_flag <= '0';  
                    else
                        data_out <= "111";
                        bnez_flag <= '1';
                    end if;
                elsif (opcode_in = JTYPE_J) then 
                    data_out <= "000";
                elsif (opcode_in = JTYPE_JAL) then 
                    data_out <= "000";
                elsif (opcode_in = JTYPE_RET) then 
                    data_out <= "101";
                elsif (opcode_in = JTYPE_CALL) then
                    data_out <= "101";
                else
                    data_out <= "110";
                end if;
            else
                data_out <= "111";
            end if;
    end process;

end BEHAVIOURAL;
