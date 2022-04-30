--tested OK
--samples on the falling edge the value of IR and outputs on the leading edge
--checks if there are data hazards (RAW) for I-type and R-type operations
--and forward the right value to the ALU inputs

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity HAZARD_DETECTION is
  port(   clk:                in std_logic;
          reset:              in std_logic;
          OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RD_REG_IN_ITYPE:    in std_logic_vector(4 downto 0);                --If I-type instruction the destination register is in the Rs2 position
          RD_REG_IN_RTYPE:    in std_logic_vector(4 downto 0);                --If R-type instruction the destination register is in the RD position
          RS1_REG_IN:         in std_logic_vector(4 downto 0);
          RS2_REG_IN:         in std_logic_vector(4 downto 0);
          alu_forwarding_one: out std_logic;
          mem_forwarding_one: out std_logic;
          alu_forwarding_two: out std_logic;
          mem_forwarding_two: out std_logic;
          RD_OUT:             out std_logic_vector(4 downto 0));
end HAZARD_DETECTION;

architecture structural of HAZARD_DETECTION is

component R1_HAZARD_DETECTION
port(     clk:                in std_logic;
          reset:              in std_logic;
          OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RS1_REG_IN:         in std_logic_vector(4 downto 0);
          RD_REG_IN:          in std_logic_vector(4 downto 0);
          TYPE_OUT:           out std_logic_vector(4 downto 0);
          reg_one:            out std_logic_vector(4 downto 0);
          reg_two:            out std_logic_vector(4 downto 0);
          reg_three:          out std_logic_vector(4 downto 0);
          alu_forwarding_one: out std_logic;
          mem_forwarding_one: out std_logic;
          RS1_OUT:            out std_logic_vector(4 downto 0);
          rs1_one:            out std_logic_vector(4 downto 0);
          rs1_two:            out std_logic_vector(4 downto 0);
          rs1_three:          out std_logic_vector(4 downto 0));
end component;

component R2_HAZARD_DETECTION
port(     clk:                in std_logic;
          reset:              in std_logic;
          OPCODE:             in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RS2_REG_IN:         in std_logic_vector(4 downto 0);
          RD_REG_IN:          in std_logic_vector(4 downto 0);
          TYPE_OUT:           out std_logic_vector(4 downto 0);
          reg_one:            out std_logic_vector(4 downto 0);
          reg_two:            out std_logic_vector(4 downto 0);
          reg_three:          out std_logic_vector(4 downto 0);
          RS2_OUT:            out std_logic_vector(4 downto 0);
          rs2_one:            out std_logic_vector(4 downto 0);
          rs2_two:            out std_logic_vector(4 downto 0);
          rs2_three:          out std_logic_vector(4 downto 0);
          alu_forwarding_two: out std_logic;
          mem_forwarding_two: out std_logic);
end component;

component RDSELECT
  port(   OPCODE:          in std_logic_vector(OP_CODE_SIZE - 1 downto 0);
          RD_REG_IN_RTYPE: in std_logic_vector(4 downto 0);
          RD_REG_IN_ITYPE: in std_logic_vector(4 downto 0);
          RD_OUT:          out std_logic_vector(4 downto 0));
end component;

signal rdselectoutsignal : std_logic_vector(4 downto 0);

begin

  RD_OUT <= rdselectoutsignal;

  RDSEL : RDSELECT
  port map(OPCODE,RD_REG_IN_RTYPE,RD_REG_IN_ITYPE,rdselectoutsignal);

  R1_HAZARD : R1_HAZARD_DETECTION
  port map(clk,reset,OPCODE,RS1_REG_IN,rdselectoutsignal,open,open,open,open,alu_forwarding_one,mem_forwarding_one,open,open,open,open);

  R2_HAZARD : R2_HAZARD_DETECTION
  port map(clk,reset,OPCODE,RS2_REG_IN,rdselectoutsignal,open,open,open,open,open,open,open,open,alu_forwarding_two,mem_forwarding_two);

end structural;

