#include "muAica.h"
#include "muLib.h"
#include <stdarg.h>
#include <stdio.h>

char strBuf[128];

char recvStr[128];
int recvStrCnt = 0;
    
void RXCallback()
{
   // char recvByte = UARTRead(0);
    
    //recvStr[recvStrCnt++] = recvByte;
    
    //muSprintf(strBuf, "RX Callback: %c\n", recvByte);
    
    UARTPrint("USER RX CALLBACK\n");
    
}

#define PIC_IRQ_ID  (*((volatile char*) 0x80001000))
#define PIC_ACK     (*((volatile char*) 0x80001010))
#define PIC_MASK    (*((volatile char*) 0x80001020))

int main()
{
	/*int IRQ_ID = PIC_IRQ_ID;
	int MASK = PIC_MASK;
    
    char strBuf[128];
    muSprintf(strBuf, "%d %d\n", IRQ_ID, MASK);
    UARTPrint(strBuf);
    
    PIC_ACK = IRQ_ID;
    
    IRQ_ID = PIC_IRQ_ID;
   
    muSprintf(strBuf, "%d\n", IRQ_ID);
    UARTPrint(strBuf);*/
   
    // Register callback for RX 
    ExtIntrRegisterCallback(0, RXCallback);
   
    UARTPrint("Callback registered \n");

    // Enable RX callback only
    //PICMask(0x0);
    
    PICMask(0x1);
    
    UARTPrint("PIC mask ok\n");
    
   
    int i = 0;
    
    while(1)
    {
        i++;
        
        if(i > 50000)
        {
            i = 0;
            
            UARTPrint("i reset\n");
        }
    }
    
    UARTPrint("Something went wrong...\n");
    
    /*
    while(1)
    {
        char test = UARTRead(1);
        
        muSprintf(strBuf, "%c", test);
        UARTPrint(strBuf);
    }*/
    
    return 0;
}
