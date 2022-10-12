library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

entity memory_unit is
  generic( numbit: integer := BIT_RISC);
  port(    alu_in:            in std_logic_vector(numbit - 1 downto 0);
           rd_reg_in:         in std_logic_vector(4 downto 0);
           b_reg_in:          in std_logic_vector(numbit - 1 downto 0);
           reset:             in std_logic;
           clk:               in std_logic;
           mux_mem_control:   in std_logic;
           EN4:               in std_logic;
           to_mem_stage_reg:  in std_logic_vector(numbit - 1 downto 0);
           alu_out:           out std_logic_vector(numbit - 1 downto 0);
           rd_reg_out:        out std_logic_vector(4 downto 0);
           b_reg_out:         out std_logic_vector(numbit-1 downto 0);
           DRAM_addr:         out std_logic_vector(numbit-1 downto 0);
           );
end memory_unit;

architecture structural of memory_unit is

  component REGISTER_GENERIC
    generic( NBIT: integer := Bit_Register);
    port(    D:     in std_logic_vector(NBIT-1 downto 0);
             CK:    in std_logic;
             RESET: in std_logic;
             Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;

  component MUX21_GENERIC
    generic( NBIT: integer := Bit_Mux21);
    port(    A:    in std_logic_vector(NBIT-1 downto 0);
             B:    in std_logic_vector(NBIT-1 downto 0);
             SEL:  in std_logic;
             Y:    out std_logic_vector(NBIT-1 downto 0));
    end component;

  signal mux_out : std_logic_vector(numbit-1 downto 0);
  signal alu_mux_out : std_logic_vector(numbit-1 downto 0);


  begin

    MUX_MEM : MUX21_GENERIC
    generic map(numbit)
    port map(alu_in,to_mem_stage_reg,mux_mem_control,mux_out);

    RDREG : REGISTER_GENERIC
    generic map(5)
    port map(rd_reg_in,clk,reset,rd_reg_out);

    memory_stage_out <= to_mem_stage_reg;

    REGALU : REGISTER_GENERIC
    generic map(numbit)
    port map(mux_out,clk,reset,alu_mux_out);

end structural;

