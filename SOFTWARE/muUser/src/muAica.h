#ifndef _MUAICA_H_
#define _MUAICA_H_

enum Ext_Intr_Reg_Error_Codes
{
	N_OUT_OF_BOUNDS = 1,
	INVALID_CALLBACK,
};

// Define the function pointer type for the intr handler callbacks
typedef void (*callback_t)();

// ECALL - External interrupts
int ExtIntrRegisterCallback(int n, callback_t handler_callback);

// ECALL - BDPort 
void BDPortSetup(int config, int enable, int intr);
void BDPortWrite(int val);
int  BDPortRead();

// ECALL - PIC_Mask
void PICMask(char val);

// ECALL - UART Send
// str MUST be null terminated;
void UARTPrint(char* str);

char UARTRead(int pooling);


// ECALL - Timer

// Clock value is given in kHz
void TimerSetBaseClock(int clock);

// Count value given in ms
void TimerSetCount(int count);

void TimerSetEnabled(int enable);

#endif