/*********************************************************************
    Implementation of the ARC4 encryption algorithm.
    Algorithm specification can be found here:
        http://en.wikipedia.org/wiki/RC4
*********************************************************************/

#include <inttypes.h>

#include "muLib.h"

#define STATE_SIZE    8

/*
* Key-scheduling algorithm (KSA)
*       Initialize the permutation in the array "state" 
*/
void KeySetup(uint8_t key[], int keySize, uint8_t state[]) {
    
    int i, j;
    uint8_t t;

    for (i = 0; i < STATE_SIZE; i++)
        state[i] = i;
    
    for (i = 0, j = 0; i < STATE_SIZE; i++) {
        j = (j + state[i] + key[i % keySize]) % STATE_SIZE;
        t = state[i];
        state[i] = state[j];
        state[j] = t;
    }
}


/*
* Pseudo-random generation algorithm (PRGA) 
*       For as many iterations as are needed, the PRGA modifies the state and 
*       outputs a byte of the keystream. 
*/
void GenerateKeyStream(uint8_t state[], uint8_t stateSize, uint8_t textSize, uint8_t keyStream[]) {
    
    uint8_t i, j, k, t;

    for (i = 0, j = 0, k = 0; k < textSize; k++)  {
        i = (i + 1) % stateSize;
        j = (j + state[i]) % stateSize;
        
        // swap(state[i], state[j])
        t = state[i];
        state[i] = state[j];
        state[j] = t;
        
        t = (state[i] + state[j]) % stateSize;
        keyStream[k] = state[t];
    }
}

int main() 
{

    uint8_t state[STATE_SIZE];
    uint8_t keyStream[STATE_SIZE];
    uint8_t ciphertext[STATE_SIZE];
    uint8_t key[] = "key";
    uint8_t plaintext[] = "teste";
    
    char buf[128];
    
    muSprintf(buf, "Secret key: %s\n", key);
    
    UARTPrint(buf);
    
    KeySetup(key, muStrlen(key), state);
    
    UARTPrint("state[]: ");
    for (int i = 0; i < STATE_SIZE; i++) 
    {
        muSprintf(buf, "%d ", state[i]);
        UARTPrint(buf);
    }
    UARTPrint("\n");
     
    GenerateKeyStream(state, STATE_SIZE, muStrlen(plaintext), keyStream);
    
    UARTPrint("keyStream[]: ");
    for (int i = 0; i < muStrlen(plaintext); i++) 
    {
        muSprintf(buf, "%02X ", keyStream[i]);
        UARTPrint(buf);
    }
    
    UARTPrint("\n");
    
    muSprintf(buf, "Plaintext: %s\n", plaintext);
    UARTPrint(buf);
    
    UARTPrint("Ciphertext: ");
    for (int i = 0; i < muStrlen(plaintext); i++) 
    {
        ciphertext[i] = plaintext[i] ^ keyStream[i];
        muSprintf(buf, "%02X ", ciphertext[i]);
        UARTPrint(buf);
    }
    
    UARTPrint("\n");
    
    UARTPrint("Decryption...\n");
    for (int i = 0; i < muStrlen(plaintext); i++) 
    {
        muSprintf(buf, "%c", ciphertext[i] ^ keyStream[i]);
        UARTPrint(buf);
    }
    UARTPrint("\n");
    

    return 0;
}
