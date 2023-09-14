#include "muAica.h"
#include <stdarg.h>
#include <stdio.h>


extern volatile char* tempStr;
extern volatile int strCnt;

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


void break_number(int number, int* a, int* b) 
{
	(*a) = 0;
	(*b) = number;
    
    if(number > 99)
    {
        (*a) = 0;
        (*b) = 0;
        
        return;
    }

	while ((*b) >= 10) {
		(*a)++;
		(*b) -= 10;
	}
}


void callback_button_A8()
{
	 int i = 0;
     
	 // "Debounce"
	 while(i < 900000)
		 i++;
     
        
    int number = countLeft;
    int a = 0;
    int b = 0;
    
    break_number(number, &a, &b);
    
    dispCount[0] = a;
    dispCount[1] = b;
	
    UART_Print("Callback A8: ");
     
            
    char txt[30];
            
    txt[0] = (char)(dispCount[0] + 0x30);
    txt[1] = ' ';
    txt[2] = (char)(dispCount[1] + 0x30);
    txt[3] = ' ';
    txt[4] = (char)(dispCount[2] + 0x30);
    txt[5] = ' ';
    txt[6] = (char)(dispCount[3] + 0x30);
    txt[7] = '\n';
    txt[8] = '\0';
    UART_Print(txt);
 
}



void callback_button_D9()
{
	 int i = 0;
     
	 // "Debounce"
	 while(i < 900000)
		 i++;
	 
	
    countLeft++;
    
    if(countLeft > 99)
        countLeft = 99;
 
   
    int number = countLeft;
    int a = 0;
    int b = 0;
    
    break_number(number, &a, &b);
    
    dispCount[0] = a;
    dispCount[1] = b;
}

void callback_button_C4()
{
	 int i = 0;
     
	 // "Debounce"
	 while(i < 900000)
		 i++;
	 
	
    countLeft--;
    
    if(countLeft < 0)
        countLeft = 0;
 
   
    int number = countLeft;
    int a = 0;
    int b = 0;
    
    break_number(number, &a, &b);
    
    dispCount[0] = a;
    dispCount[1] = b; 
}




void callback_timer()
{   
	int write = Number_BCD[dispCount[0]];
	
	// Left most 7 seg
	write = write | 0x7;
	
	BDPort_Write(write);
    	
    delay(15000);
    
	// Second 7 seg 
	write = Number_BCD[dispCount[1]];
	write = write | 0xB;
	
	BDPort_Write(write);
	
    delay(15000);

	// Third 7 seg
	
	write = Number_BCD[dispCount[2]];
	write = write | 0xD;
	
	BDPort_Write(write);
	
    delay(15000);
    
	// Last 
	
	write = Number_BCD[dispCount[3]];
	write = write | 0xE;
	
	BDPort_Write(write);
    
    //delay(15000);
}

int main()
{	
	UART_Print("INICIOU\n");
	
	// TIMER config
    TimerSetBaseClock(50000); // 50000 kHz (50 MHz)
    TimerSetCount(16); // 16 ms
    TimerSetEnabled(1);
	
    
	//////////////////////////////////////////////////////////////
	//  								  						//
	//  Configure the bidirectional port  						//
	//															//
	//	Config: 0xFE000000, last 7 bits are input				//
	//  Enable: 0xFFFFFFFF										//
	//	  INTR: 0xE0000000, last three bits connected to PIC 		//
	//////////////////////////////////////////////////////////////
	
	int BDP_Cfg  = 0xFE000000;
	int BDP_En   = 0xFFFFFFFF;
	int BDP_Intr = 0xE0000000;
	
	BDPort_Setup(BDP_Cfg, BDP_En, BDP_Intr);
	
	/////////////////////////
	//  				   //
	//  Configure the PIC  //
	//			           //
	/////////////////////////
	
	
	PIC_Mask(0xE3); // Enable (1110 0011) as interrupts 
    
	
	// Register callbacks 
	int ret = Ext_Intr_Register_Callback(7, callback_button_D9);
    Ext_Intr_Register_Callback(6, callback_button_C4);
    Ext_Intr_Register_Callback(5, callback_button_A8);
	
	if(ret == N_OUT_OF_BOUNDS)
		UART_Print("Ext_Intr_Register_Callback Fail: N_OUT_OF_BOUNDS\n");
	else if(ret == INVALID_CALLBACK)
		UART_Print("Ext_Intr_Register_Callback Fail: INVALID_CALLBACK\n");
	else
		UART_Print("Callback registered!\n");

    
    // Register timer callback 
	Ext_Intr_Register_Callback(0, callback_timer);
	
	int secCount = 0;
    
	do
	{
        secCount++;
        
        if(secCount >= 1000000)
        {
            // Incrementa os displays de 7 seg da direita
            countRight++;
            
            if(countRight > 99)
                countRight = 0;

       
            int number = countRight;
            int a = 0;
            int b = 0;
            
            break_number(number, &a, &b);
            
            dispCount[2] = a;
            dispCount[3] = b;
            
            /*UART_Print("Sec Counter: ");
                        
            char txt[30];
                    
            txt[0] = (char)(dispCount[2] + 0x30);
            txt[1] = ' ';
            txt[2] = (char)(dispCount[3] + 0x30);
            txt[3] = ' ';
            txt[4] = (char)(a + 0x30);
            txt[5] = ' ';
            txt[6] = (char)(b + 0x30);
            txt[7] = '\n';
            txt[8] = '\0';
            UART_Print(txt);*/
            
            secCount = 0;
        } 
        
	} while(1);
		
	return 0;
}