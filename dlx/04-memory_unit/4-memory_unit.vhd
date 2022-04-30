--test : tested OK, the component works as expected

library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

entity memory_unit is
  generic( numbit: integer := BIT_RISC);
  port(    alu_in:            in std_logic_vector(numbit - 1 downto 0);
           rd_reg_in:         in std_logic_vector(4 downto 0);
           reset:             in std_logic;
           clk:               in std_logic;
           to_mem_stage_reg:  in std_logic_vector(numbit - 1 downto 0);
           rd_reg_out:        out std_logic_vector(4 downto 0);
           memory_stage_out:  out std_logic_vector(numbit-1 downto 0);
           alu_out:           out std_logic_vector(numbit - 1 downto 0));
end memory_unit;

architecture structural of memory_unit is

  component REGISTER_GENERIC
    generic( NBIT: integer := NumBitRegister);
    port(    D:     in std_logic_vector(NBIT-1 downto 0);
             CK:    in std_logic;
             RESET: in std_logic;
             Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;

  begin

    RDREG : REGISTER_GENERIC
    generic map(5)
    port map(rd_reg_in,clk,reset,rd_reg_out);

    memory_stage_out <= to_mem_stage_reg;

    REGALU : REGISTER_GENERIC
    generic map(numbit)
    port map(alu_in,clk,reset,alu_out);

end structural;

