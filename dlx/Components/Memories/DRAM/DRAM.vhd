library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use WORK.myTypes.all;
use WORK.globals.all;

entity DRAM is
  generic(NBIT : integer := NumBitMemoryWord;
          NCELL : integer := NumBitMemoryCells);
  port(clk : IN std_logic;
       address : IN std_logic_vector(NBIT-1 downto 0);
       data_in : IN std_logic_vector(NBIT-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       data_out : OUT std_logic_vector(NBIT-1 downto 0);
       address_error : OUT std_logic);
end DRAM;

architecture BEHAVIORAL of DRAM is

  
  type DRAMtype is array (0 to NCELL - 1) of std_logic_vector(NBIT - 1 downto 0);
  signal DRAM_mem : DRAMtype;
  signal Dout_signal : std_logic_vector(NBIT - 1 downto 0):= (others => '0');
  begin


    READWRITE_PROCESS : process(address, write_enable, read_enable, data_in)
    begin
      if (read_enable ='1') then
         data_out <= DRAM_mem(conv_integer(unsigned(address)));
      elsif (write_enable = '1') then 
        DRAM_mem(conv_integer(unsigned(address))) <= data_in;
        end if;
        
    end process READWRITE_PROCESS;
  
    
    
  

  end BEHAVIORAL;
