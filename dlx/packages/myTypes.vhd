library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

package myTypes is

-- Control unit input sizes
    constant OP_CODE_SIZE : integer :=  6;                                              -- OPCODE field size
    constant FUNC_SIZE    : integer :=  11;                                             -- FUNC field size
    constant MICROCODE_MEM_SIZE : integer := 68;                                        -- size of each memory
    constant ALU_OPC_SIZE : integer := 5;                                               -- size of alu control signals
    constant CW_SIZE : integer := 16 + ALU_OPC_SIZE;                                     -- cw final size

    --type aluOp is (NOP, ADDOP, SUBOP, MULOP, ANDOP, NANDOP, OROP, NOROP, XOROP, XNOROP, SLLOP, SRLOP, SRAOP, GTOP, GETOP, LTOP, LETOP, EQOP, NEQOP, GTUOP, GETUOP, LTUOP, LETUOP, LHIOP, LLIOP);
    
    constant NOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00000";
    constant ADDOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00001";
    constant SUBOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00010";
    constant MULOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00011";
    constant ANDOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00100";
    constant NANDOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00101";
    constant OROP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00110";
    constant NOROP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "00111";
    constant XOROP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01000";
    constant XNOROP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01001";
    constant SLLOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01010";
    constant SRLOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01011";
    constant SRAOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01100";
    constant GTOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01101";
    constant GETOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01110";
    constant LTOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "01111";
    constant LETOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10000";
    constant EQOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10001";
    constant NEQOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10010";
    constant GTUOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10011";
    constant GETUOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10100";
    constant LTUOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10101";
    constant LETUOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10110";
    constant LHIOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "10111";
    constant LLIOP: std_logic_vector(ALU_OPC_SIZE - 1 downto 0) := "11000";
    

-- R-Type instruction -> OPCODE field
    constant RTYPE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000000";          -- for ADD, SUB, AND, OR register-to-register operation

-- R-Type instruction -> FUNC field   -- ALU operation is defined in the extra 11-bit field func
    constant RTYPE_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100000";    -- RTYPE_ADD
    constant RTYPE_AND : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100100";    -- RTYPE_AND
    constant RTYPE_OR : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100101";    -- RTYPE_OR
    constant RTYPE_SGE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101101";    -- RTYPE_SGE
    constant RTYPE_SLE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101100";    -- RTYPE_SLE
    constant RTYPE_SLL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000100";    -- RTYPE_SLL
    constant RTYPE_SNE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101001";    -- RTYPE_SNE
    constant RTYPE_SRL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000110";    -- RTYPE_SRL
    constant RTYPE_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100010";    -- RTYPE_SUB
    constant RTYPE_XOR : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100110";    -- RTYPE_XOR

    
-- I-Type instruction -> OPCODE field
    constant ITYPE_ADDI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001000"; -- i, 0x08 ---> 00 1000
    constant ITYPE_ANDI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001100"; -- i, 0x0C
    constant ITYPE_BEQZ: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000100"; -- b, 0x04
    constant ITYPE_BNEZ: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000101"; -- b, 0x05
    constant ITYPE_LW:	 std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "100011"; -- l, 0x23	
    constant ITYPE_ORI:	 std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001101"; -- i, 0x0D	
    constant ITYPE_SGEI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "011101"; -- i, 0x1D
	constant ITYPE_SLEI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "011100"; -- i, 0x1C
	constant ITYPE_SLLI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "010100"; -- i, 0x14
    constant ITYPE_SNEI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "011001"; -- i, 0x19
    constant ITYPE_SRLI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "010110"; -- i, 0x16
	constant ITYPE_SUBI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001010"; -- i, 0x0A
    constant ITYPE_SW:	 std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "101011"; -- s, 0x2B
	constant ITYPE_XORI: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001110"; -- i, 0x0E

-- J-Type instruction -> OPCODE field
	constant JTYPE_J:	std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000010"; -- j, 0x02
	constant JTYPE_JAL:	std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000011"; -- j, 0x03
    constant JTYPE_CALL: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "111110";
    constant JTYPE_RET: std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "111111";

-- NOP instruction -> OPCODE field
    constant NTYPE_NOP : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "010101";    --NTYPE_NOP





--constant registers used to fill the IRAM
    constant REG0 : std_logic_vector(NumBitAddress-1 downto 0) := "00000";
    constant REG1 : std_logic_vector(NumBitAddress-1 downto 0) := "00001";
    constant REG2 : std_logic_vector(NumBitAddress-1 downto 0) := "00010";
    constant REG3 : std_logic_vector(NumBitAddress-1 downto 0) := "00011";
    constant REG4 : std_logic_vector(NumBitAddress-1 downto 0) := "00100";
    constant REG5 : std_logic_vector(NumBitAddress-1 downto 0) := "00101";
    constant REG6 : std_logic_vector(NumBitAddress-1 downto 0) := "00110";
    constant REG7 : std_logic_vector(NumBitAddress-1 downto 0) := "00111";
    constant REG8 : std_logic_vector(NumBitAddress-1 downto 0) := "01000";
    constant REG9 : std_logic_vector(NumBitAddress-1 downto 0) := "01001";
    constant REG10 : std_logic_vector(NumBitAddress-1 downto 0) := "01010";
    constant REG11 : std_logic_vector(NumBitAddress-1 downto 0) := "01011";
    constant REG12 : std_logic_vector(NumBitAddress-1 downto 0) := "01100";
    constant REG13 : std_logic_vector(NumBitAddress-1 downto 0) := "01101";
    constant REG14 : std_logic_vector(NumBitAddress-1 downto 0) := "01110";
    constant REG15 : std_logic_vector(NumBitAddress-1 downto 0) := "01111";
    constant REG16 : std_logic_vector(NumBitAddress-1 downto 0) := "10000";
    constant REG17 : std_logic_vector(NumBitAddress-1 downto 0) := "10001";
    constant REG18 : std_logic_vector(NumBitAddress-1 downto 0) := "10010";
    constant REG19 : std_logic_vector(NumBitAddress-1 downto 0) := "10011";
    constant REG20 : std_logic_vector(NumBitAddress-1 downto 0) := "10100";
    constant REG21 : std_logic_vector(NumBitAddress-1 downto 0) := "10101";
    constant REG22 : std_logic_vector(NumBitAddress-1 downto 0) := "10110";
    constant REG23 : std_logic_vector(NumBitAddress-1 downto 0) := "10111";
    constant REG24 : std_logic_vector(NumBitAddress-1 downto 0) := "11000";
    constant REG25 : std_logic_vector(NumBitAddress-1 downto 0) := "11001";
    constant REG26 : std_logic_vector(NumBitAddress-1 downto 0) := "11010";
    constant REG27 : std_logic_vector(NumBitAddress-1 downto 0) := "11011";
    constant REG28 : std_logic_vector(NumBitAddress-1 downto 0) := "11100";
    constant REG29 : std_logic_vector(NumBitAddress-1 downto 0) := "11101";
    constant REG30 : std_logic_vector(NumBitAddress-1 downto 0) := "11110";
    constant REG31 : std_logic_vector(NumBitAddress-1 downto 0) := "11111";

end myTypes;
