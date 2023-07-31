#ifndef _MUAICA_H_
#define _MUAICA_H_

// Define the function pointer type for the intr handler callbacks
typedef void (*callback_t)();

// ECALL - External interrupts
void Ext_Intr_Register_Callback(int n, callback_t handler_callback);

// ECALL - BDPort 
void BDPort_Setup(int config, int enable, int intr);
void BDPort_Write(int val);
int  BDPort_Read();

// ECALL - PIC_Mask
void PIC_Mask(char val);

// ECALL - UART Send
// str MUST be null terminated;
void UART_Print(char* str);

#endif