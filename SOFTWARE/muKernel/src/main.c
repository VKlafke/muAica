#include <stdint.h>
#include "muAica.h"


volatile int count = 0x666;

extern volatile char* tempStr;
extern volatile int strCnt;

void callback_test()
{
	 int i = 0;
	 // "Debounce"
	 while(i < 200000)
		 i++;
	 
	UART_Print("Ecall dentro de intr\n");
	
	// DEBUG STRING, SIMULATION ONLY
	__asm__ volatile 
	("li	x24,'I'\n\t" \
	 "li	x25,'N'\n\t" \
	 "li 	x26,'T'\n\t" \
	 "li	x27, 'R'\n\t" \
	 "li 	x28,'_'\n\t" \
	 "li 	x29,'_'\n\t" \
	 "li 	x30,'_'\n\t" \
	 "li 	x31,'7'\n\t");
	 
	 
	int b = BDPort_Read();
		
	char b_c = b & 0xf;
	char testVal[2]; 
	
	testVal[0] = b_c + 0x30;
	testVal[1] = '\0';
	
	UART_Print("Valor lido: ");
	UART_Print(testVal);
	UART_Print("\n");
		
	//count = a * count;
		
	BDPort_Write(b_c << 27);
		
}

int main()
{	
	UART_Print("INICIOU\n");

	//////////////////////////////////////////////////////////////
	//  								  						//
	//  Configure the bidirectional port  						//
	//															//
	//	Config: 0x8000000F, last and first 4 bits are input		//
	//  Enable: 0xFFFFFFFF										//
	//	  INTR: 0xF0000000, last 4 bits are connected to PIC  	//
	//////////////////////////////////////////////////////////////
	
	int BDP_Cfg  = 0x8000000F;
	int BDP_En   = 0xFFFFFFFF;
	int BDP_Intr = 0x80000000;
	
	BDPort_Setup(BDP_Cfg, BDP_En, BDP_Intr);
	
	
	/////////////////////////
	//  				   //
	//  Configure the PIC  //
	//			           //
	/////////////////////////
	
	
	PIC_Mask(0xF2); // Enable (1111 0011) as interrupts 
	
	// Register tx callback 
	int ret = Ext_Intr_Register_Callback(7, callback_test);
	
	if(ret == N_OUT_OF_BOUNDS)
		UART_Print("Ext_Intr_Register_Callback Fail: N_OUT_OF_BOUNDS\n");
	else if(ret == INVALID_CALLBACK)
		UART_Print("Ext_Intr_Register_Callback Fail: INVALID_CALLBACK\n");
	else
		UART_Print("Callback registered!\n");
	
	int a = 10;

	
	do
	{
		a++;
		
	} while(1);
		

		
	return a;
}