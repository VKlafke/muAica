#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.section .text,"ax"
_r2imm_s_:

# ---------------------------------------------------
# ADDI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(1,  addi, x1,  x30, 	12,		5, 		7);
	TEST_R2IMM_OP(2,  addi, x2,  x1,  	24,		9, 		15);
	TEST_R2IMM_OP(3,  addi, x3,  x2,  	43,		40, 	3);
	TEST_R2IMM_OP(4,  addi, x4,  x3,  	695,	-20, 	715);
	TEST_R2IMM_OP(5,  addi, x5,  x4,  	1832,	812, 	1020);
	TEST_R2IMM_OP(6,  addi, x6,  x5,  	-48,	29, 	-77);
	TEST_R2IMM_OP(7,  addi, x7,  x6,  	1284,	2001, 	-717);
	TEST_R2IMM_OP(8,  addi, x8,  x7,  	25,		8, 		17);
	TEST_R2IMM_OP(9,  addi, x9,  x8,  	199,	98, 	101);
	TEST_R2IMM_OP(10, addi, x10, x9,  	23,		-18, 	41);
	TEST_R2IMM_OP(11, addi, x11, x10, 	-49,	-56, 	7);
	TEST_R2IMM_OP(12, addi, x12, x11, 	16,		8, 		8);
	TEST_R2IMM_OP(13, addi, x13, x12, 	4006,	2003, 	2003);
	TEST_R2IMM_OP(14, addi, x14, x13, 	-4006,	-2003, 	-2003);
	TEST_R2IMM_OP(15, addi, x15, x14, 	12,		5, 		7);
	TEST_R2IMM_OP(16, addi, x16, x15, 	24,		9, 		15);
	TEST_R2IMM_OP(17, addi, x17, x16, 	43,		40, 	3);
	TEST_R2IMM_OP(18, addi, x18, x17, 	695,	-20, 	715);
	TEST_R2IMM_OP(19, addi, x19, x18, 	1832,	812, 	1020);
	TEST_R2IMM_OP(20, addi, x20, x19, 	-48,	29, 	-77);
	TEST_R2IMM_OP(21, addi, x21, x20, 	1284,	2001, 	-717);
	TEST_R2IMM_OP(22, addi, x22, x21, 	25,		8, 		17);
	TEST_R2IMM_OP(23, addi, x23, x22, 	199,	98, 	101);
	TEST_R2IMM_OP(24, addi, x24, x23, 	23,		-18, 	41);
	TEST_R2IMM_OP(25, addi, x25, x24, 	-49,	-56, 	7);
	TEST_R2IMM_OP(26, addi, x26, x25, 	16,		8, 		8);
	TEST_R2IMM_OP(27, addi, x27, x26, 	4006,	2003, 	2003);
	TEST_R2IMM_OP(28, addi, x28, x27, 	-4006,	-2003, 	-2003);
	TEST_R2IMM_OP(29, addi, x29, x28, 	3,		1, 		2);

# ---------------------------------------------------
# LUI INSTRUCTION	
	# TEST_LUI_OP(testnum , inst , rd , result , val1 , imm)
	TEST_LUI_OP(30,  lui, x1, 0x00001000,	1,		0x00001);
	TEST_LUI_OP(31,  lui, x2, 0x00011000,	11,		0x00011);
	TEST_LUI_OP(32,  lui, x3, 0x00002000,	2,		0x00002);
	TEST_LUI_OP(33,  lui, x4, 0x00003000,	3,		0x00003);
	TEST_LUI_OP(34,  lui, x5, 0x00004000,	4,		0x00004);
	TEST_LUI_OP(35,  lui, x6, 0x00005000,	5,		0x00005);
	TEST_LUI_OP(36,  lui, x7, 0x00006000,	6,		0x00006);
	TEST_LUI_OP(37,  lui, x8, 0x00007000,	7,		0x00007);
	TEST_LUI_OP(38,  lui, x9, 0xFE080000,	80,		0xFE080);
	TEST_LUI_OP(39, lui, x10, 0x00009000,	9, 		0x00009);
	TEST_LUI_OP(40, lui, x11, 0xFE081000,	81,		0xFE081);
	TEST_LUI_OP(41, lui, x12, 0x0000B000,	2, 		0x0000B);
	TEST_LUI_OP(42, lui, x13, 0x0000C000,	5, 		0x0000C);
	TEST_LUI_OP(43, lui, x14, 0x0000D000,	97,		0x0000D);
	TEST_LUI_OP(44, lui, x15, 0xFFFFE000,	11,		0xFFFFE);
	TEST_LUI_OP(45, lui, x16, 0x00001000,	0,		0x00001);
	TEST_LUI_OP(46, lui, x17, 0x00011000,	0,		0x00011);
	TEST_LUI_OP(47, lui, x18, 0x00002000,	0,		0x00002);
	TEST_LUI_OP(48, lui, x19, 0x00003000,	0,		0x00003);
	TEST_LUI_OP(49, lui, x20, 0x00004000,	0,		0x00004);
	TEST_LUI_OP(50, lui, x21, 0x00005000,	0,		0x00005);
	TEST_LUI_OP(51, lui, x22, 0x00006000,	0,		0x00006);
	TEST_LUI_OP(52, lui, x23, 0x00007000,	0,		0x00007);
	TEST_LUI_OP(53, lui, x24, 0xFE080000,	0,		0xFE080);
	TEST_LUI_OP(54, lui, x25, 0x00009000,	0,		0x00009);
	TEST_LUI_OP(55, lui, x26, 0xFE081000,	0,		0xFE081);
	TEST_LUI_OP(56, lui, x27, 0x0000B000,	0,		0x0000B);
	TEST_LUI_OP(57, lui, x28, 0x0000C000,	0,		0x0000C);
	TEST_LUI_OP(58, lui, x29, 0x0000D000,	0,		0x0000D);

# ---------------------------------------------------
# AUIPC INSTRUCTION	
# note: depends on SUB
	# TEST_AUIPC_OP( testnum , inst , rd , rs1 , imm , immauipc)
	TEST_AUIPC_OP(59,  auipc, x1,  x31, 0x00001000,	0x00001);
	TEST_AUIPC_OP(60,  auipc, x2,  x1,  0x00011000,	0x00011);
	TEST_AUIPC_OP(61,  auipc, x3,  x2,  0x00002000,	0x00002);
	TEST_AUIPC_OP(62,  auipc, x4,  x3,  0x00003000,	0x00003);
	TEST_AUIPC_OP(63,  auipc, x5,  x4,  0x00004000,	0x00004);
	TEST_AUIPC_OP(64,  auipc, x6,  x5,  0x00005000,	0x00005);
	TEST_AUIPC_OP(65,  auipc, x7,  x6,  0x00006000,	0x00006);
	TEST_AUIPC_OP(66,  auipc, x8,  x7,  0x00007000,	0x00007);
	TEST_AUIPC_OP(67,  auipc, x9,  x8,  0xFE080000,	0xFE080);
	TEST_AUIPC_OP(68, auipc, x10, x9,  	0x00009000,	0x00009);
	TEST_AUIPC_OP(69, auipc, x11, x10, 	0xFE081000,	0xFE081);
	TEST_AUIPC_OP(70, auipc, x12, x11, 	0x0000B000,	0x0000B);
	TEST_AUIPC_OP(71, auipc, x13, x12, 	0x0000C000,	0x0000C);
	TEST_AUIPC_OP(72, auipc, x14, x13, 	0x0000D000,	0x0000D);
	TEST_AUIPC_OP(73, auipc, x15, x14, 	0xFFFFE000,	0xFFFFE);
	TEST_AUIPC_OP(74, auipc, x16, x15, 	0x00001000,	0x00001);
	TEST_AUIPC_OP(75, auipc, x17, x16, 	0x00011000,	0x00011);
	TEST_AUIPC_OP(76, auipc, x18, x17, 	0x00002000,	0x00002);
	TEST_AUIPC_OP(77, auipc, x19, x18, 	0x00003000,	0x00003);
	TEST_AUIPC_OP(78, auipc, x20, x19, 	0x00004000,	0x00004);
	TEST_AUIPC_OP(79, auipc, x21, x20, 	0x00005000,	0x00005);
	TEST_AUIPC_OP(80, auipc, x22, x21, 	0x00006000,	0x00006);
	TEST_AUIPC_OP(81, auipc, x23, x22, 	0x00007000,	0x00007);
	TEST_AUIPC_OP(82, auipc, x24, x23, 	0xFE080000,	0xFE080);
	TEST_AUIPC_OP(83, auipc, x25, x24, 	0x00009000,	0x00009);
	TEST_AUIPC_OP(84, auipc, x26, x25, 	0xFE081000,	0xFE081);
	TEST_AUIPC_OP(85, auipc, x27, x26, 	0x0000B000,	0x0000B);
	TEST_AUIPC_OP(86, auipc, x28, x27, 	0x0000C000,	0x0000C);
	TEST_AUIPC_OP(87, auipc, x29, x28, 	0x0000D000,	0x0000D);

# ---------------------------------------------------
# ORI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(88,  ori, x1,  x30, 0x0000008A, 0x00000080, 0x0000000A);
	TEST_R2IMM_OP(89,  ori, x2,  x1,  0x000008A0, 0x00000800, 0x000000A0);
	TEST_R2IMM_OP(90,  ori, x3,  x2,  0xfffffA00, 0x00000000, 0xfffffA00);
	TEST_R2IMM_OP(91,  ori, x4,  x3,  0xffffff09, 0x00000909, 0xffffff00);
	TEST_R2IMM_OP(92,  ori, x5,  x4,  0x0000090f, 0x00000909, 0x0000000f);
	TEST_R2IMM_OP(93,  ori, x6,  x5,  0x000009f9, 0x00000909, 0x000000f0);
	TEST_R2IMM_OP(94,  ori, x7,  x6,  0x00000fff, 0x00000fff, 0x00000000);
	TEST_R2IMM_OP(95,  ori, x8,  x7,  0xffffffff, 0x00000000, 0xffffffff);
	TEST_R2IMM_OP(96,  ori, x9,  x8,  0x00000111, 0x00000010, 0x00000101);
	TEST_R2IMM_OP(97, ori, x10, x9,  0x00000222, 0x00000020, 0x00000202);
	TEST_R2IMM_OP(98, ori, x11, x10, 0x00000333, 0x00000303, 0x00000030);
	TEST_R2IMM_OP(99, ori, x12, x11, 0x00000444, 0x00000404, 0x00000040);
	TEST_R2IMM_OP(100, ori, x13, x12, 0x00000555, 0x00000141, 0x00000414);
	TEST_R2IMM_OP(101, ori, x14, x13, 0x00000777, 0x00000000, 0x00000777);
	TEST_R2IMM_OP(102, ori, x15, x14, 0x00000000, 0x00000000, 0x00000000);
	TEST_R2IMM_OP(103, ori, x16, x15, 0x0000008A, 0x00000080, 0x0000000A);
	TEST_R2IMM_OP(104, ori, x17, x16, 0x000008A0, 0x00000800, 0x000000A0);
	TEST_R2IMM_OP(105, ori, x18, x17, 0xfffffA00, 0x00000000, 0xfffffA00);
	TEST_R2IMM_OP(106, ori, x19, x18, 0xffffff09, 0x00000909, 0xffffff00);
	TEST_R2IMM_OP(107, ori, x20, x19, 0x0000090f, 0x00000909, 0x0000000f);
	TEST_R2IMM_OP(108, ori, x21, x20, 0x000009f9, 0x00000909, 0x000000f0);
	TEST_R2IMM_OP(109, ori, x22, x21, 0x00000fff, 0x00000fff, 0x00000000);
	TEST_R2IMM_OP(110, ori, x23, x22, 0xffffffff, 0x00000000, 0xffffffff);
	TEST_R2IMM_OP(111, ori, x24, x23, 0x00000111, 0x00000010, 0x00000101);
	TEST_R2IMM_OP(112, ori, x25, x24, 0x00000222, 0x00000020, 0x00000202);
	TEST_R2IMM_OP(113, ori, x26, x25, 0x00000333, 0x00000303, 0x00000030);
	TEST_R2IMM_OP(114, ori, x27, x26, 0x00000444, 0x00000404, 0x00000040);
	TEST_R2IMM_OP(115, ori, x28, x27, 0x00000555, 0x00000141, 0x00000414);
	TEST_R2IMM_OP(116, ori, x29, x28, 0x00000777, 0x00000000, 0x00000777);

# ---------------------------------------------------
# ANDI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(117,  andi, x1,  x30, 0xffffff75, 0xffffff7f, 0xfffffff5);
	TEST_R2IMM_OP(118,  andi, x2,  x1,  0xfffff75f, 0xfffff7ff, 0xffffff5f);
	TEST_R2IMM_OP(119,  andi, x3,  x2,  0x000005ff, 0xffffffff, 0x000005ff);
	TEST_R2IMM_OP(120,  andi, x4,  x3,  0xffffffff, 0xffffffff, 0xffffffff);
	TEST_R2IMM_OP(121,  andi, x5,  x4,  0xfffff0ff, 0xfffff0ff, 0xffffffff);
	TEST_R2IMM_OP(122,  andi, x6,  x5,  0xffffff0f, 0xffffff0f, 0xffffffff);
	TEST_R2IMM_OP(123,  andi, x7,  x6,  0xffffffff, 0xffffffff, 0xffffffff);
	TEST_R2IMM_OP(124,  andi, x8,  x7,  0xfffff0f0, 0xfffff0ff, 0xfffffff0);
	TEST_R2IMM_OP(125,  andi, x9,  x8,  0x00000000, 0xfffff010, 0x00000101);
	TEST_R2IMM_OP(126, andi, x10, x9,  0x00000000, 0xfffff020, 0x00000202);
	TEST_R2IMM_OP(127, andi, x11, x10, 0x00000000, 0xfffff303, 0x00000030);
	TEST_R2IMM_OP(128, andi, x12, x11, 0x00000303, 0xffffff0f, 0x00000303);
	TEST_R2IMM_OP(129, andi, x13, x12, 0xfffff000, 0xfffff000, 0xffffffff);
	TEST_R2IMM_OP(130, andi, x14, x13, 0x00000131, 0xfffff1f1, 0x00000333);
	TEST_R2IMM_OP(131, andi, x15, x14, 0x00000000, 0xfffff000, 0x00000000);
	TEST_R2IMM_OP(132, andi, x16, x15, 0xffffff75, 0xffffff7f, 0xfffffff5);
	TEST_R2IMM_OP(133, andi, x17, x16, 0xfffff75f, 0xfffff7ff, 0xffffff5f);
	TEST_R2IMM_OP(134, andi, x18, x17, 0x000005ff, 0xffffffff, 0x000005ff);
	TEST_R2IMM_OP(135, andi, x19, x18, 0xffffffff, 0xffffffff, 0xffffffff);
	TEST_R2IMM_OP(136, andi, x20, x19, 0xfffff0ff, 0xfffff0ff, 0xffffffff);
	TEST_R2IMM_OP(137, andi, x21, x20, 0xffffff0f, 0xffffff0f, 0xffffffff);
	TEST_R2IMM_OP(138, andi, x22, x21, 0xffffffff, 0xffffffff, 0xffffffff);
	TEST_R2IMM_OP(139, andi, x23, x22, 0xfffff0f0, 0xfffff0ff, 0xfffffff0);
	TEST_R2IMM_OP(140, andi, x24, x23, 0x00000000, 0xfffff010, 0x00000101);
	TEST_R2IMM_OP(141, andi, x25, x24, 0x00000000, 0xfffff020, 0x00000202);
	TEST_R2IMM_OP(142, andi, x26, x25, 0x00000000, 0xfffff303, 0x00000030);
	TEST_R2IMM_OP(143, andi, x27, x26, 0x00000303, 0xffffff0f, 0x00000303);
	TEST_R2IMM_OP(144, andi, x28, x27, 0xfffff000, 0xfffff000, 0xffffffff);
	TEST_R2IMM_OP(145, andi, x29, x28, 0x00000131, 0xfffff1f1, 0x00000333);

# ---------------------------------------------------
# XORI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
  	TEST_R2IMM_OP(146,  xori, x1,  x30, 0xfffff00A, 0xfffff000, 0x0000000A);
	TEST_R2IMM_OP(147,  xori, x2,  x1,  0xfffff0A0, 0xfffff000, 0x000000A0);
	TEST_R2IMM_OP(148,  xori, x3,  x2,  0xfffffA00, 0x00000000, 0xfffffA00);
	TEST_R2IMM_OP(149,  xori, x4,  x3,  0xfffff003, 0x00000A00, 0xfffffA03);
	TEST_R2IMM_OP(150,  xori, x5,  x4,  0xfffff030, 0x00000A00, 0xfffffA30);
	TEST_R2IMM_OP(151,  xori, x6,  x5,  0xfffff030, 0xfffff03A, 0x0000000A);
	TEST_R2IMM_OP(152,  xori, x7,  x6,  0xfffffABC, 0x000000B0, 0xfffffA0C);
	TEST_R2IMM_OP(153,  xori, x8,  x7,  0xfffffABC, 0xfffffA0C, 0x000000B0);
	TEST_R2IMM_OP(154,  xori, x9,  x8,  0xfffff111, 0xfffff010, 0x00000101);
	TEST_R2IMM_OP(155, xori, x10, x9,  0xfffff222, 0xfffff020, 0x00000202);
	TEST_R2IMM_OP(156, xori, x11, x10, 0xfffff333, 0xfffff303, 0x00000030);
	TEST_R2IMM_OP(157, xori, x12, x11, 0xfffff444, 0xfffff404, 0x00000040);
	TEST_R2IMM_OP(158, xori, x13, x12, 0xfffff555, 0xfffff141, 0x00000414);
	TEST_R2IMM_OP(159, xori, x14, x13, 0xfffff555, 0xfffff000, 0x00000555);
	TEST_R2IMM_OP(160, xori, x15, x14, 0xfffff000, 0xfffff000, 0x00000000);
	TEST_R2IMM_OP(161, xori, x16, x15, 0xfffff00A, 0xfffff000, 0x0000000A);
	TEST_R2IMM_OP(162, xori, x17, x16, 0xfffff0A0, 0xfffff000, 0x000000A0);
	TEST_R2IMM_OP(163, xori, x18, x17, 0xfffffA00, 0x00000000, 0xfffffA00);
	TEST_R2IMM_OP(164, xori, x19, x18, 0xfffff003, 0x00000A00, 0xfffffA03);
	TEST_R2IMM_OP(165, xori, x20, x19, 0xfffff030, 0x00000A00, 0xfffffA30);
	TEST_R2IMM_OP(166, xori, x21, x20, 0xfffff030, 0xfffff03A, 0x0000000A);
	TEST_R2IMM_OP(167, xori, x22, x21, 0xfffffABC, 0x000000B0, 0xfffffA0C);
	TEST_R2IMM_OP(168, xori, x23, x22, 0xfffffABC, 0xfffffA0C, 0x000000B0);
	TEST_R2IMM_OP(169, xori, x24, x23, 0xfffff111, 0xfffff010, 0x00000101);
	TEST_R2IMM_OP(170, xori, x25, x24, 0xfffff222, 0xfffff020, 0x00000202);
	TEST_R2IMM_OP(171, xori, x26, x25, 0xfffff333, 0xfffff303, 0x00000030);
	TEST_R2IMM_OP(172, xori, x27, x26, 0xfffff444, 0xfffff404, 0x00000040);
	TEST_R2IMM_OP(173, xori, x28, x27, 0xfffff555, 0xfffff141, 0x00000414);
	TEST_R2IMM_OP(174, xori, x29, x28, 0xfffff555, 0xfffff000, 0x00000555);

# ---------------------------------------------------
# SLTI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(175,  slti, x1,  x30, 1,		5, 		7);
	TEST_R2IMM_OP(176,  slti, x2,  x1,  1,		9, 		15);
	TEST_R2IMM_OP(177,  slti, x3,  x2,  0,		40, 	3);
	TEST_R2IMM_OP(178,  slti, x4,  x3,  1,		-20, 	715);
	TEST_R2IMM_OP(179,  slti, x5,  x4,  1,		812, 	1020);
	TEST_R2IMM_OP(180,  slti, x6,  x5,  0,		29, 	-77);
	TEST_R2IMM_OP(181,  slti, x7,  x6,  0,		2001, 	-717);
	TEST_R2IMM_OP(182,  slti, x8,  x7,  1,		8, 		17);
	TEST_R2IMM_OP(183,  slti, x9,  x8,  1,		98, 	101);
	TEST_R2IMM_OP(184, slti, x10, x9,  1,		-18, 	41);
	TEST_R2IMM_OP(185, slti, x11, x10, 1,		-56, 	0);
	TEST_R2IMM_OP(186, slti, x12, x11, 1,		-218, 	-8);
	TEST_R2IMM_OP(187, slti, x13, x12, 0,		2003, 	2003);
	TEST_R2IMM_OP(188, slti, x14, x13, 0,		-2003, 	-2003);
	TEST_R2IMM_OP(189, slti, x15, x14, 0,		-415, 	-707);	
	TEST_R2IMM_OP(190, slti, x16, x15, 1,		5, 		7);
	TEST_R2IMM_OP(191, slti, x17, x16, 1,		9, 		15);
	TEST_R2IMM_OP(192, slti, x18, x17, 0,		40, 	3);
	TEST_R2IMM_OP(193, slti, x19, x18, 1,		-20, 	715);
	TEST_R2IMM_OP(194, slti, x20, x19, 1,		812, 	1020);
	TEST_R2IMM_OP(195, slti, x21, x20, 0,		29, 	-77);
	TEST_R2IMM_OP(196, slti, x22, x21, 0,		2001, 	-717);
	TEST_R2IMM_OP(197, slti, x23, x22, 1,		8, 		17);
	TEST_R2IMM_OP(198, slti, x24, x23, 1,		98, 	101);
	TEST_R2IMM_OP(199, slti, x25, x24, 1,		-18, 	41);
	TEST_R2IMM_OP(200, slti, x26, x25, 1,		-56, 	0);
	TEST_R2IMM_OP(201, slti, x27, x26, 1,		-218, 	-8);
	TEST_R2IMM_OP(202, slti, x28, x27, 0,		2003, 	2003);
	TEST_R2IMM_OP(203, slti, x29, x28, 0,		-2003, 	-2003);

# ---------------------------------------------------
# SLTIU INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(204,  sltiu, x1,  x30, 1,		5, 		7);
	TEST_R2IMM_OP(205,  sltiu, x2,  x1,  1,		9, 		15);
	TEST_R2IMM_OP(206,  sltiu, x3,  x2,  0,		40, 	3);
	TEST_R2IMM_OP(207,  sltiu, x4,  x3,  0,		-20, 	715);
	TEST_R2IMM_OP(208,  sltiu, x5,  x4,  1,		812, 	1020);
	TEST_R2IMM_OP(209,  sltiu, x6,  x5,  1,		29, 	-77);
	TEST_R2IMM_OP(210,  sltiu, x7,  x6,  1,		2001, 	-717);
	TEST_R2IMM_OP(211,  sltiu, x8,  x7,  1,		8, 		17);
	TEST_R2IMM_OP(212,  sltiu, x9,  x8,  1,		98, 	101);
	TEST_R2IMM_OP(213, sltiu, x10, x9,  0,		-18, 	41);
	TEST_R2IMM_OP(214, sltiu, x11, x10, 0,		-56, 	0);
	TEST_R2IMM_OP(215, sltiu, x12, x11, 1,		-218, 	-8);
	TEST_R2IMM_OP(216, sltiu, x13, x12, 0,		2003, 	2003);
	TEST_R2IMM_OP(217, sltiu, x14, x13, 0,		-2003, 	-2003);
	TEST_R2IMM_OP(218, sltiu, x15, x14, 0,		-1, 	0);
	TEST_R2IMM_OP(219, sltiu, x16, x15, 1,		5, 		7);
	TEST_R2IMM_OP(220, sltiu, x17, x16, 1,		9, 		15);
	TEST_R2IMM_OP(221, sltiu, x18, x17, 0,		40, 	3);
	TEST_R2IMM_OP(222, sltiu, x19, x18, 0,		-20, 	715);
	TEST_R2IMM_OP(223, sltiu, x20, x19, 1,		812, 	1020);
	TEST_R2IMM_OP(224, sltiu, x21, x20, 1,		29, 	-77);
	TEST_R2IMM_OP(225, sltiu, x22, x21, 1,		2001, 	-717);
	TEST_R2IMM_OP(226, sltiu, x23, x22, 1,		8, 		17);
	TEST_R2IMM_OP(227, sltiu, x24, x23, 1,		98, 	101);
	TEST_R2IMM_OP(228, sltiu, x25, x24, 0,		-18, 	41);
	TEST_R2IMM_OP(229, sltiu, x26, x25, 0,		-56, 	0);
	TEST_R2IMM_OP(230, sltiu, x27, x26, 1,		-218, 	-8);
	TEST_R2IMM_OP(231, sltiu, x28, x27, 0,		2003, 	2003);
	TEST_R2IMM_OP(232, sltiu, x29, x28, 0,		-2003, 	-2003);

# ---------------------------------------------------
# SLLI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(233,  slli, x1,  x30, 0x00000001, 0x00000001, 0  );
	TEST_R2IMM_OP(234,  slli, x2,  x1,  0x00000002, 0x00000001, 1  );
	TEST_R2IMM_OP(235,  slli, x3,  x2,  0x00000080, 0x00000001, 7  );
	TEST_R2IMM_OP(236,  slli, x4,  x3,  0x00004000, 0x00000001, 14 );
	TEST_R2IMM_OP(237,  slli, x5,  x4,  0x80000000, 0x00000001, 31 );
	TEST_R2IMM_OP(238,  slli, x6,  x5,  0xffffffff, 0xffffffff, 0  );
	TEST_R2IMM_OP(239,  slli, x7,  x6,  0xfffffffe, 0xffffffff, 1  );
	TEST_R2IMM_OP(240,  slli, x8,  x7,  0xffffff80, 0xffffffff, 7  );
	TEST_R2IMM_OP(241,  slli, x9,  x8,  0xffffc000, 0xffffffff, 14 );
	TEST_R2IMM_OP(242, slli, x10, x9,  0x80000000, 0xffffffff, 31 );
	TEST_R2IMM_OP(243, slli, x11, x10, 0x21212121, 0x21212121, 0  );
	TEST_R2IMM_OP(244, slli, x12, x11, 0x42424242, 0x21212121, 1  );
	TEST_R2IMM_OP(245, slli, x13, x12, 0x90909080, 0x21212121, 7  );
	TEST_R2IMM_OP(246, slli, x14, x13, 0x48484000, 0x21212121, 14 );
	TEST_R2IMM_OP(247, slli, x15, x14, 0x80000000, 0x21212121, 31 );
	TEST_R2IMM_OP(248, slli, x16, x15, 0x00000001, 0x00000001, 0  );
	TEST_R2IMM_OP(249, slli, x17, x16, 0x00000002, 0x00000001, 1  );
	TEST_R2IMM_OP(250, slli, x18, x17, 0x00000080, 0x00000001, 7  );
	TEST_R2IMM_OP(251, slli, x19, x18, 0x00004000, 0x00000001, 14 );
	TEST_R2IMM_OP(252, slli, x20, x19, 0x80000000, 0x00000001, 31 );
	TEST_R2IMM_OP(253, slli, x21, x20, 0xffffffff, 0xffffffff, 0  );
	TEST_R2IMM_OP(254, slli, x22, x21, 0xfffffffe, 0xffffffff, 1  );
	TEST_R2IMM_OP(255, slli, x23, x22, 0xffffff80, 0xffffffff, 7  );
	TEST_R2IMM_OP(256, slli, x24, x23, 0xffffc000, 0xffffffff, 14 );
	TEST_R2IMM_OP(257, slli, x25, x24, 0x80000000, 0xffffffff, 31 );
	TEST_R2IMM_OP(258, slli, x26, x25, 0x21212121, 0x21212121, 0  );
	TEST_R2IMM_OP(259, slli, x27, x26, 0x42424242, 0x21212121, 1  );
	TEST_R2IMM_OP(260, slli, x28, x27, 0x90909080, 0x21212121, 7  );
	TEST_R2IMM_OP(261, slli, x29, x28, 0x48484000, 0x21212121, 14 );

# ---------------------------------------------------
# SRLI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(262,  srli, x1,  x30, 0xffff8000, 0xffff8000, 0  );
	TEST_R2IMM_OP(263,  srli, x2,  x1,  0x7fffc000, 0xffff8000, 1  );
	TEST_R2IMM_OP(264,  srli, x3,  x2,  0x01ffff00, 0xffff8000, 7  );
	TEST_R2IMM_OP(265,  srli, x4,  x3,  0x0003fffe, 0xffff8000, 14 );
	TEST_R2IMM_OP(266,  srli, x5,  x4,  0x0001ffff, 0xffff8001, 15 );
	TEST_R2IMM_OP(267,  srli, x6,  x5,  0xffffffff, 0xffffffff, 0  );
	TEST_R2IMM_OP(268,  srli, x7,  x6,  0x7fffffff, 0xffffffff, 1  );
	TEST_R2IMM_OP(269,  srli, x8,  x7,  0x01ffffff, 0xffffffff, 7  );
	TEST_R2IMM_OP(270,  srli, x9,  x8,  0x0003ffff, 0xffffffff, 14 );
	TEST_R2IMM_OP(271, srli, x10, x9,  0x00000001, 0xffffffff, 31 );
	TEST_R2IMM_OP(272, srli, x11, x10, 0x21212121, 0x21212121, 0  );
	TEST_R2IMM_OP(273, srli, x12, x11, 0x10909090, 0x21212121, 1  );
	TEST_R2IMM_OP(274, srli, x13, x12, 0x00424242, 0x21212121, 7  );
	TEST_R2IMM_OP(275, srli, x14, x13, 0x00008484, 0x21212121, 14 );
	TEST_R2IMM_OP(276, srli, x15, x14, 0x00000000, 0x21212121, 31 );
	TEST_R2IMM_OP(277, srli, x16, x15, 0xffff8000, 0xffff8000, 0  );
	TEST_R2IMM_OP(278, srli, x17, x16, 0x7fffc000, 0xffff8000, 1  );
	TEST_R2IMM_OP(279, srli, x18, x17, 0x01ffff00, 0xffff8000, 7  );
	TEST_R2IMM_OP(280, srli, x19, x18, 0x0003fffe, 0xffff8000, 14 );
	TEST_R2IMM_OP(281, srli, x20, x19, 0x0001ffff, 0xffff8001, 15 );
	TEST_R2IMM_OP(282, srli, x21, x20, 0xffffffff, 0xffffffff, 0  );
	TEST_R2IMM_OP(283, srli, x22, x21, 0x7fffffff, 0xffffffff, 1  );
	TEST_R2IMM_OP(284, srli, x23, x22, 0x01ffffff, 0xffffffff, 7  );
	TEST_R2IMM_OP(285, srli, x24, x23, 0x0003ffff, 0xffffffff, 14 );
	TEST_R2IMM_OP(286, srli, x25, x24, 0x00000001, 0xffffffff, 31 );
	TEST_R2IMM_OP(287, srli, x26, x25, 0x21212121, 0x21212121, 0  );
	TEST_R2IMM_OP(288, srli, x27, x26, 0x10909090, 0x21212121, 1  );
	TEST_R2IMM_OP(289, srli, x28, x27, 0x00424242, 0x21212121, 7  );
	TEST_R2IMM_OP(290, srli, x29, x28, 0x00008484, 0x21212121, 14 );

# ---------------------------------------------------
# SRAI INSTRUCTION
	# TEST_R2IMM_OP(testnum , inst , rd , rs1 , result , val1 , imm)
	TEST_R2IMM_OP(291,  srai, x1,  x30, 0x80000000, 0x80000000, 0  );
	TEST_R2IMM_OP(292,  srai, x2,  x1,  0xc0000000, 0x80000000, 1  );
	TEST_R2IMM_OP(293,  srai, x3,  x2,  0xff000000, 0x80000000, 7  );
	TEST_R2IMM_OP(294,  srai, x4,  x3,  0xfffe0000, 0x80000000, 14 );
	TEST_R2IMM_OP(295,  srai, x5,  x4,  0xffffffff, 0x80000001, 31 );
	TEST_R2IMM_OP(296,  srai, x6,  x5,  0x7fffffff, 0x7fffffff, 0  );
	TEST_R2IMM_OP(297,  srai, x7,  x6,  0x3fffffff, 0x7fffffff, 1  );
	TEST_R2IMM_OP(298,  srai, x8,  x7,  0x00ffffff, 0x7fffffff, 7  );
	TEST_R2IMM_OP(299,  srai, x9,  x8,  0x0001ffff, 0x7fffffff, 14 );
	TEST_R2IMM_OP(300, srai, x10, x9,  0x00000000, 0x7fffffff, 31 );
	TEST_R2IMM_OP(301, srai, x11, x10, 0x81818181, 0x81818181, 0  );
	TEST_R2IMM_OP(302, srai, x12, x11, 0xc0c0c0c0, 0x81818181, 1  );
	TEST_R2IMM_OP(303, srai, x13, x12, 0xff030303, 0x81818181, 7  );
	TEST_R2IMM_OP(304, srai, x14, x13, 0xfffe0606, 0x81818181, 14 );
	TEST_R2IMM_OP(305, srai, x15, x14, 0xffffffff, 0x81818181, 31 );
	TEST_R2IMM_OP(306, srai, x16, x15, 0x80000000, 0x80000000, 0  );
	TEST_R2IMM_OP(307, srai, x17, x16, 0xc0000000, 0x80000000, 1  );
	TEST_R2IMM_OP(308, srai, x18, x17, 0xff000000, 0x80000000, 7  );
	TEST_R2IMM_OP(309, srai, x19, x18, 0xfffe0000, 0x80000000, 14 );
	TEST_R2IMM_OP(310, srai, x20, x19, 0xffffffff, 0x80000001, 31 );
	TEST_R2IMM_OP(311, srai, x21, x20, 0x7fffffff, 0x7fffffff, 0  );
	TEST_R2IMM_OP(312, srai, x22, x21, 0x3fffffff, 0x7fffffff, 1  );
	TEST_R2IMM_OP(313, srai, x23, x22, 0x00ffffff, 0x7fffffff, 7  );
	TEST_R2IMM_OP(314, srai, x24, x23, 0x0001ffff, 0x7fffffff, 14 );
	TEST_R2IMM_OP(315, srai, x25, x24, 0x00000000, 0x7fffffff, 31 );
	TEST_R2IMM_OP(316, srai, x26, x25, 0x81818181, 0x81818181, 0  );
	TEST_R2IMM_OP(317, srai, x27, x26, 0xc0c0c0c0, 0x81818181, 1  );
	TEST_R2IMM_OP(318, srai, x28, x27, 0xff030303, 0x81818181, 7  );
	TEST_R2IMM_OP(319, srai, x29, x28, 0xfffe0606, 0x81818181, 14 );

# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data
