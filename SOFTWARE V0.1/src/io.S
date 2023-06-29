#include "basic_macros.h"


#define iop_en	 x1
#define	iop_cfg	 x2
#define iop_data x3
#define iop_itr  x4
#define testnum x30


.equ result1_lw,	0x12345678

# ---------------------------------------------------
.section .text,"ax"
main:

	li	x1, 0x80000000
	li	x2, 0x80000010
	li	x3, 0x80000020
	li	x4, 0x80000030

	li	x20, 0x008912FF
	li	x21, 0xF0

# ---------------------------------------------------
# UART Ctrl/Status Register and UART Data Write

	# test 1
	# verify if the status regs. changes with new data to write
	lb 	x10, 0(iop_en)	# get enable register
	sw	x20, 0(iop_en)	# write in the reg data
	lb	x11, 2(iop_en)	# get status again and compare with the previous one (should be 0 now)
	
	#la  x12, lw_data
	lb  x12, 0(x0)

	li		testnum, 1
	beq		x10, x11, fail	# compare stats

	# test 2
	# verify if the status changes back to initial value after write is done
loop_0:
	# beq		x21, x0, loop_1
	# addi	x21, x21, -1		# give it time to send data
	# j		loop_0
loop_1:
	# lb		x11, 0(u_ctrl)
	addi	testnum, testnum, 1
	# bne		x11, x10, fail

# ---------------------------------------------------
# PASS INSTRUCTIONs
	PASS

# ---------------------------------------------------
# FAIL INSTRUCTIONs
	FAIL

.section .data

	lw_data:	.word	result1_lw