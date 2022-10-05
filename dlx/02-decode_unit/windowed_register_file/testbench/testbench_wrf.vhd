----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2022 11:43:14
-- Design Name: 
-- Module Name: testbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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
         windowsbit: integer:=2;
         numreg_inlocout: integer:=8; --number of register in each block in local out
         numreg_global: integer:=8; --number of register in the global block
        num_windows: integer:= 4); --number of total windows
    port( 
        
        -- to external
        clk: 		IN std_logic;
        rst: 	    IN std_logic;
        rd1: 		IN std_logic;
        rd2: 		IN std_logic;
        WR: 		IN std_logic;
        rw1: 	IN std_logic_vector(numBit_address - 1 downto 0); 
        ADD_RD1: 	IN std_logic_vector(numBit_address - 1 downto 0);
        ADD_RD2: 	IN std_logic_vector(numBit_address - 1 downto 0);
        DATAIN: 	IN std_logic_vector(numBit_data- 1 downto 0);
        --RAM_READY:  IN std_logic;
        out_reg_1: 		OUT std_logic_vector(numBit_data - 1 downto 0);
	    out_reg_2: 		OUT std_logic_vector(numBit_data - 1 downto 0);

        -- Other I/O
        --CALL:       IN std_logic;
        --RET:        IN std_logic;
        --FILL:       OUT std_logic; -- POP towards memory
        --SPILL:      OUT std_logic; -- PUSH towards memory

        -- TO MEMORY
        out_mem:  OUT std_logic_vector(numBit_data - 1 downto 0);
        in_mem:  IN std_logic_vector(numBit_data - 1 downto 0)

    );
end component;
signal clk_s,rst_s,en_s,rd1_s,rd2_s,wr_s: std_logic;
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal cwp_s,swp_s: std_logic_vector(1 downto 0);
signal address_mem_s: std_logic_vector(15 downto 0);
signal enable_reg_s: std_logic_vector(8+2*8*4-1 downto 0);
signal ADD_RD1_s,add_rd2_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal datain_s: std_logic_vector(NumBitData- 1 downto 0);
signal out_reg_1_s,out_reg_2_S: std_logic_vector(NumBitData - 1 downto 0);
signal out_mem_s,in_mem_s: std_logic_vector(NumBitData - 1 downto 0);
constant clktime: time:= 20 ns;
begin
componenttotest: wrf port map(clk=>clk_s,rst=>rst_s,rd1=>rd1_s,rd2=>rd2_s,WR=>wr_s,rw1=>rw1_s,ADD_RD1=>add_rd1_s,ADD_RD2=>add_rd2_s,DATAIN=>datain_s,out_reg_1=>out_reg_1_s,out_reg_2=>out_reg_2_s,out_mem=>out_mem_s,in_mem=>in_mem_s);
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
    rd1_s<='0';
    rd2_s<='0';
    --scrivere
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
    rd2_s<='0';
    --leggere primo global register
    ADD_RD1_s<=(others=>'0');
    wait for clktime;
    --leggere ultimo global register
    ADD_RD1_s<="00111";
    wait for clktime;
    --leggere primo input
    ADD_RD1_s<="01000";
    wait for clktime;
    --leggere ultimo input
    ADD_RD1_s<="01111";
    wait for clktime;
    --leggere primo local
    ADD_RD1_s<="10000";
    wait for clktime;
    --leggere ultimo local
    ADD_RD1_s<="10111";
    wait for clktime;
    --leggere primo output
    ADD_RD1_s<="11000";
    wait for clktime;
    --leggere ultimo output
    ADD_RD1_s<="11111";
    wait for clktime;
    --leggere rd2
    rd2_s<='1';
    rd1_s<='0';
    --leggere primo global register
    ADD_RD2_s<=(others=>'0');
    wait for clktime;
    --leggere ultimo global register
    ADD_RD2_s<="00111";
    wait for clktime;
    --leggere primo input
    ADD_RD2_s<="01000";
    wait for clktime;
    --leggere ultimo input
    ADD_RD2_s<="01111";
    wait for clktime;
    --leggere primo local
    ADD_RD2_s<="10000";
    wait for clktime;
    --leggere ultimo local
    ADD_RD2_s<="10111";
    wait for clktime;
    --leggere primo output
    ADD_RD2_s<="11000";
    wait for clktime;
    --leggere ultimo output
    ADD_RD2_s<="11111";
    
wait;
end process;
end Behavioral;