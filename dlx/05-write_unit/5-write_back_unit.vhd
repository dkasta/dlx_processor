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
           WB_OUT:         out std_logic_vector(N-1 downto 0);
           mem_forwarding_one_vector:     out std_logic_vector(numbit-1 downto 0);
           mem_forwarding_two_vector:     out std_logic_vector(numbit-1 downto 0));
end write_back_unit;

architecture structural of write_back_unit is

  component MUX21_GENERIC
  generic( NBIT: integer := Bit_Mux21);
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
    port map( A => LMD,
              B => ALUOUT,
              SEL => mux_wb_control,
              Y => WB_OUT);

RD_OUT <= RD_IN;
mem_forwarding_one <= LMD;
mem_forwarding_two <= LMD;
end structural;

