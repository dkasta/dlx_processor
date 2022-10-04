library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity PC is
  generic(NBIT : integer := NumBitMemoryWord);
  port(clk : IN std_logic;
       reset : IN std_logic;
       PC_in : IN std_logic_vector(NBIT-1 downto 0);
       enable : IN std_logic;
       PC_out : OUT std_logic_vector(NBIT-1 downto 0));
end PC;

architecture behavioural of PC is
  signal data_in_signal : std_logic_vector(NBIT - 1 downto 0);

  begin

    PC_process: process (clk)
   begin
      if rising_edge(clk) then
         if Reset = '1' then
            PC_out <= (others => '0');
         elsif Reset = '0' then
            if enable = '0' then 
            PC_out <= (others => '0');
            elsif enable = '1' then
            PC_out <= PC_in;
            end if;
         end if;
      end if;
   end process PC_process;

  end behavioural;

