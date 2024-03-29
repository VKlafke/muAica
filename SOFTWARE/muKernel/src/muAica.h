#ifndef _MUAICA_H_
#define _MUAICA_H_

enum Ext_Intr_Reg_Error_Codes
{
	N_OUT_OF_BOUNDS = 1,
	INVALID_CALLBACK,
};

// Define the function pointer type for the intr handler callbacks
typedef void (*callback_t)();

// delay func
void delay(int count)
{
    while(count > 0)
        count--;
}

// ECALL - External interrupts
int Ext_Intr_Register_Callback(int n, callback_t handler_callback);

// ECALL - BDPort 
void BDPort_Setup(int config, int enable, int intr);
void BDPort_Write(int val);
int  BDPort_Read();

// ECALL - PIC_Mask
void PIC_Mask(char val);

// ECALL - UART Send
// str MUST be null terminated;
void UART_Print(char* str);

// ECALL - Timer

// Clock value is given in kHz
void TimerSetBaseClock(int clock);

// Count value given in ms
void TimerSetCount(int count);

void TimerSetEnabled(int enable);

#endif