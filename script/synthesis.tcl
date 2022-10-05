source "./.synopsys_dc.setup"

#mkdir -p work
#vlib work

# Suppress some warning messages
suppress_message MWLIBP-319
suppress_message MWLIBP-324
suppress_message TFCHK-012
suppress_message TFCHK-014
suppress_message TFCHK-049
suppress_message TFCHK-072
suppress_message TFCHK-084
suppress_message PSYN-651
suppress_message PSYN-650
suppress_message UID-401
suppress_message LINK-14
suppress_message TIM-134
suppress_message VER-130


####################################################################
#Name				:analyze_directory
#Description 		:design_compiler tcl script to analyze recursively in reverse alphanumerical order every file in every subdirectory of the main directory specified as input in order to be set for synthesis.
#Arguments			:main_directory(optional): name of the main directory containing files to be analyzed (default is current directory ./).
#					:file_extension(optional): extension of the files to be analyzed (vhdl or verilog) (default is vhdl).
#Outputs			:none		
####################################################################
proc analyze_directory {{main_directory "./"} {file_extension "vhdl"}} {
	# recur on every subdirectory of $dir, in reverse alphanumerical order
	foreach sub_directory [lsort -increasing [glob -nocomplain -type d $main_directory/*]] {
		analyze_directory $sub_directory
		#puts $sub_directory
	}

	# analyze every file with the specified format in $dir
	foreach src_file [lsort -increasing [glob -nocomplain $main_directory/*.vhd]] {
		analyze -library WORK -format $file_extension $src_file
		#puts $src_file
	}
}


####################################################################
#Name				:synthesize_dual_vth
#Description 		:design_compiler tcl script to perform a duoble voltage threshold synthesis.
#Arguments			:top_entity (optional): name of the top level entity to be synthesized (default is dlx).
#					:time_constraint (optional): maximum delay in nanoseconds between inputs and outputs (default is 2 ns).
#					:low_Vt_Library (optional): low threshold voltage library (default is CORE65LPLVT).
#					:high_Vt_Library (optional): high threshold voltage library (default is CORE65LPHVT).
#Outputs			:postsynthesis netlist
#					:sdc file
#					:reports for timing, power, area, threshold voltage group and clock gating		
####################################################################
proc synthesize_dual_vth {{top_entity "dlx"} {time_constraint 2} {low_Vth_Library "CORE65LPLVT"} {high_Vth_Library "CORE65LPHVT"}} {
	
	# Create folders
	set folder_reports_dualVth "./reports_dual_Vth/${top_entity}"
	if {![file exists $folder_reports_dualVth]} {
		file mkdir $folder_reports_dualVth
	}

	set folder_sdc_dualVth "./sdc_dual_Vth/${top_entity}"
	if {![file exists $folder_sdc_dualVth]} {
		file mkdir $folder_sdc_dualVth
	}

	set folder_post_syn_dualVth "./postsyn_dual_Vth/${top_entity}"
	if {![file exists $folder_post_syn_dualVth]} {
		file mkdir $folder_post_syn_dualVth
	}

	elaborate $top_entity

	# setup dual-Vth
	set_attribute [find library $low_Vth_Library] default_threshold_voltage_group LVT -type string
	set_attribute [find library $high_Vth_Library] default_threshold_voltage_group HVT -type string

	# setup timing constraints
	create_clock -period $time_constraint CLK
	set_max_delay -from [all_inputs] -to [all_outputs] $time_constraint

	# Clock gating options (to be verified)
	set clockGatingMinBitWidth 1
	set clockGatingMaxFanout 1024
	set_clock_gating_style -minimum_bitwidth $clockGatingMinBitWidth -max_fanout $clockGatingMaxFanout -positive_edge_logic {integrated} -control_point before
	
	# Compile without any optimizations
 	# compile

	# Define a load to the outputs (to be verified)
	# set_load 0.05 [all_outputs]

	# Optimize and compile the design
	ungroup -all -flatten
	compile_ultra -gate_clock -retime

	# Set the name of the ouptut files
	set name "$top_entity-[clock format [clock seconds] -format %Y%m%d%H%M]"
	
	# write outputs
	write -format verilog -hierarchy -output "${folder_post_syn_dualVth}/$name-postsyn.v"
	write_sdc "${folder_sdc_dualVth}/$name.sdc"
	report_timing > "${folder_reports_dualVth}/$name-timing.rpt"
	report_power > "${folder_reports_dualVth}/$name-power.rpt"
	report_area > "${folder_reports_dualVth}/$name-area.rpt"
	report_threshold_voltage_group > "${folder_reports_dualVth}/$name-threshold.rpt"
	report_clock_gating > "${folder_reports_dualVth}/$name-gating.rpt"
}


####################################################################
#Name				:synthesize
#Description 		:design_compiler tcl script to perform a standard synthesis.
#Arguments			:top_entity (optional): name of the top level entity to be synthesized (default is dlx).
#					:time_constraint (optional): maximum delay in nanoseconds between inputs and outputs (default is 2 ns).
#					:wire_load_model (optional): name of the wire load model (default is 5K_hvratio_1_4).
#Outputs			:postsynthesis netlist
#					:sdc file
#					:reports for timing, power, area and clock gating		
####################################################################
proc synthesize {{top_entity "dlx"} {time_constraint 2} {wire_load_model "5K_hvratio_1_4"}} {

	# Create folders
	set folder_reports "./reports/${top_entity}"
	if {![file exists $folder_reports]} {
		file mkdir $folder_reports
	}

	set folder_sdc "./sdc/${top_entity}"
	if {![file exists $folder_sdc]} {
		file mkdir $folder_sdc
	}

	set folder_post_syn "./postsyn/${top_entity}"
	if {![file exists $folder_post_syn]} {
		file mkdir $folder_post_syn
	}

	elaborate $top_entity

	# Setup timing constraints
	create_clock -period $time_constraint CLK
	set_max_delay -from [all_inputs] -to [all_outputs] $time_constraint

	# Setup working conditions
	set_wire_load_model -name $wire_load_model

	# Clock gating options (to be verified)
	set clockGatingMinBitWidth 1
	set clockGatingMaxFanout 1024
	set_clock_gating_style -minimum_bitwidth $clockGatingMinBitWidth -max_fanout $clockGatingMaxFanout -positive_edge_logic {integrated} -control_point before

	# Define a load to the outputs (to be verified)
	# set_load 0.05 [all_outputs]

	# Compile without any optimizations
 	# compile

	# Optimize the design
	ungroup -all -flatten
	compile_ultra -timing_high_effort_script -gate_clock -retime

	# Set the name of the ouptut files
	set name "$top_entity-[clock format [clock seconds] -format %Y%m%d%H%M]"
	
	# write outputs
	write -format verilog -hierarchy -output "${folder_post_syn}/$name-postsyn.v"
	write_sdc "${folder_sdc}/$name.sdc"
	report_timing > "${folder_reports}/$name-timing.rpt"
	report_power > "${folder_reports}/$name-power.rpt"
	report_area > "${folder_reports}/$name-area.rpt"
	report_clock_gating > "${folder_reports}/$name-gating.rpt"
}
