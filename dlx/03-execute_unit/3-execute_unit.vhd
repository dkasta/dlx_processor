library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;
use work.myTypes.all;

entity execution_unit is
  generic( numbit: integer := BIT_RISC);
  port(    clk:                   in std_logic;
           reset:                 in std_logic;
           npc_in:                in std_logic_vector(numbit-1 downto 0);
           a_reg_in:              in std_logic_vector(numbit-1 downto 0);
           b_reg_in:              in std_logic_vector(numbit-1 downto 0);
           imm_reg_in:            in std_logic_vector(numbit-1 downto 0);
           rd_reg_in:             in std_logic_vector(4 downto 0);
           mux_one_control:       in std_logic;
           mux_two_control:       in std_logic;
           alu_control:           in std_logic_vector(4 downto 0);
           EN3:                   in std_logic;
           execution_stage_out:   out std_logic_vector(numbit-1 downto 0);
           b_reg_out:             out std_logic_vector(numbit-1 downto 0);
           rd_reg_out:            out std_logic_vector(4 downto 0));
end execution_unit;

architecture structural of execution_unit is

  component MUX21_GENERIC
  generic( NBIT: integer := Bit_Mux21);
  port(    A:    in std_logic_vector(NBIT-1 downto 0);
           B:    in std_logic_vector(NBIT-1 downto 0);
           SEL:  in std_logic;
           Y:    out std_logic_vector(NBIT-1 downto 0));
  end component;

  component REGISTER_GENERIC
  generic( NBIT : integer := Bit_Register);
  port(    D:     in std_logic_vector(NBIT-1 downto 0);
           CK:    in std_logic;
           RESET: in std_logic;
           ENABLE: in std_logic;
           Q:     out std_logic_vector(NBIT-1 downto 0));
  end component;

  component ALU
  port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
        operand_B : in std_logic_vector(NumBitALU-1 downto 0);
        type_alu_operation : in aluOp;
        output : out std_logic_vector(NumBitALU-1 downto 0);
        cout : out std_logic);  
  end component;  

  signal mux_one_out_rf : std_logic_vector(numbit-1 downto 0);
  signal mux_one_out_mem_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_one_out_alu_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_rf : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_mem_forwarding : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_alu_forwarding : std_logic_vector(numbit-1 downto 0);
  signal alu_out : std_logic_vector(numbit-1 downto 0);
  signal s_cout : std_logic;

  begin

    MUX_ONE_RF : MUX21_GENERIC
    generic map(numbit)
    port map( A => npc_in,
              B => a_reg_in,
              SEL => mux_one_control,
              Y => mux_one_out_rf);

    MUX_TWO_RF : MUX21_GENERIC
    generic map(numbit)
    port map( A => b_reg_in,
              B => imm_reg_in,
              SEL => mux_two_control,
              Y => mux_two_out_rf);

--    MUX_TWO_MEM : MUX21_GENERIC
--    generic map(numbit)
--    port map(mux_two_out_rf,mem_forwarding_value,mem_forwarding_two,mux_two_out_mem_forwarding);

--    MUX_TWO_ALU : MUX21_GENERIC
--    generic map(numbit)
--    port map(mux_two_out_mem_forwarding,alu_forwarding_value,alu_forwarding_two,mux_two_out_alu_forwarding);
operand_A : in std_logic_vector(NumBitALU-1 downto 0);
        operand_B : in std_logic_vector(NumBitALU-1 downto 0);
        type_alu_operation : in aluOp;
        output : out std_logic_vector(NumBitALU-1 downto 0);
        cout : out std_logic


    ALU_comp : ALU
    port map( operand_A => mux_one_out_rf,
              operand_B => mux_two_out_rf, 
              type_alu_operation => alu_control, 
              output => alu_out, 
              cout => s_cout);

    REG1 : REGISTER_GENERIC
    generic map(numbit)
    port map( D => alu_out,
              CK => clk,
              RESET => reset,
              ENABLE => EN3,
              Q => execution_stage_out);

    REG2 : REGISTER_GENERIC
    generic map(numbit)
    port map( D => b_reg_in,
              CK => clk,
              RESET => reset,
              ENABLE => EN3,
              Q => b_reg_out);

    REG3 : REGISTER_GENERIC
    generic map(5)
    port map( D => rd_reg_in,
              CK => clk,
              RESET => reset,
              ENABLE => EN3, 
              Q => rd_reg_out);

end structural;