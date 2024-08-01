#include "syscall.h"
	
#ECALL stubs


.global ExtIntrRegisterCallback
ExtIntrRegisterCallback:
	li a7, ECALL_EXT_INTR_REG
	ecall
	ret
    
.global ExtIntrResetCallback
ExtIntrResetCallback:
	li a7, ECALL_EXT_INTR_RST
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
    
.global WatchdogSetBaseClock
WatchdogSetBaseClock:
	li a7, ECALL_WATCHDOG_SET_CLK
	ecall
	ret
    
.global WatchdogSetCount
WatchdogSetCount:
	li a7, ECALL_WATCHDOG_SET_COUNT
	ecall
	ret
    
.global WatchdogSetEnabled
WatchdogSetEnabled:
	li a7, ECALL_WATCHDOG_ENABLE
	ecall
	ret
    
.global WatchdogKick
WatchdogKick:
	li a7, ECALL_WATCHDOG_KICK
	ecall
	ret
    
.global BDPortSetup
BDPortSetup:
	li a7, ECALL_BDP_CFG
	ecall
	ret
							
.global BDPortRead
BDPortRead:
	li a7, ECALL_BDP_READ
	ecall
	ret
							
.global BDPortWrite
BDPortWrite:
	li a7, ECALL_BDP_WRITE
	ecall
	ret
				
.global PICMask
PICMask:
	li a7, ECALL_PIC_MASK
	ecall
	ret			
				
.global UARTPrint
UARTPrint:
	li a7, ECALL_UART_TX
	ecall
	ret
    
.global UARTRead
UARTRead:
    li a7, ECALL_UART_RX
    ecall
    ret
      
.global GetString
GetString:
    li a7, ECALL_GETSTRING
    ecall
    ret  
    