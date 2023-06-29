#include "basic_macros.h"

.equ stack_ptr,	0x50
.equ data_start, 0x10

.section .text,"ax"

	csrwi	mie,0x1				//	exceptions and interrupts enabled

# ---------------------------------------------------
# BNE INSTRUCTION
	# BASIC_BRANCH_OP( testnum , inst, rs1 , rs2)
	# after reset all regs. should be equal to 0, so not a single
	# branch will is going to be done
	BASIC_BRANCH_OP(1  , bne , x1  , x0)
	BASIC_BRANCH_OP(2  , bne , x2  , x1)
	BASIC_BRANCH_OP(3  , bne , x3  , x2)
	BASIC_BRANCH_OP(4  , bne , x4  , x3)
	BASIC_BRANCH_OP(5  , bne , x5  , x4)
	BASIC_BRANCH_OP(6  , bne , x6  , x5)
	BASIC_BRANCH_OP(7  , bne , x7  , x6)
	BASIC_BRANCH_OP(8  , bne , x8  , x7)
	BASIC_BRANCH_OP(9  , bne , x9  , x8)
	BASIC_BRANCH_OP(10 , bne , x10 , x9)
	BASIC_BRANCH_OP(11 , bne , x11 , x10)
	BASIC_BRANCH_OP(12 , bne , x12 , x11)
	BASIC_BRANCH_OP(13 , bne , x13 , x12)
	BASIC_BRANCH_OP(14 , bne , x14 , x13)
	BASIC_BRANCH_OP(15 , bne , x15 , x14)
	BASIC_BRANCH_OP(16 , bne , x16 , x15)
	BASIC_BRANCH_OP(17 , bne , x17 , x16)
	BASIC_BRANCH_OP(18 , bne , x18 , x17)
	BASIC_BRANCH_OP(19 , bne , x19 , x18)
	BASIC_BRANCH_OP(20 , bne , x20 , x19)
	BASIC_BRANCH_OP(21 , bne , x21 , x20)
	BASIC_BRANCH_OP(22 , bne , x22 , x21)
	BASIC_BRANCH_OP(23 , bne , x23 , x22)
	BASIC_BRANCH_OP(24 , bne , x24 , x23)
	BASIC_BRANCH_OP(25 , bne , x25 , x24)
	BASIC_BRANCH_OP(26 , bne , x26 , x25)
	BASIC_BRANCH_OP(27 , bne , x27 , x26)
	BASIC_BRANCH_OP(28 , bne , x28 , x27)
	BASIC_BRANCH_OP(29 , bne , x29 , x28)
	BASIC_BRANCH_OP(30 , bne , x30 , x29)
	BASIC_BRANCH_OP(31 , bne , x31 , x30)
	
# ---------------------------------------------------
# ADDI INSTRUCTION
	# BASIC_ADDI_OP( rd , rs1 , imm)
	# BASIC_TEST_CASE_ADDI(testnum , result)
	
	# test 32
	BASIC_ADDI_OP( x1  , x0  , 15)
	BASIC_ADDI_OP( x2  , x1  , 15)
	BASIC_ADDI_OP( x3  , x2  , 15)
	BASIC_ADDI_OP( x4  , x3  , 15)
	BASIC_ADDI_OP( x5  , x4  , 15)
	BASIC_ADDI_OP( x6  , x5  , 15)
	BASIC_ADDI_OP( x7  , x6  , 15)
	BASIC_ADDI_OP( x8  , x7  , 15)
	BASIC_ADDI_OP( x9  , x8  , 15)
	BASIC_ADDI_OP( x10 , x9  , 15)
	BASIC_ADDI_OP( x11 , x10 , 15)
	BASIC_ADDI_OP( x12 , x11 , 15)
	BASIC_ADDI_OP( x13 , x12 , 15)
	BASIC_ADDI_OP( x14 , x13 , 15)
	BASIC_ADDI_OP( x15 , x14 , 15)
	BASIC_ADDI_OP( x16 , x15 , 15)
	BASIC_ADDI_OP( x17 , x16 , 15)
	BASIC_ADDI_OP( x18 , x17 , 15)
	BASIC_ADDI_OP( x19 , x18 , 15)
	BASIC_ADDI_OP( x20 , x19 , 15)
	BASIC_ADDI_OP( x21 , x20 , 15)
	BASIC_ADDI_OP( x22 , x21 , 15)
	BASIC_ADDI_OP( x23 , x22 , 15)
	BASIC_ADDI_OP( x24 , x23 , 15)
	BASIC_ADDI_OP( x25 , x24 , 15)
	BASIC_ADDI_OP( x26 , x25 , 15)
	BASIC_ADDI_OP( x27 , x26 , 15)
	BASIC_ADDI_OP( x28 , x27 , 15)
	BASIC_ADDI_OP( x29 , x28 , 15)
	BASIC_ADDI_OP( x30 , x29 , 15)
	BASIC_ADDI_OP( x31 , x30 , 15)


	BASIC_TEST_CASE_ADDI(32 , 465)

	# test 33
	BASIC_ADDI_OP( x1  , x0  , 48);
	BASIC_ADDI_OP( x2  , x1  , 48);
	BASIC_ADDI_OP( x3  , x2  , 48);
	BASIC_ADDI_OP( x4  , x3  , 48);
	BASIC_ADDI_OP( x5  , x4  , 48);
	BASIC_ADDI_OP( x6  , x5  , 48);
	BASIC_ADDI_OP( x7  , x6  , 48);
	BASIC_ADDI_OP( x8  , x7  , 48);
	BASIC_ADDI_OP( x9  , x8  , 48);
	BASIC_ADDI_OP( x10 , x9  , 48);
	BASIC_ADDI_OP( x11 , x10 , 48);
	BASIC_ADDI_OP( x12 , x11 , 48);
	BASIC_ADDI_OP( x13 , x12 , 48);
	BASIC_ADDI_OP( x14 , x13 , 48);
	BASIC_ADDI_OP( x15 , x14 , 48);
	BASIC_ADDI_OP( x16 , x15 , 48);
	BASIC_ADDI_OP( x17 , x16 , 48);
	BASIC_ADDI_OP( x18 , x17 , 48);
	BASIC_ADDI_OP( x19 , x18 , 48);
	BASIC_ADDI_OP( x20 , x19 , 48);
	BASIC_ADDI_OP( x21 , x20 , 48);
	BASIC_ADDI_OP( x22 , x21 , 48);
	BASIC_ADDI_OP( x23 , x22 , 48);
	BASIC_ADDI_OP( x24 , x23 , 48);
	BASIC_ADDI_OP( x25 , x24 , 48);
	BASIC_ADDI_OP( x26 , x25 , 48);
	BASIC_ADDI_OP( x27 , x26 , 48);
	BASIC_ADDI_OP( x28 , x27 , 48);
	BASIC_ADDI_OP( x29 , x28 , 48);
	BASIC_ADDI_OP( x30 , x29 , 48);
	BASIC_ADDI_OP( x31 , x30 , 48);

	BASIC_TEST_CASE_ADDI(33 , 1488)

	# test 34
	BASIC_ADDI_OP( x1  , x0  , -15)
	BASIC_ADDI_OP( x2  , x1  , -15)
	BASIC_ADDI_OP( x3  , x2  , -15)
	BASIC_ADDI_OP( x4  , x3  , -15)
	BASIC_ADDI_OP( x5  , x4  , -15)
	BASIC_ADDI_OP( x6  , x5  , -15)
	BASIC_ADDI_OP( x7  , x6  , -15)
	BASIC_ADDI_OP( x8  , x7  , -15)
	BASIC_ADDI_OP( x9  , x8  , -15)
	BASIC_ADDI_OP( x10 , x9  , -15)
	BASIC_ADDI_OP( x11 , x10 , -15)
	BASIC_ADDI_OP( x12 , x11 , -15)
	BASIC_ADDI_OP( x13 , x12 , -15)
	BASIC_ADDI_OP( x14 , x13 , -15)
	BASIC_ADDI_OP( x15 , x14 , -15)
	BASIC_ADDI_OP( x16 , x15 , -15)
	BASIC_ADDI_OP( x17 , x16 , -15)
	BASIC_ADDI_OP( x18 , x17 , -15)
	BASIC_ADDI_OP( x19 , x18 , -15)
	BASIC_ADDI_OP( x20 , x19 , -15)
	BASIC_ADDI_OP( x21 , x20 , -15)
	BASIC_ADDI_OP( x22 , x21 , -15)
	BASIC_ADDI_OP( x23 , x22 , -15)
	BASIC_ADDI_OP( x24 , x23 , -15)
	BASIC_ADDI_OP( x25 , x24 , -15)
	BASIC_ADDI_OP( x26 , x25 , -15)
	BASIC_ADDI_OP( x27 , x26 , -15)
	BASIC_ADDI_OP( x28 , x27 , -15)
	BASIC_ADDI_OP( x29 , x28 , -15)
	BASIC_ADDI_OP( x30 , x29 , -15)
	BASIC_ADDI_OP( x31 , x30 , -15)

	BASIC_TEST_CASE_ADDI(34 , -465)

	# test 35
	BASIC_ADDI_OP( x1  , x0  , -48)
	BASIC_ADDI_OP( x2  , x1  , -48)
	BASIC_ADDI_OP( x3  , x2  , -48)
	BASIC_ADDI_OP( x4  , x3  , -48)
	BASIC_ADDI_OP( x5  , x4  , -48)
	BASIC_ADDI_OP( x6  , x5  , -48)
	BASIC_ADDI_OP( x7  , x6  , -48)
	BASIC_ADDI_OP( x8  , x7  , -48)
	BASIC_ADDI_OP( x9  , x8  , -48)
	BASIC_ADDI_OP( x10 , x9  , -48)
	BASIC_ADDI_OP( x11 , x10 , -48)
	BASIC_ADDI_OP( x12 , x11 , -48)
	BASIC_ADDI_OP( x13 , x12 , -48)
	BASIC_ADDI_OP( x14 , x13 , -48)
	BASIC_ADDI_OP( x15 , x14 , -48)
	BASIC_ADDI_OP( x16 , x15 , -48)
	BASIC_ADDI_OP( x17 , x16 , -48)
	BASIC_ADDI_OP( x18 , x17 , -48)
	BASIC_ADDI_OP( x19 , x18 , -48)
	BASIC_ADDI_OP( x20 , x19 , -48)
	BASIC_ADDI_OP( x21 , x20 , -48)
	BASIC_ADDI_OP( x22 , x21 , -48)
	BASIC_ADDI_OP( x23 , x22 , -48)
	BASIC_ADDI_OP( x24 , x23 , -48)
	BASIC_ADDI_OP( x25 , x24 , -48)
	BASIC_ADDI_OP( x26 , x25 , -48)
	BASIC_ADDI_OP( x27 , x26 , -48)
	BASIC_ADDI_OP( x28 , x27 , -48)
	BASIC_ADDI_OP( x29 , x28 , -48)
	BASIC_ADDI_OP( x30 , x29 , -48)
	BASIC_ADDI_OP( x31 , x30 , -48)

	BASIC_TEST_CASE_ADDI(35 , -1488)

	# test 36
	BASIC_ADDI_OP( x1  , x0  , 20)
	BASIC_ADDI_OP( x2  , x1  , 21)
	BASIC_ADDI_OP( x3  , x2  , 22)
	BASIC_ADDI_OP( x4  , x3  , 23)
	BASIC_ADDI_OP( x5  , x4  , 24)
	BASIC_ADDI_OP( x6  , x5  , 25)
	BASIC_ADDI_OP( x7  , x6  , 26)
	BASIC_ADDI_OP( x8  , x7  , 27)
	BASIC_ADDI_OP( x9  , x8  , 28)
	BASIC_ADDI_OP( x10 , x9  , 2000)
	BASIC_ADDI_OP( x11 , x10 , 30)
	BASIC_ADDI_OP( x12 , x11 , 31)
	BASIC_ADDI_OP( x13 , x12 , 32)
	BASIC_ADDI_OP( x14 , x13 , 33)
	BASIC_ADDI_OP( x15 , x14 , 34)
	BASIC_ADDI_OP( x16 , x15 , 35)
	BASIC_ADDI_OP( x17 , x16 , 36)
	BASIC_ADDI_OP( x18 , x17 , 37)
	BASIC_ADDI_OP( x19 , x18 , 38)
	BASIC_ADDI_OP( x20 , x19 , 39)
	BASIC_ADDI_OP( x21 , x20 , 40)
	BASIC_ADDI_OP( x22 , x21 , 41)
	BASIC_ADDI_OP( x23 , x22 , 42)
	BASIC_ADDI_OP( x24 , x23 , -1500)
	BASIC_ADDI_OP( x25 , x24 , 44)
	BASIC_ADDI_OP( x26 , x25 , 45)
	BASIC_ADDI_OP( x27 , x26 , 46)
	BASIC_ADDI_OP( x28 , x27 , 47)
	BASIC_ADDI_OP( x29 , x28 , 48)
	BASIC_ADDI_OP( x30 , x29 , 49)
	BASIC_ADDI_OP( x31 , x30 , 50)

	BASIC_TEST_CASE_ADDI(36 , 1513)

	# test 37
	BASIC_ADDI_OP( x1  , x0  , 502)
	BASIC_ADDI_OP( x2  , x1  , -504)
	BASIC_ADDI_OP( x3  , x2  , 506)
	BASIC_ADDI_OP( x4  , x3  , -508)
	BASIC_ADDI_OP( x5  , x4  , 510)
	BASIC_ADDI_OP( x6  , x5  , -512)
	BASIC_ADDI_OP( x7  , x6  , 514)
	BASIC_ADDI_OP( x8  , x7  , -1250)
	BASIC_ADDI_OP( x9  , x8  , 1252)
	BASIC_ADDI_OP( x10 , x9  , -1254)
	BASIC_ADDI_OP( x11 , x10 , 1256)
	BASIC_ADDI_OP( x12 , x11 , -1258)
	BASIC_ADDI_OP( x13 , x12 , 1260)
	BASIC_ADDI_OP( x14 , x13 , -1262)
	BASIC_ADDI_OP( x15 , x14 , 1264)
	BASIC_ADDI_OP( x16 , x15 , -2001)
	BASIC_ADDI_OP( x17 , x16 , 2002)
	BASIC_ADDI_OP( x18 , x17 , -2003)
	BASIC_ADDI_OP( x19 , x18 , 2004)
	BASIC_ADDI_OP( x20 , x19 , -2005)
	BASIC_ADDI_OP( x21 , x20 , 2006)
	BASIC_ADDI_OP( x22 , x21 , -2007)
	BASIC_ADDI_OP( x23 , x22 , 2008)
	BASIC_ADDI_OP( x24 , x23 , -0)
	BASIC_ADDI_OP( x25 , x24 , 8)
	BASIC_ADDI_OP( x26 , x25 , -16)
	BASIC_ADDI_OP( x27 , x26 , 24)
	BASIC_ADDI_OP( x28 , x27 , -32)
	BASIC_ADDI_OP( x29 , x28 , 40)
	BASIC_ADDI_OP( x30 , x29 , -48)
	BASIC_ADDI_OP( x31 , x30 , 56)

	BASIC_TEST_CASE_ADDI(37 , 552)
	
	
# ---------------------------------------------------
# BEQ INSTRUCTION
	# BASIC_BRANCH_OP( testnum , inst , rs1 , rs2)
	# after the "SET_ANYREGFILE" MACRO  all regs. should be diff,
	# so not a single branch will take place here
	SET_ANYREGFILE

	BASIC_BRANCH_OP(38 , beq  ,x1  , x0)
	BASIC_BRANCH_OP(39 , beq  ,x2  , x1)
	BASIC_BRANCH_OP(40 , beq  ,x3  , x2)
	BASIC_BRANCH_OP(41 , beq  ,x4  , x3)
	BASIC_BRANCH_OP(42 , beq  ,x5  , x4)
	BASIC_BRANCH_OP(43 , beq  ,x6  , x5)
	BASIC_BRANCH_OP(44 , beq  ,x7  , x6)
	BASIC_BRANCH_OP(45 , beq  ,x8  , x7)
	BASIC_BRANCH_OP(46 , beq  ,x9  , x8)
	BASIC_BRANCH_OP(47 , beq ,x10 , x9)
	BASIC_BRANCH_OP(48 , beq ,x11 , x10)
	BASIC_BRANCH_OP(49 , beq ,x12 , x11)
	BASIC_BRANCH_OP(50 , beq ,x13 , x12)
	BASIC_BRANCH_OP(51 , beq ,x14 , x13)
	BASIC_BRANCH_OP(52 , beq ,x15 , x14)
	BASIC_BRANCH_OP(53 , beq ,x16 , x15)
	BASIC_BRANCH_OP(54 , beq ,x17 , x16)
	BASIC_BRANCH_OP(55 , beq ,x18 , x17)
	BASIC_BRANCH_OP(56 , beq ,x19 , x18)
	BASIC_BRANCH_OP(57 , beq ,x20 , x19)
	BASIC_BRANCH_OP(58 , beq ,x21 , x20)
	BASIC_BRANCH_OP(59 , beq ,x22 , x21)
	BASIC_BRANCH_OP(60 , beq ,x23 , x22)
	BASIC_BRANCH_OP(61 , beq ,x24 , x23)
	BASIC_BRANCH_OP(62 , beq ,x25 , x24)
	BASIC_BRANCH_OP(63 , beq ,x26 , x25)
	BASIC_BRANCH_OP(64 , beq ,x27 , x26)
	BASIC_BRANCH_OP(65 , beq ,x28 , x27)
	BASIC_BRANCH_OP(66 , beq ,x29 , x28)
	BASIC_BRANCH_OP(67 , beq ,x30 , x29)
	BASIC_BRANCH_OP(68 , beq ,x31 , x30)

	CLEAR_REGFILE
# ---------------------------------------------------
# LUI INSTRUCTION
	# BASIC_LUI_OP( rd , imm)
	# BASIC_TEST_CASE_LUI(testnum)

	# test 69
	BASIC_LUI_OP( x0  , 0x00003)
	BASIC_LUI_OP( x1  , 0x00006)
	BASIC_LUI_OP( x2  , 0x00009)
	BASIC_LUI_OP( x3  , 0x0000C)
	BASIC_LUI_OP( x4  , 0x0000F)
	BASIC_LUI_OP( x5  , 0x00012)
	BASIC_LUI_OP( x6  , 0x00015)
	BASIC_LUI_OP( x7  , 0x00018)
	BASIC_LUI_OP( x8  , 0x0001B)
	BASIC_LUI_OP( x9  , 0x0001E)
	BASIC_LUI_OP( x10 , 0x00021)
	BASIC_LUI_OP( x11 , 0x00024)
	BASIC_LUI_OP( x12 , 0x00027)
	BASIC_LUI_OP( x13 , 0x00F2A)
	BASIC_LUI_OP( x14 , 0x00E2D)
	BASIC_LUI_OP( x15 , 0x00D30)
	BASIC_LUI_OP( x16 , 0x33C00)
	BASIC_LUI_OP( x17 , 0x36B00)
	BASIC_LUI_OP( x18 , 0x39A00)
	BASIC_LUI_OP( x19 , 0x3C000)
	BASIC_LUI_OP( x20 , 0x3F000)
	BASIC_LUI_OP( x21 , 0x42000)
	BASIC_LUI_OP( x22 , 0x45000)
	BASIC_LUI_OP( x23 , 0x48000)
	# BASIC_LUI_OP( x24 , 0x4B000)	--> x24 holds the test number
	BASIC_LUI_OP( x25 , 0x4E000)
	BASIC_LUI_OP( x26 , 0x51000)
	BASIC_LUI_OP( x27 , 0x54000)
	BASIC_LUI_OP( x28 , 0x57000)
	BASIC_LUI_OP( x29 , 0x5A000)
	BASIC_LUI_OP( x30 , 0x5D000)
	BASIC_LUI_OP( x31 , 0x60000)

	BASIC_TEST_CASE_LUI(69)
	
	
# ---------------------------------------------------
# PASS Basic Tests
	PASS

# ---------------------------------------------------
# FAIL Basic Tests
	FAIL


.section .data

	data1:	.word	data_start

