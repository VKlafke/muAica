#ifndef _MUKERNEL_H_
#define _MUKERNEL_H_

// Peripherals addresses
#define BDPORT_EN 	(*((volatile int*) 0x80000000))
#define BDPORT_CFG 	(*((volatile int*) 0x80000010))
#define BDPORT_DATA (*((volatile int*) 0x80000020))
#define BDPORT_INTR (*((volatile int*) 0x80000030))

#define PIC_IRQ_ID  (*((volatile char*) 0x80001000))
#define PIC_ACK     (*((volatile char*) 0x80001010))
#define PIC_MASK    (*((volatile char*) 0x80001020))

#define UART_TX		(*((volatile char*) 0x80002000))
#define UART_RX		(*((volatile char*) 0x80003000))
#define UART_RX_DV	(*((volatile char*) 0x80005000))

#define TIMER_BASE_CLK (*((volatile int*) 0x80004000))
#define TIMER_COUNT    (*((volatile int*) 0x80004010))
#define TIMER_ENABLE   (*((volatile char*) 0x80004020))	

// Default values
#define MAX_EXT_INTR 8

// Function implementation
// M extension signature:
//   funct7 = 0000001b
//   opcode = 0110011b
// MUL: funct3 = 000
// DIV: funct3 = 100

#define MASK_EXTM  0xFE00707F // 0000 001 rs2 (5b) rs1 (5b) 000 (funct3) rd (5b) 0110011 (opcode)

#define MATCH_MUL 0x02000033 // MUL signature 
#define MATCH_DIV 0x02004033 // DIV signature
	
// Trap causes 
enum Kernel_Trap_Codes
{
	EX_MISALIGNED_INSTRUCTION_ADDR = 1,
	EX_ILLEGAL_INSTRUCTION, 
    EX_MISALIGNED_DATA_ADDR = 4,
    EX_ECALL = 8,
};

// External callback reg issue codes
enum Ext_Intr_Reg_Error_Codes
{
	N_OUT_OF_BOUNDS = 1,
	INVALID_CALLBACK,
};



// External interrupt callback typedef 
typedef void (*callback_t)();

// Kernel functions

// 
int main();

// Handles the treatment of exceptions / interrupts.
// Gets trap ID from mcause and calls the appropriate handler for it
int TrapHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2, unsigned int* sp);


///////////////////////
//
// External interrupts 
//

// Dispatches external interrupts to the appropriate handler 
// Reads IRQ from PIC then calls the configured callback,
// if callback not set, defaults to Kernel_Ext_Intr_default() 
void KernelExtIntrDispatcher();

// Register external intr handler callbacks from user 
int KernelExtIntrHandlerSet(int n, callback_t handler_callback);

// Default callback for external intr 
void KernelExtIntrDefault(int irqID);

//
/////////////////////////


/////////////////////////
//
//  BDPort 
//

// Setup BDPort values 
void KernelBDPortSetup(int config, int enable, int intr);

// Read from BDPort
int KernelBDPortRead();

// Write to BDPort
void KernelBDPortWrite();

//
//////////////////////////

/////////////////////////
//
//  PIC  
//

// Set the PIC intr mask
void KernelPICMask(char val);

//
//////////////////////////


/////////////////////////
//
//  UART  
//

// Send string over TX 
void KernelUARTTX(char* str);


// Get data from RX 
char KernelRXRead();

//
//////////////////////////


/////////////////////////
//
//  TIMER 
//

// Set the base clock used for timer calculations
void KernelTimerSetClock(int clk);

// Set the timer count target value, in ms
void KernelTimerSetCount(int cnt);

// Enable / disable the timer 
void KernelTimerSetEnabled(int enable);

//
//////////////////////////



/////////////////////////
//
//  Helper functions
//

// KernelDivide performs a signed division and calculates the remainder.
// It handles edge cases such as division by zero and INT_MIN overflow carefully.
int KernelDivide(int dividend, int divisor, int* rem);

// Converts an integer to a string and appends it to the buffer.
// Returns the number of characters written.
int KernelIntToString(char* buf, int value);

// Copies the source string into the destination buffer.
// Returns the number of characters copied (excluding the null terminator).
int KernelStrcpy(char* dest, const char* src);

// Scans string for formatters (%d / %s / %%) and replaces them with data from 
// argument list
void KernelSprintf(char* buf, const char* format, ...);

//
//////////////////////////


#endif