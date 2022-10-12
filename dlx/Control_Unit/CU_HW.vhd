library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;

entity CU_HARDWIRED is
       port (-- ID Control Signals
              jal_mux_control : OUT std_logic;
              write_enable    : OUT std_logic;    -- MUX-A Sel
              rd1_enable    : OUT std_logic;    -- MUX-B Sel
              rd2_enable      : OUT std_logic;
              call      : OUT std_logic;
              ret      : OUT std_logic;
              imm_mux_control : OUT std_logic;
              EN2      : OUT std_logic;
              
             -- EX Control Signal
             mux_one_control      : OUT std_logic;
             mux_two_control      : OUT std_logic;
             ALU_OPCODE      : OUT std_logic_vector(4 downto 0);
             EN3      : OUT std_logic;
               
             -- MEM Control Signals
             DRAM_write_enable         : OUT std_logic;    -- Data RAM Write Enable
             DRAM_read_enable         : OUT std_logic;    -- Data RAM Read Enable
             mux_mem_control      : OUT std_logic;
             EN4      : OUT std_logic;
              
             -- WB Control Signals
             mux_wb_control      : OUT std_logic;    -- Write Back MUX Sel
             
             -- INPUTS
             OPCODE : IN  std_logic_vector(OP_CODE_SIZE - 1 downto 0);
             FUNC   : IN  std_logic_vector(FUNC_SIZE - 1 downto 0);
             Clk : IN std_logic;
             Rst : IN std_logic;
             WB_write_enable: OUT std_logic;
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
                                      "1011000110010101000111",     --RTYPE_SLL
                                      "00000000000",
                                      "1011000110010111000111",     --RTYPE_SRL
                                      "1011000110011001000111",     --RTYPE_SRA                   --not implemented
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
                                      "1011000110000011000111",     --RTYPE_ADD
                                      "00000000000",     --RTYPE_ADDU  not implemented
                                      "1011000110000101000111",     --RTYPE_SUB 011000110
                                      "00000000000",     --RTYPE_SUBU  not implemented
                                      "1011000110001001000111",     --RTYPE_AND
                                      "1011000110001101000111",     --RTYPE_OR
                                      "1011000110010001000111",     --RTYPE_XOR
                                      "00000000000",
                                      "1011000110100011000111",     --RTYPE_SEQ
                                      "1011000110100101000111",     --RTYPE_SNE
                                      "1011000110011111000111",     --RTYPE_SLT
                                      "1011000110011011000111",     --RTYPE_SGT
                                      "1011000110100001000111",     --RTYPE_SLE
                                      "1011000110011101000111",     --RTYPE_SGE
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
                                      "1011000110101011000111",     --RTYPE_SLTU                  --not implemented
                                      "1011000110100111000111",     --RTYPE_SGTU                  --not implemented
                                      "1011000110101101000111",     --RTYPE_SLEU                  --not implemented
                                      "1011000110101001000111",      --RTYPE_SGEU                  --not implemented
                                      "1011000110000111000111",       --RTYPE_MUL
                                      "1011000110001011000111"        --RTYPE_NAND
                                      "1011000110001111000111"        --RTYPE_NOR
                                      "1011000110010011000111"        --RTYPE_XNOR
                                      "1011000110101111000111"        --RTYPE_LHI
                                      "1011000110110001000111"        --RTYPE_LLI

                                      );

signal cw_mem_itype : mem_array := ("00000000000",     --START NOT R_TYPE
                                    "00000000000",
                                    "1000001101000000000000",     --JTYPE_J                     --implemented in the branch prediction unit
                                    "0100001000000000000000",     --JTYPE_JAL                   --not implemented
                                    "1010000000000000000000",     --ITYPE_BEQZ                  --implemented in the branch prediction unit
                                    "1010000000000000000000",     --ITYPE_BNEZ                  --implemented in the branch prediction unit
                                    "00000000000",     --ITYPE_BFPT                  --not implemented
                                    "00000000000",     --ITYPE_BFPF                  --not implemented
                                    "1010000111000011000111",     --ITYPE_ADD
                                    "00000000000",     --ITYPE_ADDU                  --not implemented
                                    "1010000111000101000111",     --ITYPE_SUB
                                    "00000000000",     --ITYPE_SUBU                  --not implemented
                                    "1010000111001001000111",     --ITYPE_AND
                                    "1010000111001101000111",     --ITYPE_OR
                                    "1010000111010001000111",     --ITYPE_XOR
                                    "00000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000",     --ITYPE_RFE                   --not implemented
                                    "00000000000",     --ITYPE_TRAP                  --not implemented
                                    "00110100000",     --JTYPE_JR                    --implemented in the branch prediction unit
                                    "00111000111",     --JTYPE_JALR                  --implemented in the branch prediction unit
                                    "1010000111010101000111",     --ITYPE_SLL
                                    "0000000000000000000000",     --NTYPE_NOP
                                    "1010000111010111000111",     --ITYPE_SRL
                                    "00000000000",     --ITYPE_SRA                   --not implemented
                                    "11011100110",     --ITYPE_SEQ
                                    "1010000111100101000111",     --ITYPE_SNE
                                    "11100100110",     --ITYPE_SLT
                                    "11101000110",     --ITYPE_SGT
                                    "1010000111100001000111",     --ITYPE_SLE
                                    "1010000111011101000111",     --ITYPE_SGE
                                    "00000000000",
                                    "00000000000",
                                    "00000000000",     --ITYPE_LB                    --not implemented
                                    "00000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000",
                                    "1010000111000011011111",     --ITYPE_LW         lw rD, 4(ra)
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
                                    "00000000000",      --ITYPE_SGEU                  --not implemented
                                    "0100100000000000000000", --CALL
                                    "1010010000000000000000", --RET
                                    );

  signal cw : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem

  -- control word is shifted to the correct stage
  --signal cw1 : std_logic_vector(CW_SIZE - 1 downto 0);                        -- decode stage
  signal cw2 : std_logic_vector(CW_SIZE - 1 downto 0);                        -- execution stage
  signal cw3 : std_logic_vector(CW_SIZE - 1 - 1 - ALU_OPC_SIZE downto 0);     -- memory stage
  signal cw4 : std_logic_vector(CW_SIZE - 1 - 1 - ALU_OPC_SIZE - 2 downto 0); -- write back stage

begin

  -- stage one control signals
  jal_mux_control <= cw2(CW_SIZE - 1);
  write_enable <= cw2(CW_SIZE - 2);
  rd1_enable <= cw2(CW_SIZE - 3);
  rd2_enable <= cw2(CW_SIZE - 4);
  call <= cw2(CW_SIZE - 5);
  ret <= cw2(CW_SIZE - 6);
  imm_mux_control <= cw2(CW_SIZE - 7);
  EN2 <= cw2(CW_SIZE - 8);
  -- stage two control signals
  mux_one_control <= cw3(CW_SIZE - 9);
  mux_two_control <= cw3(CW_SIZE - 10);
  ALU_OPCODE <= cw3(CW_SIZE - 11 downto CW_SIZE -11- ALU_OPC_SIZE);
  EN3 <=  cw3( CW_SIZE - 12 - ALU_OPC_SIZE);



  -- stage three control signals
  DRAM_write_enable <= cw4(CW_SIZE - 13 - ALU_OPC_SIZE);
  DRAM_read_enable <= cw4(CW_SIZE - 14 - ALU_OPC_SIZE);
  mux_mem_control <= cw4(CW_SIZE - 15 - ALU_OPC_SIZE);
  EN4 <= cw4(CW_SIZE - 16 - ALU_OPC_SIZE);


  --stage four control singals
  mux_wb_control <= cw5(CW_SIZE - 17 - ALU_OPC_SIZE);

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
      if (flush = '1') then
        cw2 <= (others => '0');
      else
        cw2 <= cw;
        cw3 <= cw2(CW_SIZE - 9 downto 0); -- 5 downto 0    MEM and WB
        cw4 <= cw3(CW_SIZE - 13 - ALU_OPC_SIZE downto 0);  -- 3 downto 0  WB  
        cw5 <= cw4(CW_SIZE - 17 - ALU_OPC_SIZE downto 0);
      end if;
    end if;
  end process CW_PIPE;

end BEHAVIORAL;


