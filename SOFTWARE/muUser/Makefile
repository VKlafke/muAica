CC_RISCV        = riscv32-unknown-elf-gcc
LD_RISCV        = riscv32-unknown-elf-ld
DUMP_RISCV      = riscv32-unknown-elf-objdump
OBJCOPY_RISCV   = riscv32-unknown-elf-objcopy
READ_RISCV 		= riscv32-unknown-elf-readelf
SIZE_RISCV		= riscv32-unknown-elf-size

# Output binary file name
SERIAL_BIN := ./out/serial.bin

# Intermediate files
TEXT_BIN := ./build/code.bin
DATA_BIN := ./build/data.bin

MAIN_SRC			= $(basename $(notdir $@))

BUILD_OUTPUT 	= obj/$(addsuffix .o, $(MAIN_SRC))
LINKER_OUTPUT 	= build/$(addsuffix .elf, $(MAIN_SRC))

LINK_OBJs		=  $(BOOTLOADER_S_OUTPUT) $(SYSCALL_OUTPUT) $(MULIB_OUTPUT) $(BUILD_OUTPUT)

BOOTLOADER_S_OUTPUT = obj/bootloader.o
BOOTLOADER_S_INPUT = src/bootloader.S
BOOTLOADER_S_CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none

SYSCALL_OUTPUT = obj/syscall.obj
SYSCALL_INPUT = src/syscall.S
SYSCALL_CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none

MULIB_OUTPUT = obj/mulib.obj
MULIB_INPUT = src/muLib.c
MULIB_CFLAGS = -march=rv32im_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none -fno-zero-initialized-in-bss

DFLAGS = -D -Mnumeric,no-aliases
CFLAGS = -march=rv32im_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none -fno-zero-initialized-in-bss
LFLAGS = -T link.ld

%:
	@echo
	@echo Assembling $(BOOTLOADER_S_INPUT)
	$(CC_RISCV) -c $(BOOTLOADER_S_INPUT) $(BOOTLOADER_S_CFLAGS) -o $(BOOTLOADER_S_OUTPUT)
	
	@echo
	@echo Assembling $(SYSCALL_INPUT)
	$(CC_RISCV) -c $(SYSCALL_INPUT) $(SYSCALL_CFLAGS) -o $(SYSCALL_OUTPUT)

	@echo
	@echo Compiling $(MULIB_INPUT)
	$(CC_RISCV) -c $(MULIB_INPUT) $(MULIB_CFLAGS) -o $(MULIB_OUTPUT)
    	
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
	@echo Cleaning binary build files 
	@rm -v -f ./build/*.bin

	@echo    
	@echo Generating instruction memory image...
	$(OBJCOPY_RISCV) --dump-section .text=$(TEXT_BIN) ./build/$(addsuffix .elf, $(MAIN_SRC))
	../bin2hex $(TEXT_BIN) > ./out/code.txt 4999
    
	@echo
	@echo Generating data memory image...
	$(OBJCOPY_RISCV) --dump-section .data=$(DATA_BIN) ./build/$(addsuffix .elf, $(MAIN_SRC))
   
	@echo
	@echo Checking if .data section exists...
	@if [ ! -f $(DATA_BIN) ]; then \
		echo "No .data section found. Creating a zero-byte file.";\
		touch $(DATA_BIN); \
	else \
	../bin2hex $(DATA_BIN) > ./out/data.txt 4096; \
    fi
	
	@echo
	@echo Creating serial file...
	../genSerialBin $(TEXT_BIN) $(DATA_BIN) $(SERIAL_BIN)
   
.PHONY: clean
clean:
	rm -f $(APP) *.o *.lst *.map *.bin *.txt
