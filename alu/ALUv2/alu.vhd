library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.globals.all;
use work.myTypes1.all;


entity alu is
  port (operand_A : in std_logic_vector(NumBitALU-1 downto 0);
        operand_B : in std_logic_vector(NumBitALU-1 downto 0);
        type_alu_operation : in aluOp;
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
    
    component mux_alu is
        port(addsub: in std_logic_vector(NumBitALU-1 downto 0);
             mul: in std_logic_vector(NumBitALU-1 downto 0);
             log: in std_logic_vector(NumBitALU-1 downto 0);
             shift: in std_logic_vector(NumBitALU-1 downto 0);
             lhi: in std_logic_vector(NumBitALU-1 downto 0);
             gt: in std_logic;
             get: in std_logic;
             lt: in std_logic;
             let: in std_logic;
             eq: in std_logic;
             neq: in std_logic;
             sel: in aluOp;
             out_mux: out std_logic_vector(NumBitALU-1 downto 0));
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
  signal s_sel_log : std_logic_vector(3 downto 0) := "0000";         --to select the desired logical operation type
  signal s_out_log : std_logic_vector(NumBitALU-1 downto 0);         --to retrieve the result of the logical operation
  signal s_sign, s_gt, s_get, s_lt, s_let, s_eq, s_neq : std_logic;  --logical possible operation signals
  signal s_A_log, s_B_log : std_logic_vector(NumBitALU-1 downto 0);  --to assign operands of the logical operation

 --SHIFT
    signal sel_shift : std_logic_vector(1 downto 0);                 --to select the desired shifting operation type
  signal s_out_shift : std_logic_vector(NumBitALU-1 downto 0);       --to retrieve the result of the shift
  signal s_A_sht, s_B_sht : std_logic_vector(NumBitALU-1 downto 0);  --to assign operands of the shift operation

  signal s_out_lhi   : std_logic_vector(NumBitALU-1 downto 0);
  signal s_B_lhi : std_logic_vector(NumBitALU-1 downto 0);

  begin

    process(operand_A, operand_B, type_alu_operation)
    begin
      case type_alu_operation is
        when ADDOP =>  -- A + B
         	s_A_add <= operand_A; 
         	s_B_add <= operand_B;
            s_add_or_sub <= '0';  				             
        when SUBOP =>  -- A - B
         	s_A_add <= operand_A; 
         	s_B_add <= operand_B;
         	s_add_or_sub <= '1';	
        when MULOP => 	-- A * B
            s_A_mul <= operand_A;
            s_B_mul <= operand_B;							                      
--        when ANDOP => 	sel_log <= "0001"; A_log <= A; B_log <= B;				              -- A and B
--        when OROP => 	    sel_log <= "0111"; A_log <= A; B_log <= B;				              -- A or B
--        when XOROP => 	sel_log <= "0110"; A_log <= A; B_log <= B;				              -- A xor B
--        when SLLOP => 	sel_shift <= "00"; A_sht <= A; B_sht <= B;				              -- A sll B
--        when SRLOP => 	sel_shift <= "01"; A_sht <= A; B_sht <= B;				              -- A srl B
--        when SRAOP => 	sel_shift <= "10"; A_sht <= A; B_sht <= B;				              -- A sra B

	      when GTUOP => -- A > B
              s_A_add <= operand_A; 
              s_B_add <= operand_B; 
              s_add_or_sub <= '1'; 
              s_sign <= '0';
--        when GETUOP => 	s_add_or_sub <= '1'; s_sign <= '0';             s_A_add <= operand_A; s_B_add <= operand_B;         -- A >= B
--        when LTUOP => 	s_add_or_sub <= '1'; s_sign <= '0';             s_A_add <= operand_A; s_B_add <= operand_B; 		-- A < B
--        when LETUOP => 	s_add_or_sub <= '1'; s_sign <= '0';             s_A_add <= operand_A; s_B_add <= operand_B;			-- A >= B
--        when GTOP => 	    s_add_or_sub <= '1'; s_sign <= A(31) xor B(31); s_A_add <= operand_A; s_B_add <= operand_B;         -- A > B
--        when GETOP => 	s_add_or_sub <= '1'; s_sign <= A(31) xor B(31); s_A_add <= operand_A; s_B_add <= operand_B;         -- A >= B
--        when LTOP => 	    s_add_or_sub <= '1'; s_sign <= A(31) xor B(31); s_A_add <= operand_A; s_B_add <= operand_B;         -- A < B
--        when LETOP => 	s_add_or_sub <= '1'; s_sign <= A(31) xor B(31); s_A_add <= operand_A; s_B_add <= operand_B; 	    -- A >= B
--        when EQOP => 	    s_add_or_sub <= '1'; s_sign <= '0';             s_A_add <= operand_A; s_B_add <= operand_B; 		-- A == B
--	      when NEQOP => 	s_add_or_sub <= '1'; s_sign <= '0';             s_A_add <= operand_A; s_B_add <= operand_B; 		-- A /= B
--        when NOP =>       NULL;
--	      when LHIOP =>	    B_lhi <= B;
          when others => 	NULL;
      end case;
    end process;

      cout <= s_cout;
      --out_lhi <= B_lhi(15 downto 0) & x"0000";

      adder_subtr: adder_sub generic map(NumBitP4Data) port map(s_A_add, s_B_add, s_add_or_sub, s_cout, s_out_add);
      mul : booth_mul generic map(NumBitBoothMul) port map(s_A_mul(15 downto 0), s_B_mul(15 downto 0), s_out_mul);
      --logic : logical port map(A_log, B_log, sel_log, out_log);
      --shift : shifter port map(A_sht, B_sht, sel_shift, out_shift);
      compar : comparator port map(s_cout, s_out_add, s_sign, s_gt, s_get, s_lt, s_let, s_eq, s_neq);
      muxy1 : mux_alu port map(s_out_add, s_out_mul, s_out_log, s_out_shift, s_out_lhi, s_gt, s_get, s_lt, s_let, s_eq, s_neq, type_alu_operation, output);


end behaviour;
