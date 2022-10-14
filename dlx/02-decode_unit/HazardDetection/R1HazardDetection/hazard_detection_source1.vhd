library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity HAZARD_DETECTION1 is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS1_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       RD_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       nop_add:             OUT std_logic);
end HAZARD_DETECTION1;

architecture BEHAVIORAL of HAZARD_DETECTION1 is
  signal rd_reg : std_logic_vector(NumBitAddress-1 downto 0);
  signal rd_reg_1 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rd_reg_2 : std_logic_vector(NumBitAddress-1 downto 0);
   signal rd_reg_3 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs1_reg : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs1_reg_1 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs1_reg_2 : std_logic_vector(NumBitAddress-1 downto 0);
  signal rs1_reg_3 : std_logic_vector(NumBitAddress-1 downto 0);
  signal opcode_i: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal opcode_1: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal opcode_2: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
  signal opcode_3: std_logic_vector(OP_CODE_SIZE - 1 downto 0);
begin

    IN_PROCESS : process(OPCODE,RS1_REG_IN,RD_REG_IN)
  	begin
      --se è una r type o una i type salva il registro altrimenti tutti 0 (registro r0 è sempre 0) in if stage
  		if (OPCODE = RTYPE or OPCODE = ITYPE_ADDI or OPCODE = ITYPE_SUBI or OPCODE = ITYPE_ANDI or OPCODE = ITYPE_ORI or OPCODE = ITYPE_XORI or OPCODE = ITYPE_SLLI or OPCODE = ITYPE_SRLI or OPCODE = ITYPE_BEQZ or OPCODE = ITYPE_SW or OPCODE = ITYPE_SNEI or OPCODE =ITYPE_BNEZ or OPCODE = ITYPE_LW or OPCODE = ITYPE_SLEI or OPCODE = ITYPE_SGEI) then      --any non rtype opcode
  			rd_reg <= RD_REG_IN;
            rs1_reg <= RS1_REG_IN;
            opcode_i<=opcode;
  		else
  			rd_reg <= (others => '0');
            rs1_reg <= (others => '0');
            opcode_i <= (others => '0');
  		end if;
  	end process;

    PIPE : process(clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)

        rs1_reg_1 <= (others => '0');
        rs1_reg_2 <= (others => '0');
        rs1_reg_3 <= (others => '0');
        rd_reg_1 <= (others => '0');
        rd_reg_2 <= (others => '0');
        rd_reg_3 <= (others => '0');
        opcode_1 <= (others => '0');
        opcode_2 <= (others => '0');
        opcode_3 <= (others => '0');
      elsif(rising_edge(Clk)) then 

        opcode_1 <= opcode_i; --id
        opcode_2 <= opcode_1; --ex
        opcode_3 <= opcode_2; --mem
        rs1_reg_1 <= rs1_reg; --id
        rs1_reg_2 <= rs1_reg_1; --ex
        rs1_reg_3 <= rs1_reg_2; --mem
        rd_reg_1 <= rd_reg; --id
        rd_reg_2 <= rd_reg_1; --ex
        rd_reg_3 <= rd_reg_2; --mem
      end if;
    end process PIPE;

    alu_forwarding_PROCESS : process (clk, reset)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        alu_forwarding_one <= '0';
      elsif (rising_edge(clk)) then                 -- rising clock edge
        --alu-alu alu_forwarding 
        --add R1,R2,R3 IF ID EX MEM WB -source
        --add R2,R1,R3	IF ID EX  MEM WB  -dest ALU FORWARDING
        if((opcode_1=RTYPE and opcode_1=opcode_2)or(opcode_2=RTYPE and opcode_1/=(OP_CODE_SIZE - 1 downto 0 =>'0'))) then
            if(rd_reg_2=rs1_reg_1) then
                alu_forwarding_one<='1';
            end if;
        else
            alu_forwarding_one<='0';
        end if;
      end if;
    end process alu_forwarding_PROCESS;

    mem_forwarding_PROCESS : process (clk, reset)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        mem_forwarding_one <= '0';
      elsif (rising_edge(clk)) then                 -- rising clock edge
        if((opcode_1=RTYPE and opcode_1=opcode_3)or(opcode_3/=(OP_CODE_SIZE - 1 downto 0 =>'0') and opcode_1/=(OP_CODE_SIZE - 1 downto 0 =>'0'))) then
            if(rd_reg_3=rs1_reg_1) then
                mem_forwarding_one<='1';
            end if;
        else
            mem_forwarding_one<='0';
        end if;
      end if;
    end process mem_forwarding_PROCESS;

    nop_PROCESS : process (clk, reset)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        nop_add <= '0';
      elsif (rising_edge(clk)) then                 -- rising clock edge
        if(opcode_1/=(OP_CODE_SIZE - 1 downto 0 =>'0') and opcode_2/=RTYPE and opcode_2/=(OP_CODE_SIZE - 1 downto 0 =>'0') ) then
            if(rd_reg_2=rs1_reg_1) then
                nop_add<='1';
            end if;
        else
            nop_add<='0';
        end if;
      end if;
    end process nop_PROCESS;    
end BEHAVIORAL;