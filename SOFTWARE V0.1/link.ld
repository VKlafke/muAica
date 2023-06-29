STACK_SIZE = 0x100;         /* Stack size in bytes */

/* Executable object file sections */
SECTIONS 
{
	/**************
	 * Bootloader *
	 **************/
	
    . = 0x00000000;         /* Code start address: Instruction memory OFFSET */
    .bootloader : /* Output elf section */
	{               
		. = ALIGN(4);
		
        *(.bootloader*) 
		
		. = ALIGN(4);
    }   
	
	/**********************************
	 * Machine Interrupt Vector Table *
	 **********************************/
	. = 0x00000200;
	.m_intr_vector :
	{
		. = ALIGN(4);

		_m_intr_vect_s_ = .;

		*(._m_intr_vect_0);
			. = _m_intr_vect_s_ + 4;
		*(._m_intr_vect_1);
			. = _m_intr_vect_s_ + 8;
		*(._m_intr_vect_2);
			. = _m_intr_vect_s_ + 12;
		*(._m_intr_vect_3);
			. = _m_intr_vect_s_ + 16;
		*(._m_intr_vect_4);
			. = _m_intr_vect_s_ + 20;
		*(._m_intr_vect_5);
			. = _m_intr_vect_s_ + 24;
		*(._m_intr_vect_6);
			. = _m_intr_vect_s_ + 28;
		*(._m_intr_vect_7);
			. = _m_intr_vect_s_ + 32;
		*(._m_intr_vect_8);
			. = _m_intr_vect_s_ + 36;
		*(._m_intr_vect_9);
			. = _m_intr_vect_s_ + 40;
		*(._m_intr_vect_10);
			. = _m_intr_vect_s_ + 44;
		*(._m_intr_vect_11);
			. = _m_intr_vect_s_ + 48;
		*(._m_intr_vect_12);
			. = _m_intr_vect_s_ + 52;
		*(._m_intr_vect_13);
			. = _m_intr_vect_s_ + 56;
		*(._m_intr_vect_14);
			. = _m_intr_vect_s_ + 60;
		*(._m_intr_vect_15);
			. = _m_intr_vect_s_ + 64;

		. = ALIGN(4);
	}
	
	/*****************************
	 * Machine Main Trap Handler *
	 *****************************/
	 
	. = 0x00000240;
	.m_trap_handler :
	{
		. = ALIGN(4);

		*(._m_trap_handler_);

		. = ALIGN(4);
	}
	
	.text : /* Output elf section */ 
	{
		. = ALIGN(4);
		
        *(.text*) 
		
		. = ALIGN(4);
    }
  
    . = 0x00003000;         /* Data start address: Data memory OFFSET */
    .data : {               /* Output elf section */
        *(.data*)           /* Input object files section */
        *(.sdata*)
        *(.rodata*)         /* .rodata, .rodata.str1.4 */
    }
    
    .bss : {                /* Output elf section */
        *(.bss*)            /* Input object files section */
        *(.sbss*)
    }
    
     . = (. + STACK_SIZE);  /* STACK_SIZE/4 words of stack memory */
    . = ALIGN(4);           /* Ensure the _stack_ptr alignment upward to a 4 byte boundary */
    _stack_ptr = .;         /* Set the stack pointer address */  
}