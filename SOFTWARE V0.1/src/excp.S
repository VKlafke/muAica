#include "aica_io.h"
#include "test_macros.h"

# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
# Section with trap handlers definitions (write the vector table)

.section ._m_trap_handler_,"ax"
	_main_trap_handler_:

	# get the start address of the excpetion vector table
	auipc	x29, 0		# load the start address of the main handler
	addi	x29, x29, -72

	# get the cause of the exception, so we can form the target vector
	csrr	x30, mcause
	blt		x30, x0, _m_trap_intr_

	slli	x30, x30, 2
	add		x29, x30, x29
	jr		x29

	_m_trap_intr_:
	slli	x30, x30, 3
	add		x29, x30, x29

	jr		x29

.section ._m_excp2_vect_,"ax"
	j	excp_bad_instr_address


# ---------------------------------------------------
# ---------------------------------------------------
# ---------------------------------------------------
.section .text,"ax"
_excp_s_:

# ---------------------------------------------------
# Start the CSRs
	csrrsi	x0, mstatus, 8	# enable global interrupts

	csrrsi	x0,	mie, 8		# enable software exception only

	la		x1, _main_trap_handler_
	csrrw	x0, mtvec,	x1	# set base address to the vector table start, in DIRECT mode

# ---------------------------------------------------
# Generate a bad instr. address
	li		x1, 0x0004000
	jalr	x0, x1, 65

# ---------------------------------------------------
# Exception - Bad instr. address
	excp_bad_instr_address:
	PASS


# ---------------------------------------------------
# PASS Basic Tests
	# PASS

# ---------------------------------------------------
# FAIL Basic Tests
	FAIL
