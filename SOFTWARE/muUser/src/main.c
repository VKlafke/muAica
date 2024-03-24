#include "muAica.h"
#include <stdarg.h>
#include <stdio.h>

volatile int global_Vector[12] = {0, 0, 0};
volatile int testGlobal = 123;



int main()
{	
    int stack_Vector[12] = {0};
    
    for(int i = 0; i < 12; i++)
    {
        global_Vector[i] = i + 1;
        stack_Vector[i] = i;
        
        UART_Print("Test vectors\n");
    }
		
	return 0;
}