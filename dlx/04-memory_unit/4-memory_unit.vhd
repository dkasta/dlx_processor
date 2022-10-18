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
           DRAM_to_mux:       in std_logic_vector(numbit - 1 downto 0);
           alu_out:           out std_logic_vector(numbit - 1 downto 0);
           rd_reg_out:        out std_logic_vector(4 downto 0);
           b_reg_out:         out std_logic_vector(numbit-1 downto 0);
           DRAM_addr:         out std_logic_vector(numbit-1 downto 0);
           alu_forwarding_one_vector     out std_logic_vector(numbit-1 downto 0);
           alu_forwarding_two_vector     out std_logic_vector(numbit-1 downto 0)
           );
end memory_unit;

architecture structural of memory_unit is

  component REGISTER_GENERIC
    generic( NBIT: integer := Bit_Register);
    port(    D:     in std_logic_vector(NBIT-1 downto 0);
             CK:    in std_logic;
             RESET: in std_logic;
             ENABLE:in std_logic;
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
  signal b_reg_in_signal: std_logic_vector(numbit-1 downto 0);
  signal alu_in_signal: std_logic_vector(numbit-1 downto 0);
  begin

    MUX_MEM : MUX21_GENERIC
    generic map(numbit)
    port map( A => alu_in,
              B => DRAM_to_mux,
              SEL => mux_mem_control,
              Y => mux_out);
    
    
    REGALU : REGISTER_GENERIC
    generic map(numbit)
    port map( D => mux_out,
              CK => clk,
              RESET => reset,
              ENABLE => EN4,
              Q => alu_out);

    RDREG : REGISTER_GENERIC
    generic map(5)
    port map( D => rd_reg_in,
              CK => clk,
              RESET => reset,
              ENABLE => EN4,
              Q => rd_reg_out);

    b_reg_in_signal <= b_reg_in;
    b_reg_out <= b_reg_in_signal;
    
    alu_in_signal <= alu_in;
    DRAM_addr <= alu_in_signal;

    alu_forwarding_one_vector <= alu_in_signal;
    alu_forwarding_two_vector <= alu_in_signal;
end structural;

