#include "muKernel.h"
#include "syscall.h"



int trap_handler(int mcause, int mepc, int a0, int a1, int a2, int a7) 
{                                                                                                                
    if (mcause >= 0) 
	{ // System calls and exceptions
		
		if(mcause == 1) // Misaligned instruction address 
		{
			// Treat exception
			// ....
			
			// DEBUG STRING, SIMULATION ONLY
			__asm__ volatile 
			("li	x24,'E'\n\t" \
			 "li	x25,'X'\n\t" \
			 "li 	x26,'C'\n\t" \
			 "li	x27,'E'\n\t" \
			 "li 	x28,'P'\n\t" \
			 "li 	x29,'T'\n\t" \
			 "li 	x30,'_'\n\t" \
			 "li 	x31,'1'\n\t");
			 
			// Will get stuck on loop entering exception... ?
			return mepc; 	
		}
		else if(mcause == 2) // Illegal instruction
		{
			// Treat exception
			// ....
			
			// DEBUG STRING, SIMULATION ONLY
			__asm__ volatile 
			("li	x24,'E'\n\t" \
			 "li	x25,'X'\n\t" \
			 "li 	x26,'C'\n\t" \
			 "li	x27,'E'\n\t" \
			 "li 	x28,'P'\n\t" \
			 "li 	x29,'T'\n\t" \
			 "li 	x30,'_'\n\t" \
			 "li 	x31,'2'\n\t");
			 
			// Skip illegal instruction on return 
			return mepc + 4; 	
		}
		else if(mcause == 4)// Misaligned data address
		{		
		
			// DEBUG STRING, SIMULATION ONLY
			__asm__ volatile 
			("li	x24,'E'\n\t" \
			 "li	x25,'X'\n\t" \
			 "li 	x26,'C'\n\t" \
			 "li	x27, 'E'\n\t" \
			 "li 	x28,'P'\n\t" \
			 "li 	x29,'T'\n\t" \
			 "li 	x30,'_'\n\t" \
			 "li 	x31,'4'\n\t");
			 
			// Will get stuck on loop entering exception  
			return mepc;
		}
		else if(mcause == 8) // ECALL instruction
		{
			int ecall_func = a7;
			int retVal = 0;
			
			// Request ecall func ID is stored in a7 
			/*__asm__ volatile 
			(
				"mv %0, a7"
				: "=r" (ecall_func)
			);*/
			
			// Do the system call 
			
			if(ecall_func == ECALL_BDP_CFG) // BDPort config
			{		
				Kernel_BDPort_Setup(a0, a1, a2);
			}
			else if(ecall_func == ECALL_BDP_READ) // BDPort read
			{
				retVal = Kernel_BDPort_Read();
			}
			else if(ecall_func == ECALL_BDP_WRITE) // BDPort write 
			{
				Kernel_BDPort_Write(a0);
			}
			
			// Put retval in register a1 (a0 is return to mepc)			
			__asm__ volatile
			(
				"mv a1, %0\n\t" 
				:
				: "r" (retVal)      
				: "a1"          
			);
			
			// DEBUG STRING, SIMULATION ONLY
			__asm__ volatile 
			("li	x24,'E'\n\t" \
			 "li	x25,'C'\n\t" \
			 "li 	x26,'A'\n\t" \
			 "li	x27, 'L'\n\t" \
			 "li 	x28,'L'\n\t" \
			 "li 	x29,'_'\n\t" \
			 "mv 	x30,%0\n\t" \
			 "li 	x31,''\n\t"
			 :
			 : "r"(ecall_func)
			 );		
		}
		
        return mepc + 4; // Return execution at the next inst 
    }
    else 
	{    // IRQs from PIC  
		
		ext_intr_handler();
		
        return mepc;
    }        
                                                                                                      
}

void ext_intr_handler()
{
	// Get IRQ number from PIC
	int IRQ_ID = *(char*)PIC_IRQ_ID;
	
	// SIMULATION DEBUG STRING IN REGISTERS
	__asm__ volatile 
	("li	x24,''\n\t" \
	 "li	x25,''\n\t" \
	 "li 	x26,'I'\n\t" \
	 "li	x27,'N'\n\t" \
	 "li	x28,'T'\n\t" \
	 "li	x29,'R'\n\t" \
	 "li 	x30,'_'\n\t");
	
	// Treat IRQ based on ID	
	if(IRQ_ID == 7)
	{
		__asm__ volatile 
		("li	x31, '7'");
	}
	else if(IRQ_ID == 6)
	{
		__asm__ volatile 
		("li	x31, '6'");
	}
	else if(IRQ_ID == 5)
	{
		__asm__ volatile 
		("li	x31, '5'");
	}
	else if(IRQ_ID == 4)
	{
		__asm__ volatile 
		("li	x31, '4'");
	}
	else if(IRQ_ID == 3)
	{
		__asm__ volatile 
		("li	x31, '3'");
	}
	else if(IRQ_ID == 2)
	{
		__asm__ volatile 
		("li	x31, '2'");
	}
	else if(IRQ_ID == 1)
	{
		__asm__ volatile 
		("li	x31, '1'");
	}
	else if(IRQ_ID == 0)
	{
		__asm__ volatile 
		("li	x31, '0'");
	}
	
	// Notify PIC that IRQ was treated
	*(char*)PIC_ACK = IRQ_ID;
}

//////////////////////////////
//
//	BDPort system functions
//

// Set up BD port registers
// Config: Bit is input / output
// Enable: Bit is enabled
// 	 Intr: Bit is interruption (only bits 31 - 24)
void Kernel_BDPort_Setup(int config, int enable, int intr)
{
	*(int*)BDPORT_CFG = config;
	*(int*)BDPORT_EN = enable;
	*(int*)BDPORT_INTR = intr;
	
	return;
}

// Read int value from BDPort
int Kernel_BDPort_Read()
{
	int ret = *(int*)BDPORT_DATA;
	
	return ret;
}

// Write to BDPort 
void Kernel_BDPort_Write(int val)
{
	*(int*)BDPORT_DATA = val;
	
	return;
}
	
							//
							//
							//
//////////////////////////////