library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

entity execution_unit is
  generic( numbit: integer := BIT_RISC);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           alu_forwarding_one:    in std_logic;
           mem_forwarding_one:    in std_logic;
           alu_forwarding_two:    in std_logic;
           mem_forwarding_two:    in std_logic;
           alu_forwarding_value:  in std_logic_vector(numbit - 1 downto 0);
           mem_forwarding_value:  in std_logic_vector(numbit - 1 downto 0);
           npc_in:                in std_logic_vector(numbit-1 downto 0);
           a_reg_in:              in std_logic_vector(numbit-1 downto 0);
           b_reg_in:              in std_logic_vector(numbit-1 downto 0);
           imm_reg_in:            in std_logic_vector(numbit-1 downto 0);
           rd_reg_in:             in std_logic_vector(4 downto 0);
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(3 downto 0);
           execution_stage_out:   out std_logic_vector(numbit-1 downto 0);
           b_reg_out:             out std_logic_vector(numbit-1 downto 0);
           rd_reg_out:            out std_logic_vector(4 downto 0));
end execution_unit;

architecture structural of execution_unit is

  component MUX21_GENERIC
  generic( NBIT: integer := NumBitMux21);
  port(    A:    in std_logic_vector(NBIT-1 downto 0);
           B:    in std_logic_vector(NBIT-1 downto 0);
           SEL:  in std_logic;
           Y:    out std_logic_vector(NBIT-1 downto 0));
  end component;

  component REGISTER_GENERIC
  generic( NBIT : integer := NumBitRegister);
  port(    D:     in std_logic_vector(NBIT-1 downto 0);
           CK:    in std_logic;
           RESET: in std_logic;
           Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;

  component ALU_BEHAVIORAL
  generic( NBIT : integer := NumBitALU);
  port 	 ( FUNC:    in std_logic_vector(3 downto 0);
           DATA1:   in std_logic_vector(NBIT-1 downto 0); 
           DATA2:   in std_logic_vector(NBIT-1 downto 0);
           OUTALU:  out std_logic_vector(NBIT-1 downto 0));
  end component;  

  signal mux_one_out_rf : std_logic_vector(numbit-1 downto 0);
  signal mux_one_out_mem_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_one_out_alu_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_rf : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_mem_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_alu_forwarding : std_logic_vector(numbit-1 downto 0);
  signal alu_out : std_logic_vector(numbit-1 downto 0);

  begin

    MUX_ONE_RF : MUX21_GENERIC
    generic map(numbit)
    port map(npc_in,a_reg_in,mux_one_control,mux_one_out_rf);

    MUX_ONE_MEM : MUX21_GENERIC
    generic map(numbit)
    port map(mux_one_out_rf,mem_forwarding_value,mem_forwarding_one,mux_one_out_mem_forwarding);

    MUX_ONE_ALU : MUX21_GENERIC
    generic map(numbit)
    port map(mux_one_out_mem_forwarding,alu_forwarding_value,alu_forwarding_one,mux_one_out_alu_forwarding);

    MUX_TWO_RF : MUX21_GENERIC
    generic map(numbit)
    port map(b_reg_in,imm_reg_in,mux_two_control,mux_two_out_rf);

    MUX_TWO_MEM : MUX21_GENERIC
    generic map(numbit)
    port map(mux_two_out_rf,mem_forwarding_value,mem_forwarding_two,mux_two_out_mem_forwarding);

    MUX_TWO_ALU : MUX21_GENERIC
    generic map(numbit)
    port map(mux_two_out_mem_forwarding,alu_forwarding_value,alu_forwarding_two,mux_two_out_alu_forwarding);

    ALU : ALU_BEHAVIORAL
    generic map(numbit)
    port map(alu_control,mux_one_out_alu_forwarding,mux_two_out_alu_forwarding,alu_out);

    REG1 : REGISTER_GENERIC
    generic map(numbit)
    port map(alu_out,clk,reset,execution_stage_out);

    REG3 : REGISTER_GENERIC
    generic map(numbit)
    port map(b_reg_in,clk,reset,b_reg_out);

    REG4 : REGISTER_GENERIC
    generic map(5)
    port map(rd_reg_in,clk,reset,rd_reg_out);

end structural;

