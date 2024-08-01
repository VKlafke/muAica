#ifndef _MUKERNEL_H_
#define _MUKERNEL_H_

#include <stdint.h>

// Peripherals addresses
#define BDPORT_EN 	(*((volatile int*) 0x80000000))
#define BDPORT_CFG 	(*((volatile int*) 0x80000010))
#define BDPORT_DATA (*((volatile int*) 0x80000020))
#define BDPORT_INTR (*((volatile int*) 0x80000030))

#define PIC_IRQ_ID  (*((volatile char*) 0x80001000))
#define PIC_ACK     (*((volatile char*) 0x80001010))
#define PIC_MASK    (*((volatile char*) 0x80001020))

#define UART_TX		(*((volatile unsigned char*) 0x80002000))
#define UART_RX		(*((volatile char*) 0x80003000))
#define UART_RX_DV	(*((volatile char*) 0x80005000))

#define TIMER_BASE_CLK (*((volatile int*) 0x80004000))
#define TIMER_COUNT    (*((volatile int*) 0x80004010))
#define TIMER_ENABLE   (*((volatile char*) 0x80004020))	

#define WATCHDOG_BASE_CLK (*((volatile int*) 0x80006000))
#define WATCHDOG_COUNT    (*((volatile int*) 0x80006010))
#define WATCHDOG_ENABLE   (*((volatile char*) 0x80006020))	
#define WATCHDOG_KICK     (*((volatile char*) 0x80006030))	

// Default values
#define MAX_EXT_INTR 8

// Function implementation
// M extension signature:
//   funct7 = 0000001b
//   opcode = 0110011b
// MUL: funct3 = 000
// DIV: funct3 = 100

#define MASK_F7OP  0xFE00007F // Mask "funct7" and "opcode" fields of instruction 
#define MASK_EXTM  0xFE00707F // Mask "funct7" "funct3" and opcode 
                              // 0000 001 rs2 (5b) rs1 (5b) 000 (funct3) rd (5b) 0110011 (opcode) < M extension

#define MATCH_M      0x02000033 // 'M' extension instructions 
#define MATCH_MUL    0x02000033 // MUL signature 
#define MATCH_MULH   0x02001033 // MULH signature 
#define MATCH_MULHSU 0x02002033 // MULHSU signature 
#define MATCH_MULHU  0x02003033 // MULHU signature 
#define MATCH_DIV    0x02004033 // DIV signature 
#define MATCH_DIVU   0x02005033 // DIVU signature 
#define MATCH_REM    0x02006033 // REM signature
#define MATCH_REMU   0x02007033 // REMU signature
	
// Trap causes 
enum Kernel_Trap_Codes
{
	EX_MISALIGNED_INSTRUCTION_ADDR = 1,
	EX_ILLEGAL_INSTRUCTION         = 2, 
    EX_MISALIGNED_DATA_ADDR        = 4,
    EX_ECALL                       = 8,
};

// External callback reg issue codes
enum Ext_Intr_Reg_Error_Codes
{
	N_OUT_OF_BOUNDS    = 1,
	INVALID_CALLBACK   = 2,
};

// External interrupt callback typedef 
typedef void (*callback_t)();

// CSR access functions 

// Machine Trap-Vector Base Addr
static inline uint32_t r_mtvec()
{
  uint32_t x;
  asm volatile("csrr %0, mtvec" : "=r" (x) );
  return x;
}

static inline void w_mtvec(uint32_t x)
{
  asm volatile("csrw mtvec, %0" : : "r" (x));
}

// Machine Status Register 
static inline uint64_t r_mstatus()
{
  uint64_t x;
  asm volatile("csrr %0, mstatus" : "=r" (x) );
  return x;
}

static inline void w_mstatus(uint64_t x)
{
  asm volatile("csrw mstatus, %0" : : "r" (x));
}

// Machine Interrupt Enable Register 
static inline uint64_t r_mie()
{
  uint64_t x;
  asm volatile("csrr %0, mie" : "=r" (x) );
  return x;
}

static inline void w_mie(uint64_t x)
{
  asm volatile("csrw mie, %0" : : "r" (x));
}

// Kernel functions

// 
int main();

// Handles the treatment of exceptions / interrupts from USER MODE
// Gets trap ID from mcause and calls the appropriate handler for it
int KernelTrapHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2, unsigned int* sp);

// Handles treatment of exceptions that happen in KERNEL MODE 
int KernelTrapReentryHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2, unsigned int* userStack);


int KernelExceptionHandler(int mode, int mcause, int mepc, int ecallFunc, int a0, int a1, int a2, unsigned int* userStack);

///////////////////////
//
// External interrupts 
//

// Dispatches external interrupts to the appropriate handler 
// Reads IRQ from PIC then calls the configured callback,
// if callback not set, defaults to Kernel_Ext_Intr_default() 
void KernelExtIntrDispatcher(int irqID);

// Register external intr handler callbacks from user 
int KernelExtIntrHandlerSet(int n, callback_t handler_callback);

// Reset external intr handler callback to default 
int KernelExtIntrHandlerReset(int n);

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
char KernelRXRead(int pooling);

// Stores received bytes in a buffer untill 'return' key is received
// once we receive 'return', signal that a line is ready to be read
// by KernelGetString
void KernelRXCallback();

// Return string size, if one is ready, and pointer to str 
// 0 otherwise
int KernelGetString(char** pStr);

//
//////////////////////////


/////////////////////////
//
//  TIMER 
//

// Set the base clock used for timer calculations
void KernelTimerSetClock(int clk);

// Set the timer count target value
void KernelTimerSetCount(int cnt);

// Enable / disable the timer 
void KernelTimerSetEnabled(int enable);

//
//////////////////////////

//////////////////////////////
//
// WATCHDOG TIMER
//

// Set the base clock used for timer calculations (prescaler)
void KernelWatchdogSetClock(int clk);

// Set the timer count target value
void KernelWatchdogSetCount(int cnt);

// Enable / disable the watchdog 
void KernelWatchdogSetEnabled(int enable);

// Reset the watchdog count 
void KernelWatchdogKick();
							//
							//
							//
//////////////////////////////

/////////////////////////
//
//  'M' extension implementation
//

uint64_t KernelUnsignedMultiply(uint32_t multiplicand, uint32_t multiplier);
int64_t KernelSignedMultiply(int32_t multiplicand, int32_t multiplier, int extract_high);
int32_t KernelMULHSU(int32_t multiplicand, uint32_t multiplier);
uint32_t KernelMULHU(uint32_t multiplicand, uint32_t multiplier);
int32_t KernelMULH(int32_t multiplicand, int32_t multiplier);

// MUL instruction 
int32_t KernelMUL(int32_t multiplicand, int32_t multiplier);

uint32_t KernelDIVU(uint32_t rs1, uint32_t rs2, uint32_t* rem);
// KernelDIV performs a signed division and calculates the remainder.
// It handles edge cases such as division by zero and INT_MIN overflow.
int KernelDIV(int dividend, int divisor, int* rem);


// Decode M type instruction and return type 
int KernelDecodeMInstruction(int instruction, int* outRs1, int* outRs2, int* outDest, unsigned int* userStack);

//
////////////////////////

/////////////////////////
//
//  Helper functions
//



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