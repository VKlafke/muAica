#include "syscall.h"
	
#ECALL stubs

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