#ifndef _MUAICA_H_
#define _MUAICA_H_

enum Ext_Intr_Reg_Error_Codes
{
	N_OUT_OF_BOUNDS = 1,
	INVALID_CALLBACK,
};


// delay func
void delay(int count)
{
    while(count > 0)
        count--;
}

// Define the function pointer type for the intr handler callbacks
typedef void (*callback_t)();

////////////////////////////////
// SCall - External interrupts
int ExtIntrRegisterCallback(int n, callback_t handler_callback);

////////////////
// SCall - BDPort 
void BDPortSetup(int config, int enable, int intr);
void BDPortWrite(int val);
int  BDPortRead();

//////////////////////
// SCall - PIC_Mask
void PICMask(char val);

////////////////
// SCall - UART
// str MUST be null terminated;
void UARTPrint(char* str);

char UARTRead(int pooling);

// Read string from UART
int GetString(char** pStr);

////////////////
// SCall - Timer

// Base clock acts as a prescaler for the timer
void TimerSetBaseClock(int clock);

// Count value, time granularity defined by base clock 
void TimerSetCount(int count);

// Enable / disable timer 
void TimerSetEnabled(int enable);

///////////////////
// SCall - Watchdog

// Base clock acts as a prescaler for the timer
void WatchdogSetBaseClock(int clock);

// Count value, time granularity defined by base clock 
void WatchdogSetCount(int count);

// Enable / disable timer 
void WatchdogSetEnabled(int enable);

// Signal watchdog 
void WatchdogKick();

#endif