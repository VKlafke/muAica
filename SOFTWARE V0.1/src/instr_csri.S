#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.section .text,"ax"
_csri_s_:

# CSRI Instr => instruction	rd, csr, rs1

# valid bits for mstatus: [7] and [3]
# valid bits for mie: [11] and [3]
# valid bits for mtvec: [31:0]
# valid bits for mepc: [31:2]
# valid bits for mcause: [31] and [3:0]

# ---------------------------------------------------
# CSRRWI INSTRUCTION
	# TEST_CSRI_OP(testnum , inst , reg, rd , rs1 , result)

	# --------------------------------
	# -- MSTATUS
	TEST_CSRI_OP(1,  csrrwi, mstatus,	x1,  30, 	0);
	TEST_CSRI_OP(2,  csrrwi, mstatus,	x2,  1,  	8);
	TEST_CSRI_OP(3,  csrrwi, mstatus,	x3,  2,  	0);
	TEST_CSRI_OP(4,  csrrwi, mstatus,	x4,  3,  	0);
	TEST_CSRI_OP(5,  csrrwi, mstatus,	x5,  4,  	0);
	TEST_CSRI_OP(6,  csrrwi, mstatus,	x6,  5,  	0);
	TEST_CSRI_OP(7,  csrrwi, mstatus,	x7,  6,  	0);
	TEST_CSRI_OP(8,  csrrwi, mstatus,	x8,  7,  	0);
	TEST_CSRI_OP(9,  csrrwi, mstatus,	x9,  8,  	0);
	TEST_CSRI_OP(10, csrrwi, mstatus,	x10, 9,  	8);
	TEST_CSRI_OP(11, csrrwi, mstatus,	x11, 10, 	8);
	TEST_CSRI_OP(12, csrrwi, mstatus,	x12, 11, 	8);
	TEST_CSRI_OP(13, csrrwi, mstatus,	x13, 12, 	8);
	TEST_CSRI_OP(14, csrrwi, mstatus,	x14, 13, 	8);
	TEST_CSRI_OP(15, csrrwi, mstatus,	x15, 14, 	8);
	#--
	TEST_CSRI_OP(16, csrrwi, mstatus,	x16, 15, 	8);
	TEST_CSRI_OP(17, csrrwi, mstatus,	x17, 16, 	8);
	TEST_CSRI_OP(18, csrrwi, mstatus,	x18, 17, 	0);
	TEST_CSRI_OP(19, csrrwi, mstatus,	x19, 18, 	0);
	TEST_CSRI_OP(20, csrrwi, mstatus,	x20, 19, 	0);
	TEST_CSRI_OP(21, csrrwi, mstatus,	x21, 20, 	0);
	TEST_CSRI_OP(22, csrrwi, mstatus,	x22, 21, 	0);
	TEST_CSRI_OP(23, csrrwi, mstatus,	x23, 22, 	0);
	TEST_CSRI_OP(24, csrrwi, mstatus,	x24, 23, 	0);
	TEST_CSRI_OP(25, csrrwi, mstatus,	x25, 24, 	0);
	TEST_CSRI_OP(26, csrrwi, mstatus,	x26, 25, 	8);
	TEST_CSRI_OP(27, csrrwi, mstatus,	x27, 26, 	8);
	TEST_CSRI_OP(28, csrrwi, mstatus,	x28, 27, 	8);
	TEST_CSRI_OP(29, csrrwi, mstatus,	x29, 28, 	8);

	# --------------------------------
	# -- MIE
	TEST_CSRI_OP(30, csrrwi, mie,	x1,  30, 	0);
	TEST_CSRI_OP(31, csrrwi, mie,	x2,  1,  	8);
	TEST_CSRI_OP(32, csrrwi, mie,	x3,  2,  	0);
	TEST_CSRI_OP(33, csrrwi, mie,	x4,  3,  	0);
	TEST_CSRI_OP(34, csrrwi, mie,	x5,  4,  	0);
	TEST_CSRI_OP(35, csrrwi, mie,	x6,  5,  	0);
	TEST_CSRI_OP(36, csrrwi, mie,	x7,  6,  	0);
	TEST_CSRI_OP(37, csrrwi, mie,	x8,  7,  	0);
	TEST_CSRI_OP(38, csrrwi, mie,	x9,  8,  	0);
	TEST_CSRI_OP(39, csrrwi, mie,	x10, 9,  	8);
	TEST_CSRI_OP(40, csrrwi, mie,	x11, 10, 	8);
	TEST_CSRI_OP(41, csrrwi, mie,	x12, 11, 	8);
	TEST_CSRI_OP(42, csrrwi, mie,	x13, 12, 	8);
	TEST_CSRI_OP(43, csrrwi, mie,	x14, 13, 	8);
	TEST_CSRI_OP(44, csrrwi, mie,	x15, 14, 	8);
	# --
	TEST_CSRI_OP(45, csrrwi, mie,	x16, 15, 	8);
	TEST_CSRI_OP(46, csrrwi, mie,	x17, 16, 	8);
	TEST_CSRI_OP(47, csrrwi, mie,	x18, 17, 	0);
	TEST_CSRI_OP(48, csrrwi, mie,	x19, 18, 	0);
	TEST_CSRI_OP(49, csrrwi, mie,	x20, 19, 	0);
	TEST_CSRI_OP(50, csrrwi, mie,	x21, 20, 	0);
	TEST_CSRI_OP(51, csrrwi, mie,	x22, 21, 	0);
	TEST_CSRI_OP(52, csrrwi, mie,	x23, 22, 	0);
	TEST_CSRI_OP(53, csrrwi, mie,	x24, 23, 	0);
	TEST_CSRI_OP(54, csrrwi, mie,	x25, 24, 	0);
	TEST_CSRI_OP(55, csrrwi, mie,	x26, 25, 	8);
	TEST_CSRI_OP(56, csrrwi, mie,	x27, 26, 	8);
	TEST_CSRI_OP(57, csrrwi, mie,	x28, 27, 	8);
	TEST_CSRI_OP(58, csrrwi, mie,	x29, 28, 	8);

	# --------------------------------
	# -- MTVEC
	TEST_CSRI_OP(59, csrrwi, mtvec,	x1,  30, 	0);
	TEST_CSRI_OP(60, csrrwi, mtvec,	x2,  1,  	30);
	TEST_CSRI_OP(61, csrrwi, mtvec,	x3,  2,  	1);
	TEST_CSRI_OP(62, csrrwi, mtvec,	x4,  3,  	2);
	TEST_CSRI_OP(63, csrrwi, mtvec,	x5,  4,  	3);
	TEST_CSRI_OP(64, csrrwi, mtvec,	x6,  5,  	4);
	TEST_CSRI_OP(65, csrrwi, mtvec,	x7,  6,  	5);
	TEST_CSRI_OP(66, csrrwi, mtvec,	x8,  7,  	6);
	TEST_CSRI_OP(67, csrrwi, mtvec,	x9,  8,  	7);
	TEST_CSRI_OP(68, csrrwi, mtvec,	x10, 9,  	8);
	TEST_CSRI_OP(69, csrrwi, mtvec,	x11, 10, 	9);
	TEST_CSRI_OP(70, csrrwi, mtvec,	x12, 11, 	10);
	TEST_CSRI_OP(71, csrrwi, mtvec,	x13, 12, 	11);
	TEST_CSRI_OP(72, csrrwi, mtvec,	x14, 13, 	12);
	TEST_CSRI_OP(73, csrrwi, mtvec,	x15, 14, 	13);
	# --
	TEST_CSRI_OP(74, csrrwi, mtvec,	x16, 15, 	14);
	TEST_CSRI_OP(75, csrrwi, mtvec,	x17, 16, 	15);
	TEST_CSRI_OP(76, csrrwi, mtvec,	x18, 17, 	16);
	TEST_CSRI_OP(77, csrrwi, mtvec,	x19, 18, 	17);
	TEST_CSRI_OP(78, csrrwi, mtvec,	x20, 19, 	18);
	TEST_CSRI_OP(79, csrrwi, mtvec,	x21, 20, 	19);
	TEST_CSRI_OP(80, csrrwi, mtvec,	x22, 21, 	20);
	TEST_CSRI_OP(81, csrrwi, mtvec,	x23, 22, 	21);
	TEST_CSRI_OP(82, csrrwi, mtvec,	x24, 23, 	22);
	TEST_CSRI_OP(83, csrrwi, mtvec,	x25, 24, 	23);
	TEST_CSRI_OP(84, csrrwi, mtvec,	x26, 25, 	24);
	TEST_CSRI_OP(85, csrrwi, mtvec,	x27, 26, 	25);
	TEST_CSRI_OP(86, csrrwi, mtvec,	x28, 27, 	26);
	TEST_CSRI_OP(87, csrrwi, mtvec,	x29, 28, 	27);

	# --------------------------------
	# -- MEPC
	TEST_CSRI_OP(88, csrrwi, mepc,	x1,  30, 	0);
	TEST_CSRI_OP(89, csrrwi, mepc,	x2,  1,  	28);
	TEST_CSRI_OP(90, csrrwi, mepc,	x3,  2,  	0);
	TEST_CSRI_OP(91, csrrwi, mepc,	x4,  3,  	0);
	TEST_CSRI_OP(92, csrrwi, mepc,	x5,  4,  	0);
	TEST_CSRI_OP(93, csrrwi, mepc,	x6,  5,  	4);
	TEST_CSRI_OP(94, csrrwi, mepc,	x7,  6,  	4);
	TEST_CSRI_OP(95, csrrwi, mepc,	x8,  7,  	4);
	TEST_CSRI_OP(96, csrrwi, mepc,	x9,  8,  	4);
	TEST_CSRI_OP(97, csrrwi, mepc,	x10, 9,  	8);
	TEST_CSRI_OP(98, csrrwi, mepc,	x11, 10, 	8);
	TEST_CSRI_OP(99, csrrwi, mepc,	x12, 11, 	8);
	TEST_CSRI_OP(100, csrrwi, mepc,	x13, 12, 	8);
	TEST_CSRI_OP(101, csrrwi, mepc,	x14, 13, 	12);
	TEST_CSRI_OP(102, csrrwi, mepc,	x15, 14, 	12);
	# --
	TEST_CSRI_OP(103, csrrwi, mepc,	x16, 15, 	12);
	TEST_CSRI_OP(104, csrrwi, mepc,	x17, 16, 	12);
	TEST_CSRI_OP(105, csrrwi, mepc,	x18, 17, 	16);
	TEST_CSRI_OP(106, csrrwi, mepc,	x19, 18, 	16);
	TEST_CSRI_OP(107, csrrwi, mepc,	x20, 19, 	16);
	TEST_CSRI_OP(108, csrrwi, mepc,	x21, 20, 	16);
	TEST_CSRI_OP(109, csrrwi, mepc,	x22, 21, 	20);
	TEST_CSRI_OP(110, csrrwi, mepc,	x23, 22, 	20);
	TEST_CSRI_OP(111, csrrwi, mepc,	x24, 23, 	20);
	TEST_CSRI_OP(112, csrrwi, mepc,	x25, 24, 	20);
	TEST_CSRI_OP(113, csrrwi, mepc,	x26, 25, 	24);
	TEST_CSRI_OP(114, csrrwi, mepc,	x27, 26, 	24);
	TEST_CSRI_OP(115, csrrwi, mepc,	x28, 27, 	24);
	TEST_CSRI_OP(116, csrrwi, mepc,	x29, 28, 	24);

	# --------------------------------
	# -- MCAUSE
	TEST_CSRI_OP(117, csrrwi, mcause,	x1,  30, 	0);
	TEST_CSRI_OP(118, csrrwi, mcause,	x2,  1,  	14);
	TEST_CSRI_OP(119, csrrwi, mcause,	x3,  2,  	1);
	TEST_CSRI_OP(120, csrrwi, mcause,	x4,  3,  	2);
	TEST_CSRI_OP(121, csrrwi, mcause,	x5,  4,  	3);
	TEST_CSRI_OP(122, csrrwi, mcause,	x6,  5,  	4);
	TEST_CSRI_OP(123, csrrwi, mcause,	x7,  6,  	5);
	TEST_CSRI_OP(124, csrrwi, mcause,	x8,  7,  	6);
	TEST_CSRI_OP(125, csrrwi, mcause,	x9,  8,  	7);
	TEST_CSRI_OP(126, csrrwi, mcause,	x10, 9,  	8);
	TEST_CSRI_OP(127, csrrwi, mcause,	x11, 10, 	9);
	TEST_CSRI_OP(128, csrrwi, mcause,	x12, 11, 	10);
	TEST_CSRI_OP(129, csrrwi, mcause,	x13, 12, 	11);
	TEST_CSRI_OP(130, csrrwi, mcause,	x14, 13, 	12);
	TEST_CSRI_OP(131, csrrwi, mcause,	x15, 14, 	13);
	# --
	TEST_CSRI_OP(132, csrrwi, mcause,	x16, 15, 	14);
	TEST_CSRI_OP(133, csrrwi, mcause,	x17, 16, 	15);
	TEST_CSRI_OP(134, csrrwi, mcause,	x18, 17, 	0);
	TEST_CSRI_OP(135, csrrwi, mcause,	x19, 18, 	1);
	TEST_CSRI_OP(136, csrrwi, mcause,	x20, 19, 	2);
	TEST_CSRI_OP(137, csrrwi, mcause,	x21, 20, 	3);
	TEST_CSRI_OP(138, csrrwi, mcause,	x22, 21, 	4);
	TEST_CSRI_OP(139, csrrwi, mcause,	x23, 22, 	5);
	TEST_CSRI_OP(140, csrrwi, mcause,	x24, 23, 	6);
	TEST_CSRI_OP(141, csrrwi, mcause,	x25, 24, 	7);
	TEST_CSRI_OP(142, csrrwi, mcause,	x26, 25, 	8);
	TEST_CSRI_OP(143, csrrwi, mcause,	x27, 26, 	9);
	TEST_CSRI_OP(144, csrrwi, mcause,	x28, 27, 	10);
	TEST_CSRI_OP(145, csrrwi, mcause,	x29, 28, 	11);

# ---------------------------------------------------
# CSRRSI INSTRUCTION
	# TEST_CSRI_OP(testnum , inst , reg, rd , rs1 , result)

	# clear all csr values
	csrrw	x0, mstatus, x0
	csrrw	x0, mie, x0
	csrrw	x0, mtvec, x0
	csrrw	x0, mepc, x0
	csrrw	x0,	mcause, x0

	# --------------------------------
	# -- MSTATUS
	TEST_CSRI_OP(146, csrrsi, mstatus,	x1,  30, 	0);
	TEST_CSRI_OP(147, csrrsi, mstatus,	x2,  1,  	8);
	TEST_CSRI_OP(148, csrrsi, mstatus,	x3,  2,  	8);
	TEST_CSRI_OP(149, csrrsi, mstatus,	x4,  3,  	8);
	TEST_CSRI_OP(150, csrrsi, mstatus,	x5,  4,  	8);
	TEST_CSRI_OP(151, csrrsi, mstatus,	x6,  5,  	8);
	TEST_CSRI_OP(152, csrrsi, mstatus,	x7,  6,  	8);
	TEST_CSRI_OP(153, csrrsi, mstatus,	x8,  7,  	8);
	TEST_CSRI_OP(154, csrrsi, mstatus,	x9,  8,  	8);
	TEST_CSRI_OP(155, csrrsi, mstatus,	x10, 9,  	8);
	TEST_CSRI_OP(156, csrrsi, mstatus,	x11, 10, 	8);
	TEST_CSRI_OP(157, csrrsi, mstatus,	x12, 11, 	8);
	TEST_CSRI_OP(158, csrrsi, mstatus,	x13, 12, 	8);
	TEST_CSRI_OP(159, csrrsi, mstatus,	x14, 13, 	8);
	TEST_CSRI_OP(160, csrrsi, mstatus,	x15, 14, 	8);
	# --
	csrrw	x0,mstatus,x0
	#--
	TEST_CSRI_OP(161, csrrsi, mstatus,	x16, 15, 	0);
	TEST_CSRI_OP(162, csrrsi, mstatus,	x17, 16, 	8);
	TEST_CSRI_OP(163, csrrsi, mstatus,	x18, 17, 	8);
	TEST_CSRI_OP(164, csrrsi, mstatus,	x19, 18, 	8);
	TEST_CSRI_OP(165, csrrsi, mstatus,	x20, 19, 	8);
	TEST_CSRI_OP(166, csrrsi, mstatus,	x21, 20, 	8);
	TEST_CSRI_OP(167, csrrsi, mstatus,	x22, 21, 	8);
	TEST_CSRI_OP(168, csrrsi, mstatus,	x23, 22, 	8);
	TEST_CSRI_OP(169, csrrsi, mstatus,	x24, 23, 	8);
	TEST_CSRI_OP(170, csrrsi, mstatus,	x25, 24, 	8);
	TEST_CSRI_OP(171, csrrsi, mstatus,	x26, 25, 	8);
	TEST_CSRI_OP(172, csrrsi, mstatus,	x27, 26, 	8);
	TEST_CSRI_OP(173, csrrsi, mstatus,	x28, 27, 	8);
	TEST_CSRI_OP(174, csrrsi, mstatus,	x29, 28, 	8);

	# --------------------------------
	# -- MIE
	TEST_CSRI_OP(175, csrrsi, mie,	x1,  30, 	0);
	TEST_CSRI_OP(176, csrrsi, mie,	x2,  1,  	8);
	TEST_CSRI_OP(177, csrrsi, mie,	x3,  2,  	8);
	TEST_CSRI_OP(178, csrrsi, mie,	x4,  3,  	8);
	TEST_CSRI_OP(179, csrrsi, mie,	x5,  4,  	8);
	TEST_CSRI_OP(180, csrrsi, mie,	x6,  5,  	8);
	TEST_CSRI_OP(181, csrrsi, mie,	x7,  6,  	8);
	TEST_CSRI_OP(182, csrrsi, mie,	x8,  7,  	8);
	TEST_CSRI_OP(183, csrrsi, mie,	x9,  8,  	8);
	TEST_CSRI_OP(184, csrrsi, mie,	x10, 9,  	8);
	TEST_CSRI_OP(185, csrrsi, mie,	x11, 10, 	8);
	TEST_CSRI_OP(186, csrrsi, mie,	x12, 11, 	8);
	TEST_CSRI_OP(187, csrrsi, mie,	x13, 12, 	8);
	TEST_CSRI_OP(188, csrrsi, mie,	x14, 13, 	8);
	TEST_CSRI_OP(189, csrrsi, mie,	x15, 14, 	8);
	# --
	csrrw	x0,mie,x0
	#--
	TEST_CSRI_OP(190, csrrsi, mie,	x16, 15, 	0);
	TEST_CSRI_OP(191, csrrsi, mie,	x17, 16, 	8);
	TEST_CSRI_OP(192, csrrsi, mie,	x18, 17, 	8);
	TEST_CSRI_OP(193, csrrsi, mie,	x19, 18, 	8);
	TEST_CSRI_OP(194, csrrsi, mie,	x20, 19, 	8);
	TEST_CSRI_OP(195, csrrsi, mie,	x21, 20, 	8);
	TEST_CSRI_OP(196, csrrsi, mie,	x22, 21, 	8);
	TEST_CSRI_OP(197, csrrsi, mie,	x23, 22, 	8);
	TEST_CSRI_OP(198, csrrsi, mie,	x24, 23, 	8);
	TEST_CSRI_OP(199, csrrsi, mie,	x25, 24, 	8);
	TEST_CSRI_OP(200, csrrsi, mie,	x26, 25, 	8);
	TEST_CSRI_OP(201, csrrsi, mie,	x27, 26, 	8);
	TEST_CSRI_OP(202, csrrsi, mie,	x28, 27, 	8);
	TEST_CSRI_OP(203, csrrsi, mie,	x29, 28, 	8);

	# --------------------------------
	# -- MTVEC
	TEST_CSRI_OP(204, csrrsi, mtvec,	x1,  0, 	0);
	TEST_CSRI_OP(205, csrrsi, mtvec,	x2,  1,  	0);
	TEST_CSRI_OP(206, csrrsi, mtvec,	x3,  2,  	1);
	TEST_CSRI_OP(207, csrrsi, mtvec,	x4,  3,  	3);
	TEST_CSRI_OP(208, csrrsi, mtvec,	x5,  4,  	3);
	TEST_CSRI_OP(209, csrrsi, mtvec,	x6,  5,  	7);
	TEST_CSRI_OP(210, csrrsi, mtvec,	x7,  6,  	7);
	TEST_CSRI_OP(211, csrrsi, mtvec,	x8,  7,  	7);
	TEST_CSRI_OP(212, csrrsi, mtvec,	x9,  8,  	7);
	TEST_CSRI_OP(213, csrrsi, mtvec,	x10, 9,  	15);
	TEST_CSRI_OP(214, csrrsi, mtvec,	x11, 10, 	15);
	TEST_CSRI_OP(215, csrrsi, mtvec,	x12, 11, 	15);
	TEST_CSRI_OP(216, csrrsi, mtvec,	x13, 12, 	15);
	TEST_CSRI_OP(217, csrrsi, mtvec,	x14, 13, 	15);
	TEST_CSRI_OP(218, csrrsi, mtvec,	x15, 14, 	15);
	# --
	csrrw	x0,mtvec,x0
	#--
	TEST_CSRI_OP(219, csrrsi, mtvec,	x16, 15, 	0);
	TEST_CSRI_OP(220, csrrsi, mtvec,	x17, 16, 	15);
	TEST_CSRI_OP(221, csrrsi, mtvec,	x18, 17, 	31);
	TEST_CSRI_OP(222, csrrsi, mtvec,	x19, 18, 	31);
	TEST_CSRI_OP(223, csrrsi, mtvec,	x20, 19, 	31);
	TEST_CSRI_OP(224, csrrsi, mtvec,	x21, 20, 	31);
	TEST_CSRI_OP(225, csrrsi, mtvec,	x22, 21, 	31);
	TEST_CSRI_OP(226, csrrsi, mtvec,	x23, 22, 	31);
	TEST_CSRI_OP(227, csrrsi, mtvec,	x24, 23, 	31);
	TEST_CSRI_OP(228, csrrsi, mtvec,	x25, 24, 	31);
	TEST_CSRI_OP(229, csrrsi, mtvec,	x26, 25, 	31);
	TEST_CSRI_OP(230, csrrsi, mtvec,	x27, 26, 	31);
	TEST_CSRI_OP(231, csrrsi, mtvec,	x28, 27, 	31);
	TEST_CSRI_OP(232, csrrsi, mtvec,	x29, 28, 	31);

	# --------------------------------
	# -- MEPC
	TEST_CSRI_OP(233, csrrsi, mepc,	x1,  0, 	0);
	TEST_CSRI_OP(234, csrrsi, mepc,	x2,  1,  	0);
	TEST_CSRI_OP(235, csrrsi, mepc,	x3,  2,  	0);
	TEST_CSRI_OP(236, csrrsi, mepc,	x4,  3,  	0);
	TEST_CSRI_OP(237, csrrsi, mepc,	x5,  4,  	0);
	TEST_CSRI_OP(238, csrrsi, mepc,	x6,  5,  	4);
	TEST_CSRI_OP(239, csrrsi, mepc,	x7,  6,  	4);
	TEST_CSRI_OP(240, csrrsi, mepc,	x8,  7,  	4);
	TEST_CSRI_OP(241, csrrsi, mepc,	x9,  8,  	4);
	TEST_CSRI_OP(242, csrrsi, mepc,	x10, 9,  	12);
	TEST_CSRI_OP(243, csrrsi, mepc,	x11, 10, 	12);
	TEST_CSRI_OP(244, csrrsi, mepc,	x12, 11, 	12);
	TEST_CSRI_OP(245, csrrsi, mepc,	x13, 12, 	12);
	TEST_CSRI_OP(246, csrrsi, mepc,	x14, 13, 	12);
	TEST_CSRI_OP(247, csrrsi, mepc,	x15, 14, 	12);
	# --
	csrrw	x0,mepc,x0
	#--
	TEST_CSRI_OP(248, csrrsi, mepc,	x16, 15, 	0);
	TEST_CSRI_OP(249, csrrsi, mepc,	x17, 16, 	12);
	TEST_CSRI_OP(250, csrrsi, mepc,	x18, 17, 	28);
	TEST_CSRI_OP(251, csrrsi, mepc,	x19, 18, 	28);
	TEST_CSRI_OP(252, csrrsi, mepc,	x20, 19, 	28);
	TEST_CSRI_OP(253, csrrsi, mepc,	x21, 20, 	28);
	TEST_CSRI_OP(254, csrrsi, mepc,	x22, 21, 	28);
	TEST_CSRI_OP(255, csrrsi, mepc,	x23, 22, 	28);
	TEST_CSRI_OP(256, csrrsi, mepc,	x24, 23, 	28);
	TEST_CSRI_OP(257, csrrsi, mepc,	x25, 24, 	28);
	TEST_CSRI_OP(258, csrrsi, mepc,	x26, 25, 	28);
	TEST_CSRI_OP(259, csrrsi, mepc,	x27, 26, 	28);
	TEST_CSRI_OP(260, csrrsi, mepc,	x28, 27, 	28);
	TEST_CSRI_OP(261, csrrsi, mepc,	x29, 28, 	28);

	# --------------------------------
	# -- MCAUSE
	TEST_CSRI_OP(262, csrrsi, mcause,	x1,  0, 	0);
	TEST_CSRI_OP(263, csrrsi, mcause,	x2,  1,  	0);
	TEST_CSRI_OP(264, csrrsi, mcause,	x3,  2,  	1);
	TEST_CSRI_OP(265, csrrsi, mcause,	x4,  3,  	3);
	TEST_CSRI_OP(266, csrrsi, mcause,	x5,  4,  	3);
	TEST_CSRI_OP(267, csrrsi, mcause,	x6,  5,  	7);
	TEST_CSRI_OP(268, csrrsi, mcause,	x7,  6,  	7);
	TEST_CSRI_OP(269, csrrsi, mcause,	x8,  7,  	7);
	TEST_CSRI_OP(270, csrrsi, mcause,	x9,  8,  	7);
	TEST_CSRI_OP(271, csrrsi, mcause,	x10, 9,  	15);
	TEST_CSRI_OP(272, csrrsi, mcause,	x11, 10, 	15);
	TEST_CSRI_OP(273, csrrsi, mcause,	x12, 11, 	15);
	TEST_CSRI_OP(274, csrrsi, mcause,	x13, 12, 	15);
	TEST_CSRI_OP(275, csrrsi, mcause,	x14, 13, 	15);
	TEST_CSRI_OP(276, csrrsi, mcause,	x15, 14, 	15);
	# --
	csrrw	x0,mcause,x0
	#--
	TEST_CSRI_OP(277, csrrsi, mcause,	x16, 15, 	0);
	TEST_CSRI_OP(278, csrrsi, mcause,	x17, 16, 	15);
	TEST_CSRI_OP(279, csrrsi, mcause,	x18, 17, 	15);
	TEST_CSRI_OP(280, csrrsi, mcause,	x19, 18, 	15);
	TEST_CSRI_OP(281, csrrsi, mcause,	x20, 19, 	15);
	TEST_CSRI_OP(282, csrrsi, mcause,	x21, 20, 	15);
	TEST_CSRI_OP(283, csrrsi, mcause,	x22, 21, 	15);
	TEST_CSRI_OP(284, csrrsi, mcause,	x23, 22, 	15);
	TEST_CSRI_OP(285, csrrsi, mcause,	x24, 23, 	15);
	TEST_CSRI_OP(286, csrrsi, mcause,	x25, 24, 	15);
	TEST_CSRI_OP(287, csrrsi, mcause,	x26, 25, 	15);
	TEST_CSRI_OP(288, csrrsi, mcause,	x27, 26, 	15);
	TEST_CSRI_OP(289, csrrsi, mcause,	x28, 27, 	15);
	TEST_CSRI_OP(290, csrrsi, mcause,	x29, 28, 	15);

# ---------------------------------------------------
# CSRRCI INSTRUCTION
	# TEST_CSRI_OP(testnum , inst , reg, rd , rs1 , result)

	# set all csr values
	li x1,0xFFFFFFFF
	csrrw	x0, mstatus, x1
	csrrw	x0, mie, x1
	csrrw	x0, mtvec, x1
	csrrw	x0, mepc, x1
	csrrw	x0,	mcause, x1

	# --------------------------------
	# -- MSTATUS
	TEST_CSRI_OP(291, csrrci, mstatus,	x1,  0, 	0x00000088);
	TEST_CSRI_OP(292, csrrci, mstatus,	x2,  1,  	0x00000088);
	TEST_CSRI_OP(293, csrrci, mstatus,	x3,  2,  	0x00000088);
	TEST_CSRI_OP(294, csrrci, mstatus,	x4,  3,  	0x00000088);
	TEST_CSRI_OP(295, csrrci, mstatus,	x5,  4,  	0x00000088);
	TEST_CSRI_OP(296, csrrci, mstatus,	x6,  5,  	0x00000088);
	TEST_CSRI_OP(297, csrrci, mstatus,	x7,  6,  	0x00000088);
	TEST_CSRI_OP(298, csrrci, mstatus,	x8,  7,  	0x00000088);
	TEST_CSRI_OP(299, csrrci, mstatus,	x9,  8,  	0x00000088);
	TEST_CSRI_OP(300, csrrci, mstatus,	x10, 9,  	0x00000080);
	TEST_CSRI_OP(301, csrrci, mstatus,	x11, 10, 	0x00000080);
	TEST_CSRI_OP(302, csrrci, mstatus,	x12, 11, 	0x00000080);
	TEST_CSRI_OP(303, csrrci, mstatus,	x13, 12, 	0x00000080);
	TEST_CSRI_OP(304, csrrci, mstatus,	x14, 13, 	0x00000080);
	TEST_CSRI_OP(305, csrrci, mstatus,	x15, 14, 	0x00000080);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mstatus,x1
	#--
	TEST_CSRI_OP(306, csrrci, mstatus,	x16, 15, 	0x00000088);
	TEST_CSRI_OP(307, csrrci, mstatus,	x17, 16, 	0x00000080);
	TEST_CSRI_OP(308, csrrci, mstatus,	x18, 17, 	0x00000080);
	TEST_CSRI_OP(309, csrrci, mstatus,	x19, 18, 	0x00000080);
	TEST_CSRI_OP(310, csrrci, mstatus,	x20, 19, 	0x00000080);
	TEST_CSRI_OP(311, csrrci, mstatus,	x21, 20, 	0x00000080);
	TEST_CSRI_OP(312, csrrci, mstatus,	x22, 21, 	0x00000080);
	TEST_CSRI_OP(313, csrrci, mstatus,	x23, 22, 	0x00000080);
	TEST_CSRI_OP(314, csrrci, mstatus,	x24, 23, 	0x00000080);
	TEST_CSRI_OP(315, csrrci, mstatus,	x25, 24, 	0x00000080);
	TEST_CSRI_OP(316, csrrci, mstatus,	x26, 25, 	0x00000080);
	TEST_CSRI_OP(317, csrrci, mstatus,	x27, 26, 	0x00000080);
	TEST_CSRI_OP(318, csrrci, mstatus,	x28, 27, 	0x00000080);
	TEST_CSRI_OP(319, csrrci, mstatus,	x29, 28, 	0x00000080);

	# --------------------------------
	# -- MIE
	TEST_CSRI_OP(320, csrrci, mie,	x1,  0, 	0x00000808);
	TEST_CSRI_OP(321, csrrci, mie,	x2,  1,  	0x00000808);
	TEST_CSRI_OP(322, csrrci, mie,	x3,  2,  	0x00000808);
	TEST_CSRI_OP(323, csrrci, mie,	x4,  3,  	0x00000808);
	TEST_CSRI_OP(324, csrrci, mie,	x5,  4,  	0x00000808);
	TEST_CSRI_OP(325, csrrci, mie,	x6,  5,  	0x00000808);
	TEST_CSRI_OP(326, csrrci, mie,	x7,  6,  	0x00000808);
	TEST_CSRI_OP(327, csrrci, mie,	x8,  7,  	0x00000808);
	TEST_CSRI_OP(328, csrrci, mie,	x9,  8,  	0x00000808);
	TEST_CSRI_OP(329, csrrci, mie,	x10, 9,  	0x00000800);
	TEST_CSRI_OP(330, csrrci, mie,	x11, 10, 	0x00000800);
	TEST_CSRI_OP(331, csrrci, mie,	x12, 11, 	0x00000800);
	TEST_CSRI_OP(332, csrrci, mie,	x13, 12, 	0x00000800);
	TEST_CSRI_OP(333, csrrci, mie,	x14, 13, 	0x00000800);
	TEST_CSRI_OP(334, csrrci, mie,	x15, 14, 	0x00000800);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mie,x1
	#--
	TEST_CSRI_OP(335, csrrci, mie,	x16, 15, 	0x00000808);
	TEST_CSRI_OP(336, csrrci, mie,	x17, 16, 	0x00000800);
	TEST_CSRI_OP(337, csrrci, mie,	x18, 17, 	0x00000800);
	TEST_CSRI_OP(338, csrrci, mie,	x19, 18, 	0x00000800);
	TEST_CSRI_OP(339, csrrci, mie,	x20, 19, 	0x00000800);
	TEST_CSRI_OP(340, csrrci, mie,	x21, 20, 	0x00000800);
	TEST_CSRI_OP(341, csrrci, mie,	x22, 21, 	0x00000800);
	TEST_CSRI_OP(342, csrrci, mie,	x23, 22, 	0x00000800);
	TEST_CSRI_OP(343, csrrci, mie,	x24, 23, 	0x00000800);
	TEST_CSRI_OP(344, csrrci, mie,	x25, 24, 	0x00000800);
	TEST_CSRI_OP(345, csrrci, mie,	x26, 25, 	0x00000800);
	TEST_CSRI_OP(346, csrrci, mie,	x27, 26, 	0x00000800);
	TEST_CSRI_OP(347, csrrci, mie,	x28, 27, 	0x00000800);
	TEST_CSRI_OP(348, csrrci, mie,	x29, 28, 	0x00000800);

	# --------------------------------
	# -- MTVEC
	TEST_CSRI_OP(349, csrrci, mtvec,	x1,  0, 	0xFFFFFFFF);
	TEST_CSRI_OP(350, csrrci, mtvec,	x2,  1,  	0xFFFFFFFF);
	TEST_CSRI_OP(351, csrrci, mtvec,	x3,  2,  	0xFFFFFFFE);
	TEST_CSRI_OP(352, csrrci, mtvec,	x4,  3,  	0xFFFFFFFC);
	TEST_CSRI_OP(353, csrrci, mtvec,	x5,  4,  	0xFFFFFFFC);
	TEST_CSRI_OP(354, csrrci, mtvec,	x6,  5,  	0xFFFFFFF8);
	TEST_CSRI_OP(355, csrrci, mtvec,	x7,  6,  	0xFFFFFFF8);
	TEST_CSRI_OP(356, csrrci, mtvec,	x8,  7,  	0xFFFFFFF8);
	TEST_CSRI_OP(357, csrrci, mtvec,	x9,  8,  	0xFFFFFFF8);
	TEST_CSRI_OP(358, csrrci, mtvec,	x10, 9,  	0xFFFFFFF0);
	TEST_CSRI_OP(359, csrrci, mtvec,	x11, 10, 	0xFFFFFFF0);
	TEST_CSRI_OP(360, csrrci, mtvec,	x12, 11, 	0xFFFFFFF0);
	TEST_CSRI_OP(361, csrrci, mtvec,	x13, 12, 	0xFFFFFFF0);
	TEST_CSRI_OP(362, csrrci, mtvec,	x14, 13, 	0xFFFFFFF0);
	TEST_CSRI_OP(363, csrrci, mtvec,	x15, 14, 	0xFFFFFFF0);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mtvec,x1
	#--
	TEST_CSRI_OP(364, csrrci, mtvec,	x16, 15, 	0xFFFFFFFF);
	TEST_CSRI_OP(365, csrrci, mtvec,	x17, 16, 	0xFFFFFFF0);
	TEST_CSRI_OP(366, csrrci, mtvec,	x18, 17, 	0xFFFFFFE0);
	TEST_CSRI_OP(367, csrrci, mtvec,	x19, 18, 	0xFFFFFFE0);
	TEST_CSRI_OP(368, csrrci, mtvec,	x20, 19, 	0xFFFFFFE0);
	TEST_CSRI_OP(369, csrrci, mtvec,	x21, 20, 	0xFFFFFFE0);
	TEST_CSRI_OP(370, csrrci, mtvec,	x22, 21, 	0xFFFFFFE0);
	TEST_CSRI_OP(371, csrrci, mtvec,	x23, 22, 	0xFFFFFFE0);
	TEST_CSRI_OP(372, csrrci, mtvec,	x24, 23, 	0xFFFFFFE0);
	TEST_CSRI_OP(373, csrrci, mtvec,	x25, 24, 	0xFFFFFFE0);
	TEST_CSRI_OP(374, csrrci, mtvec,	x26, 25, 	0xFFFFFFE0);
	TEST_CSRI_OP(375, csrrci, mtvec,	x27, 26, 	0xFFFFFFE0);
	TEST_CSRI_OP(376, csrrci, mtvec,	x28, 27, 	0xFFFFFFE0);
	TEST_CSRI_OP(377, csrrci, mtvec,	x29, 28, 	0xFFFFFFE0);

	# --------------------------------
	# -- MEPC
	TEST_CSRI_OP(378, csrrci, mepc,	x1,  0, 	0xFFFFFFFC);
	TEST_CSRI_OP(379, csrrci, mepc,	x2,  1,  	0xFFFFFFFC);
	TEST_CSRI_OP(380, csrrci, mepc,	x3,  2,  	0xFFFFFFFC);
	TEST_CSRI_OP(381, csrrci, mepc,	x4,  3,  	0xFFFFFFFC);
	TEST_CSRI_OP(382, csrrci, mepc,	x5,  4,  	0xFFFFFFFC);
	TEST_CSRI_OP(383, csrrci, mepc,	x6,  5,  	0xFFFFFFF8);
	TEST_CSRI_OP(384, csrrci, mepc,	x7,  6,  	0xFFFFFFF8);
	TEST_CSRI_OP(385, csrrci, mepc,	x8,  7,  	0xFFFFFFF8);
	TEST_CSRI_OP(386, csrrci, mepc,	x9,  8,  	0xFFFFFFF8);
	TEST_CSRI_OP(387, csrrci, mepc,	x10, 9,  	0xFFFFFFF0);
	TEST_CSRI_OP(388, csrrci, mepc,	x11, 10, 	0xFFFFFFF0);
	TEST_CSRI_OP(389, csrrci, mepc,	x12, 11, 	0xFFFFFFF0);
	TEST_CSRI_OP(390, csrrci, mepc,	x13, 12, 	0xFFFFFFF0);
	TEST_CSRI_OP(391, csrrci, mepc,	x14, 13, 	0xFFFFFFF0);
	TEST_CSRI_OP(392, csrrci, mepc,	x15, 14, 	0xFFFFFFF0);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mepc,x1
	#--
	TEST_CSRI_OP(393, csrrci, mepc,	x16, 15, 	0xFFFFFFFC);
	TEST_CSRI_OP(394, csrrci, mepc,	x17, 16, 	0xFFFFFFF0);
	TEST_CSRI_OP(395, csrrci, mepc,	x18, 17, 	0xFFFFFFE0);
	TEST_CSRI_OP(396, csrrci, mepc,	x19, 18, 	0xFFFFFFE0);
	TEST_CSRI_OP(397, csrrci, mepc,	x20, 19, 	0xFFFFFFE0);
	TEST_CSRI_OP(398, csrrci, mepc,	x21, 20, 	0xFFFFFFE0);
	TEST_CSRI_OP(399, csrrci, mepc,	x22, 21, 	0xFFFFFFE0);
	TEST_CSRI_OP(400, csrrci, mepc,	x23, 22, 	0xFFFFFFE0);
	TEST_CSRI_OP(401, csrrci, mepc,	x24, 23, 	0xFFFFFFE0);
	TEST_CSRI_OP(402, csrrci, mepc,	x25, 24, 	0xFFFFFFE0);
	TEST_CSRI_OP(403, csrrci, mepc,	x26, 25, 	0xFFFFFFE0);
	TEST_CSRI_OP(404, csrrci, mepc,	x27, 26, 	0xFFFFFFE0);
	TEST_CSRI_OP(405, csrrci, mepc,	x28, 27, 	0xFFFFFFE0);
	TEST_CSRI_OP(406, csrrci, mepc,	x29, 28, 	0xFFFFFFE0);

	# --------------------------------
	# -- MCAUSE
	TEST_CSRI_OP(407, csrrci, mcause,	x1,  0, 	0x8000000F);
	TEST_CSRI_OP(408, csrrci, mcause,	x2,  1,  	0x8000000F);
	TEST_CSRI_OP(409, csrrci, mcause,	x3,  2,  	0x8000000E);
	TEST_CSRI_OP(410, csrrci, mcause,	x4,  3,  	0x8000000C);
	TEST_CSRI_OP(411, csrrci, mcause,	x5,  4,  	0x8000000C);
	TEST_CSRI_OP(412, csrrci, mcause,	x6,  5,  	0x80000008);
	TEST_CSRI_OP(413, csrrci, mcause,	x7,  6,  	0x80000008);
	TEST_CSRI_OP(414, csrrci, mcause,	x8,  7,  	0x80000008);
	TEST_CSRI_OP(415, csrrci, mcause,	x9,  8,  	0x80000008);
	TEST_CSRI_OP(416, csrrci, mcause,	x10, 9,  	0x80000000);
	TEST_CSRI_OP(417, csrrci, mcause,	x11, 10, 	0x80000000);
	TEST_CSRI_OP(418, csrrci, mcause,	x12, 11, 	0x80000000);
	TEST_CSRI_OP(419, csrrci, mcause,	x13, 12, 	0x80000000);
	TEST_CSRI_OP(420, csrrci, mcause,	x14, 13, 	0x80000000);
	TEST_CSRI_OP(421, csrrci, mcause,	x15, 14, 	0x80000000);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mcause,x1
	#--
	TEST_CSRI_OP(422, csrrci, mcause,	x16, 15, 	0x8000000F);
	TEST_CSRI_OP(423, csrrci, mcause,	x17, 16, 	0x80000000);
	TEST_CSRI_OP(424, csrrci, mcause,	x18, 17, 	0x80000000);
	TEST_CSRI_OP(425, csrrci, mcause,	x19, 18, 	0x80000000);
	TEST_CSRI_OP(426, csrrci, mcause,	x20, 19, 	0x80000000);
	TEST_CSRI_OP(427, csrrci, mcause,	x21, 20, 	0x80000000);
	TEST_CSRI_OP(428, csrrci, mcause,	x22, 21, 	0x80000000);
	TEST_CSRI_OP(429, csrrci, mcause,	x23, 22, 	0x80000000);
	TEST_CSRI_OP(430, csrrci, mcause,	x24, 23, 	0x80000000);
	TEST_CSRI_OP(431, csrrci, mcause,	x25, 24, 	0x80000000);
	TEST_CSRI_OP(432, csrrci, mcause,	x26, 25, 	0x80000000);
	TEST_CSRI_OP(433, csrrci, mcause,	x27, 26, 	0x80000000);
	TEST_CSRI_OP(434, csrrci, mcause,	x28, 27, 	0x80000000);
	TEST_CSRI_OP(435, csrrci, mcause,	x29, 28, 	0x80000000);

# ---------------------------------------------------
# PASS Basic Tests
	PASS

# ---------------------------------------------------
# FAIL Basic Tests
	FAIL
