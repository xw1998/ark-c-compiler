/* Ark C Compiler - HOST-only debug stubs.
 * This file is compiled by `make` for the HOST arkcc build.
 * It is NOT compiled by regen_bootstrap.bat (not in the bootstrap .x86.s list).
 * The bootstrap provides its own WriteFile-based versions in bootstrap_x86_runtime.c. */
#include <stdio.h>

void ark_dbg_char(int c) { fputc(c, stderr); fflush(stderr); }
void ark_dbg_str(const char *s) { fputs(s, stderr); fflush(stderr); }
void ark_dbg_int(int v) { fprintf(stderr, "%d", v); fflush(stderr); }
