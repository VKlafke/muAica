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
int TrapHandler(int mcause, int mepc, int ecallFunc, int a0, int a1, int a2);


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

#endif