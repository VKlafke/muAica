#include <stdint.h>
#include "muAica.h"


volatile int count = 0x666;

int main()
{	
	////////////////////////////////////////
	//  								  //
	//  Configure the bidirectional port  //
	//	
	//	Config: 0xF000000F, last and first 4 bits are input
	//  Enable: 0xF0000F0F
	//	  INTR: 0xF0000000, last 4 bits are connected to PIC  
	////////////////////////////////////////
	
	int BDP_Cfg  = 0xF000000F;
	int BDP_En   = 0xFFFFFFFF;
	int BDP_Intr = 0xF0000000;
	
	BDPort_Setup(BDP_Cfg, BDP_En, BDP_Intr);
	
	
	/////////////////////////
	//  				   //
	//  Configure the PIC  //
	//			           //
	/////////////////////////
	
	PIC_Mask(0xF0); // Enable the last bits as interrupts (1111 0000)
	
	int a = 10;

	do
	{
		int b = BDPort_Read();
		
		char b_c = b & 0xf;
		
		//count = a * count;
		
		BDPort_Write(b_c << 8);
		
		a += 0x12;
		
	} while(1);
		

		
	return a;
}