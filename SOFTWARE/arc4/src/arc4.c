/*********************************************************************
* Filename:   arcfour.c
* Author:     Brad Conte (brad AT bradconte.com)
* Copyright:
* Disclaimer: This code is presented "as is" without any guarantees.
* Details:    Implementation of the ARCFOUR encryption algorithm.
              Algorithm specification can be found here:
               * http://en.wikipedia.org/wiki/RC4
*********************************************************************/
#include <stdio.h>
#include <inttypes.h>
#include "muLib.h"

char strBuf[256];

/*********************** FUNCTION DEFINITIONS ***********************/
void arcfour_key_setup(uint8_t state[], uint8_t key[], int len)
{
    int i, j;
    uint8_t t;
    
    muSprintf(strBuf, "ARC4_Key_Setup: %d\n", len);
    UARTPrint(strBuf);

    for (i = 0; i < 256; ++i)
        state[i] = i;
    for (i = 0, j = 0; i < 256; ++i) {
        j = (j + state[i] + key[i % len]) % 256;
        t = state[i];
        state[i] = state[j];
        state[j] = t;
    }
    
    
    UARTPrint("ARC4 key setup end\n");
}

// This does not hold state between calls. It always generates the
// stream starting from the first  output byte.
void arcfour_generate_stream(uint8_t state[], uint8_t out[], size_t len)
{
    int i, j;
    size_t idx;
    uint8_t t;

    for (idx = 0, i = 0, j = 0; idx < len; ++idx)  {
        i = (i + 1) % 256;
        j = (j + state[i]) % 256;
        t = state[i];
        state[i] = state[j];
        state[j] = t;
        out[idx] = state[(state[i] + state[j]) % 256];
    }
}

int main() 
{

    uint8_t state[256];
    uint8_t buf[1024];
    //uint8_t key[] = "key";
    //uint8_t plaintext[] = "teste";
    uint8_t key[128];
    uint8_t plaintext[128];
    uint8_t encrypted[256];    
    
    // Enable UART-RX interruptions with default callback
    PICMask(0x1);
   
    UARTPrint("[ARC4] Enter text for encryption: ");
    
    while(1)
    {
        uint8_t* strRead;
        
        if(GetString(&strRead))
        {
            // Must copy string to its own buffer
            muStrcpy(&plaintext, strRead);
            
            UARTPrint(plaintext);
            break;
        }
    }
    
    
    UARTPrint("\n[ARC4] Enter encryption key: ");
    
    while(1)
    {
        uint8_t* strRead;
        
        if(GetString(&strRead))
        {
            // Must copy string to its own buffer
            muStrcpy(&key, strRead);
            UARTPrint(key);
            break;
        }
    }

    arcfour_key_setup(state, key, muStrlen(key));
    arcfour_generate_stream(state, buf, muStrlen(plaintext));
    
    
    UARTPrint("ARC4 Started\n");
    muSprintf(strBuf, "Plaintext: %s\n", plaintext);
    UARTPrint(strBuf);
    
    UARTPrint("Encryption...\n");
    for (int i = 0; i < muStrlen(plaintext); i++) 
    {
        encrypted[i] = plaintext[i] ^ buf[i];
        muSprintf(strBuf, "%02X ", encrypted[i]);
        UARTPrint(strBuf);
    }
    UARTPrint("\n");
    
    
    UARTPrint("Decryption...\n");
    for (int i = 0; i < muStrlen(plaintext); i++) 
    {
        muSprintf(strBuf, "%c", encrypted[i] ^ buf[i]);
        UARTPrint(strBuf);
    }
    UARTPrint("\n");
    
    return 0;
}
