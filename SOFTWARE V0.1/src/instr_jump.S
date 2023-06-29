#include "aica_io.h"
#include "test_macros.h"

# note: tests depends on AUIPC

# ---------------------------------------------------
.section .text,"ax"
_jump_s_:

# ---------------------------------------------------
# JAL INSTRUCTION
	# TEST_JUMP_OP(testnum , inst , rd )
	TEST_JUMP_OP(1,  jal , x1 );
	TEST_JUMP_OP(2,  jal , x2 );
	TEST_JUMP_OP(3,  jal , x3 );
	TEST_JUMP_OP(4,  jal , x4 );
	TEST_JUMP_OP(5,  jal , x5 );
	TEST_JUMP_OP(6,  jal , x6 );
	TEST_JUMP_OP(7,  jal , x7 );
	TEST_JUMP_OP(8,  jal , x8 );
	TEST_JUMP_OP(9,  jal , x9 );
	TEST_JUMP_OP(10, jal , x10 );
	TEST_JUMP_OP(11, jal , x11 );
	TEST_JUMP_OP(12, jal , x12 );
	TEST_JUMP_OP(13, jal , x13 );
	TEST_JUMP_OP(14, jal , x14 );
	TEST_JUMP_OP(15, jal , x15 );
	TEST_JUMP_OP(16, jal , x16 );
	TEST_JUMP_OP(17, jal , x17 );
	TEST_JUMP_OP(18, jal , x18 );
	TEST_JUMP_OP(19, jal , x19 );
	TEST_JUMP_OP(20, jal , x20 );
	TEST_JUMP_OP(21, jal , x21 );
	TEST_JUMP_OP(22, jal , x22 );
	TEST_JUMP_OP(23, jal , x23 );
	TEST_JUMP_OP(24, jal , x24 );
	TEST_JUMP_OP(25, jal , x25 );
	TEST_JUMP_OP(26, jal , x26 );
	TEST_JUMP_OP(27, jal , x27 );
	TEST_JUMP_OP(28, jal , x28 );
	TEST_JUMP_OP(29, jal , x29 );

# ---------------------------------------------------
# JALR INSTRUCTION
	# TEST_JUMPR_OP(testnum , inst , rd , rs1 , imm)
	TEST_JUMPR_OP(30,  jalr , x1 , x31, 16);
	TEST_JUMPR_OP(31,  jalr , x2 , x1 , 16);
	TEST_JUMPR_OP(32,  jalr , x3 , x2 , 16);
	TEST_JUMPR_OP(33,  jalr , x4 , x3 , 16);
	TEST_JUMPR_OP(34,  jalr , x5 , x4 , 16);
	TEST_JUMPR_OP(35,  jalr , x6 , x5 , 16);
	TEST_JUMPR_OP(36,  jalr , x7 , x6 , 16);
	TEST_JUMPR_OP(37,  jalr , x8 , x7 , 16);
	TEST_JUMPR_OP(38,  jalr , x9 , x8 , 16);
	TEST_JUMPR_OP(39, jalr , x10, x9 , 16);
	TEST_JUMPR_OP(40, jalr , x11, x10, 16);
	TEST_JUMPR_OP(41, jalr , x12, x11, 16);
	TEST_JUMPR_OP(42, jalr , x13, x12, 16);
	TEST_JUMPR_OP(43, jalr , x14, x13, 16);
	TEST_JUMPR_OP(44, jalr , x15, x14, 16);
	TEST_JUMPR_OP(45, jalr , x16, x15, 16);
	TEST_JUMPR_OP(46, jalr , x17, x16, 16);
	TEST_JUMPR_OP(47, jalr , x18, x17, 16);
	TEST_JUMPR_OP(48, jalr , x19, x18, 16);
	TEST_JUMPR_OP(49, jalr , x20, x19, 16);
	TEST_JUMPR_OP(50, jalr , x21, x20, 16);
	TEST_JUMPR_OP(51, jalr , x22, x21, 16);
	TEST_JUMPR_OP(52, jalr , x23, x22, 16);
	TEST_JUMPR_OP(53, jalr , x24, x23, 16);
	TEST_JUMPR_OP(54, jalr , x25, x24, 16);
	TEST_JUMPR_OP(55, jalr , x26, x25, 16);
	TEST_JUMPR_OP(56, jalr , x27, x26, 16);
	TEST_JUMPR_OP(57, jalr , x28, x27, 16);
	TEST_JUMPR_OP(58, jalr , x29, x28, 16);
	TEST_JUMPR_OP(59, jalr , x31, x29, 16);

#---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data

