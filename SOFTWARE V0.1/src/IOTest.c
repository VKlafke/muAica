
#define _IO_RW_WORD_(__io_addr__)	(*(volatile int *)(__io_addr__))

#define BDPORT_EN 	0x80000000
#define BDPORT_CFG 	0x80000010
#define BDPORT_DATA 0x80000020
#define BDPORT_INTR 0x80000030

#define PASS __asm__("li	x31,'O'\n\tli	x30,'K'\n\tli	x29,'\n'\n\tloop_pass:\n\tbne	x31, x0, loop_pass\n\t");	
	
#define FAIL __asm__("li		x31,'E'\n\tli		x30,'R'\n\tli		x29,'R'\n\tli		x28,'O'\n\tli		x27,':'\n\tli		x26,' '\n\tli		x25,'\n'\n\tloop_fail:\n\tbne	x31, x0, loop_fail\n\t");

// Set stack pointer
__asm__("addi	x2, x2, 64\n\t");

	
int main()
{	
	// port config, last four bytes are input
	*(int*)BDPORT_CFG = 0x0F;
	
	// port enable
	*(int*)BDPORT_EN = 0xFFFFFFFF;

	// read port 
	//int a = _IO_RW_WORD_(0x80000020);
	
	// zero out port
	*(int*)BDPORT_DATA = 0;
	
	*(int*)BDPORT_EN = 0xf000000F;
	
	int i = 0;
	
	char* bdp_data = (char*)BDPORT_DATA;
	char b = bdp_data[0];
	
	int a = 11;

	
	do
	{
		b = bdp_data[0];
		//i++;
		
		*(int*)BDPORT_DATA = b << 28;
		
	} while((b & 0x0f) != 15);
	
	PASS
	
	return a;
}