#include <stddef.h>
#include "muKernel.h"
#include "syscall.h"

volatile char* tempStr;
volatile int strCnt;

// Vector that hold the callbacks for external interrupts
// these can be set by the user through Ext_Intr_Handler_Set(int, callback_t)
static callback_t vec_Ext_Intr_Handler[MAX_EXT_INTR] = {Kernel_RX_Callback};


// Main trap handler 
// Deals with exceptions or calls ext intr dispatcher
int trap_handler(int mcause, int mepc, int a0, int a1, int a2, int ecall_func) 
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
			int retVal = 0;
			
			// Do the system call 		
			switch(ecall_func)
			{				
				case ECALL_EXT_INTR_REG: // Register ext intr handler 
					Kernel_Ext_Intr_Handler_Set(a0, (callback_t)a1);
				break;
				
				case ECALL_BDP_CFG:	// BDPort config
					Kernel_BDPort_Setup(a0, a1, a2);
				break;
				
				case ECALL_BDP_READ: // BDPort read
					retVal = Kernel_BDPort_Read();
				break;
				
				case ECALL_BDP_WRITE: // BDPort write 
					Kernel_BDPort_Write(a0);
				break;
				
				case ECALL_PIC_MASK: // Set PIC intr mask 
					Kernel_PIC_Mask(a0);
				break;
				
				case ECALL_UART_TX: // Send string to tx 
					Kernel_UART_TX((char*)a0);
				break;
				
				default:
				break;			
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
		
		int _val_ = 0x00000800;
		int _mstatus_ = 128;
		
		// Enable exceptions, disable int
		__asm__ volatile
		(
			"csrc mie, %0\n\t"\
			"csrw	mstatus, 8"
			:
			: "r"(_val_)
		);
			
		// Call appropriate intr handler 
		Kernel_Ext_Intr_Dispatcher();
	
		// Restore mstatus and mie 
		__asm__ volatile
		(
			"csrw	mstatus, %0\n\t"	 \
			"csrs 	mie, %1" 
			:
			: "r"(_mstatus_), "r"(_val_)
		);
			
		
        return mepc;
    }        
                                                                                                      
}


/////////////////////////
//
// External interrupts 
//

// Dispatch interrupts to appropriate handler 
void Kernel_Ext_Intr_Dispatcher()
{
	// Get IRQ number from PIC
	int IRQ_ID = PIC_IRQ_ID;
	
	
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
	if(IRQ_ID >= 0 && IRQ_ID < MAX_EXT_INTR)
	{
		if(vec_Ext_Intr_Handler[IRQ_ID] != 0)
			vec_Ext_Intr_Handler[IRQ_ID]();
		else 
			Kernel_Ext_Intr_default(); // default handler when there is no assigned callback 
	}
	
	// Notify PIC that IRQ was treated
	PIC_ACK = IRQ_ID;
}

// Register external intr handler callbacks from user 
int Kernel_Ext_Intr_Handler_Set(int n, callback_t handler_callback) 
{
	// Check for valid index 
    if (n < 0 || n >= MAX_EXT_INTR) 
		return 1; // N_OUT_OF_BOUNDS
    
	// Check for valid callback 
    if (handler_callback == NULL) 
		return 2; // INVALID_CALLBACK
	
	// Register callback 
    vec_Ext_Intr_Handler[n] = handler_callback;
	
	return 0;
}

// Default external interrupt handler 
void Kernel_Ext_Intr_default()
{
	__asm__ volatile 
	("li	x24,''\n\t" \
	 "li	x25,'I'\n\t" \
	 "li 	x26,'N'\n\t" \
	 "li	x27,'T'\n\t" \
	 "li 	x28,'R'\n\t" \
	 "li 	x29,'_'\n\t" \
	 "li 	x30,'D'\n\t"
	);		
}

							//
							//
							//
//////////////////////////////


//////////////////////////////
//
//	BDPort
//

// Set up BD port registers
// Config: Bit is input / output
// Enable: Bit is enabled
// 	 Intr: Bit is interruption (only bits 31 - 24)
void Kernel_BDPort_Setup(int config, int enable, int intr)
{
	BDPORT_CFG = config;
	BDPORT_EN = enable;
	BDPORT_INTR = intr;
}

// Read int value from BDPort
int Kernel_BDPort_Read()
{
	int ret = BDPORT_DATA;
	
	return ret;
}

// Write to BDPort 
void Kernel_BDPort_Write(int val)
{
	BDPORT_DATA = val;
}
	
							//
							//
							//
//////////////////////////////


//////////////////////////////
//
//	PIC
//

// Set the PIC intr mask
void Kernel_PIC_Mask(char val)
{
	PIC_MASK = val;
}

							//
							//
							//
//////////////////////////////



//////////////////////////////
//
//	UART
//

// Send string over TX 
// TODO: Add return indicating if TX msg was sent successfuly
//		 false if TX busy
void Kernel_UART_TX(char* str)
{
	strCnt = 0;
	
	while(str[strCnt] != '\0')
	{
		while(UART_TX == 1);
			//continue;
		
		UART_TX = str[strCnt++];
	}	
}

volatile char rxStr[256];
volatile int rxCnt = 0;

// Default RX callback
// stores the string in an array
// sends string over tx when '\0' arrives
void Kernel_RX_Callback()
{
	char rx_in = UART_RX;

	rxStr[rxCnt] = rx_in;

	if(rx_in == '\0')
	{
		Kernel_UART_TX((char*)rxStr);

		rxCnt = 0;
	}
	else
		rxCnt++;
}

							//
							//
							//
//////////////////////////////