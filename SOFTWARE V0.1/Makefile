CC_RISCV        = riscv32-unknown-elf-gcc
LD_RISCV        = riscv32-unknown-elf-ld
DUMP_RISCV      = riscv32-unknown-elf-objdump
OBJCOPY_RISCV      = riscv32-unknown-elf-objcopy

CC_FILE			= $(basename $(notdir $@))

BUILD_OUTPUT 	= obj/$(addsuffix .o, $(CC_FILE))
LINKER_OUTPUT 	= build/$(addsuffix .elf, $(CC_FILE))

BOOTLOADER_OUTPUT = obj/bootloader.o
BOOTLOADER_INPUT = src/bootloader.S
BOOTLOADER_CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none

DFLAGS = -D -Mnumeric,no-aliases
CFLAGS = -march=rv32i_zicsr_zifencei -mabi=ilp32 -mstrict-align -mpreferred-stack-boundary=3 -nostartfiles -Wall -Wl,--build-i=none
LFLAGS = -T link.ld

%:
	$(CC_RISCV) -c $(BOOTLOADER_INPUT) $(BOOTLOADER_CFLAGS) -o $(BOOTLOADER_OUTPUT)
	$(CC_RISCV) -c $(addsuffix .c, $@) $(CFLAGS) -o $(BUILD_OUTPUT)
	$(LD_RISCV) $(BOOTLOADER_OUTPUT) $(BUILD_OUTPUT) $(LFLAGS)  -o $(LINKER_OUTPUT) -M > build/dump/$(addsuffix .map, $(CC_FILE))
	$(DUMP_RISCV) $(DFLAGS) $(LINKER_OUTPUT) > build/dump/$(addsuffix .lst, $(CC_FILE))
	
	# Dump sections that make up the final code.txt	
	$(OBJCOPY_RISCV) --dump-section .bootloader=out/.bootloader.bin $(LINKER_OUTPUT)
	$(OBJCOPY_RISCV) --dump-section .m_intr_vector=out/.m_intr_vector.bin $(LINKER_OUTPUT)
	$(OBJCOPY_RISCV) --dump-section .m_trap_handler=out/.m_trap_handler.bin $(LINKER_OUTPUT)
	$(OBJCOPY_RISCV) --dump-section .text=out/.text.bin $(LINKER_OUTPUT)

	# Create the padding file for bootloader
	section_size=$(shell riscv32-unknown-elf-readelf -S build/INTR_Test.elf | grep .bootloader | awk '{print $$7}'); \
	section2_start=$(shell riscv32-unknown-elf-readelf -S build/INTR_Test.elf | grep .m_intr_vector | awk '{print $$5}'); \
	padding_hex=$$(printf "%d" $$((0x$$section2_start - 0x$$section_size ))); \
	padding_hex=$$((padding_hex));\
	echo "padding_hex: $${padding_hex}"; \
	dd if=/dev/zero of=out/.bootloader_padding.bin bs=1 count=$$padding_hex;
	
	# Concatenate files with padding
	cat out/.bootloader.bin out/.bootloader_padding.bin out/.m_intr_vector.bin out/.m_trap_handler.bin out/.text.bin > out/code.bin

	../bin2hex out/code.bin > out/code.txt 4096
	
	$(OBJCOPY_RISCV) --dump-section .data=out/data.bin $(LINKER_OUTPUT)
	../bin2hex out/data.bin > out/data.txt 4096
		
	riscv32-unknown-elf-objcopy -O ihex $(LINKER_OUTPUT) out.hex

.PHONY: clean
clean:
	rm -f $(APP) *.o *.lst *.map *.bin *.txt
