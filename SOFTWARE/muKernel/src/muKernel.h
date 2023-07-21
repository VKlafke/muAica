#ifndef _MUKERNEL_H_
#define _MUKERNEL_H_

// Kernel functions

// Handles the treatment of exceptions / interrupts.
// Gets trap ID from mcause and calls the appropriate handler for it
int trap_handler(int mcause, int mepc, int a0, int a1, int a2, int a7);

// Handles treatment of external interrupts
// Reads IRQ from PIC and takes appropriate action.
void ext_intr_handler();


// Setup BDPort values 
void Kernel_BDPort_Setup(int config, int enable, int intr);

// Read from BDPort
int Kernel_BDPort_Read();

// Write to BDPort
void Kernel_BDPort_Write();

// Peripherals addresses
#define BDPORT_EN 	0x80000000
#define BDPORT_CFG 	0x80000010
#define BDPORT_DATA 0x80000020
#define BDPORT_INTR 0x80000030

#define PIC_IRQ_ID  0x80001000
#define PIC_ACK     0x80001010
#define PIC_MASK    0x80001020

#endif