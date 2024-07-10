#include "muKernel.h"
#include <stdarg.h>

// constante endereços programa usuario
void (*UserMainPtr)(void) = (void(*)(void))0x1BCC;

int lastReceiveSize = 0;

int main()
{   
    // Infinite loop so we always come back to the 
    // software receiving
    while(1)
    {
        // Send boot message
        KernelUARTTX("->");   
  
        int shiftCount = 24;
        int recvSize = 0;
        
        // Get the size of the software that will be sent
        while(shiftCount >= 0)
        {
            // Wait for rx data 
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead(0);
                
            int temp = rxData << shiftCount;
            
            recvSize = recvSize | temp;
            
            shiftCount -= 8;
        }
        
        lastReceiveSize = recvSize;
        
        int i = 0;
        int recvData = 0;
        int instAddr = 0x90001BCC;
        
        shiftCount = 0;
        
        // Get the software 
        while(i < recvSize)
        {
            // Wait for rx data
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead(0);
            
            int temp = rxData << shiftCount;
            
            recvData = recvData | temp;
            
            shiftCount += 8;
            i++;

            // Commit data to instruction memory
            if(shiftCount >= 32)
            {
                *(int*)instAddr = recvData;
                       
                recvData = 0;
                instAddr += 4;
                shiftCount = 0;
            }
        }
        
        //KernelUARTTX("RECEIVED .text\n");   
        
        // size .data
        shiftCount = 24;
        recvSize = 0;
        
        // Get the size of the .data section
        while(shiftCount >= 0)
        {
            // Wait for rx data 
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead(0);
            
            int temp = rxData << shiftCount;
            
            recvSize = recvSize | temp;
            
            shiftCount -= 8;
        }
                      
        // Receive .data section        
        i = 0;
        recvData = 0;
        int dataAddr = 0x00000800;
        
        shiftCount = 0;
        
        while(i < recvSize)
        {
            // Wait for rx data
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead(0);
            
            int temp = rxData << shiftCount;
            
            recvData = recvData | temp;
            
            shiftCount += 8;
            i++;
                      
            // If receiving data stops before a multiple of 4
            if (i >= recvSize)
            {
                for (; shiftCount < 32; shiftCount += 8)
                {
                    int emptyBits = 0 << shiftCount;
                    recvData = recvData | emptyBits;
                }
            }
            
            // Commit data to data memory
            if(shiftCount >= 32)
            {
                *(int*)dataAddr = recvData;
                
                recvData = 0;
                dataAddr += 4;
                shiftCount = 0;
            }
        }
        
        KernelUARTTX("Received!\n");   
        
        // Call the user main function
        UserMainPtr();
      
        KernelUARTTX("Finished executing.\n");        
            
        // Reset pic mask so we can safely receive another software.
        KernelPICMask(0x0);
    }
 
    return 0;
}