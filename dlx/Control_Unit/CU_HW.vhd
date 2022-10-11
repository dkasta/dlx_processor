library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;

entity CU_HARDWIRED is
       port (-- ID Control Signals
             -- EX Control Signal
             MUXA_CONTROL    : OUT std_logic;    -- MUX-A Sel
             MUXB_CONTROL    : OUT std_logic;    -- MUX-B Sel
             ALU_OPCODE      : OUT std_logic_vector(ALU_OPC_SIZE - 1 downto 0); -- ALU Operation Code
             -- MEM Control Signals
             DRAM_WE         : OUT std_logic;    -- Data RAM Write Enable
             DRAM_RE         : OUT std_logic;    -- Data RAM Read Enable
             -- WB Control Signals
             WB_MUX_SEL      : OUT std_logic;    -- Write Back MUX Sel
             JAL_SEL         : OUT std_logic;
             RF_WE           : OUT std_logic;    -- Register File Write Enable
             -- INPUTS
             OPCODE : IN  std_logic_vector(OP_CODE_SIZE - 1 downto 0);
             FUNC   : IN  std_logic_vector(FUNC_SIZE - 1 downto 0);
             Clk : IN std_logic;
             Rst : IN std_logic;
             FLUSH : IN std_logic);                  -- Active high
              
end CU_HARDWIRED;

architecture BEHAVIORAL of CU_HARDWIRED is

  --if bits in mem_array are (others => '0') it means that either the instruction
  --is not implemented or is a NTYPE_NOP
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem_rtype : mem_array := ("00000000000",
      						                    "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "10000000110",     --RTYPE_SLL
                                      "00000000000",
                                      "10000100110",     --RTYPE_SRL
                                      "00000000000",     --RTYPE_SRA                   --not implemented
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",
                                      "10001000110",     --RTYPE_ADD
                                      "00000000000",     --RTYPE_ADDU  not implemented
                                      "10001100110",     --RTYPE_SUB
                                      "00000000000",     --RTYPE_SUBU  not implemented
                                      "10010000110",     --RTYPE_AND
                                      "10010100110",     --RTYPE_OR
                                      "10011000110",     --RTYPE_XOR
                                      "00000000000",
                                      "10011100110",     --RTYPE_SEQ
                                      "10100000110",     --RTYPE_SNE
                                      "10100100110",     --RTYPE_SLT
                                      "10101000110",     --RTYPE_SGT
                                      "10101100110",     --RTYPE_SLE
                                      "10110000110",     --RTYPE_SGE
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",     --RTYPE_MOVI2S                --not implemented
                                      "00000000000",     --RTYPE_MOVS2I                --not implemented
                                      "00000000000",     --RTYPE_MOVF                  --not implemented
                                      "00000000000",     --RTYPE_MOVD                  --not implemented
                                      "00000000000",     --RTYPE_MOVFP2I               --not implemented
                                      "00000000000",     --RTYPE_MOVI2FP               --not implemented
                                      "00000000000",     --RTYPE_MOVI2T                --not implemented
                                      "00000000000",     --RTYPE_MOVT2I                --not implemented
                                      "00000000000",
                                      "00000000000",
                                      "00000000000",     --RTYPE_SLTU                  --not implemented
                                      "00000000000",     --RTYPE_SGTU                  --not implemented
                                      "00000000000",     --RTYPE_SLEU                  --not implemented
                                      "00000000000"      --RTYPE_SGEU                  --not implemented
                                      );

signal cw_mem_itype : mem_array := ("00000000000",     --START NOT R_TYPE
                                    "00000000000",
                                    "00110100000",     --JTYPE_J                     --implemented in the branch prediction unit
                                    "00111000111",     --JTYPE_JAL                   --not implemented
                                    "00110100000",     --ITYPE_BEQZ                  --implemented in the branch prediction unit
                                    "00110100000",     --ITYPE_BNEZ                  --implemented in the branch prediction unit
                                    "00000000000",     --ITYPE_BFPT                  --not implemented
                                    "00000000000",     --ITYPE_BFPF                  --not implemented
                                    "11001000110",     --ITYPE_ADD
                                    "00000000000",     --ITYPE_ADDU                  --not implemented
                                    "11001100110",     --ITYPE_SUB
                                    "00000000000",     --ITYPE_SUBU                  --not implemented
                                    "11010000110",     --ITYPE_AND
                                    "11010100110",     --ITYPE_OR
                                    "11011000110",     --ITYPE_XOR
                                    "00000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000",     --ITYPE_RFE                   --not implemented
                                    "00000000000",     --ITYPE_TRAP                  --not implemented
                                    "00110100000",     --JTYPE_JR                    --implemented in the branch prediction unit
                                    "00111000111",     --JTYPE_JALR                  --implemented in the branch prediction unit
                                    "11000000110",     --ITYPE_SLL
                                    "00110100000",     --NTYPE_NOP
                                    "11000100110",     --ITYPE_SRL
                                    "00000000000",     --ITYPE_SRA                   --not implemented
                                    "11011100110",     --ITYPE_SEQ
                                    "11100000110",     --ITYPE_SNE
                                    "11100100110",     --ITYPE_SLT
                                    "11101000110",     --ITYPE_SGT
                                    "11101100110",     --ITYPE_SLE
                                    "11110000110",     --ITYPE_SGE
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",     --ITYPE_LB                    --not implemented
                                    "00000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000",
                                    "11001001010",     --ITYPE_LW
                                    "00000000000",     --ITYPE_LBU                   --not implemented
                                    "00000000000",     --ITYPE_LHU                   --not implemented
                                    "00000000000",     --ITYPE_LF                    --not implemented
                                    "00000000000",     --ITYPE_LD                    --not implemented
                                    "00000000000",     --ITYPE_SB                    --not implemented
                                    "00000000000",     --ITYPE_SH                    --not implemented
                                    "00000000000",
                                    "11001010000",     --ITYPE_SW
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",     --ITYPE_SF                    --not implemented
                                    "00000000000",     --ITYPE_SD                    --not implemented
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",     --NTYPE_ITLB                  --not implemented
                                    "00000000000",
                                    "00000000000",     --ITYPE_SLTU                  --not implemented
                                    "00000000000",     --ITYPE_SGTU                  --not implemented
                                    "00000000000",     --ITYPE_SLEU                  --not implemented
                                    "00000000000"      --ITYPE_SGEU                  --not implemented
                                    );

  signal cw : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem

  -- control word is shifted to the correct stage
  --signal cw1 : std_logic_vector(CW_SIZE - 1 downto 0);                        -- decode stage
  signal cw2 : std_logic_vector(CW_SIZE - 1 downto 0);                        -- execution stage
  signal cw3 : std_logic_vector(CW_SIZE - 1 - 1 - ALU_OPC_SIZE downto 0);     -- memory stage
  signal cw4 : std_logic_vector(CW_SIZE - 1 - 1 - ALU_OPC_SIZE - 2 downto 0); -- write back stage

begin

  -- stage one control signals

  -- stage two control signals
  MUXA_CONTROL <= cw2(CW_SIZE - 1);
  MUXB_CONTROL <= cw2(CW_SIZE - 2);
  ALU_OPCODE <= cw2(CW_SIZE - 3 downto CW_SIZE - 3 - ALU_OPC_SIZE + 1);

  -- stage three control signals
  DRAM_WE <= cw3(CW_SIZE - 3 - ALU_OPC_SIZE);
  DRAM_RE <= cw3(CW_SIZE - 4 - ALU_OPC_SIZE);

  --stage four control singals
  WB_MUX_SEL <= cw4(CW_SIZE - 5 - ALU_OPC_SIZE);
  RF_WE <= cw4(CW_SIZE - 6 - ALU_OPC_SIZE);
  JAL_SEL <= cw4(CW_SIZE - 7 - ALU_OPC_SIZE);

	process(OPCODE, FUNC) --COMBINATIONAL PROCESS, calculates the address of the next microcode to execute given its OPCODE and FUNC.
	begin
		if (OPCODE = RTYPE) then
			cw <= cw_mem_rtype(conv_integer(FUNC)); --(opcode = 0 for rtype)->(FUNC+OPCODE)->FUNC directly points to RTYPE addresses in memory
		else
			cw <= cw_mem_itype(conv_integer(OPCODE));
		end if;
	end process;

  --3D = 61
  -- process to pipeline control words
  CW_PIPE: process (Clk, Rst)
  begin  -- process Clk
    if Rst = '1' then                   -- asynchronous reset (active high)
      --cw1 <= (others => '0');
      cw2 <= (others => '0');
      cw3 <= (others => '0');
      cw4 <= (others => '0');
    elsif Clk'event and Clk = '1' then  -- rising clock edge
      --cw1 <= cw;
      cw2 <= cw;
      cw3 <= cw2(CW_SIZE - 1 - ALU_OPC_SIZE - 1 downto 0); -- 5 downto 0    MEM and WB
      cw4 <= cw3(CW_SIZE - 1 - 2 - ALU_OPC_SIZE - 1 downto 0);  -- 3 downto 0  WB
    end if;
  end process CW_PIPE;

end BEHAVIORAL;


