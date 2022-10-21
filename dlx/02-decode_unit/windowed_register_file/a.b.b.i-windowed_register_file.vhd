library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.globals.all;

entity wrf is
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
        RAM_READY:  IN std_logic;
        --jump 
        wr31_enable: in std_logic;
        data_31: in  std_logic_vector(numBit_data-1 downto 0)
    );
end wrf;
architecture structural of wrf is
    --whan call=1 save the data_31 in the reg 31 then make call_internal=1
    --when ret=1 mettere in out_reg_1 il registro 31 then ret_internal=1
    --when wr_31=1 write in reg31 data_31
    component decoder is 
        generic(numBit_address: integer := NumBitAddress; -- bit numbers of address 5
                windowsbit: integer:= Windows_Bit;                --log2(num_windows)
                numreg_global: integer:=Numreg_g; --number of register in the global block
                numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
                num_windows: integer:= tot_windows); --number of total windows
        port(clk:   in std_logic;
            rst:   in std_logic;
            wr:    in std_logic;
            push:  in std_logic;
            rw1:   in std_logic_vector(numBit_address-1 downto 0); --selection signal for the decoder
            cwp:   in std_logic_vector(windowsbit-1 downto 0); 
            swp:   in std_logic_vector(windowsbit-1 downto 0);
            address_mem: in std_logic_vector(2*numreg_inlocout-1 downto 0); 
            wr_internal: in std_logic; --wr for call and jumps
            call: in std_logic;
            enable: out std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0) --enable for all the registers

            );
    end component;

    component physical_register_file is
    generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
                numreg_global: integer:=Numreg_g; --number of register in the global block
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
                num_windows: integer:= tot_windows); --number of total windows
                
    port (  clk:              in std_logic;
            rst:              in std_logic;
            en:               in std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0); --enable for all the registers
            Data_in1:         in std_logic_vector(numBit_data-1 downto 0); --data from the cu
            Data_in2:         in std_logic_vector(numBit_data-1 downto 0); --data from the memory
            Data_out_reg:	    out std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); 
            Data_out_global:  out std_logic_vector(numBit_data*numreg_global-1 downto 0);
            data31:            in std_logic_vector(numBit_data-1 downto 0); --data for the 31 register
            wr_internal:      in std_logic;
            swp_en:           in std_logic_vector(windowsbit-1 downto 0)); --enable for the mux (choose if the data come from the memory or the cu)
    
    end component;

    component cwp_swp is
    generic(windowsbit: integer:=Windows_Bit); -- bit of input of each port of the mux
        port(curr: in std_logic_vector(windowsbit-1 downto 0);
            nex: out std_logic_vector(windowsbit-1 downto 0);
            sel: in std_logic_vector(1 downto 0));
    end component;

    component sel_block is
    generic( numBit_data: integer := NumBitData; -- numero di bit dei registri
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
            windowsbit: integer:=Windows_Bit; 
            num_windows: integer:= tot_windows); --number of total windows
        port(
            tot_reg:    in std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); -- all 0 first register (first windows)
            curr_win:   in std_logic_vector(windowsbit-1 downto 0);
            out_reg:    out std_logic_vector(numBit_data*3*numreg_inlocout-1 downto 0) -- 
        );
    end component;

    component mux_out is
    generic(
            numBit_address: integer := NumBitAddress; -- bit numbers of address 5 
            numBit_data: integer := NumBitData; -- numero di bit dei registri
            numreg_inlocout: integer:=Numreg_IN_LOC_OUT; --number of register in each block in local out
            numreg_global: integer:=Numreg_g --number of register in the global block
            ); 
        port(
            en:         in std_logic;
            add_read:   in std_logic_vector(numBit_address-1 downto 0);
            out_reg:    out std_logic_vector(numBit_data-1 downto 0); 
            ret:    in std_logic;
            in_reg:     in std_logic_vector(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto 0) 
        );
    end component;
    component register_generic_wrf is
    generic (NBIT : integer := Bit_Register);
        port(   D:     in std_logic_vector(NBIT-1 downto 0);
                CK:    in std_logic;
                    EN:    in std_logic;
                RESET: in std_logic;
                Q:     out std_logic_vector(NBIT-1 downto 0));
    end component;
    component fill_enable_generator is
        generic(
            numreg_inlocout: integer := Numreg_IN_LOC_OUT
        );
        port(
            clk:        in std_logic;
            rst:        in std_logic;
            en:         in std_logic;
            ready:  in std_logic;
            done:       out std_logic;
            occupied:    out std_logic;
            address_mem: out std_logic_vector(2*numreg_inlocout-1 downto 0)
        );
        end component;
    component address_counter is
        generic(
            N:          integer := numBit_address;
            num_inlocout:   integer := Numreg_in_loc_out
        );
        port(
            clk:        in std_logic;
            rst:        in std_logic;
            en:         in std_logic;
            ready:      in std_logic;
            done:       out std_logic;
            occupied:    out std_logic;
            addr:       out std_logic_vector(N-1 downto 0)
        );
    end component;
    component call_ret_block is
    port(   
            clk: in std_logic;
            rst: in std_logic;
            call_from_wrf: out std_logic;
            ret_from_wrf: out std_logic;
            call:           IN std_logic; -- 1 if there is a call to another subroutine
            ret:            IN std_logic --1 if there is a retur to another subroutine
        );
    end component;
    signal curr_cwp,next_cwp,curr_swp,next_swp,pop_and_swp: std_logic_vector(windowsbit-1 downto 0); 
    signal address_mem_s: std_logic_vector(2*numreg_inlocout-1 downto 0); 
    signal spill_regs: std_logic_vector(numBit_data*3*numreg_inlocout-1 downto 0); 
    signal enable_regs: std_logic_vector(numreg_global+2*numreg_inlocout*num_windows-1 downto 0);
    signal tot_regs: std_logic_vector(numBit_data*2*numreg_inlocout*num_windows-1 downto 0); 
    signal input_mux_rd: std_logic_vector(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto 0);
    signal sel_cwp,sel_swp:std_logic_vector(1 downto 0);
    signal done_spill,done_fill: std_logic;
    signal pop,push,pop_not_finish,start_pop,push_not_finish,start_push: std_logic;
    signal address_spill: std_logic_vector(numBit_address-1 downto 0);
    --signals for call and ret
    signal call_internal,ret_internal: std_logic;
    signal wr_internal,rd1en_internal,en31: std_logic;
    begin
    dec: decoder generic map(numBit_address => NumBitAddress,windowsbit=> windowsbit,numreg_global=>numreg_global,numreg_inlocout=>numreg_inlocout,num_windows=> num_windows)
            port map(clk=>clk,rst=>rst,wr=>wr,wr_internal=>wr_internal,rw1=>rw1,cwp=>curr_cwp,swp=>pop_and_swp,address_mem=>address_mem_s,enable=>enable_regs,push=>push,call=>call);
    phy: physical_register_file generic map ( numBit_data=> NumBitData,numreg_global=>numreg_global,numreg_inlocout=>numreg_inlocout,num_windows=> num_windows)	         
            port map(clk=>clk,rst=>rst,en=>enable_regs,Data_in1=>DATAIN,Data_in2=>in_mem,Data_out_reg=>tot_regs,Data_out_global=>input_mux_rd(numBit_data*numreg_global-1 downto 0),swp_en=>pop_and_swp,data31=>data_31,wr_internal=>wr_internal);
    sel: sel_block generic map ( numBit_data=> NumBitData,numreg_inlocout=>numreg_inlocout,windowsbit=>windowsbit,num_windows=> num_windows)
            port map(tot_reg=>tot_regs,curr_win=>curr_cwp,out_reg=>input_mux_rd(numBit_data*numreg_global+numBit_data*3*numreg_inlocout-1 downto numBit_data*numreg_global ));
    muxout1: mux_out generic map(numBit_address=> NumBitAddress,numBit_data=> NumBitData,numreg_inlocout=>numreg_inlocout,numreg_global=>numreg_global) 
            port map(en=>rd1en_internal,add_read=>ADD_RD1,out_reg=>out_reg_1,in_reg=>input_mux_rd,ret=>ret);
    muxout2: mux_out generic map(numBit_address=> NumBitAddress,numBit_data=> NumBitData,numreg_inlocout=>numreg_inlocout,numreg_global=>numreg_global ) 
            port map(en=>rd2,add_read=>ADD_RD2,out_reg=>out_reg_2,in_reg=>input_mux_rd,ret=>'0');
    next_cwp_m: cwp_swp generic map(windowsbit=>windowsbit) port map (curr=>curr_cwp,nex=>next_cwp,sel=>sel_cwp);
    cwp: register_generic_wrf generic map (NBIT => windowsbit) port map(D=>next_cwp,CK=>clk,EN=>'1',RESET=>rst,Q=>curr_cwp);
    next_swp_m: cwp_swp generic map(windowsbit=>windowsbit) port map (curr=>curr_swp,nex=>next_swp,sel=>sel_swp);
    swp: register_generic_wrf generic map (NBIT => windowsbit) port map(D=>next_swp,CK=>clk,EN=>'1',RESET=>rst,Q=>curr_swp);
    call_ret:call_ret_block port map(clk=>clk,rst=>rst,call_from_wrf=>call_internal,ret_from_wrf=>ret_internal,call=>call,ret=>ret);
    fill_generator: fill_enable_generator generic map(numreg_inlocout=>numreg_inlocout)
        port map(clk=>clk,rst=>rst,en=>pop,ready=>RAM_READY,done=>done_fill,occupied=>pop_not_finish,address_mem=>address_mem_s);
    sel_spill: sel_block generic map ( numBit_data=> NumBitData,numreg_inlocout=>numreg_inlocout,windowsbit=>windowsbit,num_windows=> num_windows)
            port map(tot_reg=>tot_regs,curr_win=>curr_swp,out_reg=>spill_regs);
    mux_spill: mux_out generic map(numBit_address=> NumBitAddress,numBit_data=> NumBitData,numreg_inlocout=>numreg_inlocout,numreg_global=>0 ) 
            port map(en=>push,add_read=>address_spill,out_reg=>out_mem,in_reg=>spill_regs,ret=>'0');
    spill: address_counter generic map(N=>numBit_address, num_inlocout=>numreg_inlocout)
            port map(clk=>clk,rst=>rst,en=>push,ready=>ram_ready,done=>done_spill,occupied=>push_not_finish,addr=>address_spill);

    --00 or 11 in the cwp/swp needs to be stable, 01 when there is a call curr+1, 10 when there is a return curr-1
    change_cwp: process(call_internal,ret_internal,done_fill,done_spill)
                begin
                    if((call_internal='1' and (to_integer(unsigned(curr_cwp))+2)mod num_windows /= to_integer(unsigned(curr_swp))) or done_spill='1') then 
                    -- se viene chiamata una nuova subroutine e c'è spazio nel registro oppure lo spill è stato fatto allora cwp può incrementare
                    --si aspetta che venga fatto lo spill per aggiornare cwp
                        sel_cwp<="01";
                    elsif((ret_internal='1' and curr_cwp/=curr_swp)) then 
                    -- se c'è un return nelle subroutine e i registri sono già caricati nel registro o sono già stati ristabiliti allora diminuisci il cwp
                        sel_cwp<="10"; 
                    else 
                        sel_cwp<="00";          
                    end if;
                end process; 
    --00 o 11 swp stable, 01 swp+1 (when a spill is performed), 10 swp-1 (when a fill is performed)
    change_swp: process(done_fill,done_spill)
                begin
                    if(done_fill='1') then
                        sel_swp<="10";
                    elsif(done_spill='1')then
                        sel_swp<="01";
                    else
                        sel_swp<="00";
                    end if;
                end process;    
    --"enable" for the pop in the physical register      
    pop_and_swp<=curr_swp and (windowsbit-1 downto 0 => pop);

    --mantain the enable for the enable_generator
    process(ret_internal)
    begin
        if(unsigned(curr_swp) > 0) then
            start_pop<=ret_internal;
        else
            start_pop<='0';
        end if;
    end process;
    pop<=pop_not_finish or start_pop;
    --start the push
    process(call_internal)
    begin
        if(abs(TO_INTEGER(unsigned(curr_cwp))- TO_INTEGER(unsigned(curr_swp)))<2) then
            start_push <='0';
        else
            start_push<=call_internal;
        end if;
    end process;
    push<=push_not_finish or start_push;
    --to wrf_cu and mem
    done_fill_cu<=done_fill;
    done_spill_cu<=done_spill;
    pop_mem<=pop;
    push_mem<=push;
    rd1en_internal<=rd1 or ret;
    wr_internal<=call or wr31_enable;
end structural;