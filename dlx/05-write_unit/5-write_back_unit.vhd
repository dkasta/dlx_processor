-- the write back stage is modelled as multiplexer whose inputs are LMD and ALUOUT signals

library IEEE;
use IEEE.std_logic_1164.all;
use WORK.globals.all;

entity write_back_unit is
  generic( N: integer := BIT_RISC);
  port(    LMD:            in std_logic_vector(N-1 downto 0);
           ALUOUT:         in std_logic_vector(N-1 downto 0);
           RD_IN:          in std_logic_vector(4 downto 0);
           mux_wb_control: in std_logic;
           RD_OUT:         out std_logic_vector(4 downto 0);
           WB_OUT:         out std_logic_vector(N-1 downto 0));
end write_back_unit;

architecture structural of write_back_unit is

  component MUX21_GENERIC
  generic( NBIT: integer := NumBitMux21);
  port(    A:   in std_logic_vector(NBIT-1 downto 0);
           B:   in std_logic_vector(NBIT-1 downto 0);
           SEL: in std_logic;
           Y:   out std_logic_vector(NBIT-1 downto 0));
  end component;

  signal mux_out : std_logic_vector(BIT_RISC - 1 downto 0);
  signal jal_mux_out : std_logic_vector(4 downto 0);

  begin
    MUX_WB : MUX21_GENERIC
    generic map(BIT_RISC)
    port map( LMD => LMD,
              ALUOUT => ALUOUT,
              mux_wb_control => mux_wb_control,
              RD_OUT => RD_OUT,
              WB_OUT => WB_OUT);


end structural;

