ISA = rv32i
PREFIX = /opt/riscv/bin/riscv32-unknown-elf-
PYTHON = python3.12

LD = $(PREFIX)ld
CC = $(PREFIX)gcc
AS = $(PREFIX)as

OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump

TARGET = test
BUILDDIR = build

CFLAGS = -O1 -Wall -march=$(ISA) -mabi=ilp32 -Wa,-adghlmns=$(@:.o=.s) -std=c99 -mpreferred-stack-boundary=4 -nostartfiles -ffreestanding
LDFLAGS = -Wl,-Bstatic,-A,$(ISA),--gc-sections,-lgcc,-static,--print-memory-usage

all: $(BUILDDIR)/$(TARGET).mem $(BUILDDIR)/$(TARGET).dasm 
	@echo "Generated files:"
	@ls build

$(BUILDDIR):
	@wsl mkdir -p $(BUILDDIR)

$(BUILDDIR)/$(TARGET).elf: $(BUILDDIR)
#	$(CC) $(CFLAGS) -o $(BUILDDIR)/test.elf -T linker.ld test.c
	$(AS) -o $(BUILDDIR)/test.elf test.s

$(BUILDDIR)/$(TARGET).dasm: $(BUILDDIR) $(BUILDDIR)/$(TARGET).elf
	$(OBJDUMP) --disassemble-all -Mno-aliases $(BUILDDIR)/$(TARGET).elf > $(BUILDDIR)/$(TARGET).dasm

$(BUILDDIR)/$(TARGET).out: $(BUILDDIR) $(BUILDDIR)/$(TARGET).elf
	$(OBJCOPY) -O verilog $(BUILDDIR)/$(TARGET).elf $(BUILDDIR)/test.out

$(BUILDDIR)/$(TARGET).mem: $(BUILDDIR) $(BUILDDIR)/$(TARGET).out
	$(PYTHON) ../../scripts/format_mem.py < $(BUILDDIR)/$(TARGET).out > $(BUILDDIR)/$(TARGET).mem

clean:
	wsl rm -rf build

.PHONY: all