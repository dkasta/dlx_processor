library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use WORK.globals.all;

entity se_tb is
end se_tb;

architecture test of se_tb is

signal s_data_in : std_logic_vector(BIT_RISC_no_ext-1 downto 0);
signal s_data_out : std_logic_vector(BIT_RISC-1 downto 0);

component sign_extender is
    port (data_in: in std_logic_vector(BIT_RISC_no_ext-1 downto 0);
          data_out: out std_logic_vector(BIT_RISC-1 downto 0));
end component;

    begin

    dut: sign_extender
        port map (s_data_in, s_data_out);
    proc: process
    begin

        s_data_in <= X"FFAB";
        wait for 5 ns;
        assert s_data_out = X"FFFFFFAB" report "error 1st testvector";

        s_data_in <= X"0016";
        wait for 5 ns;
        assert s_data_out = X"00000016" report "error 2nd testvector";
        wait;

    end process;
end test;