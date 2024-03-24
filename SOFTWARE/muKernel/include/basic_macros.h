
#ifndef __BASIC_MACROS_H
#define __BASIC_MACROS_H

// -----------------------------------------------------------------------
// Verification Macro
// -----------------------------------------------------------------------

#define PASS		\
pass_:				\
	li	x31,'O';	\
	li	x30,'K';	\
	li	x29,'\n';	\
loop_pass:			\
	bne	x31, x0, loop_pass;

#define FAIL			\
fail:					\
	li		x31,'E';	\
	li		x30,'R';	\
	li		x29,'R';	\
	li		x28,'O';	\
	li		x27,':';	\
	li		x26,' ';	\
	li		x25,'\n';	\
loop_fail:				\
	bne	x31, x0, loop_fail;

#define CLEAR_REGFILE	\
	addi	x1,  x0, 0;	\
	addi	x2,  x0, 0;	\
	addi	x3,  x0, 0;	\
	addi	x4,  x0, 0;	\
	addi	x5,  x0, 0;	\
	addi	x6,  x0, 0;	\
	addi	x7,  x0, 0;	\
	addi	x8,  x0, 0;	\
	addi	x9,  x0, 0;	\
	addi	x10, x0, 0;	\
	addi	x11, x0, 0;	\
	addi	x12, x0, 0;	\
	addi	x13, x0, 0;	\
	addi	x14, x0, 0;	\
	addi	x15, x0, 0;	\
	addi	x16, x0, 0;	\
	addi	x17, x0, 0;	\
	addi	x18, x0, 0;	\
	addi	x19, x0, 0;	\
	addi	x20, x0, 0;	\
	addi	x21, x0, 0;	\
	addi	x22, x0, 0;	\
	addi	x23, x0, 0;	\
	addi	x24, x0, 0;	\
	addi	x25, x0, 0;	\
	addi	x26, x0, 0;	\
	addi	x27, x0, 0;	\
	addi	x28, x0, 0;	\
	addi	x29, x0, 0;	\
	addi	x30, x0, 0;	\
	addi	x31, x0, 0;

#define SET_ANYREGFILE		\
	addi	x1,  x0, 1;		\
	addi	x2,  x0, 8;		\
	addi	x3,  x0, 15;	\
	addi	x4,  x0, 22;	\
	addi	x5,  x0, 29;	\
	addi	x6,  x0, 36;	\
	addi	x7,  x0, 43;	\
	addi	x8,  x0, 50;	\
	addi	x9,  x0, 57;	\
	addi	x10, x0, 64;	\
	addi	x11, x0, 71;	\
	addi	x12, x0, 78;	\
	addi	x13, x0, 85;	\
	addi	x14, x0, 92;	\
	addi	x15, x0, 99;	\
	addi	x16, x0, -1;	\
	addi	x17, x0, -8;	\
	addi	x18, x0, -15;	\
	addi	x19, x0, -22;	\
	addi	x20, x0, -29;	\
	addi	x21, x0, -36;	\
	addi	x22, x0, -43;	\
	addi	x23, x0, -50;	\
	addi	x24, x0, -57;	\
	addi	x25, x0, -64;	\
	addi	x26, x0, -71;	\
	addi	x27, x0, -78;	\
	addi	x28, x0, -85;	\
	addi	x29, x0, -92;	\
	addi	x30, x0, -99;	\
	addi	x31, x0, -106;

// -----------------------------------------------------------------------
// Basic test for BNE
// -----------------------------------------------------------------------
#define BASIC_BRANCH_OP(testnum , inst , rs1 , rs2)	\
	inst rs1, rs2, fail;

// -----------------------------------------------------------------------
// Basic test for ADDI
// -----------------------------------------------------------------------
#define BASIC_TEST_CASE_ADDI(testnum , result)	\
test_## testnum:				\
	addi	x29, x0, result;	\
	addi	x24, x0, testnum;	\
	bne		x29, x31, fail;

#define BASIC_ADDI_OP(rd , rs1 , imm)	\
	addi	rd, rs1, imm;

// -----------------------------------------------------------------------
// Basic test for LUI
// -----------------------------------------------------------------------
#define BASIC_TEST_CASE_LUI(testnum)	\
test_## testnum:				\
	addi	x24, x0, testnum;	\
	bne		x0,  x0, fail;		\
	beq		x1,  x0, fail;		\
	beq		x2,  x0, fail;		\
	beq		x3,  x0, fail;		\
	beq		x4,  x0, fail;		\
	beq		x5,  x0, fail;		\
	beq		x6,  x0, fail;		\
	beq		x7,  x0, fail;		\
	beq		x8,  x0, fail;		\
	beq		x9,  x0, fail;		\
	beq		x10, x0, fail;		\
	beq		x11, x0, fail;		\
	beq		x12, x0, fail;		\
	beq		x13, x0, fail;		\
	beq		x14, x0, fail;		\
	beq		x15, x0, fail;		\
	beq		x16, x0, fail;		\
	beq		x17, x0, fail;		\
	beq		x18, x0, fail;		\
	beq		x19, x0, fail;		\
	beq		x20, x0, fail;		\
	beq		x21, x0, fail;		\
	beq		x22, x0, fail;		\
	beq		x23, x0, fail;		\
	beq		x25, x0, fail;		\
	beq		x26, x0, fail;		\
	beq		x27, x0, fail;		\
	beq		x28, x0, fail;		\
	beq		x29, x0, fail;		\
	beq		x30, x0, fail;		\
	beq		x31, x0, fail;

#define BASIC_LUI_OP(rd , imm)	\
	lui		rd, imm;


#endif
