#include "muAica.h"
#include "muLib.h"
#include <stdarg.h>
#include <stdio.h>


volatile int countLeft = 0;  // left two 7 seg disp
volatile int countRight = 0; // right two 7 seg disp 
volatile int dispCount[4] = {0, 0, 0, 0}; // the number for each 7 seg disp

// Convert decimal to 7seg 
volatile int Number_BCD[16] = 
{
    0xC00,
    0xF90,
    0xA40,
    0xB00,
    0x990,
    0x920,
    0x820,
    0xF80,
    0x800,
    0x900,
    0xA00, // a
    0x830, // b
    0xC60, // c
    0xA10, // d
    0x860, // e
    0x8E0 // f
};

void CallbackTimer()
{   
	int write = Number_BCD[dispCount[0]];
	
	// Left most 7 seg
	write = write | 0x7;
	
	BDPortWrite(write);
    	
    delay(25000);
    
	// Second 7 seg 
	write = Number_BCD[dispCount[1]];
	write = write | 0xB;
	
	BDPortWrite(write);
	
    delay(25000);

	// Third 7 seg	
	write = Number_BCD[dispCount[2]];
	write = write | 0xD;
	
	BDPortWrite(write);
	
    delay(25000);
    
	// Last 
	write = Number_BCD[dispCount[3]];
	write = write | 0xE;
	
	BDPortWrite(write);
    
}

void CallbackButtonC4()
{
    int i = 0;
     
	 // Debounce
	 while(i < 900000)
		 i++;
     
     countRight--;
     
     if(countRight < 0)
         countRight = 99;

     dispCount[2] = countRight / 10;
     dispCount[3] = countRight % 10;
}

void CallbackButtonD9()
{
    int i = 0;
     
	 // Debounce
	 while(i < 900000)
		 i++;
     
     countRight++;
     
     if(countRight > 99)
         countRight = 0;

     dispCount[2] = countRight / 10;
     dispCount[3] = countRight % 10;
}
    
int main()
{
	//////////////////////////////////////////////////////////////
	//  								  						//
	//  Configure the bidirectional port  						//
	//															//
	//	Config: 0xFE000000, last 7 bits are input				//
	//  Enable: 0xFFFFFFFF										//
	//	  INTR: 0xC0000000, last two bits connected to PIC 	//
	//////////////////////////////////////////////////////////////

	int BDP_Cfg  = 0xFF000000;
	int BDP_En   = 0xFFFFFFFF;
	int BDP_Intr = 0xC0000000;
	
	BDPortSetup(BDP_Cfg, BDP_En, BDP_Intr);
    
	UARTPrint("SETUP BD PORT\n");
    
    // Timer callback to drive the displays 
	ExtIntrRegisterCallback(1, CallbackTimer);
    
    // Button callback 
	ExtIntrRegisterCallback(7, CallbackButtonD9);
	ExtIntrRegisterCallback(6, CallbackButtonC4);
    
	UARTPrint("SETUP TIMER CALLBACK \n");
    
	PICMask(0xC3); // Enable (1100 0011) as interrupts 
    
    UARTPrint("SETUP PIC \n");
    
    // TIMER config
    TimerSetBaseClock(50000); // 50000 kHz (50 MHz)
    TimerSetCount(16); // 16 ms
    TimerSetEnabled(1);

	UARTPrint("SETUP TIMER\n");
    
    int secCount = 0;
 
	do
	{
        // Wait for string and then echo it back
        char *str = NULL;
        
        if(GetString(&str))
            UARTPrint(str);
        
        
        // Increase counter 
        if(secCount > 100000)
        {
            secCount = 0;
            
            countLeft++;
            
            if(countLeft > 99)
                countLeft = 0;
            
            dispCount[0] = countLeft / 10;
            dispCount[1] = countLeft % 10;
        }            
        
        secCount++;
        
	} while(1);

    
    return 0;
}
