library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity HAZARD_DETECTION2 is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS2_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       RD_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic;
       nop_add:             OUT std_logic);
end HAZARD_DETECTION2;

architecture BEHAVIORAL of HAZARD_DETECTION2 is
  signal rd_reg : std_logic_vector(NumBitAddress-1 downto 0);
  signal rd_reg_1 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rd_reg_2 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs2_reg : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs2_reg_1 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs2_reg_2 : std_logic_vector(NumBitAddress-1 downto 0);
  signal opcode_i: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal opcode_1: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal opcode_2: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
begin

    IN_PROCESS : process(OPCODE,RS2_REG_IN,RD_REG_IN,RESET)
  	begin
      --se è una r type o una i type salva il registro altrimenti tutti 0 (registro r0 è sempre 0) in if stage
  		IF reset='1' then
  		    rd_reg <= (others => '0');
            rs2_reg <= (others => '0');
            opcode_i <= NTYPE_NOP;
        else
            if (OPCODE = RTYPE or OPCODE = ITYPE_ADDI or OPCODE = ITYPE_SUBI or OPCODE = ITYPE_ANDI or OPCODE = ITYPE_ORI or OPCODE = ITYPE_XORI or OPCODE = ITYPE_SLLI or OPCODE = ITYPE_SRLI or OPCODE = ITYPE_BEQZ or OPCODE = ITYPE_SW or OPCODE = ITYPE_SNEI or OPCODE =ITYPE_BNEZ or OPCODE = ITYPE_LW or OPCODE = ITYPE_SLEI or OPCODE = ITYPE_SGEI) then      --any non rtype opcode
                if(OPCODE=RTYPE and RD_REG_IN=(NumBitAddress-1 downto 0=>'0') and RS2_REG_IN=(NumBitAddress-1 downto 0=>'0')) then
                  rd_reg <= (others => '0');
                  rs2_reg <= (others => '0');
                  opcode_i <= NTYPE_NOP;
                else
                rd_reg <= RD_REG_IN;
                rs2_reg <= RS2_REG_IN;
                opcode_i<=opcode;
                end if;
            else
                rd_reg <= (others => '0');
                rs2_reg <= (others => '0');
                opcode_i <= NTYPE_NOP;
            end if;
  		end if;
  	end process;

    PIPE : process(clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)

        rs2_reg_1 <= (others => '0');
        rs2_reg_2 <= (others => '0');
        rd_reg_1 <= (others => '0');
        rd_reg_2 <= (others => '0');
        opcode_1 <= NTYPE_NOP;
        opcode_2 <= NTYPE_NOP;
      elsif(rising_edge(Clk)) then 

        opcode_1 <= opcode_i; --id
        opcode_2 <= opcode_1; --ex
        rs2_reg_1 <= rs2_reg; --id
        rs2_reg_2 <= rs2_reg_1; --ex
        rd_reg_1 <= rd_reg; --id
        rd_reg_2 <= rd_reg_1; --ex
      end if;
    end process PIPE;

    alu_forwarding_PROCESS : process (reset,opcode_1,opcode_i,rd_reg_1,rs2_reg)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        alu_forwarding_two <= '0';
      else             
        --alu-alu alu_forwarding 
        --add R1,R2,R3 IF ID EX MEM WB -source
        --add R2,R1,R3	IF ID EX  MEM WB  -dest ALU FORWARDING
        if(opcode_i=RTYPE and (opcode_1=opcode_i or opcode_1=ITYPE_ADDI or opcode_1=ITYPE_ANDI or opcode_1=ITYPE_ORI or opcode_1=ITYPE_SGEI or opcode_1=ITYPE_SLEI or opcode_1=ITYPE_SLLI or opcode_1=ITYPE_SNEI or opcode_1=ITYPE_SRLI or opcode_1=ITYPE_SUBI or opcode_1=ITYPE_XORI)) then
            if(rd_reg_1=rs2_reg) then
                alu_forwarding_two<='1';
            else  alu_forwarding_two<='0';
            end if;
        else
            alu_forwarding_two<='0';
        end if;
      end if;
    end process alu_forwarding_PROCESS;

    mem_forwarding_PROCESS : process (reset,rd_reg_2,rs2_reg,opcode_i,opcode_2)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        mem_forwarding_two <= '0';
      else                 -- rising clock edge
        if(opcode_i=RTYPE and (opcode_2=ITYPE_ADDI or opcode_2=ITYPE_ANDI or opcode_2=ITYPE_BEQZ or opcode_2=ITYPE_BNEZ or opcode_2=ITYPE_LW or opcode_2=ITYPE_ORI or opcode_2=ITYPE_SGEI or opcode_2=ITYPE_SLEI or opcode_2=ITYPE_SLLI or opcode_2=ITYPE_SNEI or opcode_2=ITYPE_SRLI or opcode_2=ITYPE_SUBI or opcode_2=ITYPE_SW or opcode_2=ITYPE_XORI or opcode_2=RTYPE)) then
            if(rd_reg_2=rs2_reg) then
                mem_forwarding_two<='1';
            else  mem_forwarding_two<='0';
            end if;
        else
            mem_forwarding_two<='0';
        end if;
      end if;
    end process mem_forwarding_PROCESS;

    nop_PROCESS : process (opcode_i,opcode_1,rd_reg_1,rs2_reg,reset)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        nop_add <= '0';
      else              -- rising clock edge
        if(opcode_i=RTYPE and (opcode_1=ITYPE_BEQZ or opcode_1=ITYPE_BNEZ or opcode_1=ITYPE_LW or opcode_1=ITYPE_SW) ) then
            if(rd_reg_1=rs2_reg) then
                nop_add<='1';
            else nop_add<='0';
            end if;
        else
            nop_add<='0';
        end if;
      end if;
    end process nop_PROCESS;    
end BEHAVIORAL;
