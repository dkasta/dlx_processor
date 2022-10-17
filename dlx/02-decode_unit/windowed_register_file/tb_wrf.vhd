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
        RAM_READY:  IN std_logic

    );
end component;
signal clk_s: std_logic := '0';
signal rst_s: std_logic := '1';
signal rd1_s: std_logic := '0';
signal rd2_s: std_logic := '0';
signal wr_s: std_logic := '1';
signal call_s:std_logic := '0';
signal ret_s: std_logic := '0';
signal rw1_s: std_logic_vector(NumBitAddress-1 downto 0);
signal address_mem_s: std_logic_vector(15 downto 0);
signal add_rd1_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal add_rd2_s:std_logic_vector(NumBitAddress - 1 downto 0);
signal datain_s: std_logic_vector(NumBitData- 1 downto 0);
signal out_reg_1_s: std_logic_vector(NumBitData - 1 downto 0);
signal out_reg_2_s: std_logic_vector(NumBitData - 1 downto 0);
signal out_mem_s,in_mem_s: std_logic_vector(NumBitData - 1 downto 0);
signal ram_ready_s,done_fill_s,done_spill_s,pop,push: std_logic;
constant clktime: time:= 20 ns;
begin
componenttotest: wrf 
port map( ram_ready => ram_ready_s,
          call=>call_s,
          ret=>ret_s,
          clk=>clk_s,
          rst=>rst_s,
          rd1=>rd1_s,
          rd2=>rd2_s,
          WR=>wr_s,
          rw1=>rw1_s,
          ADD_RD1=>add_rd1_s,
          ADD_RD2=>add_rd2_s,
          DATAIN=>datain_s,
          out_reg_1=>out_reg_1_s,
          out_reg_2=>out_reg_2_s,
          out_mem=>out_mem_s,
          in_mem=>in_mem_s,
          done_fill_cu=>done_fill_s,
          done_spill_cu=>done_spill_s,
          pop_mem=>pop,
          push_mem=>push);

        
  PCLOCK : process(clk_s)
	begin
		clk_s <= not(clk_s) after 1 ns;
	end process;

    datain_s <= "00000000000000000000000000000001" after 3 ns, "00000000000000000000000000000010" after 5 ns, "00000000000000000000000000000011" after 7 ns;
    rw1_s <= "00101" after 3 ns, "00110" after 5 ns, "00111" after 7 ns;
    wr_s <= '0' after 8 ns;
    rd1_s <= '1' after 8 ns;
    rd2_s <= '1' after 8 ns;
    add_rd1_s <= "00101" after 10 ns;
    add_rd2_s <= "00110" after 10 ns;

	rst_s <= '0' after 3 ns;

end Behavioral;
