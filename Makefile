CC      ?= gcc
CFLAGS  ?= -Wall -Wextra -O2 -std=c99 -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-function -Iinclude
LDFLAGS ?=

SRC_CORE := $(wildcard src/*.c)
SRC_BE   := $(wildcard src/backend/*/*.c) src/backend/registry.c
SRC_HOST := port/host/flash_fs_host.c port/host/platform_host.c
SRC      := $(SRC_CORE) $(SRC_BE) $(SRC_HOST)

ifeq ($(OS),Windows_NT)
ARKCC := arkcc.exe
RM    := del /Q
else
ARKCC := arkcc
RM    := rm -f
endif

.PHONY: all clean test test-arm test-c test-x86 test-riscv

all: $(ARKCC)

$(ARKCC): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(ARKCC) $(LDFLAGS)

test: test-arm test-c

test-arm: $(ARKCC)
	./$(ARKCC) examples/hello.c -target arm -S -o nul
	./$(ARKCC) examples/arith.c -target arm -S -o nul
	./$(ARKCC) examples/func.c  -target arm -S -o nul

test-c: $(ARKCC)
	./$(ARKCC) examples/hello.c -target c -o hello.gen.c
	./$(ARKCC) examples/arith.c -target c -o arith.gen.c
	./$(ARKCC) examples/func.c  -target c -o func.gen.c

test-x86: $(ARKCC)
	./$(ARKCC) examples/hello.c -target x86_64 -S -o nul
	./$(ARKCC) examples/arith.c -target x86_64 -S -o nul
	./$(ARKCC) examples/func.c  -target x86_64 -S -o nul

test-riscv: $(ARKCC)
	./$(ARKCC) examples/hello.c -target riscv32 -S -o nul
	./$(ARKCC) examples/arith.c -target riscv32 -S -o nul
	./$(ARKCC) examples/func.c  -target riscv32 -S -o nul

clean:
	-$(RM) $(ARKCC) arkcc arkcc.exe *.bin *.gen.c
