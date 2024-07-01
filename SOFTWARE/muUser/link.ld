MEMORY
{
  INSTRUCTION_MEMORY : ORIGIN = 0x000021B4, LENGTH = 24140
  DATA_MEMORY        : ORIGIN = 0x00000800, LENGTH = 14336
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
