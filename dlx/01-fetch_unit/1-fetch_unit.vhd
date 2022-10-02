library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.globals.all;

entity fetch_unit is
  generic( numbit : integer := BIT_RISC);
  port(   program_counter: in std_logic_vector(numbit-1 downto 0);
       	  to_IR:		       in std_logic_vector(numbit-1 downto 0);
       	  clk:			       in std_logic;
       	  rst:	 	  	     in std_logic;
       	  to_IRAM:     	   out std_logic_vector(numbit - 1 downto 0);
       	  npc_out:		     out std_logic_vector(numbit-1 downto 0);
       	  instr_reg_out:   out std_logic_vector(numbit-1 downto 0);
       	  instr_fetched:   out std_logic_vector(numbit-1 downto 0));
end fetch_unit;

architecture behavioural of fetch_unit is
  
  signal pc_reg_out : std_logic_vector( numbit-1 downto 0) := (others => '0');
  signal pc_adder_out : std_logic_vector( numbit-1 downto 0);
  signal tomem : std_logic_vector( numbit - 1 downto 0);

component register_generic
  generic( NBIT : integer := Bit_Register);
  port( 	 D:   	in std_logic_vector(NBIT-1 downto 0);
       		 CK:   	in std_logic;
       		 RESET:	in std_logic;
      		 Q:  		out std_logic_vector(NBIT-1 downto 0));
  end component;

  -----------------------------------------------------------
  component IRAM is
    generic(RAM_DEPTH : integer := RAM_DEPTH;
            I_SIZE : integer := I_SIZE);
    port(Rst  : in  std_logic;
         Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
         Dout : out std_logic_vector(I_SIZE - 1 downto 0));
  end component;
  -----------------------------------------------------------

  begin
    
    pc_reg_out <= program_counter;
    
    pc_adder_out <= std_logic_vector(unsigned(pc_reg_out) + 4);

    NPC : register_generic
   	 	  generic map( numbit)
    	  	 port map( pc_adder_out, clk, rst, npc_out);

    instr_fetched <= to_IR;

    IR_reg : register_generic
    	 generic map(numbit)
    	 port map( to_IR,clk,rst,instr_reg_out);

    tomem <= pc_reg_out;

---------------------------------------------------------------------------------
    C_IRAM : IRAM
    generic map(RAM_DEPTH,NBIT)
      port map(Rst => rst,
               Addr => tomem,
               Dout => instr_fetched);
---------------------------------------------------------------------------------

    --process to check if a forbidden memory address is being accessed
    IRAM_PROC : process(tomem)
    begin
      if((unsigned(tomem)) < RAM_DEPTH) then
        to_IRAM <= tomem;
      end if;
    end process;


end behavioural;

