
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
// Tests for an instruction:register-2-immediate
// -----------------------------------------------------------------------

#define TEST_CSR_OP(testnum , inst ,reg ,  rd , rs1 , val1 , result)	\
	TEST_CASE(inst, testnum, rd, result,	\
	li		rs1, val1;						\
	inst	rd, reg, rs1;					\
	)

#define TEST_CSRI_OP(testnum , inst ,reg ,  rd , rs1 , result)	\
	TEST_CASE(inst, testnum, rd, result,	\
	inst	rd, reg, rs1;					\
	)

// -----------------------------------------------------------------------
// Tests for an instruction:register-2-immediate
// -----------------------------------------------------------------------

#define TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)		\
	TEST_CASE(inst, testnum, rd, result,	\
	li		rs1, val1;						\
	inst	rd, rs1, imm;					\
	)

#define TEST_LUI_OP(testnum , inst , rd , result , val1 , imm)		\
	TEST_CASE(inst, testnum, rd, result,	\
	li		rd, val1;						\
	inst	rd, imm;						\
	)

#define TEST_AUIPC_OP( testnum , inst , rd , rs1 , imm , immauipc)	\
test_## inst ##testnum:		\
	inst	rs1, 0;			\
	inst	rd, immauipc;	\
	sub		rd, rd, rs1;	\
	addi	rd, rd, -4;		\
	li		rs1, imm;		\
	li		x30, testnum;	\
	bne		rd, rs1, fail;

// -----------------------------------------------------------------------
// Tests for an instruction: register-2-register
// -----------------------------------------------------------------------

#define TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)	\
	TEST_CASE(inst, testnum , rd , result,	\
	li		rs1, val1;						\
	li		rs2, val2;						\
	inst	rd, rs1, rs2;					\
	)

// -----------------------------------------------------------------------
// Tests for an instruction: jump
// -----------------------------------------------------------------------
#define TEST_JUMP_OP(testnum , inst , rd )	\
	inst	rd, jal_label_## testnum;		\
	addi	rd, rd, 4;						\
	addi	rd, rd, 4;						\
	addi	rd, rd, 4;						\
jal_label_## testnum:						\
	addi	rd, rd, 12;						\
	la		x31, jal_label_## testnum;		\
	li		x30, testnum;					\
	bne		rd, x31, fail;

#define TEST_JUMPR_OP(testnum , inst , rd , rs1 , imm)	\
	la		rs1, jalr_label_## testnum;		\
	inst	rd, rs1, imm;					\
	addi	rd, rd, 4;						\
	addi	rd, rd, 4;						\
	addi	rd, rd, 4;						\
jalr_label_## testnum:						\
	j fail;									\
	j fail;									\
	j fail;									\
	j fail;									\
	addi	rd, rd, 12;						\
	li		x30, testnum;					\
	bne		rd, rs1, fail;

// -----------------------------------------------------------------------
// Tests for an instruction: branch (T - taken / NT - not taken)
// -----------------------------------------------------------------------
// #define TEST_CASE_BRANCH_T(testnum, inst, rd, result)

#define TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)\
	TEST_CASE(inst, testnum, rd, result,				\
	li		rs1, val1;									\
	li		rs2, val2;									\
	inst	rs1, rs2, label2_ ##inst ##testnum;			\
label1_ ##inst ##testnum:								\
	li		rd, val1;									\
	nop;												\
	nop;												\
label2_ ##inst ##testnum:								\
	li		rd, result;									\
	)

#define TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)\
	TEST_CASE(inst, testnum, rd, result,				\
	li		rs1, val1;									\
	li		rs2, val2;									\
	li		rd,  val1;									\
	inst	rs1, rs2, label2_ ##inst ##testnum;			\
label1_ ##inst ##testnum:								\
	li		rd, result;									\
label2_ ##inst ##testnum:								\
	)

// -----------------------------------------------------------------------
// Tests for an instruction: memory access (Load and Store)
// -----------------------------------------------------------------------
#define TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)		\
	TEST_CASE(inst, testnum, rd, result,	\
	li		rs1, ram_base;					\
	inst	rd, imm(rs1);					\
	)

#define TEST_STORE_OP(testnum , inst , rs1 , rs2 , result , imm)	\
test_ ##inst ##testnum:						\
	li		rs1, ram_base;					\
	li		rs2, result;					\
	inst	rs2, imm(rs1);					\
	lw		rs1, imm(rs1);					\
	li		x30, testnum;					\
	bne		rs1, rs2, fail;

#define TEST_STORE_LH_OP(testnum , inst , rs1 , rs2 , result , val2 , imm)\
test_ ##inst ##testnum:						\
	li		rs1, ram_base;					\
	li		rs2, val2;						\
	inst	rs2, imm(rs1);					\
	lw		rs1, imm(rs1);					\
	li		rs2, result;					\
	li		x30, testnum;					\
	bne		rs1, rs2, fail;

#define TEST_STORE_UH_OP(testnum , inst , rs1 , rs2 , result , val2 , imm)\
test_ ##inst ##testnum:						\
	li		rs1, ram_base;					\
	li		rs2, val2;						\
	inst	rs2, imm(rs1);					\
	addi	rs1, rs1, -2;					\
	lw		rs1, imm(rs1);					\
	li		rs2, result;					\
	li		x30, testnum;					\
	bne		rs1, rs2, fail;	

#define TEST_STORE_B_OP(testnum , inst , rs1 , rs2 , result , val2 , imm , imm_offset)\
test_ ##inst ##testnum:						\
	li		x30, ram_base;					\
	addi	rs1, x30, imm_offset;			\
	li		rs2, val2;						\
	inst	rs2, imm(x30);					\
	lw		rs1, imm(rs1);					\
	li		rs2, result;					\
	li		x30, testnum;					\
	bne		rs1, rs2, fail;

#define TEST_S_L_OP(testnum , inst , load , rs1 , rs2 , result , val2 , imm , imm_offset)\
test_ ##inst ##testnum:						\
	li		x30, ram_base;					\
	addi	rs1, x30, imm_offset;			\
	li		rs2, val2;						\
	inst	rs2, imm(x30);					\
	load	rs1, imm(rs1);					\
	li		rs2, result;					\
	li		x30, testnum;					\
	bne		rs1, rs2, fail;




#endif
