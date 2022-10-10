library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.globals.all;


entity wrf_fsm is
      generic(  NBIT : integer := NumBitMemoryWord;
                NADDR : integer :=  NumMemBitAddress);
    port( clk:          in std_logic;
          rst:          in std_logic;
          push:         in std_logic;
          done_fill:    in std_logic;
          done_spill:   in std_logic;
          pop:          in std_logic;
          ram_ready:    in std_logic;
          address:      out std_logic_vector(NADDR-1 downto 0);
          register_in:  in std_logic_vector(Nbit-1 downto 0);
          register_out: out std_logic_vector(Nbit-1 downto 0);
          datamem_in:   in std_logic_vector(Nbit-1 downto 0);
          datamem_out:  out std_logic_vector(Nbit-1 downto 0);
          read:         out std_logic;
          write:        out std_logic);
end wrf_fsm;

architecture Behavioral of wrf_fsm is
type statetype is (INIT,FREEZE,SPILL,FILL);
signal curr_state,next_state: statetype;
signal curr_addr,next_addr: std_logic_vector(NADDR-1 downto 0);
signal curr_data,next_data: std_logic_vector(NBIT-1 downto 0);
begin
    address<=curr_addr;
    process(curr_state,curr_addr,push,pop,ram_ready,done_fill,done_spill)
    begin
        case curr_state is
            when init   =>  next_addr<=(others =>'0'); next_state<=freeze;
            when freeze =>  
                            if(push='1' and ram_ready='1')then
                               next_state<=spill;                                
                               next_addr<=std_logic_vector(unsigned(curr_addr)+1);
                            elsif(pop='1' and ram_ready='1') then
                                next_addr<=std_logic_vector(unsigned(curr_addr)-1);
                                next_state<=fill;
                            end if;
            when spill  =>  if(ram_ready='1') then
                                next_addr<=std_logic_vector(unsigned(curr_addr)+1);
                                next_state<=spill;
                            end if;
                            if(pop='1') then
                                next_addr<=curr_addr;
                                next_state<=fill;
                            elsif(done_spill='1')then
                                next_addr<=curr_addr;
                                next_state<=freeze;
                            end if;
                            
            when fill   =>  if(ram_ready='1') then
                                next_addr<=std_logic_vector(unsigned(curr_addr)-1);
                                next_State<=fill;
                            end if;
                            if(push='1') then
                                next_state<=spill;
                                next_addr<=curr_addr;
                             elsif(done_fill='1') then
                                next_addr<=curr_addr;
                                next_state<=freeze;
                            end if;
        end case;
    end process;
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst='1') then
                curr_state<=INIT;
                curr_addr<=(OTHERS=>'0');
                curr_data<=(others=>'X');
            else
                curr_state<=next_state;
                curr_addr<=next_addr;
                curr_data<=next_data;
            end if;
        end if;
    end process;
    address<=curr_addr;
    read <= pop and not DONE_FILL;
    write <= push and not DONE_SPILL;

    next_data <= curr_data when (RAM_READY = '0') else datamem_in;

    register_out <= DATAmem_in when (RAM_READY = '1') else curr_data;
    DATAmem_out <= register_in;

end Behavioral;