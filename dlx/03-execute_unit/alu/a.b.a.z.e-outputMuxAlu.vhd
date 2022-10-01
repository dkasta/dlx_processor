library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.myTypes.all;

entity mux_alu is
	port(add_or_sub: in std_logic_vector(31 downto 0);
	     multiplication: in std_logic_vector(31 downto 0);
	     logical: in std_logic_vector(31 downto 0);
 	     shift: in std_logic_vector(31 downto 0);
	     load_high_imm: in std_logic_vector(31 downto 0);
	     greater_then: in std_logic;
	     greater_equal_then: in std_logic;
	     less_then: in std_logic;
 	     less_equal_then: in std_logic;
	     equal: in std_logic;
	     not_equal: in std_logic;
	     selection: in aluOp;
	     output_mux: out std_logic_vector (31 downto 0));
end mux_alu;

architecture behav of mux_alu is
begin

 process(selection, add_or_sub, multiplication, logical, shift, load_high_imm, greater_then, greater_equal_then, less_then, less_equal_then, equal, not_equal)
	begin
	 case selection is
	 
		when ADDOP | SUBOP => 
		  output_mux <= add_or_sub;
		  
		when MULOP => 
		  output_mux <= multiplication;
		  
		when ANDOP | NANDOP | OROP | NOROP | XOROP | XNOROP => 
		  output_mux <= logical;
		  
		when SLLOP | SRLOP | SRAOP =>     
		  output_mux <= shift;
		  
		when GTUOP | GTOP => 
		  output_mux <= (31 downto 1 => '0') & greater_then;
		  
		when GETUOP | GETOP =>    
		  output_mux <= (31 downto 1 => '0') & greater_equal_then;
		  
		when LTUOP | LTOP =>     
		  output_mux <= (31 downto 1 => '0') & less_then;
		  
	    when LETUOP | LETOP => 
	      output_mux <= (31 downto 1 => '0') & less_equal_then;
	      
		when EQOP => 
		  output_mux <= (31 downto 1 => '0') & equal;
		  
		when NEQOP =>     
		  output_mux <= (31 downto 1 => '0') & not_equal;
		  
		when NOP => 
		  output_mux <= (others => '0');
		  
		when LHIOP =>     
		  output_mux <= load_high_imm;
		  
		when others => 
		  output_mux <= (others => 'Z');
		  
 	end case;
 end process;

end behav;
