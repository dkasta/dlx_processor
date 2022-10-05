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
component decoder is 
    generic(numBit_address: integer := NumBitAddress; -- bit numbers of address 5
            windowsbit: integer:= 2;                --log2(num_windows)
            numreg_global: integer:=8; --number of register in the global block
            numreg_inlocout: integer:=8; --number of register in each block in local out
	        num_windows: integer:= 4); --number of total windows
    port(clk:   in std_logic;
         rst:   in std_logic;
         wr:    in std_logic;
         rw1:   in std_logic_vector(numBit_address-1 downto 0); --selection signal for the decoder
         cwp:   in std_logic_vector(windowsbit-1 downto 0); 
         swp:   in std_logic_vector(windowsbit-1 downto 0);
         address_mem: in std_logic_vector(2*numreg_inlocout-1 downto 0); 
         enable_reg: out std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0) --enable for all the registers

         );
end component;
signal clk_s,rst_s,wr_s: std_logic;
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal cwp_s,swp_s: std_logic_vector(1 downto 0);
signal address_mem_s: std_logic_vector(15 downto 0);
signal enable_reg_s: std_logic_vector(8+2*8*4-1 downto 0);
constant clktime: time:= 20 ns;
begin

comptotest: decoder port map(clk=>clk_s,rst=>rst_s,rw1=>rw1_s,cwp=>cwp_s,address_mem=>address_mem_s,enable_reg=>enable_reg_s,wr=>wr_s,swp=>swp_s);
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
    swp_s<=(others => '0');
    address_mem_s<=(others=>'0');
    --test cwp
    wr_s<='1';
    --prima finestra nessun registro preso
    rw1_s<=(others=>'0');
    cwp_s<=(others=>'0');
    wait for clktime;
    --prima finestra global register
    rw1_s<="00010"; --2
    cwp_s<=(others=>'0');
    wait for clktime;
    --prima finestra input register
    rw1_s<="01000"; --8
    cwp_s<=(others=>'0');
    wait for clktime;
    --prima finestra local register
    rw1_s<="10001"; --17
    cwp_s<=(others=>'0');
    wait for clktime;
    --prima finestra output register
    rw1_s<="11010"; --26
    cwp_s<=(others=>'0');
    wait for clktime;
    --seconda finestra global register
    rw1_s<="00100";--4 
    cwp_s<="01";
    wait for clktime;
    --seconda finestra input register
    rw1_s<="01010";--10
    cwp_s<="01";
    wait for clktime;
    --seconda finestra local register
    rw1_s<="10100";--20
    cwp_s<="01";
    wait for clktime;
    --seconda finestra output register
    rw1_s<="11110";--30
    cwp_s<="01";
    wait for clktime;
    --terza finestra global register
    rw1_s<="00110";--6
    cwp_s<="10";
    wait for clktime;
    --terza finestra input register
    rw1_s<="01101";--13
    cwp_s<="10";
    wait for clktime;
    --terza finestra local register
    rw1_s<="10110";--22
    cwp_s<="10";
    wait for clktime;
    --terza finestra output register
    rw1_s<="11100";--28
    cwp_s<="10";
    wait for clktime;
    --quarta finestra global register
    rw1_s<="00111";--7
    cwp_s<="11";
    wait for clktime;
    --quarta finestra input register
    rw1_s<="01111";--15
    cwp_s<="11";
    wait for clktime;
    --quarta finestra local register
    rw1_s<="10111";--23
    cwp_s<="11";
    wait for clktime;
    --quarta finestra output register
    rw1_s<="11111";--31
    cwp_s<="11";
    wait for clktime;
wait;
end process;
end Behavioral;