#include <stddef.h>
#include "muKernel.h"
#include "syscall.h"

volatile char* tempStr;
volatile int strCnt;

// Vector that hold the callbacks for external interrupts
// these can be set by the user through ExtIntrHandlerSet(int, callback_t)
callback_t vec_Ext_Intr_Handler[MAX_EXT_INTR] = 
{
    NULL,
    NULL,    
    //KernelRXCallback,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
};

// Main trap handler 
// Deals with exceptions or calls ext intr dispatcher
int TrapHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2) 
{                                                                                                                
    if (mcause >= 0) 
	{ // System calls and exceptions
		
        if(mcause == EX_MISALIGNED_INSTRUCTION_ADDR)
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
             
             KernelUARTTX("EXCEPTION: Misaligned instruction addr\n");
			 
			// Will get stuck on loop entering exception
			return mepc; 	
		}
		else if(mcause == EX_ILLEGAL_INSTRUCTION)
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
             
             KernelUARTTX("EXCEPTION: Illegal instruction\n");
			 
			// Skip illegal instruction on return 
			return mepc + 4; 	
		}
		else if(mcause == EX_MISALIGNED_DATA_ADDR)
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
             
             KernelUARTTX("EXCEPTION: Misaligned data addr: ");
             
             
            char bytes[30];
             
            bytes[0] = (unsigned char)(((mepc >> 28) & 0xF) + 0x41);
            bytes[1] = '_';
            bytes[2] = (unsigned char)(((mepc >> 24) & 0xF) + 0x41);
            bytes[3] = '_';
            bytes[4] = (unsigned char)(((mepc >> 20) & 0xF) + 0x41);
            bytes[5] = '_';
            bytes[6] = (unsigned char)(((mepc >> 16) & 0xF) + 0x41);
            bytes[7] = '_';
            bytes[8] = (unsigned char)(((mepc >> 12) & 0xF) + 0x41);
            bytes[9] = '_';
            bytes[10] = (unsigned char)(((mepc >> 8) & 0xF) + 0x41);
            bytes[11] = '_';
            bytes[12] = (unsigned char)(((mepc >> 4) & 0xF) + 0x41);
            bytes[13] = '_';
            bytes[14] = (unsigned char)((mepc & 0xF) + 0x41);
			bytes[15] = '\n';
            bytes[16] = '\0';
            
            KernelUARTTX(bytes);
            
            
             KernelUARTTX("EXCEPTION END STRING\n");
             
			// Will get stuck on loop entering exception  
			return mepc;
		}
		else if(mcause == EX_ECALL)
		{
			int retVal = 0;
			
			// Do the system call 		
			switch(ecallFunc)
			{				
				case ECALL_EXT_INTR_REG: // Register ext intr handler 
					KernelExtIntrHandlerSet(a0, (callback_t)a1);
				break;
				
				case ECALL_BDP_CFG:	// BDPort config
					KernelBDPortSetup(a0, a1, a2);
				break;
				
				case ECALL_BDP_READ: // BDPort read
					retVal = KernelBDPortRead();
				break;
				
				case ECALL_BDP_WRITE: // BDPort write 
					KernelBDPortWrite(a0);
				break;
				
				case ECALL_PIC_MASK: // Set PIC intr mask 
					KernelPICMask(a0);
				break;
				
				case ECALL_UART_TX: // Send string to tx 
					KernelUARTTX((char*)a0);
				break;
				
                case ECALL_TIMER_SET_CLK: // set timer base clock 
                    KernelTimerSetClock(a0);
                break;
                
                case ECALL_TIMER_SET_COUNT: // Set timer count, ms
                    KernelTimerSetCount(a0);
                break;
                
                case ECALL_TIMER_ENABLE: // enable / disable timer
                    KernelTimerSetEnabled(a0);
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
			/*__asm__ volatile 
			("li	x24,'E'\n\t" \
			 "li	x25,'C'\n\t" \
			 "li 	x26,'A'\n\t" \
			 "li	x27, 'L'\n\t" \
			 "li 	x28,'L'\n\t" \
			 "li 	x29,'_'\n\t" \
			 "mv 	x30,%0\n\t" \
			 "li 	x31,''\n\t"
			 :
			 : "r"(ecallFunc)
			 );		*/
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
		KernelExtIntrDispatcher();
	
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
void KernelExtIntrDispatcher()
{
	// Get IRQ number from PIC
	int IRQ_ID = PIC_IRQ_ID;
	
	
	// SIMULATION DEBUG STRING IN REGISTERS
	/*__asm__ volatile 
	("li	x24,''\n\t" \
	 "li	x25,''\n\t" \
	 "li 	x26,'I'\n\t" \
	 "li	x27,'N'\n\t" \
	 "li	x28,'T'\n\t" \
	 "li	x29,'R'\n\t" \
	 "li 	x30,'_'\n\t");*/

	// Treat IRQ based on ID	
	if(IRQ_ID >= 0 && IRQ_ID < MAX_EXT_INTR)
	{
		if(vec_Ext_Intr_Handler[IRQ_ID] != 0)
			vec_Ext_Intr_Handler[IRQ_ID]();
		else 
			KernelExtIntrDefault(IRQ_ID); // default handler when there is no assigned callback 
	}
	
	// Notify PIC that IRQ was treated
	PIC_ACK = IRQ_ID;
}

// Register external intr handler callbacks from user 
int KernelExtIntrHandlerSet(int n, callback_t handler_callback) 
{
	// Check for valid index 
    if (n < 0 || n >= MAX_EXT_INTR) 
		return N_OUT_OF_BOUNDS;
    
	// Check for valid callback 
    if (handler_callback == NULL) 
		return INVALID_CALLBACK;
	
	// Register callback 
    vec_Ext_Intr_Handler[n] = handler_callback;
	
	return 0;
}

// Default external interrupt handler 
void KernelExtIntrDefault(int irqID)
{
	// DEBUG SIMULATION
    __asm__ volatile 
	("li	x24,''\n\t" \
	 "li	x25,'I'\n\t" \
	 "li 	x26,'N'\n\t" \
	 "li	x27,'T'\n\t" \
	 "li 	x28,'R'\n\t" \
	 "li 	x29,'_'\n\t" \
	 "li 	x30,'D'\n\t"
	);
    
    /*KernelUARTTX("Default INTR callback: ");
	char valText[3]; 
	
	valText[0] = irqID + 0x30;
	valText[1] = '\n';
    valText[2] = '\0';
    
	//KernelUARTTX(valText);*/
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
void KernelBDPortSetup(int config, int enable, int intr)
{
	BDPORT_CFG = config;
	BDPORT_EN = enable;
	BDPORT_INTR = intr;
}

// Read int value from BDPort
int KernelBDPortRead()
{
	return BDPORT_DATA;
}

// Write to BDPort 
void KernelBDPortWrite(int val)
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
void KernelPICMask(char val)
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
void KernelUARTTX(char* str)
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
void KernelRXCallback()
{
	char rxIn = UART_RX;

	rxStr[rxCnt] = rxIn;

	if(rxIn == '\0')
	{
		KernelUARTTX((char*)rxStr);

		rxCnt = 0;
	}
	else
		rxCnt++;
}

							//
							//
							//
//////////////////////////////


//////////////////////////////
//
//	TIMER
//


void KernelTimerSetClock(int clk)
{
    TIMER_BASE_CLK = clk;
}

void KernelTimerSetCount(int cnt)
{
    TIMER_COUNT = cnt;
}

void KernelTimerSetEnabled(int enable)
{
    TIMER_ENABLE = enable;
}

							//
							//
							//
//////////////////////////////