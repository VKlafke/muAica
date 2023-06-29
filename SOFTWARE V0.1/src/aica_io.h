

/*----------------------------------------
----------------------------------------
	Shared header between C and ASM projects.

1) Memory sections information;

2) I/O Section: start at address 0xFFFF0000

	2.1) IO Access: read/write

	2.2) UART Region: UART I/O device
		UART_CTRL = control/status register (read-only);
		UART_DATA = data RxT (read-write).
		UART_BAUD = baudrate (read-write);

	2.3) Timer 0:
		TIMER0_DATA = data register (read-write).

----------------------------------------
----------------------------------------*/

#ifndef _AICA_IO_H_
#define _AICA_IO_H_


/*----------------------------------
------------------------------------
------------------------------------
1) Memory sections information
*/
#define _ICACHE_SIZE_	0x00004000
#define _DCACHE_SIZE_	0x00004000
#define _TVEC_SEC_		0x00000200			/*	Trap Vector Table memory section start address */
#define _TMAIN_SEC_		_TVEC_SEC_ + 64		/*	Main Trap Handler start address, after the vector table */
#define _SDATA_SEC_		0x00110000			/*	SData memory section start address */
#define	_SP_START_		0x00000040			/*	Stack Pointer start address	*/
#define set_sp(_addr_)				\
	__asm__				 			\
	(								\
		"li	sp, %0 "				\
		: : "rK" (_addr_)			\
	);

/*----------------------------------
------------------------------------
------------------------------------
2) I/O Section
*/
#define	_IO_SEC_		0xFFFF0000			/*	Mapped I/O section, start address	*/

/*	2.1) UART definitions	*/
#define	UART_CTRL		_IO_SEC_+0			/*	UART control/status register (read-only)	*/
#define	UART_DATA		_IO_SEC_+1			/*	UART data register (read-write)				*/
#define	UART_BAUD		_IO_SEC_+2			/*	UART baudrate register (read-write)			*/

/*	2.2) TIMER 0 definitions	*/
#define	TIMER0_DATA		_IO_SEC_+4			/* 	Timer 0 data register (read-write)	*/

/*	2.3) Read/Write access to any I/O device
obs.: it doesn't check for any device status byt itself
*/
#define _IO_RW_BYTE_(__io_addr__)	(*(volatile char *)(__io_addr__))
#define _IO_RW_HALF_(__io_addr__)	(*(volatile short *)(__io_addr__))
#define _IO_RW_WORD_(__io_addr__)	(*(volatile int *)(__io_addr__))

#define timer0_read(__int_data__)	__int_data__=_IO_RW_WORD_(TIMER0_DATA)
#define timer0_write(__int_data__)	_IO_RW_WORD_(TIMER0_DATA)=__int_data__

#endif
