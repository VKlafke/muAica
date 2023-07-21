CC_RISCV        = riscv32-unknown-elf-gcc
LD_RISCV        = riscv32-unknown-elf-ld
DUMP_RISCV      = riscv32-unknown-elf-objdump
OBJCOPY_RISCV   = riscv32-unknown-elf-objcopy
READ_RISCV 		= riscv32-unknown-elf-readelf
SIZE_RISCV		= riscv32-unknown-elf-size

MAIN_SRC			= $(basename $(notdir $@))

BUILD_OUTPUT 	= obj/$(addsuffix .o, $(MAIN_SRC))
LINKER_OUTPUT 	= build/$(addsuffix .elf, $(MAIN_SRC))

LINK_OBJs		= $(MUKERNEL_S_OUTPUT) $(SYSCALL_OUTPUT) $(MUKERNEL_C_OUTPUT) $(BUILD_OUTPUT)

MUKERNEL_S_OUTPUT = obj/muKernel-s.o
MUKERNEL_S_INPUT = src/muKernel.S
MUKERNEL_S_CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none

SYSCALL_OUTPUT = obj/syscall.obj
SYSCALL_INPUT = src/syscall.S
SYSCALL_CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none

MUKERNEL_C_OUTPUT = obj/muKernel.o
MUKERNEL_C_INPUT = src/muKernel.c

DFLAGS = -D -Mnumeric,no-aliases
CFLAGS = -march=rv32im_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none
LFLAGS = -T link.ld

%:
	@echo
	@echo Assembling $(MUKERNEL_S_INPUT)
	$(CC_RISCV) -c $(MUKERNEL_S_INPUT) $(MUKERNEL_S_CFLAGS) -o $(MUKERNEL_S_OUTPUT)
	
	@echo
	@echo Assembling $(SYSCALL_INPUT)
	$(CC_RISCV) -c $(SYSCALL_INPUT) $(SYSCALL_CFLAGS) -o $(SYSCALL_OUTPUT)
	
	@echo
	@echo Compiling $(MUKERNEL_C_INPUT)
	$(CC_RISCV) -c $(MUKERNEL_C_INPUT) $(CFLAGS) -o $(MUKERNEL_C_OUTPUT)
	
	@echo
	@echo Compiling $(addsuffix .c, $(MAIN_SRC))
	$(CC_RISCV) -c $(addsuffix .c, $@) $(CFLAGS) -o $(BUILD_OUTPUT)
		
	@echo
	@echo Linking $(LINK_OBJs)
	$(LD_RISCV) $(LINK_OBJs)  $(LFLAGS)  -o $(LINKER_OUTPUT) -M > build/dump/$(addsuffix .map, $(MAIN_SRC))
	
	@echo
	@echo Reading ./build/$(addsuffix .elf, $(MAIN_SRC)) sections
	$(READ_RISCV) --section-headers ./build/$(addsuffix .elf, $(MAIN_SRC))
	$(SIZE_RISCV) ./build/$(addsuffix .elf, $(MAIN_SRC))
	
	@echo
	@echo Creating $(addsuffix .lst, $(MAIN_SRC))
	$(DUMP_RISCV) $(DFLAGS) ./build/$(addsuffix .elf, $(MAIN_SRC)) > ./build/dump/$(addsuffix .lst, $(MAIN_SRC))

	@echo    
	@echo Generating instruction memory image...
	$(OBJCOPY_RISCV) --dump-section .text=./build/code.bin ./build/$(addsuffix .elf, $(MAIN_SRC))
	../bin2hex ./build/code.bin > ./out/code.txt 4096
    
	@echo
	@echo Generating data memory image...
	$(OBJCOPY_RISCV) --dump-section .data=./build/data.bin ./build/$(addsuffix .elf, $(MAIN_SRC))
	../bin2hex ./build/data.bin > ./out/data.txt 4096

.PHONY: clean
clean:
	rm -f $(APP) *.o *.lst *.map *.bin *.txt
