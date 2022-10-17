library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.globals.all;

entity fetch_unit is
  generic( numbit : integer := BIT_RISC);
  port(   clk:			             in std_logic;
       	  rst:	 	  	           in std_logic;
          EN1:                   in std_logic;
          to_IR:		             in std_logic_vector(numbit-1 downto 0);
          comparator_out_to_mux: in std_logic_vector(1 downto 0);
          RF_ONE_OUT_IF:         in std_logic_vector(numbit-1 downto 0);
          NPC_branch_jump:        in std_logic_vector(numbit-1 downto 0);
          to_IRAM:     	         out std_logic_vector(numbit - 1 downto 0);
       	  npc_out:		           out std_logic_vector(numbit-1 downto 0);
       	  instr_reg_out:         out std_logic_vector(numbit-1 downto 0);
       	  instr_fetched:         out std_logic_vector(numbit-1 downto 0));
end fetch_unit;

architecture behavioural of fetch_unit is
  
  signal pc_reg_out : std_logic_vector( numbit-1 downto 0);
  signal pc_adder_out : std_logic_vector( numbit-1 downto 0) := (others => '0');
  signal pc_mux_out : std_logic_vector( numbit-1 downto 0) := (others => '0');
  signal tomem : std_logic_vector( numbit - 1 downto 0) := (others => '0');
  signal to_IR_signal : std_logic_vector( numbit - 1 downto 0) := (others => '0');
  signal instr_fetched_signal : std_logic_vector( numbit - 1 downto 0) := (others => '0');

component register_generic
  generic( NBIT : integer := Bit_Register);
  port( 	 D:   	 in std_logic_vector(NBIT-1 downto 0);
       		 CK:   	 in std_logic;
       		 RESET:	 in std_logic;
           ENABLE: in std_logic;
      		 Q:  		 out std_logic_vector(NBIT-1 downto 0));
  end component;

  component PC is
    generic(NBIT : integer := NumBitMemoryWord);
    port(clk : IN std_logic;
         reset : IN std_logic;
         PC_in : IN std_logic_vector(NBIT-1 downto 0);
         enable : IN std_logic;
         PC_out : OUT std_logic_vector(NBIT-1 downto 0));
  end component;


   component MUX31_GENERIC 
    generic( NBIT : integer := BIT_RISC);
    port( A      : in  std_logic_vector(NBIT-1 downto 0);
          B      : in  std_logic_vector(NBIT-1 downto 0);
          C      : in  std_logic_vector(NBIT-1 downto 0);
          SEL    : in  std_logic_vector(1 downto 0);
          Y      : out std_logic_vector(NBIT-1 downto 0));
    end component;
  -----------------------------------------------------------
--  component IRAM is
--    generic(RAM_DEPTH : integer := RAM_DEPTH;
--            I_SIZE : integer := I_SIZE);
--    port(Rst  : in  std_logic;
--         enable : in std_logic;
--         Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
--         Dout : out std_logic_vector(I_SIZE - 1 downto 0));
--  end component;
  -----------------------------------------------------------

  begin
        
    --pc_adder_out <= std_logic_vector(unsigned(pc_reg_out) + 4);

    PC_block : PC
    generic map (numbit)
           port map (clk => clk, 
                     reset => rst, 
                     PC_in => pc_mux_out, 
                     enable => EN1, 
                     PC_out => pc_reg_out); 

    PC_ADDER_PROCESS : process(pc_reg_out, EN1)
    begin 
      if EN1 = '1' then 
           pc_adder_out <= std_logic_vector(unsigned(pc_reg_out) + 4);
      end if;
    end process;

    -- SEL = 1, B is selected
    MUX_PC : MUX31_GENERIC
    generic map(numbit)
      port map ( A => NPC_branch_jump, 
                 B => RF_ONE_OUT_IF, 
                 C => pc_adder_out,
                 SEL => comparator_out_to_mux, 
                 Y => pc_mux_out);
    
    

    NPC : register_generic
   	 	  generic map( numbit)
    	  	 port map( D => pc_adder_out,
                     CK => clk, 
                     RESET => rst,
                     ENABLE => EN1, 
                     Q => npc_out);

    to_IR_signal <= to_IR;

    IR_reg : register_generic
    	 generic map(numbit)
    	 port map( D => to_IR_signal,
                 CK => clk,
                 RESET => rst,
                 ENABLE => EN1, 
                 Q => instr_reg_out);

    tomem <= pc_reg_out;
    instr_fetched <= to_IR_signal;
---------------------------------------------------------------------------------
--    C_IRAM : IRAM
--    generic map(RAM_DEPTH,NBIT)
--      port map(Rst => rst,
--               enable => EN1,
--               Addr => tomem,
--               Dout => instr_fetched_signal);
---------------------------------------------------------------------------------

    --process to check if a forbidden memory address is being accessed
    IRAM_PROC : process(tomem)
    begin
      if((unsigned(tomem)) < RAM_DEPTH) then
        to_IRAM <= tomem;
      end if;
    end process;


end behavioural;

