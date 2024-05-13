#include <stddef.h>
#include <stdarg.h>
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
            
            int rs1 = 0;
            int rs2 = 0;
            int rd = 0;
            
            int OPTypeM = KernelDecodeMInstruction(inst, &rs1, &rs2, &rd, userStack);
            
            // reaproveitar multiplicação / divisão em instruções diferentes
            // VERIFICAR existencia de overflow em mul 
     
            // regular multiplication, returns low 32 bits of result 
            if(OPTypeM == MATCH_MUL)
            {
                int sum = 0;
                                
                // If any of the numbers to be multiplied is zero, skip mul 
                if(rs1 != 0 && rs2 != 0)
                {
                    sum = KernelMUL(rs1, rs2);
                }                
                
                // Store result in user stack 
                userStack[rd] = sum;
           
                return mepc + 4; // done, resume at epc+4 
            }
            else if(OPTypeM == MATCH_MULH)
            { // signed - signed mul, return high 32 bits 
                
                int sum = 0;
                                
                // If any of the numbers to be multiplied is zero, skip mul 
                if(rs1 != 0 && rs2 != 0)
                {
                    sum = KernelMULH(rs1, rs2);
                }                
                
                // Store result in user stack 
                userStack[rd] = sum;
           
                return mepc + 4; // done, resume at epc+4        
            }
            else if(OPTypeM == MATCH_MULHSU)
            { // signed - unsigned mul, return high 32 bits 
                
                int sum = 0;
                                
                // If any of the numbers to be multiplied is zero, skip mul 
                if(rs1 != 0 && rs2 != 0)
                {
                    sum = KernelMULHSU(rs1, rs2);
                }                
                
                // Store result in user stack 
                userStack[rd] = sum;
           
                return mepc + 4; // done, resume at epc+4        
            }
            else if(OPTypeM == MATCH_MULHU)
            { // unsigned - unsigned mul, return high 32 bits 
                
                int sum = 0;
                                
                // If any of the numbers to be multiplied is zero, skip mul 
                if(rs1 != 0 && rs2 != 0)
                {
                    sum = KernelMULHU(rs1, rs2);
                }                
                
                // Store result in user stack 
                userStack[rd] = sum;
           
                return mepc + 4; // done, resume at epc+4        
            }
            else if(OPTypeM == MATCH_DIV)
            { // signed - signed div 
                
                // If dividend is 0, skip operation and return 0
                if(rs1 == 0)
                {
                    userStack[rd] = 0;
                    
                    return mepc + 4;
                }
                            
                // Fetch data from registers pointed by instruction 
                int dividend = rs1;
                int divisor  = rs2;
                
                // Do the division 
                int result = KernelDIV(dividend, divisor, NULL);
                
                userStack[rd] = result;
              
                return mepc + 4; // done, resume at epc+4           
            }
            else if(OPTypeM == MATCH_DIVU)
            { // unsigned - unsigned div 
                
                // If dividend is 0, skip operation and return 0
                if(rs1 == 0)
                {
                    userStack[rd] = 0;
                    
                    return mepc + 4;
                }
                            
                // Fetch data from registers pointed by instruction 
                int dividend = rs1;
                int divisor  = rs2;
                
                // Do the division 
                int result = KernelDIVU(dividend, divisor, NULL);
                
                userStack[rd] = result;
              
                return mepc + 4; // done, resume at epc+4           
            }
            else if(OPTypeM == MATCH_REM)
            { // remainder of signed-signed div op 
                                 
                // Fetch data from registers pointed by instruction 
                int dividend = rs1;
                int divisor  = rs2;
                int rem = 0;
                
                // Do the division 
                int result = KernelDIV(dividend, divisor, &rem);
                
                userStack[rd] = rem;
                
                return mepc + 4; // done, resume at epc+4           
            }
            else if(OPTypeM == MATCH_REMU)
            { // remainder of unsigned-unsigned div op 
                                 
                // Fetch data from registers pointed by instruction 
                int dividend = rs1;
                int divisor  = rs2;
                int rem = 0;
                
                // Do the division 
                int result = KernelDIVU(dividend, divisor, &rem);
                
                userStack[rd] = rem;
                
                return mepc + 4; // done, resume at epc+4           
            }
            else
                KernelUARTTX("EXCEPTION: ILLEGAL INSTRUCTION\n");
             
			 
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

/////////////////////////
//
//  'M' extension implementation
//

// Function to emulate the MULHSU instruction in RISC-V
int32_t KernelMULHSU(int32_t multiplicand, uint32_t multiplier)
{
	uint64_t product = 0;  // To hold the full product without loss
	int32_t high = 0;      // To extract and return the high 32 bits
	int sign = multiplicand < 0 ? -1 : 1;  // Determine the sign of rs1

	// Use absolute value of rs1 for multiplication
	uint32_t abs_rs1 = multiplicand < 0 ? (uint32_t)(-multiplicand) : (uint32_t)multiplicand;

	// Iterate through each bit of rs2
	for (int i = 0; i < 32; i++) 
	{
		if (multiplier & (1U << i))
		{
			product += ((uint64_t)abs_rs1 << i);
		}
	}

	// Adjust the sign of the product
	if (sign == -1)
	{
		product = -(int64_t)product;
	}

	// Shift the product right by 32 bits to get the high part
	high = (int32_t)(product >> 32);

	// Apply the sign of rs1 to the result
	return high;
}

// Function to emulate the MULHU instruction in RISC-V for unsigned integers
uint32_t KernelMULHU(uint32_t multiplicand, uint32_t multiplier)
{
	uint64_t product = 0;  // To hold the full product without loss
	uint32_t high = 0;     // To extract and return the high 32 bits

	// Iterate through each bit of rs2
	for (int i = 0; i < 32; i++) 
	{
		if (multiplier & (1U << i))
		{
			product += ((uint64_t)multiplicand << i);
		}
	}

	// Shift the product right by 32 bits to get the high part
	high = (uint32_t)(product >> 32);

	return high;
}

// Function to emulate the MULH instruction in RISC-V for signed integers
int32_t KernelMULH(int32_t multiplicand, int32_t multiplier)
{
	int64_t high = 0; // This will eventually hold the high 32 bits of the result
	uint32_t abs_multiplicand = multiplicand < 0 ? (uint32_t)(-multiplicand) : (uint32_t)multiplicand;
	uint32_t abs_multiplier = multiplier < 0 ? (uint32_t)(-multiplier) : (uint32_t)multiplier;
	int64_t temp_product = 0;

	int sign = (multiplicand < 0) ^ (multiplier < 0) ? -1 : 1;  // Determine the sign of the result

	// Iterate through each bit of rs2
	for (int i = 0; i < 32; i++) 
	{
		if (abs_multiplier & (1 << i))
		{
			temp_product += ((int64_t)abs_multiplicand << i);
		}
	}

	// Adjust the sign of the product
	if (sign == -1)
	{
		temp_product = -temp_product;
	}

	// Shift right to get the high part
	high = temp_product >> 32;

	// Adjust sign
	return (int32_t)high;
}

// MUL instruction 
int32_t KernelMUL(int32_t multiplicand, int32_t multiplier) 
{
	int64_t product = 0;  // Using int64_t to handle potential overflow during multiplication
	int32_t sign = (multiplicand < 0) ^ (multiplier < 0) ? -1 : 1;  // Determine the sign of the result

	// Convert multiplicand and multiplier to their absolute values to simplify multiplication    
	uint32_t abs_multiplicand = multiplicand < 0 ? (uint32_t)(-multiplicand) : (uint32_t)multiplicand;
	uint32_t abs_multiplier = multiplier < 0 ? (uint32_t)(-multiplier) : (uint32_t)multiplier;


	// Perform multiplication using the shift-and-add method
	while (abs_multiplier != 0) 
	{
		if (abs_multiplier & 1) 
		{
			product += abs_multiplicand;  // Add the multiplicand to the product if the current bit of multiplier is 1
		}

		abs_multiplicand <<= 1;  // Left shift the multiplicand (equivalent to multiplying it by 2)
		abs_multiplier >>= 1;    // Right shift the multiplier, moving to the next bit
	}

	// Adjust the sign of the product
	if (sign == -1)
	{
		product = -product; 
	}

	// Cast and return only the lower 32 bits of the product, simulating the behavior of the RISC-V MUL instruction
	return (int32_t)(product);
}

// Function to emulate the DIVU instruction in RISC-V for unsigned division
uint32_t KernelDIVU(uint32_t rs1, uint32_t rs2, uint32_t* rem) 
{
	// Check for division by zero. This condition is handled first to prevent division errors.
	// return all bits set and remainder is the dividend
	if (rs2 == 0)
	{
		if (rem != NULL)
			*rem = rs1; // Set remainder to dividend if pointer is not NULL

		// KernelUARTTX("{EXCEPTION} - DIV BY ZERO - ");

		return UINT32_MAX; // Return error code for division by zero
	}

	uint32_t quotient = 0;
	uint32_t remainder = rs1;  // Start with the remainder equal to rs1
	int i;

	// Perform long division from the most significant bit
	for (i = 31; i >= 0; i--) 
	{
		if ((remainder >> i) >= rs2) 
		{
			remainder -= rs2 << i;
			quotient |= 1U << i;
		}
	}

	// Set remainder if required
	if (rem != NULL)
		*rem = remainder;

	return quotient;
}

// KernelDivide performs a signed division and calculates the remainder.
// It handles edge cases such as division by zero and INT_MIN overflow carefully.
int KernelDIV(int dividend, int divisor, int* rem)
{
	// Check for division by zero. This condition is handled first to prevent division errors.
	// It returns INT32_MIN as an error code and sets the remainder to 0 if the pointer is not NULL.
	if (divisor == 0)
	{
		if (rem != NULL) 
			*rem = dividend; // Set remainder to dividend if pointer is not NULL

		KernelUARTTX("{EXCEPTION} - DIV BY ZERO - \n");

		return -1; // Return error code for division by zero
	}

	// Handle the special case of INT_MIN divided by -1, which causes overflow in a 32-bit environment.
	// Returns INT_MIN and sets the remainder to 0, per spec.
	if (dividend == INT_MIN && divisor == -1)
	{
		if (rem != NULL) 
			*rem = 0; // Set remainder to 0

		KernelUARTTX("{EXCEPTION} - OVERFLOW - \n");
        
		return INT_MIN;
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

// Check if instruction is part of 'M' extension, decode if true.
// returns instruction ID
// "outRs1" and "outRs2" return the value extracted from the registers pointed by the instruction 
// "outDest" returns the ID of the dest register, corrected for our modified user stack.
int KernelDecodeMInstruction(int instruction, int* outRs1, int* outRs2, int* outDest, unsigned int* userStack)
{
    // Check if funct7 and opcode match M extension
    if((instruction & MASK_F7OP) != MATCH_M) 
        return -1; 
    
    // Get register IDs
    int rd = (instruction >> 7) & 0x01F; 
    int rs1 = (instruction >> 15) & 0x01F;
    int rs2 = (instruction >> 20) & 0x01F;

    // Special case for x0 reg, since it's not in the stack 
    // and x2 is also not available.
    if(rs1 == 0 || rs1 == 2)
    {
        // no caso de rs1 = x2 printar erro / exceção 
        
        KernelUARTTX("[rs1] Error! Trying to multiply using x2 (sp) as operand.\n\n");
        
        *outRs1 = 0;
    }
    else if(rs1 == 1)
    { // Special case for x1 reg 
        *outRs1 = userStack[0];
    }
    else
    {
        // -2 because we don't have reg x2 in our stack. x1 = 0, x3 = 1 ...
        *outRs1 = userStack[rs1-2];
    }
    
    // Special case for x0 reg, since it's not in the stack 
    // and x2 is also not available.
    if(rs2 == 0 || rs2 == 2)
    {   
        KernelUARTTX("[rs2] Error! Trying to multiply using x2 (sp) as operand.\n\n");
        *outRs2 = 0;
    }
    else if(rs2 == 1)
    { // Special case for x1 reg 
        *outRs2 = userStack[0];
    }
    else
    {
        // -2 because we don't have reg x2 in our stack. x1 = 0, x3 = 1 ...
        *outRs2 = userStack[rs2-2];
    }
    
    // destination reg, corrected for our stack 
    *outDest = rd-2;
    
    // return type of operation
    if((instruction & MASK_EXTM) == MATCH_MUL) 
        return MATCH_MUL; // signed MUL
    else if((instruction & MASK_EXTM) == MATCH_MULH) 
        return MATCH_MULH; // signed MULH
    else if((instruction & MASK_EXTM) == MATCH_MULHSU) 
        return MATCH_MULHSU; // signed/unsigned MULHSU
    else if((instruction & MASK_EXTM) == MATCH_MULHU) 
        return MATCH_MULHU; // signed/unsigned MULHU
    else if((instruction & MASK_EXTM) == MATCH_DIV)
        return MATCH_DIV; // signed DIV
    else if((instruction & MASK_EXTM) == MATCH_DIVU)
        return MATCH_DIVU; // unsigned DIV
    else if((instruction & MASK_EXTM) == MATCH_REM)
        return MATCH_REM; // signed remainder
    else if((instruction & MASK_EXTM) == MATCH_REMU)
        return MATCH_REMU; // unsigned remainder
    else 
        return -1; // not found
}


							//
							//
							//
//////////////////////////////

//////////////////////////////
//
//	Helper functions
//
/*
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
}*/
							//
							//
							//
//////////////////////////////