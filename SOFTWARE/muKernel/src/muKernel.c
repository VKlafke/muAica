#include <stddef.h>
#include <stdarg.h>
#include <stdint.h>
#include <limits.h>
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


void HexToAscii(int num, char* dest) 
{
    // Start from the end of the buffer, leaving space for the null terminator
    dest[8] = '\0';

    for (int i = 7; i >= 0; i--) {
        // Extract the lowest 4 bits (one hex digit)
        int hexDigit = num & 0xF;
        
        // Convert the hex digit to its ASCII representation
        if (hexDigit >= 0 && hexDigit <= 9) {
            // '0' to '9'
            dest[i] = '0' + hexDigit;
        } else {
            // 'A' to 'F'
            dest[i] = 'A' + (hexDigit - 10);
        }

        // Shift the number to get the next hex digit in the next iteration
        num >>= 4;
    }
}

struct stStackFrame
{
    int ra; // x1, return addr
    int gp; // x3, global pointer 
    int tp; // x4, thread pointer 
    
    int t0; // x5, temp 0
    int t1; // x6, temp 1
    int t2; // x7, temp 2
    
    int s0; // x8, saved register 0 / frame pointer 
    int s1; // x9, saved register 1
    
    int a0; // x10, func ret val 
    int a1; // x11, arg 0
    int a2; // x12, arg 1
    int a3; // x13, arg 2 
    int a4; // x14, arg 3
    int a5; // x15, arg 4
    int a6; // x16, arg 5
    int a7;  // x17, arg 6
    
    int s2;  // x18, Saved register
    int s3;  // x19, Saved register
    int s4;  // x20, Saved register
    int s5;  // x21, Saved register
    int s6;  // x22, Saved register
    int s7;  // x23, Saved register
    int s8;  // x24, Saved register
    int s9;  // x25, Saved register
    int s10; // x26, Saved register
    int s11; // x27, Saved register
    int t3; // x28: Temporary
    int t4; // x29: Temporary
    int t5; // x30: Temporary
    int t6;    // x31: Temporary
};

// Main trap handler 
// Deals with exceptions or calls ext intr dispatcher
int TrapHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2, unsigned int* userStack) 
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
            
            int instAddr = 0x90000000 | mepc;
            
            int inst = *((int*)instAddr); // fetch inst
            
             
            // check opcode & function codes
            if((inst & MASK_EXTM) == MATCH_MUL) 
            {
                // MUL. extract rd, rs1, rs2 from inst
                int rd = (inst >> 7) & 0x01F; 
                int rs1 = (inst >> 15) & 0x01F;
                int rs2 = (inst >> 20) & 0x01F;
                            
                // Fetch data from registers pointed by instruction 
                int rs1Val = userStack[rs1-2]; // -2 because we don't have reg x2 in our stack. x1 = 0, x3 = 1 ...
                int rs2Val = userStack[rs2-2];

                // Perform MUL op 
                // TODO: better mul 
                int sum = 0;
                for(int i = 0; i < rs1Val; i++)
                {
                    sum += rs2Val;
                }                  
                
                userStack[rd-2] = sum;
              
                return mepc + 4; // done, resume at epc+4
            }
            else if((inst & MASK_EXTM) == MATCH_DIV)
            {
                // MUL. extract rd, rs1, rs2 from inst
                int rd = (inst >> 7) & 0x01F; 
                int rs1 = (inst >> 15) & 0x01F;
                int rs2 = (inst >> 20) & 0x01F;
                            
                // Fetch data from registers pointed by instruction 
                int dividend = userStack[rs1-2]; // -2 because we don't have reg x2 in our stack. x1 = 0, x3 = 1 ...
                int divisor = userStack[rs2-2];        
                
                // Do the division 
                int result = KernelDivide(dividend, divisor, NULL);
                
                userStack[rd-2] = result;
              
                return mepc + 4; // done, resume at epc+4
                
            }

			 
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
	//BDPORT_INTR = 0;
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


// Get data from RX 
char KernelRXRead()
{
    return UART_RX;
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


//////////////////////////////
//
//	Helper functions
//

unsigned int KernelMultiply(unsigned int multiplicand, unsigned int multiplier)
{
	unsigned int product = 0; // Initialize the product to 0

	while (multiplier > 0) 
	{
		// Check if the least significant bit of the multiplier is 1
		if (multiplier & 1) 
		{	
			product += multiplicand; // Add the multiplicand to the product if the current bit of multiplier is 1
		}
		multiplicand <<= 1; // Left shift the multiplicand (equivalent to multiplying it by 2)
		multiplier >>= 1; // Right shift the multiplier, moving to the next bit
	}

	return product; // Return the final product
}

// KernelDivide performs a signed division and calculates the remainder.
// It handles edge cases such as division by zero and INT_MIN overflow carefully.
int KernelDivide(int dividend, int divisor, int* rem)
{
	// Check for division by zero. This condition is handled first to prevent division errors.
	// It returns INT32_MIN as an error code and sets the remainder to 0 if the pointer is not NULL.
	if (divisor == 0)
	{
		if (rem != NULL) *rem = 0; // Set remainder to 0 if pointer is not NULL

		// KernelUARTTX("{DIV EXCEPTION} - DIV BY ZERO - ");

		return INT32_MIN; // Return error code for division by zero
	}

	// Handle the special case of INT_MIN divided by -1, which causes overflow in a 32-bit environment.
	// Returns INT_MAX as the closest valid result and sets the remainder to 0.
	if (dividend == INT_MIN && divisor == -1)
	{
		if (rem != NULL) *rem = 0; // Set remainder to 0
		// KernelUARTTX("{DIV EXCEPTION} - OVERFLOW - ");
		return INT_MAX; // Return INT_MAX to avoid overflow
	}

	// Convert dividend and divisor to their absolute values to simplify the division operation.
	// Special handling for INT_MIN to avoid overflow, converting it to unsigned for correct absolute value calculation.
	unsigned int tempDividend = dividend == INT_MIN ? (unsigned int)INT_MAX + 1 : (unsigned int)(dividend < 0 ? -dividend : dividend);
	unsigned int tempDivisor = divisor == INT_MIN ? (unsigned int)INT_MAX + 1 : (unsigned int)(divisor < 0 ? -divisor : divisor);

	unsigned int quotient = 0; // Initialize quotient
	int sign = (dividend < 0) ^ (divisor < 0) ? -1 : 1; // Determine the sign of the result based on dividend and divisor

	// Perform division using bit manipulation.
	while (tempDividend >= tempDivisor)
	{
		unsigned int shift = 0; // Initialize shift counter
		// Determine the maximum shift for tempDivisor that makes it less or equal to half of tempDividend
		// This ensures we don't overshoot the dividend when subtracting.
		while ((tempDivisor << shift) <= (tempDividend >> 1))
		{
			shift++;
		}

		// Subtract the shifted divisor from the dividend and add the corresponding value to the quotient.
		tempDividend -= tempDivisor << shift;
		quotient += 1U << shift;
	}

	// If a remainder is requested, calculate it using the final value of tempDividend.
	// The sign of the remainder matches the sign of the original dividend.
	if (rem != NULL)
	{
		*rem = dividend < 0 ? -(int)tempDividend : (int)tempDividend;
	}

	int result = (int)quotient; // Prepare the final quotient for sign adjustment

	// Adjust the quotient's sign based on the determined sign.
	if (sign == -1)
	{
		result = -result; // Apply the sign to the quotient
	}

	return result; // Return the calculated quotient
}


// Converts an integer to a string and appends it to the buffer.
// Returns the number of characters written.
int KernelIntToString(char* buf, int value) 
{
	char temp[32]; // Temporary buffer to hold the integer characters in reverse order
	int i = 0, j, len = 0;
	int isNegative = value < 0;

	if (isNegative) 
	{
		value = -value; // Make the value positive for processing
	}

	// Extract digits
	do 
	{
		temp[i++] = (value % 10) + '0'; // Convert integer to character
		value /= 10;
	} while (value);

	if (isNegative) 
	{
		temp[i++] = '-';
	}

	len = i;
	// Reverse the string into the output buffer
	for (j = 0; j < len; j++) 
	{
		buf[j] = temp[len - 1 - j];
	}
	buf[len] = '\0'; // Null-terminate the string

	return len; // Return the length of the string, excluding the null terminator
}

// Copies the source string into the destination buffer.
// Returns the number of characters copied (excluding the null terminator).
int KernelStrcpy(char* dest, const char* src) 
{
	int count = 0;
	while (*src) 
	{
		*dest++ = *src++;
		count++;
	}
	*dest = '\0'; // Null-terminate the destination string

	return count;
}

// Scans string for formatters (%d / %s / %%) and replaces them with data from 
// argument list
void KernelSprintf(char* buf, const char* format, ...) 
{
	va_list args;
	va_start(args, format);

	const char* p = format;
	char* buf_ptr = buf;
	while (*p) 
	{
		if (*p == '%') 
		{
			switch (*++p) 
			{ // Move to the specifier character
			case 'd': 
			{ // Integer
				int i = va_arg(args, int);
				buf_ptr += KernelIntToString(buf_ptr, i);
				break;
			}
			case 's': 
			{ // String
				char* s = va_arg(args, char*);
				buf_ptr += KernelStrcpy(buf_ptr, s);
				break;
			}
			case '%': 
			{ // Percent sign
				*buf_ptr++ = '%';
				break;
			}
			default: // Unsupported format
				*buf_ptr++ = '%';
				*buf_ptr++ = *p;
				break;
			}
		}
		else 
		{
			*buf_ptr++ = *p; // Copy regular character
		}
		p++;
	}

	*buf_ptr = '\0'; // Null-terminate the buffer
	va_end(args);
}
							//
							//
							//
//////////////////////////////