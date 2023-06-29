#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------

.equ ram_base,	0x00000000

.equ ram_data1,			0x12345678
.equ ram_data_test2,	0x00000056
.equ ram_data_test3,	0x00001234

# ---------------------------------------------------
.section .text,"ax"
_datapath_s_:

# ---------------------------------------------------
# Load and Store sequence
	# test1
	li	x10, ram_base
	lw	x11, 0(x10)
	li	x12, ram_data1
	li	x30, 1
	bne x11, x12, fail

	# test 2
	lb	x11, 1(x10)
	li	x12, ram_data_test2
	li	x30, 2
	bne x11, x12, fail

	# test 3
	lh	x11, 2(x10)
	li	x12, ram_data_test3
	li	x30, 3
	bne x11, x12, fail

# ---------------------------------------------------
# Load and Add sequence (Load-Stall)
	# test 4
	li	x15, ram_data1
	lw	x16, 0(x10)
	sub x16, x16,x15
	addi x16, x16, 1
	li  x15, 1
	li	x30, 4
	bne x16, x15, fail

	# test 5
	lw	 x16, 0(x10)
	srli x16, x16, 16
	li	 x15, ram_data_test3
	sub	 x16, x16, x15
	li	 x30, 5
	bne  x16, x0, fail

# ---------------------------------------------------
# Load and Add sequence (Load-Stall), with Branch NT on IF
	# test 6
	#  with branch NT
	li		x20,ram_base
	li		x18,3
label_0:
	lw		x19,0(x20)
	# nop here, put in by ctrl (load-stall)
	add		x21,x20,x19	# doesnt matter the operation, but has to cause a load-stall

	beq		x18,x0,label_1
	addi	x18,x18,-1
	j		label_0
label_1:
	li	x30, 6
	bne	x18, x0, fail

	# test 7
	# with branch T
	li		x20,ram_base
	li		x18,6
label_3:
	lw		x19,0(x20)
	# nop here, put in by ctrl (load-stall)
	addi	x18, x18, -1
	bne		x18,x0,label_3
	li	x30, 7

# ---------------------------------------------------
# Jump Flush
	# test 8
	li  x26, 10
	li	x25, 10
	jal x0, j_flush1
	addi x25, x25, 1
	addi x25, x25, 1
	addi x25, x25, 1
	addi x25, x25, 1
j_flush1:
	li	x30, 8
	bne x25, x26, fail

	# test 9
	li  x26, 10
	li	x25, 10
	la	x24, j_flush2
	jalr x0, x24, 0
	addi x25, x25, 1
	addi x25, x25, 1
	addi x25, x25, 1
	addi x25, x25, 1
j_flush2:
	li	x30, 9
	bne x25, x26, fail

# test 10
	li  x26, 10
	li	x25, 10
	jal x0, j_flush3
	j	fail
	j	fail
	j	fail
j_flush3:
	li	x30, 10
	bne x25, x26, fail

# test 11
	li  x26, 10
	li	x25, 10
	la	x24, j_flush4
	jalr x0, x24, 0
	j	fail
	j	fail
	j	fail
j_flush4:
	li	x30, 11
	bne x25, x26, fail

# test 12
	li  x26, 10
	li	x25, 10
	jal x0, j_flush5
	lw	x25, 0(x10)
	lw	x25, 0(x10)
	lw	x25, 0(x10)
j_flush5:
	li	x30, 12
	bne x25, x26, fail

# test 13
	li  x26, 10
	li	x25, 10
	la	x24, j_flush6
	jalr x0, x24, 0
	lw	x25, 0(x10)
	lw	x25, 0(x10)
	lw	x25, 0(x10)
j_flush6:
	li	x30, 13
	bne x25, x26, fail

# test 14
	li  x26, 10
	li	x25, 10
	jal x0, j_flush7
	beq	x0, x0, fail
	beq x0, x0, fail
	beq x0, x0, fail
j_flush7:
	li	x30, 14
	bne x25, x26, fail

# test 15
	li  x26, 10
	li	x25, 10
	la	x24, j_flush8
	jalr x0, x24, 0
	bne	x0, x25, fail
	bne	x0, x25, fail
	bne	x0, x25, fail
j_flush8:
	li	x30, 15
	bne x25, x26, fail	

# ---------------------------------------------------
# Branch Taken on MEM with Branch Taken on IF
	# test 16
	li		x17, 3
	li		x18, 3
	li		x19, 1
	li		x20, 20
b2b_1:
	beq		x18, x0, b2b_2
	sub		x18, x18, x19
	j		b2b_1

b2b_2:
	beq		x17, x0, b2b_3
	sub		x17, x17, x19
b2b_3:
	addi	x20, x20, -1
	beq		x20, x0, b2b_4
	j		b2b_1
b2b_4:
	li	x30, 16

# ---------------------------------------------------
# Branch falling on Jump
	# test 17
	li		x17, 3
	li		x18, 2
	li		x19, 1
	bge		x17, x18, b2j_1
	addi	x19, x19, -1
	addi	x19, x19, -1
	addi	x19, x19, -1
b2j_1:
	j	b2j_2
	addi	x19, x19, -1
b2j_2:
	addi	x19, x19, -1
	li		x30, 17
	bne		x19, x0, fail

# test 18
	li		x17, 3
	li		x18, 2
	li		x19, 1
	blt		x18, x17, b2j_3
	addi	x19, x19, -1
	addi	x19, x19, -1
	addi	x19, x19, -1
b2j_3:
	j	b2j_4
	addi	x19, x19, -1
b2j_4:
	addi	x19, x19, -1
	li		x30, 18
	bne		x19, x0, fail

# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTION
	FAIL

# ---------------------------------------------------
.section .data

	data1:	.word	ram_data1

