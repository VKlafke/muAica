#ifndef _MUKERNEL_H_
#define _MUKERNEL_H_

// Peripherals addresses
#define BDPORT_EN 	0x80000000
#define BDPORT_CFG 	0x80000010
#define BDPORT_DATA 0x80000020
#define BDPORT_INTR 0x80000030

#define PIC_IRQ_ID  0x80001000
#define PIC_ACK     0x80001010
#define PIC_MASK    0x80001020

// Default values

#define MAX_EXT_INTR 8

// External interrupt callback typedef 
typedef void (*callback_t)();

// Kernel functions

// Handles the treatment of exceptions / interrupts.
// Gets trap ID from mcause and calls the appropriate handler for it
int trap_handler(int mcause, int mepc, int a0, int a1, int a2, int ecall_func);


///////////////////////
//
// External interrupts 
//

// Dispatches external interrupts to the appropriate handler 
// Reads IRQ from PIC then calls the configured callback,
// if callback not set, defaults to Kernel_Ext_Intr_default() 
void Kernel_Ext_Intr_Dispatcher();

// Register external intr handler callbacks from user 
void Kernel_Ext_Intr_Handler_Set(int n, callback_t handler_callback);

// Default callback for external intr 
void Kernel_Ext_Intr_default();

//
/////////////////////////


/////////////////////////
//
//  BDPort 
//

// Setup BDPort values 
void Kernel_BDPort_Setup(int config, int enable, int intr);

// Read from BDPort
int Kernel_BDPort_Read();

// Write to BDPort
void Kernel_BDPort_Write();

//
//////////////////////////

/////////////////////////
//
//  PIC  
//

// Set the PIC intr mask
void Kernel_PIC_Mask(char val);

//
//////////////////////////

#endif