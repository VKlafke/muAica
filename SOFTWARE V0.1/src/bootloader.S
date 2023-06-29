#include "aica_io.h"
#include "csr.h"

#-------------------------------------------------
#-------------------------------------------------
#-- Extern function
.extern	main

#--------------------------
#-- Section with "ALLOC + EXECINSTR" attributes
.section .bootloader,"ax"

	#----------------------------------------------
	#----------------------------------------------
	# set stack pointer value, x2 = stack pointer
	_bootloader_stackpointer_:
		li	sp,_SP_START_

	#----------------------------------------------
	#----------------------------------------------
	# configure the control/status registers
	_bootloader_csr_:
		// trap enable configuration
		li 		x30, 0x00000800
		csrs	mie,x30			//	exceptions and interrupts enabled
		csrsi	mstatus, 8				//	traps enabled

		// main trap handler start address
		li		x30, _TMAIN_SEC_
		csrw	mtvec, x30

		// not realy needed
		csrw	mepc, x0
		csrw	mcause, x0

	#----------------------------------------------
	#----------------------------------------------
	# configure the I/O devices
	#_bootloader_io_uart_:
	#	li	x30, UART_CTRL
	#	sb	x0, 0(x30)		// set uart to start with interrupts disabled

	#----------------------------------------------
	#----------------------------------------------
	# separted functions for each boot action
	call	main		