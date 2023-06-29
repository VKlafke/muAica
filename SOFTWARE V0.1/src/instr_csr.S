#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.section .text,"ax"
_csr_s_:

# CSR Instr => instruction	rd, csr, rs1

# valid bits for mstatus: [7] and [3]
# valid bits for mie: [11] and [3]
# valid bits for mtvec: [31:0]
# valid bits for mepc: [31:2]
# valid bits for mcause: [31] and [3:0]

# ---------------------------------------------------
# CSRRW INSTRUCTION
	# TEST_CSR_OP(testnum , inst , reg, rd , rs1 , val1 , result)

	# --------------------------------
	# -- MSTATUS
	TEST_CSR_OP(1,  csrrw, mstatus,	x1,  x30, 	0x12345600,	0x00000000);
	TEST_CSR_OP(2,  csrrw, mstatus,	x2,  x1,  	0x12345600,	0x00000000);
	TEST_CSR_OP(3,  csrrw, mstatus,	x3,  x2,  	0x12345600,	0x00000000);
	TEST_CSR_OP(4,  csrrw, mstatus,	x4,  x3,  	0x12345600,	0x00000000);
	TEST_CSR_OP(5,  csrrw, mstatus,	x5,  x4,  	0x12345608,	0x00000000);
	TEST_CSR_OP(6,  csrrw, mstatus,	x6,  x5,  	0x12345649,	0x00000008);
	TEST_CSR_OP(7,  csrrw, mstatus,	x7,  x6,  	0x1234564C,	0x00000008);
	TEST_CSR_OP(8,  csrrw, mstatus,	x8,  x7,  	0x1234561F,	0x00000008);
	TEST_CSR_OP(9,  csrrw, mstatus,	x9,  x8,  	0x12345680,	0x00000008);
	TEST_CSR_OP(10, csrrw, mstatus,	x10, x9,  	0x12345690,	0x00000080);
	TEST_CSR_OP(11, csrrw, mstatus,	x11, x10, 	0x123456C0,	0x00000080);
	TEST_CSR_OP(12, csrrw, mstatus,	x12, x11, 	0x123456F0,	0x00000080);
	TEST_CSR_OP(13, csrrw, mstatus,	x13, x12, 	0x12345688,	0x00000080);
	TEST_CSR_OP(14, csrrw, mstatus,	x14, x13, 	0x12345699,	0x00000088);
	TEST_CSR_OP(15, csrrw, mstatus,	x15, x14, 	0x123456FF,	0x00000088);
	#--
	TEST_CSR_OP(16, csrrw, mstatus,	x16, x15, 	0x12345600,	0x00000088);
	TEST_CSR_OP(17, csrrw, mstatus,	x17, x16, 	0x12345600,	0x00000000);
	TEST_CSR_OP(18, csrrw, mstatus,	x18, x17, 	0x12345600,	0x00000000);
	TEST_CSR_OP(19, csrrw, mstatus,	x19, x18, 	0x12345600,	0x00000000);
	TEST_CSR_OP(20, csrrw, mstatus,	x20, x19, 	0x12345608,	0x00000000);
	TEST_CSR_OP(21, csrrw, mstatus,	x21, x20, 	0x12345649,	0x00000008);
	TEST_CSR_OP(22, csrrw, mstatus,	x22, x21, 	0x1234564C,	0x00000008);
	TEST_CSR_OP(23, csrrw, mstatus,	x23, x22, 	0x1234561F,	0x00000008);
	TEST_CSR_OP(24, csrrw, mstatus,	x24, x23, 	0x12345680,	0x00000008);
	TEST_CSR_OP(25, csrrw, mstatus,	x25, x24, 	0x12345690,	0x00000080);
	TEST_CSR_OP(26, csrrw, mstatus,	x26, x25, 	0x123456C0,	0x00000080);
	TEST_CSR_OP(27, csrrw, mstatus,	x27, x26, 	0x123456F0,	0x00000080);
	TEST_CSR_OP(28, csrrw, mstatus,	x28, x27, 	0x12345688,	0x00000080);
	TEST_CSR_OP(29, csrrw, mstatus,	x29, x28, 	0x12345699,	0x00000088);

	# --------------------------------
	# -- MIE
	TEST_CSR_OP(30,  csrrw, mie,x1,  x30, 	0x12340000,	0x00000000);
	TEST_CSR_OP(31,  csrrw, mie,x2,  x1,  	0x12340000,	0x00000000);
	TEST_CSR_OP(32,  csrrw, mie,x3,  x2,  	0x12340000,	0x00000000);
	TEST_CSR_OP(33,  csrrw, mie,x4,  x3,  	0x12340000,	0x00000000);
	TEST_CSR_OP(34,  csrrw, mie,x5,  x4,  	0x12340008,	0x00000000);
	TEST_CSR_OP(35,  csrrw, mie,x6,  x5,  	0x12340009,	0x00000008);
	TEST_CSR_OP(36,  csrrw, mie,x7,  x6,  	0x1234000C,	0x00000008);
	TEST_CSR_OP(37,  csrrw, mie,x8,  x7,  	0x1234000F,	0x00000008);
	TEST_CSR_OP(38,  csrrw, mie,x9,  x8,  	0x12340800,	0x00000008);
	TEST_CSR_OP(39, csrrw, mie,	x10, x9,  	0x12340900,	0x00000800);
	TEST_CSR_OP(40, csrrw, mie,	x11, x10, 	0x12340A00,	0x00000800);
	TEST_CSR_OP(41, csrrw, mie,	x12, x11, 	0x12340F00,	0x00000800);
	TEST_CSR_OP(42, csrrw, mie,	x13, x12, 	0x12340808,	0x00000800);
	TEST_CSR_OP(43, csrrw, mie,	x14, x13, 	0x12340909,	0x00000808);
	TEST_CSR_OP(44, csrrw, mie,	x15, x14, 	0x12340F0F,	0x00000808);
	# --
	TEST_CSR_OP(45, csrrw, mie,	x16, x15, 	0x12340000,	0x00000808);
	TEST_CSR_OP(46, csrrw, mie,	x17, x16, 	0x12340000,	0x00000000);
	TEST_CSR_OP(47, csrrw, mie,	x18, x17, 	0x12340000,	0x00000000);
	TEST_CSR_OP(48, csrrw, mie,	x19, x18, 	0x12340000,	0x00000000);
	TEST_CSR_OP(49, csrrw, mie,	x20, x19, 	0x12340008,	0x00000000);
	TEST_CSR_OP(50, csrrw, mie,	x21, x20, 	0x12340009,	0x00000008);
	TEST_CSR_OP(51, csrrw, mie,	x22, x21, 	0x1234000C,	0x00000008);
	TEST_CSR_OP(52, csrrw, mie,	x23, x22, 	0x1234000F,	0x00000008);
	TEST_CSR_OP(53, csrrw, mie,	x24, x23, 	0x12340800,	0x00000008);
	TEST_CSR_OP(54, csrrw, mie,	x25, x24, 	0x12340900,	0x00000800);
	TEST_CSR_OP(55, csrrw, mie,	x26, x25, 	0x12340A00,	0x00000800);
	TEST_CSR_OP(56, csrrw, mie,	x27, x26, 	0x12340F00,	0x00000800);
	TEST_CSR_OP(57, csrrw, mie,	x28, x27, 	0x12340808,	0x00000800);
	TEST_CSR_OP(58, csrrw, mie,	x29, x28, 	0x12340909,	0x00000808);

	# --------------------------------
	# -- MTVEC
	TEST_CSR_OP(59,  csrrw, mtvec,	x1,  x30, 	0x12345678,	0x00000000);
	TEST_CSR_OP(60,  csrrw, mtvec,	x2,  x1,  	0x23456789,	0x12345678);
	TEST_CSR_OP(61,  csrrw, mtvec,	x3,  x2,  	0x3456789A,	0x23456789);
	TEST_CSR_OP(62,  csrrw, mtvec,	x4,  x3,  	0x456789AB,	0x3456789A);
	TEST_CSR_OP(63,  csrrw, mtvec,	x5,  x4,  	0x56789ABC,	0x456789AB);
	TEST_CSR_OP(64,  csrrw, mtvec,	x6,  x5,  	0x6789ABCD,	0x56789ABC);
	TEST_CSR_OP(65,  csrrw, mtvec,	x7,  x6,  	0x789ABCDE,	0x6789ABCD);
	TEST_CSR_OP(66,  csrrw, mtvec,	x8,  x7,  	0x89ABCDEF,	0x789ABCDE);
	TEST_CSR_OP(67,  csrrw, mtvec,	x9,  x8,  	0x9ABCDEF0,	0x89ABCDEF);
	TEST_CSR_OP(68, csrrw, mtvec,	x10, x9,  	0xABCDEF01,	0x9ABCDEF0);
	TEST_CSR_OP(69, csrrw, mtvec,	x11, x10, 	0xBCDEF012,	0xABCDEF01);
	TEST_CSR_OP(70, csrrw, mtvec,	x12, x11, 	0xCDEF0123,	0xBCDEF012);
	TEST_CSR_OP(71, csrrw, mtvec,	x13, x12, 	0xDEF01234,	0xCDEF0123);
	TEST_CSR_OP(72, csrrw, mtvec,	x14, x13, 	0xEF012345,	0xDEF01234);
	TEST_CSR_OP(73, csrrw, mtvec,	x15, x14, 	0xF0123456,	0xEF012345);
	# --
	TEST_CSR_OP(74, csrrw, mtvec,	x16, x15, 	0x12345678,	0xF0123456);
	TEST_CSR_OP(75, csrrw, mtvec,	x17, x16, 	0x23456789,	0x12345678);
	TEST_CSR_OP(76, csrrw, mtvec,	x18, x17, 	0x3456789A,	0x23456789);
	TEST_CSR_OP(77, csrrw, mtvec,	x19, x18, 	0x456789AB,	0x3456789A);
	TEST_CSR_OP(78, csrrw, mtvec,	x20, x19, 	0x56789ABC,	0x456789AB);
	TEST_CSR_OP(79, csrrw, mtvec,	x21, x20, 	0x6789ABCD,	0x56789ABC);
	TEST_CSR_OP(80, csrrw, mtvec,	x22, x21, 	0x789ABCDE,	0x6789ABCD);
	TEST_CSR_OP(81, csrrw, mtvec,	x23, x22, 	0x89ABCDEF,	0x789ABCDE);
	TEST_CSR_OP(82, csrrw, mtvec,	x24, x23, 	0x9ABCDEF0,	0x89ABCDEF);
	TEST_CSR_OP(83, csrrw, mtvec,	x25, x24, 	0xABCDEF01,	0x9ABCDEF0);
	TEST_CSR_OP(84, csrrw, mtvec,	x26, x25, 	0xBCDEF012,	0xABCDEF01);
	TEST_CSR_OP(85, csrrw, mtvec,	x27, x26, 	0xCDEF0123,	0xBCDEF012);
	TEST_CSR_OP(86, csrrw, mtvec,	x28, x27, 	0xDEF01234,	0xCDEF0123);
	TEST_CSR_OP(87, csrrw, mtvec,	x29, x28, 	0xEF012345,	0xDEF01234);

	# --------------------------------
	# -- MEPC
	TEST_CSR_OP(88,  csrrw, mepc,	x1,  x30, 	0x12345678,	0x00000000);
	TEST_CSR_OP(89,  csrrw, mepc,	x2,  x1,  	0x23456789,	0x12345678);
	TEST_CSR_OP(90,  csrrw, mepc,	x3,  x2,  	0x3456789A,	0x23456788);
	TEST_CSR_OP(91,  csrrw, mepc,	x4,  x3,  	0x456789AB,	0x34567898);
	TEST_CSR_OP(92,  csrrw, mepc,	x5,  x4,  	0x56789ABC,	0x456789A8);
	TEST_CSR_OP(93,  csrrw, mepc,	x6,  x5,  	0x6789ABCD,	0x56789ABC);
	TEST_CSR_OP(94,  csrrw, mepc,	x7,  x6,  	0x789ABCDE,	0x6789ABCC);
	TEST_CSR_OP(95,  csrrw, mepc,	x8,  x7,  	0x89ABCDEF,	0x789ABCDC);
	TEST_CSR_OP(96,  csrrw, mepc,	x9,  x8,  	0x9ABCDEF0,	0x89ABCDEC);
	TEST_CSR_OP(97, csrrw, mepc,	x10, x9,  	0xABCDEF01,	0x9ABCDEF0);
	TEST_CSR_OP(98, csrrw, mepc,	x11, x10, 	0xBCDEF012,	0xABCDEF00);
	TEST_CSR_OP(99, csrrw, mepc,	x12, x11, 	0xCDEF0123,	0xBCDEF010);
	TEST_CSR_OP(100, csrrw, mepc,	x13, x12, 	0xDEF01234,	0xCDEF0120);
	TEST_CSR_OP(101, csrrw, mepc,	x14, x13, 	0xEF012345,	0xDEF01234);
	TEST_CSR_OP(102, csrrw, mepc,	x15, x14, 	0xF0123456,	0xEF012344);
	# --
	TEST_CSR_OP(103, csrrw, mepc,	x16, x15, 	0x12345678,	0xF0123454);
	TEST_CSR_OP(104, csrrw, mepc,	x17, x16, 	0x23456789,	0x12345678);
	TEST_CSR_OP(105, csrrw, mepc,	x18, x17, 	0x3456789A,	0x23456788);
	TEST_CSR_OP(106, csrrw, mepc,	x19, x18, 	0x456789AB,	0x34567898);
	TEST_CSR_OP(107, csrrw, mepc,	x20, x19, 	0x56789ABC,	0x456789A8);
	TEST_CSR_OP(108, csrrw, mepc,	x21, x20, 	0x6789ABCD,	0x56789ABC);
	TEST_CSR_OP(109, csrrw, mepc,	x22, x21, 	0x789ABCDE,	0x6789ABCC);
	TEST_CSR_OP(110, csrrw, mepc,	x23, x22, 	0x89ABCDEF,	0x789ABCDC);
	TEST_CSR_OP(111, csrrw, mepc,	x24, x23, 	0x9ABCDEF0,	0x89ABCDEC);
	TEST_CSR_OP(112, csrrw, mepc,	x25, x24, 	0xABCDEF01,	0x9ABCDEF0);
	TEST_CSR_OP(113, csrrw, mepc,	x26, x25, 	0xBCDEF012,	0xABCDEF00);
	TEST_CSR_OP(114, csrrw, mepc,	x27, x26, 	0xCDEF0123,	0xBCDEF010);
	TEST_CSR_OP(115, csrrw, mepc,	x28, x27, 	0xDEF01234,	0xCDEF0120);
	TEST_CSR_OP(116, csrrw, mepc,	x29, x28, 	0xEF012345,	0xDEF01234);

	# --------------------------------
	# -- MCAUSE
	TEST_CSR_OP(117,  csrrw, mcause,x1,  x30, 	0x01230000,	0x00000000);
	TEST_CSR_OP(118,  csrrw, mcause,x2,  x1,  	0x01230001,	0x00000000);
	TEST_CSR_OP(119,  csrrw, mcause,x3,  x2,  	0x01230002,	0x00000001);
	TEST_CSR_OP(120,  csrrw, mcause,x4,  x3,  	0x01230003,	0x00000002);
	TEST_CSR_OP(121,  csrrw, mcause,x5,  x4,  	0x01230004,	0x00000003);
	TEST_CSR_OP(122,  csrrw, mcause,x6,  x5,  	0x01230005,	0x00000004);
	TEST_CSR_OP(123,  csrrw, mcause,x7,  x6,  	0x01230006,	0x00000005);
	TEST_CSR_OP(124,  csrrw, mcause,x8,  x7,  	0x01230007,	0x00000006);
	TEST_CSR_OP(125,  csrrw, mcause,x9,  x8,  	0x01230008,	0x00000007);
	TEST_CSR_OP(126, csrrw, mcause,	x10, x9,  	0x01230009,	0x00000008);
	TEST_CSR_OP(127, csrrw, mcause,	x11, x10, 	0x0123000A,	0x00000009);
	TEST_CSR_OP(128, csrrw, mcause,	x12, x11, 	0x0123000B,	0x0000000A);
	TEST_CSR_OP(129, csrrw, mcause,	x13, x12, 	0x0123000C,	0x0000000B);
	TEST_CSR_OP(130, csrrw, mcause,	x14, x13, 	0x0123000D,	0x0000000C);
	TEST_CSR_OP(131, csrrw, mcause,	x15, x14, 	0x0123000E,	0x0000000D);
	# --
	TEST_CSR_OP(132, csrrw, mcause,	x16, x15, 	0x81230000,	0x0000000E);
	TEST_CSR_OP(133, csrrw, mcause,	x17, x16, 	0x81230001,	0x80000000);
	TEST_CSR_OP(134, csrrw, mcause,	x18, x17, 	0x81230002,	0x80000001);
	TEST_CSR_OP(135, csrrw, mcause,	x19, x18, 	0x81230003,	0x80000002);
	TEST_CSR_OP(136, csrrw, mcause,	x20, x19, 	0x81230004,	0x80000003);
	TEST_CSR_OP(137, csrrw, mcause,	x21, x20, 	0x81230005,	0x80000004);
	TEST_CSR_OP(138, csrrw, mcause,	x22, x21, 	0x81230006,	0x80000005);
	TEST_CSR_OP(139, csrrw, mcause,	x23, x22, 	0x81230007,	0x80000006);
	TEST_CSR_OP(140, csrrw, mcause,	x24, x23, 	0x81230008,	0x80000007);
	TEST_CSR_OP(141, csrrw, mcause,	x25, x24, 	0x81230009,	0x80000008);
	TEST_CSR_OP(142, csrrw, mcause,	x26, x25, 	0x8123000A,	0x80000009);
	TEST_CSR_OP(143, csrrw, mcause,	x27, x26, 	0x8123000B,	0x8000000A);
	TEST_CSR_OP(144, csrrw, mcause,	x28, x27, 	0x8123000C,	0x8000000B);
	TEST_CSR_OP(145, csrrw, mcause,	x29, x28, 	0x8123000D,	0x8000000C);

# ---------------------------------------------------
# CSRRS INSTRUCTION
	# TEST_CSR_OP(testnum , inst , reg, rd , rs1 , val1 , result)

	# clear all csr values
	csrrw	x0, mstatus, x0
	csrrw	x0, mie, x0
	csrrw	x0, mtvec, x0
	csrrw	x0, mepc, x0
	csrrw	x0,	mcause, x0

	# --------------------------------
	# -- MSTATUS
	TEST_CSR_OP(146,  csrrs, mstatus,	x1,  x30, 	0x12345600,	0x00000000);
	TEST_CSR_OP(147,  csrrs, mstatus,	x2,  x1,  	0x12345600,	0x00000000);
	TEST_CSR_OP(148,  csrrs, mstatus,	x3,  x2,  	0x12345600,	0x00000000);
	TEST_CSR_OP(149,  csrrs, mstatus,	x4,  x3,  	0x12345600,	0x00000000);
	TEST_CSR_OP(150,  csrrs, mstatus,	x5,  x4,  	0x12345608,	0x00000000);
	TEST_CSR_OP(151,  csrrs, mstatus,	x6,  x5,  	0x12345649,	0x00000008);
	TEST_CSR_OP(152,  csrrs, mstatus,	x7,  x6,  	0x1234564C,	0x00000008);
	TEST_CSR_OP(153,  csrrs, mstatus,	x8,  x7,  	0x1234561F,	0x00000008);
	TEST_CSR_OP(154,  csrrs, mstatus,	x9,  x8,  	0x12345680,	0x00000008);
	TEST_CSR_OP(155, csrrs, mstatus,	x10, x9,  	0x12345690,	0x00000088);
	TEST_CSR_OP(156, csrrs, mstatus,	x11, x10, 	0x123456C0,	0x00000088);
	TEST_CSR_OP(157, csrrs, mstatus,	x12, x11, 	0x123456F0,	0x00000088);
	TEST_CSR_OP(158, csrrs, mstatus,	x13, x12, 	0x12345688,	0x00000088);
	TEST_CSR_OP(159, csrrs, mstatus,	x14, x13, 	0x12345699,	0x00000088);
	TEST_CSR_OP(160, csrrs, mstatus,	x15, x14, 	0x123456FF,	0x00000088);
	#--
	csrrw	x0,mstatus,x0
	#--
	TEST_CSR_OP(161, csrrs, mstatus,	x16, x15, 	0x12345600,	0x00000000);
	TEST_CSR_OP(162, csrrs, mstatus,	x17, x16, 	0x12345600,	0x00000000);
	TEST_CSR_OP(163, csrrs, mstatus,	x18, x17, 	0x12345600,	0x00000000);
	TEST_CSR_OP(164, csrrs, mstatus,	x19, x18, 	0x12345600,	0x00000000);
	TEST_CSR_OP(165, csrrs, mstatus,	x20, x19, 	0x12345608,	0x00000000);
	TEST_CSR_OP(166, csrrs, mstatus,	x21, x20, 	0x12345649,	0x00000008);
	TEST_CSR_OP(167, csrrs, mstatus,	x22, x21, 	0x1234564C,	0x00000008);
	TEST_CSR_OP(168, csrrs, mstatus,	x23, x22, 	0x1234561F,	0x00000008);
	TEST_CSR_OP(169, csrrs, mstatus,	x24, x23, 	0x12345680,	0x00000008);
	TEST_CSR_OP(170, csrrs, mstatus,	x25, x24, 	0x12345690,	0x00000088);
	TEST_CSR_OP(171, csrrs, mstatus,	x26, x25, 	0x123456C0,	0x00000088);
	TEST_CSR_OP(172, csrrs, mstatus,	x27, x26, 	0x123456F0,	0x00000088);
	TEST_CSR_OP(173, csrrs, mstatus,	x28, x27, 	0x12345688,	0x00000088);
	TEST_CSR_OP(174, csrrs, mstatus,	x29, x28, 	0x12345699,	0x00000088);

# --------------------------------
	# -- MIE
	TEST_CSR_OP(175, csrrs, mie,	x1,  x30, 	0x12340000,	0x00000000);
	TEST_CSR_OP(176, csrrs, mie,	x2,  x1,  	0x12340000,	0x00000000);
	TEST_CSR_OP(177, csrrs, mie,	x3,  x2,  	0x12340000,	0x00000000);
	TEST_CSR_OP(178, csrrs, mie,	x4,  x3,  	0x12340000,	0x00000000);
	TEST_CSR_OP(179, csrrs, mie,	x5,  x4,  	0x12340008,	0x00000000);
	TEST_CSR_OP(180, csrrs, mie,	x6,  x5,  	0x12340009,	0x00000008);
	TEST_CSR_OP(181, csrrs, mie,	x7,  x6,  	0x1234000C,	0x00000008);
	TEST_CSR_OP(182, csrrs, mie,	x8,  x7,  	0x1234000F,	0x00000008);
	TEST_CSR_OP(183, csrrs, mie,	x9,  x8,  	0x12340800,	0x00000008);
	TEST_CSR_OP(184, csrrs, mie,	x10, x9,  	0x12340900,	0x00000808);
	TEST_CSR_OP(185, csrrs, mie,	x11, x10, 	0x12340A00,	0x00000808);
	TEST_CSR_OP(186, csrrs, mie,	x12, x11, 	0x12340F00,	0x00000808);
	TEST_CSR_OP(187, csrrs, mie,	x13, x12, 	0x12340808,	0x00000808);
	TEST_CSR_OP(188, csrrs, mie,	x14, x13, 	0x12340909,	0x00000808);
	TEST_CSR_OP(189, csrrs, mie,	x15, x14, 	0x12340F0F,	0x00000808);
	# --
	csrrw	x0,mie,x0
	# --
	TEST_CSR_OP(190, csrrs, mie,	x16, x15, 	0x12340000,	0x00000000);
	TEST_CSR_OP(191, csrrs, mie,	x17, x16, 	0x12340000,	0x00000000);
	TEST_CSR_OP(192, csrrs, mie,	x18, x17, 	0x12340000,	0x00000000);
	TEST_CSR_OP(193, csrrs, mie,	x19, x18, 	0x12340000,	0x00000000);
	TEST_CSR_OP(194, csrrs, mie,	x20, x19, 	0x12340008,	0x00000000);
	TEST_CSR_OP(195, csrrs, mie,	x21, x20, 	0x12340009,	0x00000008);
	TEST_CSR_OP(196, csrrs, mie,	x22, x21, 	0x1234000C,	0x00000008);
	TEST_CSR_OP(197, csrrs, mie,	x23, x22, 	0x1234000F,	0x00000008);
	TEST_CSR_OP(198, csrrs, mie,	x24, x23, 	0x12340800,	0x00000008);
	TEST_CSR_OP(199, csrrs, mie,	x25, x24, 	0x12340900,	0x00000808);
	TEST_CSR_OP(200, csrrs, mie,	x26, x25, 	0x12340A00,	0x00000808);
	TEST_CSR_OP(201, csrrs, mie,	x27, x26, 	0x12340F00,	0x00000808);
	TEST_CSR_OP(202, csrrs, mie,	x28, x27, 	0x12340808,	0x00000808);
	TEST_CSR_OP(203, csrrs, mie,	x29, x28, 	0x12340909,	0x00000808);

	# --------------------------------
	# -- MTVEC
	TEST_CSR_OP(204, csrrs, mtvec,	x1,  x30, 	0x00000001,	0x00000000);
	TEST_CSR_OP(205, csrrs, mtvec,	x2,  x1,  	0x00000010,	0x00000001);
	TEST_CSR_OP(206, csrrs, mtvec,	x3,  x2,  	0x00000100,	0x00000011);
	TEST_CSR_OP(207, csrrs, mtvec,	x4,  x3,  	0x00001000,	0x00000111);
	TEST_CSR_OP(208, csrrs, mtvec,	x5,  x4,  	0x00010000,	0x00001111);
	TEST_CSR_OP(209, csrrs, mtvec,	x6,  x5,  	0x00100000,	0x00011111);
	TEST_CSR_OP(210, csrrs, mtvec,	x7,  x6,  	0x01000000,	0x00111111);
	TEST_CSR_OP(211, csrrs, mtvec,	x8,  x7,  	0x10000000,	0x01111111);
	TEST_CSR_OP(212, csrrs, mtvec,	x9,  x8,  	0x00000004,	0x11111111);
	TEST_CSR_OP(213, csrrs, mtvec,	x10, x9,  	0x00000040,	0x11111115);
	TEST_CSR_OP(214, csrrs, mtvec,	x11, x10, 	0x00000400,	0x11111155);
	TEST_CSR_OP(215, csrrs, mtvec,	x12, x11, 	0x00004000,	0x11111555);
	TEST_CSR_OP(216, csrrs, mtvec,	x13, x12, 	0x00040000,	0x11115555);
	TEST_CSR_OP(217, csrrs, mtvec,	x14, x13, 	0x00400000,	0x11155555);
	TEST_CSR_OP(218, csrrs, mtvec,	x15, x14, 	0x04000000,	0x11555555);
	# --
	csrrw x0,mtvec,x0
	# --
	TEST_CSR_OP(219, csrrs, mtvec,	x16, x15, 	0x00000001,	0x00000000);
	TEST_CSR_OP(220, csrrs, mtvec,	x17, x16, 	0x00000010,	0x00000001);
	TEST_CSR_OP(221, csrrs, mtvec,	x18, x17, 	0x00000100,	0x00000011);
	TEST_CSR_OP(222, csrrs, mtvec,	x19, x18, 	0x00001000,	0x00000111);
	TEST_CSR_OP(223, csrrs, mtvec,	x20, x19, 	0x00010000,	0x00001111);
	TEST_CSR_OP(224, csrrs, mtvec,	x21, x20, 	0x00100000,	0x00011111);
	TEST_CSR_OP(225, csrrs, mtvec,	x22, x21, 	0x01000000,	0x00111111);
	TEST_CSR_OP(226, csrrs, mtvec,	x23, x22, 	0x10000000,	0x01111111);
	TEST_CSR_OP(227, csrrs, mtvec,	x24, x23, 	0x00000004,	0x11111111);
	TEST_CSR_OP(228, csrrs, mtvec,	x25, x24, 	0x00000040,	0x11111115);
	TEST_CSR_OP(229, csrrs, mtvec,	x26, x25, 	0x00000400,	0x11111155);
	TEST_CSR_OP(230, csrrs, mtvec,	x27, x26, 	0x00004000,	0x11111555);
	TEST_CSR_OP(231, csrrs, mtvec,	x28, x27, 	0x00040000,	0x11115555);
	TEST_CSR_OP(232, csrrs, mtvec,	x29, x28, 	0x00400000,	0x11155555);

	# --------------------------------
	# -- MEPC
	TEST_CSR_OP(233, csrrs, mepc,	x1,  x30, 	0x00000001,	0x00000000);
	TEST_CSR_OP(234, csrrs, mepc,	x2,  x1,  	0x00000010,	0x00000000);
	TEST_CSR_OP(235, csrrs, mepc,	x3,  x2,  	0x00000100,	0x00000010);
	TEST_CSR_OP(236, csrrs, mepc,	x4,  x3,  	0x00001000,	0x00000110);
	TEST_CSR_OP(237, csrrs, mepc,	x5,  x4,  	0x00010000,	0x00001110);
	TEST_CSR_OP(238, csrrs, mepc,	x6,  x5,  	0x00100000,	0x00011110);
	TEST_CSR_OP(239, csrrs, mepc,	x7,  x6,  	0x01000000,	0x00111110);
	TEST_CSR_OP(240, csrrs, mepc,	x8,  x7,  	0x10000000,	0x01111110);
	TEST_CSR_OP(241, csrrs, mepc,	x9,  x8,  	0x00000004,	0x11111110);
	TEST_CSR_OP(242, csrrs, mepc,	x10, x9,  	0x00000040,	0x11111114);
	TEST_CSR_OP(243, csrrs, mepc,	x11, x10, 	0x00000400,	0x11111154);
	TEST_CSR_OP(244, csrrs, mepc,	x12, x11, 	0x00004000,	0x11111554);
	TEST_CSR_OP(245, csrrs, mepc,	x13, x12, 	0x00040000,	0x11115554);
	TEST_CSR_OP(246, csrrs, mepc,	x14, x13, 	0x00400000,	0x11155554);
	TEST_CSR_OP(247, csrrs, mepc,	x15, x14, 	0x04000000,	0x11555554);
	# --
	csrrw x0,mepc,x0
	# --
	TEST_CSR_OP(248, csrrs, mepc,	x16, x15, 	0x00000007,	0x00000000);
	TEST_CSR_OP(249, csrrs, mepc,	x17, x16, 	0x00000070,	0x00000004);
	TEST_CSR_OP(250, csrrs, mepc,	x18, x17, 	0x00000700,	0x00000074);
	TEST_CSR_OP(251, csrrs, mepc,	x19, x18, 	0x00007000,	0x00000774);
	TEST_CSR_OP(252, csrrs, mepc,	x20, x19, 	0x00070000,	0x00007774);
	TEST_CSR_OP(253, csrrs, mepc,	x21, x20, 	0x00700000,	0x00077774);
	TEST_CSR_OP(254, csrrs, mepc,	x22, x21, 	0x07000000,	0x00777774);
	TEST_CSR_OP(255, csrrs, mepc,	x23, x22, 	0x70000000,	0x07777774);
	TEST_CSR_OP(256, csrrs, mepc,	x24, x23, 	0x00000008,	0x77777774);
	TEST_CSR_OP(257, csrrs, mepc,	x25, x24, 	0x00000080,	0x7777777C);
	TEST_CSR_OP(258, csrrs, mepc,	x26, x25, 	0x00000800,	0x777777FC);
	TEST_CSR_OP(259, csrrs, mepc,	x27, x26, 	0x00008000,	0x77777FFC);
	TEST_CSR_OP(260, csrrs, mepc,	x28, x27, 	0x00080000,	0x7777FFFC);
	TEST_CSR_OP(261, csrrs, mepc,	x29, x28, 	0x00800000,	0x777FFFFC);

	# --------------------------------
	# -- MCAUSE
	TEST_CSR_OP(262, csrrs, mcause,x1,  x30, 	0x01230000,	0x00000000);
	TEST_CSR_OP(263, csrrs, mcause,x2,  x1,  	0x01230001,	0x00000000);
	TEST_CSR_OP(264, csrrs, mcause,x3,  x2,  	0x01230002,	0x00000001);
	TEST_CSR_OP(265, csrrs, mcause,x4,  x3,  	0x01230003,	0x00000003);
	TEST_CSR_OP(266, csrrs, mcause,x5,  x4,  	0x01230004,	0x00000003);
	TEST_CSR_OP(267, csrrs, mcause,x6,  x5,  	0x01230005,	0x00000007);
	TEST_CSR_OP(268, csrrs, mcause,x7,  x6,  	0x01230006,	0x00000007);
	TEST_CSR_OP(269, csrrs, mcause,x8,  x7,  	0x01230007,	0x00000007);
	TEST_CSR_OP(270, csrrs, mcause,x9,  x8,  	0x01230008,	0x00000007);
	TEST_CSR_OP(271, csrrs, mcause,	x10, x9,  	0x01230009,	0x0000000F);
	TEST_CSR_OP(272, csrrs, mcause,	x11, x10, 	0x0123000A,	0x0000000F);
	TEST_CSR_OP(273, csrrs, mcause,	x12, x11, 	0x0123000B,	0x0000000F);
	TEST_CSR_OP(274, csrrs, mcause,	x13, x12, 	0x0123000C,	0x0000000F);
	TEST_CSR_OP(275, csrrs, mcause,	x14, x13, 	0x0123000D,	0x0000000F);
	TEST_CSR_OP(276, csrrs, mcause,	x15, x14, 	0x0123000E,	0x0000000F);
	# --
	csrrw x0,mcause,x0
	# --
	TEST_CSR_OP(277, csrrs, mcause,	x16, x15, 	0x81230000,	0x00000000);
	TEST_CSR_OP(278, csrrs, mcause,	x17, x16, 	0x81230001,	0x80000000);
	TEST_CSR_OP(279, csrrs, mcause,	x18, x17, 	0x81230002,	0x80000001);
	TEST_CSR_OP(280, csrrs, mcause,	x19, x18, 	0x81230003,	0x80000003);
	TEST_CSR_OP(281, csrrs, mcause,	x20, x19, 	0x81230004,	0x80000003);
	TEST_CSR_OP(282, csrrs, mcause,	x21, x20, 	0x81230005,	0x80000007);
	TEST_CSR_OP(283, csrrs, mcause,	x22, x21, 	0x81230006,	0x80000007);
	TEST_CSR_OP(284, csrrs, mcause,	x23, x22, 	0x81230007,	0x80000007);
	TEST_CSR_OP(285, csrrs, mcause,	x24, x23, 	0x81230008,	0x80000007);
	TEST_CSR_OP(286, csrrs, mcause,	x25, x24, 	0x81230009,	0x8000000F);
	TEST_CSR_OP(287, csrrs, mcause,	x26, x25, 	0x8123000A,	0x8000000F);
	TEST_CSR_OP(288, csrrs, mcause,	x27, x26, 	0x8123000B,	0x8000000F);
	TEST_CSR_OP(289, csrrs, mcause,	x28, x27, 	0x8123000C,	0x8000000F);
	TEST_CSR_OP(290, csrrs, mcause,	x29, x28, 	0x8123000D,	0x8000000F);

# ---------------------------------------------------
# CSRRC INSTRUCTION
	# TEST_CSR_OP(testnum , inst , reg, rd , rs1 , val1 , result)

	# set all csr values
	li x1,0xFFFFFFFF
	csrrw	x0, mstatus, x1
	csrrw	x0, mie, x1
	csrrw	x0, mtvec, x1
	csrrw	x0, mepc, x1
	csrrw	x0,	mcause, x1

	# --------------------------------
	# -- MSTATUS
	TEST_CSR_OP(291,  csrrc, mstatus,	x1,  x30, 	0x12340000,	0x00000088);
	TEST_CSR_OP(292,  csrrc, mstatus,	x2,  x1,  	0x12340000,	0x00000088);
	TEST_CSR_OP(293,  csrrc, mstatus,	x3,  x2,  	0x12340000,	0x00000088);
	TEST_CSR_OP(294,  csrrc, mstatus,	x4,  x3,  	0x12340000,	0x00000088);
	TEST_CSR_OP(295,  csrrc, mstatus,	x5,  x4,  	0x12340008,	0x00000088);
	TEST_CSR_OP(296,  csrrc, mstatus,	x6,  x5,  	0x12340008,	0x00000080);
	TEST_CSR_OP(297,  csrrc, mstatus,	x7,  x6,  	0x12340008,	0x00000080);
	TEST_CSR_OP(298,  csrrc, mstatus,	x8,  x7,  	0x12340008,	0x00000080);
	TEST_CSR_OP(299,  csrrc, mstatus,	x9,  x8,  	0x12340080,	0x00000080);
	TEST_CSR_OP(300, csrrc, mstatus,	x10, x9,  	0x12340080,	0x00000000);
	TEST_CSR_OP(301, csrrc, mstatus,	x11, x10, 	0x12340080,	0x00000000);
	TEST_CSR_OP(302, csrrc, mstatus,	x12, x11, 	0x12340080,	0x00000000);
	TEST_CSR_OP(303, csrrc, mstatus,	x13, x12, 	0x12340000,	0x00000000);
	TEST_CSR_OP(304, csrrc, mstatus,	x14, x13, 	0x12340000,	0x00000000);
	TEST_CSR_OP(305, csrrc, mstatus,	x15, x14, 	0x12340000,	0x00000000);
	#--
	li		x1,0xFFFFFFFF
	csrrw	x0,mstatus,x1
	#--
	TEST_CSR_OP(306, csrrc, mstatus,	x16, x15, 	0x12340000,	0x00000088);
	TEST_CSR_OP(307, csrrc, mstatus,	x17, x16, 	0x12340000,	0x00000088);
	TEST_CSR_OP(308, csrrc, mstatus,	x18, x17, 	0x12340000,	0x00000088);
	TEST_CSR_OP(309, csrrc, mstatus,	x19, x18, 	0x12340000,	0x00000088);
	TEST_CSR_OP(310, csrrc, mstatus,	x20, x19, 	0x12340008,	0x00000088);
	TEST_CSR_OP(311, csrrc, mstatus,	x21, x20, 	0x12340008,	0x00000080);
	TEST_CSR_OP(312, csrrc, mstatus,	x22, x21, 	0x12340008,	0x00000080);
	TEST_CSR_OP(313, csrrc, mstatus,	x23, x22, 	0x12340008,	0x00000080);
	TEST_CSR_OP(314, csrrc, mstatus,	x24, x23, 	0x12340080,	0x00000080);
	TEST_CSR_OP(315, csrrc, mstatus,	x25, x24, 	0x12340080,	0x00000000);
	TEST_CSR_OP(316, csrrc, mstatus,	x26, x25, 	0x12340080,	0x00000000);
	TEST_CSR_OP(317, csrrc, mstatus,	x27, x26, 	0x12340080,	0x00000000);
	TEST_CSR_OP(318, csrrc, mstatus,	x28, x27, 	0x12340000,	0x00000000);
	TEST_CSR_OP(319, csrrc, mstatus,	x29, x28, 	0x12340000,	0x00000000);

	# --------------------------------
	# -- MIE
	TEST_CSR_OP(320, csrrc, mie,	x1,  x30, 	0x12340000,	0x00000808);
	TEST_CSR_OP(321, csrrc, mie,	x2,  x1,  	0x12340000,	0x00000808);
	TEST_CSR_OP(322, csrrc, mie,	x3,  x2,  	0x12340000,	0x00000808);
	TEST_CSR_OP(323, csrrc, mie,	x4,  x3,  	0x12340000,	0x00000808);
	TEST_CSR_OP(324, csrrc, mie,	x5,  x4,  	0x12340008,	0x00000808);
	TEST_CSR_OP(325, csrrc, mie,	x6,  x5,  	0x12340008,	0x00000800);
	TEST_CSR_OP(326, csrrc, mie,	x7,  x6,  	0x12340008,	0x00000800);
	TEST_CSR_OP(327, csrrc, mie,	x8,  x7,  	0x12340008,	0x00000800);
	TEST_CSR_OP(328, csrrc, mie,	x9,  x8,  	0x12340800,	0x00000800);
	TEST_CSR_OP(329, csrrc, mie,	x10, x9,  	0x12340800,	0x00000000);
	TEST_CSR_OP(330, csrrc, mie,	x11, x10, 	0x12340800,	0x00000000);
	TEST_CSR_OP(331, csrrc, mie,	x12, x11, 	0x12340800,	0x00000000);
	TEST_CSR_OP(332, csrrc, mie,	x13, x12, 	0x12340000,	0x00000000);
	TEST_CSR_OP(333, csrrc, mie,	x14, x13, 	0x12340000,	0x00000000);
	TEST_CSR_OP(334, csrrc, mie,	x15, x14, 	0x12340000,	0x00000000);
	# --
	li		x1,0xFFFFFFFF
	csrrw	x0,mie,x1
	# --
	TEST_CSR_OP(335, csrrc, mie,	x16, x15, 	0x12340000,	0x00000808);
	TEST_CSR_OP(336, csrrc, mie,	x17, x16, 	0x12340000,	0x00000808);
	TEST_CSR_OP(337, csrrc, mie,	x18, x17, 	0x12340000,	0x00000808);
	TEST_CSR_OP(338, csrrc, mie,	x19, x18, 	0x12340000,	0x00000808);
	TEST_CSR_OP(339, csrrc, mie,	x20, x19, 	0x12340008,	0x00000808);
	TEST_CSR_OP(340, csrrc, mie,	x21, x20, 	0x12340008,	0x00000800);
	TEST_CSR_OP(341, csrrc, mie,	x22, x21, 	0x12340008,	0x00000800);
	TEST_CSR_OP(342, csrrc, mie,	x23, x22, 	0x12340008,	0x00000800);
	TEST_CSR_OP(343, csrrc, mie,	x24, x23, 	0x12340800,	0x00000800);
	TEST_CSR_OP(344, csrrc, mie,	x25, x24, 	0x12340800,	0x00000000);
	TEST_CSR_OP(345, csrrc, mie,	x26, x25, 	0x12340800,	0x00000000);
	TEST_CSR_OP(346, csrrc, mie,	x27, x26, 	0x12340800,	0x00000000);
	TEST_CSR_OP(347, csrrc, mie,	x28, x27, 	0x12340000,	0x00000000);
	TEST_CSR_OP(348, csrrc, mie,	x29, x28, 	0x12340000,	0x00000000);

	# --------------------------------
	# -- MTVEC
	TEST_CSR_OP(349, csrrc, mtvec,	x1,  x30, 	0x00000001,	0xFFFFFFFF);
	TEST_CSR_OP(350, csrrc, mtvec,	x2,  x1,  	0x00000010,	0xFFFFFFFE);
	TEST_CSR_OP(351, csrrc, mtvec,	x3,  x2,  	0x00000100,	0xFFFFFFEE);
	TEST_CSR_OP(352, csrrc, mtvec,	x4,  x3,  	0x00001000,	0xFFFFFEEE);
	TEST_CSR_OP(353, csrrc, mtvec,	x5,  x4,  	0x00010000,	0xFFFFEEEE);
	TEST_CSR_OP(354, csrrc, mtvec,	x6,  x5,  	0x00100000,	0xFFFEEEEE);
	TEST_CSR_OP(355, csrrc, mtvec,	x7,  x6,  	0x01000000,	0xFFEEEEEE);
	TEST_CSR_OP(356, csrrc, mtvec,	x8,  x7,  	0x10000000,	0xFEEEEEEE);
	TEST_CSR_OP(357, csrrc, mtvec,	x9,  x8,  	0x00000004,	0xEEEEEEEE);
	TEST_CSR_OP(358, csrrc, mtvec,	x10, x9,  	0x00000040,	0xEEEEEEEA);
	TEST_CSR_OP(359, csrrc, mtvec,	x11, x10, 	0x00000400,	0xEEEEEEAA);
	TEST_CSR_OP(360, csrrc, mtvec,	x12, x11, 	0x00004000,	0xEEEEEAAA);
	TEST_CSR_OP(361, csrrc, mtvec,	x13, x12, 	0x00040000,	0xEEEEAAAA);
	TEST_CSR_OP(362, csrrc, mtvec,	x14, x13, 	0x00400000,	0xEEEAAAAA);
	TEST_CSR_OP(363, csrrc, mtvec,	x15, x14, 	0x04000000,	0xEEAAAAAA);
	# --
	li		x1,0xFFFFFFFF
	csrrw x0,mtvec,x1
	# --
	TEST_CSR_OP(364, csrrc, mtvec,	x16, x15, 	0x00000001,	0xFFFFFFFF);
	TEST_CSR_OP(365, csrrc, mtvec,	x17, x16, 	0x00000010,	0xFFFFFFFE);
	TEST_CSR_OP(366, csrrc, mtvec,	x18, x17, 	0x00000100,	0xFFFFFFEE);
	TEST_CSR_OP(367, csrrc, mtvec,	x19, x18, 	0x00001000,	0xFFFFFEEE);
	TEST_CSR_OP(368, csrrc, mtvec,	x20, x19, 	0x00010000,	0xFFFFEEEE);
	TEST_CSR_OP(369, csrrc, mtvec,	x21, x20, 	0x00100000,	0xFFFEEEEE);
	TEST_CSR_OP(370, csrrc, mtvec,	x22, x21, 	0x01000000,	0xFFEEEEEE);
	TEST_CSR_OP(371, csrrc, mtvec,	x23, x22, 	0x10000000,	0xFEEEEEEE);
	TEST_CSR_OP(372, csrrc, mtvec,	x24, x23, 	0x00000004,	0xEEEEEEEE);
	TEST_CSR_OP(373, csrrc, mtvec,	x25, x24, 	0x00000040,	0xEEEEEEEA);
	TEST_CSR_OP(374, csrrc, mtvec,	x26, x25, 	0x00000400,	0xEEEEEEAA);
	TEST_CSR_OP(375, csrrc, mtvec,	x27, x26, 	0x00004000,	0xEEEEEAAA);
	TEST_CSR_OP(376, csrrc, mtvec,	x28, x27, 	0x00040000,	0xEEEEAAAA);
	TEST_CSR_OP(377, csrrc, mtvec,	x29, x28, 	0x00400000,	0xEEEAAAAA);

	# --------------------------------
	# -- MEPC
	TEST_CSR_OP(378, csrrc, mepc,	x1,  x30, 	0x00000005,	0xFFFFFFFC);
	TEST_CSR_OP(379, csrrc, mepc,	x2,  x1,  	0x00000050,	0xFFFFFFF8);
	TEST_CSR_OP(380, csrrc, mepc,	x3,  x2,  	0x00000500,	0xFFFFFFA8);
	TEST_CSR_OP(381, csrrc, mepc,	x4,  x3,  	0x00005000,	0xFFFFFAA8);
	TEST_CSR_OP(382, csrrc, mepc,	x5,  x4,  	0x00050000,	0xFFFFAAA8);
	TEST_CSR_OP(383, csrrc, mepc,	x6,  x5,  	0x00500000,	0xFFFAAAA8);
	TEST_CSR_OP(384, csrrc, mepc,	x7,  x6,  	0x05000000,	0xFFAAAAA8);
	TEST_CSR_OP(385, csrrc, mepc,	x8,  x7,  	0x50000000,	0xFAAAAAA8);
	TEST_CSR_OP(386, csrrc, mepc,	x9,  x8,  	0x00000008,	0xAAAAAAA8);
	TEST_CSR_OP(387, csrrc, mepc,	x10, x9,  	0x00000080,	0xAAAAAAA0);
	TEST_CSR_OP(388, csrrc, mepc,	x11, x10, 	0x00000800,	0xAAAAAA20);
	TEST_CSR_OP(389, csrrc, mepc,	x12, x11, 	0x00008000,	0xAAAAA220);
	TEST_CSR_OP(390, csrrc, mepc,	x13, x12, 	0x00080000,	0xAAAA2220);
	TEST_CSR_OP(391, csrrc, mepc,	x14, x13, 	0x00800000,	0xAAA22220);
	TEST_CSR_OP(392, csrrc, mepc,	x15, x14, 	0x08000000,	0xAA222220);
	# --
	li	x1,0xFFFFFFFF
	csrrw x0,mepc,x1
	# --
	TEST_CSR_OP(393, csrrc, mepc,	x16, x15, 	0x00000005,	0xFFFFFFFC);
	TEST_CSR_OP(394, csrrc, mepc,	x17, x16, 	0x00000050,	0xFFFFFFF8);
	TEST_CSR_OP(395, csrrc, mepc,	x18, x17, 	0x00000500,	0xFFFFFFA8);
	TEST_CSR_OP(396, csrrc, mepc,	x19, x18, 	0x00005000,	0xFFFFFAA8);
	TEST_CSR_OP(397, csrrc, mepc,	x20, x19, 	0x00050000,	0xFFFFAAA8);
	TEST_CSR_OP(398, csrrc, mepc,	x21, x20, 	0x00500000,	0xFFFAAAA8);
	TEST_CSR_OP(399, csrrc, mepc,	x22, x21, 	0x05000000,	0xFFAAAAA8);
	TEST_CSR_OP(400, csrrc, mepc,	x23, x22, 	0x50000000,	0xFAAAAAA8);
	TEST_CSR_OP(401, csrrc, mepc,	x24, x23, 	0x00000008,	0xAAAAAAA8);
	TEST_CSR_OP(402, csrrc, mepc,	x25, x24, 	0x00000080,	0xAAAAAAA0);
	TEST_CSR_OP(403, csrrc, mepc,	x26, x25, 	0x00000800,	0xAAAAAA20);
	TEST_CSR_OP(404, csrrc, mepc,	x27, x26, 	0x00008000,	0xAAAAA220);
	TEST_CSR_OP(405, csrrc, mepc,	x28, x27, 	0x00080000,	0xAAAA2220);
	TEST_CSR_OP(406, csrrc, mepc,	x29, x28, 	0x00800000,	0xAAA22220);

	# --------------------------------
	# -- MCAUSE
	TEST_CSR_OP(407, csrrc, mcause,x1,  x30, 	0x01230000,	0x8000000F);
	TEST_CSR_OP(408, csrrc, mcause,x2,  x1,  	0x01230001,	0x8000000F);
	TEST_CSR_OP(409, csrrc, mcause,x3,  x2,  	0x01230002,	0x8000000E);
	TEST_CSR_OP(410, csrrc, mcause,x4,  x3,  	0x01230003,	0x8000000C);
	TEST_CSR_OP(411, csrrc, mcause,x5,  x4,  	0x01230004,	0x8000000C);
	TEST_CSR_OP(412, csrrc, mcause,x6,  x5,  	0x01230005,	0x80000008);
	TEST_CSR_OP(413, csrrc, mcause,x7,  x6,  	0x01230006,	0x80000008);
	TEST_CSR_OP(414, csrrc, mcause,x8,  x7,  	0x01230007,	0x80000008);
	TEST_CSR_OP(415, csrrc, mcause,x9,  x8,  	0x01230008,	0x80000008);
	TEST_CSR_OP(416, csrrc, mcause,	x10, x9,  	0x01230009,	0x80000000);
	TEST_CSR_OP(417, csrrc, mcause,	x11, x10, 	0x0123000A,	0x80000000);
	TEST_CSR_OP(418, csrrc, mcause,	x12, x11, 	0x0123000B,	0x80000000);
	TEST_CSR_OP(419, csrrc, mcause,	x13, x12, 	0x0123000C,	0x80000000);
	TEST_CSR_OP(420, csrrc, mcause,	x14, x13, 	0x0123000D,	0x80000000);
	TEST_CSR_OP(421, csrrc, mcause,	x15, x14, 	0x0123000E,	0x80000000);
	# --
	li	x1,0xFFFFFFFF
	csrrw x0,mcause,x1
	# --
	TEST_CSR_OP(422, csrrc, mcause,	x16, x15, 	0x81230000,	0x8000000F);
	TEST_CSR_OP(423, csrrc, mcause,	x17, x16, 	0x81230001,	0x0000000F);
	TEST_CSR_OP(424, csrrc, mcause,	x18, x17, 	0x81230002,	0x0000000E);
	TEST_CSR_OP(425, csrrc, mcause,	x19, x18, 	0x81230003,	0x0000000C);
	TEST_CSR_OP(426, csrrc, mcause,	x20, x19, 	0x81230004,	0x0000000C);
	TEST_CSR_OP(427, csrrc, mcause,	x21, x20, 	0x81230005,	0x00000008);
	TEST_CSR_OP(428, csrrc, mcause,	x22, x21, 	0x81230006,	0x00000008);
	TEST_CSR_OP(429, csrrc, mcause,	x23, x22, 	0x81230007,	0x00000008);
	TEST_CSR_OP(430, csrrc, mcause,	x24, x23, 	0x81230008,	0x00000008);
	TEST_CSR_OP(431, csrrc, mcause,	x25, x24, 	0x81230009,	0x00000000);
	TEST_CSR_OP(432, csrrc, mcause,	x26, x25, 	0x8123000A,	0x00000000);
	TEST_CSR_OP(433, csrrc, mcause,	x27, x26, 	0x8123000B,	0x00000000);
	TEST_CSR_OP(434, csrrc, mcause,	x28, x27, 	0x8123000C,	0x00000000);
	TEST_CSR_OP(435, csrrc, mcause,	x29, x28, 	0x8123000D,	0x00000000);

# ---------------------------------------------------
# PASS Basic Tests
	PASS

# ---------------------------------------------------
# FAIL Basic Tests
	FAIL
