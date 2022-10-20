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
        EN1: IN std_logic;
        npc_out_if : OUT std_logic_vector(BIT_RISC - 1 downto 0);
        instruction_fetched : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        ir_out : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        npc_out_id: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        a_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        b_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        imm_reg_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        rd_out_id: OUT  std_logic_vector(4 downto 0);
        alu_out : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        b_reg_out_ex : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        rd_out_ex : OUT  std_logic_vector(4 downto 0);
        alu_out_mem : OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        wb_stage_out: OUT  std_logic_vector(BIT_RISC - 1 downto 0);
        rd_out_wb:   out std_logic_vector(4 downto 0)

        );
end DLX;



architecture structural of DLX is

  --Instruction Ram
 component IRAM 
   generic(RAM_DEPTH : integer := RAM_DEPTH;
           I_SIZE : integer := I_SIZE);
   port( Rst  : in  std_logic;
         enable : in std_logic;
         Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
         Dout : out std_logic_vector(I_SIZE - 1 downto 0));
 end component;
    

  -- Data Ram
  component DRAM
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

  -- Data Ram for WRF
  component DRAMWRF
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
  component datapath
      generic( numbit: integer := BIT_RISC);
      port(    clk:                   in std_logic;
               reset:                 in std_logic;
               ------------------------------------------------------------------
               -- IF input
               EN1:                   in std_logic;
               to_IR:                 in std_logic_vector(numbit - 1 downto 0); -- In from IRAM
               ------------------------------------------------------------------
               -- ID input
               wr31_enable:        in std_logic;
               write_enable:          in std_logic;
               rd1_enable:            in std_logic;
               rd2_enable:            in std_logic;
               call:                  in std_logic;
               ret:                   in std_logic;
               imm_mux_control:        in std_logic;
               EN2:                   in std_logic;
               ------------------------------------------------------------------
               -- EXE input
               mux_one_control:       in std_logic_vector(1 downto 0);
               mux_two_control:       in std_logic_vector(1 downto 0);
               alu_control:           in std_logic_vector(4 downto 0);
               EN3:                    in std_logic;
               -----------------------------------------------------------------
               -- MEM input
               mux_mem_control:       in std_logic;
               EN4:       in std_logic;
               DRAM_to_mux:           in std_logic_vector(numbit - 1 downto 0);
               ------------------------------------------------------------------
               -- WB input 
               mux_wb_control:        in std_logic;
               ------------------------------------------------------------------
               -- IF output
               to_IRAM:               out std_logic_vector(numbit - 1 downto 0); -- To IRAM
               npc_out_if:            out std_logic_vector(numbit - 1 downto 0);
               instruction_fetched:   out std_logic_vector(numbit - 1 downto 0);
               ir_out:                out std_logic_vector(numbit - 1 downto 0);
         
               ------------------------------------------------------------------
               -- ID output
               npc_out_id:            out std_logic_vector(numbit - 1 downto 0);
               a_reg_out:             out std_logic_vector(numbit - 1 downto 0);
               b_reg_out:             out std_logic_vector(numbit - 1 downto 0);
               imm_reg_out:           out std_logic_vector(numbit - 1 downto 0);
               rd_out_id:             out std_logic_vector(4 downto 0);
               nop_add:              out std_logic;  -- It goes in CU
               alu_forwarding_one:   out std_logic;
               alu_forwarding_two:   out std_logic;
               mem_forwarding_one:   out std_logic;
               mem_forwarding_two:   out std_logic;
               ------------------------------------------------------------------
               -- EXE output
               alu_out:               out std_logic_vector(numbit - 1 downto 0);
               b_reg_out_ex:          out std_logic_vector(numbit - 1 downto 0);
               rd_out_ex:             out std_logic_vector(4 downto 0);
               ------------------------------------------------------------------
               --MEM output
               DRAM_addr:             out std_logic_vector(numbit-1 downto 0);
               DRAM_data_in:           out std_logic_vector(numbit - 1 downto 0);
               alu_out_mem:           out std_logic_vector(numbit - 1 downto 0);
               wb_stage_out:          out std_logic_vector(numbit - 1 downto 0);
               rd_out_wb:             out std_logic_vector(4 downto 0);
               FLUSH:                  out std_logic_vector(1 downto 0);
               -------------------------------------------------------------------
               --signal for dram WRF 
               inmemsignal : IN std_logic_vector(numbit - 1 downto 0);
               outmemsignal : OUT std_logic_vector(numbit - 1 downto 0); 
               addressmemsignal: OUT std_logic_vector(numbit-1 downto 0); 
               rd_memsignal:     OUT std_logic;
               wr_memsignal:  OUT std_logic;
               ram_ready: IN std_logic
               );
    end component;

    component CU_HARDWIRED
      port (-- ID Control Signals
             wr31_enable : OUT std_logic;
             write_enable    : OUT std_logic;    -- MUX-A Sel
             rd1_enable    : OUT std_logic;    -- MUX-B Sel
             rd2_enable      : OUT std_logic;
             call      : OUT std_logic;
             ret      : OUT std_logic;
             imm_mux_control : OUT std_logic;
             EN2      : OUT std_logic;
             
            -- EX Control Signal
            mux_one_control      : OUT std_logic_vector(1 downto 0);
            mux_two_control      : OUT std_logic_vector(1 downto 0);
            ALU_OPCODE      : OUT std_logic_vector(4 downto 0);
            EN3      : OUT std_logic;
              
            -- MEM Control Signals
            DRAM_write_enable : OUT std_logic;    -- Data RAM Write Enable
            DRAM_read_enable : OUT std_logic;    -- Data RAM Read Enable
            mux_mem_control : OUT std_logic;
            EN4      : OUT std_logic;
             
            -- WB Control Signals
            mux_wb_control      : OUT std_logic;    -- Write Back MUX Sel
            
            -- INPUTS
            OPCODE : IN  std_logic_vector(OP_CODE_SIZE - 1 downto 0);
            FUNC   : IN  std_logic_vector(FUNC_SIZE - 1 downto 0);
            Clk : IN std_logic;
            Rst : IN std_logic;
            nop_add:            IN std_logic;  -- It goes in CU
            alu_forwarding_one: IN std_logic;
            alu_forwarding_two: IN std_logic;
            mem_forwarding_one: IN std_logic;
            mem_forwarding_two: IN std_logic;
            FLUSH : IN std_logic_vector(1 downto 0));                 
             
end component;



  ----------------------------------------------------------------
  -- Signals Declaration
  ----------------------------------------------------------------

  -- IRAM Bus signals
  signal toiramfrompc : std_logic_vector(BIT_RISC - 1 downto 0);
  signal toirfromiram : std_logic_vector(BIT_RISC - 1 downto 0);

  -- DRAM Bus signals
  signal DRAM_write_enable_signal : std_logic;
  signal DRAM_read_enable_signal : std_logic;
  signal DRAM_addr_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal DRAM_data_in_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal DRAM_to_mux_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal address_error_signal : std_logic;
  -- Control Unit Bus signals
  signal wr31_enable_signal : std_logic;
  signal write_enable_signal : std_logic;
  signal rd1_enable_signal : std_logic;
  signal rd2_enable_signal : std_logic;
  signal call_signal : std_logic;
  signal ret_signal : std_logic;
  signal imm_mux_control_signal : std_logic;
  signal EN2_signal : std_logic;
  signal mux_one_control_signal : std_logic_vector(1 downto 0);
  signal mux_two_control_signal : std_logic_vector(1 downto 0);
  signal alu_control_signal : std_logic_vector(4 downto 0);
  signal EN3_signal : std_logic;
  signal mux_mem_control_signal : std_logic;
  signal EN4_signal : std_logic;
  signal mux_wb_control_signal : std_logic;
  signal FLUSH_signal : std_logic_vector(1 downto 0);
  --WRF signal DRAM
  signal inmemsignal_out : std_logic_vector(BIT_RISC - 1 downto 0);
  signal outmemsignal_in : std_logic_vector(BIT_RISC - 1 downto 0); 
  signal addressmemsignal_in: std_logic_vector(BIT_RISC-1 downto 0); 
  signal rd_memsignal_in:     std_logic;
  signal wr_memsignal_in:  std_logic;
  signal ram_ready_out: std_logic;
  -----------------------------------------------------
  --Forwarding signals from datapath to CU
  signal nopaddsignal : std_logic;
  signal aluforwardingonesignal : std_logic;
  signal aluforwardingtwosignal : std_logic;
  signal memforwardingonesignal : std_logic;
  signal memforwardingtwosignal : std_logic;
  --------------------------------------------------------- 

  signal npc_out_if_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal instruction_fetched_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal ir_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal npc_out_id_signal: std_logic_vector(BIT_RISC - 1 downto 0);
  signal a_reg_out_signal: std_logic_vector(BIT_RISC - 1 downto 0);
  signal b_reg_out_signal: std_logic_vector(BIT_RISC - 1 downto 0);
  signal imm_reg_out_signal: std_logic_vector(BIT_RISC - 1 downto 0);
  signal rd_out_id_signal: std_logic_vector(4 downto 0);
  signal alu_out_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal b_reg_out_ex_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal rd_out_ex_signal : std_logic_vector(4 downto 0);
  signal alu_out_mem_signal : std_logic_vector(BIT_RISC - 1 downto 0);
  signal wb_stage_out_signal : std_logic_vector(BIT_RISC -1 downto 0);
  signal rd_out_wb_signal : std_logic_vector(4 downto 0);
  --testing
begin  -- DLX
      npc_out_if <= npc_out_if_signal;
      instruction_fetched <= instruction_fetched_signal;
      ir_out <= ir_out_signal;
      npc_out_id <= npc_out_id_signal;
      a_reg_out <= a_reg_out_signal;
      b_reg_out <= b_reg_out_signal;
      imm_reg_out <= imm_reg_out_signal;
      rd_out_id <= rd_out_id_signal;
      ------------------------------------------------------------------
      -- EXE output
      alu_out <= alu_out_signal;
      b_reg_out_ex <= b_reg_out_ex_signal;
      rd_out_ex <= rd_out_ex_signal;
      ------------------------------------------------------------------
      --MEM output
      alu_out_mem <= alu_out_mem_signal;
      
      --WB output
      wb_stage_out <= wb_stage_out_signal;
      rd_out_wb <= rd_out_wb_signal;


    IRAM_I : IRAM
    generic map(RAM_DEPTH,I_SIZE)
    port map(Rst => reset,
             enable => EN1,
             Addr => toiramfrompc, 
             Dout => toirfromiram);

    DRAM_I : DRAM
    generic map(BIT_RISC, NumMemBitAddress)
    port map(clk => clk,
             address => DRAM_addr_signal, 
             data_in => DRAM_data_in_signal, 
             write_enable => DRAM_write_enable_signal, 
             read_enable => DRAM_read_enable_signal, 
             reset => reset, 
             data_out => DRAM_to_mux_signal, 
             address_error => address_error_signal);

    DRAM_WRF : DRAMWRF
    generic map(BIT_RISC, NumMemBitAddress)
    port map(clk => clk,
             address => addressmemsignal_in, 
             data_in => outmemsignal_in, 
             write_enable => wr_memsignal_in, 
             read_enable => rd_memsignal_in, 
             reset => reset, 
             data_out => inmemsignal_out, 
             address_error => ram_ready_out);         


    CONTROL_I : CU_HARDWIRED
    port map( wr31_enable => wr31_enable_signal,
              write_enable => write_enable_signal,
              rd1_enable => rd1_enable_signal,    -- MUX-B Sel
              rd2_enable => rd2_enable_signal,
              call => call_signal,
              ret => ret_signal,
              imm_mux_control => imm_mux_control_signal,
              EN2 => EN2_signal,
              -- EX Control Signal
              mux_one_control => mux_one_control_signal,
              mux_two_control => mux_two_control_signal,
              ALU_OPCODE => alu_control_signal,
              EN3 => EN3_signal,
              -- MEM Control Signals
              DRAM_write_enable => DRAM_write_enable_signal,
              DRAM_read_enable => DRAM_read_enable_signal,     
              mux_mem_control => mux_mem_control_signal,
              EN4 => EN4_signal,
              -- WB Control Signals
              mux_wb_control => mux_wb_control_signal,
              -- INPUTS
              OPCODE => ir_out_signal(31 downto 26),
              FUNC => ir_out_signal(10 downto 0),
              Clk => clk,
              Rst => reset,
              nop_add => nopaddsignal,   -- It goes in CU
              alu_forwarding_one => aluforwardingonesignal,
              alu_forwarding_two => aluforwardingtwosignal,
              mem_forwarding_one => memforwardingonesignal,
              mem_forwarding_two => memforwardingtwosignal,
              FLUSH => FLUSH_signal);


    DATAPATH_I : DATAPATH
    generic map(BIT_RISC)
    port map(   clk => clk,
                reset => reset,
                -- IF input
                EN1 => EN1,
                to_IR => toirfromiram,
                -- ID input
                wr31_enable => wr31_enable_signal,
                write_enable => write_enable_signal,
                rd1_enable => rd1_enable_signal,
                rd2_enable => rd2_enable_signal,
                call => call_signal,
                ret => ret_signal,
                imm_mux_control => imm_mux_control_signal,
                EN2 => EN2_signal,
                -- EXE input
                mux_one_control => mux_one_control_signal,
                mux_two_control => mux_two_control_signal,
                alu_control => alu_control_signal,
                EN3 => EN3_signal,
                -- MEM input
                mux_mem_control => mux_mem_control_signal,
                EN4 => EN4_signal,
                DRAM_to_mux => DRAM_to_mux_signal,
                -- WB input 
                mux_wb_control => mux_wb_control_signal,
                -- IF output
                to_IRAM => toiramfrompc,
                npc_out_if => npc_out_if_signal,
                instruction_fetched => instruction_fetched_signal,
                ir_out => ir_out_signal,
                -- ID output
                npc_out_id => npc_out_id_signal,
                a_reg_out => a_reg_out_signal,
                b_reg_out => b_reg_out_signal,
                imm_reg_out => imm_reg_out_signal,
                rd_out_id => rd_out_id_signal,
                nop_add => nopaddsignal,   -- It goes in CU
                alu_forwarding_one => aluforwardingonesignal,
                alu_forwarding_two => aluforwardingtwosignal,
                mem_forwarding_one => memforwardingonesignal,
                mem_forwarding_two => memforwardingtwosignal,
                -- EXE output
                alu_out => alu_out_signal,
                b_reg_out_ex => b_reg_out_ex_signal,
                rd_out_ex => rd_out_ex_signal,
                --MEM output
                DRAM_addr => DRAM_addr_signal,
                DRAM_data_in => DRAM_data_in_signal,
                alu_out_mem => alu_out_mem_signal,
                wb_stage_out => wb_stage_out_signal,
                rd_out_wb => rd_out_wb_signal,
                FLUSH => FLUSH_signal,
               inmemsignal=>inmemsignal_out,
               outmemsignal=>outmemsignal_in, 
               addressmemsignal=>addressmemsignal_in, 
               rd_memsignal=>rd_memsignal_in,
               wr_memsignal=>wr_memsignal_in,
               ram_ready=>ram_ready_out);
                
end structural;

