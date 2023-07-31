#include <stdint.h>
#include "muAica.h"


volatile int count = 0x666;

extern volatile char* tempStr;
extern volatile int strCnt;

int main()
{	
	//////////////////////////////////////////////////////////////
	//  								  						//
	//  Configure the bidirectional port  						//
	//															//
	//	Config: 0xF000000F, last and first 4 bits are input		//
	//  Enable: 0xFFFFFFFF										//
	//	  INTR: 0xF0000000, last 4 bits are connected to PIC  	//
	//////////////////////////////////////////////////////////////
	
	int BDP_Cfg  = 0x0000000F;
	int BDP_En   = 0xFFFFFFFF;
	int BDP_Intr = 0xF0000000;
	
	BDPort_Setup(BDP_Cfg, BDP_En, BDP_Intr);
	
	
	/////////////////////////
	//  				   //
	//  Configure the PIC  //
	//			           //
	/////////////////////////
	
	PIC_Mask(0xF1); // Enable (1111 0001) as interrupts 
	
	// Register tx callback 
	//Ext_Intr_Register_Callback(0, callback_tx_proc);
	
	int a = 10;
	
	UART_Print("teste\n");

	do
	{
		int b = BDPort_Read();
		
		char b_c = b & 0xf;
		
		//count = a * count;
		
		BDPort_Write(b_c << 28);
		
		a += 0x12;
		
	} while(1);
		

		
	return a;
}