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
           mux_one_control:       in std_logic_vector(1 downto 0);
           mux_two_control:       in std_logic_vector(1 downto 0);
           alu_control:           in std_logic_vector(4 downto 0);
           EN3:                   in std_logic;
           alu_forwarding_one_vector:     in std_logic_vector(numbit-1 downto 0);
           alu_forwarding_two_vector:     in std_logic_vector(numbit-1 downto 0);
           mem_forwarding_one_vector:     in std_logic_vector(numbit-1 downto 0);
           mem_forwarding_two_vector:     in std_logic_vector(numbit-1 downto 0);
           rd_out_exe: 		    out std_logic_vector(4 downto 0);
           alu_out_exe:           out std_logic_vector(numbit-1 downto 0);
           execution_stage_out:   out std_logic_vector(numbit-1 downto 0);
           alu_branch_out:        out std_logic_vector(numbit-1 downto 0);
           b_reg_out:             out std_logic_vector(numbit-1 downto 0);
           rd_reg_out:            out std_logic_vector(4 downto 0));
end execution_unit;

architecture structural of execution_unit is

  component MUX41_GENERIC 
  generic( NBIT : integer := BIT_RISC);
  port( A      : in  std_logic_vector(NBIT-1 downto 0);
        B      : in  std_logic_vector(NBIT-1 downto 0);
        C      : in  std_logic_vector(NBIT-1 downto 0);
        D      : in  std_logic_vector(NBIT-1 downto 0);
        SEL    : in  std_logic_vector(1 downto 0);
        Y      : out std_logic_vector(NBIT-1 downto 0));
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
        type_alu_operation : in std_logic_vector(ALU_OPC_SIZE-1 downto 0);
        output : out std_logic_vector(NumBitALU-1 downto 0);
        cout : out std_logic);  
  end component;  

  signal mux_one_out_rf : std_logic_vector(numbit-1 downto 0);
  signal mux_two_out_rf : std_logic_vector(numbit-1 downto 0);
  signal alu_out : std_logic_vector(numbit-1 downto 0);
  signal s_cout : std_logic;

  begin

    rd_out_exe <= rd_reg_in;
    alu_out_exe <= alu_out;

    MUX_ONE_RF : MUX41_GENERIC
    generic map(numbit)
    port map( A => npc_in,
              B => alu_forwarding_one_vector,
              C => mem_forwarding_one_vector,
              D => a_reg_in,
              SEL => mux_one_control,
              Y => mux_one_out_rf);

    MUX_TWO_RF : MUX41_GENERIC
    generic map(numbit)
    port map( A => b_reg_in,
              B => alu_forwarding_two_vector,
              C => mem_forwarding_two_vector,
              D => imm_reg_in,
              SEL => mux_two_control,
              Y => mux_two_out_rf);


    ALU_comp : ALU
    port map( operand_A => mux_one_out_rf,
              operand_B => mux_two_out_rf, 
              type_alu_operation => alu_control, 
              output => alu_out, 
              cout => s_cout);

    alu_branch_out <= alu_out;
    
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