#ifndef _SYSCALL_H_
#define _SYSCALL_H_

// ECALL codes

#define ECALL_EXT_INTR_REG       1
#define ECALL_EXT_INTR_RST       2

#define ECALL_TIMER_SET_CLK      3
#define ECALL_TIMER_SET_COUNT    4
#define ECALL_TIMER_ENABLE       5

#define ECALL_WATCHDOG_SET_CLK   6
#define ECALL_WATCHDOG_SET_COUNT 7
#define ECALL_WATCHDOG_ENABLE    8
#define ECALL_WATCHDOG_KICK      9  

#define ECALL_BDP_CFG            10
#define ECALL_BDP_READ           11
#define ECALL_BDP_WRITE          12

#define ECALL_PIC_MASK           13

#define ECALL_UART_TX            14
#define ECALL_UART_RX            15
#define ECALL_GETSTRING          16

#endif