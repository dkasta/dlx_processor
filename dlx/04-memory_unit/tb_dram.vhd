library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
use WORK.globals.all;

entity TB_DRAM is
end TB_DRAM;

architecture TEST of TB_DRAM is
  signal s_address : std_logic_vector(NBIT-1 downto 0) := (others => '0');
  signal s_data_in : std_logic_vector(NBIT-1 downto 0);
  signal s_write_enable : std_logic := '1';
  signal s_read_enable : std_logic := '1';
  signal s_data_out : std_logic_vector(NBIT-1 downto 0);
  signal s_reset : std_logic := '1';
  signal s_clk : std_logic := '0';

  component DRAM
  port(clk : IN std_logic;
       address : IN std_logic_vector(NBIT-1 downto 0);
       data_in : IN std_logic_vector(NBIT-1 downto 0);
       write_enable : IN std_logic;
       read_enable : IN std_logic;
       reset : IN std_logic;
       data_out : OUT std_logic_vector(NBIT-1 downto 0);
       address_error : OUT std_logic);
  end component;

  begin
    DUT: DRAM
    port map(s_clk, s_address, s_data_in, s_write_enable, s_read_enable, s_reset, s_data_out);

    s_reset <= '0' after 2 ns;
    s_data_in <= "11111111111111111111111111111111", "00000000000000000000000000000000" after 22 ns, "11111111111111111111111111111111" after 25 ns;
    s_address <= (others => '0'), "00000000000000001111111111111111" after 20 ns;
    s_write_enable <= '1', '0' after 13 ns, '1' after 20 ns, '0' after 30 ns;
    s_read_enable <= '0' after 4 ns, '1' after 13 ns,'0' after 20 ns, '1' after 25 ns;

    process_clock : process(s_clk)
        begin
            s_clk <= not(s_clk) after 1 ns;
    end process;

  end TEST;
