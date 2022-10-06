library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;


entity SIGN_EXTENTION is
    port (data_in : in std_logic_vector(BIT_RISC_no_ext-1 downto 0);
          data_out : out std_logic_vector(BIT_RISC-1 downto 0));
end SIGN_EXTENTION;

architecture BEHAVIOURAL of SIGN_EXTENTION is
begin

    proc: process(data_in)
        begin
            data_out <= std_logic_vector(resize(signed(data_in), BIT_RISC));
    end process;

end BEHAVIOURAL;
