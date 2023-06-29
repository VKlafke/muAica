#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.section .text,"ax"
_branch_s_:

# ---------------------------------------------------
# BNE Instruction
	# test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(1	,	bne	,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_T(2	,	bne	,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_T(3	,	bne	,	x5	,x4		,x3		,256	,40, 	3);
	TEST_BRANCH_T(4	,	bne	,	x6	,x5		,x4		,256	,-20, 	715);
	TEST_BRANCH_T(5	,	bne	,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_T(6	,	bne	,	x8	,x7		,x6		,256	,29, 	-77);
	TEST_BRANCH_T(7	,	bne	,	x9	,x8		,x7		,256	,2001, 	-717);
 	TEST_BRANCH_T(8	,	bne	,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_T(9	,	bne	,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_T(10,	bne	,	x12	,x11	,x10	,256	,-18, 	41);
	TEST_BRANCH_T(11,	bne	,	x13	,x12	,x11	,256	,-56, 	0);
	TEST_BRANCH_T(12,	bne	,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_T(13,	bne	,	x15	,x14	,x13	,256	,2004, 	2003);
 	TEST_BRANCH_T(14,	bne	,	x16	,x15	,x14	,256	,2003, -2003);
	#  test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(15,	bne	,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_NT(16,	bne	,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_NT(17,	bne	,	x19	,x18	,x17	,256	,20	,	20);
	TEST_BRANCH_NT(18,	bne	,	x20	,x19	,x18	,256	,204,	204);
	TEST_BRANCH_NT(19,	bne	,	x21	,x20	,x19	,256	,-700,	-700);
 	TEST_BRANCH_NT(20,	bne	,	x22	,x21	,x20	,256	,-100,	-100);
	TEST_BRANCH_NT(21,	bne	,	x23	,x22	,x21	,256	,440,	440);
	TEST_BRANCH_NT(22,	bne	,	x24	,x23	,x22	,256	,2005,	2005);
	TEST_BRANCH_NT(23,	bne	,	x25	,x24	,x23	,256	,-10,	-10);
	TEST_BRANCH_NT(24,	bne	,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_NT(25,	bne	,	x27	,x26	,x25	,256	,0	,	0);
 	TEST_BRANCH_NT(26,	bne	,	x28	,x27	,x26	,256	,500,	500);
	TEST_BRANCH_NT(27,	bne	,	x29	,x28	,x27	,256	,-505,	-505);

# ---------------------------------------------------
# BEQ Instruction
	# test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(28,	beq	,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_NT(29,	beq	,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_NT(30,	beq	,	x5	,x4		,x3		,256	,40, 	3);
	TEST_BRANCH_NT(31,	beq	,	x6	,x5		,x4		,256	,-20, 	715);
	TEST_BRANCH_NT(32,	beq	,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_NT(33,	beq	,	x8	,x7		,x6		,256	,29, 	-77);
	TEST_BRANCH_NT(34,	beq	,	x9	,x8		,x7		,256	,2001, 	-717);
 	TEST_BRANCH_NT(35,	beq	,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_NT(36,	beq	,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_NT(37,	beq	,	x12	,x11	,x10	,256	,-18, 	41);
	TEST_BRANCH_NT(38,	beq	,	x13	,x12	,x11	,256	,-56, 	0);
	TEST_BRANCH_NT(39,	beq	,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_NT(40,	beq	,	x15	,x14	,x13	,256	,2004, 	2003);
 	TEST_BRANCH_NT(41,	beq	,	x16	,x15	,x14	,256	,2003, -2003);
	#  test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(42,	beq	,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_T(43,	beq	,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_T(44,	beq	,	x19	,x18	,x17	,256	,20	,	20);
	TEST_BRANCH_T(45,	beq	,	x20	,x19	,x18	,256	,204,	204);
	TEST_BRANCH_T(46,	beq	,	x21	,x20	,x19	,256	,-700,	-700);
 	TEST_BRANCH_T(47,	beq	,	x22	,x21	,x20	,256	,-100,	-100);
	TEST_BRANCH_T(48,	beq	,	x23	,x22	,x21	,256	,440,	440);
	TEST_BRANCH_T(49,	beq	,	x24	,x23	,x22	,256	,2005,	2005);
	TEST_BRANCH_T(50,	beq	,	x25	,x24	,x23	,256	,-10,	-10);
	TEST_BRANCH_T(51,	beq	,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_T(52,	beq	,	x27	,x26	,x25	,256	,0	,	0);
 	TEST_BRANCH_T(53,	beq	,	x28	,x27	,x26	,256	,500,	500);
	TEST_BRANCH_T(54,	beq	,	x29	,x28	,x27	,256	,-505,	-505);	

# ---------------------------------------------------
# BGE Instruction
	# test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(55,	bge	,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_NT(56,	bge	,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_NT(57,	bge	,	x5	,x4		,x3		,256	,3, 	40);
	TEST_BRANCH_NT(58,	bge	,	x6	,x5		,x4		,256	,-20, 	715);
	TEST_BRANCH_NT(59,	bge	,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_NT(60,	bge	,	x8	,x7		,x6		,256	,-77, 	29);
	TEST_BRANCH_NT(61,	bge	,	x9	,x8		,x7		,256	,-717, 	2001);
 	TEST_BRANCH_NT(62,	bge	,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_NT(63,	bge	,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_NT(64,	bge	,	x12	,x11	,x10	,256	,-18, 	41);
	TEST_BRANCH_NT(65,	bge	,	x13	,x12	,x11	,256	,-56, 	0);
	TEST_BRANCH_NT(66,	bge	,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_NT(67,	bge	,	x15	,x14	,x13	,256	,2002, 	2003);
 	TEST_BRANCH_NT(68,	bge	,	x16	,x15	,x14	,256	,-2003, -150);
	#  test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(69,	bge	,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_T(70,	bge	,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_T(71,	bge	,	x19	,x18	,x17	,256	,1050	,1050);
	TEST_BRANCH_T(72,	bge	,	x20	,x19	,x18	,256	,-700,	-700);
	TEST_BRANCH_T(73,	bge	,	x21	,x20	,x19	,256	,-100,	-100);
 	TEST_BRANCH_T(74,	bge	,	x22	,x21	,x20	,256	,-100,	-150);
	TEST_BRANCH_T(75,	bge	,	x23	,x22	,x21	,256	,440,	44);
	TEST_BRANCH_T(76,	bge	,	x24	,x23	,x22	,256	,25,	13);
	TEST_BRANCH_T(77,	bge	,	x25	,x24	,x23	,256	,-10,	-512);
	TEST_BRANCH_T(78,	bge	,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_T(79,	bge	,	x27	,x26	,x25	,256	,0	,	-150);
 	TEST_BRANCH_T(80,	bge	,	x28	,x27	,x26	,256	,500,	55);
	TEST_BRANCH_T(81,	bge	,	x29	,x28	,x27	,256	,-505,	-505);	

# ---------------------------------------------------
# BGEU Instruction
	# test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(82,	bgeu,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_NT(83,	bgeu,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_NT(84,	bgeu,	x5	,x4		,x3		,256	,3, 	40);
	TEST_BRANCH_NT(85,	bgeu,	x6	,x5		,x4		,256	,715, 	-20);
	TEST_BRANCH_NT(86,	bgeu,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_NT(87,	bgeu,	x8	,x7		,x6		,256	,29, 	-77);
	TEST_BRANCH_NT(88,	bgeu,	x9	,x8		,x7		,256	,2001, 	-171);
 	TEST_BRANCH_NT(89,	bgeu,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_NT(90,	bgeu,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_NT(91,	bgeu,	x12	,x11	,x10	,256	,41, 	-18);
	TEST_BRANCH_NT(92,	bgeu,	x13	,x12	,x11	,256	,0, 	-56);
	TEST_BRANCH_NT(93,	bgeu,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_NT(94,	bgeu,	x15	,x14	,x13	,256	,2002, 	2003);
 	TEST_BRANCH_NT(95,	bgeu,	x16	,x15	,x14	,256	,-2003, -150);
	#  test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(96,	bgeu,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_T(97,	bgeu,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_T(98,	bgeu,	x19	,x18	,x17	,256	,1050	,1050);
	TEST_BRANCH_T(99,	bgeu,	x20	,x19	,x18	,256	,-700,	-700);
	TEST_BRANCH_T(100,	bgeu,	x21	,x20	,x19	,256	,-100,	-100);
 	TEST_BRANCH_T(101,	bgeu,	x22	,x21	,x20	,256	,-100,	-150);
	TEST_BRANCH_T(102,	bgeu,	x23	,x22	,x21	,256	,440,	44);
	TEST_BRANCH_T(103,	bgeu,	x24	,x23	,x22	,256	,25,	13);
	TEST_BRANCH_T(104,	bgeu,	x25	,x24	,x23	,256	,-10,	-512);
	TEST_BRANCH_T(105,	bgeu,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_T(106,	bgeu,	x27	,x26	,x25	,256	,-150	,0);
 	TEST_BRANCH_T(107,	bgeu,	x28	,x27	,x26	,256	,500,	55);
	TEST_BRANCH_T(108,	bgeu,	x29	,x28	,x27	,256	,-505,	-505);

# ---------------------------------------------------
# BLT Instruction
	# test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(109,	blt	,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_T(110,	blt	,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_T(111,	blt	,	x5	,x4		,x3		,256	,3, 	40);
	TEST_BRANCH_T(112,	blt	,	x6	,x5		,x4		,256	,-20, 	715);
	TEST_BRANCH_T(113,	blt	,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_T(114,	blt	,	x8	,x7		,x6		,256	,-77, 	29);
	TEST_BRANCH_T(115,	blt	,	x9	,x8		,x7		,256	,-717, 	2001);
 	TEST_BRANCH_T(116,	blt	,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_T(117,	blt	,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_T(118,	blt	,	x12	,x11	,x10	,256	,-18, 	41);
	TEST_BRANCH_T(119,	blt	,	x13	,x12	,x11	,256	,-56, 	0);
	TEST_BRANCH_T(120,	blt	,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_T(121,	blt	,	x15	,x14	,x13	,256	,2002, 	2003);
 	TEST_BRANCH_T(122,	blt	,	x16	,x15	,x14	,256	,-2003, -150);
	#  test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(123,	blt	,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_NT(124,	blt	,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_NT(125,	blt	,	x19	,x18	,x17	,256	,1050	,1050);
	TEST_BRANCH_NT(126,	blt	,	x20	,x19	,x18	,256	,-700,	-700);
	TEST_BRANCH_NT(127,	blt	,	x21	,x20	,x19	,256	,-100,	-100);
 	TEST_BRANCH_NT(128,	blt	,	x22	,x21	,x20	,256	,-100,	-150);
	TEST_BRANCH_NT(129,	blt	,	x23	,x22	,x21	,256	,440,	44);
	TEST_BRANCH_NT(130,	blt	,	x24	,x23	,x22	,256	,25,	13);
	TEST_BRANCH_NT(131,	blt	,	x25	,x24	,x23	,256	,-10,	-512);
	TEST_BRANCH_NT(132,	blt	,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_NT(133,	blt	,	x27	,x26	,x25	,256	,0	,	-150);
 	TEST_BRANCH_NT(134,	blt	,	x28	,x27	,x26	,256	,500,	55);
	TEST_BRANCH_NT(135,	blt	,	x29	,x28	,x27	,256	,-505,	-505);	

# ---------------------------------------------------
# BLTU Instruction
	# test taken
	# TEST_BRANCH_T(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_T(136,	bltu,	x3	,x2		,x1		,256	,5, 	7);
 	TEST_BRANCH_T(137,	bltu,	x4	,x3		,x2		,256	,9, 	15);
	TEST_BRANCH_T(138,	bltu,	x5	,x4		,x3		,256	,3, 	40);
	TEST_BRANCH_T(139,	bltu,	x6	,x5		,x4		,256	,715, 	-20);
	TEST_BRANCH_T(140,	bltu,	x7	,x6		,x5		,256	,812, 	1020);
	TEST_BRANCH_T(141,	bltu,	x8	,x7		,x6		,256	,29, 	-77);
	TEST_BRANCH_T(142,	bltu,	x9	,x8		,x7		,256	,2001, 	-171);
 	TEST_BRANCH_T(143,	bltu,	x10	,x9		,x8		,256	,8, 	17);
	TEST_BRANCH_T(144,	bltu,	x11	,x10	,x9		,256	,98, 	101);
	TEST_BRANCH_T(145,	bltu,	x12	,x11	,x10	,256	,41, 	-18);
	TEST_BRANCH_T(146,	bltu,	x13	,x12	,x11	,256	,0, 	-56);
	TEST_BRANCH_T(147,	bltu,	x14	,x13	,x12	,256	,-218, 	-8);
	TEST_BRANCH_T(148,	bltu,	x15	,x14	,x13	,256	,2002, 	2003);
 	TEST_BRANCH_T(149,	bltu,	x16	,x15	,x14	,256	,-2003, -150);
	#  test not taken
	# TEST_BRANCH_NT(testnum , inst , rd , rs1 , rs2 , result , val1 , val2)
	TEST_BRANCH_NT(150,	bltu,	x17	,x16	,x15	,256	,0	,	0);
	TEST_BRANCH_NT(151,	bltu,	x18	,x17	,x16	,256	,10	,	10);
	TEST_BRANCH_NT(152,	bltu,	x19	,x18	,x17	,256	,1050	,1050);
	TEST_BRANCH_NT(153,	bltu,	x20	,x19	,x18	,256	,-700,	-700);
	TEST_BRANCH_NT(154,	bltu,	x21	,x20	,x19	,256	,-100,	-100);
 	TEST_BRANCH_NT(155,	bltu,	x22	,x21	,x20	,256	,-100,	-150);
	TEST_BRANCH_NT(156,	bltu,	x23	,x22	,x21	,256	,440,	44);
	TEST_BRANCH_NT(157,	bltu,	x24	,x23	,x22	,256	,25,	13);
	TEST_BRANCH_NT(158,	bltu,	x25	,x24	,x23	,256	,-10,	-512);
	TEST_BRANCH_NT(159,	bltu,	x26	,x25	,x24	,256	,-1	,	-1);
	TEST_BRANCH_NT(160,	bltu,	x27	,x26	,x25	,256	,-150	,0);
 	TEST_BRANCH_NT(161,	bltu,	x28	,x27	,x26	,256	,500,	55);
	TEST_BRANCH_NT(162,	bltu,	x29	,x28	,x27	,256	,-505,	-505);

#---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data

