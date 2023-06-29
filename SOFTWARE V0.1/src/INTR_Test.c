#include "aica_io.h"
#include "csr.h"
#include "trap_handler.h"

#define _IO_RW_WORD_(__io_addr__)	(*(volatile int *)(__io_addr__))

#define PASS __asm__("li	x31,'O'\n\tli	x30,'K'\n\tli	x29,'\n'\n\tloop_pass:\n\tbne	x31, x0, loop_pass\n\t");	
	
#define FAIL __asm__("li		x31,'E'\n\tli		x30,'R'\n\tli		x29,'R'\n\tli		x28,'O'\n\tli		x27,':'\n\tli		x26,' '\n\tli		x25,'\n'\n\tloop_fail:\n\tbne	x31, x0, loop_fail\n\t");

void test_intr();
	
MAIN_HANDLER();

INTR_VECT(test_intr , 11);	// intr vector for external interrupt
		
__asm__(".section	.text, \"ax\"");

int main()
{	
	// configure the CSR
	//mintr_en();						// enable external interrupts
	//mtrap_en();						// enable global trap


	int _trap_cause_;		
			
	// inf loop
	while (1) 
	{	
		_trap_cause_ = csr_r(mcause);
	}
}

void test_intr()
{
	int _trap_cause_;		
	_trap_cause_ = csr_r(mcause);
			
	PASS;
}