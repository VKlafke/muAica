#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.section .text,"ax"
_reg2reg_s_:

# ---------------------------------------------------
# ADD INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	add, x1,  x30, x1,		12,		5, 		7);
	TEST_R2R_OP(2, 	add, x2,  x1,  x31,		24,		9, 		15);
	TEST_R2R_OP(3, 	add, x3,  x2,  x1,		43,		40, 	3);
	TEST_R2R_OP(4, 	add, x4,  x3,  x2,		695,	-20, 	715);
	TEST_R2R_OP(5, 	add, x5,  x4,  x3,		1832,	812, 	1020);
	TEST_R2R_OP(6, 	add, x6,  x5,  x4,		-48,	29, 	-77);
	TEST_R2R_OP(7, 	add, x7,  x6,  x5,		1284,	2001, 	-717);
	TEST_R2R_OP(8,	add, x8,  x7,  x6,		25,		8, 		17);
	TEST_R2R_OP(9,	add, x9,  x8,  x7,		199,	98, 	101);
	TEST_R2R_OP(10, add, x10, x9,  x8,		23,		-18, 	41);
	TEST_R2R_OP(11, add, x11, x10, x9,		-49,	-56, 	7);
	TEST_R2R_OP(12, add, x12, x11, x10,		16,		8, 		8);
	TEST_R2R_OP(13, add, x13, x12, x11,		4006,	2003, 	2003);
	TEST_R2R_OP(14, add, x14, x13, x12,		-4006,	-2003, 	-2003);
	TEST_R2R_OP(15, add, x15, x14, x13,		12,		5, 		7);
	TEST_R2R_OP(16, add, x16, x15, x14,		24,		9, 		15);
	TEST_R2R_OP(17, add, x17, x16, x15,		43,		40, 	3);
	TEST_R2R_OP(18, add, x18, x17, x16,		695,	-20, 	715);
	TEST_R2R_OP(19, add, x19, x18, x17,		1832,	812, 	1020);
	TEST_R2R_OP(20, add, x20, x19, x18,		-48,	29, 	-77);
	TEST_R2R_OP(21, add, x21, x20, x19,		1284,	2001, 	-717);
	TEST_R2R_OP(22, add, x22, x21, x20,		25,		8, 		17);
	TEST_R2R_OP(23, add, x23, x22, x21,		199,	98, 	101);
	TEST_R2R_OP(24, add, x24, x23, x22,		23,		-18, 	41);
	TEST_R2R_OP(25, add, x25, x24, x23,		-49,	-56, 	7);
	TEST_R2R_OP(26, add, x26, x25, x24,		16,		8, 		8);
	TEST_R2R_OP(27, add, x27, x26, x25,		4006,	2003, 	2003);
	TEST_R2R_OP(28, add, x28, x27, x26,		-4006,	-2003, 	-2003);
	TEST_R2R_OP(29, add, x29, x28, x27,		3,		1, 		2);
	
# ---------------------------------------------------
# SUB INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(30,	sub, x1,  x30, x1,		-2,		5, 		7);
	TEST_R2R_OP(31, sub, x2,  x1,  x31,		-6,		9, 		15);
	TEST_R2R_OP(32, sub, x3,  x2,  x1,		37,		40, 	3);
	TEST_R2R_OP(33, sub, x4,  x3,  x2,		-735,	-20, 	715);
	TEST_R2R_OP(34, sub, x5,  x4,  x3,		-208,	812, 	1020);
	TEST_R2R_OP(35, sub, x6,  x5,  x4,		106,	29, 	-77);
	TEST_R2R_OP(36, sub, x7,  x6,  x5,		2718,	2001, 	-717);
	TEST_R2R_OP(37,	sub, x8,  x7,  x6,		-9,		8, 		17);
	TEST_R2R_OP(38,	sub, x9,  x8,  x7,		-3,		98, 	101);
	TEST_R2R_OP(39, sub, x10, x9,  x8,		-59,	-18, 	41);
	TEST_R2R_OP(40, sub, x11, x10, x9,		-63,	-56, 	7);
	TEST_R2R_OP(41, sub, x12, x11, x10,		0,		8, 		8);
	TEST_R2R_OP(42, sub, x13, x12, x11,		0,		2003, 	2003);
	TEST_R2R_OP(43, sub, x14, x13, x12,		0,		-2003, 	-2003);
	TEST_R2R_OP(44, sub, x15, x14, x13,		-2,		5, 		7);
	TEST_R2R_OP(45, sub, x16, x15, x14,		-6,		9, 		15);
	TEST_R2R_OP(46, sub, x17, x16, x15,		37,		40, 	3);
	TEST_R2R_OP(47, sub, x18, x17, x16,		-735,	-20, 	715);
	TEST_R2R_OP(48, sub, x19, x18, x17,		-208,	812, 	1020);
	TEST_R2R_OP(49, sub, x20, x19, x18,		106,	29, 	-77);
	TEST_R2R_OP(50, sub, x21, x20, x19,		2718,	2001, 	-717);
	TEST_R2R_OP(51, sub, x22, x21, x20,		-9,		8, 		17);
	TEST_R2R_OP(52, sub, x23, x22, x21,		-3,		98, 	101);
	TEST_R2R_OP(53, sub, x24, x23, x22,		-59,	-18, 	41);
	TEST_R2R_OP(54, sub, x25, x24, x23,		-63,	-56, 	7);
	TEST_R2R_OP(55, sub, x26, x25, x24,		0,		8, 		8);
	TEST_R2R_OP(56, sub, x27, x26, x25,		0,		2003, 	2003);
	TEST_R2R_OP(57, sub, x28, x27, x26,		0,		-2003, 	-2003);
	TEST_R2R_OP(58, sub, x29, x28, x27,		-1,		1, 		2);

# ---------------------------------------------------
# OR INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	or, x1,  x30, x1,	0x0000008A, 0x00000080, 0x0000000A);
	TEST_R2R_OP(2, 	or, x2,  x1,  x31,	0x000008A0, 0x00000800, 0x000000A0);
	TEST_R2R_OP(3, 	or, x3,  x2,  x1,	0x00008A00, 0x00008000, 0x00000A00);
	TEST_R2R_OP(4, 	or, x4,  x3,  x2,	0x0008A000, 0x00080000, 0x0000A000);
	TEST_R2R_OP(5, 	or, x5,  x4,  x3,	0x008A0000, 0x00800000, 0x000A0000);
	TEST_R2R_OP(6, 	or, x6,  x5,  x4,	0x08A00000, 0x08000000, 0x00A00000);
	TEST_R2R_OP(7, 	or, x7,  x6,  x5,	0x8A000000, 0x80000000, 0x0A000000);
	TEST_R2R_OP(8,	or, x8,  x7,  x6,	0xA0000000, 0x00000000, 0xA0000000);
	TEST_R2R_OP(9,	or, x9,  x8,  x7,	0x11111111, 0x10101010, 0x01010101);
	TEST_R2R_OP(10, or, x10, x9,  x8,	0x22222222, 0x20202020, 0x02020202);
	TEST_R2R_OP(11, or, x11, x10, x9,	0x33333333, 0x03030303, 0x30303030);
	TEST_R2R_OP(12, or, x12, x11, x10,	0x44444444, 0x04040404, 0x40404040);
	TEST_R2R_OP(13, or, x13, x12, x11,	0x55555555, 0x41414141, 0x14141414);
	TEST_R2R_OP(14, or, x14, x13, x12,	0x77777777, 0x77770000, 0x00007777);
	TEST_R2R_OP(15, or, x15, x14, x13,	0x00077000, 0x00077000, 0x00077000);
	TEST_R2R_OP(16, or, x16, x15, x14,	0x0000008A, 0x00000080, 0x0000000A);
	TEST_R2R_OP(17, or, x17, x16, x15,	0x000008A0, 0x00000800, 0x000000A0);
	TEST_R2R_OP(18, or, x18, x17, x16,	0x00008A00, 0x00008000, 0x00000A00);
	TEST_R2R_OP(19, or, x19, x18, x17,	0x0008A000, 0x00080000, 0x0000A000);
	TEST_R2R_OP(20, or, x20, x19, x18,	0x008A0000, 0x00800000, 0x000A0000);
	TEST_R2R_OP(21, or, x21, x20, x19,	0x08A00000, 0x08000000, 0x00A00000);
	TEST_R2R_OP(22, or, x22, x21, x20,	0x8A000000, 0x80000000, 0x0A000000);
	TEST_R2R_OP(23, or, x23, x22, x21,	0xA0000000, 0x00000000, 0xA0000000);
	TEST_R2R_OP(24, or, x24, x23, x22,	0x11111111, 0x10101010, 0x01010101);
	TEST_R2R_OP(25, or, x25, x24, x23,	0x22222222, 0x20202020, 0x02020202);
	TEST_R2R_OP(26, or, x26, x25, x24,	0x33333333, 0x03030303, 0x30303030);
	TEST_R2R_OP(27, or, x27, x26, x25,	0x44444444, 0x04040404, 0x40404040);
	TEST_R2R_OP(28, or, x28, x27, x26,	0x55555555, 0x41414141, 0x14141414);
	TEST_R2R_OP(29, or, x29, x28, x27,	0x77777777, 0x77770000, 0x00007777);

# ---------------------------------------------------
# AND INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	and, x1,  x30, x1,	0xffffff75, 0xffffff7f, 0xfffffff5);
	TEST_R2R_OP(2, 	and, x2,  x1,  x31,	0xfffff75f, 0xfffff7ff, 0xffffff5f);
	TEST_R2R_OP(3, 	and, x3,  x2,  x1,	0xffff75ff, 0xffff7fff, 0xfffff5ff);
	TEST_R2R_OP(4, 	and, x4,  x3,  x2,	0xfff75fff, 0xfff7ffff, 0xffff5fff);
	TEST_R2R_OP(5, 	and, x5,  x4,  x3,	0xff75ffff, 0xff7fffff, 0xfff5ffff);
	TEST_R2R_OP(6, 	and, x6,  x5,  x4,	0xf75fffff, 0xf7ffffff, 0xff5fffff);
	TEST_R2R_OP(7, 	and, x7,  x6,  x5,	0x55ffffff, 0x5fffffff, 0xf5ffffff);
	TEST_R2R_OP(8,	and, x8,  x7,  x6,	0x5fffffff, 0xffffffff, 0x5fffffff);
	TEST_R2R_OP(9,	and, x9,  x8,  x7,	0x00000000, 0x10101010, 0x01010101);
	TEST_R2R_OP(10, and, x10, x9,  x8,	0x00000000, 0x20202020, 0x02020202);
	TEST_R2R_OP(11, and, x11, x10, x9,	0x00000000, 0x03030303, 0x30303030);
	TEST_R2R_OP(12, and, x12, x11, x10,	0x03030303, 0x0f0f0f0f, 0x03030303);
	TEST_R2R_OP(13, and, x13, x12, x11,	0x00000000, 0x00000000, 0xffffffff);
	TEST_R2R_OP(14, and, x14, x13, x12,	0x00003131, 0x0000f1f1, 0x00003333);
	TEST_R2R_OP(15, and, x15, x14, x13,	0x00310000, 0x00790000, 0x33330000);
	TEST_R2R_OP(16, and, x16, x15, x14,	0xffffff75, 0xffffff7f, 0xfffffff5);
	TEST_R2R_OP(17, and, x17, x16, x15,	0xfffff75f, 0xfffff7ff, 0xffffff5f);
	TEST_R2R_OP(18, and, x18, x17, x16,	0xffff75ff, 0xffff7fff, 0xfffff5ff);
	TEST_R2R_OP(19, and, x19, x18, x17,	0xfff75fff, 0xfff7ffff, 0xffff5fff);
	TEST_R2R_OP(20, and, x20, x19, x18,	0xff75ffff, 0xff7fffff, 0xfff5ffff);
	TEST_R2R_OP(21, and, x21, x20, x19,	0xf75fffff, 0xf7ffffff, 0xff5fffff);
	TEST_R2R_OP(22, and, x22, x21, x20,	0x55ffffff, 0x5fffffff, 0xf5ffffff);
	TEST_R2R_OP(23, and, x23, x22, x21,	0x5fffffff, 0xffffffff, 0x5fffffff);
	TEST_R2R_OP(24, and, x24, x23, x22,	0x00000000, 0x10101010, 0x01010101);
	TEST_R2R_OP(25, and, x25, x24, x23,	0x00000000, 0x20202020, 0x02020202);
	TEST_R2R_OP(26, and, x26, x25, x24,	0x00000000, 0x03030303, 0x30303030);
	TEST_R2R_OP(27, and, x27, x26, x25,	0x03030303, 0x0f0f0f0f, 0x03030303);
	TEST_R2R_OP(28, and, x28, x27, x26,	0x00000000, 0x00000000, 0xffffffff);
	TEST_R2R_OP(29, and, x29, x28, x27,	0x00003131, 0x0000f1f1, 0x00003333);

# ---------------------------------------------------
# XOR INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
  	TEST_R2R_OP(1,	xor, x1,  x30, x1,	0x0000000A, 0x00000000, 0x0000000A);
	TEST_R2R_OP(2, 	xor, x2,  x1,  x31,	0x000000A0, 0x00000000, 0x000000A0);
	TEST_R2R_OP(3, 	xor, x3,  x2,  x1,	0x00000A00, 0x00000000, 0x00000A00);
	TEST_R2R_OP(4, 	xor, x4,  x3,  x2,	0x0000A000, 0x00000000, 0x0000A000);
	TEST_R2R_OP(5, 	xor, x5,  x4,  x3,	0x000A0000, 0x00000000, 0x000A0000);
	TEST_R2R_OP(6, 	xor, x6,  x5,  x4,	0x00A00000, 0x00000000, 0x00A00000);
	TEST_R2R_OP(7, 	xor, x7,  x6,  x5,	0x0A000000, 0x00000000, 0x0A000000);
	TEST_R2R_OP(8,	xor, x8,  x7,  x6,	0xA0000000, 0x00000000, 0xA0000000);
	TEST_R2R_OP(9,	xor, x9,  x8,  x7,	0x11111111, 0x10101010, 0x01010101);
	TEST_R2R_OP(10, xor, x10, x9,  x8,	0x22222222, 0x20202020, 0x02020202);
	TEST_R2R_OP(11, xor, x11, x10, x9,	0x33333333, 0x03030303, 0x30303030);
	TEST_R2R_OP(12, xor, x12, x11, x10,	0x44444444, 0x04040404, 0x40404040);
	TEST_R2R_OP(13, xor, x13, x12, x11,	0x55555555, 0x41414141, 0x14141414);
	TEST_R2R_OP(14, xor, x14, x13, x12,	0x77775555, 0x77770000, 0x00005555);
	TEST_R2R_OP(15, xor, x15, x14, x13,	0x00000000, 0x00077000, 0x00077000);
	TEST_R2R_OP(16, xor, x16, x15, x14,	0x0000000A, 0x00000000, 0x0000000A);
	TEST_R2R_OP(17, xor, x17, x16, x15,	0x000000A0, 0x00000000, 0x000000A0);
	TEST_R2R_OP(18, xor, x18, x17, x16,	0x00000A00, 0x00000000, 0x00000A00);
	TEST_R2R_OP(19, xor, x19, x18, x17,	0x0000A000, 0x00000000, 0x0000A000);
	TEST_R2R_OP(20, xor, x20, x19, x18,	0x000A0000, 0x00000000, 0x000A0000);
	TEST_R2R_OP(21, xor, x21, x20, x19,	0x00A00000, 0x00000000, 0x00A00000);
	TEST_R2R_OP(22, xor, x22, x21, x20,	0x0A000000, 0x00000000, 0x0A000000);
	TEST_R2R_OP(23, xor, x23, x22, x21,	0xA0000000, 0x00000000, 0xA0000000);
	TEST_R2R_OP(24, xor, x24, x23, x22,	0x11111111, 0x10101010, 0x01010101);
	TEST_R2R_OP(25, xor, x25, x24, x23,	0x22222222, 0x20202020, 0x02020202);
	TEST_R2R_OP(26, xor, x26, x25, x24,	0x33333333, 0x03030303, 0x30303030);
	TEST_R2R_OP(27, xor, x27, x26, x25,	0x44444444, 0x04040404, 0x40404040);
	TEST_R2R_OP(28, xor, x28, x27, x26,	0x55555555, 0x41414141, 0x14141414);
	TEST_R2R_OP(29, xor, x29, x28, x27,	0x77775555, 0x77770000, 0x00005555);

# ---------------------------------------------------
# SLT INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	slt, x1,  x30, x1,		1,		5, 		7);
	TEST_R2R_OP(2, 	slt, x2,  x1,  x31,		1,		9, 		15);
	TEST_R2R_OP(3, 	slt, x3,  x2,  x1,		0,		40, 	3);
	TEST_R2R_OP(4, 	slt, x4,  x3,  x2,		1,		-20, 	715);
	TEST_R2R_OP(5, 	slt, x5,  x4,  x3,		1,		812, 	1020);
	TEST_R2R_OP(6, 	slt, x6,  x5,  x4,		0,		29, 	-77);
	TEST_R2R_OP(7, 	slt, x7,  x6,  x5,		0,		2001, 	-717);
	TEST_R2R_OP(8,	slt, x8,  x7,  x6,		1,		8, 		17);
	TEST_R2R_OP(9,	slt, x9,  x8,  x7,		1,		98, 	101);
	TEST_R2R_OP(10, slt, x10, x9,  x8,		1,		-18, 	41);
	TEST_R2R_OP(11, slt, x11, x10, x9,		1,		-56, 	0);
	TEST_R2R_OP(12, slt, x12, x11, x10,		1,		-218, 	-8);
	TEST_R2R_OP(13, slt, x13, x12, x11,		0,		2003, 	2003);
	TEST_R2R_OP(14, slt, x14, x13, x12,		0,		-2003, 	-2003);
	TEST_R2R_OP(15, slt, x15, x14, x13,		0,		-415, 	-707);	
	TEST_R2R_OP(16, slt, x16, x15, x14,		1,		5, 		7);
	TEST_R2R_OP(17, slt, x17, x16, x15,		1,		9, 		15);
	TEST_R2R_OP(18, slt, x18, x17, x16,		0,		40, 	3);
	TEST_R2R_OP(19, slt, x19, x18, x17,		1,		-20, 	715);
	TEST_R2R_OP(20, slt, x20, x19, x18,		1,		812, 	1020);
	TEST_R2R_OP(21, slt, x21, x20, x19,		0,		29, 	-77);
	TEST_R2R_OP(22, slt, x22, x21, x20,		0,		2001, 	-717);
	TEST_R2R_OP(23, slt, x23, x22, x21,		1,		8, 		17);
	TEST_R2R_OP(24, slt, x24, x23, x22,		1,		98, 	101);
	TEST_R2R_OP(25, slt, x25, x24, x23,		1,		-18, 	41);
	TEST_R2R_OP(26, slt, x26, x25, x24,		1,		-56, 	0);
	TEST_R2R_OP(27, slt, x27, x26, x25,		1,		-218, 	-8);
	TEST_R2R_OP(28, slt, x28, x27, x26,		0,		2003, 	2003);
	TEST_R2R_OP(29, slt, x29, x28, x27,		0,		-2003, 	-2003);

# ---------------------------------------------------
# SLTU INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	sltu, x1,  x30, x1,		1,		5, 		7);
	TEST_R2R_OP(2, 	sltu, x2,  x1,  x31,	1,		9, 		15);
	TEST_R2R_OP(3, 	sltu, x3,  x2,  x1,		0,		40, 	3);
	TEST_R2R_OP(4, 	sltu, x4,  x3,  x2,		0,		-20, 	715);
	TEST_R2R_OP(5, 	sltu, x5,  x4,  x3,		1,		812, 	1020);
	TEST_R2R_OP(6, 	sltu, x6,  x5,  x4,		1,		29, 	-77);
	TEST_R2R_OP(7, 	sltu, x7,  x6,  x5,		1,		2001, 	-717);
	TEST_R2R_OP(8,	sltu, x8,  x7,  x6,		1,		8, 		17);
	TEST_R2R_OP(9,	sltu, x9,  x8,  x7,		1,		98, 	101);
	TEST_R2R_OP(10, sltu, x10, x9,  x8,		0,		-18, 	41);
	TEST_R2R_OP(11, sltu, x11, x10, x9,		0,		-56, 	0);
	TEST_R2R_OP(12, sltu, x12, x11, x10,	1,		-218, 	-8);
	TEST_R2R_OP(13, sltu, x13, x12, x11,	0,		2003, 	2003);
	TEST_R2R_OP(14, sltu, x14, x13, x12,	0,		-2003, 	-2003);
	TEST_R2R_OP(15, sltu, x15, x14, x13,	0,		-1, 	0);
	TEST_R2R_OP(16, sltu, x16, x15, x14,	1,		5, 		7);
	TEST_R2R_OP(17, sltu, x17, x16, x15,	1,		9, 		15);
	TEST_R2R_OP(18, sltu, x18, x17, x16,	0,		40, 	3);
	TEST_R2R_OP(19, sltu, x19, x18, x17,	0,		-20, 	715);
	TEST_R2R_OP(20, sltu, x20, x19, x18,	1,		812, 	1020);
	TEST_R2R_OP(21, sltu, x21, x20, x19,	1,		29, 	-77);
	TEST_R2R_OP(22, sltu, x22, x21, x20,	1,		2001, 	-717);
	TEST_R2R_OP(23, sltu, x23, x22, x21,	1,		8, 		17);
	TEST_R2R_OP(24, sltu, x24, x23, x22,	1,		98, 	101);
	TEST_R2R_OP(25, sltu, x25, x24, x23,	0,		-18, 	41);
	TEST_R2R_OP(26, sltu, x26, x25, x24,	0,		-56, 	0);
	TEST_R2R_OP(27, sltu, x27, x26, x25,	1,		-218, 	-8);
	TEST_R2R_OP(28, sltu, x28, x27, x26,	0,		2003, 	2003);
	TEST_R2R_OP(29, sltu, x29, x28, x27,	0,		-2003, 	-2003);

# ---------------------------------------------------
# SLL INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	sll, x1,  x30, x1,		0x00000001, 0x00000001, 0  );
	TEST_R2R_OP(2, 	sll, x2,  x1,  x31,		0x00000002, 0x00000001, 1  );
	TEST_R2R_OP(3, 	sll, x3,  x2,  x1,		0x00000080, 0x00000001, 7  );
	TEST_R2R_OP(4, 	sll, x4,  x3,  x2,		0x00004000, 0x00000001, 14 );
	TEST_R2R_OP(5, 	sll, x5,  x4,  x3,		0x80000000, 0x00000001, 31 );
	TEST_R2R_OP(6, 	sll, x6,  x5,  x4,		0xffffffff, 0xffffffff, 0  );
	TEST_R2R_OP(7, 	sll, x7,  x6,  x5,		0xfffffffe, 0xffffffff, 1  );
	TEST_R2R_OP(8,	sll, x8,  x7,  x6,		0xffffff80, 0xffffffff, 7  );
	TEST_R2R_OP(9,	sll, x9,  x8,  x7,		0xffffc000, 0xffffffff, 14 );
	TEST_R2R_OP(10, sll, x10, x9,  x8,		0x80000000, 0xffffffff, 31 );
	TEST_R2R_OP(11, sll, x11, x10, x9,		0x21212121, 0x21212121, 0  );
	TEST_R2R_OP(12, sll, x12, x11, x10,		0x42424242, 0x21212121, 1  );
	TEST_R2R_OP(13, sll, x13, x12, x11,		0x90909080, 0x21212121, 7  );
	TEST_R2R_OP(14, sll, x14, x13, x12,		0x48484000, 0x21212121, 14 );
	TEST_R2R_OP(15, sll, x15, x14, x13,		0x80000000, 0x21212121, 31 );
	TEST_R2R_OP(16, sll, x16, x15, x14,		0x00000001, 0x00000001, 0  );
	TEST_R2R_OP(17, sll, x17, x16, x15,		0x00000002, 0x00000001, 1  );
	TEST_R2R_OP(18, sll, x18, x17, x16,		0x00000080, 0x00000001, 7  );
	TEST_R2R_OP(19, sll, x19, x18, x17,		0x00004000, 0x00000001, 14 );
	TEST_R2R_OP(20, sll, x20, x19, x18,		0x80000000, 0x00000001, 31 );
	TEST_R2R_OP(21, sll, x21, x20, x19,		0xffffffff, 0xffffffff, 0  );
	TEST_R2R_OP(22, sll, x22, x21, x20,		0xfffffffe, 0xffffffff, 1  );
	TEST_R2R_OP(23, sll, x23, x22, x21,		0xffffff80, 0xffffffff, 7  );
	TEST_R2R_OP(24, sll, x24, x23, x22,		0xffffc000, 0xffffffff, 14 );
	TEST_R2R_OP(25, sll, x25, x24, x23,		0x80000000, 0xffffffff, 31 );
	TEST_R2R_OP(26, sll, x26, x25, x24,		0x21212121, 0x21212121, 0  );
	TEST_R2R_OP(27, sll, x27, x26, x25,		0x42424242, 0x21212121, 1  );
	TEST_R2R_OP(28, sll, x28, x27, x26,		0x90909080, 0x21212121, 7  );
	TEST_R2R_OP(29, sll, x29, x28, x27,		0x48484000, 0x21212121, 14 );

	# verify if the shift uses only the 5lsb of the immediate
	TEST_R2R_OP(31, sll, x25, x24, x23,		0x21212121, 0x21212121, 0xffffffe0 );
	TEST_R2R_OP(32, sll, x26, x25, x24,		0x42424242, 0x21212121, 0xffffffe1 );
	TEST_R2R_OP(33, sll, x27, x26, x25,		0x90909080, 0x21212121, 0xffffffe7 );
	TEST_R2R_OP(34, sll, x28, x27, x26,		0x48484000, 0x21212121, 0xffffffee );
	TEST_R2R_OP(35, sll, x29, x28, x27,		0x00000000, 0x21212120, 0xffffffff );

# ---------------------------------------------------
# SRL INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	srl, x1,  x30, x1,		0xffff8000, 0xffff8000, 0  );
	TEST_R2R_OP(2, 	srl, x2,  x1,  x31,		0x7fffc000, 0xffff8000, 1  );
	TEST_R2R_OP(3, 	srl, x3,  x2,  x1,		0x01ffff00, 0xffff8000, 7  );
	TEST_R2R_OP(4, 	srl, x4,  x3,  x2,		0x0003fffe, 0xffff8000, 14 );
	TEST_R2R_OP(5, 	srl, x5,  x4,  x3,		0x0001ffff, 0xffff8001, 15 );
	TEST_R2R_OP(6, 	srl, x6,  x5,  x4,		0xffffffff, 0xffffffff, 0  );
	TEST_R2R_OP(7, 	srl, x7,  x6,  x5,		0x7fffffff, 0xffffffff, 1  );
	TEST_R2R_OP(8,	srl, x8,  x7,  x6,		0x01ffffff, 0xffffffff, 7  );
	TEST_R2R_OP(9,	srl, x9,  x8,  x7,		0x0003ffff, 0xffffffff, 14 );
	TEST_R2R_OP(10, srl, x10, x9,  x8,		0x00000001, 0xffffffff, 31 );
	TEST_R2R_OP(11, srl, x11, x10, x9,		0x21212121, 0x21212121, 0  );
	TEST_R2R_OP(12, srl, x12, x11, x10,		0x10909090, 0x21212121, 1  );
	TEST_R2R_OP(13, srl, x13, x12, x11,		0x00424242, 0x21212121, 7  );
	TEST_R2R_OP(14, srl, x14, x13, x12,		0x00008484, 0x21212121, 14 );
	TEST_R2R_OP(15, srl, x15, x14, x13,		0x00000000, 0x21212121, 31 );
	TEST_R2R_OP(16, srl, x16, x15, x14,		0xffff8000, 0xffff8000, 0  );
	TEST_R2R_OP(17, srl, x17, x16, x15,		0x7fffc000, 0xffff8000, 1  );
	TEST_R2R_OP(18, srl, x18, x17, x16,		0x01ffff00, 0xffff8000, 7  );
	TEST_R2R_OP(19, srl, x19, x18, x17,		0x0003fffe, 0xffff8000, 14 );
	TEST_R2R_OP(20, srl, x20, x19, x18,		0x0001ffff, 0xffff8001, 15 );
	TEST_R2R_OP(21, srl, x21, x20, x19,		0xffffffff, 0xffffffff, 0  );
	TEST_R2R_OP(22, srl, x22, x21, x20,		0x7fffffff, 0xffffffff, 1  );
	TEST_R2R_OP(23, srl, x23, x22, x21,		0x01ffffff, 0xffffffff, 7  );
	TEST_R2R_OP(24, srl, x24, x23, x22,		0x0003ffff, 0xffffffff, 14 );
	TEST_R2R_OP(25, srl, x25, x24, x23,		0x00000001, 0xffffffff, 31 );
	TEST_R2R_OP(26, srl, x26, x25, x24,		0x21212121, 0x21212121, 0  );
	TEST_R2R_OP(27, srl, x27, x26, x25,		0x10909090, 0x21212121, 1  );
	TEST_R2R_OP(28, srl, x28, x27, x26,		0x00424242, 0x21212121, 7  );
	TEST_R2R_OP(29, srl, x29, x28, x27,		0x00008484, 0x21212121, 14 );

	# verify if the shift uses only the 5lsb of the immediate
	TEST_R2R_OP(31, srl, x25, x24, x23,		0x21212121, 0x21212121, 0xffffffe0 );
	TEST_R2R_OP(32, srl, x26, x25, x24,		0x10909090, 0x21212121, 0xffffffe1 );
	TEST_R2R_OP(33, srl, x27, x26, x25,		0x00424242, 0x21212121, 0xffffffe7 );
	TEST_R2R_OP(34, srl, x28, x27, x26,		0x00008484, 0x21212121, 0xffffffee );
	TEST_R2R_OP(35, srl, x29, x28, x27,		0x00000000, 0x21212121, 0xffffffff );

# ---------------------------------------------------
# SRA INSTRUCTION
	# TEST_R2R_OP(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_R2R_OP(1,	sra, x1,  x30, x1,		0x80000000, 0x80000000, 0  );
	TEST_R2R_OP(2, 	sra, x2,  x1,  x31,		0xc0000000, 0x80000000, 1  );
	TEST_R2R_OP(3, 	sra, x3,  x2,  x1,		0xff000000, 0x80000000, 7  );
	TEST_R2R_OP(4, 	sra, x4,  x3,  x2,		0xfffe0000, 0x80000000, 14 );
	TEST_R2R_OP(5, 	sra, x5,  x4,  x3,		0xffffffff, 0x80000001, 31 );
	TEST_R2R_OP(6, 	sra, x6,  x5,  x4,		0x7fffffff, 0x7fffffff, 0  );
	TEST_R2R_OP(7, 	sra, x7,  x6,  x5,		0x3fffffff, 0x7fffffff, 1  );
	TEST_R2R_OP(8,	sra, x8,  x7,  x6,		0x00ffffff, 0x7fffffff, 7  );
	TEST_R2R_OP(9,	sra, x9,  x8,  x7,		0x0001ffff, 0x7fffffff, 14 );
	TEST_R2R_OP(10, sra, x10, x9,  x8,		0x00000000, 0x7fffffff, 31 );
	TEST_R2R_OP(11, sra, x11, x10, x9,		0x81818181, 0x81818181, 0  );
	TEST_R2R_OP(12, sra, x12, x11, x10,		0xc0c0c0c0, 0x81818181, 1  );
	TEST_R2R_OP(13, sra, x13, x12, x11,		0xff030303, 0x81818181, 7  );
	TEST_R2R_OP(14, sra, x14, x13, x12,		0xfffe0606, 0x81818181, 14 );
	TEST_R2R_OP(15, sra, x15, x14, x13,		0xffffffff, 0x81818181, 31 );
	TEST_R2R_OP(16, sra, x16, x15, x14,		0x80000000, 0x80000000, 0  );
	TEST_R2R_OP(17, sra, x17, x16, x15,		0xc0000000, 0x80000000, 1  );
	TEST_R2R_OP(18, sra, x18, x17, x16,		0xff000000, 0x80000000, 7  );
	TEST_R2R_OP(19, sra, x19, x18, x17,		0xfffe0000, 0x80000000, 14 );
	TEST_R2R_OP(20, sra, x20, x19, x18,		0xffffffff, 0x80000001, 31 );
	TEST_R2R_OP(21, sra, x21, x20, x19,		0x7fffffff, 0x7fffffff, 0  );
	TEST_R2R_OP(22, sra, x22, x21, x20,		0x3fffffff, 0x7fffffff, 1  );
	TEST_R2R_OP(23, sra, x23, x22, x21,		0x00ffffff, 0x7fffffff, 7  );
	TEST_R2R_OP(24, sra, x24, x23, x22,		0x0001ffff, 0x7fffffff, 14 );
	TEST_R2R_OP(25, sra, x25, x24, x23,		0x00000000, 0x7fffffff, 31 );
	TEST_R2R_OP(26, sra, x26, x25, x24,		0x81818181, 0x81818181, 0  );
	TEST_R2R_OP(27, sra, x27, x26, x25,		0xc0c0c0c0, 0x81818181, 1  );
	TEST_R2R_OP(28, sra, x28, x27, x26,		0xff030303, 0x81818181, 7  );
	TEST_R2R_OP(29, sra, x29, x28, x27,		0xfffe0606, 0x81818181, 14 );

	# verify if the shift uses only the 5lsb of the immediate
	TEST_R2R_OP(31, sra, x25, x24, x23,		0x81818181, 0x81818181, 0xffffffc0 );
	TEST_R2R_OP(32, sra, x26, x25, x24,		0xc0c0c0c0, 0x81818181, 0xffffffc1 );
	TEST_R2R_OP(33, sra, x27, x26, x25,		0xff030303, 0x81818181, 0xffffffc7 );
	TEST_R2R_OP(34, sra, x28, x27, x26,		0xfffe0606, 0x81818181, 0xffffffce );
	TEST_R2R_OP(35, sra, x29, x28, x27,		0xffffffff, 0x81818181, 0xffffffff );

# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data
