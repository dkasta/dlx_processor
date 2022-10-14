library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.globals.all;
use work.myTypes.all;


entity alu is
  port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
        operand_B : in std_logic_vector(NumBitALU-1 downto 0);
        type_alu_operation : in std_logic_vector(ALU_OPC_SIZE-1 downto 0); 
        output : out std_logic_vector(NumBitALU-1 downto 0);
        cout : out std_logic);
end alu;

architecture behaviour of alu is

    component adder_sub is
        generic (N : integer);
        port    (A:	In	std_logic_vector(N-1 downto 0);
                 B:	In	std_logic_vector(N-1 downto 0);
                 Ci:	In	std_logic;
                 Cout:	Out	std_logic;
                 Sum: out std_logic_vector(N-1 downto 0));
    end component;
    
    component booth_mul is
        generic (N: integer := 16);
        port (A: in	std_logic_vector(NumBitBoothMul-1 downto 0);
              B: in std_logic_vector(NumBitBoothMul-1 downto 0);
              P: out std_logic_vector(2*NumBitBoothMul-1 downto 0));
    end component;
    
    component comparator is
        port(C: in std_logic;
             Sum: in std_logic_vector(NumBitALU-1 downto 0);
             sign: in std_logic;
             gt: out std_logic;
             get: out std_logic;
             lt: out std_logic;
             let: out std_logic;
             eq: out std_logic;
             neq: out std_logic);
    end component;
    
    component shifter_t2 is
    	port(A: in std_logic_vector(NumBitALU-1 downto 0);
	         B: in std_logic_vector(NumBitALU-1 downto 0);
	         sel: in std_logic_vector(1 downto 0);
	         C: out std_logic_vector(NumBitALU-1 downto 0));
    end component;
    
    component logic_t2
        generic (NBIT: integer := 32);
        port (R1, R2: in  std_logic_vector(NBIT-1 downto 0);
        S0, S1, S2, S3 : in  std_logic;                          
        Y: out std_logic_vector(NBIT-1 downto 0));
    end component;     
    
    component mux_alu is
	port(add_or_sub: in std_logic_vector(NumBitALU-1 downto 0);
	     multiplication: in std_logic_vector(NumBitALU-1 downto 0);
	     logical: in std_logic_vector(NumBitALU-1 downto 0);
 	     shift: in std_logic_vector(NumBitALU-1 downto 0);
	     load_high_imm: in std_logic_vector(NumBitALU-1 downto 0);
	     greater_then: in std_logic;
	     greater_equal_then: in std_logic;
	     less_then: in std_logic;
 	     less_equal_then: in std_logic;
	     equal: in std_logic;
	     not_equal: in std_logic;
	     selection: in std_logic_vector(ALU_OPC_SIZE-1 downto 0);
	     output_mux: out std_logic_vector (NumBitALU-1 downto 0));
    end component;

 --ADD/SUB
  signal s_add_or_sub : std_logic;                                  --to select addition or subtraction (=0->ADD; =1>-SUB)
  signal s_out_add : std_logic_vector(NumBitALU-1 downto 0);        --to retrieve result of the addition/subtraction
  signal s_cout : std_logic;                                        --to retrieve cout if needed
  signal s_A_add, s_B_add : std_logic_vector(NumBitALU-1 downto 0); --to assign operands of the add/sub operation
 
 --MUL
  signal s_out_mul : std_logic_vector(NumBitALU-1 downto 0);        --to retrieve result of the multiplication
  signal s_A_mul, s_B_mul : std_logic_vector(NumBitALU-1 downto 0); --to assign operands of the multiplication
 
 --LOGIC
  signal s_sel_log0 : std_logic := '0';         --to select the desired logical operation type
  signal s_sel_log1 : std_logic := '0';         --to select the desired logical operation type
  signal s_sel_log2 : std_logic := '0';         --to select the desired logical operation type
  signal s_sel_log3 : std_logic := '0';         --to select the desired logical operation type

  signal s_out_log : std_logic_vector(NumBitALU-1 downto 0);         --to retrieve the result of the logical operation
  signal s_sign, s_gt, s_get, s_lt, s_let, s_eq, s_neq : std_logic;  --logical possible operation signals
  signal s_A_log, s_B_log : std_logic_vector(NumBitALU-1 downto 0);  --to assign operands of the logical operation

 --SHIFT
  signal s_sel_shift : std_logic_vector(1 downto 0);                    --to select the desired shifting operation type
  signal s_out_shift : std_logic_vector(NumBitALU-1 downto 0);          --to retrieve the result of the shift
  signal s_A_shift, s_B_shift : std_logic_vector(NumBitALU-1 downto 0); --to assign operands of the shift operation

  signal s_out_lhi   : std_logic_vector(NumBitALU-1 downto 0);
  signal s_B_lhi : std_logic_vector(NumBitALU-1 downto 0);

  begin

    process(operand_A, operand_B, type_alu_operation)
    begin
        case type_alu_operation is
        
            when ADDOP =>  -- A + B
                s_add_or_sub <= '0';  
                s_A_add <= operand_A; 
                s_B_add <= operand_B;
            
                     
            when SUBOP =>  -- A - B
                s_add_or_sub <= '1';	
                s_A_add <= operand_A; 
                s_B_add <= operand_B;
            
            
            when MULOP =>  -- A * B
                s_A_mul <= operand_A;
                s_B_mul <= operand_B;
                
                                          
            when ANDOP => -- A and B	
                s_sel_log0 <= '0';
                s_sel_log1 <= '0';
                s_sel_log2 <= '0';
                s_sel_log3 <= '1';
                s_A_log <= operand_A; 
                s_B_log <= operand_B;		
                
                
            when NANDOP => -- A nand B	
                s_sel_log0 <= '1';
                s_sel_log1 <= '1';
                s_sel_log2 <= '1';
                s_sel_log3 <= '0';
                s_A_log <= operand_A; 
                s_B_log <= operand_B;
                
                
            when OROP =>  -- A or B    
                s_sel_log0 <= '0';
                s_sel_log1 <= '1';
                s_sel_log2 <= '1';
                s_sel_log3 <= '1';                
                s_A_log <= operand_A; 
                s_B_log <= operand_B;				             
            

            when NOROP =>  -- A nor B    
                s_sel_log0 <= '1';
                s_sel_log1 <= '0';
                s_sel_log2 <= '0';
                s_sel_log3 <= '0';                
                s_A_log <= operand_A; 
                s_B_log <= operand_B;
                
                
            when XOROP =>  -- A xor B
                s_sel_log0 <= '0';
                s_sel_log1 <= '1';
                s_sel_log2 <= '1';
                s_sel_log3 <= '0';
                s_A_log <= operand_A; 
                s_B_log <= operand_B;				              


            when XNOROP =>  -- A xnor B
                s_sel_log0 <= '1';
                s_sel_log1 <= '0';
                s_sel_log2 <= '0';
                s_sel_log3 <= '1';
                s_A_log <= operand_A; 
                s_B_log <= operand_B;


            when SLLOP =>  -- A sll B	
                s_sel_shift <= "00";
                s_A_shift <= operand_A;
                s_B_shift <= operand_B;		
            
             
            when SRLOP =>  -- A srl B 	
                s_sel_shift <= "01"; 
                s_A_shift <= operand_A; 
                s_B_shift <= operand_B;	
            
                  
            when SRAOP =>  -- A sra B	
                s_sel_shift <= "10"; 
                s_A_shift <= operand_A; 
                s_B_shift <= operand_B;	
            
            
            when GTOP =>  -- A > B	
                s_add_or_sub <= '1'; 
                s_sign <= operand_A(31) xor operand_B(31); 
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 
            
            
            when GTUOP =>  -- A > B unsigned
                s_add_or_sub <= '1'; 
                s_sign <= '0';
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 
            
            
            when GETOP => -- A >= B	
                s_add_or_sub <= '1'; 
                s_sign <= operand_A(31) xor operand_B(31); 
                s_A_add <= operand_A; 
                s_B_add <= operand_B;         
                
            
            when GETUOP =>  -- A >= B unsigned
                s_add_or_sub <= '1'; 
                s_sign <= '0';             
                s_A_add <= operand_A; 
                s_B_add <= operand_B;  
            
            
            when LTOP =>  -- A < B	    
                s_add_or_sub <= '1'; 
                s_sign <= operand_A(31) xor operand_B(31);
                s_A_add <= operand_A; 
                s_B_add <= operand_B;         
            
            
            when LTUOP =>  -- A < B unsined
                s_add_or_sub <= '1'; 
                s_sign <= '0';             
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 		
            
            
            when LETOP =>  -- A >= B
                s_add_or_sub <= '1'; 
                s_sign <= operand_A(31) xor operand_B(31); 
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 	    
            
            
            when LETUOP =>  -- A >= B unsigned
                s_add_or_sub <= '1'; 
                s_sign <= '0';             
                s_A_add <= operand_A; 
                s_B_add <= operand_B;			
            
            
            when EQOP =>  -- A == B	    
                s_add_or_sub <= '1'; 
                s_sign <= '0';             
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 		
                
            
            when NEQOP => -- A /= B
                s_add_or_sub <= '1';
                s_sign <= '0';             
                s_A_add <= operand_A; 
                s_B_add <= operand_B; 		
            
            
            when LHIOP =>	    
                s_B_lhi <= operand_B;
            
            
            when NOP =>       
                NULL;
            
            
            when others => 	
                NULL;
              
      end case;
    end process;

      cout <= s_cout;
      s_out_lhi <= s_B_lhi(15 downto 0) & x"0000";

      adder_subtr: adder_sub generic map(NumBitP4Data) port map(s_A_add, s_B_add, s_add_or_sub, s_cout, s_out_add);
      mul: booth_mul generic map(NumBitBoothMul) port map(s_A_mul(15 downto 0), s_B_mul(15 downto 0), s_out_mul);
      logic: logic_t2 generic map(NBIT) port map(s_A_log, s_B_log, s_sel_log0, s_sel_log1, s_sel_log2, s_sel_log3, s_out_log);
      shift: shifter_t2 port map(s_A_shift, s_B_shift, s_sel_shift, s_out_shift);
      comp: comparator port map(s_cout, s_out_add, s_sign, s_gt, s_get, s_lt, s_let, s_eq, s_neq);
      out_mux: mux_alu port map(s_out_add, s_out_mul, s_out_log, s_out_shift, s_out_lhi, s_gt, s_get, s_lt, s_let, s_eq, s_neq, type_alu_operation, output);


end behaviour;
