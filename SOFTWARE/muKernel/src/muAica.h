#ifndef _MUAICA_H_
#define _MUAICA_H_


// ECALL - BDPort 
void BDPort_Setup(int config, int enable, int intr);
void BDPort_Write(int val);
int  BDPort_Read();

// ECALL - PIC_Mask
void PIC_Mask(char val);

// ECALL
/*void BDPort_Setup(int config, int enable, int intr)
{
    __asm__ volatile 
    (
        "mv a0, %0 \n\t" \
        "mv a1, %1 \n\t" \
        "mv a2, %2 \n\t" \
        "addi a7, x0, 10 \n\t" \
        "ecall \n\t"
        :
        : "r" (config), "r" (enable), "r" (intr)
        : "a0", "a1", "a2", "a7"
    );
}

int BDPort_Read()
{
	int retVal = 0;
	
	__asm__ volatile 
	("addi a7, x0, 11 \n\t" \
	 "ecall \n\t" \
	 "mv %0, a0"
	 : "=r" (retVal)
	 );

	return retVal;	 
}

void BDPort_Write(int val)
{
    __asm__ volatile 
    (
        "mv a0, %0 \n\t" \
        "addi a7, x0, 12 \n\t" \
        "ecall \n\t"
        :
        : "r" (val)
        : "a0", "a7"
    );
}

void PIC_Mask(char val)
{
    __asm__ volatile 
    (
        "mv a0, %0 \n\t" \
        "addi a7, x0, 13 \n\t" \
        "ecall \n\t"
        :
        : "r" (val)
        : "a0", "a7"
    );
}*/

#endif