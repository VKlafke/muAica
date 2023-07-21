
#ifndef __TEST_MACROS_H
#define __TEST_MACROS_H

// -----------------------------------------------------------------------
// Verification Macro
// -----------------------------------------------------------------------

#define TEST_CASE(inst, testnum, testreg, correctval , code... )	\
test_## inst ##testnum:		\
	code;					\
	li	x31, correctval;	\
	li	x30, testnum;		\
	bne	testreg, x31, fail;

#define PASS		\
pass_:				\
	li	x31,'O';	\
	li	x30,'K';	\
	li	x29,'\n';	\
loop_pass:			\
	bne	x31, x0, loop_pass;

#define FAIL			\
fail:					\
	mv		x24,x30;	\
	li		x31,'E';	\
	li		x30,'R';	\
	li		x29,'R';	\
	li		x28,'O';	\
	li		x27,':';	\
	li		x26,' ';	\
	li		x25,'\n';	\
loop_fail:				\
	bne	x31, x0, loop_fail;

// -----------------------------------------------------------------------
// Tests for store word and load word
// -----------------------------------------------------------------------

#define TEST_S_L_OP(testnum , inst_store , inst_load , rd, rs1 , rs2 , val2 , imm)	\
	TEST_CASE(inst, testnum, rd, val2,		\
	li			rs2, val2;					\
	inst_store	rs2, imm(rs1);				\
	inst_load	rd, imm(rs1);				\
	)

#define TEST_L_OP(testnum , inst , rs1 , rs2 , val2 , imm)	\
	TEST_CASE(inst, testnum, rs2, val2,		\
	inst	rs2, imm(rs1);					\
	)

// -----------------------------------------------------------------------
// Tests for store half and load half
// -----------------------------------------------------------------------

#define TEST_SH_LH_OP(testnum , inst_store , inst_load , rd, rs1 , rs2 , val2 , imm, result)	\
	TEST_CASE(inst, testnum, rd, result,	\
	li			rs2, val2;					\
	inst_store	rs2, imm(rs1);				\
	inst_load	rd, imm(rs1);				\
	)

#endif
