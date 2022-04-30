--tested OK
--depending on the OPCODE (instruction IN) jump or branches (it has regs as inputs)
--if no jump or branch instruction is input then npc_in is bypassed as npc_out

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.globals.all;
use work.myTypes.all;

entity BRANCHDECISIONUNIT is
  port(OPCODE : IN std_logic_vector(5 downto 0);
       JOFFSET_IN : IN std_logic_vector(25 downto 0);
       BOFFSET_IN : IN std_logic_vector(15 downto 0);
       NPC_IN : IN std_logic_vector(31 downto 0);
       REG1_IN : IN std_logic_vector(31 downto 0);
       REG2_IN : IN std_logic_vector(31 downto 0);
       NPC_OUT : OUT std_logic_vector(31 downto 0));
end BRANCHDECISIONUNIT;

architecture MIXED of BRANCHDECISIONUNIT is

  component BOFFSET
  port(BOFFSET_IN : IN std_logic_vector(15 downto 0);
       BOFFSET_OUT : OUT std_logic_vector(31 downto 0));
  end component;

  component JOFFSET
  port(JOFFSET_IN : IN std_logic_vector(25 downto 0);
       JOFFSET_OUT : OUT std_logic_vector(31 downto 0));
  end component;

  signal boffsetadjusted : std_logic_vector(31 downto 0);
  signal joffsetadjusted : std_logic_vector(31 downto 0);

  signal npcoutfinal : std_logic_vector(31 downto 0);

  begin

    BOFF : BOFFSET
    port map(BOFFSET_IN, boffsetadjusted);

    JOFF : JOFFSET
    port map(JOFFSET_IN, joffsetadjusted);


    OUT_PROCESS : process(OPCODE, NPC_IN, joffsetadjusted, boffsetadjusted, REG1_IN, REG2_IN)
    begin
  		if (OPCODE = "000010") then         --JTYPE_J
        npcoutfinal <= std_logic_vector(unsigned(NPC_IN) + unsigned(joffsetadjusted));
      elsif (OPCODE = "000100") then      --BTYPE_BEQZ
  			if(REG1_IN = "00000000000000000000000000000000") then
          npcoutfinal <= std_logic_vector(unsigned(NPC_IN) + unsigned(boffsetadjusted));
        else
          npcoutfinal <= NPC_IN;
        end if;
      elsif (OPCODE = "000101") then      --BTYPE_BNEZ
        if(REG1_IN /= "00000000000000000000000000000000") then
          npcoutfinal <= std_logic_vector(unsigned(NPC_IN) + unsigned(boffsetadjusted));
        else
          npcoutfinal <= NPC_IN;
        end if;
      elsif (OPCODE = "000011") then      --JAL (the link part is done through the pipeline and CU)
        npcoutfinal <= std_logic_vector(unsigned(joffsetadjusted) + unsigned(NPC_IN));
      elsif (OPCODE = "010010") then      --JR
        npcoutfinal <=  REG1_IN;
      elsif (OPCODE = "010011") then      --JALR (the link part is done through the pipeline and CU)
        npcoutfinal <= REG1_IN;
      else
        npcoutfinal <= NPC_IN;
  		end if;
  	end process;

    NPC_OUT <= npcoutfinal(31 downto 0);


end MIXED;

