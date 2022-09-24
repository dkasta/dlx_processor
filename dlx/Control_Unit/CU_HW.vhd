library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.myTypes.all;
use ieee.numeric_std.all;

entity CU_HW is
  generic (
    MICROCODE_MEM_SIZE :     integer := 15;  -- Microcode Memory Size
    FUNC_SIZE          :     integer := 11;  -- Func Field Size for R-Type Ops
    OP_CODE_SIZE       :     integer := 6;  -- Op Code Size
    CW_SIZE            :     integer := 11);  -- Control Word Size
  port (
    Clk                : in  std_logic;  -- Clock
    Rst                : in  std_logic;  -- Reset:Active-Low
    -- From Instruction Register
    OPCODE 		: in  std_logic_vector(OP_CODE_SIZE - 1 downto 0);
    FUNC   		: in  std_logic_vector(FUNC_SIZE - 1 downto 0); 
    
    -- ID Control Signals
    RF1_EN      : out std_logic;  -- Read port 1 Enable
    RF2_EN      : out std_logic;  -- Read port 2 Enable
    EN_1    	: out std_logic;  -- En pipe stage 1

    -- EX Control Signals
    MUXA_SEL           : out std_logic;  -- MUX-A Sel
    MUXB_SEL           : out std_logic;  -- MUX-B Sel
    EN_2	       : out std_logic;  -- En pipe stage 2
    -- ALU Operation Code
    ALU_OPCODE         : out std_logic_vector(ALU_OP_SIZE downto 0);

    -- MEM Control Signals
    WM	 	       : out std_logic;  -- Data RAM Write Enable
    EN_3               : out std_logic;  -- En pipe stage 3
    RM  	       : out std_logic;  -- Data RAM Write Enable    
    S3	               : out std_logic;  -- Write Back MUX Sel
    WF1	               : out std_logic);  -- Register File Write Enable

end CU_HW;

architecture behavioural of CU_HW is

  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem : mem_array := ("11110100111", -- R type 
                                "01100100111", -- ADDI1
                                "01100100111", -- SUBI1
                                "01100100111", -- ANDI1
                                "01100100111", -- ORI1
                                "01100100111", -- S_REG1
                                "01100110111", -- L_MEM1
				                "01100100111", -- MOV
				                "10111100111", -- ADDI2
			                    "10111100111", -- SUBI2
			                    "10111100111", -- ANDI2
			                    "10111100111", -- ORI2
			                    "10111100111", -- S_REG2
			                    "10111101100", --S_MEM2  
	                            "10111110111"  --L_MEM2   
							); -- some instruction assume that a regigster containing all 0 is present.
                                
  signal cw   	: std_logic_vector(CW_SIZE - 1 downto 0); 	-- full control word read from cw_mem
  signal cw1 	: std_logic_vector(CW_SIZE -1 downto 0); 	-- first stage ,all(11) CW signals
  signal cw2 	: std_logic_vector(CW_SIZE - 1 - 3 downto 0); 	-- second stage, 8 lsb CW signals
  signal cw3 	: std_logic_vector(CW_SIZE - 1 - 6 downto 0); 	-- third stage, 5 lsb CW signals

  signal aluOpcode_i	: std_logic_vector(ALU_OP_SIZE downto 0)	:= NOP_op; 
  signal aluOpcode1	: std_logic_vector(ALU_OP_SIZE downto 0) 	:= NOP_op;
  signal aluOpcode2	: std_logic_vector(ALU_OP_SIZE downto 0) 	:= NOP_op;


 
begin  

  cw <= cw_mem(to_integer(unsigned(OPCODE)));

  	-- stage one control signals
  RF1_EN      <= cw1(CW_SIZE - 1);
  RF2_EN      <= cw1(CW_SIZE - 2);
  EN_1        <= cw1(CW_SIZE - 3);
	-- stage two control signals
  MUXA_SEL    <= cw2(CW_SIZE - 4);
  MUXB_SEL    <= cw2(CW_SIZE - 5);
  EN_2        <= cw2(CW_SIZE - 6);
	-- stage three control signals
  RM          <= cw3(CW_SIZE - 7);
  WM	      <= cw3(CW_SIZE - 8);
  EN_3        <= cw3(CW_SIZE - 9);
  S3	      <= cw3(CW_SIZE - 10);
  WF1         <= cw3(CW_SIZE - 11);
	-- stage four control signals
  RM          <= cw3(CW_SIZE - 7);
  WM	      <= cw3(CW_SIZE - 8);
  EN_3        <= cw3(CW_SIZE - 9);
  S3	      <= cw3(CW_SIZE - 10);
  WF1         <= cw3(CW_SIZE - 11);
    	-- stage five control signals
  RM          <= cw3(CW_SIZE - 7);
  WM	      <= cw3(CW_SIZE - 8);
  EN_3        <= cw3(CW_SIZE - 9);
  S3	      <= cw3(CW_SIZE - 10);
  WF1         <= cw3(CW_SIZE - 11);

  -- purpose: Pipelining of control word and  ALU OpCode
  -- type   : sequential
  -- inputs : 
  -- outputs: Alu_opcode, cw
  CW_PIPE: process (Clk, Rst)
  begin  -- process Clk
    if Rst = '0' then                   -- asynchronous reset (active low)
      cw1 <= (others => '0');
      cw2 <= (others => '0');
      cw3 <= (others => '0');

      aluOpcode1 <= NOP_op;
      aluOpcode2 <= NOP_op;
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      cw1 <= cw;
      cw2 <= cw1(CW_SIZE - 1 - 3 downto 0);
      cw3 <= cw2(CW_SIZE - 1 - 6 downto 0);

      aluOpcode1 <= aluOpcode_i;
      aluOpcode2 <= aluOpcode1;
    end if;
  end process CW_PIPE;

ALU_OPCODE <= aluOpcode2;

  -- purpose: Generation of ALU OpCode
  -- type   : combinational
  -- inputs : IR_i
  -- outputs: aluOpcode
   ALU_OP_CODE_P : process (opcode, func)
   begin  -- process ALU_OP_CODE_P
	case to_integer(unsigned(opcode)) is
	        -- case of R type requires analysis of FUNC
		when 0 =>
			case to_integer(unsigned(func)) is
				when 1 => aluOpcode_i <= ADD_op; -- ADD_R
				when 2 => aluOpcode_i <= SUB_op; -- SUB_R
				when 3 => aluOpcode_i <= AND_op; -- AND_R
				when 4 => aluOpcode_i <= OR_op;  -- OR_R
				when others => aluOpcode_i <= NOP_op;
			end case;
		when 1  => aluOpcode_i <= ADD_op;  --ADDI1
		when 2  => aluOpcode_i <= SUB_op;  --SUBI1
		when 3  => aluOpcode_i <= AND_op;  --ANDI1
		when 4  => aluOpcode_i <= OR_op;   -- ORI1
		when 5  => aluOpcode_i <= ADD_op;  -- SREG1
		when 6  => aluOpcode_i <= ADD_op;  -- L_MEM1
		when 7  => aluOpcode_i <= ADD_Op;  -- MOV
		when 8  => aluOpcode_i <= ADD_op;  -- ADDI2
		when 9  => aluOpcode_i <= SUB_op;  -- SUBI2
		when 10 => aluOpcode_i <= AND_op;  -- ANDI2
		when 11 => aluOpcode_i <= OR_op;   -- ORI2
		when 12 => aluOpcode_i <= ADD_op;  -- SREG2
		when 13 => aluOpcode_i <= ADD_op;  -- S_MEM1
		when 14 => aluOpcode_i <= ADD_op;  -- L_MEM2
		when others => aluOpcode_i <= NOP_op;
	 end case;
	end process ALU_OP_CODE_P;


end behavioural;
