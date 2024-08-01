MEMORY
{
  INSTRUCTION_MEMORY : ORIGIN = 0x00001CC8, LENGTH = 32K - ORIGIN(INSTRUCTION_MEMORY)
  DATA_MEMORY        : ORIGIN = 0x00000800, LENGTH = 16K - ORIGIN(DATA_MEMORY)
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
        *(.srodata*)
    } > DATA_MEMORY AT > INSTRUCTION_MEMORY
    
    .bss : {                /* Output elf section */
        *(.bss*)            /* Input object files section */
        *(.sbss*)
    } > DATA_MEMORY
    
    /* Set the stack pointer to the last address of the DATA_MEMORY */
  _stack_ptr = ORIGIN(DATA_MEMORY) + LENGTH(DATA_MEMORY) - 4;
}