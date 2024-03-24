#include "syscall.h"
	
#ECALL stubs


.global Ext_Intr_Register_Callback
Ext_Intr_Register_Callback:
	li a7, ECALL_EXT_INTR_REG
	ecall
	ret

.global TimerSetBaseClock
TimerSetBaseClock:
	li a7, ECALL_TIMER_SET_CLK
	ecall
	ret
    
.global TimerSetCount
TimerSetCount:
	li a7, ECALL_TIMER_SET_COUNT
	ecall
	ret
    
.global TimerSetEnabled
TimerSetEnabled:
	li a7, ECALL_TIMER_ENABLE
	ecall
	ret
    
.global BDPort_Setup
BDPort_Setup:
	li a7, ECALL_BDP_CFG
	ecall
	ret
				
				
.global BDPort_Read
BDPort_Read:
	li a7, ECALL_BDP_READ
	ecall
	ret
				
				
.global BDPort_Write
BDPort_Write:
	li a7, ECALL_BDP_WRITE
	ecall
	ret
				
.global PIC_Mask
PIC_Mask:
	li a7, ECALL_PIC_MASK
	ecall
	ret
				
				
.global UART_Print
UART_Print:
	li a7, ECALL_UART_TX
	ecall
	ret