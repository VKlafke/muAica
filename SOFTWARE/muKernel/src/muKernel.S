#----------------------------------------------
#----------------------------------------------
# set stack pointer value, x2 = stack pointer
_bootloader_stackpointer_:
    la      sp, _stack_ptr

#----------------------------------------------
#----------------------------------------------
# configure the control/status registers
_bootloader_csr_:
    # trap enable configuration
    li      x30, 0x00000800
    csrs    mie, x30        # interrupts enabled
	csrrsi	x0, mie,  8 	# exceptions enabled
    csrsi   mstatus, 8      # traps enabled
    
    # main trap handler start address
    la      x30, trap_entry
    csrw    mtvec, x30
    
    # not realy needed
    csrw    mepc, x0
    csrw    mcause, x0

    jal    main
    

# Save registers to stack, align trap_handler arguments
# set return value from ecall, restore registers.
trap_entry:
    addi sp, sp, -31 * 4
  
    sw ra,  0 * 4(sp)	# x1, Return Address
	sw gp,  1 * 4(sp)	# x3, Global pointer
	sw tp,  2 * 4(sp)	# x4, Thread pointer
	
	sw t0,  3 * 4(sp)	# x5
    sw t1,  4 * 4(sp)   # x6
    sw t2,  5 * 4(sp)	# x7, Temp registers (t0 - t2)
	
	sw fp,  6 * 4(sp)	# x8, Frame pointer
	
	sw s1,  7 * 4(sp)	# x9, Saved register
	
    sw a0,  8 * 4(sp)   # x10 - Function return value, need to save when handling INTR
	sw a1,  9 * 4(sp)	# x11, Function arguments / return val (a0 - a1)
	
    sw a2,  10 * 4(sp)	# x12
    sw a3,  11 * 4(sp)	# x13
    sw a4,  12 * 4(sp) 	# x14
    sw a5,  13 * 4(sp) 	# x15
    sw a6,  14 * 4(sp)	# x16
    sw a7,  15 * 4(sp)	# x17, Function arguments (a2 - a7)
	
	sw s2,  16 * 4(sp)	# x18
	sw s3,  17 * 4(sp)	# x19
	sw s4,  18 * 4(sp)	# x20
	sw s5,  19 * 4(sp)	# x21
	sw s6,  20 * 4(sp)	# x22
	sw s7,  21 * 4(sp)	# x23
	sw s8,  22 * 4(sp)	# x24
	sw s9,  23 * 4(sp)	# x25
	sw s10, 24 * 4(sp)	# x26
	sw s11,	25 * 4(sp)	# x27, Saved registers (s2 - s11)
    
    sw t3,  26 * 4(sp)	# x28
    sw t4,  27 * 4(sp) 	# x29
    sw t5,  28 * 4(sp) 	# x30
    sw t6,  29 * 4(sp)	# x31, Temporary registers (t3 - t6)
    
    # call C function to handle interrupt
	
	mv	 a5, a7
	mv	 a4, a2
	mv	 a3, a1
	mv 	 a2, a0	# reorganize parameters for trap handler call
	
    csrr a0, mcause # arg 0: cause
    csrr a1, mepc   # arg 1: epc
	
	sw	a0, 30 * 4(sp)	# save mcause
	
    jal trap_handler
    
    # return value is the PC to resume
    csrw mepc, a0
	
	# a1 is the return value from ecall
	mv	a0, a1
	
	# Restore registers
  
    lw ra,  0 * 4(sp)
	lw gp,  1 * 4(sp)
	lw tp,  2 * 4(sp)
	lw t0,  3 * 4(sp)
    lw t1,  4 * 4(sp) 
    lw t2,  5 * 4(sp)
	lw fp,  6 * 4(sp)
	lw s1,  7 * 4(sp)
	
	lw a1, 30 * 4(sp) # load mcause 	
	bge a1, x0, lbl_skip_a0
	
    lw a0,  8 * 4(sp) # mcause < 0 means intr, restore a0
	
lbl_skip_a0: # if mcause is >= 0, don't restore saved a0
		
	lw a1,  9 * 4(sp)
    lw a2,  10 * 4(sp)
    lw a3,  11 * 4(sp)
    lw a4,  12 * 4(sp)
    lw a5,  13 * 4(sp)
    lw a6,  14 * 4(sp)
    lw a7,  15 * 4(sp)
	lw s2,  16 * 4(sp)
	lw s3,  17 * 4(sp)
	lw s4,  18 * 4(sp)
	lw s5,  19 * 4(sp)
	lw s6,  20 * 4(sp)
	lw s7,  21 * 4(sp)
	lw s8,  22 * 4(sp)
	lw s9,  23 * 4(sp)
	lw s10, 24 * 4(sp)
	lw s11,	25 * 4(sp)
    lw t3,  26 * 4(sp)
    lw t4,  27 * 4(sp)
    lw t5,  28 * 4(sp)
    lw t6,  29 * 4(sp)

    addi sp, sp, 31 * 4

    mret