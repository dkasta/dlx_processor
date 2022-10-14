library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use WORK.globals.all;
use work.myTypes.all;

entity R2_HAZARD_DETECTION is
  port(clk : IN std_logic;
       reset : IN std_logic;
       OPCODE : IN std_logic_vector(OP_CODE_SIZE - 1 downto 0);
       RS2_REG_IN : IN std_logic_vector(4 downto 0);
       RD_REG_IN : IN std_logic_vector(4 downto 0);
       TYPE_OUT : OUT std_logic_vector(4 downto 0);
       reg_one : OUT std_logic_vector(4 downto 0);
       reg_two : OUT std_logic_vector(4 downto 0);
       reg_three : OUT std_logic_vector(4 downto 0);
       RS2_OUT : OUT std_logic_vector(4 downto 0);
       rs2_one : OUT std_logic_vector(4 downto 0);
       rs2_two : OUT std_logic_vector(4 downto 0);
       rs2_three : OUT std_logic_vector(4 downto 0);
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic);
end R2_HAZARD_DETECTION;

architecture BEHAVIORAL of R2_HAZARD_DETECTION is

  signal rd_reg : std_logic_vector(4 downto 0);
  signal rd_reg_one : std_logic_vector(4 downto 0);
  signal rd_reg_two : std_logic_vector(4 downto 0);
  signal rd_reg_three : std_logic_vector(4 downto 0);

  signal rs2_reg : std_logic_vector(4 downto 0);
  signal rs2_reg_one : std_logic_vector(4 downto 0);
  signal rs2_reg_two : std_logic_vector(4 downto 0);
  signal rs2_reg_three : std_logic_vector(4 downto 0);

  begin



    reg_one <= rd_reg_one;
    reg_two <= rd_reg_two;
    reg_three <= rd_reg_three;

    rs2_one <= rs2_reg_one;
    rs2_two <= rs2_reg_two;
    rs2_three <= rs2_reg_three;

    TYPE_OUT <= rd_reg;
    RS2_OUT <= rs2_reg;

    IN_PROCESS : process(OPCODE,RS2_REG_IN,RD_REG_IN)
  	begin
  		if (OPCODE = RTYPE) then
  			rd_reg <= RD_REG_IN;
        rs2_reg <= RS2_REG_IN;
  		else
  			rd_reg <= RD_REG_IN;
        rs2_reg <= (others => '0');
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

    RS2_PIPE : process(clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)
        rs2_reg_one <= (others => '0');
        rs2_reg_two <= (others => '0');
        rs2_reg_three <= (others => '0');
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        rs2_reg_one <= rs2_reg;
        rs2_reg_two <= rs2_reg_one;
        rs2_reg_three <= rs2_reg_two;
      end if;
    end process RS2_PIPE;

    OUT_PROCESS : process (clk, reset)
    begin
      if reset = '1' then                   -- asynchronous reset (active high)
        alu_forwarding_two <= '0';
        mem_forwarding_two <= '0';
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        if(rs2_reg_one /= "00000") then
          if(rd_reg_two = rs2_reg_one) then
            alu_forwarding_two <= '1';
          elsif(rd_reg_two /= rs2_reg_one) then
            alu_forwarding_two <= '0';
          end if;
        elsif(rs2_reg_one = "00000") then
          alu_forwarding_two <= '0';
        end if;
        if(rs2_reg_one /= "00000") then
          if(rd_reg_three = rs2_reg_one) then
            mem_forwarding_two <= '1';
          elsif(rd_reg_three /= rs2_reg_one) then
            mem_forwarding_two <= '0';
          end if;
        elsif(rs2_reg_one = "00000") then
          mem_forwarding_two <= '0';
        end if;
      end if;
    end process OUT_PROCESS;


end BEHAVIORAL;

