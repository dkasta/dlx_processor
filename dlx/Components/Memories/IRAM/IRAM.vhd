--test : tested OK, the component works as expected
--for the file test.asm.mem you have to put HEX values
--of 32 bit total for each line for the memory to work

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use WORK.myTypes.all;
use WORK.globals.all;


-- Instruction memory for DLX
-- Memory filled by a process which reads from a file

entity IRAM is
  generic(RAM_DEPTH : integer := RAM_DEPTH;
          I_SIZE : integer := I_SIZE);
  port(Rst  : in  std_logic;
       enable : in std_logic;
       Addr : in  std_logic_vector(I_SIZE - 1 downto 0);
       Dout : out std_logic_vector(I_SIZE - 1 downto 0));
end IRAM;

architecture behavioural of IRAM is

  --signal nop : std_logic_vector(I_SIZE - 1 downto 0) := "01010100000000000000000000000000";
  signal Dout_byte : std_logic_vector(I_SIZE/4 - 1 downto 0);
  type RAMtype is array (0 to RAM_DEPTH - 1) of std_logic_vector(BIT_IRAM - 1 downto 0);
  signal IRAM_mem : RAMtype;
  signal Dout_signal : std_logic_vector(I_SIZE - 1 downto 0):= (others => '0');


begin  -- IRam_Bhe


  --Dout(31 downto 24) <= IRAM_mem(conv_integer(unsigned(Addr)));
  --Dout(23 downto 16) <= IRAM_mem(conv_integer(unsigned(Addr) + 1));
  --Dout(15 downto 8) <= IRAM_mem(conv_integer(unsigned(Addr) + 2));
  --Dout(7 downto 0) <= IRAM_mem(conv_integer(unsigned(Addr) + 3));
  
  -- purpose: This process is in charge of filling the Instruction RAM with the firmware
  -- type   : combinational
  -- inputs : Rst
  -- outputs: IRAM_mem
  FILL_MEM_P: process (Rst)
  file mem_fp: text ;
  variable file_line : line;
  variable index : integer := 0;
  variable tmp_data_u : std_logic_vector(I_SIZE-1 downto 0);
  
begin  -- process FILL_MEM_P
    
    if (Rst = '1') then
      --Dout <= (others => '0');
      file_open(mem_fp,"/home/ms22.21/dlxtest2/test/assembler.bin/LoadStore.asm.mem",READ_MODE);
      while (not endfile(mem_fp)) loop
        readline(mem_fp,file_line);
        hread(file_line,tmp_data_u);
        --IRAM_mem(index) <= conv_integer(unsigned(tmp_data_u));
        fill_IRAM : for i in 0 to 3 loop
        	IRAM_mem(4*index + i) <= tmp_data_u(8*(4-i)-1 downto 8*(4-i)- 8);
        end loop fill_IRAM ;
        index := index + 1;
      end loop;      
    end if;
  end process FILL_MEM_P;

ENABLE_PROCESS : process(Addr, enable)
  begin
    if (enable ='1') then
       Dout_signal <= IRAM_mem(conv_integer(unsigned(Addr))) & IRAM_mem(conv_integer(unsigned(Addr) + 1)) & IRAM_mem(conv_integer(unsigned(Addr) + 2)) & IRAM_mem(conv_integer(unsigned(Addr) + 3));
    else 
       Dout_signal <= (others => '0');
      end if;
  end process ENABLE_PROCESS;

Dout <= Dout_signal;
end behavioural;
