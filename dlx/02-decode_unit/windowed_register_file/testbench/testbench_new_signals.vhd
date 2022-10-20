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
        RAM_READY:  IN std_logic;
                --jump 
        wr31_enable: in std_logic;
        data_31: in  std_logic_vector(numBit_data-1 downto 0)

    );
end component;
signal clk_s,rst_s,rd1_s,rd2_s,wr_s: std_logic;
signal call_s,ret_s: std_logic;
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal address_mem_s: std_logic_vector(15 downto 0);
signal enable_reg_s: std_logic_vector(8+2*8*4-1 downto 0);
signal ADD_RD1_s,add_rd2_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal datain_s: std_logic_vector(NumBitData- 1 downto 0);
signal out_reg_1_s,out_reg_2_S: std_logic_vector(NumBitData - 1 downto 0);
signal out_mem_s,in_mem_s: std_logic_vector(NumBitData - 1 downto 0);
signal ram_ready_s,done_fill_s,done_spill_s,pop,push: std_logic;
signal data_31_s: std_logic_vector(NumBitData-1 downto 0);
signal wr31_enable_s: std_logic;
constant clktime: time:= 20 ns;
begin
componenttotest: wrf port map(data_31=>data_31_s,wr31_enable=>wr31_enable_s,ram_ready=>ram_ready_s,call=>call_s,ret=>ret_s,clk=>clk_s,rst=>rst_s,rd1=>rd1_s,rd2=>rd2_s,WR=>wr_s,rw1=>rw1_s,ADD_RD1=>add_rd1_s,ADD_RD2=>add_rd2_s,DATAIN=>datain_s,out_reg_1=>out_reg_1_s,out_reg_2=>out_reg_2_s,out_mem=>out_mem_s,in_mem=>in_mem_s,done_fill_cu=>done_fill_s,done_spill_cu=>done_spill_s,pop_mem=>pop,push_mem=>push);

        
process
begin
    clk_s<='0';
    wait for clktime/2;
    clk_s<='1';
    wait for clktime/2;
end process;
process
begin
    rst_s<='1';
    wait for clktime;
    rst_s<='0';
    wr31_enable_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='0';
    ret_s<='0';
    --scrivere win=0;
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<=(others=>'0');
    wait for clktime;
    for i in 1 to 31 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --leggere rd1
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime;
    for i in 1 to 31 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);

        wait for clktime;
    end loop;
    --prova scrittura wr31_enable
    wr31_enable_s<='1';
    wr_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    data_31_s<="00100111110011001100000000001111";
    wait for clktime;
    --lettura
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    add_rd1_s<="11111";
    add_rd2_s<="11111";
    wait for clktime;
    --scrittura da wr31 e wr normale insieme scrittura nello stesso registro allo stesso momento
    wr31_enable_s<='1';
    wr_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    rw1_s<=(others=>'0');
    datain_S<=(others=>'0');
    data_31_s<="00000000000000000000000000000011";
    wait for clktime;
    --leggo
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    add_rd1_s<=(others=>'0');
    add_rd2_s<="11111";
    wait for clktime;
    --scrivo e leggo 
    for i in 1 to 31 loop
    --scrittura
        wr31_enable_s<='1';
        wr_s<='1';
        rd1_s<='0';
        rd2_s<='0';
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        data_31_s<=std_logic_vector(unsigned(data_31_s)+1);
        wait for clktime;
      --lettura
        wr31_enable_s<='0';
        wr_s<='0';
        rd1_s<='1';
        rd2_s<='1';
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        wait for clktime;
    end loop;
wait;