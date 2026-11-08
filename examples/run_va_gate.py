#!/usr/bin/env python3
"""ARM Thumb-2 / RV32I varargs gate: compile, assemble, RUN, compare.

Every other gate in this repo stops at the emitted text.  This one executes the
varargs code on both non-C backends and compares the result against gcc, because
that is the only way to tell "the va region is written" from "the va region is
written correctly" -- the failure this replaces was `va_start` compiling into
`LDR r0,[r0]` (address 0, the vector table) and answering with the initial SP.

How a case runs:
  arkcc -target <arm|riscv32> -S  ->  GNU as  ->  ld (flat image at 0x08000000)
  ->  unicorn  ->  the value main() returned is the exit code
The same source is compiled by the host gcc and run natively; its exit code is
the expected value, so the case list stays type-directed (no magic numbers).

Covered (ARM): all-register and register+stack arguments; a 64-bit argument in
a register pair and on the stack; a named long long / four named ints that force
the tail onto the stack; an odd named count so the first 64-bit value has to
skip an alignment word; double arguments and float arguments promoted to double.
Covered (RV32I): the 32-bit cases, plus the two refusals that mark the edge of
what that backend can pass (no stack arguments, no two-word values).

Tools (override with --arm-as / --rv-as or the environment):
  ARKCC_ARM_AS   directory holding arm-none-eabi-as / -ld / -objcopy / -nm
  ARKCC_RV_AS    directory holding riscv64-unknown-elf-as / -ld / ...
  ARKCC_GCC      host gcc (default: gcc on PATH)
A target whose toolchain is missing is SKIPPED, not failed; exit 2 means no
target could be run at all (nothing was verified), 1 means a real failure.
"""
import argparse
import glob
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_va_gate')
ARKC = os.path.join(ROOT, 'arkcc.exe')
if not os.path.exists(ARKC):
    ARKC = os.path.join(ROOT, 'arkcc')
INC = os.path.join(ROOT, 'stdlib', 'include')

# ---------------------------------------------------------------------------
# case sources
# ---------------------------------------------------------------------------

PRELUDE = r'''
#include <stdarg.h>

static int s4(int n, ...)
{
    va_list ap; int a, b, c, d;
    va_start(ap, n);
    a = va_arg(ap, int); b = va_arg(ap, int);
    c = va_arg(ap, int); d = va_arg(ap, int);
    va_end(ap);
    return a + 2 * b + 3 * c + 4 * d;
}
static int sN(int n, ...)
{
    va_list ap; int i, s = 0;
    va_start(ap, n);
    for (i = 0; i < n; i++) s = s * 3 + va_arg(ap, int);
    va_end(ap);
    return s;
}
static int s6flat(int n, ...)
{
    va_list ap; int a, b, c, d, e, f;
    va_start(ap, n);
    a = va_arg(ap, int); b = va_arg(ap, int); c = va_arg(ap, int);
    d = va_arg(ap, int); e = va_arg(ap, int); f = va_arg(ap, int);
    va_end(ap);
    return a + 2 * b + 3 * c + 4 * d + 5 * e + 6 * f;
}
/* va_copy: two walkers over one argument image.  va_list is a plain pointer on
 * these two targets, so the copy is an assignment -- but that is a decision the
 * header makes, and it has to be a *value* copy: if the two names shared one
 * object, the second walker would resume where the first stopped and read the
 * word after 2 instead of 2.  Both must answer 122. */
static int va_copy_case(int n, ...)
{
    va_list ap, aq; int a, b, c;
    va_start(ap, n);
    a = va_arg(ap, int);
    va_copy(aq, ap);
    b = va_arg(ap, int);
    c = va_arg(aq, int);
    va_end(ap); va_end(aq);
    (void)n;
    return a * 100 + b * 10 + c;
}
static int four_named(int a, int b, int c, int d, ...)
{
    va_list ap; int x, y;
    va_start(ap, d);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap);
    return a + b + c + d + x * 10 + y * 100;
}
/* A 12-byte composite through `...` is three argument words, and this case is
 * the one that made the riscv32 backend's word reassembly visible: the words
 * have to come from base+4j, not base+j, or s.b/s.c are read out of the middle
 * of a neighbouring word.  The members carry different weights so any swap
 * changes the answer, and the trailing int proves the walk advanced by the
 * whole payload rather than by one word. */
struct s12 { int a, b, c; };
static int struct12_va(int n, ...)
{
    va_list ap; struct s12 s; int t;
    va_start(ap, n);
    s = va_arg(ap, struct s12);
    t = va_arg(ap, int);
    va_end(ap);
    (void)n;
    return (s.a + s.b * 2 + s.c * 3 + t) & 0xFF;
}
'''

# 64-bit and floating values: only the ARM target has the two-word value model
# these need (the RV32I backend refuses 8-byte loads/stores by name, and the
# gate asserts that refusal below).
PRELUDE_64 = r'''
union llw { long long v; int w[2]; };
union ddw { double d; int w[2]; };

static int llw_sum(int n, ...)
{
    union llw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.v = va_arg(ap, long long); s += u.w[0] + u.w[1]; }
    va_end(ap);
    return s;
}
static int dsum(int n, ...)
{
    union ddw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.d = va_arg(ap, double); s = s * 31 + (u.w[1] >> 20) + u.w[0]; }
    va_end(ap);
    return s;
}
/* A negative double built by setting the sign bit: the ARM backend's unary
 * minus on a 64-bit value goes through its integer path (NEG on the high word),
 * which is not IEEE negation -- a separate defect this gate should not measure. */
static double mkneg(double x)
{
    union ddw u;
    u.d = x;
    u.w[1] = u.w[1] | 0x80000000u;
    return u.d;
}
static int named_ll(int a, long long b, ...)
{
    union llw u; va_list ap; int x, y;
    u.v = b;
    va_start(ap, b);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap);
    return a + u.w[0] + u.w[1] + x * 10 + y * 100;
}
static int odd_named(int a, ...)
{
    union llw u; va_list ap;
    va_start(ap, a);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
static int two_named_ll(int a, long long b, ...)
{
    union llw u; va_list ap;
    va_start(ap, b);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
/* A struct passed by value through `...`: AAPCS copies anything larger than
 * two words onto the stack, so the walk sees three plain words.  This case only
 * proves the common path -- a composite whose size is not a multiple of 4, or
 * whose members need 8-byte alignment, is not covered here. */
struct s3 { int a, b, c; };
static struct s3 mk_s3(void)
{
    struct s3 t; t.a = 1; t.b = 2; t.c = 3;
    return t;
}
static int struct_va(int n, ...)
{
    va_list ap; struct s3 s;
    va_start(ap, n);
    s = va_arg(ap, struct s3);
    va_end(ap);
    (void)n;
    return (s.a + s.b + s.c) & 0xFF;
}
/* Region shapes: the prologue saves r_k..r3 with k = NCRN rounded down to an
 * even number, so these four signatures have to walk regions of 16, 8, 8 and 0
 * bytes.  The 64-bit ones are the ones that can tell whether the region base is
 * still 8-byte aligned after the shrink. */
static int s2_ll(int a, int b, ...)
{
    union llw u; va_list ap;
    va_start(ap, b);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + u.w[0] + u.w[1];
}
static int s3_ll(int a, int b, int c, ...)
{
    union llw u; va_list ap;
    va_start(ap, c);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + c + u.w[0] + u.w[1];
}
static int s4_int(int a, int b, int c, int d, ...)
{
    va_list ap; int x;
    va_start(ap, d);
    x = va_arg(ap, int);
    va_end(ap);
    return a + b + c + d + x;
}
/* Three named words leave r3 free -- but r3 is an odd register, so AAPCS puts
 * the first variadic long long on the stack and leaves r3 as a hole.  The
 * region walk therefore has to round up from region word 3 to word 4, which
 * only works if the region base is 8-byte aligned: this case is the one that
 * fails the moment a caller returns with a misaligned sp (measured on the board
 * as 85 instead of 17 before the extern-void stack leak was fixed). */
static int cross_ll(int a, int b, int c, ...)
{
    union llw u; va_list ap;
    va_start(ap, c);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + c + u.w[0] + u.w[1];
}
static int after_ll_pair(int a, long long b, long long c, ...)
{
    va_list ap; int x;
    va_start(ap, c);
    x = va_arg(ap, int);
    va_end(ap);
    return a + x;
}
'''

# Cases whose RV32I source needs PRELUDE_64I on top of PRELUDE.
RV64_CASES = set(('ll_reg', 'll_mix', 'named_ll', 'odd_ll', 'two_ll',
                  'cross_ll', 's2_ll', 's3_ll', 'pair'))

# (name, main body, targets the case applies to)
CASES = [
    ('s4',       'return s4(4, 1, 2, 3, 4) & 0xFF;', 'arm rv'),
    ('s6flat',   'return s6flat(6, 1, 2, 3, 4, 5, 6) & 0xFF;', 'arm rv'),
    ('loop3',    'return sN(3, 1, 0, 1) & 0xFF;', 'arm rv'),
    ('loop4',    'return sN(4, 1, 2, 3, 4) & 0xFF;', 'arm rv'),
    ('four',     'return four_named(1, 2, 3, 4, 5, 6) & 0xFF;', 'arm rv'),
    ('va_copy',  'return va_copy_case(0, 1, 2) & 0xFF;', 'arm rv'),
    ('ll_reg',   'return llw_sum(1, 0x1122334455667788LL) & 0xFF;', 'arm rv'),
    ('ll_mix',   'return llw_sum(2, 0x1122334455667788LL, 0x99aabbccddeeff00LL) & 0xFF;', 'arm rv'),
    ('named_ll', 'return named_ll(1, 0x1122334455667788LL, 7, 8) & 0xFF;', 'arm rv'),
    ('odd_ll',   'return odd_named(1, 0x1122334455667788LL) & 0xFF;', 'arm rv'),
    ('two_ll',   'return two_named_ll(1, 0x1122334455667788LL, 0x99aabbccddeeff00LL) & 0xFF;', 'arm rv'),
    ('cross_ll', 'return cross_ll(1, 2, 3, 0x1122334455667788LL) & 0xFF;', 'arm rv'),
    ('struct_va', 'return struct_va(1, mk_s3()) & 0xFF;', 'arm'),
    ('struct12', 'struct s12 v; v.a = 1; v.b = 2; v.c = 3;'
                 ' return struct12_va(1, v, 100) & 0xFF;', 'arm rv'),
    ('struct2',  'return struct2_va(1, mk_s2x()) & 0xFF;', 'arm'),
    ('struct4',  'return struct4_va(1, mk_s4b()) & 0xFF;', 'arm'),
    ('struct8a', 'return struct8a_va(1, mk_s16a()) & 0xFF;', 'arm'),
    ('struct5p', 'return struct5p_va(1, mk_s5p()) & 0xFF;', 'arm'),
    ('struct_tail', 'return struct_tail(1, mk_s3(), 7, 9) & 0xFF;', 'arm'),
    ('struct_split', 'return struct_split(1, 2, 3, mk_s3()) & 0xFF;', 'arm'),
    ('struct_stack', 'return struct_stack(1, 2, 3, 4, mk_s3()) & 0xFF;', 'arm'),
    ('s2_ll',    'return s2_ll(1, 2, 0x1122334455667788LL) & 0xFF;', 'arm rv'),
    ('s3_ll',    'return s3_ll(1, 2, 3, 0x1122334455667788LL) & 0xFF;', 'arm rv'),
    ('s4_int',   'return s4_int(1, 2, 3, 4, 5) & 0xFF;', 'arm'),
    ('pair',     'return after_ll_pair(1, 0x1122334455667788LL, 0x99aabbccddeeff00LL, 9) & 0xFF;', 'arm rv'),
    ('d_one',    'return dsum(1, 1.5) & 0xFF;', 'arm'),
    ('d_three',  'return dsum(3, 1.5, 2.5, 3.5) & 0xFF;', 'arm'),
    ('d_neg',    'return dsum(2, 1024.5, mkneg(2.5)) & 0xFF;', 'arm'),
    ('d_prom',   'return dsum(1, 1.5f) & 0xFF;', 'arm'),
    # Nine argument words: eight in a0-a7 and one on the stack.  This used to
    # be a *refusal* on RV32I (the backend had no stack-argument path); it is
    # a result case now, so the number, not the error text, is the assertion.
    ('toomany', 'return sN(8, 1, 0, 1, 1, 0, 0, 1, 0) & 0xFF;', 'arm rv'),
    # 34 argument words: 4 in r0-r3 and 30 on the stack.  The ARM region is the
    # caller's own image, so the only limit is the caller's stack -- there is
    # no mirrored window to overflow any more.
    ('many_stack', 'return sN(33, ' + ', '.join(str(i) for i in range(1, 34)) + ') & 0xFF;',
     'arm'),
]

# Arguments a target cannot pass must be a build error, and that is asserted.
# Nothing is refused any more: a composite wider than two words through `...`
# used to be an arm-only feature (riscv32 built a different argument image, so
# the inline words would have been read as something else) and was a refusal
# case here.  The riscv32 backend now lays the payload out as consecutive
# argument words too, so it is the `struct12` result case above that guards it.
REFUSE = []

# A composite wider than two words for the refusal case above.
STRUCT_SNIPPET = r'''
struct xs3 { int a, b, c; };
static struct xs3 xmk(void) { struct xs3 t; t.a = 1; t.b = 2; t.c = 3; return t; }
static int xs3v(int n, ...)
{
    va_list ap; struct xs3 s;
    va_start(ap, n); s = va_arg(ap, struct xs3); va_end(ap); (void)n;
    return s.a;
}
'''

# A 64-bit reader for the refusal case above (the RV32I prelude has none).
LL_SNIPPET = r'''
union llw { long long v; int w[2]; };
static int llw_sum(int n, ...)
{
    union llw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.v = va_arg(ap, long long); s += u.w[0] + u.w[1]; }
    va_end(ap);
    return s;
}
'''

# Integer-only 64-bit varargs for RV32I: everything PRELUDE_64 has except the
# double and composite cases, which that backend cannot pass yet.  Kept as a
# separate string rather than filtered out of PRELUDE_64 so a case can never be
# compiled against a declaration it needs and silently lose it.
PRELUDE_64I = r'''
union llw { long long v; int w[2]; };

static int llw_sum(int n, ...)
{
    union llw u; va_list ap; int s = 0, i;
    va_start(ap, n);
    for (i = 0; i < n; i++) { u.v = va_arg(ap, long long); s += u.w[0] + u.w[1]; }
    va_end(ap);
    return s;
}
static int named_ll(int a, long long b, ...)
{
    union llw u; va_list ap; int x, y;
    u.v = b;
    va_start(ap, b);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap);
    return a + u.w[0] + u.w[1] + x * 10 + y * 100;
}
static int odd_named(int a, ...)
{
    union llw u; va_list ap;
    va_start(ap, a);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
static int two_named_ll(int a, long long b, ...)
{
    union llw u; va_list ap;
    va_start(ap, b);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + u.w[0] + u.w[1];
}
static int s2_ll(int a, int b, ...)
{
    union llw u; va_list ap;
    va_start(ap, b);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + u.w[0] + u.w[1];
}
static int s3_ll(int a, int b, int c, ...)
{
    union llw u; va_list ap;
    va_start(ap, c);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + c + u.w[0] + u.w[1];
}
static int cross_ll(int a, int b, int c, ...)
{
    union llw u; va_list ap;
    va_start(ap, c);
    u.v = va_arg(ap, long long);
    va_end(ap);
    return a + b + c + u.w[0] + u.w[1];
}

static int after_ll_pair(int a, long long b, long long c, ...)
{
    va_list ap; int x;
    va_start(ap, c);
    x = va_arg(ap, int);
    va_end(ap);
    return a + x;
}
'''

# Composites through `...`, sizes two words and up.  A *named* parameter of more
# than two words travels as one address word (this compiler's own convention,
# the callee memcpys it); an *unnamed* one cannot, because the callee has no
# type for it and <stdarg.h> walks consecutive words.  AAPCS passes the payload
# inline, and so does gcc (measured: `f(1, s12)` arrives in r1,r2,r3), so the
# caller writes one word per four bytes.
PRELUDE_STRUCT = r'''
struct s2x { int a, b; };                    /* 8 bytes, 4-byte alignment */
struct s4b { int a, b, c, d; };              /* 16 bytes, 4-byte alignment */
struct s16a { long long a, b; };             /* 16 bytes, 8-byte alignment */
struct s5p { int a; char b; } __attribute__((packed));   /* 5 bytes -> 2 words */
static struct s2x mk_s2x(void) { struct s2x t; t.a = 11; t.b = 22; return t; }
static struct s4b mk_s4b(void)
{
    struct s4b t; t.a = 1; t.b = 2; t.c = 3; t.d = 4; return t;
}
static struct s16a mk_s16a(void) { struct s16a t; t.a = 5; t.b = 6; return t; }
static struct s5p mk_s5p(void)
{
    struct s5p t; t.a = 0x01020304; t.b = 7; return t;
}
static int struct2_va(int n, ...)
{
    va_list ap; struct s2x s;
    va_start(ap, n); s = va_arg(ap, struct s2x); va_end(ap); (void)n;
    return (s.a + s.b) & 0xFF;
}
static int struct4_va(int n, ...)
{
    va_list ap; struct s4b s;
    va_start(ap, n); s = va_arg(ap, struct s4b); va_end(ap); (void)n;
    return (s.a + s.b + s.c + s.d) & 0xFF;
}
static int struct8a_va(int n, ...)
{
    va_list ap; struct s16a s;
    va_start(ap, n); s = va_arg(ap, struct s16a); va_end(ap); (void)n;
    return (int)(s.a + s.b) & 0xFF;
}
static int struct5p_va(int n, ...)
{
    va_list ap; struct s5p s;
    va_start(ap, n); s = va_arg(ap, struct s5p); va_end(ap); (void)n;
    return (s.a + s.b) & 0xFF;
}
/* The composite is followed by two more arguments: the walk has to resume at
 * the right word after a multi-word argument. */
static int struct_tail(int n, ...)
{
    va_list ap; struct s3 t; int x, y;
    va_start(ap, n);
    t = va_arg(ap, struct s3);
    x = va_arg(ap, int);
    y = va_arg(ap, int);
    va_end(ap); (void)n;
    return (t.a + t.b + t.c) * 4 + x + y;
}
/* Three named words leave r3 free, so a 12-byte composite splits: word 0 in
 * r3, words 1,2 on the stack (gcc does the same). */
static int struct_split(int a, int b, int c, ...)
{
    va_list ap; struct s3 t;
    va_start(ap, c);
    t = va_arg(ap, struct s3);
    va_end(ap);
    return (a + b + c + t.a + t.b + t.c) & 0xFF;
}
/* Four named words: the composite is entirely on the stack. */
static int struct_stack(int a, int b, int c, int d, ...)
{
    va_list ap; struct s3 t;
    va_start(ap, d);
    t = va_arg(ap, struct s3);
    va_end(ap);
    return (a + b + c + d + t.a + t.b + t.c) & 0xFF;
}
'''


# The arm backend writes global initialisers as code in __arkcc_init_globals
# (it stores them into SRAM at g_data_base, 0x20000000) and leaves the call to
# the runtime startup.  A test stub that skipped it saw every global as zero --
# which is exactly the sort of silence this gate exists to prevent, so do it
# here, with a null check because a program without initialised globals does
# not define the symbol at all.
ARM_START = '''    .syntax unified
    .thumb
    .global _start
    .weak __arkcc_init_globals
    .text
_start:
    ldr sp, =0x20080000
    ldr r0, =__arkcc_init_globals
    cmp r0, #0
    beq 1f
    blx r0
1:
    bl main
_hang:
    b _hang

/* A byte loop for memcpy.  A block-scope initialiser that copies a string
 * literal into a local char array (`char s[6] = "abc";`, `char m[2][6] =
 * {"ab","cd"};`) expands to a memcpy call, so without a definition here every
 * such case on this target died at link time and could not be tested at all. */
    .global memcpy
    .thumb_func
memcpy:
    mov r3, r0
2:
    cmp r2, #0
    beq 3f
    ldrb r12, [r1], #1
    strb r12, [r3], #1
    subs r2, r2, #1
    bne 2b
3:
    bx lr
'''

RV_START = '''    .text
    .global _start
_start:
    li sp, 0x20080000
    call main
hang:
    j hang

/* Byte-loop memcpy: a block-scope string initialiser (`char s[6] = "abc";`)
 * expands to a memcpy call, and without it such a case could not link here. */
    .global memcpy
memcpy:
    mv a3, a0
4:
    beqz a2, 5f
    lbu a4, 0(a1)
    sb a4, 0(a3)
    addi a1, a1, 1
    addi a3, a3, 1
    addi a2, a2, -1
    j 4b
5:
    ret
'''


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


class Runner:
    def __init__(self, gcc):
        self.gcc = gcc
        self.passed = 0
        self.failed = 0
        self.opt = []

    def run(self, cmd):
        return subprocess.run(cmd, capture_output=True, text=True, errors='replace')

    def oracle(self, src, exe):
        if not self.gcc:
            return None, 'no host gcc'
        r = self.run([self.gcc, '-w', src, '-o', exe])
        if r.returncode != 0:
            return None, r.stderr
        return self.run([exe]).returncode & 0xFF, ''

    def compile(self, target, src, asm):
        r = self.run([ARKC, '-target', target, '-S', '-I', INC]
                     + getattr(self, 'opt', []) + [src, '-o', asm])
        if r.returncode != 0:
            return 'arkcc: ' + (r.stdout + r.stderr).strip()
        return ''

    def symbols(self, elf, nm):
        out = {}
        r = self.run([nm, elf])
        for ln in r.stdout.splitlines():
            p = ln.split()
            if len(p) == 3:
                try:
                    out[p[2]] = int(p[0], 16)
                except ValueError:
                    pass
        return out

    def arm(self, name, src, tool, libgcc=''):
        """Assemble/link/run one ARM case.

        `libgcc` is the soft-float/no-FPU libgcc.a: the backend no longer
        carries its own AEABI helpers (they answered 5 classes of calls
        wrongly -- see backend_arm.c), so an image that uses a double, a
        64-bit division or a float conversion must link the runtime.  A
        missing library is therefore a link error, not a wrong answer.
        """
        asm = os.path.join(TMP, name + '.s')
        gnu = os.path.join(TMP, name + '_gnu.s')
        obj = os.path.join(TMP, name + '.o')
        elf = os.path.join(TMP, name + '.elf')
        binf = os.path.join(TMP, name + '.bin')
        err = self.compile('arm', src, asm)
        if err:
            return None, err
        # arkcc's own text uses ';' comments and omits .syntax unified: both are
        # its conventions, so the host assembler needs them translated.
        lines = ['    .syntax unified']
        for ln in open(asm, encoding='utf-8', errors='replace').read().splitlines():
            if ln.lstrip().startswith(';'):
                continue
            lines.append(ln)
        write(gnu, '\n'.join(lines) + '\n')
        r = self.run([tool('as'), '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                      '-mfloat-abi=hard', gnu, '-o', obj])
        if r.returncode != 0:
            return None, 'as: ' + r.stderr.strip()
        ldargs = [tool('ld'), '-Ttext=0x08000000', '-e', '_start',
                  os.path.join(TMP, 'start_arm.o'), obj]
        if libgcc:
            ldargs.append(libgcc)
        r = self.run(ldargs + ['-o', elf])
        if r.returncode != 0:
            return None, 'ld: ' + r.stderr.strip()
        r = self.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if r.returncode != 0:
            return None, 'objcopy: ' + r.stderr.strip()
        return self.exec_arm(binf, elf, tool)

    def rv(self, name, src, tool):
        asm = os.path.join(TMP, name + '.s')
        obj = os.path.join(TMP, name + '.o')
        elf = os.path.join(TMP, name + '.elf')
        binf = os.path.join(TMP, name + '.bin')
        err = self.compile('riscv32', src, asm)
        if err:
            return None, err
        r = self.run([tool('as'), '-march=rv32im', '-mabi=ilp32', asm, '-o', obj])
        if r.returncode != 0:
            return None, 'as: ' + r.stderr.strip()
        r = self.run([tool('ld'), '-m', 'elf32lriscv', '-Ttext=0x08000000', '-e', '_start',
                      os.path.join(TMP, 'start_rv.o'), obj, '-o', elf])
        if r.returncode != 0:
            return None, 'ld: ' + r.stderr.strip()
        r = self.run([tool('objcopy'), '-O', 'binary', elf, binf])
        if r.returncode != 0:
            return None, 'objcopy: ' + r.stderr.strip()
        return self.exec_rv(binf, elf, tool)

    def exec_arm(self, binf, elf, tool):
        from unicorn import Uc, UcError, UC_ARCH_ARM, UC_MODE_THUMB, UC_MODE_MCLASS
        from unicorn.arm_const import (UC_ARM_REG_SP, UC_ARM_REG_LR,
                                       UC_ARM_REG_PC, UC_ARM_REG_R0)
        syms = self.symbols(elf, tool('nm'))
        uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
        uc.mem_map(0x08000000, 0x100000)
        uc.mem_write(0x08000000, open(binf, 'rb').read())
        uc.mem_map(0x20000000, 0x100000)
        # The arm backend places initialised globals in SRAM (g_data_base,
        # 0x20000000 by default) and leaves an image in flash for the startup
        # code to copy.  Without that copy every global reads as zero, which is
        # how "the arm backend never loads a global correctly" could hide: the
        # linker script here is a bare -Ttext.  Do what real startup does.
        dbin = os.path.join(TMP, '_initdata.bin')
        r = self.run([tool('objcopy'), '-O', 'binary', '--only-section=.data',
                      elf, dbin])
        if r.returncode == 0 and os.path.exists(dbin):
            blob = open(dbin, 'rb').read()
            if blob:
                uc.mem_write(0x20000000, blob)
        uc.reg_write(UC_ARM_REG_SP, 0x20080000)
        uc.reg_write(UC_ARM_REG_LR, 0xFFFFFFFF)
        try:
            uc.emu_start(syms['_start'] | 1, syms['_hang'] | 1, count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_ARM_REG_PC))
        return uc.reg_read(UC_ARM_REG_R0) & 0xFF, ''

    def exec_rv(self, binf, elf, tool):
        from unicorn import Uc, UcError, UC_ARCH_RISCV, UC_MODE_RISCV32
        from unicorn.riscv_const import UC_RISCV_REG_A0, UC_RISCV_REG_PC
        syms = self.symbols(elf, tool('nm'))
        uc = Uc(UC_ARCH_RISCV, UC_MODE_RISCV32)
        uc.mem_map(0x08000000, 0x100000)
        uc.mem_write(0x08000000, open(binf, 'rb').read())
        uc.mem_map(0x20000000, 0x100000)
        try:
            uc.emu_start(syms['_start'], syms['hang'], count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_RISCV_REG_PC))
        return uc.reg_read(UC_RISCV_REG_A0) & 0xFF, ''


FRAME_CAP = 1024   # bytes; nothing in this gate needs a bigger frame

def frame_peak(asm_path, target):
    """Largest frame one function reserves, and which function it was.

    The point of this check: an earlier version of the ARM and RV32I variadic
    support mirrored the whole argument register file into the frame at a fixed
    offset, which forced an 8 KB frame on every variadic function while a
    mini-app task on the board only gets 4 KB (APP_TASK_STACK_SIZE).  It passed
    every execution test here and could never have run on the target, so the
    frame size is asserted, not assumed.

    Summing *consecutive* adjustments is the whole point.  emit_sp_adjust()
    splits a frame larger than one encoding into several `SUB sp, sp, #N`, so
    the first version of this function -- which took the largest single
    instruction -- reported 4095 for a 9000-byte frame and FRAME_CAP happily
    passed it.  Measured: `char buf[9000]` -> three SUBs of 4095/4095/810,
    reported 4095.  A frame is the sum of the run, not its largest term.
    """
    try:
        text = open(asm_path, encoding='utf-8', errors='replace').read()
    except OSError:
        return None, None
    best, where = 0, None
    cur, run, fn = 0, 0, None
    for line in text.splitlines():
        m = re.match(r'^([A-Za-z_.$][\w.$]*):\s*$', line)
        if m:
            fn = m.group(1)
        if target == 'arm':
            m = re.match(r'^\s*SUB\s+sp,\s*sp,\s*#(\d+)\s*$', line)
            if m:
                run += int(m.group(1))
                if run > best:
                    best, where = run, fn
                continue
        else:
            m = re.match(r'^\s*sub\s+sp,\s*sp,\s*t0\s*$', line)
            if m:
                run += cur
                if run > best:
                    best, where = run, fn
                cur = 0
                continue
            m = re.match(r'^\s*li\s+t0,\s*(\d+)\s*$', line)
            if m:
                cur = int(m.group(1))
                continue
        run = 0
    return best, where

FRAME_SELFTEST = """
f_small:
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #64
    POP {r5, r6, r7, pc}
f_big:
    PUSH {r5, r6, r7, lr}
    SUB sp, sp, #4095
    SUB sp, sp, #4095
    SUB sp, sp, #810
    POP {r5, r6, r7, pc}
"""


def frame_check_selftest(r):
    """The frame assertion has to be able to fail, so test the instrument.

    frame_peak() reported 4095 for a 9000-byte frame before it summed the run
    of split `SUB sp, sp, #N`, i.e. FRAME_CAP passed a frame 8.8x over the cap.
    A gate that cannot fail is not a gate; this pins the accumulator itself.
    """
    path = os.path.join(TMP, 'frame_selftest.s')
    write(path, FRAME_SELFTEST)
    big, fn = frame_peak(path, 'arm')
    if big != 9000 or fn != 'f_big':
        print('FAIL frame/selftest split run -> %r in %r, want 9000 in f_big'
              % (big, fn))
        r.failed += 1
    else:
        print('PASS frame/selftest split run 4095+4095+810 counted as 9000')
        r.passed += 1
    # f_small is smaller than f_big, so the maximum legitimately stays on f_big;
    # check the single-instruction case on its own file.
    write(path, 'g:\n    SUB sp, sp, #64\n')
    one, fn = frame_peak(path, 'arm')
    if one != 64:
        print('FAIL frame/selftest single adjustment -> %r, want 64' % (one,))
        r.failed += 1
    else:
        print('PASS frame/selftest single adjustment 64')
        r.passed += 1
    # ...and the alignment invariant must be able to fail too: three pushed
    # argument words leave sp at 4 mod 8.
    write(path, 'bad:\n    PUSH {r1, r2, r3}\n    PUSH {r5, r6, r7, lr}\n'
                '    SUB sp, sp, #8\n    MOV r6, sp\n')
    bad = frame_align_problems(path)
    write(path, 'good:\n    PUSH {r0, r1, r2, r3}\n    PUSH {r5, r6, r7, lr}\n'
                '    SUB sp, sp, #8\n    MOV r6, sp\n')
    good = frame_align_problems(path)
    if not bad or good:
        print('FAIL frame/selftest alignment invariant bad=%r good=%r'
              % (bad, good))
        r.failed += 1
    else:
        print('PASS frame/selftest alignment invariant flags an odd push')
        r.passed += 1


REGION_SRC = (
    '#include <stdarg.h>\n'
    'int r1(int a, ...) { va_list ap; int x; va_start(ap, a); x = va_arg(ap, int); va_end(ap); return a + x; }\n'
    'int r2(int a, int b, ...) { va_list ap; int x; va_start(ap, b); x = va_arg(ap, int); va_end(ap); return a + b + x; }\n'
    'int r3(int a, int b, int c, ...) { va_list ap; int x; va_start(ap, c); x = va_arg(ap, int); va_end(ap); return a + b + c + x; }\n'
    'int r4(int a, int b, int c, int d, ...) { va_list ap; int x; va_start(ap, d); x = va_arg(ap, int); va_end(ap); return a + b + c + d + x; }\n'
)


def region_checks(r):
    """The prologue must save exactly the register words that can be variadic.

    Cost per signature is the whole point of the shrink: 16 bytes for one named
    word, 8 for two or three, 0 for four.  A signature silently falling back to
    "always push four" would still be correct, just 8 bytes more expensive per
    call, so the shape is asserted rather than left to the frame-size check.
    """
    src = os.path.join(TMP, 'region_shapes.c')
    asm = os.path.join(TMP, 'region_shapes.s')
    write(src, REGION_SRC)
    rc = r.run([ARKC, '-target', 'arm', '-S', '-O1', '-I', INC,
                '-I', INC, src, '-o', asm])
    if rc.returncode != 0:
        print('FAIL asm/region   arkcc failed: %s'
              % (rc.stdout + rc.stderr).strip()[:160])
        r.failed += 1
        return
    text = open(asm, encoding='utf-8', errors='replace').read().splitlines()
    want = {'r1': 'PUSH {r0, r1, r2, r3}', 'r2': 'PUSH {r2, r3}',
            'r3': 'PUSH {r2, r3}', 'r4': None}
    for fn, expect in want.items():
        i = text.index(fn + ':') if (fn + ':') in text else -1
        if i < 0:
            print('FAIL asm/region%-3s function missing from the output' % fn)
            r.failed += 1
            continue
        got = text[i + 1].strip()
        while got.startswith('.'):        # .cfi_startproc
            i += 1
            got = text[i + 1].strip()
        # the first real instruction is the region push (or the saved registers)
        if expect is None:
            ok = got == 'PUSH {r5, r6, r7, lr}'
        else:
            ok = got == expect
        if not ok:
            print('FAIL asm/region%-3s prologue starts with %r, want %r'
                  % (fn, got, expect or 'PUSH {r5, r6, r7, lr} (no region)'))
            r.failed += 1
        else:
            print('PASS asm/region%-3s %s' % (fn, got))
            r.passed += 1


def frame_align_problems(asm_path):
    """Functions whose *prologue* leaves sp at 4 mod 8.

    Every prologue move is a multiple of 4, and AAPCS32 wants sp 8-byte aligned
    wherever another function can observe it -- which is exactly the property
    va_arg's "round up to 8" leans on.  Summing the prologue catches the case
    where saving 4 bytes looks free: pushing three register words instead of
    four keeps the *region* walk correct (address parity still matches AAPCS
    word parity) but drops the frame to 4 mod 8, and a `double` local or a
    GCC-compiled callee can then fault on an 8-byte access.

    Only the prologue counts: the bodies of these functions use PUSH/POP as a
    stack machine, so summing every PUSH in a function says nothing about sp at
    the first call.  The prologue ends at `MOV r6, sp` (or at the first
    instruction that is neither PUSH nor SUB).
    """
    out = []
    fn, total, in_pro = None, 0, False
    for line in open(asm_path, encoding='utf-8', errors='replace'):
        line = line.rstrip()
        m = re.match(r'^([A-Za-z_$][\w.$]*):$', line)
        if m:
            if fn is not None and in_pro and total % 8:
                out.append((fn, total))
            fn, total, in_pro = m.group(1), 0, True
            continue
        if not in_pro:
            continue
        t = line.strip()
        if not t or t.startswith(('.cfi', '.loc', ';', '.file', '.size', '.type')):
            continue
        m = re.match(r'^PUSH\s+\{(.*)\}$', t)
        if m:
            total += 4 * len([r for r in m.group(1).split(',') if r.strip()])
            continue
        m = re.match(r'^SUB\s+sp,\s*sp,\s*#(\d+)$', t)
        if m:
            total += int(m.group(1))
            continue
        if t == 'MOV r6, sp':
            if total % 8:
                out.append((fn, total))
            in_pro = False
            continue
        in_pro = False
    return out


def tool_finder(prefix, path):
    """Return a function 'as'/'ld'/... -> absolute tool path, or None."""
    if not path:
        return None

    def find(kind):
        name = prefix + kind
        exe = os.path.join(path, name + '.exe')
        if os.path.exists(exe):
            return exe
        found = shutil.which(name)
        if found:
            return found
        raise SystemExit('toolchain binary not found: %s in %s' % (name, path))

    try:
        find('as')
    except SystemExit:
        return None
    return find


# Instructions whose encoding this gate must pin down byte for byte.
#
# The ARM cases below go through GNU as; the board goes through arkc's own
# assembler.  Two encoders for one text means "GNU as accepted it" says nothing
# about the target, and the va epilogue is the one instruction pair where that
# difference bit: `POP {r5, r6, r7, lr}` has no 16-bit form at all (bit 8 is PC
# in POP, LR only in PUSH), the internal encoder silently dropped `lr`, and the
# variadic return then popped three registers instead of four -- 4 bytes of
# stack lost and a stale lr on every return, invisible on the host.
ENCODING = [
    ('pop_lr',
     '.thumb\n.text\n.global f\nf:\n'
     '    PUSH {r5, r6, r7, lr}\n    POP {r5, r6, r7, lr}\n    BX lr\n',
     b'\xe0\xb5\xbd\xe8\xe0\x40\x70\x47'),
    ('pop_pc',
     '.thumb\n.text\n.global g\ng:\n    POP {r5, r6, r7, pc}\n',
     b'\xe0\xbd'),
]


# How many words a call leaves on the IR stack, when the callee is only
# declared in this translation unit.
#
# irgen decides the pop count from the *call expression's* type; the backends
# used to decide the push count by looking the callee up in prog->funcs, i.e.
# only among functions this file defines.  A declared-only callee therefore got
# "returns one word" no matter what its prototype said:
#   extern void h(void); h();            -> pushed r0 that nobody popped,
#                                           4 bytes of stack leaked per call
#   extern long long e(void); return e();-> high word never pushed, silently
#                                           wrong 64-bit result
# The leaked word is what broke va_arg on the board: MINISTART's
# __arkcc_init_globals() call left the MiniApp frame 4 bytes off, so the
# argument region was no longer 8-byte aligned and every 64-bit va_arg read
# one word early.  Both shapes are asserted here.
SHAPE_SRC = (
    'extern void h(void);\n'
    'extern long long e(void);\n'
    'int main(void) { h(); return (int)(e() >> 40) & 0xFF; }\n'
)


def shape_checks(r):
    src = os.path.join(TMP, 'shape_voidcall.c')
    asm = os.path.join(TMP, 'shape_voidcall.s')
    write(src, SHAPE_SRC)
    rc = r.run([ARKC, '-target', 'arm', '-S', '-O1', '-I', INC, src, '-o', asm])
    if rc.returncode != 0:
        print('FAIL asm/void_call  arkcc failed: %s'
              % (rc.stdout + rc.stderr).strip()[:160])
        r.failed += 1
        return
    lines = [ln.strip() for ln in open(asm, encoding='utf-8', errors='replace')]
    lines = [ln for ln in lines if ln and not ln.startswith(';')]

    def after(mnemonic):
        for i, ln in enumerate(lines):
            if ln.replace('  ', ' ') == mnemonic:
                return lines[i + 1:i + 4]
        return None

    tail = after('BL h')
    want = 'PUSH {r0}'
    if tail is None:
        print('FAIL asm/void_call  no "BL h" in the emitted assembly')
        r.failed += 1
    elif tail[0] == want:
        print('FAIL asm/void_call  a declared-only void call pushed a result: %r'
              % (tail,))
        r.failed += 1
    else:
        print('PASS asm/void_call  h() pushes nothing')
        r.passed += 1

    tail = after('BL e')
    if tail is None:
        print('FAIL asm/void_call  no "BL e" in the emitted assembly')
        r.failed += 1
    elif tail[0] != 'PUSH {r0}' or tail[1] != 'PUSH {r1}':
        print('FAIL asm/void_call  a declared-only long long call must push both '
              'words, got %r' % (tail,))
        r.failed += 1
    else:
        print('PASS asm/void_call  e() pushes both words')
        r.passed += 1


def encoding_checks(r):
    """arkcc's own assembler, checked byte for byte (no external toolchain)."""
    for name, text, want in ENCODING:
        src = os.path.join(TMP, 'enc_' + name + '.s')
        out = os.path.join(TMP, 'enc_' + name + '.bin')
        write(src, text)
        if os.path.exists(out):
            os.remove(out)
        rc = r.run([ARKC, '-target', 'arm', src, '-o', out])
        if rc.returncode != 0:
            print('FAIL asm/%-9s assembler failed: %s'
                  % (name, (rc.stdout + rc.stderr).strip()[:160]))
            r.failed += 1
            continue
        try:
            got = open(out, 'rb').read()
        except OSError as e:
            print('FAIL asm/%-9s no output: %s' % (name, e))
            r.failed += 1
            continue
        if got != want:
            print('FAIL asm/%-9s got %s want %s'
                  % (name, got.hex(), want.hex()))
            r.failed += 1
        else:
            print('PASS asm/%-9s %s' % (name, want.hex()))
            r.passed += 1


# The optimiser sets the gate must survive.  -fopt-regalloc moves the saved
# register block, which shifts every caller-frame offset a variadic function
# reads through r6 -- so it has to be exercised by default, not just when
# somebody remembers to pass --opt.
OPT_SUITE = [
    [],
    ['-O2'],
    ['-fopt-regalloc', '-fopt-regalloc-near'],
    ['-O2', '-fopt-regalloc', '-fopt-regalloc-near'],
    ['-O2', '-freg-top', '-finline',
     '-fopt-regalloc', '-fopt-regalloc-near'],
]

def opt_suite(args):
    """Run the whole gate once per optimiser set, then aggregate."""
    import subprocess
    here = os.path.abspath(__file__)
    bad = []
    for opts in OPT_SUITE:
        label = ' '.join(opts) if opts else '(default)'
        cmd = [sys.executable, here,
               '--arm-as', args.arm_as, '--rv-as', args.rv_as,
               '--gcc', args.gcc]
        if opts:
            cmd.append('--opt=' + ' '.join(opts))
        print('\n=== %s ===' % label)
        sys.stdout.flush()
        rc = subprocess.call(cmd)
        if rc != 0:
            bad.append(label)
            print('=== %s: FAILED (rc=%d) ===' % (label, rc))
    total = len(OPT_SUITE)
    print('\n=== opt suite: %d/%d set(s) green ==='
          % (total - len(bad), total))
    if bad:
        for label in bad:
            print('    red: %s' % label)
        return 1
    return 0

def find_arm_libgcc(arm_tool_dir):
    """libgcc.a for arm-none-eabi (thumb/v7-m, no FPU).

    The arm backend emits AEABI calls (`__aeabi_dadd`, `__aeabi_ldivmod`, ...)
    and expects the target runtime to provide them, the same way armcc expects
    armlib.  Pick the *no-FPU* multilib: the backend calls those helpers with
    integer registers, so a hard-float libgcc (which expects VFP arguments)
    would be ABI-incompatible.
    """
    if not arm_tool_dir:
        return ''
    top = os.path.dirname(os.path.abspath(arm_tool_dir))   # .../tools
    pat = os.path.join(top, 'lib', 'gcc', 'arm-none-eabi', '*',
                       'thumb', 'v7-m', 'nofp', 'libgcc.a')
    hits = sorted(glob.glob(pat))
    return hits[-1] if hits else ''


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''))
    ap.add_argument('--arm-libgcc',
                    default=os.environ.get('ARKCC_ARM_LIBGCC', ''),
                    help='libgcc.a providing the AEABI helpers the arm '
                         'backend calls (autodetected from --arm-as)')
    ap.add_argument('--rv-as', default=os.environ.get('ARKCC_RV_AS', ''))
    ap.add_argument('--gcc', default=os.environ.get('ARKCC_GCC', 'gcc'))
    # Extra arkcc options for the *case* compiles (e.g. "-O2 -freg-top"), so the
    # same 49 cases can be re-run through the optimiser and the reg-top
    # peephole.  Empty by default: the plain run is the reference.
    ap.add_argument('--opt', default=os.environ.get('ARKCC_VA_OPT', ''))
    # Sweep every optimiser set that touches frame geometry (see OPT_SUITE).
    ap.add_argument('--opt-suite', action='store_true',
                    help='run the whole gate once per optimiser set and '
                         'aggregate the verdicts')
    args = ap.parse_args()

    if args.opt_suite:
        return opt_suite(args)

    try:
        import unicorn  # noqa: F401
    except ImportError:
        print('SKIP: the unicorn python package is not installed '
              '(pip install unicorn); nothing was verified')
        return 2

    os.makedirs(TMP, exist_ok=True)
    write(os.path.join(TMP, 'start_arm.s'), ARM_START)
    write(os.path.join(TMP, 'start_rv.s'), RV_START)

    r = Runner(args.gcc if shutil.which(args.gcc) else None)
    r.opt = args.opt.split() if args.opt else []
    ran = 0

    encoding_checks(r)
    region_checks(r)
    frame_check_selftest(r)
    shape_checks(r)

    arm_tool = tool_finder('arm-none-eabi-', args.arm_as)
    arm_libgcc = args.arm_libgcc or find_arm_libgcc(args.arm_as)
    if arm_tool and not arm_libgcc:
        print('NOTE arm: no libgcc.a found next to the toolchain; cases that '
              'need the AEABI runtime (double, float, 64-bit divide) will fail '
              'to link.  Pass --arm-libgcc <path> to point at one.')
    if arm_tool:
        ran += 1
        rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                    os.path.join(TMP, 'start_arm.s'),
                    '-o', os.path.join(TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('FAIL arm start stub: ' + rc.stderr.strip()[:200])
            r.failed += 1
        for name, body, targets in CASES:
            if 'arm' not in targets.split():
                continue
            src = os.path.join(TMP, 'arm_' + name + '.c')
            write(src, PRELUDE + PRELUDE_64 + PRELUDE_STRUCT
                  + '\nint main(void)\n{\n    ' + body + '\n}\n')
            exp, err = r.oracle(src, os.path.join(TMP, 'arm_' + name + '_gcc.exe'))
            if exp is None:
                print('SKIP arm/%-9s no gcc oracle: %s' % (name, err.strip()[:80]))
                r.failed += 1
                continue
            got, err = r.arm('arm_' + name, src, arm_tool, arm_libgcc)
            if got is None:
                print('FAIL arm/%-9s %s' % (name, err.strip()[:200]))
                r.failed += 1
            elif got != exp:
                print('FAIL arm/%-9s arm=%d expected=%d' % (name, got, exp))
                r.failed += 1
            else:
                pk, pkfn = frame_peak(os.path.join(TMP, 'arm_' + name + '.s'), 'arm')
                bad = frame_align_problems(os.path.join(TMP, 'arm_' + name + '.s'))
                if pk is not None and pk > FRAME_CAP:
                    print('FAIL arm/%-9s frame %d B in %s > %d (a variadic frame '
                          'must stay small)' % (name, pk, pkfn, FRAME_CAP))
                    r.failed += 1
                elif bad:
                    print('FAIL arm/%-9s prologue leaves sp 4 mod 8 in %s'
                          % (name, ', '.join('%s(%d)' % b for b in bad[:3])))
                    r.failed += 1
                else:
                    print('PASS arm/%-9s %d' % (name, got))
                    r.passed += 1
    else:
        print('SKIP arm: no arm-none-eabi toolchain (set --arm-as / ARKCC_ARM_AS)')

    rv_tool = tool_finder('riscv64-unknown-elf-', args.rv_as)
    if rv_tool:
        ran += 1
        rc = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(TMP, 'start_rv.s'),
                    '-o', os.path.join(TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('FAIL rv start stub: ' + rc.stderr.strip()[:200])
            r.failed += 1
        for name, body, targets in CASES:
            if 'rv' not in targets.split():
                continue
            src = os.path.join(TMP, 'rv_' + name + '.c')
            head = PRELUDE + (PRELUDE_64I if name in RV64_CASES else '')
            write(src, head + '\nint main(void)\n{\n    ' + body + '\n}\n')
            exp, err = r.oracle(src, os.path.join(TMP, 'rv_' + name + '_gcc.exe'))
            if exp is None:
                print('SKIP rv/%-9s no gcc oracle: %s' % (name, err.strip()[:80]))
                r.failed += 1
                continue
            got, err = r.rv('rv_' + name, src, rv_tool)
            if got is None:
                print('FAIL rv/%-9s %s' % (name, err.strip()[:200]))
                r.failed += 1
            elif got != exp:
                print('FAIL rv/%-9s rv=%d expected=%d' % (name, got, exp))
                r.failed += 1
            else:
                pk, pkfn = frame_peak(os.path.join(TMP, 'rv_' + name + '.s'), 'rv')
                if pk is not None and pk > FRAME_CAP:
                    print('FAIL rv/%-9s frame %d B in %s > %d (a variadic frame '
                          'must stay small)' % (name, pk, pkfn, FRAME_CAP))
                    r.failed += 1
                else:
                    print('PASS rv/%-9s %d' % (name, got))
                    r.passed += 1
        for name, body, want, extra in REFUSE:
            src = os.path.join(TMP, 'rv_' + name + '.c')
            head = PRELUDE + (LL_SNIPPET if extra == 'll' else '')
            if extra == 'struct':
                head = PRELUDE + STRUCT_SNIPPET
            write(src, head + '\nint main(void)\n{\n    ' + body + '\n}\n')
            rc = r.run([ARKC, '-target', 'riscv32', '-S', '-I', INC, src,
                        '-o', os.path.join(TMP, 'rv_' + name + '.s')])
            msg = rc.stdout + rc.stderr
            if rc.returncode != 0 and want in msg:
                print('PASS rv/%-9s refused' % name)
                r.passed += 1
            else:
                print('FAIL rv/%-9s expected a refusal (%r), rc=%d'
                      % (name, want, rc.returncode))
                r.failed += 1
    else:
        print('SKIP rv: no riscv64-unknown-elf toolchain (set --rv-as / ARKCC_RV_AS)')

    print('\n%d passed, %d failed, %d target(s) run' % (r.passed, r.failed, ran))
    if ran == 0:
        return 2
    return 0 if r.failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
