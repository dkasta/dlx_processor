library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
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
component DRAMWRF is
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
signal clk_s,rst_s,rd1_s,rd2_s,wr_s: std_logic;
signal call_s,ret_s: std_logic;
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal cwp_s,swp_s: std_logic_vector(1 downto 0); --da eliminare
signal P1_s: std_logic_vector(numBitdata-1 downto 0);
signal address_mem_s: std_logic_vector(31 downto 0);
signal enable_reg_s: std_logic_vector(8+2*8*4-1 downto 0);
signal ADD_RD1_s,add_rd2_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal datain_s: std_logic_vector(NumBitData- 1 downto 0);
signal out_reg_1_s,out_reg_2_S: std_logic_vector(NumBitData - 1 downto 0);
signal out_mem_s,in_mem_s: std_logic_vector(NumBitData - 1 downto 0);
signal ram_ready_s,done_fill_s,done_spill_s,pop,push: std_logic;
signal wr31_enable_s: std_logic;
signal data_31_s: std_logic_vector(NumBitData - 1 downto 0);
signal datamem_in,datamem_out:std_logic_vector(NumBitData - 1 downto 0);
signal rdm,wrm:std_logic;
constant clktime: time:= 20 ns;
begin
componenttotest: wrf port map(data_31=>data_31_s,wr31_enable=>wr31_enable_s,ram_ready=>ram_ready_s,call=>call_s,ret=>ret_s,clk=>clk_s,rst=>rst_s,rd1=>rd1_s,rd2=>rd2_s,WR=>wr_s,rw1=>rw1_s,ADD_RD1=>add_rd1_s,ADD_RD2=>add_rd2_s,DATAIN=>datain_s,out_reg_1=>out_reg_1_s,out_reg_2=>out_reg_2_s,out_mem=>out_mem_s,in_mem=>in_mem_s,done_fill_cu=>done_fill_s,done_spill_cu=>done_spill_s,pop_mem=>pop,push_mem=>push);
componentfsm: wrf_fsm  port map( clk=>clk_s, rst=>rst_s,push=>push,done_fill=>done_fill_s,done_spill=>done_spill_s,pop=>pop,ram_ready=>ram_ready_s,address=>address_mem_s,register_in=>out_mem_s,register_out=>in_mem_s,datamem_in=>datamem_out,datamem_out=>datamem_in,read=>rdm,write=>wrm);
componentdata: DRAMWRF port map(clk=>clk_s,address=>address_mem_s,data_in=>datamem_in,write_enable=>wrm,read_enable=>rdm ,reset=>rst_s,data_out=>datamem_out,address_error=>ram_ready_s);
        
process
begin
    clk_s<='0';
    wait for clktime/2;
    clk_s<='1';
    wait for clktime/2;
end process;
process
begin
    rst_s<='1'; --reset
    wait for clktime;
    wr31_enable_s<='0';
    rst_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='0';
    ret_s<='0';
    --scrivere win=0;
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<=(others=>'0');
    wait for clktime;
    for i in 1 to 30 loop
        rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
        datain_s<=std_logic_vector(unsigned(datain_s)+1);
        wait for clktime;
    end loop;
    --call subroutine --> win=1
    wr31_enable_s<='0';
    wr_s<='0';
    call_s<='1';
    data_31_s<=(others=>'1');
    wait for clktime;
    --read input and global
    call_s<='0';
    data_31_s<=(others=>'0');
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 15 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --scrittura della win=1
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<="00000000000000000000000000001111"; --15
    wait for clktime;
    for i in 1 to 29 loop
        if(i/=15)then
            rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
            datain_s<=std_logic_vector(unsigned(datain_s)+1);
            wait for clktime;
        else
            rw1_s<=std_logic_vector(unsigned(rw1_s)+2);
            datain_s<=std_logic_vector(unsigned(datain_s)+2);
            wait for clktime;
        end if;
    end loop;
    --leggere rd1
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 31 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --call for win=2
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    data_31_s<=(others=>'1');
    call_s<='1';
    wait for clktime;
    --read input and global
    call_s<='0';
    data_31_s<=(others=>'0');
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 15 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --scrittura della win=2
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<="00000000000000000000000000010001"; --17
    wait for clktime;
    for i in 1 to 29 loop
        if(i/=15)then
            rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
            datain_s<=std_logic_vector(unsigned(datain_s)+1);
            wait for clktime;
        else
            rw1_s<=std_logic_vector(unsigned(rw1_s)+2);
            datain_s<=std_logic_vector(unsigned(datain_s)+2);
            wait for clktime;
        end if;
    end loop;
    --leggere win2
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 31 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --call for win=3 and save in memory!
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='1';
    data_31_s<=(others=>'1');
    wait for clktime;
    --read input and global
    call_s<='0';
    data_31_s<=(others=>'0');
    wait for 31*clktime;
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 15 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --scrittura della win=3
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<="00000000000000000000000000010000"; --16
    wait for clktime;
    for i in 1 to 29 loop
        if(i/=15)then
            rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
            datain_s<=std_logic_vector(unsigned(datain_s)+1);
            wait for clktime;
        else
            rw1_s<=std_logic_vector(unsigned(rw1_s)+2);
            datain_s<=std_logic_vector(unsigned(datain_s)+2);
            wait for clktime;
        end if;
    end loop;
    --leggere win3
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 31 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --call for win=4 and save in memory!
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='1';
    data_31_s<=(others=>'1');
    wait for clktime;
    --read input and global
    call_s<='0';
    data_31_s<=(others=>'0');
    wait for 31*clktime;
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 15 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --scrittura della win=4
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<="00000000000000000000000000010000"; --16
    wait for clktime;
    for i in 1 to 29 loop
        if(i/=15)then
            rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
            datain_s<=std_logic_vector(unsigned(datain_s)+1);
            wait for clktime;
        else
            rw1_s<=std_logic_vector(unsigned(rw1_s)+2);
            datain_s<=std_logic_vector(unsigned(datain_s)+2);
            wait for clktime;
        end if;
    end loop;
    --leggere win4
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 31 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --call for win=5 and save in memory!
    wr31_enable_s<='0';
    wr_s<='0';
    rd1_s<='0';
    rd2_s<='0';
    call_s<='1';
    data_31_s<=(others=>'1');
    wait for clktime;
    --read input and global
    call_s<='0';
    data_31_s<=(others=>'0');
    wait for 31*clktime;
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 15 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --scrittura della win=5
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='1';
    rw1_s<=(others=>'0');
    datain_S<="00000000000000000000000000010000"; --16
    wait for clktime;
    for i in 1 to 29 loop
        if(i/=15)then
            rw1_s<=std_logic_vector(unsigned(rw1_s)+1);
            datain_s<=std_logic_vector(unsigned(datain_s)+1);
            wait for clktime;
        else
            rw1_s<=std_logic_vector(unsigned(rw1_s)+2);
            datain_s<=std_logic_vector(unsigned(datain_s)+2);
            wait for clktime;
        end if;
    end loop;
    --leggere win5
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --ret time! return to windows 4
    ret_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='0';
    wr31_enable_s<='0';
    wait for clktime;
    --read register in win 4 to see if something change (only output and global needs to change)
    ret_s<='0';
    wait for 31*clktime;
    rd1_s<='1';
    rd2_s<='1';
    --leggere 4 windows
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
    --ret time! return to windows 3
    ret_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='0';
    wr31_enable_s<='0';
    wait for clktime;
    --read register in win 3 to see if something change (only output and global needs to change)
    ret_s<='0';
    wait for 31*clktime;
    rd1_s<='1';
    rd2_s<='1';
    --leggere 3 windows
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
        --ret time! return to windows 2
    ret_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='0';
    wr31_enable_s<='0';
    wait for clktime;
    --read register in win 2 to see if something change (only output and global needs to change)
    ret_s<='0';
    wait for 31*clktime;
    rd1_s<='1';
    rd2_s<='1';
    --leggere 2 windows
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
        --ret time! return to windows 1
    ret_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='0';
    wr31_enable_s<='0';
    wait for clktime;
    --read register in win 1 to see if something change (only output and global needs to change)
    ret_s<='0';
    wait for 31*clktime;
    rd1_s<='1';
    rd2_s<='1';
    --leggere 1 windows
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
        --ret time! return to windows 0
    ret_s<='1';
    rd1_s<='0';
    rd2_s<='0';
    wr_s<='0';
    wr31_enable_s<='0';
    wait for clktime;
    --read register in win 0 to see if something change (only output and global needs to change)
    ret_s<='0';
    wait for 31*clktime;
    rd1_s<='1';
    rd2_s<='1';
    --leggere 0 windows
    call_s<='0';
    wr_s<='0';
    rd1_s<='1';
    rd2_s<='1';
    wr31_enable_s<='0';
    add_rd1_s<=(others=>'0');
    add_rd2_s<=(others=>'0');
    wait for clktime; 
    for i in 1 to 30 loop
        add_rd1_s<=std_logic_vector(unsigned(add_rd1_s)+1);
        add_rd2_s<=std_logic_vector(unsigned(add_rd2_s)+1);
        wait for clktime;
    end loop;
wait;
end process;
end Behavioral;