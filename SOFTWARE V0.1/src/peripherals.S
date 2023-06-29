#include "basic_macros.h"

.equ stack_ptr,	0x50
.equ data_start, 0x10

.section .text,"ax"

	addi	x31,x0,0
	lui		x31,0x80000
	lw		x1,0(x31)
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	sw	x31,0(x31)		
	NOP
	NOP
	NOP
	NOP
	NOP
# ---------------------------------------------------
# PASS Basic Tests
	PASS

# ---------------------------------------------------
# FAIL Basic Tests
	FAIL


.section .data

	data1:	.word	data_start

