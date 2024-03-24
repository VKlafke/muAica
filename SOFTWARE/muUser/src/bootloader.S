#----------------------------------------------
#----------------------------------------------
# set stack pointer value, x2 = stack pointer
_bootloader_stackpointer_:
    la      sp, _stack_ptr
    
    # Store return address in stack
    addi sp, sp, -4
    sw ra, 0(sp)
    
    # trap enable configuration
    li      x30, 0x00000800
    csrs    mie, x30        # interrupts enabled
    csrrsi	x0, mie,  8 	# exceptions enabled
    csrsi   mstatus, 8      # traps enabled
    
    # not realy needed
    csrw    mepc, x0
    csrw    mcause, x0
    
    jal    main
    
    # Load return address from stack
    lw ra, 0(sp)
    addi sp, sp, 4
    
    # return 
    jalr	x0, 0(ra)