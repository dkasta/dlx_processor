library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;

package myTypes is

-- Control unit input sizes
    constant OP_CODE_SIZE : integer :=  6;                                              -- OPCODE field size
    constant FUNC_SIZE    : integer :=  11;                                             -- FUNC field size
    constant MICROCODE_MEM_SIZE : integer := 62;                                        -- size of each memory
    constant ALU_OPC_SIZE : integer := 4;                                               -- size of alu control signals
    constant CW_SIZE : integer := 7 + ALU_OPC_SIZE;                                     -- cw final size
    
    
    type aluOp is (NOP, ADDOP, SUBOP, MULOP, ANDOP, NANDOP, OROP, NOROP, XOROP, XNOROP, SLLOP, SRLOP, SRAOP, GTOP, GETOP, LTOP, LETOP, EQOP, NEQOP, GTUOP, GETUOP, LTUOP, LETUOP, LHIOP);


-- R-Type instruction -> FUNC field
    constant RTYPE_SLL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000100";    -- RTYPE_SLL
    constant RTYPE_SRL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000110";    -- RTYPE_SRL
    constant RTYPE_SRA : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000111";    -- RTYPE_SRA -Shift Right Arithmetic (keep the sign)
    constant RTYPE_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100000";    -- RTYPE_ADD
    constant RTYPE_ADDU : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100001";    -- RTYPE_ADDU
    constant RTYPE_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100010";    -- RTYPE_SUB
    constant RTYPE_SUBU : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100011";    -- RTYPE_SUBU
    constant RTYPE_AND : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100100";    -- RTYPE_AND
    constant RTYPE_OR : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100101";    -- RTYPE_OR
    constant RTYPE_XOR : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000100110";    -- RTYPE_XOR
    constant RTYPE_SEQ : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101000";    -- RTYPE_SEQ
    constant RTYPE_SNE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101001";    -- RTYPE_SNE
    constant RTYPE_SLT : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101010";    -- RTYPE_SLT
    constant RTYPE_SGT : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101011";    -- RTYPE_SGT
    constant RTYPE_SLE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101100";    -- RTYPE_SLE
    constant RTYPE_SGE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000101101";    -- RTYPE_SGE
    --constant NOP : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000000";

-- R-Type instruction -> OPCODE field
    constant RTYPE : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000000";          -- for ADD, SUB, AND, OR register-to-register operation

-- I-Type instruction -> OPCODE field
    constant ITYPE_J : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000010";     -- ITYPE_J
    constant ITYPE_JAL : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000011";   -- ITYPE_JAL
    constant ITYPE_SRA : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "010111";    --ITYPE_SRA
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
