library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity R1_HAZARD_DETECTION is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS1_REG_IN : IN std_logic_vector(4 downto 0);
       RD_REG_IN : IN std_logic_vector(4 downto 0);
       TYPE_OUT : OUT std_logic_vector(4 downto 0);
       reg_one : OUT std_logic_vector(4 downto 0);
       reg_two : OUT std_logic_vector(4 downto 0);
       reg_three : OUT std_logic_vector(4 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       RS1_OUT : OUT std_logic_vector(4 downto 0);
       rs1_one : OUT std_logic_vector(4 downto 0);
       rs1_two : OUT std_logic_vector(4 downto 0);
       rs1_three : OUT std_logic_vector(4 downto 0));
end R1_HAZARD_DETECTION;

architecture BEHAVIORAL of R1_HAZARD_DETECTION is

  signal rd_reg : std_logic_vector(4 downto 0);
  signal rd_reg_one : std_logic_vector(4 downto 0);
  signal rd_reg_two : std_logic_vector(4 downto 0);
  signal rd_reg_three : std_logic_vector(4 downto 0);

  signal rs1_reg : std_logic_vector(4 downto 0);
  signal rs1_reg_one : std_logic_vector(4 downto 0);
  signal rs1_reg_two : std_logic_vector(4 downto 0);
  signal rs1_reg_three : std_logic_vector(4 downto 0);

  signal tmp : integer range 0 to 1 := 0;

  begin

    reg_one <= rd_reg_one;
    reg_two <= rd_reg_two;
    reg_three <= rd_reg_three;

    rs1_one <= rs1_reg_one;
    rs1_two <= rs1_reg_two;
    rs1_three <= rs1_reg_three;

    TYPE_OUT <= rd_reg;
    RS1_OUT <= rs1_reg;

    IN_PROCESS : process(OPCODE,RS1_REG_IN,RD_REG_IN)
  	begin
  		if (OPCODE = RTYPE or OPCODE = "001000" or OPCODE = "001010" or OPCODE = "001100" or OPCODE = "001101" or OPCODE = "001110" or OPCODE = "010100" or OPCODE = "010110" or OPCODE = "011000" or OPCODE = "011001" or OPCODE = "011010" or OPCODE = "011011" or OPCODE = "011100" or OPCODE = "011101") then      --any non rtype opcode
  			rd_reg <= RD_REG_IN;
        rs1_reg <= RS1_REG_IN;
  		else
  			rd_reg <= (others => '0');
        rs1_reg <= (others => '0');
  		end if;
  	end process;

    RD_PIPE: process (clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)
        rd_reg_one <= (others => '0');
        rd_reg_two <= (others => '0');
        rd_reg_three <= (others => '0');
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        rd_reg_one <= rd_reg;
        rd_reg_two <= rd_reg_one;
        rd_reg_three <= rd_reg_two;
      end if;
    end process RD_PIPE;

    RS1_PIPE : process(clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)
        rs1_reg_one <= (others => '0');
        rs1_reg_two <= (others => '0');
        rs1_reg_three <= (others => '0');
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        rs1_reg_one <= rs1_reg;
        rs1_reg_two <= rs1_reg_one;
        rs1_reg_three <= rs1_reg_two;
      end if;
    end process RS1_PIPE;

    OUT_PROCESS : process (clk, reset)
    begin
      if reset = '1' then                  -- asynchronous reset (active high)
        alu_forwarding_one <= '0';
        mem_forwarding_one <= '0';
      elsif Clk'event and Clk = '1' then                 -- rising clock edge
        if(rs1_reg_one /= "00000") then
          if(rd_reg_two = rs1_reg_one) then
            alu_forwarding_one <= '1';
          elsif(rd_reg_two /= rs1_reg_one) then
            alu_forwarding_one <= '0';
          end if;
        elsif (rs1_reg_one = "00000") then
          alu_forwarding_one <= '0';
        end if;
        if(rs1_reg_one /= "00000") then
          if(rd_reg_three = rs1_reg_one) then
            mem_forwarding_one <= '1';
          elsif(rd_reg_three /= rs1_reg_one) then
            mem_forwarding_one <= '0';
          end if;
        elsif (rs1_reg_one = "00000") then
          mem_forwarding_one <= '0';
        end if;
      end if;
    end process OUT_PROCESS;



end BEHAVIORAL;


