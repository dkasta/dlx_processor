library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;
--use ieee.numeric_std.all;
--use work.all;

entity dlx_cu is
  generic (
    MICROCODE_MEM_SIZE :     integer := 10;  -- Microcode Memory Size
    FUNC_SIZE          :     integer := 11;  -- Func Field Size for R-Type Ops
    OP_CODE_SIZE       :     integer := 6;  -- Op Code Size
    -- ALU_OPC_SIZE       :     integer := 6;  -- ALU Op Code Word Size
    IR_SIZE            :     integer := 32;  -- Instruction Register Size    
    CW_SIZE            :     integer := 15);  -- Control Word Size
  port (
    Clk                : in  std_logic;  -- Clock
    Rst                : in  std_logic;  -- Reset:Active-Low
    -- Instruction Register
    IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
    
    -- IF Control Signal
    IR_LATCH_EN        : out std_logic;  -- Instruction Register Latch Enable
    NPC_LATCH_EN       : out std_logic;
                                        -- NextProgramCounter Register Latch Enable
    -- ID Control Signals
    RegA_LATCH_EN      : out std_logic;  -- Register A Latch Enable
    RegB_LATCH_EN      : out std_logic;  -- Register B Latch Enable
    RegIMM_LATCH_EN    : out std_logic;  -- Immediate Register Latch Enable

    -- EX Control Signals
    MUXA_SEL           : out std_logic;  -- MUX-A Sel
    MUXB_SEL           : out std_logic;  -- MUX-B Sel
    ALU_OUTREG_EN      : out std_logic;  -- ALU Output Register Enable
    EQ_COND            : out std_logic;  -- Branch if (not) Equal to Zero
    -- ALU Operation Code
    ALU_OPCODE         : out aluOp; -- choose between implicit or exlicit coding, like std_logic_vector(ALU_OPC_SIZE -1 downto 0);
    
    -- MEM Control Signals
    DRAM_WE            : out std_logic;  -- Data RAM Write Enable
    LMD_LATCH_EN       : out std_logic;  -- LMD Register Latch Enable
    JUMP_EN            : out std_logic;  -- JUMP Enable Signal for PC input MUX
    PC_LATCH_EN        : out std_logic;  -- Program Counte Latch Enable

    -- WB Control signals
    WB_MUX_SEL         : out std_logic;  -- Write Back MUX Sel
    RF_WE              : out std_logic);  -- Register File Write Enable

end dlx_cu;

architecture dlx_cu_fsm of dlx_cu is
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem : mem_array := ("111100010000111", -- R type: IS IT CORRECT?
                                "000000000000000",
                                "111011111001100", -- J (0X02) instruction encoding corresponds to the address to this ROM
                                "000000000000000", -- JAL to be filled
                                "000000000000000", -- BEQZ to be filled
                                "000000000000000", -- BNEZ
                                "000000000000000", -- 
                                "000000000000000",
                                "000000000000000", -- ADD i (0X08): FILL IT!!!
                                "000000000000000");-- to be completed (enlarged and filled)
                                
                                
  signal IR_opcode : std_logic_vector(OP_CODE_SIZE -1 downto 0);  -- OpCode part of IR
  signal IR_func : std_logic_vector(FUNC_SIZE downto 0);   -- Func part of IR when Rtype
  signal cw   : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem


signal aluOpcode_i: std_logic_vector(ALU_OP_SIZE downto 0) := NOP_op; -- ALUOP defined in package
 
  -- declarations for FSM implementation (to be completed whith alla states!)
type TYPE_STATE is (reset, fetch, decode_R, decode_I1, decode_I2,
                   execute_R, execute_I1,execute_I2, memory_R,memory_I1,
                   memory_I2, memory_LMEM1, memory_LMEM2, memory_SMEM2);
	signal CURRENT_STATE : TYPE_STATE := reset;
	signal NEXT_STATE : TYPE_STATE;



 
begin  -- dlx_cu_rtl

  IR_opcode(5 downto 0) <= IR_IN(31 downto 26);
  IR_func(10 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);

  cw <= cw_mem(conv_integer(IR_opcode));


  -- stage one control signals
  IR_LATCH_EN  <= cw(CW_SIZE - 1);
  NPC_LATCH_EN <= cw(CW_SIZE - 2);
  
  -- stage two control signals
  RegA_LATCH_EN   <= cw(CW_SIZE - 3);
  RegB_LATCH_EN   <= cw(CW_SIZE - 4);
  RegIMM_LATCH_EN <= cw(CW_SIZE - 5);
  
  -- stage three control signals
  MUXA_SEL      <= cw(CW_SIZE - 6);
  MUXB_SEL      <= cw(CW_SIZE - 7);
  ALU_OUTREG_EN <= cw(CW_SIZE - 8);
  EQ_COND       <= cw(CW_SIZE - 9);
  
  -- stage four control signals
  DRAM_WE      <= cw(CW_SIZE - 10);
  LMD_LATCH_EN <= cw(CW_SIZE - 11);
  JUMP_EN      <= cw(CW_SIZE - 12);
  PC_LATCH_EN  <= cw(CW_SIZE - 13);
  
  -- stage five control signals
  WB_MUX_SEL <= cw(CW_SIZE - 14);
  RF_WE      <= cw(CW_SIZE - 15);


  -- purpose: Generation of ALU OpCode
  -- type   : combinational
  -- inputs : IR_i
  -- outputs: aluOpcode
   ALU_OP_CODE_P : process (IR_opcode, IR_func)
   begin  -- process ALU_OP_CODE_P
	case conv_integer(unsigned(opcode)) is
	        -- case of R type requires analysis of FUNC
		when 0 =>
			case conv_integer(unsigned(func)) is
				when 1 => aluOpcode_i <= ADD_op; -- ADD according to instruction set coding
				when 2 => aluOpcode_i <= SUB_op; -- SUB
				when 3 => aluOpcode_i <= AND_op; -- AND
				when 4 => aluOpcode_i <= OR_op; -- OR
				when others => aluOpcode_i <= NOP_op;
			end case;
		when 1 => aluOpcode_i <= ADD_op;  --ADDI1
		when 2 => aluOpcode_i <= SUB_op;  --SUBI1
		when 3 => aluOpcode_i <= AND_op;  --ANDI1
		when 4 => aluOpcode_i <= OR_op;   -- ORI1
		when 5 => aluOpcode_i <= ADD_op;  -- ADDI2
		when 6 => aluOpcode_i <= SUB_op;  -- SUBI2
		when 7 => aluOpcode_i <= AND_op;  -- ANDI2
		when 8 => aluOpcode_i <= OR_op;   -- ORI2
--	   In the instructions above
--		I suppose to have zeros in the unused field of the IR in order to add with 0.
		when 9  => aluOpcode_i <= ADD_Op; -- MOV 
		when 10 => aluOpcode_i <= ADD_op; -- SREG1 
		when 11 => aluOpcode_i <= ADD_op; -- SREG2
		when 12 => aluOpcode_i <= ADD_op; -- S_MEM1
		when 13 => aluOpcode_i <= ADD_op; -- L_MEM1
		when 14 => aluOpcode_i <= ADD_op; -- L_MEM2
		when others => aluOpcode_i <= NOP_op;
	 end case;
	end process ALU_OP_CODE_P;


-----------------------------------------------------
-- FSM
-- This is a very simplified starting point for a fsm
-- up to you to complete it and to improve it
-----------------------------------------------------


 	P_OPC : process(Clk, Rst)		
	begin
		if Rst='0' then
	        	CURRENT_STATE <= reset;
		elsif (Clk ='1' and Clk'EVENT) then 
			CURRENT_STATE <= NEXT_STATE;
		end if;
	end process P_OPC;

	P_NEXT_STATE : process(CURRENT_STATE, OpCode)
	begin
		--NEXT_STATE <= CURRENT_STATE;
		case CURRENT_STATE is
			when reset =>
          NEXT_STATE <= fetch;
				if OPCODE = 0 then 
					NEXT_STATE <= decode_R; -- All 4 R-Type instruction will have the same decode
				elsif OPCODE > 0 AND OPCODE < 8 then -- 1 TYPE according to instruction encoding
					NEXT_STATE <= decode_I1;
				elsif OPCODE > 7 AND OPCODE  < 15  then-- 2 TYPE according to instruction encoding
					NEXT_STATE <= decode_I2;
				end if;
			
			when decode_R => 
					NEXT_STATE <= execute_R; 
			when decode_I1 =>
					NEXT_STATE <= execute_I1;
			when decode_I2 =>
					NEXT_STATE <= execute_I2;
			
			when execute_R =>
					NEXT_STATE <= memory_R;
			when execute_I1 =>
					if OPCODE = 6 then
						NEXT_STATE <= memory_LMEM1;
					else
						NEXT_STATE <= memory_I1;
					end if;
			when execute_I2 =>
					if OPCODE = 13 then -- SMEM_2 according to the instruction enconding
						NEXT_STATE <= memory_SMEM2;
					elsif OPCODE = 14 then -- LMEM_2 according to the instruction encoding
						NEXT_STATE <= memory_LMEM2;
					else							-- ALL other I2-Type instructions
						NEXT_STATE <= memory_I2;
					end if;
			when others =>
					NEXT_STATE <= reset;   -- after memory states FSM resets itself
		end case;	
	end process P_NEXT_STATE;
	
		P_OUTPUTS: process(CURRENT_STATE)
	begin
		ALU_OPCODE <= NOP_op; -- default
		case CURRENT_STATE is	
			when reset        =>   cw <=  "00000000000";
      		when fetch        =>   cw <= ---here we can send some commands to a mux in order to copy an instruction
			when decode_r     =>   cw <=  "11100000000";
			when decode_I1    =>   cw <=  "01100000000";
			when decode_I2    =>   cw <=  "10100000000";
			when execute_R    =>   cw <=  "00010100000";
				       ALU_OPCODE <= aluOpcode_i;
			when execute_I1   =>   cw <=  "00000100000";
				       ALU_OPCODE <= aluOpcode_i;
			when execute_I2   =>   cw <=  "00011100000";
				       ALU_OPCODE <= aluOpcode_i;
			when memory_R     =>   cw <=  "00000000111";
			when memory_LMEM1 =>   cw <=  "00000010111";
			when memory_I1    =>   cw <=  "00000000111";
			when memory_SMEM2 =>   cw <=  "00000001100";
			when memory_LMEM2 =>   cw <=  "00000010111";
			when memory_I2    =>   cw <=  "00000000111";
			when others       =>   cw <=  "00000000000"; -- error 		
		end case; 	
	end process P_OUTPUTS;

end dlx_cu_fsm;
