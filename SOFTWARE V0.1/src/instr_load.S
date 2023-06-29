# ---------------------------------------------------
#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
.equ ram_base,	0x0000000

# equ LW
.equ result1_lw,	0x12345678
.equ result2_lw,	0x23456789
.equ result3_lw,	0x3456789a
.equ result4_lw,	0x456789ab
.equ result5_lw,	0x56789abc
.equ result6_lw,	0x6789abcd
.equ result7_lw,	0x789abcde
.equ result8_lw,	0x89abcdef
.equ result9_lw,	0x9abcdef0
.equ result10_lw,	0xabcdef01
.equ result11_lw,	0xbcdef012
.equ result12_lw,	0xcdef0123
.equ result13_lw,	0xdef01234
.equ result14_lw,	0xef012345
.equ result15_lw,	0xf0123456
.equ result16_lw,	0x01234567
.equ result17_lw,	0x12345678
.equ result18_lw,	0x23456789
.equ result19_lw,	0x3456789a
.equ result20_lw,	0x456789ab
.equ result21_lw,	0x56789abc
.equ result22_lw,	0x6789abcd
.equ result23_lw,	0x789abcde
.equ result24_lw,	0x89abcdef
.equ result25_lw,	0x9abcdef0
.equ result26_lw,	0xabcdef01
.equ result27_lw,	0xbcdef012
.equ result28_lw,	0xcdef1023
.equ result29_lw,	0xdef01234

# equ LH
.equ result1_lh,	0x00005678
.equ result2_lh,	0x00006789
.equ result3_lh,	0x0000789a
.equ result4_lh,	0xffff89ab
.equ result5_lh,	0xffff9abc
.equ result6_lh,	0xffffabcd
.equ result7_lh,	0xffffbcde
.equ result8_lh,	0xffffcdef
.equ result9_lh,	0xffffdef0
.equ result10_lh,	0xffffef01
.equ result11_lh,	0xfffff012
.equ result12_lh,	0x00000123
.equ result13_lh,	0x00001234
.equ result14_lh,	0x00002345
.equ result15_lh,	0x00003456
.equ result16_lh,	0x00001234
.equ result17_lh,	0x00002345
.equ result18_lh,	0x00003456
.equ result19_lh,	0x00004567
.equ result20_lh,	0x00005678
.equ result21_lh,	0x00006789
.equ result22_lh,	0x0000789a
.equ result23_lh,	0xffff89ab
.equ result24_lh,	0xffff9abc
.equ result25_lh,	0xffffabcd
.equ result26_lh,	0xffffbcde
.equ result27_lh,	0xffffcdef
.equ result28_lh,	0xffffdef0
.equ result29_lh,	0xffffef01

# equ LHU
.equ result1_lhu,	0x00005678
.equ result2_lhu,	0x00006789
.equ result3_lhu,	0x0000789a
.equ result4_lhu,	0x000089ab
.equ result5_lhu,	0x00009abc
.equ result6_lhu,	0x0000abcd
.equ result7_lhu,	0x0000bcde
.equ result8_lhu,	0x0000cdef
.equ result9_lhu,	0x0000def0
.equ result10_lhu,	0x0000ef01
.equ result11_lhu,	0x0000f012
.equ result12_lhu,	0x00000123
.equ result13_lhu,	0x00001234
.equ result14_lhu,	0x00002345
.equ result15_lhu,	0x00003456
.equ result16_lhu,	0x00001234
.equ result17_lhu,	0x00002345
.equ result18_lhu,	0x00003456
.equ result19_lhu,	0x00004567
.equ result20_lhu,	0x00005678
.equ result21_lhu,	0x00006789
.equ result22_lhu,	0x0000789a
.equ result23_lhu,	0x000089ab
.equ result24_lhu,	0x00009abc
.equ result25_lhu,	0x0000abcd
.equ result26_lhu,	0x0000bcde
.equ result27_lhu,	0x0000cdef
.equ result28_lhu,	0x0000def0
.equ result29_lhu,	0x0000ef01

# equ LB
.equ result1_lb,	0x00000078
.equ result2_lb,	0xffffff89
.equ result3_lb,	0xffffff9a
.equ result4_lb,	0xffffffab
.equ result5_lb,	0xffffffbc
.equ result6_lb,	0xffffffcd
.equ result7_lb,	0xffffffde
.equ result8_lb,	0x00000056
.equ result9_lb,	0x00000067
.equ result10_lb,	0x00000078
.equ result11_lb,	0xffffff89
.equ result12_lb,	0xffffff9a
.equ result13_lb,	0xffffffab
.equ result14_lb,	0xffffffbc
.equ result15_lb,	0xffffffcd
.equ result16_lb,	0x00000034
.equ result17_lb,	0x00000045
.equ result18_lb,	0x00000056
.equ result19_lb,	0x00000067
.equ result20_lb,	0x00000078
.equ result21_lb,	0xffffff89
.equ result22_lb,	0xffffff9a
.equ result23_lb,	0x00000012
.equ result24_lb,	0x00000023
.equ result25_lb,	0x00000034
.equ result26_lb,	0x00000045
.equ result27_lb,	0x00000056
.equ result28_lb,	0x00000067
.equ result29_lb,	0x00000078

# equ LBU
.equ result1_lbu,	0x00000078
.equ result2_lbu,	0x00000089
.equ result3_lbu,	0x0000009a
.equ result4_lbu,	0x000000ab
.equ result5_lbu,	0x000000bc
.equ result6_lbu,	0x000000cd
.equ result7_lbu,	0x000000de
.equ result8_lbu,	0x00000056
.equ result9_lbu,	0x00000067
.equ result10_lbu,	0x00000078
.equ result11_lbu,	0x00000089
.equ result12_lbu,	0x0000009a
.equ result13_lbu,	0x000000ab
.equ result14_lbu,	0x000000bc
.equ result15_lbu,	0x000000cd
.equ result16_lbu,	0x00000034
.equ result17_lbu,	0x00000045
.equ result18_lbu,	0x00000056
.equ result19_lbu,	0x00000067
.equ result20_lbu,	0x00000078
.equ result21_lbu,	0x00000089
.equ result22_lbu,	0x0000009a
.equ result23_lbu,	0x00000012
.equ result24_lbu,	0x00000023
.equ result25_lbu,	0x00000034
.equ result26_lbu,	0x00000045
.equ result27_lbu,	0x00000056
.equ result28_lbu,	0x00000067
.equ result29_lbu,	0x00000078

# ---------------------------------------------------
.section .text,"ax"
_load_s_:

# ---------------------------------------------------
# LW INSTRUCTION
	# TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)
	TEST_LOAD_OP(1 , lw , x1 , x31, result1_lw , 0);
	TEST_LOAD_OP(2 , lw , x2 , x1 , result2_lw , 4);
	TEST_LOAD_OP(3 , lw , x3 , x2 , result3_lw , 8);
	TEST_LOAD_OP(4 , lw , x4 , x3 , result4_lw , 12);
	TEST_LOAD_OP(5 , lw , x5 , x4 , result5_lw , 16);
	TEST_LOAD_OP(6 , lw , x6 , x5 , result6_lw , 20);
	TEST_LOAD_OP(7 , lw , x7 , x6 , result7_lw , 24);
	TEST_LOAD_OP(8 , lw , x8 , x7 , result8_lw , 28);
	TEST_LOAD_OP(9 , lw , x9 , x8 , result9_lw , 32);
	TEST_LOAD_OP(10, lw , x10, x9 , result10_lw , 36);
	TEST_LOAD_OP(11, lw , x11, x10, result11_lw , 40);
	TEST_LOAD_OP(12, lw , x12, x11, result12_lw , 44);
	TEST_LOAD_OP(13, lw , x13, x12, result13_lw , 48);
	TEST_LOAD_OP(14, lw , x14, x13, result14_lw , 52);
	TEST_LOAD_OP(15, lw , x15, x14, result15_lw , 56);
	TEST_LOAD_OP(16, lw , x16, x15, result16_lw , 60);
	TEST_LOAD_OP(17, lw , x17, x16, result17_lw , 64);
	TEST_LOAD_OP(18, lw , x18, x17, result18_lw , 68);
	TEST_LOAD_OP(19, lw , x19, x18, result19_lw , 72);
	TEST_LOAD_OP(20, lw , x20, x19, result20_lw , 76);
	TEST_LOAD_OP(21, lw , x21, x20, result21_lw , 80);
	TEST_LOAD_OP(22, lw , x22, x21, result22_lw , 84);
	TEST_LOAD_OP(23, lw , x23, x22, result23_lw , 88);
	TEST_LOAD_OP(24, lw , x24, x23, result24_lw , 92);
	TEST_LOAD_OP(25, lw , x25, x24, result25_lw , 96);
	TEST_LOAD_OP(26, lw , x26, x25, result26_lw , 100);
	TEST_LOAD_OP(27, lw , x27, x26, result27_lw , 104);
	TEST_LOAD_OP(28, lw , x28, x27, result28_lw , 108);
	TEST_LOAD_OP(29, lw , x29, x28, result29_lw , 112);

# ---------------------------------------------------
# LH INSTRUCTION
	# TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)
	# lower half-word
	TEST_LOAD_OP(30, lh , x1 , x31, result1_lh , 0);
	TEST_LOAD_OP(31, lh , x2 , x1 , result2_lh , 4);
	TEST_LOAD_OP(32, lh , x3 , x2 , result3_lh , 8);
	TEST_LOAD_OP(33, lh , x4 , x3 , result4_lh , 12);
	TEST_LOAD_OP(34, lh , x5 , x4 , result5_lh , 16);
	TEST_LOAD_OP(35, lh , x6 , x5 , result6_lh , 20);
	TEST_LOAD_OP(36, lh , x7 , x6 , result7_lh , 24);
	TEST_LOAD_OP(37, lh , x8 , x7 , result8_lh , 28);
	TEST_LOAD_OP(38, lh , x9 , x8 , result9_lh , 32);
	TEST_LOAD_OP(39, lh , x10, x9 , result10_lh, 36);
	TEST_LOAD_OP(40, lh , x11, x10, result11_lh, 40);
	TEST_LOAD_OP(41, lh , x12, x11, result12_lh, 44);
	TEST_LOAD_OP(42, lh , x13, x12, result13_lh, 48);
	TEST_LOAD_OP(43, lh , x14, x13, result14_lh, 52);
	TEST_LOAD_OP(44, lh , x15, x14, result15_lh, 56);
	# upper half-word
	TEST_LOAD_OP(45, lh , x16, x15, result16_lh, 2);
	TEST_LOAD_OP(46, lh , x17, x16, result17_lh, 6);
	TEST_LOAD_OP(47, lh , x18, x17, result18_lh, 10);
	TEST_LOAD_OP(48, lh , x19, x18, result19_lh, 14);
	TEST_LOAD_OP(49, lh , x20, x19, result20_lh, 18);
	TEST_LOAD_OP(50, lh , x21, x20, result21_lh, 22);
	TEST_LOAD_OP(51, lh , x22, x21, result22_lh, 26);
	TEST_LOAD_OP(52, lh , x23, x22, result23_lh, 30);
	TEST_LOAD_OP(53, lh , x24, x23, result24_lh, 34);
	TEST_LOAD_OP(54, lh , x25, x24, result25_lh, 38);
	TEST_LOAD_OP(55, lh , x26, x25, result26_lh, 42);
	TEST_LOAD_OP(56, lh , x27, x26, result27_lh, 46);
	TEST_LOAD_OP(57, lh , x28, x27, result28_lh, 50);
	TEST_LOAD_OP(58, lh , x29, x28, result29_lh, 54);

# ---------------------------------------------------
# LHU INSTRUCTION
	# TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)
	# lower half-word
	TEST_LOAD_OP(59, lhu , x1 , x31, result1_lhu , 0);
	TEST_LOAD_OP(60, lhu , x2 , x1 , result2_lhu , 4);
	TEST_LOAD_OP(61, lhu , x3 , x2 , result3_lhu , 8);
	TEST_LOAD_OP(62, lhu , x4 , x3 , result4_lhu , 12);
	TEST_LOAD_OP(63, lhu , x5 , x4 , result5_lhu , 16);
	TEST_LOAD_OP(64, lhu , x6 , x5 , result6_lhu , 20);
	TEST_LOAD_OP(65, lhu , x7 , x6 , result7_lhu , 24);
	TEST_LOAD_OP(66, lhu , x8 , x7 , result8_lhu , 28);
	TEST_LOAD_OP(67, lhu , x9 , x8 , result9_lhu , 32);
	TEST_LOAD_OP(68, lhu , x10, x9 , result10_lhu, 36);
	TEST_LOAD_OP(69, lhu , x11, x10, result11_lhu, 40);
	TEST_LOAD_OP(70, lhu , x12, x11, result12_lhu, 44);
	TEST_LOAD_OP(71, lhu , x13, x12, result13_lhu, 48);
	TEST_LOAD_OP(72, lhu , x14, x13, result14_lhu, 52);
	TEST_LOAD_OP(73, lhu , x15, x14, result15_lhu, 56);
	# upper half-word
	TEST_LOAD_OP(74, lhu , x16, x15, result16_lhu, 2);
	TEST_LOAD_OP(75, lhu , x17, x16, result17_lhu, 6);
	TEST_LOAD_OP(76, lhu , x18, x17, result18_lhu, 10);
	TEST_LOAD_OP(77, lhu , x19, x18, result19_lhu, 14);
	TEST_LOAD_OP(78, lhu , x20, x19, result20_lhu, 18);
	TEST_LOAD_OP(79, lhu , x21, x20, result21_lhu, 22);
	TEST_LOAD_OP(80, lhu , x22, x21, result22_lhu, 26);
	TEST_LOAD_OP(81, lhu , x23, x22, result23_lhu, 30);
	TEST_LOAD_OP(82, lhu , x24, x23, result24_lhu, 34);
	TEST_LOAD_OP(83, lhu , x25, x24, result25_lhu, 38);
	TEST_LOAD_OP(84, lhu , x26, x25, result26_lhu, 42);
	TEST_LOAD_OP(85, lhu , x27, x26, result27_lhu, 46);
	TEST_LOAD_OP(86, lhu , x28, x27, result28_lhu, 50);
	TEST_LOAD_OP(87, lhu , x29, x28, result29_lhu, 54);

# ---------------------------------------------------
# LB INSTRUCTION
	# TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)
	# byte 0
	TEST_LOAD_OP(88 , lb , x1 , x31, result1_lb , 0);
	TEST_LOAD_OP(89 , lb , x2 , x1 , result2_lb , 4);
	TEST_LOAD_OP(90 , lb , x3 , x2 , result3_lb , 8);
	TEST_LOAD_OP(91 , lb , x4 , x3 , result4_lb , 12);
	TEST_LOAD_OP(92 , lb , x5 , x4 , result5_lb , 16);
	TEST_LOAD_OP(93 , lb , x6 , x5 , result6_lb , 20);
	TEST_LOAD_OP(94 , lb , x7 , x6 , result7_lb , 24);
	# byte 1
	TEST_LOAD_OP(95, lb , x8 , x7 , result8_lb , 1);
	TEST_LOAD_OP(96, lb , x9 , x8 , result9_lb , 5);
	TEST_LOAD_OP(97, lb , x10, x9 , result10_lb, 9);
	TEST_LOAD_OP(98, lb , x11, x10, result11_lb, 13);
	TEST_LOAD_OP(99, lb , x12, x11, result12_lb, 17);
	TEST_LOAD_OP(100, lb , x13, x12, result13_lb, 21);
	TEST_LOAD_OP(101, lb , x14, x13, result14_lb, 25);
	TEST_LOAD_OP(102, lb , x15, x14, result15_lb, 29);
	# byte 2
	TEST_LOAD_OP(103, lb , x16, x15, result16_lb, 2);
	TEST_LOAD_OP(104, lb , x17, x16, result17_lb, 6);
	TEST_LOAD_OP(105, lb , x18, x17, result18_lb, 10);
	TEST_LOAD_OP(106, lb , x19, x18, result19_lb, 14);
	TEST_LOAD_OP(107, lb , x20, x19, result20_lb, 18);
	TEST_LOAD_OP(108, lb , x21, x20, result21_lb, 22);
	TEST_LOAD_OP(109, lb , x22, x21, result22_lb, 26);
	# byte 3
	TEST_LOAD_OP(110, lb , x23, x22, result23_lb, 3);
	TEST_LOAD_OP(111, lb , x24, x23, result24_lb, 7);
	TEST_LOAD_OP(112, lb , x25, x24, result25_lb, 11);
	TEST_LOAD_OP(113, lb , x26, x25, result26_lb, 15);
	TEST_LOAD_OP(114, lb , x27, x26, result27_lb, 19);
	TEST_LOAD_OP(115, lb , x28, x27, result28_lb, 23);
	TEST_LOAD_OP(116, lb , x29, x28, result29_lb, 27);

# ---------------------------------------------------
# LBU INSTRUCTION
	# TEST_LOAD_OP(testnum , inst , rd , rs1 , result , imm)
	# byte 0
	TEST_LOAD_OP(117 , lbu , x1 , x31, result1_lbu , 0);
	TEST_LOAD_OP(118 , lbu , x2 , x1 , result2_lbu , 4);
	TEST_LOAD_OP(119 , lbu , x3 , x2 , result3_lbu , 8);
	TEST_LOAD_OP(120 , lbu , x4 , x3 , result4_lbu , 12);
	TEST_LOAD_OP(121 , lbu , x5 , x4 , result5_lbu , 16);
	TEST_LOAD_OP(122 , lbu , x6 , x5 , result6_lbu , 20);
	TEST_LOAD_OP(123 , lbu , x7 , x6 , result7_lbu , 24);
	# byte 1
	TEST_LOAD_OP(124, lbu , x8 , x7 , result8_lbu , 1);
	TEST_LOAD_OP(125, lbu , x9 , x8 , result9_lbu , 5);
	TEST_LOAD_OP(126, lbu , x10, x9 , result10_lbu, 9);
	TEST_LOAD_OP(127, lbu , x11, x10, result11_lbu, 13);
	TEST_LOAD_OP(128, lbu , x12, x11, result12_lbu, 17);
	TEST_LOAD_OP(129, lbu , x13, x12, result13_lbu, 21);
	TEST_LOAD_OP(130, lbu , x14, x13, result14_lbu, 25);
	TEST_LOAD_OP(131, lbu , x15, x14, result15_lbu, 29);
	# byte 2
	TEST_LOAD_OP(132, lbu , x16, x15, result16_lbu, 2);
	TEST_LOAD_OP(133, lbu , x17, x16, result17_lbu, 6);
	TEST_LOAD_OP(134, lbu , x18, x17, result18_lbu, 10);
	TEST_LOAD_OP(135, lbu , x19, x18, result19_lbu, 14);
	TEST_LOAD_OP(136, lbu , x20, x19, result20_lbu, 18);
	TEST_LOAD_OP(137, lbu , x21, x20, result21_lbu, 22);
	TEST_LOAD_OP(138, lbu , x22, x21, result22_lbu, 26);
	# byte 3
	TEST_LOAD_OP(139, lbu , x23, x22, result23_lbu, 3);
	TEST_LOAD_OP(140, lbu , x24, x23, result24_lbu, 7);
	TEST_LOAD_OP(141, lbu , x25, x24, result25_lbu, 11);
	TEST_LOAD_OP(142, lbu , x26, x25, result26_lbu, 15);
	TEST_LOAD_OP(143, lbu , x27, x26, result27_lbu, 19);
	TEST_LOAD_OP(144, lbu , x28, x27, result28_lbu, 23);
	TEST_LOAD_OP(145, lbu , x29, x28, result29_lbu, 27);

# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data

	lw_data:	.word	result1_lw, result2_lw, result3_lw, result4_lw, result5_lw, result6_lw, result7_lw, result8_lw, result9_lw, result10_lw,	\
	result11_lw, result12_lw, result13_lw, result14_lw, result15_lw, result16_lw, result17_lw, result18_lw, result19_lw, result20_lw,				\
	result21_lw, result22_lw, result23_lw, result24_lw, result25_lw, result26_lw, result27_lw, result28_lw, result29_lw
