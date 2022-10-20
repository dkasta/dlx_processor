library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.myTypes.all;

entity CU_HARDWIRED is
       port (-- ID Control Signals
              wr31_enable : OUT std_logic;
              write_enable    : OUT std_logic;    -- MUX-A Sel
              rd1_enable    : OUT std_logic;    -- MUX-B Sel
              rd2_enable      : OUT std_logic;
              call      : OUT std_logic;
              ret      : OUT std_logic;
              imm_mux_control : OUT std_logic;
              EN2      : OUT std_logic;
              
             -- EX Control Signal
             mux_one_control      : OUT std_logic_vector(1 downto 0);
             mux_two_control      : OUT std_logic_vector(1 downto 0);
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
             nop_add:            IN std_logic;  -- It goes in CU
             alu_forwarding_one: IN std_logic;
             alu_forwarding_two: IN std_logic;
             mem_forwarding_one: IN std_logic;
             mem_forwarding_two: IN std_logic;
             FLUSH : IN std_logic_vector(1 downto 0));                  -- Active high
              
end CU_HARDWIRED;

architecture BEHAVIORAL of CU_HARDWIRED is

  --if bits in mem_array are (others => '0') it means that either the instruction
  --is not implemented or is a NTYPE_NOP
  type mem_array is array (integer range 0 to MICROCODE_MEM_SIZE - 1) of std_logic_vector(CW_SIZE - 1 downto 0);
  signal cw_mem_rtype : mem_array := ("00000000000000000000000",
      						                    "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "0110001" & "1100010101" & "000111",     --RTYPE_SLL  SLLOP
                                      "00000000000000000000000",
                                      "0110001" & "1100010111" & "000111",     --RTYPE_SRL  SRLOP
                                      "0110001" & "1100011001" & "000111",     --RTYPE_SRA  SRAOP           
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "0110001" & "1100000011" & "000111",     --RTYPE_ADD
                                      "00000000000000000000000",     --RTYPE_ADDU  not implemented
                                      "0110001" & "1100000101"  & "000111",     --RTYPE_SUB 
                                      "00000000000000000000000",     --RTYPE_SUBU  not implemented
                                      "0110001" & "1100001001" & "000111",     --RTYPE_AND
                                      "0110001" & "1100001101" & "000111",     --RTYPE_OR
                                      "0110001" & "1100010001" & "000111",     --RTYPE_XOR
                                      "00000000000000000000000",
                                      "0110001" & "1100100011" & "000111",     --RTYPE_SEQ   EQOP
                                      "0110001" & "1100100101" & "000111",     --RTYPE_SNE   NEQOP
                                      "0110001" & "1100011111" & "000111",     --RTYPE_SLT  LTOP
                                      "0110001" & "1100011011" & "000111",     --RTYPE_SGT GTOP
                                      "0110001" & "1100100001" & "000111",     --RTYPE_SLE LETOP
                                      "0110001" & "1100011101" & "000111",     --RTYPE_SGE GETOP
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "00000000000000000000000",     --RTYPE_MOVI2S                --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVS2I                --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVF                  --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVD                  --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVFP2I               --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVI2FP               --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVI2T                --not implemented
                                      "00000000000000000000000",     --RTYPE_MOVT2I                --not implemented
                                      "00000000000000000000000",
                                      "00000000000000000000000",
                                      "0110001" & "1100101011" & "000111",     --RTYPE_SLTU  LTUOP                 --not implemented
                                      "0110001" & "1100100111" & "000111",     --RTYPE_SGTU  GTUOP                --not implemented
                                      "0110001" & "1100101101" & "000111",     --RTYPE_SLEU  LETUOP                --not implemented
                                      "0110001" & "1100101001" & "000111",      --RTYPE_SGEU   GETUOP               --not implemented
                                      "0110001" & "1100000111" & "000111",       --RTYPE_MUL
                                      "0110001" & "1100001011" & "000111",        --RTYPE_NAND
                                      "0110001" & "1100001111" & "000111",        --RTYPE_NOR
                                      "0110001" & "1100010011" & "000111",        --RTYPE_XNOR
                                      "0110001" & "1100101111" & "000111",        --RTYPE_LHI
                                      "0110001" & "1100110001" & "000111"        --RTYPE_LLI

                                      );

signal cw_mem_itype : mem_array := ("00000000000000000000000",     --START NOT R_TYPE
                                    "00000000000000000000000",
                                    "000001" & "00000000000000000",     --JTYPE_J                     --implemented in the branch prediction unit
                                    "100001" & "00000000000000000",     --JTYPE_JAL                   --not implemented
                                    "010000" & "00000000000000000",     --ITYPE_BEQZ                  --implemented in the branch prediction unit
                                    "010000" & "00000000000000000",     --ITYPE_BNEZ                  --implemented in the branch prediction unit
                                    "00000000000000000000000",     --ITYPE_BFPT                  --not implemented
                                    "00000000000000000000000",     --ITYPE_BFPF                  --not implemented
                                    "0100001" & "1111000011" & "000111",     --ITYPE_ADD
                                    "00000000000000000000000",     --ITYPE_ADDU                  --not implemented
                                    "0100001" & "1111000101" & "000111",     --ITYPE_SUB
                                    "00000000000000000000000",     --ITYPE_SUBU                  --not implemented
                                    "0100001" & "1111001001" & "000111",     --ITYPE_AND
                                    "0100001" & "1111001101" & "000111",     --ITYPE_OR
                                    "0100001" & "1111010001" & "000111",     --ITYPE_XOR
                                    "00000000000000000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000000000000000",     --ITYPE_RFE                   --not implemented
                                    "00000000000000000000000",     --ITYPE_TRAP                  --not implemented
                                    "00000000000000000000000",     --JTYPE_JR                    --implemented in the branch prediction unit
                                    "00000000000000000000000",     --JTYPE_JALR                  --implemented in the branch prediction unit
                                    "0100001" & "1111010101" & "000111",     --ITYPE_SLL
                                    "00000000000000000000000",     --NTYPE_NOP
                                    "0100001" & "1111010111" & "000111",     --ITYPE_SRL
                                    "00000000000000000000000",     --ITYPE_SRA                   --not implemented
                                    "0100001" & "1111100011" & "000111",     --ITYPE_SEQ
                                    "0100001" & "1111100101" & "000111",     --ITYPE_SNE
                                    "0100001" & "1111011111" & "000111",     --ITYPE_SLT Lower 
                                    "0100001" & "1111011011" & "000111",     --ITYPE_SGT Greater
                                    "0100001" & "1111100001" & "000111",     --ITYPE_SLE
                                    "0100001" & "1111011101" & "000111",     --ITYPE_SGE
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",     --ITYPE_LB                    --not implemented
                                    "00000000000000000000000",     --ITYPE_LH                    --not implemented
                                    "00000000000000000000000",
                                    "0100001" & "1111000011" & "011111",     --ITYPE_LW         lw rD, 4(ra)
                                    "00000000000000000000000",     --ITYPE_LBU                   --not implemented
                                    "00000000000000000000000",     --ITYPE_LHU                   --not implemented
                                    "00000000000000000000000",     --ITYPE_LF                    --not implemented
                                    "00000000000000000000000",     --ITYPE_LD                    --not implemented
                                    "00000000000000000000000",     --ITYPE_SB                    --not implemented
                                    "00000000000000000000000",     --ITYPE_SH                    --not implemented
                                    "00000000000000000000000",
                                    "0110001" & "1111000011" & "100110",     --ITYPE_SW
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",     --ITYPE_SF                    --not implemented
                                    "00000000000000000000000",     --ITYPE_SD                    --not implemented
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",     --NTYPE_ITLB                  --not implemented
                                    "00000000000000000000000",
                                    "00000000000000000000000",     --ITYPE_SLTU                  --not implemented
                                    "00000000000000000000000",     --ITYPE_SGTU                  --not implemented
                                    "00000000000000000000000",     --ITYPE_SLEU                  --not implemented
                                    "00000000000000000000000",      --ITYPE_SGEU                  --not implemented
                                    "100101" & "00000000000000000", --CALL
                                    "010010" & "00000000000000000", --RET
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000",
                                    "00000000000000000000000"
                                    );

  signal cw : std_logic_vector(CW_SIZE - 1 downto 0); -- full control word read from cw_mem

  -- control word is shifted to the correct stage
  signal cw2 : std_logic_vector(CW_SIZE - 1 downto 0);      -- decode stage         21   (20 downto 0)
  signal cw3 : std_logic_vector(CW_SIZE - 1 - 7 downto 0);     -- execute stage     16   (15 downto 0)
  signal cw4 : std_logic_vector(CW_SIZE - 1 - 7 - 10 downto 0); -- memory stage       6   (5 donwto 0)
  signal cw5 : std_logic_vector(CW_SIZE  - 1 - 7 - 10 - 4 downto 0); -- write back stage   2   (1 downto 0)

begin

  -- stage one control signals
  wr31_enable <= cw2(22);
  rd1_enable <= cw2(21);
  rd2_enable <= cw2(20);
  call <= cw2(19);
  ret <= cw2(18);
  imm_mux_control <= cw2(17);
  EN2 <= cw2(16);
  -- stage two control signals
  mux_one_control <= cw3(15 downto 14);
  mux_two_control <= cw3(13 downto 12);
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
      elsif (nop_add = '1') then
        cw3 <= (others => '0');
      else
        cw2 <= cw;                                --21
        if (alu_forwarding_one = '1') and ( alu_forwarding_two = '0') then   
          cw3 <= "01" & cw2(13 downto 0);
        elsif (alu_forwarding_one = '1') and ( alu_forwarding_two = '1') then
          cw3 <= "0101" & cw2(11 downto 0);
        elsif (alu_forwarding_one = '0') and ( alu_forwarding_two = '1') then   
          cw3 <= cw2(15 downto 14) & "01" & cw2(11 downto 0);
        elsif (mem_forwarding_one = '1') and ( mem_forwarding_two = '0') then   
          cw3 <= "10" & cw2(13 downto 0);
        elsif (mem_forwarding_one = '1') and ( mem_forwarding_two = '1') then
          cw3 <= "1010" & cw2(11 downto 0);
        elsif (mem_forwarding_one = '0') and ( mem_forwarding_two = '1') then   
          cw3 <= cw2(15 downto 14) & "10" & cw2(11 downto 0);
        elsif (alu_forwarding_one = '1') and ( mem_forwarding_two = '1') then   
          cw3 <= "0110" & cw2(11 downto 0);
        elsif (mem_forwarding_one = '1') and ( alu_forwarding_two = '1') then   
          cw3 <= "1001" & cw2(11 downto 0);
        else
          cw3 <= cw2(15 downto 0);         --16
        end if;
        cw4 <= cw3(5 downto 0);     --6
        cw5 <= cw4(1 downto 0); --2
      end if;
    end if;
  end process CW_PIPE;

end BEHAVIORAL;

