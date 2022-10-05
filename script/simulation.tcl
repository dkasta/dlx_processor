set sim_root "./"
set asm_root "../../assembly"

##??
#first write these commands in shell??
#mkdir -p work
#vlib work
###??

########################################################################################################################################
#Name			:compile_directory
#Description 		:questaSim tcl script to analyze recursively in reverse alphanumerical order every file in every subdirectory of the main directory specified as input in order to be set for later simulation.
#Arguments		:main_directory(optional)			- name of the main directory containing files to be analyzed (default).
#				:file_extension(optional)   		- extension of the files to be analyzed (vhdl or verilog) (default is vhdl).
#Outputs		:none		
########################################################################################################################################
proc compile_directory {{main_directory "./"} {file_extension "vhd"}} {
	# recur on every subdirectory
	foreach subdir [lsort -decreasing [glob -nocomplain -type d $main_directory/*]] {
		compile_directory $subdir
	}

	# compile every file
	foreach src_file [glob -nocomplain $main_directory/*.$file_extension] {
		vcom -pedanticerrors -check_synthesis -bindAtCompile $src_file
	}
}

########################################################################################################################################
#Name			:simulate_alu
#Description 		:questaSim tcl script to to test the dlx with custom .asm files. It converts the incoming assembly test file into the corrispondent .mem file.
#Arguments		:asm_file (optional): name of the .asm file to be converted in .mem file by the dlxasm (default is example.asm).
#				:run_time (optional): duration time of the simulation (default is 100 ns).
#Outputs		:none		
########################################################################################################################################
#NOTES
#copy the asm file in the same folder as this script
#call this procedeure as for ex simulate_alu testAllInstr.asm
#Possibly permission error by the conv2memory, give execution permission to it
proc simulate_alu {{asm_file "test.asm"} {run_time 100}} {

	global sim_root asm_root

	# Assume that the .asm fil to be converted is already in the current directory
#	if {[file exists $asm_file] == 0} {
#		puts "The asm_file $asm_file is not found. Exiting."
#		return
#	}

	# assemble asm code
	#exec perl $asm_root/assembler/dlxasm.pl $asm_file
	#exec $asm_root/assembler/conv2memory $asm_file.exe > $sim_root/test.asm.mem

	# cleanup temporary files
	#exec rm $asm_file.exe $asm_file.exe.hdr

	# simulate assembled code
#	vsim tb_dlx
#	vsim tb_alu

	####dlx.do contains custom waveform options. Not done yet
#	if {[file exists $asm_root/dlx.do]} {
#		do $asm_root/dlx.do
#	} else {
#		add wave *
#	}

##	run $run_time ns
}



