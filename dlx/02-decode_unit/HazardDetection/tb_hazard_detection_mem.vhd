library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity TB_HAZARD_DETECTION is
end TB_HAZARD_DETECTION;

architecture TEST of TB_HAZARD_DETECTION is

  signal clk_s : std_logic;
  signal reset_s : std_logic;
  signal OPCODE_s : std_logic_vector(OP_CODE_SIZE - 1 downto 0);
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
        clk_s<='1';
        wait for clktime/2;
        clk_s<='0';
        wait for clktime/2;
    end process;
    process
    begin
        reset_s<='1';
        wait for clktime;
        reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source oopcode3
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
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,R3	   IF ID   EX  MEM WB  -dest mem FORWARDING opcode1
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
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R2,R1,R3 IF ID EX MEM WB -source op3
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
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R3,R1,R2	   IF ID   EX  MEM WB  -dest mem FORWARDING op1
        --0-5 opcode "00000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00010"
        --16-20 rd "00011"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00011";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source oopcode3
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
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,3	   IF ID   EX  MEM WB  -dest mem FORWARDING
        --0-5 opcode "001000"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R1,R2,R3 IF ID EX MEM WB -source oopcode3
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
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --lw  R2,R1(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING op1
        --0-5 opcode "100011"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R1,R2,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,R3 IF ID EX MEM WB -source op3
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
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R2,R1,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R3,R1,R2	   IF ID   EX  MEM WB  -dest mem FORWARDING
        --0-5 opcode "00000"
        --6-10 rs1 "00001"
        --11-15 rs2 "00010"
        --16-20 rd "00011"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00011";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R1,R2,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --add R1,R2,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --lw  R2,R1(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --lw  R1,R2(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,R3 IF ID EX MEM WB -source op3
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
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --lw  R2,R1(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R1,R3,r2 IF ID EX MEM WB -source op3
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
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --lw  R1,R2(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --lw  R2,R1(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --lw  R1,R2(0)	   IF ID   EX  MEM  mem WB  -dest mem FORWARDING
        --0-5 opcode "100011"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="100011"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
        --add r4,r5,r6    IF ID EX  MEM WB opcode2
        --0-5 opcode "00000"
        --6-10 rs1 "00101"
        --11-15 rs2 "00110"
        --16-20 rd "00100"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00110";
         RD_REG_IN_RTYPE_s<="00100";
         RS1_REG_IN_s<="00101";
         RS2_REG_IN_s<="00110";
         wait for clktime;
        --add R2,R1,12 IF ID EX MEM WB -source
        --0-5 opcode "001000"
        --6-10 rs1 "00001"
        --11-15 rd "00010"
        --16-31 immediate "0000000000000011"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00001";
         RS2_REG_IN_s<="00010";
         wait for 2*clktime;
         reset_s<='1';
         wait for clktime;
         reset_s<='0';
        --addi r9, r2, #50    
        --0-5 opcode "100011"
        --6-10 rs1 "00010"
        --11-15 rd "01001"
        --16-31 immediate "0000000000110010"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="01001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="01001";
         wait for clktime;
        --addi r10, r2, #50 
        --0-5 opcode "001000"
        --6-10 rs1 "00010"
        --11-15 rd "01010"
        --16-31 immediate "0000000000110010"  
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="01010";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="01010";
         wait for clktime;
        --add r11, r9, r10   
        --0-5 opcode "00000"
        --6-10 rs1 "01001"
        --11-15 rs2 "01010"
        --16-20 rd "01011"
        --21-25 unset
        --26-31 func
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="01010";
         RD_REG_IN_RTYPE_s<="01011";
         RS1_REG_IN_s<="01001";
         RS2_REG_IN_s<="01010";
         wait for clktime;
        --addi r1, r2, #1
        --0-5 opcode "001000"
        --6-10 rs1 "00010"
        --11-15 rd "00001"
        --16-31 immediate "0000000000000001"
         OPCODE_s<="001000"; 
         RD_REG_IN_ITYPE_s<="00001";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00010";
         RS2_REG_IN_s<="00001";
         wait for clktime;
         OPCODE_s<="000000"; 
         RD_REG_IN_ITYPE_s<="00000";
         RD_REG_IN_RTYPE_s<="00000";
         RS1_REG_IN_s<="00000";
         RS2_REG_IN_s<="00000";
         wait;
    end process;
end TEST;

