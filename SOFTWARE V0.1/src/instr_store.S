# ------------------------------------
#include "test_macros.h"

# ---------------------------------------------------

.equ ram_base,	0x0000000

# equ SW

.equ result1_sw,	0x12345678
.equ result2_sw,	0x23456789
.equ result3_sw,	0x3456789a
.equ result4_sw,	0x456789ab
.equ result5_sw,	0x56789abc
.equ result6_sw,	0x6789abcd
.equ result7_sw,	0x789abcde
.equ result8_sw,	0x89abcdef
.equ result9_sw,	0x9abcdef0
.equ result10_sw,	0xabcdef01
.equ result11_sw,	0xbcdef012
.equ result12_sw,	0xcdef0123
.equ result13_sw,	0xdef01234
.equ result14_sw,	0xef012345
.equ result15_sw,	0xf0123456
.equ result16_sw,	0x01234567
.equ result17_sw,	0x12345678
.equ result18_sw,	0x23456789
.equ result19_sw,	0x3456789a
.equ result20_sw,	0x456789ab
.equ result21_sw,	0x56789abc
.equ result22_sw,	0x6789abcd
.equ result23_sw,	0x789abcde
.equ result24_sw,	0x89abcdef
.equ result25_sw,	0x9abcdef0
.equ result26_sw,	0xabcdef01
.equ result27_sw,	0xbcdef012
.equ result28_sw,	0xcdef1023
.equ result29_sw,	0xdef01234

# equ SH
.equ result1_sh,	0x00005678
.equ result2_sh,	0x00006789
.equ result3_sh,	0x0000789a
.equ result4_sh,	0x000089ab
.equ result5_sh,	0x00009abc
.equ result6_sh,	0x0000abcd
.equ result7_sh,	0x0000bcde
.equ result8_sh,	0x0000cdef
.equ result9_sh,	0x0000def0
.equ result10_sh,	0x0000ef01
.equ result11_sh,	0x0000f012
.equ result12_sh,	0x00000123
.equ result13_sh,	0x00001234
.equ result14_sh,	0x00002345
.equ result15_sh,	0x00003456

.equ result16_sh,	0x45675678
.equ result17_sh,	0x56786789
.equ result18_sh,	0x6789789a
.equ result19_sh,	0x789a89ab
.equ result20_sh,	0x89ab9abc
.equ result21_sh,	0x9abcabcd
.equ result22_sh,	0xabcdbcde
.equ result23_sh,	0xbcdecdef
.equ result24_sh,	0xcdefdef0
.equ result25_sh,	0xdef0ef01
.equ result26_sh,	0xef01f012
.equ result27_sh,	0xf0120123
.equ result28_sh,	0x10231234
.equ result29_sh,	0x12342345

# equ SB
.equ result1_sb,	0x00000078
.equ result2_sb,	0x00000089
.equ result3_sb,	0x0000009a
.equ result4_sb,	0x000000ab
.equ result5_sb,	0x000000bc
.equ result6_sb,	0x000000cd
.equ result7_sb,	0x000000de

.equ result8_sb,	0x0000ef78
.equ result9_sb,	0x0000f089
.equ result10_sb,	0x0000019a
.equ result11_sb,	0x000012ab
.equ result12_sb,	0x000023bc
.equ result13_sb,	0x000034cd
.equ result14_sb,	0x000045de
.equ result15_sb,	0x00005600

.equ result16_sb,	0x0067ef78
.equ result17_sb,	0x0078f089
.equ result18_sb,	0x0089019a
.equ result19_sb,	0x009a12ab
.equ result20_sb,	0x00ab23bc
.equ result21_sb,	0x00bc34cd
.equ result22_sb,	0x00cd45de

.equ result23_sb,	0xde67ef78
.equ result24_sb,	0xef78f089
.equ result25_sb,	0xf089019a
.equ result26_sb,	0x019a12ab
.equ result27_sb,	0x12ab23bc
.equ result28_sb,	0x23bc34cd
.equ result29_sb,	0x34cd45de

# equ SW -> LH[U]
.equ result1_swlh,	0x00005678
.equ result2_swlh,	0xffff89ab
.equ result3_swlhu,	0x00006789
.equ result4_swlhu,	0x00009abc

# equ SW -> LB[U]
.equ result1_swlb,	0xffffff89
.equ result2_swlb,	0x00000067
.equ result3_swlb,	0x00000045
.equ result4_swlb,	0x00000023

.equ result1_swlbu,	0x00000089
.equ result2_swlbu,	0x00000067
.equ result3_swlbu,	0x00000045
.equ result4_swlbu,	0x00000023


# equ SH -> LH
.equ result1_shlh,	0x00005678
.equ result2_shlh,	0xffffcdef
.equ result3_shlh,	0xffffcdef
.equ result4_shlh,	0x00006789

.equ result1_shlhu,	0x00005678	
.equ result2_shlhu,	0x0000cdef
.equ result3_shlhu,	0x0000cdef
.equ result4_shlhu,	0x00006789

# equ SH -> LHU
.equ result1_shlb,	0x00000078
.equ result2_shlb,	0xffffffcd
.equ result3_shlb,	0xffffff89
.equ result4_shlb,	0xffffffde

.equ result1_shlbu,	0x00000078	
.equ result2_shlbu,	0x000000cd
.equ result3_shlbu,	0x00000089	
.equ result4_shlbu,	0x000000de

# equ SB -> LH[U]
.equ result1_sblh,	0x00000078
.equ result2_sblh,	0xffffef78
.equ result3_sblh,	0xffff8900
.equ result4_sblh,	0xffff89f0

.equ result1_sblhu,	0x00007800
.equ result2_sblhu,	0x000078ef
.equ result3_sblhu,	0x00000089
.equ result4_sblhu,	0x0000f089

# equ SB -> LB[U]
.equ result1_sblb,	0x00000078
.equ result2_sblb,	0xffffffef
.equ result3_sblb,	0xffffff89
.equ result4_sblb,	0xfffffff0

.equ result1_sblbu,	0x00000000
.equ result2_sblbu,	0x00000000
.equ result3_sblbu,	0x00000000
.equ result4_sblbu,	0x000000f0

# ---------------------------------------------------
.section .text,"ax"
_store_s_:

# ---------------------------------------------------
# SW INSTRUCTION
	# TEST_STORE_OP(testnum , inst , rs1, rs2 , result , imm)
	TEST_STORE_OP(1 , sw , x1 , x31, result1_sw , 0);
	TEST_STORE_OP(2 , sw , x2 , x1 , result2_sw , 4);
	TEST_STORE_OP(3 , sw , x3 , x2 , result3_sw , 8);
	TEST_STORE_OP(4 , sw , x4 , x3 , result4_sw , 12);
	TEST_STORE_OP(5 , sw , x5 , x4 , result5_sw , 16);
	TEST_STORE_OP(6 , sw , x6 , x5 , result6_sw , 20);
	TEST_STORE_OP(7 , sw , x7 , x6 , result7_sw , 24);
	TEST_STORE_OP(8 , sw , x8 , x7 , result8_sw , 28);
	TEST_STORE_OP(9 , sw , x9 , x8 , result9_sw , 32);
	TEST_STORE_OP(10, sw , x10, x9 , result10_sw, 36);
	TEST_STORE_OP(11, sw , x11, x10, result11_sw, 40);
	TEST_STORE_OP(12, sw , x12, x11, result12_sw, 44);
	TEST_STORE_OP(13, sw , x13, x12, result13_sw, 48);
	TEST_STORE_OP(14, sw , x14, x13, result14_sw, 52);
	TEST_STORE_OP(15, sw , x15, x14, result15_sw, 56);
	TEST_STORE_OP(16, sw , x16, x15, result16_sw, 60);
	TEST_STORE_OP(17, sw , x17, x16, result17_sw, 64);
	TEST_STORE_OP(18, sw , x18, x17, result18_sw, 68);
	TEST_STORE_OP(19, sw , x19, x18, result19_sw, 72);
	TEST_STORE_OP(20, sw , x20, x19, result20_sw, 76);
	TEST_STORE_OP(21, sw , x21, x20, result21_sw, 80);
	TEST_STORE_OP(22, sw , x22, x21, result22_sw, 84);
	TEST_STORE_OP(23, sw , x23, x22, result23_sw, 88);
	TEST_STORE_OP(24, sw , x24, x23, result24_sw, 92);
	TEST_STORE_OP(25, sw , x25, x24, result25_sw, 96);
	TEST_STORE_OP(26, sw , x26, x25, result26_sw, 100);
	TEST_STORE_OP(27, sw , x27, x26, result27_sw, 104);
	TEST_STORE_OP(28, sw , x28, x27, result28_sw, 108);
	TEST_STORE_OP(29, sw , x29, x28, result29_sw, 112);

# ---------------------------------------------------
# SH INSTRUCTION
	# TEST_STORE_LH_OP(testnum , inst , rs1, rs2 , result , val2 , imm)
	# lower half-word
	TEST_STORE_LH_OP(30 , sh , x1 , x31, result1_sh, result1_sw ,128);
	TEST_STORE_LH_OP(31 , sh , x2 , x1 , result2_sh, result2_sw ,132);
	TEST_STORE_LH_OP(32 , sh , x3 , x2 , result3_sh, result3_sw ,136);
	TEST_STORE_LH_OP(33 , sh , x4 , x3 , result4_sh, result4_sw ,140);
	TEST_STORE_LH_OP(34 , sh , x5 , x4 , result5_sh, result5_sw ,144);
	TEST_STORE_LH_OP(35 , sh , x6 , x5 , result6_sh, result6_sw ,148);
	TEST_STORE_LH_OP(36 , sh , x7 , x6 , result7_sh, result7_sw ,152);
	TEST_STORE_LH_OP(37 , sh , x8 , x7 , result8_sh, result8_sw ,156);
	TEST_STORE_LH_OP(38 , sh , x9 , x8 , result9_sh, result9_sw ,160);
	TEST_STORE_LH_OP(39, sh , x10, x9 ,  result10_sh, result10_sw, 164);
	TEST_STORE_LH_OP(40, sh , x11, x10,  result11_sh, result11_sw, 168);
	TEST_STORE_LH_OP(41, sh , x12, x11,  result12_sh, result12_sw, 172);
	TEST_STORE_LH_OP(42, sh , x13, x12,  result13_sh, result13_sw, 176);
	TEST_STORE_LH_OP(43, sh , x14, x13,  result14_sh, result14_sw, 180);
	TEST_STORE_LH_OP(44, sh , x15, x14,  result15_sh, result15_sw, 184);
	# TEST_STORE_UH_OP(testnum , inst , rs1, rs2 , result , val2 , imm)
	# upper half-word
	TEST_STORE_UH_OP(45, sh , x16, x15, result16_sh, result16_sw, 130);
	TEST_STORE_UH_OP(46, sh , x17, x16, result17_sh, result17_sw, 134);
	TEST_STORE_UH_OP(47, sh , x18, x17, result18_sh, result18_sw, 138);
	TEST_STORE_UH_OP(48, sh , x19, x18, result19_sh, result19_sw, 142);
	TEST_STORE_UH_OP(49, sh , x20, x19, result20_sh, result20_sw, 146);
	TEST_STORE_UH_OP(50, sh , x21, x20, result21_sh, result21_sw, 150);
	TEST_STORE_UH_OP(51, sh , x22, x21, result22_sh, result22_sw, 154);
	TEST_STORE_UH_OP(52, sh , x23, x22, result23_sh, result23_sw, 158);
	TEST_STORE_UH_OP(53, sh , x24, x23, result24_sh, result24_sw, 162);
	TEST_STORE_UH_OP(54, sh , x25, x24, result25_sh, result25_sw, 166);
	TEST_STORE_UH_OP(55, sh , x26, x25, result26_sh, result26_sw, 170);
	TEST_STORE_UH_OP(56, sh , x27, x26, result27_sh, result27_sw, 174);
	TEST_STORE_UH_OP(57, sh , x28, x27, result28_sh, result28_sw, 178);
	TEST_STORE_UH_OP(58, sh , x29, x28, result29_sh, result29_sw, 182);

# ---------------------------------------------------
# SB INSTRUCTION
	# TEST_STORE_B_OP(testnum , inst , rs1 , rs2 , result , val2 , imm , imm_offset)
	# byte 0
	TEST_STORE_B_OP(59 , sb , x1 , x31, result1_sb, result1_sw, 256	,0);
	TEST_STORE_B_OP(60 , sb , x2 , x1 , result2_sb, result2_sw, 260	,0);
	TEST_STORE_B_OP(61 , sb , x3 , x2 , result3_sb, result3_sw, 264	,0);
	TEST_STORE_B_OP(62 , sb , x4 , x3 , result4_sb, result4_sw, 268	,0);
	TEST_STORE_B_OP(63 , sb , x5 , x4 , result5_sb, result5_sw, 272	,0);
	TEST_STORE_B_OP(64 , sb , x6 , x5 , result6_sb, result6_sw, 276	,0);
	TEST_STORE_B_OP(65 , sb , x7 , x6 , result7_sb, result7_sw, 280	,0);
	# byte 1
	TEST_STORE_B_OP(66 , sb , x8 , x7 , result8_sb, result8_sw,	257	,-1);
	TEST_STORE_B_OP(67 , sb , x9 , x8 , result9_sb, result9_sw,	261	,-1);
	TEST_STORE_B_OP(68, sb , x10, x9 , result10_sb, result10_sw,265	,-1);
	TEST_STORE_B_OP(69, sb , x11, x10, result11_sb, result11_sw,269	,-1);
	TEST_STORE_B_OP(70, sb , x12, x11, result12_sb, result12_sw,273	,-1);
	TEST_STORE_B_OP(71, sb , x13, x12, result13_sb, result13_sw,277	,-1);
	TEST_STORE_B_OP(72, sb , x14, x13, result14_sb, result14_sw,281	,-1);
	TEST_STORE_B_OP(73, sb , x15, x14, result15_sb, result15_sw,285	,-1);
	# byte 2
	TEST_STORE_B_OP(74, sb , x16, x15, result16_sb, result16_sw, 258, -2);
	TEST_STORE_B_OP(75, sb , x17, x16, result17_sb, result17_sw, 262, -2);
	TEST_STORE_B_OP(76, sb , x18, x17, result18_sb, result18_sw, 266, -2);
	TEST_STORE_B_OP(77, sb , x19, x18, result19_sb, result19_sw, 270, -2);
	TEST_STORE_B_OP(78, sb , x20, x19, result20_sb, result20_sw, 274, -2);
	TEST_STORE_B_OP(79, sb , x21, x20, result21_sb, result21_sw, 278, -2);
	TEST_STORE_B_OP(80, sb , x22, x21, result22_sb, result22_sw, 282, -2);
	# byte 3
	TEST_STORE_B_OP(81, sb , x23, x22, result23_sb, result23_sw, 259, -3);
	TEST_STORE_B_OP(82, sb , x24, x23, result24_sb, result24_sw, 263, -3);
	TEST_STORE_B_OP(83, sb , x25, x24, result25_sb, result25_sw, 267, -3);
	TEST_STORE_B_OP(84, sb , x26, x25, result26_sb, result26_sw, 271, -3);
	TEST_STORE_B_OP(85, sb , x27, x26, result27_sb, result27_sw, 275, -3);
	TEST_STORE_B_OP(86, sb , x28, x27, result28_sb, result28_sw, 279, -3);
	TEST_STORE_B_OP(87, sb , x29, x28, result29_sb, result29_sw, 283, -3);

# ---------------------------------------------------
# STORE FOLLOWED BY A LOAD
	####################################################################################
	# SW WITH LH[U]
	# TEST_S_L_OP(testnum , inst , load , rs1 , rs2 , result , val2 , imm , imm_offset)
	# LH
	# lower half
	TEST_S_L_OP(88 , sw , lh , x1 , x31, result1_swlh, result1_sw, 500, 0);
	TEST_S_L_OP(89 , sw , lh , x2 , x1 , result2_swlh, result8_sw, 500, 2);
	# upper half
	TEST_S_L_OP(90 , sw , lhu , x3 , x2 , result3_swlhu, result2_sw, 504, 0);
	TEST_S_L_OP(91 , sw , lhu , x4 , x3 , result4_swlhu, result9_sw, 504, 2);

	# SW WITH LB[U]
	# TEST_S_L_OP(testnum , inst , load , rs1 , rs2 , result , val2 , imm , imm_offset)
	# LB
	TEST_S_L_OP(92 , sw , lb , x1 , x31, result1_swlb, result2_sw, 500, 0);
	TEST_S_L_OP(93 , sw , lb , x2 , x1 , result2_swlb, result2_sw, 500, 1);
	TEST_S_L_OP(94 , sw , lb , x3 , x2 , result3_swlb, result2_sw, 500, 2);
	TEST_S_L_OP(95 , sw , lb , x4 , x3 , result4_swlb, result2_sw, 500, 3);
	# LBU
	TEST_S_L_OP(96 , sw , lbu , x1 , x31, result1_swlbu, result2_sw, 504, 0);
	TEST_S_L_OP(97 , sw , lbu , x2 , x1 , result2_swlbu, result2_sw, 504, 1);
	TEST_S_L_OP(98 , sw , lbu , x3 , x2 , result3_swlbu, result2_sw, 504, 2);
	TEST_S_L_OP(99 , sw , lbu , x4 , x3 , result4_swlbu, result2_sw, 504, 3);

	####################################################################################
	# SH WITH A LH[U]
	# TEST_S_L_OP(testnum , inst , load , rs1 , rs2 , result , val2 , imm , imm_offset)
	
	# LH
	TEST_S_L_OP(100 , sh , lh , x1 , x31, result1_shlh, result1_sw, 512, 0);
	TEST_S_L_OP(101 , sh , lh , x2 , x1 , result2_shlh, result8_sw, 514, 0);
	TEST_S_L_OP(102 , sh , lh , x3 , x2 , result3_shlh, result2_sw, 512, 2);
	TEST_S_L_OP(103 , sh , lh , x4 , x3 , result4_shlh, result9_sw, 514, -2);

	# LHU
	TEST_S_L_OP(104 , sh , lhu , x1 , x31, result1_shlhu, result1_sw, 520, 0);
	TEST_S_L_OP(105 , sh , lhu , x2 , x1 , result2_shlhu, result8_sw, 522, 0);
	TEST_S_L_OP(106 , sh , lhu , x3 , x2 , result3_shlhu, result2_sw, 520, 2);
	TEST_S_L_OP(107 , sh , lhu , x4 , x3 , result4_shlhu, result9_sw, 522, -2);

	# SH WITH A LB[U]
	# LB
	TEST_S_L_OP(108 , sh , lb , x1 , x31, result1_shlb, result1_sw, 528, 0);
	TEST_S_L_OP(109 , sh , lb , x2 , x1 , result2_shlb, result8_sw, 528, 1);
	TEST_S_L_OP(110 , sh , lb , x3 , x2 , result3_shlb, result2_sw, 530, 0);
	TEST_S_L_OP(111 , sh , lb , x4 , x3 , result4_shlb, result9_sw, 530, 1);

	# LBU
	TEST_S_L_OP(112 , sh , lbu , x1 , x31, result1_shlbu, result1_sw, 532, 0);
	TEST_S_L_OP(113 , sh , lbu , x2 , x1 , result2_shlbu, result8_sw, 532, 1);
	TEST_S_L_OP(114 , sh , lbu , x3 , x2 , result3_shlbu, result2_sw, 534, 0);
	TEST_S_L_OP(115 , sh , lbu , x4 , x3 , result4_shlbu, result9_sw, 534, 1);

	####################################################################################
	# SB WITH LH[H]
	# TEST_S_L_OP(testnum , inst , load , rs1 , rs2 , result , val2 , imm , imm_offset)

	# LH
	# lower half
	TEST_S_L_OP(116 , sb , lh , x1 , x31, result1_sblh, result1_sw, 540, 0);
	TEST_S_L_OP(117 , sb , lh , x2 , x1 , result2_sblh, result8_sw, 541, -1);
	# upper half
	TEST_S_L_OP(118 , sb , lh , x3 , x2 , result3_sblh, result2_sw, 543, -1);
	TEST_S_L_OP(119 , sb , lh , x4 , x3 , result4_sblh, result9_sw, 542, 0);

	# LHU
	# upper half
	TEST_S_L_OP(120 , sb , lhu , x1 , x31, result1_sblhu, result1_sw, 545, -1);
	TEST_S_L_OP(121 , sb , lhu , x2 , x1 , result2_sblhu, result8_sw, 544, 0);
	# lower half
	TEST_S_L_OP(122 , sb , lhu , x3 , x2 , result3_sblhu, result2_sw, 546, 0);
	TEST_S_L_OP(123 , sb , lhu , x4 , x3 , result4_sblhu, result9_sw, 547, -1);

	# SB WITH LB[U]
	# LB
	TEST_S_L_OP(124 , sb , lb , x1 , x31, result1_sblb, result1_sw, 548, 0);
	TEST_S_L_OP(125 , sb , lb , x2 , x1 , result2_sblb, result8_sw, 549, 0);
	TEST_S_L_OP(126 , sb , lb , x3 , x2 , result3_sblb, result2_sw, 550, 0);
	TEST_S_L_OP(127 , sb , lb , x4 , x3 , result4_sblb, result9_sw, 551, 0);

	# LBU
	TEST_S_L_OP(128 , sb , lbu , x1 , x31, result1_sblbu, result1_sw, 552, 3);
	TEST_S_L_OP(129 , sb , lbu , x2 , x1 , result2_sblbu, result8_sw, 553, 2);
	TEST_S_L_OP(130 , sb , lbu , x3 , x2 , result3_sblbu, result2_sw, 554, 1);
	TEST_S_L_OP(131 , sb , lbu , x4 , x3 , result4_sblbu, result9_sw, 555, 0);


# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
# we put 0s in the data section that we write, so the dcache is started with valid data in it,
# giving us not a single miss, since this test it not mean to verify that
.section .data

one_data:
			.8byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

two_data:
			.8byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
