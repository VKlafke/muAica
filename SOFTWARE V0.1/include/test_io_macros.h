
#ifndef __TEST_IO_MACROS_H
#define __TEST_IO_MACROS_H

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
// Test UART Baud Rate
// -----------------------------------------------------------------------

#define TEST_UART_BD_R(inst , testnum , rd ,  result , addr)\
	TEST_CASE(inst , testnum, rd, result,	\
	li		x31, result;					\
	lbu		rd, 0(addr);					\
	)

#define TEST_UART_BD_WR(inst , testnum , rd ,  result , addr)\
	TEST_CASE(inst , testnum, rd, result,	\
	li		x31, result;					\
	sb		x31, 0(addr);					\
	lbu		rd, 0(addr);					\
	)

#define TEST_UART_BD_RW(inst , testnum , rd ,  result , value , addr)\
	TEST_CASE(inst , testnum, rd, result,	\
	li		x21, value;						\
	lbu		x20,	0(addr);				\
	sb		x21,	0(addr);				\
	lbu		rd,		0(addr);				\
	add		rd, rd, x20;					\
	)

#endif
