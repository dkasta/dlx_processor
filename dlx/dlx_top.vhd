-- Top entity which connect datapath, CU, DRAM and IRAM.

library ieee;
use ieee.std_logic_1164.all;
use work.myTypes.all;
use WORK.globals.all;


-- All the OUT signals will be used by the testbench

entity DLX is
  generic(  IR_SIZE      : integer := 32;       -- Instruction Register Size
            PC_SIZE      : integer := 32);       -- Program Counter Size
  port( clk : IN std_logic;
        reset : IN std_logic;
        npc_out_bpu : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        npc_out_if : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        instruction_fetched : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        ir_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        rd_out_id : OUT std_logic_vector(4 downto 0);
        npc_out_id : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        a_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        b_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        imm_reg_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        alu_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        rd_out_ex : OUT std_logic_vector(4 downto 0);
        b_reg_out_ex : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        rd_out_mem : OUT std_logic_vector(4 downto 0);
        memory_stage_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        alu_out_mem : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        rd_out_wb : OUT std_logic_vector(4 downto 0);
        wb_stage_out : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        address_error : OUT std_logic;
        MUXA_CONTROL : OUT std_logic;
        MUXB_CONTROL : OUT std_logic;
        ALU_OPCODE : OUT std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
        DRAM_WE : OUT std_logic;
        DRAM_RE : OUT std_logic;
        WB_MUX_SEL : OUT std_logic;
        JAL_SEL : OUT std_logic;
        RF_WE : OUT std_logic;
        alu_forwarding_one : OUT std_logic;
        mem_forwarding_one : OUT std_logic;
        alu_forwarding_two : OUT std_logic;
        mem_forwarding_two : OUT std_logic;
        alu_forwarding_value : OUT std_logic_vector(IR_SIZE - 1 downto 0);
        mem_forwarding_value : OUT std_logic_vector(IR_SIZE - 1 downto 0));
end DLX;


architecture structural of DLX is

  --Instruction Ram
  component IRAM
  generic(  RAM_DEPTH : integer := RAM_DEPTH;
            I_SIZE : integer := I_SIZE);
  port( Rst  : in  std_logic;
        Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
        Dout : out std_logic_vector(I_SIZE - 1 downto 0));
  end component;

  -- Data Ram
 component DRAM is
  generic(NBIT : integer := NumBitMemoryWord;
          NADDR : integer :=  NumMemBitAddress);
  port(clk : IN std_logic;
       address : IN std_logic_vector(NADDR-1 downto 0);
       data_in : IN std_logic_vector(NBIT-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       data_out : OUT std_logic_vector(NBIT-1 downto 0);
       address_error : OUT std_logic);
end component;

  -- Datapath
  component DATAPATH
  generic(numbit : integer := RISC_BIT);
  port(clk : IN std_logic;
       reset : IN std_logic;
       write_enable : IN std_logic;
       mux_one_control : IN std_logic;
       mux_two_control : IN std_logic;
       alu_control : IN std_logic_vector(3 downto 0);
       to_ir : IN std_logic_vector(numbit - 1 downto 0);
       to_mem_stage_reg : IN std_logic_vector(numbit - 1 downto 0);
       wb_control : IN std_logic;
       jal_sel : IN std_logic;
       to_iram : OUT std_logic_vector(numbit - 1 downto 0);
       npc_out_if : OUT std_logic_vector(numbit - 1 downto 0);
       npc_out_bpu : OUT std_logic_vector(numbit - 1 downto 0);
       instruction_fetched : OUT std_logic_vector(numbit - 1 downto 0);
       ir_out : OUT std_logic_vector(numbit - 1 downto 0);
       rd_out_id : OUT std_logic_vector(4 downto 0);
       npc_out_id : OUT std_logic_vector(numbit - 1 downto 0);
       a_reg_out : OUT std_logic_vector(numbit - 1 downto 0);
       b_reg_out : OUT std_logic_vector(numbit - 1 downto 0);
       imm_reg_out : OUT std_logic_vector(numbit - 1 downto 0);
       alu_out : OUT std_logic_vector(numbit - 1 downto 0);
       rd_out_ex : OUT std_logic_vector(4 downto 0);
       b_reg_out_ex : OUT std_logic_vector(numbit - 1 downto 0);
       rd_out_mem : OUT std_logic_vector(4 downto 0);
       memory_stage_out : OUT std_logic_vector(numbit - 1 downto 0);
       alu_out_mem : OUT std_logic_vector(numbit - 1 downto 0);
       wb_stage_out : OUT std_logic_vector(numbit - 1 downto 0);
       rd_out_wb : OUT std_logic_vector(4 downto 0);
       alu_forwarding_one : OUT std_logic;
       mem_forwarding_one : OUT std_logic;
       alu_forwarding_two : OUT std_logic;
       mem_forwarding_two : OUT std_logic;
       alu_forwarding_value : OUT std_logic_vector(numbit - 1 downto 0);
       mem_forwarding_value : OUT std_logic_vector(numbit - 1 downto 0));
  end component;

  component CU_HARDWIRED
     port (-- ID Control Signals
           -- EX Control Signal
           MUX_ONE_CONTROL    : OUT std_logic;    -- MUX-A Sel
           MUX_TWO_CONTROL    : OUT std_logic;    -- MUX-B Sel
           ALU_OPCODE      : OUT std_logic_vector(ALU_OPC_SIZE - 1 downto 0); -- ALU Operation Code
           -- MEM Control Signals
           DRAM_WE         : OUT std_logic;    -- Data RAM Write Enable
           DRAM_RE         : OUT std_logic;    -- Data RAM Read Enable
           -- WB Control Signals
           WB_MUX_SEL      : OUT std_logic;    -- Write Back MUX Sel
           JAL_SEL         : OUT std_logic;
           RF_WE           : OUT std_logic;    -- Register File Write Enable
           -- INPUTS
           OPCODE : IN  std_logic_vector(OP_CODE_SIZE - 1 downto 0);
           FUNC   : IN  std_logic_vector(FUNC_SIZE - 1 downto 0);
           Clk : IN std_logic;
           Rst : IN std_logic);                  -- Active high
     end component;



  ----------------------------------------------------------------
  -- Signals Declaration
  ----------------------------------------------------------------

  -- Instruction Ram Bus signals
  signal toiramfrompc : std_logic_vector(RISC_BIT - 1 downto 0);
  signal toirfromiram : std_logic_vector(RISC_BIT - 1 downto 0);

  -- Data Ram Bus signals
  signal todramfromaluout : std_logic_vector(RISC_BIT - 1 downto 0);
  signal todramfrombreg : std_logic_vector(RISC_BIT - 1 downto 0);
  signal tolmdfromdram : std_logic_vector(RISC_BIT - 1 downto 0);
  signal address_dram : std_logic_vector(RISC_BIT - 1 downto 0);

  -- Control Unit Bus signals
  signal muxacontrolsignal : std_logic;
  signal muxbcontrolsignal : std_logic;
  signal dramwesignal : std_logic;
  signal dramresignal : std_logic;
  signal wbmuxselsignal : std_logic;
  signal rfwesignal : std_logic;
  signal aluopcodesignal : std_logic_vector(ALU_OPC_SIZE - 1 downto 0);
  signal jalsel : std_logic;

  --IR signal
  signal iroutsignal : std_logic_vector(RISC_BIT - 1 downto 0);



  begin  -- DLX
    ir_out <= iroutsignal;

    alu_out <= todramfromaluout;
    b_reg_out_ex <= todramfrombreg;

    address_dram <= "0000000000000000" & todramfromaluout(15 downto 0);

    MUXA_CONTROL <= muxacontrolsignal;
    MUXB_CONTROL <= muxbcontrolsignal;
    ALU_OPCODE <= aluopcodesignal;
    DRAM_WE <= dramwesignal;
    DRAM_RE <= dramresignal;
    WB_MUX_SEL <= wbmuxselsignal;
    RF_WE <= rfwesignal;
    JAL_SEL <= jalsel;

    IRAM_I : IRAM
    generic map(RAM_DEPTH,I_SIZE)
    port map(Rst => reset,
             Addr => toiramfrompc, 
             Dout => toirfromiram);

    DRAM_I : DRAM
    generic map(RISC_BIT, RISC_BIT)
    port map(clk => clk,
             address => address_dram, 
             data_in => todramfrombreg, 
             write_enable => dramwesignal, 
             read_enable => dramresignal, 
             reset => reset, 
             data_out => tolmdfromdram, 
             address_error => address_error);

    CONTROL_I : CU_HARDWIRED
    port map(MUX_ONE_CONTROL => muxonecontrolsignal,
             MUX_TWO_CONTROL => muxtwocontrolsignal,
             ALU_OPCODE => aluopcodesignal,
             DRAM_WE => dramwesignal,
             DRAM_RE => dramresignal,
             WB_MUX_SEL => wbmuxselsignal,
             RF_WE => rfwesignal,
             JAL_SEL => jalsel,
             OPCODE => iroutsignal(31 downto 26),
             FUNC => iroutsignal(10 downto 0),
             Clk => clk,
             Rst => reset);


    DATAPATH_I : DATAPATH
    generic map(RISC_BIT)
    port map(   clk =>  clk,
                reset => reset,
                write_enable =>  rfwesignal,
                mux_one_control => muxonecontrolsignal,
                mux_two_control => muxtwocontrolsignal,
                alu_control => aluopcodesignal,
                instruction_fetched => instruction_fetched,
                to_ir => toirfromiram,
                to_mem_stage_reg => tolmdfromdram,
                wb_control => wbmuxselsignal,
                jal_sel => jalsel,
                to_iram => toiramfrompc,
                npc_out_if => npc_out_if,
                npc_out_bpu => npc_out_bpu,
                ir_out => iroutsignal,
                rd_out_id => rd_out_id,
                npc_out_id => npc_out_id,
                a_reg_out => a_reg_out,
                b_reg_out => b_reg_out,
                imm_reg_out => imm_reg_out,
                alu_out => todramfromaluout,
                rd_out_ex => rd_out_ex,
                b_reg_out_ex => todramfrombreg,
                rd_out_mem => rd_out_mem,
                memory_stage_out => memory_stage_out,
                alu_out_mem => alu_out_mem,
                wb_stage_out => wb_stage_out,
                rd_out_wb => rd_out_wb,
                alu_forwarding_one => alu_forwarding_one,
                mem_forwarding_one => mem_forwarding_one,
                alu_forwarding_two => alu_forwarding_two,
                mem_forwarding_two => mem_forwarding_two,
                alu_forwarding_value => alu_forwarding_value,
                mem_forwarding_value => mem_forwarding_value);

end structural;


