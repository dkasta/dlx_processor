library ieee;
use ieee.std_logic_1164.all;

package globals is
--constants used for the testbenches of every component--
	constant Bit_Mux21 : integer := 32;
	-------------register----------------------
	constant Bit_Register : integer := 32;
	-------------latch-------------------------
	constant Bit_Latch : integer := 32;
	-------------ripple carry adder------------
	constant NumBitRCA : integer := 32;
	-------------comparator--------------------
	constant NumBitComparator : integer := 32;
	-------------accumulator-------------------
	constant NumBitAccumulator : integer := 32;
	-------------ALU---------------------------
	constant NumBitALU : integer := 32;
	-------------sign extention----------------
	constant NumBitSignExtentionRegister : integer := 32;
	-------------num bit of RISC core----------
	constant BIT_RISC : integer := 32;
	-------------memory------------------------
	constant NumBitMemoryWord : integer := 32;
	constant NumMemBitAddress : integer := 10;
	-------------register file-----------------
	constant NumBitData : integer := 32;
	--constant NumBitRegisterFile : integer := 32;

	constant NumBitAddress : integer := 5;
	constant Windows_Bit: integer:= 2;
	constant Numreg_IN_LOC_OUT: integer:=8;
	constant Numreg_g: integer:=8;
	constant tot_windows: integer:=4;

	------------adder/sub----------------------
	constant NumBitAdderSub : integer := 32;
	-------------p4 adder----------------------
	constant NumBitP4Data : integer := 32;
    constant NumBitPerBlock : integer := 4;
	constant NumBlocks : integer := 8;
    constant NBIT_PER_BLOCK : integer := 4;
    constant NBIT: integer := 32;
    constant NBLOCKS : integer := NBIT/NBIT_PER_BLOCK;
	-------------booth multiplier--------------
	constant NumBitMuxBoothMul : integer := 8;
	constant NumBitBoothMul : integer := 16;
	-------------instruction memory------------
	constant RAM_DEPTH : integer := 120;
	constant I_SIZE : integer := 32;
	constant BIT_IRAM : integer := 8;
	-------------data memory------------
	constant BIT_DRAM : integer := 32;
	-------------data memory------------
	constant BIT_RISC_no_ext : integer := 16;


end globals;


--fill_IRAM : for i in 0 to 3 loop
--	IRAM_mem(4*index + i) <= conv_integer(unsigned(tmp_data_u(4*i to 4*i + 3)));
--  end loop fill_IRAM ;