
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity HAZARD_DETECTION is
  port(   clk:                in std_logic;
          reset:              in std_logic;
          OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RD_REG_IN_ITYPE:    in std_logic_vector(NumBitAddress-1 downto 0);                --If I-type instruction the destination register is in the Rd position
          RD_REG_IN_RTYPE:    in std_logic_vector(NumBitAddress-1 downto 0);                --If R-type instruction the destination register is in the RD position
          RS1_REG_IN:         in std_logic_vector(NumBitAddress-1 downto 0);
          RS2_REG_IN:         in std_logic_vector(NumBitAddress-1 downto 0);
          alu_forwarding_one: out std_logic;
          mem_forwarding_one: out std_logic;
          alu_forwarding_two: out std_logic;
          mem_forwarding_two: out std_logic;
          nop_add:            out std_logic;
          RD_OUT:             out std_logic_vector(NumBitAddress-1 downto 0));
end HAZARD_DETECTION;

architecture structural of HAZARD_DETECTION is

component HAZARD_DETECTION1 is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS1_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       RD_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       nop_add:             OUT std_logic);
end component;

component HAZARD_DETECTION2 is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS2_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       RD_REG_IN : IN std_logic_vector(NumBitAddress-1 downto 0);
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic;
       nop_add:             OUT std_logic);
end component;

--scegliere il corretto registro destinazione
component RDSELECT
  port(   OPCODE:          in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RD_REG_IN_RTYPE: in std_logic_vector(NumBitAddress-1 downto 0);
          RD_REG_IN_ITYPE: in std_logic_vector(NumBitAddress-1 downto 0);
          RD_OUT:          out std_logic_vector(NumBitAddress-1 downto 0));
end component;

signal rdselectoutsignal : std_logic_vector(NumBitAddress-1 downto 0);
signal nop_op1: std_logic;
signal nop_op2: std_logic;
begin

  RD_OUT <= rdselectoutsignal;
  nop_add<=nop_op1 and nop_op2;
  RDSEL : RDSELECT
  port map(OPCODE,RD_REG_IN_RTYPE,RD_REG_IN_ITYPE,rdselectoutsignal);

  R1_HAZARD : HAZARD_DETECTION1
  port map( clk=>clk,
            reset=>reset,
            opcode=>OPCODE,
            RS1_REG_IN=>RS1_REG_IN,
            RD_REG_IN=>rdselectoutsignal,
            alu_forwarding_one=>alu_forwarding_one,
            mem_forwarding_one=>mem_forwarding_one,
            nop_add=>nop_op1);

  R2_HAZARD : HAZARD_DETECTION2
  port map( clk=>clk,
            reset=>reset,
            opcode=>OPCODE,
            RS2_REG_IN=>RS2_REG_IN,
            RD_REG_IN=>rdselectoutsignal,
            alu_forwarding_two=>alu_forwarding_two,
            mem_forwarding_two=>mem_forwarding_two,
            nop_add=>nop_op2);

end structural;

