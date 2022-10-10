library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
use WORK.globals.all;
entity testbench is
end testbench;

architecture Behavioral of testbench is

component DRAM is
  generic(NBIT : integer := NumBitMemoryWord;
          NADDR : integer := 7);
  port(clk : IN std_logic;
       address : IN std_logic_vector(NADDR-1 downto 0);
       data_in : IN std_logic_vector(NBIT-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       data_out : OUT std_logic_vector(NBIT-1 downto 0);
       address_error : OUT std_logic);
end component;
component wrf_fsm is
      generic(  NBIT : integer := NumBitMemoryWord;
                NADDR : integer :=  NumMemBitAddress);
    port( clk:          in std_logic;
          rst:          in std_logic;
          push:         in std_logic;
          done_fill:    in std_logic;
          done_spill:   in std_logic;
          pop:          in std_logic;
          ram_ready:    in std_logic;
          address:      out std_logic_vector(NADDR-1 downto 0);
          register_in:  in std_logic_vector(Nbit-1 downto 0);
          register_out: out std_logic_vector(Nbit-1 downto 0);
          datamem_in:   in std_logic_vector(Nbit-1 downto 0);
          datamem_out:  out std_logic_vector(Nbit-1 downto 0);
          read:         out std_logic;
          write:        out std_logic);
end component;
component wrf is
    generic(
         numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
         numBit_data: integer := NumBitData; -- numero di bit dei registri
         windowsbit: integer := Windows_Bit;
         numreg_inlocout: integer := Numreg_IN_LOC_OUT; --number of register in each block in local out
         numreg_global: integer := Numreg_g; --number of register in the global block
        num_windows: integer := tot_windows); --number of total windows
    port( 
        
        -- to external
        clk: 		IN std_logic;
        rst: 	    IN std_logic;

        --control signals
        rd1: 		    IN std_logic;
        rd2: 		    IN std_logic;
        WR: 		    IN std_logic;
        call:           IN std_logic; -- 1 if there is a call to another subroutine
        ret:            IN std_logic; --1 if there is a retur to another subroutine
        done_fill_cu:   out std_logic;
        done_spill_cu:  out std_logic;
        --address and data

        rw1: 	IN std_logic_vector(numBit_address - 1 downto 0); 
        ADD_RD1: 	IN std_logic_vector(numBit_address - 1 downto 0);
        ADD_RD2: 	IN std_logic_vector(numBit_address - 1 downto 0);
        DATAIN: 	IN std_logic_vector(numBit_data- 1 downto 0);
        out_reg_1: 		OUT std_logic_vector(numBit_data - 1 downto 0);
	    out_reg_2: 		OUT std_logic_vector(numBit_data - 1 downto 0);

        -- for MEMORY
        pop_mem:    OUT std_logic;
        push_mem:   OUT std_logic;
        out_mem:  OUT std_logic_vector(numBit_data - 1 downto 0);
        in_mem:  IN std_logic_vector(numBit_data - 1 downto 0);
        RAM_READY:  IN std_logic

    );
end component;
signal clk_s,rst_s,rd1_s,rd2_s,wr_s: std_logic;
signal call_s,ret_s: std_logic;
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal address_mem_s: std_logic_vector(7-1 downto 0);
signal ADD_RD1_s,add_rd2_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal datain_s: std_logic_vector(NumBitData- 1 downto 0);
signal out_reg_1_s,out_reg_2_S: std_logic_vector(NumBitData - 1 downto 0);
signal out_mem_s,in_mem_s: std_logic_vector(NumBitData - 1 downto 0);
signal datamem_in_s,datamem_out_s: std_logic_vector(NumBitData-1 downto 0);
signal ram_ready_s,done_fill_s,done_spill_s,pop_S,push_s,rd_mem_s,wr_mem_s,err: std_logic;
constant clktime: time:= 20 ns;
begin
componenttotest: wrf port map(ram_ready=>ram_ready_s,call=>call_s,ret=>ret_s,clk=>clk_s,rst=>rst_s,rd1=>rd1_s,rd2=>rd2_s,WR=>wr_s,rw1=>rw1_s,ADD_RD1=>add_rd1_s,ADD_RD2=>add_rd2_s,DATAIN=>datain_s,out_reg_1=>out_reg_1_s,out_reg_2=>out_reg_2_s,out_mem=>out_mem_s,in_mem=>in_mem_s,done_fill_cu=>done_fill_s,done_spill_cu=>done_spill_s,pop_mem=>pop_s,push_mem=>push_s);
componenttotest2: wrf_fsm port map(clk=>clk_s,rst=>rst_s,push=>push_s,pop=>pop_s,done_fill=>done_fill_s,done_spill=>done_spill_s,ram_ready=>ram_ready_s,address=>address_mem_s,read=>rd_mem_s,write=>wr_mem_s,register_in=>out_mem_s,register_out=>in_mem_s,datamem_in=>datamem_in_s,datamem_out=>datamem_out_s);
componenttotest3: DRAM port map(clk=>clk_s,address=>address_mem_s,data_in=>datamem_out_s,write_enable=>wr_mem_s,read_enable=>rd_mem_s,reset=>rst_s,data_out=>datamem_in_s,address_error=>err);
        
process
begin
    clk_s<='0';
    wait for clktime/2;
    clk_s<='1';
    wait for clktime/2;
end process;
process
begin
    ram_ready_s<='1';
    rst_s<='1';
    wait for clktime;
    rst_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='0';
    ret_s<='0';
    wr_s<='1';
    --scrittura win 0
    datain_S<=(others=>'0');
    rw1_s<=(others=>'0');
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 31 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --call for win 1
    wr_s<='0';
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait for clktime;
    wr_s<='1';
    --scrittura win 1
    datain_S<="00000000000000000000000000011000";  --24
    rw1_s<="01000";
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 23 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --call for win 2
    wr_s<='0';
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait for clktime;
        wr_s<='1';
    --scrittura win 2
    datain_S<="00000000000000000000000000101000";  --40
    rw1_s<="01000";
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 23 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --call for win 3 (needs to store in memory in0 and loc0) and swp=1
    wr_s<='0';
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait until done_spill_s='1';
    wait for clktime;
    wr_s<='1';
    --scrittura win 3
    datain_S<="00000000000000000000000000111000";  --56
    rw1_s<="01000";
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 23 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
     --call for win 4 (needs to store in memory in1 and loc1) and swp=2 cwp=0
     wr_s<='0';
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait until done_spill_s='1';
    wait for clktime;
    wr_s<='1';
    --scrittura win 4
    datain_S<="00000000000000000000000000011000";  --24
    rw1_s<="01000";
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 23 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --call for win 5 (needs to store in memory in2 and loc2) and swp=3 cwp=1
    wr_s<='0';
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait until done_spill_s='1';
    wait for clktime;
        wr_s<='1';
    --scrittura win 5
    datain_S<="00000000000000000000000000101000";  --40
    rw1_s<="01000";
    wait for clktime;
    ret_s<='0';
    wait for clktime;
    for i in 1 to 23 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --return to win 4 (restore in2 and loc2) swp=2 cwp=0
    wr_s<='0';
    ret_s<='1';
    wait for clktime;
    ret_s<='0';
    wait until done_fill_s='1';
    wait for clktime;
    call_s<='1';
    wait for clktime;
    call_s<='0';
    wait until done_spill_s='1';
    --read output
    rd1_s<='1';
    rd2_s<='1';
    --leggere primo e ultimo output
    ADD_RD1_s<="11000"; --8
    ADD_RD2_s<="11111"; --0
    wait for clktime;
wait;
end process;
end Behavioral;