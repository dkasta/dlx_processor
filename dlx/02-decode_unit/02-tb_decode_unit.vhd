library ieee;
use ieee.std_logic_1164.all;
use WORK.globals.all;
use WORK.myTypes.all;

entity tb_decode_unit is
end tb_decode_unit;

architecture behavioural of tb_decode_unit is

  constant NBIT : integer := 32;
  signal WB_STAGE_IN :  std_logic_vector(NBIT-1 downto 0) := "00000000000000000000000000001111";    --F is data in
  signal TB_CLOCK : std_logic := '0';
  signal RESET : std_logic := '1';
  signal WRITE_ENABLE : std_logic := '1';
  signal RD1_ENABLE : std_logic := '1';
  signal RD2_ENABLE : std_logic := '1';
  signal CALL : std_logic := '0';
  signal RET : std_logic := '0';
  signal EN2 : std_logic := '1';
  signal IR_IN  : std_logic_vector(NBIT-1 downto 0) := (others => '0');  --RTYPE ADD RS1 1 RS2 2 RD 3
  signal A_REG_OUT :  std_logic_vector(NBIT-1 downto 0);
  signal B_REG_OUT :  std_logic_vector(NBIT-1 downto 0);
  signal IMM_REG_OUT :  std_logic_vector(NBIT-1 downto 0);
  signal NPC_OUT :  std_logic_vector(NBIT-1 downto 0);
  signal NPC_IN :  std_logic_vector(NBIT-1 downto 0) := "00000000000000000000000000000000";
  signal RD_IN : std_logic_vector(4 downto 0) := "00000";
  signal RD_OUT : std_logic_vector(4 downto 0);
  signal alu_forwarding_one : std_logic;z
  signal mem_forwarding_one : std_logic;
  signal alu_forwarding_two : std_logic;
  signal mem_forwarding_two : std_logic;
  signal NPC_OUT_BPU : std_logic_vector(NBIT - 1 downto 0);
  signal INSTRUCTION_FETCHED : std_logic_vector(NBIT - 1 downto 0);
  signal INMEM : std_logic_vector(NBIT - 1 downto 0);
  signal OUTMEM : std_logic_vector(NBIT - 1 downto 0);
  signal rega_addr: std_logic_vector(4 downto 0);
  signal regb_addr: std_logic_vector(4 downto 0);
  
  component decode_unit 
    generic( numbit: integer := BIT_RISC);
       port( 	clk: 			            in std_logic;
              rst: 			            in std_logic;
              write_enable: 		    in std_logic;
              rd1_enable:           in std_logic;
              rd2_enable:           in std_logic;
              call:                 in std_logic; --call to a subroutine
              ret:                  in std_logic; --return to a subroutine
              EN2:                  in std_logic;
              in_IR:    			      in std_logic_vector(numbit-1 downto 0);
              WB_STAGE_IN: 		      in std_logic_vector(numbit-1 downto 0);
              NPC_IN: 			        in std_logic_vector(numbit-1 downto 0);
              RD_IN: 			          in std_logic_vector(4 downto 0);
              instr_fetched:        in std_logic_vector(BIT_RISC - 1 downto 0);
              inmem:                in std_logic_vector(31 downto 0); --from dram wrf
              outmem:               out std_logic_vector(31 downto 0); --to dram wrf
              --NPC_OUT_BPU: 		      out std_logic_vector(numbit - 1 downto 0);
              RD_OUT: 			        out std_logic_vector(4 downto 0);
              NPC_OUT: 			        out std_logic_vector(numbit-1 downto 0);
              A_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
              B_REG_OUT: 		        out std_logic_vector(numbit-1 downto 0);
              IMM_REG_OUT: 		      out std_logic_vector(numbit-1 downto 0)
              --alu_forwarding_one:   out std_logic;
              --mem_forwarding_one:   out std_logic;
              --alu_forwarding_two:   out std_logic;
              --mem_forwarding_two:   out std_logic
              );
  end component;

  begin
    DUT : decode_unit
    generic map(NBIT)
    port map( clk => TB_CLOCK,
              rst => RESET,
              write_enable => WRITE_ENABLE,
              rd1_enable => RD1_ENABLE,
              rd2_enable => RD2_ENABLE,
              call => CALL,
              ret => RET,
              EN2 => EN2,
              in_IR => IR_IN,
              WB_STAGE_IN => WB_STAGE_IN,
              NPC_IN => NPC_IN,
              RD_IN => RD_IN,
              instr_fetched => IR_IN,
              inmem => INMEM,
              outmem => OUTMEM,
              --NPC_OUT_BPU => ,
              RD_OUT => RD_OUT,
              NPC_OUT => NPC_OUT,
              A_REG_OUT => A_REG_OUT,
              B_REG_OUT => B_REG_OUT,
              IMM_REG_OUT => IMM_REG_OUT
              --alu_forwarding_one => ,
              --mem_forwarding_one => ,
              --alu_forwarding_two => ,
              --mem_forwarding_two => ,
              );

    IR_IN <= "00000000010000110000100000100000" after 3 ns, "00101000001000010000000000001010" after 5 ns, "00100000011000110000000000001010" after 7 ns, "00000000011000010010000000100000" after 9 ns, "00010100001000001111111111110000" after 11 ns, "00001011111111111111111111111100" after 13 ns;
    NPC_IN <= "00000000000000000000000000000100" after 3 ns, "00000000000000000000000000001000" after 5 ns, "00000000000000000000000000001100" after 7 ns, "00000000000000000000000000010000" after 9 ns, "00000000000000000000000000010100" after 11 ns, "00000000000000000000000000011000" after 13 ns;

    WB_STAGE_IN <= (others => '1') after 8 ns;
    RD_IN <= "00001" after 8 ns;

    RESET <= '0' after 3 ns;
    rega_addr <= IR_IN(20 downto 16);
    regb_addr <= IR_IN(15 downto 11);
    PCLOCK : process(TB_CLOCK)
    begin
      TB_CLOCK <= not(TB_CLOCK) after 1 ns;
    end process;

end behavioural;


