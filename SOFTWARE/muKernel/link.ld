STACK_SIZE = 0x200;         /* Stack size in bytes */

MEMORY
{
  INSTRUCTION_MEMORY : ORIGIN = 0x00000000, LENGTH = 7K
  DATA_MEMORY        : ORIGIN = 0x00000000, LENGTH = 1K
}


/* Executable object file sections */
SECTIONS 
{
    .text : {               /* Output elf section */        
        *(.text*)           /* The code order depends on the objects order passed to linker */
    } > INSTRUCTION_MEMORY
    
    .data : {               /* Output elf section */
        *(.data*)           /* Input object files section */
        *(.sdata*)
        *(.rodata*)         /* .rodata, .rodata.str1.4 */
    } > DATA_MEMORY AT > INSTRUCTION_MEMORY
    
    .bss : {                /* Output elf section */
        *(.bss*)            /* Input object files section */
        *(.sbss*)
    } > DATA_MEMORY
    
     . = (. + STACK_SIZE);  /* STACK_SIZE/4 words of stack memory */
    . = ALIGN(4);           /* Ensure the _stack_ptr alignment upward to a 4 byte boundary */
    _stack_ptr = .;         /* Set the stack pointer address */  
}
