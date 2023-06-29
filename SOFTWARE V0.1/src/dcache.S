#include <aica_io.h>
#include <test_cache_macros.h>

# ---------------------------------------------------

.equ data0_a,	_SDATA_SEC_
.equ data0_b,	data0_a+0x00008000

# -------
.equ	sw_lw0_a,	0x00000004
.equ	sw_lw1_a,	0x00000200
.equ	sw_lw2_a,	0xfffff9f0

.equ	sw_lw0_b,	0x00000008
.equ	sw_lw1_b,	0xffffff5a
.equ	sw_lw2_b,	0x00000033

# -------
.equ	sh_lh0_a,	0x00001234
.equ	sh_lh0_ra,	0xffff1234

.equ	sh_lh1_a,	0x0000abcd
.equ	sh_lh1_ra1,	0xffffabcd
.equ	sh_lh1_ra2,	0xabcd1234

.equ	sh_lh0_b,	0x00001030
.equ	sh_lh0_rb,	0xffff1030

.equ	sh_lh1_b,	0x0000a0c0
.equ	sh_lh1_rb1,	0xffffa0c0
.equ	sh_lh1_rb2,	0xa0c01030

# ---------------------------------------------------
.section ._bootloader_,"ax"
_dcache_s_:

# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ----------SW and LW test

# ---------------------------------------------------
# SW HIT/MISS, with a LW HIT
# SW miss doesnt use the write allocate logic, since the data loaded will be older
	#TEST_S_L_OP(testnum, inst_store, inst_load, rd, rs1, rs2, val2, imm)

	li	x1, data0_a
	TEST_S_L_OP(1	,	sw,	lw,	x3,	x1,	x2,	sw_lw0_a,	0);
	TEST_S_L_OP(2	,	sw,	lw,	x3,	x1,	x2,	sw_lw1_a,	4);
	TEST_S_L_OP(3	,	sw,	lw,	x3,	x1,	x2,	sw_lw2_a,	8);

# ---------------------------------------------------
# SW MISS with a LW HIT
# SW miss now will cause a write-back operation, since the data is dirty
	li	x1,	data0_b
	TEST_S_L_OP(4	,	sw,	lw,	x3,	x1,	x2,	sw_lw0_b,	0);
	TEST_S_L_OP(5	,	sw,	lw,	x3,	x1,	x2,	sw_lw1_b,	4);
	TEST_S_L_OP(6	,	sw,	lw,	x3,	x1,	x2,	sw_lw2_b,	8);

# ---------------------------------------------------
# LW MISS, will cause write-back operation
	#TEST_LW_OP(testnum, inst, rs1, rs2, val2, imm)
	li	x1,	data0_a
	TEST_L_OP(7,	lw,	x1,	x2,	sw_lw0_a,	0);
	TEST_L_OP(8,	lw,	x1,	x2,	sw_lw1_a,	4);
	TEST_L_OP(9,	lw,	x1,	x2,	sw_lw2_a,	8);

	li	x1,	data0_b
	TEST_L_OP(10,	lw,	x1,	x2,	sw_lw0_b,	0);
	TEST_L_OP(11,	lw,	x1,	x2,	sw_lw1_b,	4);
	TEST_L_OP(12,	lw,	x1,	x2,	sw_lw2_b,	8);

# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ----------SH and LH test

# ---------------------------------------------------
# SH HIT/MISS, with a LB HIT
# SH miss use the write allocate logic, will cause a write-back due to the previous tests

	# ----- SIGNED
	li	x1, data0_a
	TEST_SH_LH_OP(	12	,	sh,	lh,	x3,	x1,	x2,	sh_lh0_a,	8,	sh_lh0_a);
	TEST_L_OP(		13	,	lw,		x1,	x2,		sh_lh0_ra,	8);	# verify if the write-allocate is working
	TEST_SH_LH_OP(	14	,	sh,	lh,	x3,	x1,	x2,	sh_lh1_a,	10,	sh_lh1_ra1);
	TEST_L_OP(		15	,	lw,		x1,	x2,		sh_lh1_ra2,	8);

	li	x1, data0_b
	TEST_SH_LH_OP(	16	,	sh,	lh,	x3,	x1,	x2,	sh_lh0_b,	4,	sh_lh0_b);
	TEST_L_OP(		17	,	lw,		x1,	x2,		sh_lh0_rb,	4);	# verify if the write-allocate is working
	TEST_SH_LH_OP(	18	,	sh,	lh,	x3,	x1,	x2,	sh_lh1_b,	6,	sh_lh1_rb1);
	TEST_L_OP(		19	,	lw,		x1,	x2,		sh_lh1_rb2,	4);

	#  test the write-back with half-word operations
	li	x1,	data0_a
	TEST_L_OP(20,	lw,	x1,	x2,	sh_lh1_ra2,	8);
	li	x1,	data0_b
	TEST_L_OP(21,	lw,	x1,	x2,	sh_lh1_rb2,	4);

# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# ----------SB and LB test

# ---------------------------------------------------
# SB HIT/MISS, with a LB HIT
# SB miss use the write allocate logic, will cause a write-back due to the previous tests

	# ----- SIGNED

	#  test the write-back with half-word operations
	
# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

.section .data

