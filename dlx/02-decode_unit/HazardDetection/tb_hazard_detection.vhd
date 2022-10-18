library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_HAZARD_DETECTION is
end TB_HAZARD_DETECTION;

architecture TEST of TB_HAZARD_DETECTION is

  signal clk_s : std_logic := '0';
  signal reset_s : std_logic := '1';
  signal OPCODE_s : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000001";
  signal RD_REG_IN_ITYPE_s : std_logic_vector(4 downto 0);
  signal RD_REG_IN_RTYPE_s : std_logic_vector(4 downto 0);
  signal RS1_REG_IN_s : std_logic_vector(4 downto 0);
  signal RS2_REG_IN_s : std_logic_vector(4 downto 0);
  signal alu_forwarding_one_s : std_logic;
  signal mem_forwarding_one_s : std_logic;
  signal alu_forwarding_two_s : std_logic;
  signal mem_forwarding_two_s : std_logic;
  signal RD_OUT_s : std_logic_vector(4 downto 0);
  signal nop_add_s: std_logic;
  constant clktime : time :=10 ns;
  component HAZARD_DETECTION
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RD_REG_IN_ITYPE : IN std_logic_vector(4 downto 0);
       RD_REG_IN_RTYPE : IN std_logic_vector(4 downto 0);
       RS1_REG_IN : IN std_logic_vector(4 downto 0);
       RS2_REG_IN : IN std_logic_vector(4 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic;
       nop_add:            out std_logic;
       RD_OUT : OUT std_logic_vector(4 downto 0));
  end component;

  begin
    DUT : HAZARD_DETECTION
    port map(nop_add=>nop_add_s,clk=>clk_s,reset=>reset_s,OPCODE=>opcode_s,RD_REG_IN_ITYPE=>RD_REG_IN_ITYPE_s,RD_REG_IN_RTYPE=>RD_REG_IN_RTYPE_s,RS1_REG_IN=>RS1_REG_IN_s,RS2_REG_IN=>RS2_REG_IN_s,alu_forwarding_one=>alu_forwarding_one_s,mem_forwarding_one=>mem_forwarding_one_s,alu_forwarding_two=>alu_forwarding_two_s,mem_forwarding_two=>mem_forwarding_two_s,RD_OUT=>RD_OUT_s);

    process
    begin
        clk_s<='0';
        wait for clktime/2;
        clk_s<='1';
        wait for clktime/2;
    end process;
    process
    begin
        reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --LW r1,(0)r3  IF ID EX  MEM  MEM WB op2
        --0-5 opcode "001000"
        --6-10 rs1 "00011"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000001"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00011";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r5,r1,r4	IF ID  NOP  NOP EX  MEM WB op1
        --0-5 opcode "00000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00100"
        --16-20 rd "00101"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00100";
         RD_REG_IN_RTYPE_s<="00101";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00100";
         wait for clktime;
        reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --LW r1,(0)r3  IF ID EX  MEM  MEM WB op2
        --0-5 opcode "001000"
        --6-10 rs1 "00011"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000001"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00011";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r5,r4,r1	IF ID  NOP  NOP EX  MEM WB op1
        --0-5 opcode "00000"
        --6-10 rs1 "00100"
        --11-15 rs2 "00001"
        --16-20 rd "00101"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00101";
         RS1_REG_IN_s<="00100";
         RS2_REG_IN_s<="00001";
         wait for clktime;
         reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --LW r1,(0)r3  IF ID EX  MEM  MEM WB op2
        --0-5 opcode "001000"
        --6-10 rs1 "00011"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000001"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00011";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --LW r2,(0)r1  	IF ID NOP NOP EX  MEM MEM WB op1
        --0-5 opcode "100011"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000000"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
          reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source opcode 2
        --0-5 opcode "00000"
        --6-10 rs1 "00010"
        --11-15 rs2 "00011"
        --16-20 rd "00001"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00001";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00011";
         wait for clktime;
        --add R2,R1,R3	IF ID EX  MEM WB  -dest ALU FORWARDING opcode1
        --0-5 opcode "00000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00011"
        --16-20 rd "00010"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00010";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00011";
         wait for clktime;
         reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R2,R1,R3 IF ID EX MEM WB -source
        --0-5 opcode "00000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00011"
        --16-20 rd "00010"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00010";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00011";
         wait for clktime;
        --add R1,R3,r2	IF ID EX  MEM WB  -dest ALU FORWARDING
        --0-5 opcode "00000"
        --6-10 rs1 "00011"
        --11-15 rs2 "00010"
        --16-20 rd "00001"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00001";
         RS1_REG_IN_s<="00011";
         RS2_REG_IN_s<="00010";
         wait for clktime;
         reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source
        --0-5 opcode "00000"
        --6-10 rs1 "00010"
        --11-15 rs2 "00011"
        --16-20 rd "00001"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00001";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00011";
         wait for clktime;
        --add R2,R1,3	IF ID EX  MEM WB  -dest ALU FORWARDING
        --0-5 opcode "001000"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
         reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source opcode 2
        --0-5 opcode "000000"
        --6-10 rs1 "00010"
        --11-15 rs2 "00011"
        --16-20 rd "00001"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00001";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00011";
         wait for clktime;
        --lw  R2,R1(0)	IF ID EX  MEM  mem WB  -dest ALU FORWARDING opcode1
        --0-5 opcode "011101"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="011101"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
         reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,3  IF ID EX MEM WB -source opcode2
        --0-5 opcode "011100"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add R2,R1,R3	IF ID EX  MEM WB  -dest ALU FORWARDING
        --0-5 opcode "000000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00011"
        --16-20 rd "00010"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00011";
         RD_REG_IN_RTYPE_s<="00010";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00011";
         wait for clktime;   
          reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R2,R1,12 IF ID EX MEM WB -source
        --0-5 opcode "011100"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000010001"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
        --add R1,R3,r2	IF ID EX  MEM WB  -dest ALU FORWARDING
        --0-5 opcode "000000"
        --6-10 rs1 "00011"
        --11-15 rs2 "00010"
        --16-20 rd "00001"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00001";
         RS1_REG_IN_s<="00011";
         RS2_REG_IN_s<="00010";
         wait for clktime;     
          reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,3  IF ID EX MEM WB -source
        --0-5 opcode "011100"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000010001"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add R2,R1,12	IF ID EX  MEM WB  -dest ALU FORWARDING
        --0-5 opcode "011100"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000010001"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;     
          reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,12 IF ID EX MEM WB -source
        --0-5 opcode "011100"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000010001"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --lw  R2,R1(0)	IF ID EX  MEM  mem WB  -dest ALU FORWARDING
        --0-5 opcode "011100"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000010001"
         OPCODE_s<="011100"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;                    
        wait;
        
    end process;
    
end TEST;
