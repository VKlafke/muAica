#include "muKernel.h"

// constante endereços programa usuario

void (*UserMainPtr)(void) = (void(*)(void))0x2140;


int lastReceiveSize = 0;

/*
static void HexToAscii(int num, char* dest) 
{
    // Start from the end of the buffer, leaving space for the null terminator
    dest[8] = '\0';

    for (int i = 7; i >= 0; i--) {
        // Extract the lowest 4 bits (one hex digit)
        int hexDigit = num & 0xF;
        
        // Convert the hex digit to its ASCII representation
        if (hexDigit >= 0 && hexDigit <= 9) {
            // '0' to '9'
            dest[i] = '0' + hexDigit;
        } else {
            // 'A' to 'F'
            dest[i] = 'A' + (hexDigit - 10);
        }

        // Shift the number to get the next hex digit in the next iteration
        num >>= 4;
    }
}

void ByteToAsciiHex(unsigned char byte, char* dest) 
{
    // Convert the high 4 bits to ASCII hex
    int high = (byte >> 4) & 0xF;
    dest[0] = (high <= 9) ? ('0' + high) : ('A' + (high - 10));

    // Convert the low 4 bits to ASCII hex
    int low = byte & 0xF;
    dest[1] = (low <= 9) ? ('0' + low) : ('A' + (low - 10));

    // Null-terminate the string
    dest[2] = '\0';
}*/



int main()
{   
    // Allocate space for a string 
    char strRet[128];
    
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
            
            char rxData = KernelRXRead();
                
            // print recv  
            /*char strBuf[3];
            
            ByteToAsciiHex(rxData, strBuf);
            KernelSprintf(strRet, "%s - ", strBuf);
            KernelUARTTX(strRet);*/
            
            int temp = rxData << shiftCount;
            
            recvSize = recvSize | temp;
            
            shiftCount -= 8;
        }
        
        // printar tamanho    
       /* char strSizeBuf[32];
            
        HexToAscii(recvSize, strSizeBuf);
        KernelSprintf(strRet, "\nRECEIVED SIZE: %s\n", strSizeBuf);
        KernelUARTTX(strRet);      
        */
        lastReceiveSize = recvSize;
        
        int i = 0;
        int recvData = 0;
        int instAddr = 0x90002140;
        
        shiftCount = 0;
        
        // Get the software 
        while(i < recvSize)
        {
            // Wait for rx data
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead();
            
            int temp = rxData << shiftCount;
            
            recvData = recvData | temp;
            
            shiftCount += 8;
            i++;
              
/*              
            char strBuf[3];
                
            ByteToAsciiHex(rxData, strBuf);
            KernelUARTTX(strBuf);
            KernelUARTTX(" - ");     
            */
            // Commit data to instruction memory
            if(shiftCount >= 32)
            {
                *(int*)instAddr = recvData;
                              
                // Convert hex to ascii and send data back via UART
                // to debug
                /*char strDataBuf[32];
                char strAddrBuf[32];
            
                HexToAscii(recvData, strDataBuf);
                HexToAscii(instAddr, strAddrBuf);
                
                KernelSprintf(strRet, "\nInstr commit: %s (%s)\n", strDataBuf, strAddrBuf);
                
                KernelUARTTX(strRet);*/
                
                /*
                KernelUARTTX("\nInstr commit: ");
                KernelUARTTX(strDataBuf);
                KernelUARTTX(" (");
                KernelUARTTX(strAddrBuf);
                KernelUARTTX(")\n");*/
                       
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
            
            char rxData = KernelRXRead();
            
            int temp = rxData << shiftCount;
            
            recvSize = recvSize | temp;
            
            shiftCount -= 8;
        }
        
        // printar tamanho    
       /* HexToAscii(recvSize, strSizeBuf);
        KernelSprintf(strRet, "RECEIVED .data size: %s\n", strSizeBuf);
        KernelUARTTX(strRet);*/
            
        // Receive .data section 
        
        i = 0;
        recvData = 0;
        int dataAddr = 0x00000400;
        
        shiftCount = 0;
        
        while(i < recvSize)
        {
            // Wait for rx data
            while(UART_RX_DV == 0);
            
            char rxData = KernelRXRead();
            
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
        /*
        // Clean up last received software from instruction memory 
        instAddr = 0x90001800;
        for(int i = 0; i < lastReceiveSize; i++)
        {
            *(int*)instAddr = 0;
            
            instAddr += 4;
        }
        
        lastReceiveSize = 0;
    
        KernelUARTTX("Finished clean up, Ready to receive!\n"); */
    }
 
    return 0;
}
