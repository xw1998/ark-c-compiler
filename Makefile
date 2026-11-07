CC      ?= gcc
# Python is only used by the gate scripts under tests/.  Override with
# `make PYTHON=/path/to/python test` if the interpreter is not on PATH.
PYTHON  ?= python
CFLAGS  ?= -Wall -Wextra -O2 -std=c99 -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-function -Iinclude
LDFLAGS ?=

SRC_CORE := $(wildcard src/*.c)
SRC_BE   := $(wildcard src/backend/*/*.c) src/backend/registry.c
SRC_HOST := port/host/flash_fs_host.c port/host/platform_host.c port/host/debug_host.c
SRC      := $(SRC_CORE) $(SRC_BE) $(SRC_HOST)

ifeq ($(OS),Windows_NT)
ARKCC := arkcc.exe
RM    := del /Q
else
ARKCC := arkcc
RM    := rm -f
endif

.PHONY: all clean test test-arm test-c test-x86 test-riscv test-reloc-text stm32

all: $(ARKCC)

$(ARKCC): $(SRC) $(wildcard include/*.h)
# Headers are prerequisites too: a header-only change (a size macro, a
# profile default) used to leave the old binary in place, and 'make' said
# "Nothing to be done" while the source tree said otherwise.
	$(CC) $(CFLAGS) $(SRC) -o $(ARKCC) $(LDFLAGS)

test: test-arm test-c test-reloc-text

test-arm: $(ARKCC)
	./$(ARKCC) examples/hello.c -target arm -S -o nul
	./$(ARKCC) examples/arith.c -target arm -S -o nul
	./$(ARKCC) examples/func.c  -target arm -S -o nul

test-c: $(ARKCC)
	./$(ARKCC) examples/hello.c -target c -o hello.gen.c
	./$(ARKCC) examples/arith.c -target c -o arith.gen.c
	./$(ARKCC) examples/func.c  -target c -o func.gen.c

# Gate for --reloc-text: two objects, linked 0x1C070000 away from the base they
# were compiled against, must end up with their string literals pointing at
# themselves -- and with the flag off, at the old (wrong) address.  The second
# object is the point: a global delta passes object #0 and fails object #1.
test-reloc-text: $(ARKCC)
	$(PYTHON) tests/run_reloc_text_tests.py ./$(ARKCC)

test-x86: $(ARKCC)
	./$(ARKCC) examples/hello.c -target x86 -S -o nul
	./$(ARKCC) examples/arith.c -target x86 -S -o nul
	./$(ARKCC) examples/func.c  -target x86 -S -o nul

test-riscv: $(ARKCC)
	./$(ARKCC) examples/hello.c -target riscv32 -S -o nul
	./$(ARKCC) examples/arith.c -target riscv32 -S -o nul
	./$(ARKCC) examples/func.c  -target riscv32 -S -o nul

# ===== STM32 cross-compilation =====
# Fails if arm-none-eabi-gcc is missing, but Makefile syntax stays valid.
ARM_GCC ?= arm-none-eabi-gcc

STM32_CFLAGS = -mcpu=cortex-m7 -mthumb -mfpu=fpv5-d16 -mfloat-abi=hard \
    -DARKCC_STM32 -DARKCC_PROFILE=ARKCC_PROFILE_STM32_MIN \
    -DARK_POOL_SIZE=262144 \
    -DARK_SRC_BUF_SIZE=32768 -DARK_ASM_BUF_SIZE=131072 -DARK_CODE_BUF_SIZE=65536 \
    -DARK_OBJ_BUF_SIZE=4096 -DARK_LINK_BUF_SIZE=4096 \
    -DARKCC_BACKEND_X86_64=0 -DARKCC_BACKEND_RISCV32=0 -DARKCC_BACKEND_C=0 \
    -Iinclude -Iport/stm32 \
    -Wall -Wextra -O2 -std=c99 -ffreestanding -nostdlib \
    -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-function

# STM32 builds only the ARM backend + frontend core (excludes main.c; keeps config.c, now using fs_read_file).
# Excludes the C backend (not needed on STM32); x86_64/riscv32 backend files are not compiled,
# and -DARKCC_BACKEND_*=0 keeps registry.c from referencing their symbols.
STM32_SRC := $(wildcard src/*.c)
STM32_SRC := $(filter-out src/main.c, $(STM32_SRC))
STM32_SRC += src/backend/arm/backend_arm.c src/backend/registry.c
STM32_SRC += port/stm32/flash_fs_stm32.c port/stm32/platform_stm32.c port/stm32/main_stm32.c

arkcc_stm32.elf: $(STM32_SRC)
	$(ARM_GCC) $(STM32_CFLAGS) -o $@ $^ -lgcc

stm32: arkcc_stm32.elf

clean:
	-$(RM) $(ARKCC) arkcc arkcc.exe *.bin *.gen.c
	-$(RM) arkcc_stm32.elf
