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
             FLUSH : IN std_logic_vector(1 downto 0));                  -- Active high
              
end CU_HARDWIRED;

architecture BEHAVIORAL of CU_HARDWIRED is

  --if bits in mem_array are (others => '0') it means that either the instruction
  --is not implemented or is a NTYPE_NOP
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem_rtype : mem_array := ("000000000000000000000",
      						                    "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "111000110010101000111",     --RTYPE_SLL
                                      "000000000000000000000",
                                      "111000110010111000111",     --RTYPE_SRL
                                      "111000110011001000111",     --RTYPE_SRA                   --not implemented
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "111000110000011000111",     --RTYPE_ADD
                                      "000000000000000000000",     --RTYPE_ADDU  not implemented
                                      "111000110000101000111",     --RTYPE_SUB 011000110
                                      "000000000000000000000",     --RTYPE_SUBU  not implemented
                                      "111000110001001000111",     --RTYPE_AND
                                      "111000110001101000111",     --RTYPE_OR
                                      "111000110010001000111",     --RTYPE_XOR
                                      "000000000000000000000",
                                      "111000110100011000111",     --RTYPE_SEQ
                                      "111000110100101000111",     --RTYPE_SNE
                                      "111000110011111000111",     --RTYPE_SLT
                                      "111000110011011000111",     --RTYPE_SGT
                                      "111000110100001000111",     --RTYPE_SLE
                                      "111000110011101000111",     --RTYPE_SGE
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "000000000000000000000",     --RTYPE_MOVI2S                --not implemented
                                      "000000000000000000000",     --RTYPE_MOVS2I                --not implemented
                                      "000000000000000000000",     --RTYPE_MOVF                  --not implemented
                                      "000000000000000000000",     --RTYPE_MOVD                  --not implemented
                                      "000000000000000000000",     --RTYPE_MOVFP2I               --not implemented
                                      "000000000000000000000",     --RTYPE_MOVI2FP               --not implemented
                                      "000000000000000000000",     --RTYPE_MOVI2T                --not implemented
                                      "000000000000000000000",     --RTYPE_MOVT2I                --not implemented
                                      "000000000000000000000",
                                      "000000000000000000000",
                                      "111000110101011000111",     --RTYPE_SLTU                  --not implemented
                                      "111000110100111000111",     --RTYPE_SGTU                  --not implemented
                                      "111000110101101000111",     --RTYPE_SLEU                  --not implemented
                                      "111000110101001000111",      --RTYPE_SGEU                  --not implemented
                                      "111000110000111000111",       --RTYPE_MUL
                                      "111000110001011000111",        --RTYPE_NAND
                                      "111000110001111000111",        --RTYPE_NOR
                                      "111000110010011000111",        --RTYPE_XNOR
                                      "111000110101111000111",        --RTYPE_LHI
                                      "111000110110001000111"        --RTYPE_LLI

                                      );

signal cw_mem_itype : mem_array := ("000000000000000000000",     --START NOT R_TYPE
                                    "000000000000000000000",
                                    "100001101000000000000",     --JTYPE_J                     --implemented in the branch prediction unit
                                    "000001000000000000000",     --JTYPE_JAL                   --not implemented
                                    "110000000000000000000",     --ITYPE_BEQZ                  --implemented in the branch prediction unit
                                    "110000000000000000000",     --ITYPE_BNEZ                  --implemented in the branch prediction unit
                                    "000000000000000000000",     --ITYPE_BFPT                  --not implemented
                                    "000000000000000000000",     --ITYPE_BFPF                  --not implemented
                                    "110000111000011000111",     --ITYPE_ADD
                                    "000000000000000000000",     --ITYPE_ADDU                  --not implemented
                                    "110000111000101000111",     --ITYPE_SUB
                                    "000000000000000000000",     --ITYPE_SUBU                  --not implemented
                                    "110000111001001000111",     --ITYPE_AND
                                    "110000111001101000111",     --ITYPE_OR
                                    "110000111010001000111",     --ITYPE_XOR
                                    "000000000000000000000",     --ITYPE_LH                    --not implemented
                                    "000000000000000000000",     --ITYPE_RFE                   --not implemented
                                    "000000000000000000000",     --ITYPE_TRAP                  --not implemented
                                    "000000000000000000000",     --JTYPE_JR                    --implemented in the branch prediction unit
                                    "000000000000000000000",     --JTYPE_JALR                  --implemented in the branch prediction unit
                                    "110000111010101000111",     --ITYPE_SLL
                                    "000000100000000000000",     --NTYPE_NOP
                                    "110000111010111000111",     --ITYPE_SRL
                                    "000000000000000000000",     --ITYPE_SRA                   --not implemented
                                    "000000000000000000000",     --ITYPE_SEQ
                                    "110000111100101000111",     --ITYPE_SNE
                                    "000000000000000000000",     --ITYPE_SLT
                                    "000000000000000000000",     --ITYPE_SGT
                                    "110000111100001000111",     --ITYPE_SLE
                                    "110000111011101000111",     --ITYPE_SGE
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",     --ITYPE_LB                    --not implemented
                                    "000000000000000000000",     --ITYPE_LH                    --not implemented
                                    "000000000000000000000",
                                    "110000111000011011111",     --ITYPE_LW         lw rD, 4(ra)
                                    "000000000000000000000",     --ITYPE_LBU                   --not implemented
                                    "000000000000000000000",     --ITYPE_LHU                   --not implemented
                                    "000000000000000000000",     --ITYPE_LF                    --not implemented
                                    "000000000000000000000",     --ITYPE_LD                    --not implemented
                                    "000000000000000000000",     --ITYPE_SB                    --not implemented
                                    "000000000000000000000",     --ITYPE_SH                    --not implemented
                                    "000000000000000000000",
                                    "000000000000000000000",     --ITYPE_SW
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",     --ITYPE_SF                    --not implemented
                                    "000000000000000000000",     --ITYPE_SD                    --not implemented
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",     --NTYPE_ITLB                  --not implemented
                                    "000000000000000000000",
                                    "000000000000000000000",     --ITYPE_SLTU                  --not implemented
                                    "000000000000000000000",     --ITYPE_SGTU                  --not implemented
                                    "000000000000000000000",     --ITYPE_SLEU                  --not implemented
                                    "000000000000000000000",      --ITYPE_SGEU                  --not implemented
                                    "000100000000000000000", --CALL
                                    "110010000000000000000", --RET
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000",
                                    "000000000000000000000"
                                    );

  signal cw : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem

  -- control word is shifted to the correct stage
  signal cw2 : std_logic_vector(CW_SIZE - 1 downto 0);      -- decode stage         21   (20 downto 0)
  signal cw3 : std_logic_vector(CW_SIZE - 7 downto 0);     -- execute stage         14   (13 downto 0)
  signal cw4 : std_logic_vector(CW_SIZE - 7 - 8 downto 0); -- memory stage           6   (5 donwto 0)
  signal cw5 : std_logic_vector(CW_SIZE - 7 - 8 - 4 downto 0); -- write back stage   2   (1 downto 0)

begin

  -- stage one control signals
  jal_mux_control <= cw2(20);
  rd1_enable <= cw2(19);
  rd2_enable <= cw2(18);
  call <= cw2(17);
  ret <= cw2(16);
  imm_mux_control <= cw2(15);
  EN2 <= cw2(14);
  -- stage two control signals
  mux_one_control <= cw3(13);
  mux_two_control <= cw3(12);
  ALU_OPCODE <= cw3(11 downto 7); -- 12 downto 8
  EN3 <=  cw3(6);



  -- stage three control signals
  DRAM_write_enable <= cw4(5);
  DRAM_read_enable <= cw4(4);
  mux_mem_control <= cw4(3);
  EN4 <= cw4(2);


  --stage four control singals
  mux_wb_control <= cw5(1);
  write_enable <= cw5(0);

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
      if (FLUSH = "00") then
        cw2 <= (others => '0');
      else
        cw2 <= cw;                                --21
        cw3 <= cw2(CW_SIZE - 7 downto 0);         --14
        cw4 <= cw3(CW_SIZE - 7 - 8 downto 0);     --6
        cw5 <= cw4(CW_SIZE - 7 - 8 - 4 downto 0); --2
      end if;
    end if;
  end process CW_PIPE;

end BEHAVIORAL;


