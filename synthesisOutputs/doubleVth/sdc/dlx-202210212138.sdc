###################################################################

# Created by write_sdc on Fri Oct 21 21:38:02 2022

###################################################################
set sdc_version 1.9

set_units -time ns -resistance kOhm -capacitance pF -power mW -voltage V       \
-current mA
create_clock [get_ports Clk]  -period 2  -waveform {0 1}
set_max_delay 2  -from [list [get_ports Clk] [get_ports Rst] [get_ports {IR[31]}] [get_ports   \
{IR[30]}] [get_ports {IR[29]}] [get_ports {IR[28]}] [get_ports {IR[27]}]       \
[get_ports {IR[26]}] [get_ports {IR[25]}] [get_ports {IR[24]}] [get_ports      \
{IR[23]}] [get_ports {IR[22]}] [get_ports {IR[21]}] [get_ports {IR[20]}]       \
[get_ports {IR[19]}] [get_ports {IR[18]}] [get_ports {IR[17]}] [get_ports      \
{IR[16]}] [get_ports {IR[15]}] [get_ports {IR[14]}] [get_ports {IR[13]}]       \
[get_ports {IR[12]}] [get_ports {IR[11]}] [get_ports {IR[10]}] [get_ports      \
{IR[9]}] [get_ports {IR[8]}] [get_ports {IR[7]}] [get_ports {IR[6]}]           \
[get_ports {IR[5]}] [get_ports {IR[4]}] [get_ports {IR[3]}] [get_ports         \
{IR[2]}] [get_ports {IR[1]}] [get_ports {IR[0]}]]  -to [list [get_ports {PC[31]}] [get_ports {PC[30]}] [get_ports {PC[29]}]      \
[get_ports {PC[28]}] [get_ports {PC[27]}] [get_ports {PC[26]}] [get_ports      \
{PC[25]}] [get_ports {PC[24]}] [get_ports {PC[23]}] [get_ports {PC[22]}]       \
[get_ports {PC[21]}] [get_ports {PC[20]}] [get_ports {PC[19]}] [get_ports      \
{PC[18]}] [get_ports {PC[17]}] [get_ports {PC[16]}] [get_ports {PC[15]}]       \
[get_ports {PC[14]}] [get_ports {PC[13]}] [get_ports {PC[12]}] [get_ports      \
{PC[11]}] [get_ports {PC[10]}] [get_ports {PC[9]}] [get_ports {PC[8]}]         \
[get_ports {PC[7]}] [get_ports {PC[6]}] [get_ports {PC[5]}] [get_ports         \
{PC[4]}] [get_ports {PC[3]}] [get_ports {PC[2]}] [get_ports {PC[1]}]           \
[get_ports {PC[0]}]]
set_clock_gating_check -rise -setup 0 [get_cells -hsc @                        \
clk_gate_DTP/cnt/i_reg@main_gate]
set_clock_gating_check -fall -setup 0 [get_cells -hsc @                        \
clk_gate_DTP/cnt/i_reg@main_gate]
set_clock_gating_check -rise -hold 0 [get_cells -hsc @                         \
clk_gate_DTP/cnt/i_reg@main_gate]
set_clock_gating_check -fall -hold 0 [get_cells -hsc @                         \
clk_gate_DTP/cnt/i_reg@main_gate]
set_clock_gating_check -rise -setup 0 [get_cells -hsc @                        \
clk_gate_DTP/PC/d_out_reg@main_gate]
set_clock_gating_check -fall -setup 0 [get_cells -hsc @                        \
clk_gate_DTP/PC/d_out_reg@main_gate]
set_clock_gating_check -rise -hold 0 [get_cells -hsc @                         \
clk_gate_DTP/PC/d_out_reg@main_gate]
set_clock_gating_check -fall -hold 0 [get_cells -hsc @                         \
clk_gate_DTP/PC/d_out_reg@main_gate]
