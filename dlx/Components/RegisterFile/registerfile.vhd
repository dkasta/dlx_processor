--test : tested OK, the component works as expected
--Synchronous write, asynchronous read
--as soon as the input is ready the read process gives the value of the REGISTERS
--if there is a conflict between read and write address the write input
--is bypassed to the output and the right register is read during the leading
--edge of a clock cycle

-- register_file is a 2R1W implementation of a register file

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity register_file is
  generic( numBit_data: integer := NumBitData;
	         numBit_address: integer := NumBitAddress;
	         numBit_registers: integer := NumBitRegisterFile);
  port (  clk:              in std_logic;
          rst:              in std_logic;
	        Write_enable:     in std_logic;
	        Write_address:    in std_logic_vector(numBit_address-1 downto 0);
 	        Read_one_address:	in std_logic_vector(numBit_address-1 downto 0);
 	        Read_two_address: in std_logic_vector(numBit_address-1 downto 0);
 	        Data_in:          in std_logic_vector(numBit_data-1 downto 0);
          Data_one_out:	    out std_logic_vector(numBit_data-1 downto 0);
 	        Data_two_out:	    out std_logic_vector(numBit_data-1 downto 0));
end register_file;

architecture behavioral of register_file is

	type Reg_array is array(numBit_registers-1 downto 0) of std_logic_vector(numBit_data-1 downto 0);
	signal Registers : Reg_array := (others => (others => '0')); --initialize my registers to 0

  begin
    write : process(clk, rst, Write_enable, Write_address, Data_in)
      begin
        if(rst = '1') then
          Registers <= (others => (others => '0'));
        elsif(clk'event and clk = '1' and Write_enable = '1') then
          if(not(to_integer(unsigned(Write_address)) = 0)) then        --True if the condition is false
            Registers(to_integer(unsigned(Write_address))) <= Data_in; --So we copy the Data_in inside the RF only if the 
          end if;                                                      --address is different from 0.
        end if;
      end process;

    read : process (Read_one_address, Read_two_address,Write_enable,Data_in,Write_address)
	   begin
    --We use all the possible combinations in the case in which we have the same Write_address and Read_one_address
    --or Read_two_address because we want to avoid to access the register file. 
      if (Write_enable = '1' and Read_one_address = Write_address and Read_two_address = Write_address) then
        if(not(to_integer(unsigned(Write_address)) = 0)) then
          data_one_out <= Data_in;
          data_two_out <= Data_in;
        elsif(to_integer(unsigned(Write_address)) = 0) then
          data_one_out <= Registers(to_integer(unsigned(Read_one_address)));
          data_two_out <= Registers(to_integer(unsigned(Read_two_address)));
        end if;
      
      elsif(Write_enable = '1' and Read_one_address = Write_address) then
         if(not(to_integer(unsigned(Write_address)) = 0)) then
           data_one_out <= Data_in;
           data_two_out <= Registers(to_integer(unsigned(Read_two_address)));
         elsif(to_integer(unsigned(Write_address)) = 0) then
           data_one_out <= Registers(to_integer(unsigned(Read_one_address)));
           data_two_out <= Registers(to_integer(unsigned(Read_two_address)));
         end if;
      
      elsif(Write_enable = '1' and Read_two_address = Write_address) then
        if(not(to_integer(unsigned(Write_address)) = 0)) then
          data_two_out <= Data_in;
          data_one_out <= Registers(to_integer(unsigned(Read_one_address)));
        elsif(to_integer(unsigned(Write_address)) = 0) then
          data_one_out <= Registers(to_integer(unsigned(Read_one_address)));
          data_two_out <= Registers(to_integer(unsigned(Read_two_address)));
        end if;
      
      else
        data_one_out <= Registers(to_integer(unsigned(Read_one_address)));
        data_two_out <= Registers(to_integer(unsigned(Read_two_address)));
      end if;
     
     end process;
   
   end behavioral;