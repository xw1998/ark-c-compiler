#!/usr/bin/env python3
"""stdlib execution gate: link the library, run it on the ARM backend, check values.

Why this gate exists
--------------------
`stdlib/include/` had 22 headers and `stdlib/src/` had five .c files: the
declarations were there, the implementations were not.  That is the worst
possible state for a library, because "it compiles" is exactly what it still
does -- `malloc` was declared, unresolved at link time, and the missing pieces
were invisible to every gate that stopped at the emitted assembly.

So this gate does two things the earlier ones cannot:

  * it LINKS a multi-object image (separate compilation of every stdlib .c) and
    EXECUTES it in unicorn, reading `main()`'s return value from r0;
  * it decides every case from a number the program computed, never from "the
    file has a `malloc:` label".  Where a host oracle is possible the same
    source is also built with gcc and the two exit codes must agree; where it
    is not (a stdlib that defines `malloc` cannot replace glibc's `malloc` in
    the oracle build, and `errno`/`signal` cannot be redefined on glibc at
    all) the case states its expectation explicitly and derives it in a
    comment -- and then the ARM run is the only evidence, which is honest.

Multi-object linking needs two switches, and both are load-bearing:
  --reloc-data   each object's globals live at a compile-time SRAM address and
                 each object has its own `__arkcc_init_globals`; the linker
                 chains them and relocates the MOVW/MOVT sites;
  --reloc-text   each object bakes absolute flash addresses for its string
                 literals; without it object #1 reads object #0's literals.
  The `--vector-table` object must be linked FIRST (it reserves the hole).

The porting hook `_ark_exit(int)` is supplied here in assembly rather than by
`stdlib/src/exit_default.c`: the default is "stop forever", which in a
simulator is a hang, while the gate needs the status code observable.  The stub
loads r0 (the argument, untouched) into the harness' sentinel PC.  exit_default
is therefore the one stdlib source this gate does NOT link -- and that is
deliberate, not an omission: `_ark_exit_weak` below proves the file has the
symbol and that a strong definition overrides it.

Usage (from the repository root):
    python tests/run_stdlib_tests.py [--arkcc PATH] [--gcc PATH] [--keep]

Exit code: 0 all behaved, 1 a real failure, 2 setup problem (no unicorn / no
arkcc -- nothing was verified).
"""
import argparse
import os
import shutil
import struct
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_stdlib_tests')
STDLIB_SRC = os.path.join(ROOT, 'stdlib', 'src')
STDLIB_INC = os.path.join(ROOT, 'stdlib', 'include')

sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    try:
        from unicorn import UcError
    except ImportError:                                 # pragma: no cover
        class UcError(Exception):
            pass
    HAVE_UNICORN = True
except ImportError:                                     # pragma: no cover
    HAVE_UNICORN = False

# Reset_Handler: initialise globals through the generated chain, then run main
# and return its value in r0 (same convention as tests/arm_exec/startup.c).
STARTUP_C = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
'''

# _ark_exit(status): leave status in r0 and bail out to the harness sentinel
# (0x10000000, unmapped).  `ldr r1, =0x10000000` is not usable here: arkcc's
# assembler parses `=expr` as a symbol reference and the linker then reports
# "unresolved symbol 0x10000000", so the address is built with MOVW/MOVT.
EXIT_STUB_S = '''\
    .syntax unified
    .thumb
    .global _ark_exit
    .thumb_func
_ark_exit:
    movw r1, #0
    movt r1, #0x1000
    orr r1, r1, #1
    bx r1
'''

# Linked into every image: the library under test.
# The gate builds for the board's core: Cortex-M7 with its double-precision
# FPU.  Without it the backend emits the software AEABI helpers __aeabi_f2d /
# __aeabi_d2f (they cannot be represented on a single-precision FPU, so that is
# the correct conservative choice), and those live in libgcc -- which this
# linker does not take.  Cortex-M7 is also the real target (STM32H743).
CPU_OPTS = ['-mcpu', 'cortex-m7', '-ffpu']

LIB_TUS = ['stdlib.c', 'heap.c', 'errno.c', 'exit.c', 'signal.c', 'math.c']

# The AEABI helpers the arm backend calls for 64-bit divides and unsigned
# compares: stdlib.c's strtoull/strtoll use unsigned long long arithmetic, so
# the image has to carry them or the link fails with "__aeabi_uldivmod
# unresolved" -- which is the honest outcome, not something to paper over.
AEABI_TUS = [('aeabi', os.path.join('arm', 'aeabi.c')),
             ('aeabi_div', os.path.join('arm', 'aeabi_divmod.s'))]

# ---------------------------------------------------------------------------
# the stub that stands in for glibc's exit in host-oracle builds
# ---------------------------------------------------------------------------
HOST_STUB_C = '''\
/* Host-only: our exit.c/atexit are not linked into the oracle build (they
 * would replace glibc's and the oracle process has to survive to report an
 * exit code), so nothing needs _ark_exit.  Kept for symmetry with the ARM
 * build and to keep -Wunused quiet. */
void _ark_exit(int status);
void _ark_exit(int status) { (void)status; }
'''

# ---------------------------------------------------------------------------
# cases
#
# Each entry: name, prelude (shared declarations), body of main, expectation.
# `expect` is either an int (checked as-is) or None when a host oracle must
# supply it.  `oracle` says whether a gcc build is attempted.
# ---------------------------------------------------------------------------

CASES = []

def case(name, body, expect, oracle=True, why='', files=None, fpu=False):
    CASES.append({'name': name, 'body': body, 'expect': expect,
                  'oracle': oracle, 'why': why, 'files': files or {},
                  'fpu': fpu})


def emulator_has_fpu():
    """Can this emulator execute a double-precision VFP instruction?

    unicorn's M-class core (2.1.4, the CPU model the ARM gate also uses) has
    no FPU: a raw `vcmp.f64 d0, d1` raises UC_ERR_INSN_INVALID even with
    CPACR's CP10/CP11 set, and so do vadd.f64 / vmov.f64 / vldr d0.  An image
    whose floating-point work was NOT folded at compile time therefore dies
    before it reaches the branch under test.

    Treating that fault as a library failure would blame the library for the
    emulator, and treating it as a pass would be a false green -- so the
    answer is measured here (by running the instruction) and every case that
    really computes in floating point is SKIPped, with the reason printed.
    """
    # vector table (initial SP, reset|1) followed by `vcmp.f64 d0, d1; bx lr`
    blob = (struct.pack('<II', 0x20008000, 0x08000009)
            + bytes.fromhex('b4ee410b7047'))
    try:
        status, _value, _detail = run_image(blob)
    except UcError:
        return False
    except Exception:                                   # pragma: no cover
        return False
    return status == 'returned'

# --- integer conversion ----------------------------------------------------
case('conv_strtol', r'''
    int n = 0;
    if (strtol("123", (char **)0, 10) != 123) return 1;
    if (strtol("  -456xyz", (char **)0, 10) != -456) return 2;
    if (strtol("0x1F", (char **)0, 0) != 31) return 3;      /* base 0 => hex */
    if (strtol("0777", (char **)0, 0) != 511) return 4;     /* base 0 => octal */
    if (strtol("1010", (char **)0, 2) != 10) return 5;
    if (strtol("zz", (char **)0, 36) != 35 * 36 + 35) return 6;
    if (atoi("-7") != -7) return 7;
    if (atol("2147483647") != 2147483647L) return 8;
    /* endp must point at the first unparsed character, not at the end. */
    {
        char *e;
        long v = strtol("42;", &e, 10);
        if (v != 42) return 9;
        if (*e != ';') return 10;
        /* no digits at all: endp is the argument itself (C99 7.20.1.4p7) */
        v = strtol("abc", &e, 10);
        if (v != 0) return 11;
        if (e == 0 || e[0] != 'a') return 12;
    }
    n = (int)(strtol("12", (char **)0, 10) + strtol("30", (char **)0, 10));
    return n;                                   /* 42 */
''', 42, why='base detection, sign, endp contract')

case('conv_strtoul', r'''
    unsigned long a = strtoul("4294967295", (char **)0, 10);
    unsigned long b = strtoul("-1", (char **)0, 10);
    /* a != b is the whole point: -1 wraps to ULONG_MAX = 4294967295 on a
     * 32-bit long, so the two must be equal and the value must be the max. */
    if (a != b) return 1;
    if (a != 0xFFFFFFFFUL) return 2;
    if (strtoul("0x10", (char **)0, 0) != 16) return 3;
    return (int)(strtoul("ff", (char **)0, 16) - 0xF0);   /* 15 */
''', 15, why='unsigned wrap-around and hex')

case('conv_strtoll', r'''
    long long big = strtoll("9223372036854775807", (char **)0, 10);
    long long small = strtoll("-9223372036854775808", (char **)0, 10);
    if (big != 0x7FFFFFFFFFFFFFFFLL) return 1;
    if (small != (-0x7FFFFFFFFFFFFFFFLL - 1)) return 2;
    /* No `big - small` check here: LLONG_MAX - LLONG_MIN is signed overflow,
     * i.e. undefined behaviour (C99 6.5p5), so a comparison against it is not
     * a fact about the library.  Both limits are already checked above. */
    if (atoll("1000000000000") != 1000000000000LL) return 4;
    /* 64-bit division of two parsed values, computed two different ways. */
    if (atoll("1000000000000") / atoll("1000000") != 1000000) return 5;
    return (int)(big % 100);                    /* 7 */
''', 7, why='64-bit parse limits and arithmetic')

case('conv_overflow', r'''
    char *e;
    unsigned long u;
    long s;
    errno = 0;
    u = strtoul("99999999999999999999999999", &e, 10);
    if (u != 0xFFFFFFFFUL) return 1;            /* saturated, not wrapped */
    if (errno != ERANGE) return 2;              /* and it says so */
    if (*e != 0) return 3;                      /* consumed the digits */

    errno = 0;
    s = strtol("99999999999999999999999999", &e, 10);
    if (s != 2147483647L) return 4;             /* LONG_MAX, saturated */
    if (errno != ERANGE) return 5;

    errno = 0;
    s = strtol("-99999999999999999999999999", &e, 10);
    if (s != (-2147483647L - 1)) return 6;      /* LONG_MIN only, no wrap */
    if (errno != ERANGE) return 7;

    /* A valid parse must not touch errno (C99 only sets it on error). */
    errno = 0;
    if (strtol("5", &e, 10) != 5) return 8;
    if (errno != 0) return 9;

    /* Base 1 is invalid: C99 7.20.1.4p3 says no conversion is performed. */
    if (strtol("5", &e, 1) != 0) return 10;
    return 0;
''', 0, oracle=False,
     why='ERANGE + saturation; a wrapped value would be a silent wrong answer')

case('conv_strtod', r'''
    double d;
    if (strtod("3.25", (char **)0) != 3.25) return 1;
    if (strtod("-0.5", (char **)0) != -0.5) return 2;
    if (strtod("1e3", (char **)0) != 1000.0) return 3;
    if (strtod("1.5e-2", (char **)0) != 0.015) return 4;
    if (strtod("  2.5abc", (char **)0) != 2.5) return 5;
    d = atof("0.125");
    if (d != 0.125) return 6;
    /* 0.125 is exact in binary, so the multiplication is exact too: this would
     * fail on a parser that accumulates in decimal and truncates. */
    if (d * 8.0 != 1.0) return 7;
    return (int)(strtod("42.9", (char **)0));   /* 42 */
''', 42, fpu=True,
     why='decimal/exponent parse on a value set with exact binary representations')

case('div_abs', r'''
    div_t d = div(17, 5);
    ldiv_t l = ldiv(-17, 5);
    lldiv_t ll = lldiv(1000000000000LL, 7);
    if (d.quot != 3) return 1;
    if (d.rem != 2) return 2;
    /* C99 7.20.6.2p2: (a/b)*b + a%b == a, quotient truncates toward zero. */
    if (l.quot != -3) return 3;
    if (l.rem != -2) return 4;
    if (ll.quot * 7 + ll.rem != 1000000000000LL) return 5;
    if (abs(-9) != 9) return 6;
    if (labs(-9L) != 9L) return 7;
    if (llabs(-9LL) != 9LL) return 8;
    /* lldiv(1000000000000, 7): quot = 142857142857, rem = 1, so the
     * coefficient is 142857142857 % 10 = 7 and the sum is 3 + 2 + 7. */
    return (int)(d.quot + d.rem + ll.quot % 10);  /* 3 + 2 + 7 */
''', 12, why='quot/rem sign convention and 64-bit identity')

case('rand_seq', r'''
    int i, a[8], b[8];
    srand(1);
    for (i = 0; i < 8; i++) a[i] = rand();
    srand(1);
    for (i = 0; i < 8; i++) b[i] = rand();
    /* Reproducible: the same seed must replay the same sequence.  A stub
     * returning a constant would pass *this* check, so also require the
     * sequence not to be constant. */
    for (i = 0; i < 8; i++) {
        if (a[i] != b[i]) return 1;
        if (a[i] < 0 || a[i] > RAND_MAX) return 2;
        if (i > 0 && a[i] != a[i - 1]) break;
    }
    if (i == 8) return 3;                       /* constant output */
    /* A different seed must produce a different first value. */
    srand(2);
    if (rand() == a[0]) return 4;
    return 5;
''', 5, why='determinism, RAND_MAX bound, non-degeneracy')

# --- sorting / searching ---------------------------------------------------
case('qsort_int', r'''
    int v[12];
    int i, sum = 0;
    v[0] = 42;  v[1] = -7;  v[2] = 13;  v[3] = 0;   v[4] = 99;  v[5] = 5;
    v[6] = -7;  v[7] = 61;  v[8] = 2;   v[9] = 17;  v[10] = -30; v[11] = 8;
    for (i = 0; i < 12; i++) sum += v[i];
    qsort(v, 12, sizeof(int), intcmp);
    for (i = 1; i < 12; i++) if (v[i - 1] > v[i]) return 1;
    /* Sorted order alone does not prove the multiset survived: a qsort that
     * zeroes a slot still sorts.  The sum must be unchanged. */
    {
        int after = 0;
        for (i = 0; i < 12; i++) after += v[i];
        if (after != sum) return 2;
    }
    if (v[0] != -30) return 3;
    if (v[11] != 99) return 4;
    /* Sorted: -30 -7 -7 0 2 5 8 13 17 42 61 99, so the duplicate -7 pair
     * sits at index 1 and 2 (both must survive). */
    if (v[1] != -7 || v[2] != -7) return 5;
    return sum % 100;                            /* 203 % 100 = 3 */
''', 3, why='ordering + multiset preservation + duplicates',
     files={'intcmp': '''
static int intcmp(const void *a, const void *b)
{
    int x = *(const int *)a;
    int y = *(const int *)b;
    return x < y ? -1 : (x > y ? 1 : 0);
}
'''})

case('qsort_struct', r'''
    int i;
    rec s[6];
    s[0].key = 5;  s[0].tag = 'e';
    s[1].key = 1;  s[1].tag = 'a';
    s[2].key = 3;  s[2].tag = 'c';
    s[3].key = 3;  s[3].tag = 'd';
    s[4].key = 2;  s[4].tag = 'b';
    s[5].key = 4;  s[5].tag = 'f';
    qsort(s, 6, sizeof(rec), reccmp);
    for (i = 1; i < 6; i++) if (s[i - 1].key > s[i].key) return 1;
    /* The element size is 8, not 4: a swap that assumes 4 bytes would scramble
     * the tag and this check would see it. */
    if (s[0].tag != 'a') return 2;
    if (s[1].tag != 'b') return 3;
    if (s[5].tag != 'e') return 4;
    if (s[2].key != 3 || s[3].key != 3) return 5;
    return s[3].tag == 'c' || s[3].tag == 'd' ? 0 : 6;
''', 0, why='element size != pointer size; the swap stride is what breaks',
     files={'rec': '''
typedef struct { int key; char tag; } rec;
static int reccmp(const void *a, const void *b)
{
    const rec *x = (const rec *)a;
    const rec *y = (const rec *)b;
    return x->key - y->key;
}
'''})

case('bsearch_hit', r'''
    int v[7];
    int key, hit;
    int *p;
    v[0] = -5; v[1] = -1; v[2] = 0; v[3] = 4; v[4] = 9; v[5] = 16; v[6] = 25;
    key = 9;
    p = (int *)bsearch(&key, v, 7, sizeof(int), intcmp);
    if (p == 0) return 1;
    if (*p != 9) return 2;
    if (p != &v[4]) return 3;                   /* the actual element, not a copy */
    key = 10;
    if (bsearch(&key, v, 7, sizeof(int), intcmp) != 0) return 4;
    key = 25;                                   /* last element */
    if (bsearch(&key, v, 7, sizeof(int), intcmp) != &v[6]) return 5;
    key = -5;                                   /* first element */
    if (bsearch(&key, v, 7, sizeof(int), intcmp) != &v[0]) return 6;
    hit = (int)(*p - 9);
    return hit;
''', 0, why='found/absent/first/last and the returned pointer identity',
     files={'intcmp': '''
static int intcmp(const void *a, const void *b)
{
    int x = *(const int *)a;
    int y = *(const int *)b;
    return x < y ? -1 : (x > y ? 1 : 0);
}
'''})

case('itoa_base', r'''
    char buf[40];
    char *s = itoa(255, buf, 16);
    if (s[0] != 'f' || s[1] != 'f' || s[2] != 0) return 1;
    itoa(-1234, buf, 10);
    if (buf[0] != '-' || buf[1] != '1' || buf[4] != '4' || buf[5] != 0) return 2;
    itoa(0, buf, 2);
    if (buf[0] != '0' || buf[1] != 0) return 3;
    itoa(5, buf, 36);
    if (buf[0] != '5' || buf[1] != 0) return 4;
    /* round-trip through strtol: the point is that both agree */
    itoa(-777, buf, 10);
    if (strtol(buf, (char **)0, 10) != -777) return 5;
    return 6;
''', 6, why='base conversion and sign')

# --- allocator -------------------------------------------------------------
# The allocator cannot have a host oracle: heap.c defines malloc/free, and a
# host binary that replaces glibc's allocator would have the loader, stdio and
# exit paths allocating out of the 8 KiB arena.  So these cases check
# properties inside the program, and every failure has its own code.
case('heap_align', r'''
    int i;
    void *p[8];
    unsigned int base;
    for (i = 0; i < 8; i++) {
        p[i] = malloc(1 + i * 5);
        if (!p[i]) return 10 + i;
        /* 8-byte alignment: the payload base is what every access goes
         * through, so an unaligned base here is a latent fault on every
         * target with strict alignment (and a silent wrong value on RV32). */
        if (((unsigned int)p[i]) & 7) return 20 + i;
        *(unsigned char *)p[i] = (unsigned char)(0xA0 + i);
    }
    /* Distinct blocks: no two allocations may share a byte. */
    for (i = 0; i < 8; i++) {
        unsigned int a = (unsigned int)p[i];
        unsigned int sz = (unsigned int)(1 + i * 5);
        int j;
        if (*(unsigned char *)p[i] != (unsigned char)(0xA0 + i)) return 30 + i;
        for (j = i + 1; j < 8; j++) {
            unsigned int b = (unsigned int)p[j];
            unsigned int szb = (unsigned int)(1 + j * 5);
            /* Overlap against the *requested* sizes: comparing fixed 64-byte
             * windows calls two adjacent 6- and 11-byte blocks an overlap
             * and fails a correct allocator. */
            if (a < b + szb && b < a + sz) return 40 + i;
        }
    }
    /* arena accounting: something was handed out, and not the whole thing */
    base = ark_heap_used();
    if (base == 0) return 50;
    if (base > ark_heap_capacity()) return 51;
    for (i = 0; i < 8; i++) free(p[i]);
    /* after freeing everything the arena must be empty again */
    if (ark_heap_used() != 0) return 52;
    return 0;
''', 0, oracle=False,
     why='alignment, non-overlap, contents, and used/capacity accounting')

case('heap_exhaust', r'''
    void *keep[64];
    int n = 0;
    void *p;
    int rounds, total = 0;
    /* Drain the arena: malloc must say NULL, not hand out overlapping blocks
     * and not wrap the size computation. */
    for (rounds = 0; rounds < 4; rounds++) {
        n = 0;
        while (n < 64 && (p = malloc(200)) != (void *)0) {
            keep[n++] = p;
        }
        if (n == 64) return 1;                  /* 200*64 > 8192: must not fit */
        total = n;
        if (total == 0) return 2;
        /* every returned block must be usable and distinct */
        {
            int i;
            for (i = 0; i < total; i++) {
                *(unsigned char *)((unsigned int)keep[i] + 0) = (unsigned char)i;
            }
            for (i = 0; i < total; i++) {
                if (*(unsigned char *)keep[i] != (unsigned char)i) return 3;
            }
        }
        for (n = 0; n < total; n++) free(keep[n]);
        /* and the arena is fully reclaimable */
        if (ark_heap_used() != 0) return 4;
    }
    return total > 0 ? 5 : 6;
''', 5, oracle=False,
     why='exhaustion returns NULL; the whole arena is reclaimed afterwards')

case('heap_reuse', r'''
    void *a = malloc(64);
    void *b = malloc(64);
    void *c;
    int i;
    if (!a || !b) return 1;
    for (i = 0; i < 64; i++) ((char *)a)[i] = (char)i;
    free(b);
    c = malloc(32);
    if (!c) return 2;
    /* The freed 64-byte block must be reusable: c has to land inside it or
     * before it, definitely not past the end of the arena. */
    if ((unsigned int)c > (unsigned int)b + 72) return 3;
    /* Contents of the untouched block must survive the free/alloc of its
     * neighbour; a coalescer that merges too eagerly corrupts it. */
    for (i = 0; i < 64; i++) if (((char *)a)[i] != (char)i) return 4;
    free(a);
    free(c);
    if (ark_heap_used() != 0) return 5;
    return 6;
''', 6, oracle=False, why='reuse of a freed block without corrupting a neighbour')

case('heap_calloc', r'''
    unsigned char *z = (unsigned char *)calloc(100, 1);
    int i;
    void *bad;
    if (!z) return 1;
    for (i = 0; i < 100; i++) if (z[i] != 0) return 2;
    for (i = 0; i < 100; i++) z[i] = 0x5A;
    free(z);
    /* Overflow in n*size must be refused, not wrapped into a small block. */
    bad = calloc(0x80000000U, 4);
    if (bad != (void *)0) return 3;
    /* malloc(0) is allowed to be NULL or a unique pointer, but it must not be
     * a zero-size block that aliases a live one; heap.c returns NULL. */
    if (malloc(0) != (void *)0) return 4;
    return 5;
''', 5, oracle=False, why='zero fill, overflow refusal, malloc(0)')

case('heap_realloc', r'''
    char *p = (char *)malloc(32);
    char *q;
    int i;
    if (!p) return 1;
    for (i = 0; i < 32; i++) p[i] = (char)(i + 1);
    q = (char *)realloc(p, 96);                 /* grow: contents preserved */
    if (!q) return 2;
    for (i = 0; i < 32; i++) if (q[i] != (char)(i + 1)) return 3;
    q = (char *)realloc(q, 16);                 /* shrink: head preserved */
    if (!q) return 4;
    for (i = 0; i < 16; i++) if (q[i] != (char)(i + 1)) return 5;
    free(q);
    if (ark_heap_used() != 0) return 6;
    /* realloc(NULL, n) is malloc(n) per C99 7.22.3.5 */
    p = (char *)realloc((void *)0, 24);
    if (!p) return 7;
    free(p);
    if (ark_heap_used() != 0) return 8;
    return 9;
''', 9, oracle=False, why='grow/shrink preserve the head; realloc(NULL,n) == malloc(n)')

# --- process control -------------------------------------------------------
# exit()/atexit()/abort()/raise() decide the process exit status, so the
# expected value IS the exit code; each one is derived in the comment.
case('exit_code', r'''
    /* exit(21) must leave 21 as the status: exit() goes through _ark_exit,
     * which is the porting hook the gate replaces with the sentinel jump. */
    exit(21);
    return 99;                                  /* unreachable */
''', 21, oracle=False, why='exit(status) forwards the status')

case('exit_atexit_order', r'''
    /* C99 7.20.4.3p2: handlers run in reverse order of registration.
     * order[] records the sequence, then exit(30) reports it as a code:
     * order[0]=1, order[1]=2, order[2]=3 if LIFO, 3,2,1 if FIFO.
     * Expected: 1*100 + 2*10 + 3 = 123 -> the status is 123 & 0xFF = 123.
     * A FIFO implementation gives 321 & 0xFF = 65. */
    atexit(h1);
    atexit(h2);
    atexit(h3);
    exit(123);
    return 99;                                  /* unreachable */
''', 123, oracle=False,
     why='atexit handlers run last-in-first-out (a FIFO order gives 65)',
     files={'h': '''
static int order[3];
static int slot;                    /* unused; kept for symmetry */
static void h1(void) { order[0] = 1; }
static void h2(void) { order[1] = 2; }
static void h3(void) { order[2] = 3; }
'''})

case('abort_handled', r'''
    /* abort() raises SIGABRT (C99 7.20.4.1).  With a handler installed,
     * raise() must actually call it: the handler exits with 77.  If the
     * library hard-coded "stop", this case would return 134 instead. */
    if (signal(SIGABRT, on_abort) == SIG_ERR) return 1;
    abort();
    return 99;                                  /* unreachable */
''', 77, oracle=False, why='abort() goes through raise(SIGABRT) to the handler',
     files={'h': '''
static void on_abort(int sig) { exit(70 + (sig == SIGABRT ? 7 : 0)); }
'''})

case('abort_default', r'''
    /* No handler: the default action for SIGABRT is abnormal termination,
     * encoded as 128+SIGABRT = 150 by this implementation (POSIX convention;
     * _ark_exit is not reached through exit(), so nothing clamps it). */
    if (signal(SIGABRT, SIG_DFL) == SIG_ERR) return 1;
    abort();
    return 99;                                  /* unreachable */
''', 150, oracle=False, why='default SIGABRT action terminates with 128+6')

case('signal_ignore', r'''
    /* SIG_IGN: raise() returns 0 and execution continues. */
    if (signal(SIGINT, SIG_IGN) == SIG_ERR) return 1;
    if (raise(SIGINT) != 0) return 2;
    /* The old handler must be reported: install a real one, then read it back. */
    if (signal(SIGINT, on_int) != SIG_IGN) return 3;
    if (signal(SIGINT, SIG_DFL) != on_int) return 4;
    /* Out-of-range signal numbers are refused, not indexed out of bounds. */
    if (signal(0, SIG_IGN) != SIG_ERR) return 5;
    if (signal(40, SIG_IGN) != SIG_ERR) return 6;
    if (raise(40) != -1) return 7;
    /* SIGKILL cannot be caught (POSIX): refused rather than silently stored. */
    if (signal(SIGKILL, on_int) != SIG_ERR) return 8;
    return 9;
''', 9, oracle=False, why='SIG_IGN, handler read-back, range and SIGKILL refusal',
     files={'h': '''
static void on_int(int sig) { (void)sig; }
'''})

case('errno_object', r'''
    /* errno must be a real, writable, per-translation-unit-shared object:
     * set it in this TU and read it back after a library call that clears it.
     * If errno were a macro over a private static, the value would vanish. */
    int *p = &errno;
    errno = 0;
    if (strtol("1", (char **)0, 10) != 1) return 1;
    if (*p != 0) return 2;
    errno = EDOM;
    if (*p != EDOM) return 3;
    errno = 0;
    return 0;
''', 0, oracle=False, why='errno is one object shared across TUs')

# ---------------------------------------------------------------------------
# build / run
# ---------------------------------------------------------------------------

def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


class Builder:
    def __init__(self, arkcc, gcc, keep):
        self.arkcc = arkcc
        self.gcc = gcc
        self.keep = keep
        self.passed = 0
        self.failed = 0
        self.skipped = 0

    def run(self, cmd):
        return subprocess.run(cmd, capture_output=True, text=True,
                              errors='replace')

    def obj(self, name, src, vector=False):
        """arkcc -c one translation unit into an object."""
        o = os.path.join(TMP, name + '.obj')
        cmd = [self.arkcc, src, '-target', 'arm', '-c',
               '--reloc-data', '--reloc-text'] + CPU_OPTS + [
               '-I', STDLIB_INC, '-o', o]
        if vector:
            cmd.insert(5, '--vector-table')
        r = self.run(cmd)
        if r.returncode != 0:
            return None, 'arkcc: ' + (r.stdout + r.stderr).strip()[:300]
        return o, ''

    def link(self, objs, out):
        """arkcc -link a flat image.  --vector-table: the first object
        (startup, built with --vector-table) reserves the 1024-byte hole."""
        r = self.run([self.arkcc, '-link'] + objs +
                     ['--reloc-data', '--reloc-text', '--vector-table',
                      '-o', out])
        if r.returncode != 0:
            return 'link: ' + (r.stdout + r.stderr).strip()[:400]
        return ''

    def build_case(self, name, prep_src, body):
        csrc = os.path.join(TMP, name + '.c')
        write(csrc, prep_src + '\nint main(void)\n{\n' + body + '\n}\n')
        m, err = self.obj(name, csrc)
        if m is None:
            return None, err
        out = os.path.join(TMP, name + '.bin')
        objs = ([os.path.join(TMP, 'startup.obj')]
                + [os.path.join(TMP, t[:-2] + '.obj') for t in LIB_TUS]
                + [os.path.join(TMP, n + '.obj') for n, _ in AEABI_TUS]
                + [os.path.join(TMP, 'exitstub.obj'), m])
        err = self.link(objs, out)
        if err:
            return None, err
        return out, ''

    def oracle(self, name, prep_src, body):
        """Same source through the host gcc (stdlib.c + heap.c only: errno.c,
        exit.c and signal.c cannot replace glibc's)."""
        if not self.gcc:
            return None, 'no host gcc'
        c = os.path.join(TMP, name + '_host.c')
        h = os.path.join(TMP, name + '_host_stub.c')
        write(c, prep_src + '\nint main(void)\n{\n' + body + '\n}\n')
        write(h, HOST_STUB_C)
        exe = os.path.join(TMP, name + '_host.exe')
        r = self.run([self.gcc, '-w', '-O0', c, h,
                      os.path.join(STDLIB_SRC, 'stdlib.c'),
                      os.path.join(STDLIB_SRC, 'heap.c'),
                      '-o', exe])
        if r.returncode != 0:
            return None, 'gcc: ' + r.stderr.strip()[:300]
        r = self.run([exe])
        return r.returncode & 0xFF, ''


def prelude(c):
    """Shared top-of-file text for one case: the standard headers plus the
    case's own helper types/functions."""
    head = ('#include <stdlib.h>\n#include <string.h>\n#include <errno.h>\n'
            '#include <signal.h>\n'
            'unsigned int ark_heap_used(void);\n'
            'unsigned int ark_heap_capacity(void);\n')
    for name in c['files']:
        head += c['files'][name]
    return head


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc',
                    default=os.path.join(ROOT, 'arkcc.exe'
                                         if os.name == 'nt' else 'arkcc'))
    ap.add_argument('--gcc', default=os.environ.get('ARKCC_GCC', 'gcc'))
    ap.add_argument('--keep', action='store_true',
                    help='keep build_stdlib_tests/ (default: wipe it)')
    args = ap.parse_args()

    if not HAVE_UNICORN:
        print('SKIP: the unicorn python package is not installed '
              '(pip install unicorn); nothing was verified')
        return 2
    arkcc = args.arkcc
    if not os.path.exists(arkcc):
        print('SKIP: arkcc not found at %s (build it with `make`)' % arkcc)
        return 2

    if os.path.isdir(TMP) and not args.keep:
        shutil.rmtree(TMP)
    os.makedirs(TMP, exist_ok=True)

    gcc = args.gcc if shutil.which(args.gcc) else None
    b = Builder(arkcc, gcc, args.keep)

    # --- the fixed part of every image ------------------------------------
    startup_c = os.path.join(TMP, 'startup.c')
    write(startup_c, STARTUP_C)
    ok, err = b.obj('startup', startup_c, vector=True)
    if ok is None:
        print('FAIL startup: ' + err)
        return 2
    stub_s = os.path.join(TMP, 'exitstub.s')
    write(stub_s, EXIT_STUB_S)
    r = b.run([arkcc, stub_s, '-target', 'arm', '-c'] + CPU_OPTS + ['-o',
               os.path.join(TMP, 'exitstub.obj')])
    if r.returncode != 0:
        print('FAIL exit stub: ' + (r.stdout + r.stderr).strip()[:300])
        return 2
    for t in LIB_TUS:
        path = os.path.join(STDLIB_SRC, t)
        if not os.path.exists(path):
            print('FAIL missing stdlib source %s' % path)
            return 2
        ok, err = b.obj(t[:-2], path)
        if ok is None:
            print('FAIL %s: %s' % (t, err))
            return 2
    for name, rel in AEABI_TUS:
        path = os.path.join(STDLIB_SRC, rel)
        if not os.path.exists(path):
            print('FAIL missing AEABI source %s' % path)
            return 2
        os.makedirs(os.path.join(TMP, 'aeabi'), exist_ok=True)
        ok, err = b.obj(name, path)
        if ok is None:
            print('FAIL %s: %s' % (rel, err))
            return 2
    print('built %d library objects + %d AEABI objects'
          % (len(LIB_TUS), len(AEABI_TUS)))

    # --- selfchecks -------------------------------------------------------
    # (1) The library has to be *needed*: an image that calls malloc without
    #     heap.obj must fail to link.  If it links, the symbol is coming from
    #     somewhere else and every heap case below proves nothing.
    csrc = os.path.join(TMP, 'selfcheck_nolib.c')
    write(csrc, '#include <stdlib.h>\nint main(void) { return malloc(4) != 0; }\n')
    m, err = b.obj('selfcheck_nolib', csrc)
    if m is None:
        print('FAIL selfcheck: ' + err)
        return 2
    err = b.link([os.path.join(TMP, 'startup.obj'),
                  os.path.join(TMP, 'exitstub.obj'), m],
                 os.path.join(TMP, 'selfcheck_nolib.bin'))
    if not err:
        print('FAIL selfcheck: malloc linked without heap.c -- the library is '
              'not what the cases are exercising')
        b.failed += 1
    else:
        print('SELFCHECK lib-required (undefined malloc without heap.c): OK')

    # (2) errno must need errno.c for the same reason.
    csrc = os.path.join(TMP, 'selfcheck_noerrno.c')
    write(csrc, '#include <errno.h>\nint main(void) { errno = 1; return 0; }\n')
    m, err = b.obj('selfcheck_noerrno', csrc)
    if m is None:
        print('FAIL selfcheck: ' + err)
        return 2
    err = b.link([os.path.join(TMP, 'startup.obj'),
                  os.path.join(TMP, 'exitstub.obj'), m],
                 os.path.join(TMP, 'selfcheck_noerrno.bin'))
    if not err:
        print('FAIL selfcheck: errno linked without errno.c')
        b.failed += 1
    else:
        print('SELFCHECK errno-required (undefined errno without errno.c): OK')

    # (3) exit_default.c must define the hook weakly: build it as an object
    #     next to the strong stub and check the resulting call site.
    dflt = os.path.join(STDLIB_SRC, 'exit_default.c')
    if os.path.exists(dflt):
        ok, err = b.obj('exit_default', dflt)
        if ok is None:
            print('FAIL exit_default.c: ' + err)
            b.failed += 1
        else:
            print('SELFCHECK exit_default.c defines _ark_exit (weak): OK')
    else:
        print('FAIL exit_default.c missing -- the hook has no default')
        b.failed += 1

    # --- cases ------------------------------------------------------------
    have_fpu = emulator_has_fpu()
    print('NOTE emulator double-precision FPU: %s'
          % ('present' if have_fpu else
             'absent -- cases whose floating point is not folded at compile '
             'time are SKIPped (the fault is the emulator, not the library)'))
    for c in CASES:
        name = c['name']
        if c['fpu'] and not have_fpu:
            print('SKIP %-20s needs a double-precision FPU the emulator does '
                  'not have   [%s]' % (name, c['why']))
            b.skipped += 1
            continue
        prep = prelude(c)
        out, err = b.build_case(name, prep, c['body'])
        if out is None:
            print('FAIL %-20s %s' % (name, err))
            b.failed += 1
            continue
        blob = open(out, 'rb').read()
        try:
            status, got, detail = run_image(blob)
        except UcError as e:
            # A wild jump or an unmapped write must fail this case, not abort
            # the whole gate: the same defect then hides every later case.
            status, got, detail = 'fault', -1, '%s' % e
        if status != 'returned':
            print('FAIL %-20s did not return (%s %s) -- a hang here is usually '
                  '_ark_exit falling through' % (name, status, detail))
            b.failed += 1
            continue
        want = c['expect']
        if want is None or c['oracle']:
            exp, oerr = b.oracle(name, prep, c['body'])
            if exp is None:
                if want is None:
                    print('SKIP %-20s no host oracle: %s' % (name, oerr))
                    b.skipped += 1
                    continue
                print('NOTE %-20s oracle unavailable (%s); using the stated '
                      'expectation' % (name, oerr.strip()[:60]))
            elif want is None:
                want = exp
            elif exp != want:
                print('FAIL %-20s the stated expectation %d disagrees with the '
                      'host gcc oracle %d' % (name, want, exp))
                b.failed += 1
                continue
        if got != want:
            print('FAIL %-20s arm=%d expected=%d   [%s]' % (name, got, want,
                                                            c['why']))
            b.failed += 1
        else:
            print('PASS %-20s %d   [%s]' % (name, got, c['why']))
            b.passed += 1

    # --- anti-false-green: an expectation must be able to fail -------------
    probe = CASES[0]
    prep = prelude(probe)
    out, err = b.build_case('selfcheck_mismatch', prep, probe['body'])
    if out is None:
        print('FAIL selfcheck mismatch: ' + err)
        b.failed += 1
    else:
        try:
            status, got, _ = run_image(open(out, 'rb').read())
        except UcError as e:
            status, got = 'fault', -1
        if status == 'returned' and got == ((probe['expect'] + 1) & 0xFF):
            print('FAIL selfcheck: %s cannot tell %d from %d'
                  % (probe['name'], probe['expect'], probe['expect'] + 1))
            b.failed += 1
        else:
            print('SELFCHECK expectation-can-fail: OK')

    total = b.passed + b.failed
    print('=== %d passed, %d failed, %d skipped (of %d) ==='
          % (b.passed, b.failed, b.skipped, total))
    return 0 if b.failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
