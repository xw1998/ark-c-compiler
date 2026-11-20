#!/usr/bin/env python3
"""ARM execution gate: run the machine code arkc emitted, not just look at it.

Why this exists
---------------
`examples/run_tests.ps1` asserts behaviour through the *C* backend (arkcc ->
C -> host gcc -> exit code).  The ARM backend was therefore only ever checked
structurally: "the assembly looks plausible" and "it assembles".  That is
exactly the failure mode this project forbids -- no execution evidence, no
claim -- and it is why `tests/arm_exec/` shipped with a QEMU scatter file but
no QEMU on this machine.

This gate supplies the missing oracle on the host: it loads the raw image arkc
produced into unicorn (a QEMU core), starts it at the reset vector, and reads
the value `main()` returned in r0.  It is a *semantic* check of the encoder,
the code generator and the linker, because the value comes from executing the
bytes.

Conventions (same as tests/arm_exec/startup.c):
  * the image opens with a Cortex-M vector table: [0]=initial SP, [1]=Reset_Handler|1;
  * Reset_Handler calls __arkcc_init_globals(), then main(), and returns its value;
  * the harness sets LR to an unmapped address, so "Reset_Handler returned" is a
    fetch fault rather than a magic instruction.

Usage:
    python tests/arm_exec/run_arm_exec.py [--arkcc PATH] [--keep] [--trace CASE]

Exit code: 0 = every case met its expectation, 1 = a case failed, 2 = setup
problem (no arkcc / no unicorn -- unicorn is optional, see below).

`unicorn` is an optional test dependency (`pip install unicorn`).  When it is
missing the gate reports "skipped" and exits 0: the compiler itself must never
depend on a Python package to build.
"""

import argparse
import os
import shutil
import struct
import subprocess
import sys
import tempfile

try:
    from unicorn import (Uc, UcError, UC_ARCH_ARM, UC_MODE_MCLASS, UC_MODE_THUMB,
                         UC_HOOK_MEM_FETCH_UNMAPPED, UC_PROT_ALL)
    from unicorn.arm_const import (UC_ARM_REG_R0, UC_ARM_REG_SP, UC_ARM_REG_LR)
    HAVE_UNICORN = True
except ImportError:                                    # pragma: no cover
    HAVE_UNICORN = False

FLASH_BASE = 0x08000000
SRAM_BASE = 0x20000000
SRAM_SIZE = 0x00020000          # 128 KiB: the backend's default initial SP
SENTINEL = 0x10000000           # unmapped -> "Reset_Handler returned"


def run_image(blob, max_insn=5000000, sram_fill=None):
    """Execute one raw arkc image.  Returns (status, value, detail).

    sram_fill pre-loads the whole SRAM with a byte pattern before the image
    runs.  A real board powers up with whatever the SRAM cells held, so a
    case that asks for a fill proves the initialiser *writes* every byte it
    claims to define: with a zeroed map (`sram_fill=None`) a byte the init
    body forgot is indistinguishable from a byte it wrote as zero.

    max_insn is a hang guard, not a performance gate: a case whose
    reference value is computed by repeated 64-bit division spends about
    12.8k instructions per division (the backend keeps every intermediate
    on the stack, and the AEABI divider is a 64-iteration restoring loop),
    so those cases declare a larger budget instead of being called fast.
    """
    if len(blob) < 8:
        return "fault", 0, "image shorter than a vector table"
    sp = struct.unpack_from("<I", blob, 0)[0]
    entry = struct.unpack_from("<I", blob, 4)[0]
    if (entry & 1) == 0:
        return "fault", 0, "reset vector has no Thumb bit"

    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
    uc.mem_map(FLASH_BASE, (len(blob) + 0xFFF) & ~0xFFF, UC_PROT_ALL)
    uc.mem_write(FLASH_BASE, blob)
    uc.mem_map(SRAM_BASE, SRAM_SIZE, UC_PROT_ALL)
    if sram_fill is not None:
        uc.mem_write(SRAM_BASE, bytes([sram_fill & 0xFF]) * SRAM_SIZE)

    state = {"status": None, "detail": ""}

    def on_bad_fetch(uc_, access, address, size, value, user):
        if (address & ~1) == SENTINEL:
            state["status"] = "returned"
        else:
            state["status"] = "fault"
            state["detail"] = "fetch from unmapped 0x%08X" % address
        return False

    uc.hook_add(UC_HOOK_MEM_FETCH_UNMAPPED, on_bad_fetch)
    uc.reg_write(UC_ARM_REG_SP, sp)
    uc.reg_write(UC_ARM_REG_LR, SENTINEL | 1)
    try:
        uc.emu_start(entry, 0, count=max_insn)
    except UcError:
        if state["status"] is None:
            raise
    value = uc.reg_read(UC_ARM_REG_R0)
    if state["status"] == "fault":
        return "fault", value, state["detail"]
    if state["status"] == "returned":
        return "returned", value, ""
    return "limit", value, "instruction budget spent"


# --- cases -----------------------------------------------------------------
# Each case: name, {filename: source}, list of (argv, output), expected value.
# The sources are deliberately small and self-contained: the point is to prove
# one code-generation fact per case, not to re-run the C test suite.

STARTUP = """\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
"""

# The AEABI runtime is built once per case: aeabi.c is ordinary C (only 32-bit
# operators, so it never calls itself) and aeabi_divmod.s carries the two
# helpers that return four registers, which C cannot express.
AEABI_BUILD = [
    (["aeabi.c", "-target", "arm", "-c", "-o", "aeabi.obj"], None),
    (["aeabi_divmod.s", "-target", "arm", "-c", "-o", "aeabi_div.obj"], None),
]


def run_case_image(case, path):
    with open(path, "rb") as fh:
        return run_image(fh.read(), case.get("max_insn", 5000000),
                         case.get("sram_fill"))

def link_with_runtime(main_src, main_obj):
    """Build steps for one 64-bit case: runtime, program, link."""
    return AEABI_BUILD + [
        ([main_src, "-target", "arm", "-c", "--vector-table", "-o", main_obj], None),
        (["-link", main_obj, "aeabi.obj", "aeabi_div.obj",
          "--vector-table", "-o", "out.bin"], "out.bin"),
    ]


CASES = [
    {
        "name": "globals",
        "why": ".data initialisation + .bss zeroing through the init body",
        "files": {
            "g.c": STARTUP + """\
int g_data = 11;
int g_bss;
int main(void) { g_bss = 3; return g_data + g_bss; }
""",
        },
        "build": [(["g.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 14,
    },
    {
        "name": "strinit_nul",
        "why": ".data from a string literal writes the NUL and the zero fill; "
               "SRAM is pre-loaded with 0xAA so a byte the init body forgets "
               "cannot be mistaken for a byte it wrote as zero",
        "files": {
            "s.c": STARTUP + """\
const char tag[] = "abc";
const char pad[8] = "ab";
int main(void)
{
    int n = 0;
    int i;
    for (i = 0; i < (int)sizeof(tag); i++) n = n * 3 + tag[i];
    n = n * 3 + (int)sizeof(tag);
    for (i = 0; i < 8; i++) n = n * 3 + pad[i];
    return n;
}
""",
        },
        "build": [(["s.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "sram_fill": 0xAA,
        "expect": 75065859,
    },
    {
        "name": "reloc_data",
        "why": "--reloc-data: two objects with globals, linked and executed",
        "files": {
            "pa.c": "int ga = 11;\nint ga2;\nint use_a(void) { ga2 = 3; return ga + ga2; }\n",
            "pb.c": "int gb = 22;\nint gb2;\nint use_b(void) { gb2 = 4; return gb + gb2; }\n",
            "pm.c": STARTUP + """\
int use_a(void);
int use_b(void);
int main(void) { return use_a() + use_b(); }
""",
        },
        "build": [
            (["pa.c", "-target", "arm", "-c", "--reloc-data", "-o", "pa.obj"], None),
            (["pb.c", "-target", "arm", "-c", "--reloc-data", "-o", "pb.obj"], None),
            (["pm.c", "-target", "arm", "-c", "--reloc-data", "--vector-table", "-o", "pm.obj"], None),
            (["-link", "pm.obj", "pa.obj", "pb.obj", "--reloc-data", "--vector-table",
              "-o", "out.bin"], "out.bin"),
        ],
        "expect": 40,
    },
    {
        "name": "reloc_text_runtime",
        "why": "--reloc-text: the string literals of the *moved* objects still "
               "resolve, proven by running the image rather than by reading the "
               "immediates.  Both literal-bearing objects are linked after the "
               "one at base 0, so every one of their baked addresses is short by "
               "the size of the objects in front of them unless the linker "
               "rewrites the MOVW/MOVT pairs.  Without the flag the same "
               "program returns -97 (it reads whatever the stale pointer lands "
               "on) instead of 37, and the only sign of it is the "
               "[link] warning -- the compile-level gate checks the addresses in "
               "the image, this one checks that the addresses are the ones the "
               "code actually reads.",
        "files": {
            "ta.c": 'const char *na = "abc";\n'
                    "int len_a(void) { int i = 0; while (na[i]) i++; return i; }\n",
            "tb.c": 'const char *nb = "hello";\n'
                    "int use_b(void) { return nb[0] - 'a'; }\n",
            "tm.c": STARTUP + """\
int len_a(void);
int use_b(void);
int main(void) { return len_a() * 10 + use_b(); }
""",
        },
        "build": [
            (["ta.c", "-target", "arm", "-c", "--reloc-data", "--reloc-text", "-o", "ta.obj"], None),
            (["tb.c", "-target", "arm", "-c", "--reloc-data", "--reloc-text", "-o", "tb.obj"], None),
            (["tm.c", "-target", "arm", "-c", "--reloc-data", "--reloc-text", "--vector-table", "-o", "tm.obj"], None),
            (["-link", "tm.obj", "ta.obj", "tb.obj", "--reloc-data", "--reloc-text", "--vector-table",
              "-o", "out.bin"], "out.bin"),
        ],
        "expect": 37,
    },
    {
        "name": "struct_cond",
        "why": "C99 6.5.15p6: `k ? a : b` on two structures is a VALUE, not "
               "an lvalue.  It is materialised into a temporary and copied, so "
               "the assignment, a by-value argument and a member access all see "
               "the selected branch instead of #137.",
        "files": {
            "sc.c": STARTUP + """\
struct P { int x, y; };
int gpad = 0;
int take(struct P p) { return p.x * 10 + p.y; }
int main(void)
{
    struct P a = {1, 2}, b = {3, 4}, c;
    int k = 0;
    c = k ? a : b;
    return c.x * 10 + c.y + take(k ? b : a) + gpad;
}
""",
        },
        "build": [(["sc.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 46,
    },
    {
        "name": "reloc_data_off",
        "why": "without --reloc-data the same link must refuse, not alias the globals",
        "files": {
            "pa.c": "int ga = 11;\nint use_a(void) { return ga; }\n",
            "pb.c": "int gb = 22;\nint use_b(void) { return gb; }\n",
            "pm.c": STARTUP + """\
int use_a(void);
int use_b(void);
int main(void) { return use_a() + use_b(); }
""",
        },
        "build": [
            (["pa.c", "-target", "arm", "-c", "-o", "pa.obj"], None),
            (["pb.c", "-target", "arm", "-c", "-o", "pb.obj"], None),
            (["pm.c", "-target", "arm", "-c", "--vector-table", "-o", "pm.obj"], None),
        ],
        "link_must_fail": ["-link", "pm.obj", "pa.obj", "pb.obj", "--vector-table", "-o", "out.bin"],
        "expect_error": "SRAM overlap",
    },
    {
        "name": "sub_word_access",
        "why": "STRB/STRH/LDRSB paths: byte and halfword globals keep their size",
        "files": {
            "w.c": STARTUP + """\
char g_c = 7;
short g_s = 300;
char g_z;
int main(void) { g_z = (char)(g_c + 1); return (int)g_z + (int)(g_s / 100); }
""",
        },
        "build": [(["w.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 11,
    },
    {
        "name": "longlong_args",
        "why": "64-bit values cross a call in r0:r1 (low:high) and come back the "
               "same way; also the --reg-top path for 64-bit locals",
        "files": {
            "ll.c": STARTUP + """\
int ll_pad;
long long ll_id(long long a) { return a; }
long long ll_add(long long a, long long b) { return a + b; }
int main(void)
{
    long long c = ll_add(100, 200);   /* 300 through r0:r1 twice */
    long long d = c / 100;            /* 3, through __aeabi_ldivmod */
    if (ll_id(7) != 7) return 99;     /* high half must survive the return */
    return (int)d + 47;               /* 50 */
}
""",
        },
        "runtime": True,
        "build": link_with_runtime("ll.c", "ll.obj"),
        "expect": 50,
    },
    {
        "name": "shift64",
        "why": "64-bit shifts: constant and variable counts across the 32-bit "
               "boundary (__aeabi_llsl/llsr/lasr), checked against a shift-free "
               "reference and through function calls",
        "files": {
            "s.c": STARTUP + """\
int sh_pad;\nlong long sh_l(long long v, int n) { return v << n; }\nunsigned long long sh_r(unsigned long long v, int n) { return v >> n; }\nlong long sh_a(long long v, int n) { return v >> n; }\nstatic int check_n(unsigned long long uv, long long sv, int n)\n{\n    unsigned long long rr = uv, rl = uv, gr = uv >> n, gl = uv << n;\n    long long ra = sv, ga = sv >> n;\n    int k;\n    for (k = 0; k < n; k++) { rr = rr / 2; rl = rl * 2; ra = (ra - (ra & 1)) / 2; }\n    if (gr != rr) return 1;\n    if (gl != rl) return 2;\n    if (ga != ra) return 3;\n    return 0;\n}\nint main(void)\n{\n    unsigned long long uv = 0x123456789ABCDEF0ULL;\n    long long sv = -0x123456789ABCDEF0LL;\n    int ns[10];\n    int i, rc;\n    ns[0] = 0;  ns[1] = 1;  ns[2] = 8;  ns[3] = 16; ns[4] = 31;\n    ns[5] = 32; ns[6] = 33; ns[7] = 40; ns[8] = 47; ns[9] = 63;\n    for (i = 0; i < 10; i++) {\n        rc = check_n(uv, sv, ns[i]);\n        if (rc != 0) return rc * 10 + i;\n    }\n    if ((300LL >> 8) != 1) return 60;\n    if (((unsigned long long)1 << 32) != 0x100000000ULL) return 61;\n    if (sh_l(1, 40) != 0x10000000000LL) return 62;\n    if (sh_r(0x8000000000000000ULL, 63) != 1) return 63;\n    if (sh_a(-256, 8) != -1) return 64;\n    return 50;\n}
""",
        },
        "runtime": True,
        "max_insn": 40000000,
        "build": link_with_runtime("s.c", "s.obj"),
        "expect": 50,
    },
    {
        "name": "abi_stack_args",
        "why": "AAPCS argument passing: 5/6/7/9 word arguments and 64-bit "
               "arguments that spill to the stack land in the right word, in the "
               "right order, 8-byte aligned",
        "files": {
            "a.c": STARTUP + """\
int abi_pad;\nint five(int a, int b, int c, int d, int e) { return a + b + c + d + e; }\nint nine(int a, int b, int c, int d, int e, int f, int g, int h, int i)\n{ return a + b + c + d + e + f + g + h + i; }\nlong long ll3(long long a, long long b, long long c) { return a + b + c; }\nlong long llmix(int a, int b, int c, int d, long long e, long long f)\n{ return (long long)a + b + c + d + e + f; }\nlong long ints_then_ll(int a, int b, int c, int d, int e, long long f)\n{ return (long long)a + b + c + d + e + f; }\nint main(void)\n{\n    if (five(1, 2, 3, 4, 9) != 19) return 1;\n    if (nine(1, 2, 3, 4, 5, 6, 7, 8, 9) != 45) return 2;\n    if (ll3(1LL, 2LL, 3LL) != 6LL) return 3;\n    if (llmix(1, 2, 3, 4, 5LL, 6LL) != 21LL) return 4;\n    if (ints_then_ll(1, 2, 3, 4, 5, 6LL) != 21LL) return 5;\n    if (ll3(0x100000000LL, 0x200000000LL, 0x300000000LL) != 0x600000000LL) return 6;\n    return 50;\n}
""",
        },
        "runtime": True,
        "build": link_with_runtime("a.c", "a.obj"),
        "expect": 50,
    },
    {
        "name": "longlong64",
        "why": "64-bit arithmetic, comparisons, bitwise ops, unary minus, ++/-- "
               "(local and global), aggregate/pointer access and compound "
               "assignment",
        "files": {
            "l.c": STARTUP + """\
int ll_pad;\nstruct LS { int tag; long long v; };\nstatic long long arr[4];\nstatic struct LS gs;\nlong long g64 = 0x00000000FFFFFFFFLL;\nint main(void)\n{\n    struct LS s;\n    long long *p;\n    long long a = -100LL, b = 3LL;\n    unsigned long long ua = 0xF00000000000000BULL, ub = 3ULL;\n    if (a + b != -97LL) return 1;\n    if (a - b != -103LL) return 2;\n    if (a * b != -300LL) return 3;\n    if (a / b != -33LL) return 4;\n    if (a % b != -1LL) return 5;\n    if (ua / ub != 0x5000000000000003ULL) return 6;\n    if (!(a < b) || !(b > a) || !(a == -100LL) || !(a != b) || !(ua > ub)) return 7;\n    if ((0xF0F0F0F0F0F0F0F0ULL & 0xFFFF0000FFFF0000ULL) != 0xF0F00000F0F00000ULL) return 8;\n    if ((0xFF00FF00FF00FF00ULL ^ 0x0FF00FF00FF00FF0ULL) != 0xF0F0F0F0F0F0F0F0ULL) return 9;\n    if (~0ULL != 0xFFFFFFFFFFFFFFFFULL) return 10;\n    if (-1LL != 0xFFFFFFFFFFFFFFFFULL) return 11;\n    if (-a != 100LL) return 12;\n    s.tag = 1; s.v = -5LL;\n    if (s.v != -5LL) return 13;\n    arr[2] = 0x1122334455667788LL;\n    p = &arr[2];\n    *p = *p + 1;\n    if (arr[2] != 0x1122334455667789LL) return 14;\n    gs.v = 77LL;\n    if (gs.v != 77LL) return 15;\n    {\n        unsigned long long c = 0xFFFFFFFFULL;\n        c++;\n        unsigned *q = (unsigned *)&c;\n        if (q[0] != 0 || q[1] != 1) return 16;\n    }\n    g64++;\n    {\n        unsigned *q = (unsigned *)&g64;\n        if (q[0] != 0 || q[1] != 1) return 17;\n    }\n    {\n        long long v = 0x100000000LL;\n        v += 5LL;  if (v != 0x100000005LL) return 18;\n        v >>= 3;   if (v != 0x20000000LL) return 19;\n        v <<= 4;   if (v != 0x200000000LL) return 20;\n        v *= 3LL;  if (v != 0x600000000LL) return 21;\n    }\n    return 50;\n}
""",
        },
        "runtime": True,
        "build": link_with_runtime("l.c", "l.obj"),
        "expect": 50,
    },
    {
        "name": "struct_byval",
        "why": "structs by value and by return: `f(struct)` / `struct f(void)` / "
               "`f().m` / `arr[i] = f()`, for sizes <= 4, 5..8 and > 8 bytes, plus "
               "a mixed scalar/struct/pointer argument list",
        "files": {
            "v.c": STARTUP + """\
int sb_pad;\nstruct P { int x, y; };\nstruct Q { int x, y, z; };\nstruct S3 { char a, b, c; };\nstruct Pair { struct P p; int tag; };\nunion U { int i; struct P p; };\nstruct P mk(int x, int y) { struct P r; r.x = x; r.y = y; return r; }\nint psum(struct P a) { return a.x + a.y; }\nint qsum(struct Q q) { return q.x + q.y + q.z; }\nint s3sum(struct S3 s) { return s.a + s.b + s.c; }\nint pairsum(struct Pair v) { return v.p.x + v.p.y + v.tag; }\nint usum(union U u) { return u.i; }\nstruct P swapxy(struct P v) { struct P r; r.x = v.y; r.y = v.x; return r; }\nint mixed(int a, struct P p, int b, struct Q q, int c) { return a + p.x + p.y + b + q.x + q.y + q.z + c; }\nint main(void)\n{\n  struct P a = {1, 2}, b;\n  struct Q q = {10, 20, 30};\n  struct S3 s = {1, 2, 3};\n  struct Pair pr;\n  union U u;\n  struct P arr[3];\n  pr.p = a; pr.tag = 5;\n  u.i = 0x00040003;\n  arr[1] = a;\n  arr[2] = mk(7, 8);\n  b = mk(4, 9);\n  if (psum(a) != 3) return 1;\n  if (psum(b) != 13) return 2;\n  if (qsum(q) != 60) return 3;\n  if (s3sum(s) != 6) return 4;\n  if (pairsum(pr) != 8) return 5;\n  if (usum(u) != 0x00040003) return 6;\n  b = swapxy(a);\n  if (b.x != 2 || b.y != 1) return 7;\n  if (psum(arr[1]) != 3) return 8;\n  if (psum(arr[2]) != 15) return 9;\n  if (psum(*arr) != 0 && 0) return 10;\n  if (mixed(1, a, 2, q, 3) != 1+1+2+2+10+20+30+3) return 11;\n  if (mk(5, 6).y != 6) return 12;\n  if (psum(mk(11, 12)) != 23) return 13;\n  return 50;\n}
""",
        },
    "build": [(["v.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 50,
    },
    {
        "name": "struct_narrow_return",
        "why": "aggregate returns narrower than a word: 1/2/3/4/5/6/7/8-byte "
               "structs come back in r0/r1 with ceil(sz/4) words on the caller's "
               "stack, so the store width must be the object's real width.  No "
               "store takes 3/5/6/7 bytes, so those are composed from a "
               "duplicated word -- and the byte at offset 2 lives in bits "
               "16..23, which has to be shifted down before the 1-byte store "
               "(storing the word as-is put byte 0 into offset 2: measured "
               "1088 instead of 1122, i.e. the third field read the first)",
        "files": {
            "r.c": STARTUP + """\
int sn_pad;\nstruct S1{char a;}; struct S2{char a,b;}; struct S3{char a,b,c;};\nstruct S4{unsigned a,b;}; struct S5{char c[5];}; struct S6{short a,b,c;};\nstruct S7{char c[7];}; struct S8{int a,b;};\nstruct S1 f1(void){struct S1 s;s.a=0x11;return s;}\nstruct S2 f2(void){struct S2 s;s.a=0x22;s.b=0x33;return s;}\nstruct S3 f3(void){struct S3 s;s.a=0x44;s.b=0x55;s.c=0x66;return s;}\nstruct S4 f4(void){struct S4 s;s.a=3;s.b=5;return s;}\nstruct S5 f5(void){struct S5 s;int i;for(i=0;i<5;i++)s.c[i]=i+1;return s;}\nstruct S6 f6(void){struct S6 s;s.a=2;s.b=3;s.c=4;return s;}\nstruct S7 f7(void){struct S7 s;int i;for(i=0;i<7;i++)s.c[i]=i+1;return s;}\nstruct S8 f8(void){struct S8 s;s.a=0x1234;s.b=0x5678;return s;}\nint main(void){ struct S1 b1=f1(); struct S2 b2=f2(); struct S3 b3=f3();\n struct S4 b4=f4(); struct S5 b5=f5(); struct S6 b6=f6(); struct S7 b7=f7(); struct S8 b8=f8();\n int s = b1.a + b2.a + b2.b + b3.a + b3.b + b3.c + b4.a + b4.b\n       + b5.c[0] + b5.c[4] + b6.a + b6.b + b6.c + b7.c[0] + b7.c[6]\n       + (b8.a & 0xF) + (b8.b & 0xF);\n return s & 0x7f; }\n""",
        },
        "build": [(["r.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 16,
    },
    {
        "name": "struct_narrow_copy",
        "why": "whole-aggregate assignment and declaration-initialisation for "
               "1..8-byte structs: an lvalue copy must go through the ADDRESS "
               "(irgen_expr on an aggregate lvalue pushes only its first word), "
               "and a 3/5/6/7-byte store must not round up to 4 or 8 bytes.  "
               "SRAM is pre-filled with 0xAA and neighbours inside a struct "
               "array are checked, so an over-wide store cannot pass unnoticed",
        "files": {
            "c.c": STARTUP + """\
int sc_pad;\nstruct S1{char a;}; struct S2{char a,b;}; struct S3{char a,b,c;};\nstruct S4{unsigned a,b;}; struct S5{char c[5];}; struct S6{short a,b,c;};\nstruct S7{char c[7];}; struct S8{int a,b;};\nint main(void){\n struct S1 a1; struct S2 a2; struct S3 a3; struct S4 a4;\n struct S5 a5; struct S6 a6; struct S7 a7; struct S8 a8;\n struct S1 c1; struct S2 c2; struct S3 c3; struct S4 c4;\n struct S5 c5; struct S6 c6; struct S7 c7; struct S8 c8;\n int i; int s = 0;\n a1.a=1; a2.a=2; a2.b=3; a3.a=4; a3.b=5; a3.c=6; a4.a=7; a4.b=8;\n for(i=0;i<5;i++) a5.c[i]=i+1; a6.a=1; a6.b=2; a6.c=3;\n for(i=0;i<7;i++) a7.c[i]=i+1; a8.a=9; a8.b=10;\n c1=a1; c2=a2; c3=a3; c4=a4; c5=a5; c6=a6; c7=a7; c8=a8;\n s = c1.a + c2.a + c2.b + c3.a + c3.b + c3.c + c4.a + c4.b\n   + c5.c[0] + c5.c[4] + c6.a + c6.b + c6.c + c7.c[0] + c7.c[6] + c8.a + c8.b;\n { struct S3 v[3]; struct S3 t; struct S5 w[3];\n   for(i=0;i<3;i++){ v[i].a=0x7F; v[i].b=0x7F; v[i].c=0x7F; }\n   t.a=1; t.b=2; t.c=3; v[1]=t;\n   if (v[0].a!=0x7F || v[0].b!=0x7F || v[0].c!=0x7F) s += 40;\n   if (v[2].a!=0x7F || v[2].b!=0x7F || v[2].c!=0x7F) s += 40;\n   if (v[1].a!=1 || v[1].b!=2 || v[1].c!=3) s += 40;\n   for(i=0;i<3;i++){int j; for(j=0;j<5;j++) w[i].c[j]=0x7F;}\n   for(i=0;i<5;i++) w[1].c[i]=i+1;\n   if (w[0].c[0]!=0x7F || w[0].c[4]!=0x7F) s += 40;\n   if (w[2].c[0]!=0x7F || w[2].c[4]!=0x7F) s += 40;\n   if (w[1].c[0]!=1 || w[1].c[4]!=5) s += 40;\n   s += v[1].a + v[1].c + w[1].c[4];\n }\n return s & 0x7f;\n}\n""",
        },
        "sram_fill": 0xAA,
        "build": [(["c.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 84,
    },
    {
        "name": "struct_narrow_call_assign",
        "why": "aggregate assignment whose right-hand side is a struct-returning CALL (3- and 5-byte objects) followed by more statements: the expression value of such an assignment has to be the aggregate VALUE (one word for 3 bytes, a low/high pair for 5..8), not the destination address.  Leaving the address made a plain `v[1] = f3();` statement pop one word too many, the frame cursor then sat four bytes into slot 0, and the next pushed value overwrote the first local (`if (0) {}` after such an assignment returned 0 instead of 5).  Neighbours inside `struct S3 v[3]` / `struct S5 z[3]` are checked and SRAM is pre-filled with 0xAA, so an over-wide store cannot pass either",
        "files": {
            "a.c": STARTUP + """\
int sa_pad;\nstruct S1{char a;}; struct S2{char a,b;}; struct S3{char a,b,c;};\nstruct S4{unsigned a,b;}; struct S5{char c[5];}; struct S6{short a,b,c;};\nstruct S7{char c[7];}; struct S8{int a,b;};\nstruct S3 f3(void){struct S3 r;r.a=0x44;r.b=0x55;r.c=0x66;return r;}\nstruct S5 f5(void){struct S5 r;int i;for(i=0;i<5;i++)r.c[i]=i+1;return r;}\nint main(void){\n struct S1 a1; struct S2 a2; struct S3 a3; struct S4 a4;\n struct S5 a5; struct S6 a6; struct S7 a7; struct S8 a8;\n struct S1 c1; struct S2 c2; struct S3 c3; struct S4 c4;\n struct S5 c5; struct S6 c6; struct S7 c7; struct S8 c8;\n int i; int s = 0;\n a1.a=1; a2.a=2; a2.b=3; a3.a=4; a3.b=5; a3.c=6; a4.a=7; a4.b=8;\n for(i=0;i<5;i++) a5.c[i]=i+1; a6.a=1; a6.b=2; a6.c=3;\n for(i=0;i<7;i++) a7.c[i]=i+1; a8.a=9; a8.b=10;\n c1=a1; c2=a2; c3=a3; c4=a4; c5=a5; c6=a6; c7=a7; c8=a8;\n s = c1.a + c2.a + c2.b + c3.a + c3.b + c3.c + c4.a + c4.b\n   + c5.c[0] + c5.c[4] + c6.a + c6.b + c6.c + c7.c[0] + c7.c[6] + c8.a + c8.b;\n { struct S3 v[3]; struct S3 t; struct S5 w[3];\n   for(i=0;i<3;i++){ v[i].a=0x7F; v[i].b=0x7F; v[i].c=0x7F; }\n   t.a=1; t.b=2; t.c=3; v[1]=t;\n   if (v[0].a!=0x7F || v[0].b!=0x7F || v[0].c!=0x7F) s += 40;\n   if (v[2].a!=0x7F || v[2].b!=0x7F || v[2].c!=0x7F) s += 40;\n   if (v[1].a!=1 || v[1].b!=2 || v[1].c!=3) s += 40;\n   for(i=0;i<3;i++){int j; for(j=0;j<5;j++) w[i].c[j]=0x7F;}\n   for(i=0;i<5;i++) w[1].c[i]=i+1;\n   if (w[0].c[0]!=0x7F || w[0].c[4]!=0x7F) s += 40;\n   if (w[2].c[0]!=0x7F || w[2].c[4]!=0x7F) s += 40;\n   if (w[1].c[0]!=1 || w[1].c[4]!=5) s += 40;\n   s += v[1].a + v[1].c + w[1].c[4];\n }\n   { struct S3 y[3]; struct S5 z[3]; int i2;\n     for(i2=0;i2<3;i2++){ y[i2].a=0x7F; y[i2].b=0x7F; y[i2].c=0x7F; }\n     y[1] = f3();\n     if (y[0].a!=0x7F || y[0].c!=0x7F) s += 40;\n     if (y[2].a!=0x7F || y[2].c!=0x7F) s += 40;\n     if (y[1].a!=0x44 || y[1].b!=0x55 || y[1].c!=0x66) s += 40;\n     for(i2=0;i2<3;i2++){int j2; for(j2=0;j2<5;j2++) z[i2].c[j2]=0x7F;}\n     z[1] = f5();\n     if (z[0].c[0]!=0x7F || z[0].c[4]!=0x7F) s += 40;\n     if (z[2].c[0]!=0x7F || z[2].c[4]!=0x7F) s += 40;\n     if (z[1].c[0]!=1 || z[1].c[4]!=5) s += 40;\n     s += y[1].c + z[1].c[2];\n   }\n return s & 0x7f;\n}\n""",
        },
        "sram_fill": 0xAA,
        "build": [(["a.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 61,
    },
    {
        "name": "sret_cross_tu",
        "why": "struct return > 8 bytes across translation units: the caller "
               "only has a declaration (`struct S mk(int);`), so the hidden "
               "result pointer must come from the call's type and not from a "
               "table of definitions.  The table this used to use was built by "
               "scanning the program being compiled, so a call to a callee "
               "defined in another object was emitted with the AAPCS default "
               "(no hidden pointer) and the callee's stores landed on r0.",
        "files": {
            "ka.c": STARTUP + """\
int sxt_pad;
struct S { int a, b, c; };
struct S mk(int v);
int main(void)
{
  struct S t = mk(3);
  return t.a + t.b + t.c;
}
""",
            "kb.c": "struct S { int a, b, c; };\n"
                    "struct S mk(int v) { struct S s; s.a = v; s.b = v * 2; s.c = v * 3; return s; }\n",
        },
        "build": [
            (["ka.c", "-target", "arm", "-c", "--vector-table", "-o", "ka.obj"], None),
            (["kb.c", "-target", "arm", "-c", "-o", "kb.obj"], None),
            (["-link", "ka.obj", "kb.obj", "--vector-table", "-o", "out.bin"], "out.bin"),
        ],
        "expect": 18,
    },
    {
        "name": "sret_indirect",
        "why": "struct return > 8 bytes through a function pointer: the callee "
               "name is not known at the call site at all.  Same root cause as "
               "sret_cross_tu -- the hidden pointer has to be part of the call, "
               "not looked up by name -- and r0 has to be filled *after* the "
               "argument pops and the BLX target is in ip, where the argument "
               "pops cannot reach it.",
        "files": {
            "i.c": STARTUP + """\
int si_pad;
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a = v; s.b = v + 1; s.c = v + 2; return s; }
int main(void)
{
    struct S (*fp)(int) = mk;
    struct S t = fp(4);
    int (*ip)(void) = 0;
    (void)ip;
    return t.a + t.b + t.c;
}
""",
        },
        "build": [(["i.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 15,
    },
    {
        "name": "sret_live_results",
        "why": "several sret results alive at once (`f(mk(1), mk(2), mk(3))` and "
               "`struct S a = mk(1), b = mk(2);`): each call site owns its own "
               "buffer in the caller's frame.  One shared scratch area would "
               "have every result overwrite the previous one, and a buffer "
               "below SP would be overwritten by the callee's own frame.",
        "files": {
            "l.c": STARTUP + """\
int sl_pad;
struct S { int a, b, c; };
struct S mk(int v) { struct S s; s.a = v; s.b = v * 10; s.c = v * 100; return s; }
int pick(struct S x, struct S y, struct S z) { return x.a + y.b / 10 + z.c / 100; }
int main(void)
{
    struct S a = mk(1), b = mk(2);
    struct S arr[3];
    int i;
    arr[0] = mk(3);
    arr[1] = mk(4);
    arr[2] = mk(5);
    if (pick(mk(1), mk(2), mk(3)) != 6) return 1;
    if (a.a + b.b / 10 != 3) return 2;
    for (i = 0; i < 3; i++) if (arr[i].c / 100 != i + 3) return 3 + i;
    if (mk(6).b / 10 != 6) return 7;
    return 50;
}
""",
        },
        "build": [(["l.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 50,
    },
    {
        "name": "sret_recur",
        "why": "sret through recursion (fib returning a 12-byte struct): the "
               "result pointer of the inner call must survive the outer "
               "call's own frame, and the value has to come back out of the "
               "caller-owned buffer at every level.",
        "files": {
            "r.c": STARTUP + """\
int sr_pad;
struct S { int a, b, c; };
struct S fib(int n)
{
    struct S s;
    if (n < 2) { s.a = n; s.b = 1; s.c = 0; return s; }
    {
        struct S p = fib(n - 1), q = fib(n - 2);
        s.a = p.a + q.a; s.b = p.b; s.c = p.c; return s;
    }
}
int main(void) { struct S t = fib(10); return t.a; }
""",
        },
        "build": [(["r.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 55,
        "max_insn": 12000000,
    },
    {
        "name": "big_frame",
        "why": "a frame above 4095 bytes: one SUBW cannot do it, and the old "
               "single 'SUB sp, sp, #N' was truncated to (N/4) & 0x7f * 4 -- the "
               "stack pointer itself was wrong, so every slot offset was too. "
               "The prologue/epilogue now split the adjustment into <=4095 pieces.",
        "files": {
            "f.c": STARTUP + """\
int bf_pad;
int big(void)
{
    char buf[5000];
    int i, s;
    for (i = 0; i < 5000; i++) buf[i] = (char)(i * 7 + 3);
    s = 0;
    for (i = 0; i < 5000; i += 97) s += (unsigned char)buf[i];
    s += (unsigned char)buf[4999];
    return s & 0xFF;
}
int main(void) { return big(); }
""",
        },
        "build": [(["f.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 82,
    },
    {
        "name": "far_addr",
        "why": "the address of a local beyond 4095 bytes: 'ADD r0, r6, #off' cannot encode a 12-bit plain immediate that big, so it is rewritten to 'MOVW/MOVT ip' + 'ADD r0, r6, ip'. The first version of that rewrite reused the bracketed shape and emitted 'ADD r0, [ip]', which the assembler rejects -- and a big frame hits this before it hits a plain far load, because every array past 4095 bytes is reached through its address.",
        "files": {
            "f.c": STARTUP + """\
int fa_pad;
int far(void)
{
    char pad[6000];
    int tail[4];
    int *p;
    pad[0] = 1;
    tail[0] = 11; tail[1] = 22; tail[2] = 33; tail[3] = 44;
    p = tail;
    pad[5999] = 5;
    return p[1] + (int)(unsigned char)pad[5999] + tail[2] - tail[0];
}
int main(void) { return far(); }
""",
        },
        "build": [(["f.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 49,
    },
    {
        "name": "func_ptr",
        "why": "calling through a function pointer: the address of a function must carry the Thumb bit, or BLX branches into ARM state and the core faults on the first instruction. 'LDR rd, =f' used to load flash_base + offset with bit 0 clear, and 'ORR ip, ip, #1' -- the fixup in front of BLX -- used to be encoded as 'orrs r4, r4': the high register was masked with &7 and the immediate dropped. Both are checked here, through a pointer, a struct field and a global.",
        "files": {
            "f.c": STARTUP + """\
int fp_pad;
int (*g_fp)(int);
struct ops { int (*call)(int); } g_ops;
int twice(int v) { return v * 2; }
int plus1(int v) { return v + 1; }
int zero(void) { return 0; }
int main(void)
{
    int (*p)(int) = twice;
    int r = p(3);
    g_fp = plus1;
    r += g_fp(4);
    g_ops.call = zero;
    if (g_ops.call() != 0) r += 100;
    return r;
}
"""
        },
        "build": [(["f.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 11,
    },
    {
        "name": "block_scope_decl",
        "why": "C99 6.2.2p5: a prototype written inside a block ('extern int f(void);') must register the function and lower calls to it as BL. The node it builds used to keep the zero-filled smc_num, and irgen accepts any smc_num >= 0 as a real __smc(n) function, so every call became 'SMC #0' -- which the assembler rejects outright, and which on a core without the security extension would trap even if it assembled. Checked here with a direct call, a call through a pointer taken from that block-scope name, and a second call after the block closed.",
        "files": {
            "bh.c": "int helper(int v) { return v * 3; }\n"
                    "int base(void) { return 5; }\n",
            "bm.c": STARTUP + """\
int main(void)
{
    int r = 0;
    {
        extern int helper(int);
        extern int base(void);
        int (*p)(int) = helper;
        r  = helper(4);
        r += base();
        r += p(2);
    }
    return r;
}
""",
        },
        "build": [
            (["bh.c", "-target", "arm", "-c", "-o", "bh.obj"], None),
            (["bm.c", "-target", "arm", "-c", "--vector-table", "-o", "bm.obj"], None),
            (["-link", "bm.obj", "bh.obj", "--vector-table", "-o", "out.bin"], "out.bin"),
        ],
        "expect": 23,
    },
    {
        "name": "aeabi_runtime",
        "why": "every 64-bit helper the backend calls, called directly: "
               "lmul/ldiv/udiv, the divmod remainder paths (ldivmod "
               "r2:r3, which only C % can reach), the three shifts at "
               "0/1/31/32/33/63 against a shift-free reference, and the "
               "two compares",
        "runtime": True,
        "files": {
            "r.c": STARTUP + """\
int ar_pad;\nextern long long __aeabi_lmul(long long, long long);\nextern long long __ark_ldiv64(long long, long long);\nextern unsigned long long __ark_udiv64(unsigned long long, unsigned long long);\nextern long long __aeabi_llsl(long long, int);\nextern unsigned long long __aeabi_llsr(unsigned long long, int);\nextern long long __aeabi_lasr(long long, int);\nextern int __aeabi_lcmp(long long, long long);\nextern int __aeabi_ulcmp(unsigned long long, unsigned long long);\nstatic unsigned long long ref_shr(unsigned long long v, int n)\n{ int k; for (k = 0; k < n; k++) v = v / 2; return v; }\nstatic unsigned long long ref_shl(unsigned long long v, int n)\n{ int k; for (k = 0; k < n; k++) v = v * 2; return v; }\nstatic long long ref_sar(long long v, int n)\n{ int k; for (k = 0; k < n; k++) v = (v < 0) ? (v - 1) / 2 : v / 2; return v; }\nint main(void)\n{\n    long long a = -100LL, b = 3LL;\n    unsigned long long ua = 0xF00000000000000BULL, ub = 3ULL;\n    unsigned long long uv = 0x9ABCDEF012345678ULL;\n    long long sv = -0x123456789ABCDEF0LL;\n    int ns[6];\n    int i;\n    if (__aeabi_lmul(3LL, 7LL) != 21LL) return 1;\n    if (__aeabi_lmul(-3LL, 7LL) != -21LL) return 2;\n    if (__aeabi_lmul(0x10000LL, 0x10000LL) != 0x100000000LL) return 3;\n    if (__ark_ldiv64(100LL, 3LL) != 33LL) return 4;\n    if (__ark_ldiv64(-100LL, 3LL) != -33LL) return 5;\n    if (__ark_ldiv64(100LL, -3LL) != -33LL) return 6;\n    if (__ark_ldiv64(-100LL, -3LL) != 33LL) return 7;\n    if (__ark_udiv64(0xF000000000000000ULL, 3ULL) != 0x5000000000000000ULL) return 8;\n    if (__ark_udiv64(7ULL, 8ULL) != 0ULL) return 9;\n    if (a % b != -1LL) return 10;            /* __aeabi_ldivmod r2:r3 */\n    if (100LL % 3LL != 1LL) return 11;\n    if (ua % ub != 2ULL) return 12;          /* __aeabi_uldivmod r2:r3 */\n    ns[0] = 0; ns[1] = 1; ns[2] = 31; ns[3] = 32; ns[4] = 33; ns[5] = 63;\n    for (i = 0; i < 6; i++) {\n        if (__aeabi_llsr(uv, ns[i]) != ref_shr(uv, ns[i])) return 20 + i;\n        if ((uv >> ns[i]) != ref_shr(uv, ns[i])) return 30 + i;\n        if (__aeabi_llsl((long long)uv, ns[i]) != (long long)ref_shl(uv, ns[i])) return 40 + i;\n        if (__aeabi_lasr(sv, ns[i]) != ref_sar(sv, ns[i])) return 50 + i;\n        if ((sv >> ns[i]) != ref_sar(sv, ns[i])) return 60 + i;\n    }\n    if (__aeabi_lcmp(-5LL, 3LL) != -1) return 70;\n    if (__aeabi_lcmp(0x100000000LL, 0x100000001LL) != -1) return 71;\n    if (__aeabi_ulcmp(0x100000000ULL, 3ULL) != 1) return 72;\n    if (__aeabi_ulcmp(0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFFULL) != 0) return 73;\n    if (!(0xFFFFFFFFFFFFFFFFULL > 1ULL)) return 74;\n    return 50;\n}\n""",
        },
        "max_insn": 60000000,
        "build": link_with_runtime("r.c", "r.obj"),
        "expect": 50,
    },
    {
        "name": "ptr_llong_arg",
        "why": "a pointer is ONE stack word and a long long TWO, so passing "
               "one as a 64-bit argument has to widen it.  sema used to answer "
               "cast_changes_repr() == 0 for every non-arithmetic type, so no "
               "cast node was inserted and irgen emitted only an IR_ZEXT, which "
               "every backend treats as a no-op (it only fixed word *order*, it "
               "never created the high word).  The call then pushed one word "
               "while the argument mask said eight bytes, and the callee read a "
               "stale frame word as the high half -- this case returned 37 on the "
               "host and on the board instead of 41.  Both shapes are covered: "
               "f(q) is the pointer argument, g(q) the pointer return.",
        "files": {
            "pl.c": STARTUP + """\
long long f(long long x) { return x + 1; }
long long g(char *q) { return (long long)q; }
int g_dummy;
int main(void)
{
    char *p = (char *)0x10;
    char *q = p + 4;
    long long a = f(q);
    long long b = g(q);
    return (int)(a + b) % 251;
}
""",
        },
        "build": [(["pl.c", "-target", "arm", "-c", "--vector-table", "-o", "pl.obj"], None),
                  (["-link", "pl.obj", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 41,
    },
    {
        "name": "fconv_rne",
        "why": "float <-> double conversion is the one place a single-precision FPU cannot stand in, so the backend emits BL __aeabi_f2d / __aeabi_d2f and the software path has to round correctly.  __aeabi_d2f is round-to-nearest-even with overflow to infinity and gradual underflow into a subnormal float; this case pins both directions against 74 bit patterns computed independently, including the exact ties at 0x3F800000+1/2 ulp, 0x3F800000+3/4 ulp, 2^-150 (tie to zero) and FLT_MAX+1/2 ulp (tie to infinity).  It also covers the reason the two helpers exist in aeabi.c at all: without them every image that links aeabi.o failed to link with unresolved __aeabi_d2f / __aeabi_f2d, including images that never converted a float.  A mismatch returns 100+i / 200+i, so a partially correct conversion cannot pass by returning 0.",
        "runtime": True,
        "files": {
            "f.c": STARTUP + """\
struct d2f_case { unsigned long long in; unsigned int want; };
struct f2d_case { unsigned int in; unsigned long long want; };
static const struct d2f_case g_d2f[] = {
    { 0x0000000000000000ULL, 0x00000000UL },
    { 0x8000000000000000ULL, 0x80000000UL },
    { 0x3FF0000000000000ULL, 0x3F800000UL },
    { 0xBFF0000000000000ULL, 0xBF800000UL },
    { 0x3FE0000000000000ULL, 0x3F000000UL },
    { 0x3FD5555555555555ULL, 0x3EAAAAABUL },
    { 0x37A16C262777579CULL, 0x000116C2UL },
    { 0x47EFFFFFE0000000ULL, 0x7F7FFFFFUL },
    { 0x7FF0000000000000ULL, 0x7F800000UL },
    { 0xFFF0000000000000ULL, 0xFF800000UL },
    { 0x7E37E43C8800759CULL, 0x7F800000UL },
    { 0xFE37E43C8800759CULL, 0xFF800000UL },
    { 0x3810000000000000ULL, 0x00800000UL },
    { 0x36A0000000000000ULL, 0x00000001UL },
    { 0x3690000000000000ULL, 0x00000000UL },
    { 0x35F0000000000000ULL, 0x00000000UL },
    { 0x3FF0000000000001ULL, 0x3F800000UL },
    { 0x419D6F3454000000ULL, 0x4CEB79A3UL },
    { 0x3FB999999999999AULL, 0x3DCCCCCDUL },
    { 0x3696D601AD376AB9ULL, 0x00000001UL },
    { 0x0000000000000001ULL, 0x00000000UL },
    { 0x0000000000000001ULL, 0x00000000UL },
    { 0x7FF8000000000000ULL, 0x7FC00000UL },
    { 0xFFF8000000000123ULL, 0xFFC00000UL },
    { 0x3FF0000010000000ULL, 0x3F800000UL },
    { 0x3FF0000008000000ULL, 0x3F800000UL },
    { 0x3FF0000018000000ULL, 0x3F800001UL },
    { 0x4000000010000000ULL, 0x40000000UL },
    { 0x4000000008000000ULL, 0x40000000UL },
    { 0x4000000018000000ULL, 0x40000001UL },
    { 0x36A8000000000000ULL, 0x00000002UL },
    { 0x36A4000000000000ULL, 0x00000001UL },
    { 0x36AC000000000000ULL, 0x00000002UL },
    { 0x380FFFFFE0000000ULL, 0x00800000UL },
    { 0x380FFFFFD0000000ULL, 0x007FFFFFUL },
    { 0x380FFFFFF0000000ULL, 0x00800000UL },
    { 0xBF72B7A88E139873ULL, 0xBB95BD44UL },
    { 0x3D17008D34DA0937ULL, 0x28B8046AUL },
    { 0xBEDB2BA07D8F5910ULL, 0xB6D95D04UL },
    { 0xBA8B86DF90814B94ULL, 0x945C36FDUL },
    { 0xBBDCA017B9DE3985ULL, 0x9EE500BEUL },
    { 0xC5F529415140FD36ULL, 0xEFA94A0BUL },
    { 0x39B323B7E86D98BEULL, 0x0D991DBFUL },
    { 0xC3C623BEF49CD710ULL, 0xDE311DF8UL },
    { 0xBE3425F01307636CULL, 0xB1A12F81UL },
    { 0x3DEFC262C6A942C0ULL, 0x2F7E1316UL },
    { 0xBDED7CF986ED91F0ULL, 0xAF6BE7CCUL },
    { 0xB937545231AFA653ULL, 0x89BAA292UL },
    { 0xB9139C954B789CE1ULL, 0x889CE4AAUL },
    { 0xC59EB149B3AC1194ULL, 0xECF58A4EUL },
    { 0xBE7174A3033862C4ULL, 0xB38BA518UL },
    { 0xB8679C39664DADEBULL, 0x833CE1CBUL },
    { 0x38F0869B313ABDB5ULL, 0x078434DAUL },
    { 0x3BA288F058AE8CF5ULL, 0x1D144783UL },
    { 0xBADBD9F2B327CA2AULL, 0x96DECF96UL },
    { 0xBCE70B327558D92FULL, 0xA7385994UL },
    { 0xBA282FB585EE5AE0ULL, 0x91417DACUL },
    { 0x3C32521A2358FCE0ULL, 0x219290D1UL },
    { 0x3B27271D940DEC6FULL, 0x193938EDUL },
    { 0xB95D221F91198D6AULL, 0x8AE910FDUL },
};
static const struct f2d_case g_f2d[] = {
    { 0x00000000UL, 0x0000000000000000ULL },
    { 0x80000000UL, 0x8000000000000000ULL },
    { 0x3F800000UL, 0x3FF0000000000000ULL },
    { 0xBF800000UL, 0xBFF0000000000000ULL },
    { 0x00000001UL, 0x36A0000000000000ULL },
    { 0x007FFFFFUL, 0x380FFFFFC0000000ULL },
    { 0x00800000UL, 0x3810000000000000ULL },
    { 0x7F800000UL, 0x7FF0000000000000ULL },
    { 0xFF800000UL, 0xFFF0000000000000ULL },
    { 0x7FC00000UL, 0x7FF8000000000000ULL },
    { 0x3F8CCCCDUL, 0x3FF19999A0000000ULL },
    { 0x4B000000UL, 0x4160000000000000ULL },
    { 0x4EFFFFFFUL, 0x41DFFFFFE0000000ULL },
    { 0x33D6BF95UL, 0x3E7AD7F2A0000000ULL },
};

typedef union { double d; unsigned long long u; } dbits;
typedef union { float f; unsigned int u; } fbits;

int main(void)
{
    int i;
    dbits x;
    fbits y;

    for (i = 0; i < (int)(sizeof(g_d2f) / sizeof(g_d2f[0])); i++) {
        x.u = g_d2f[i].in;
        y.f = (float)x.d;
        if (y.u != g_d2f[i].want) return 100 + i;
    }
    for (i = 0; i < (int)(sizeof(g_f2d) / sizeof(g_f2d[0])); i++) {
        y.u = g_f2d[i].in;
        x.d = (double)y.f;
        if (x.u != g_f2d[i].want) return 200 + i;
    }
    return 0;
}
""",
        },
        "build": link_with_runtime("f.c", "f.obj"),
        "expect": 0,
    },
    {
        "name": "setjmp_longjmp",
        "why": "setjmp/longjmp as real Thumb-2 functions assembled from a .s "
               "object (stdlib/src/arm/setjmp.s).  A C wrapper cannot capture "
               "its caller's sp and lr -- it can only capture its own frame, "
               "which the next call reuses -- so the jump has to be entered "
               "directly.  The case also links an assembly object after a "
               "data-carrying C object, which is where an assembler input used "
               "to inherit the previous file's SRAM window and make the linker "
               "try to relocate a window that had no patch sites",
        "files": {
            "sjmain.c": "#include <setjmp.h>\n" + STARTUP + """\
static jmp_buf back;
int sj_pad = 5;
static int dive(int n)
{
    if (n == 0) longjmp(back, 7);
    return dive(n - 1) + 1;
}
int main(void)
{
    int r = setjmp(back);
    if (r == 0) { dive(20); return 90; }     /* dive() never returns */
    if (r == 7) longjmp(back, 0);            /* C99 7.13.2.1p2: reads back as 1 */
    if (r != 1) return 91;
    return r + sj_pad + 6;                   /* 1 + 5 + 6 = 12 */
}
""",
        },
        "copy_stdlib": ["setjmp.s"],
        "include": ["stdlib/include"],
        "build": [
            (["sjmain.c", "-target", "arm", "-c", "--vector-table", "-o", "sjmain.obj"], None),
            (["setjmp.s", "-target", "arm", "-c", "-o", "setjmp.obj"], None),
            (["-link", "sjmain.obj", "setjmp.obj", "--vector-table", "-o", "out.bin"], "out.bin"),
        ],
        "expect": 12,
    },
    {
        "name": "const_fold_float",
        "why": "float constant expressions folded at compile time (C99 6.6): "
               "an explicit cast inside an enum, a cast initialiser, an "
               "implicit float->int initialiser, an array dimension and a "
               "64-bit initialiser.  Every operand is folded, so the image "
               "carries no VFP instruction and runs on the M-class unicorn, "
               "which has no FPU",
        "runtime": True,
        "files": {
            "fc.c": STARTUP + """\
enum { EA = (int)(1.5 + 1.5) };            /* 3: explicit cast, enum value */
int g_cast     = (int)(2.5 * 4.0);         /* 10: explicit cast in an initialiser */
int g_implicit = 2.5 * 4.0;                /* 10: implicit conversion (6.6) */
int g_neg      = -2.5 * 4.0;               /* -10: unary minus folds with the rest */
int g_arr[(int)(2.0 * 3.0)];               /* 6 elements */
long long g_ll = (long long)(1.5e6 * 2.0); /* 3000000 through the 8-byte path */
int main(void)
{
    int dim = (int)(sizeof g_arr / sizeof g_arr[0]);
    if (g_neg != -10) return 70;
    if (g_ll != 3000000LL) return 71;
    return EA + g_cast + g_implicit + dim;   /* 3 + 10 + 10 + 6 = 29 */
}
""",
        },
        "build": link_with_runtime("fc.c", "fc.obj"),
        "expect": 29,
    },
    {
        "name": "const_fold_float_reject",
        "why": "the same folding must refuse instead of inventing a value: a "
               "float array dimension and a dimension whose value is UB "
               "(1.0/0.0) are diagnostics, not a silent one-element array, "
               "and an out-of-range conversion is not folded into a global",
        "files": {
            "bad1.c": "int a[2.5];\nint main(void) { return (int)sizeof a; }\n",
            "bad2.c": "int a[(int)(1.0 / 0.0)];\nint main(void) { return (int)sizeof a; }\n",
            "bad3.c": "int g = (int)1e30;\nint main(void) { return g; }\n",
        },
        "build": [],
        "reject": [
            {"argv": ["bad1.c", "-target", "arm", "--vector-table", "-o", "o1.bin"],
             "expect_error": "not an integer constant expression"},
            {"argv": ["bad2.c", "-target", "arm", "--vector-table", "-o", "o2.bin"],
             "expect_error": "not an integer constant expression"},
            {"argv": ["bad3.c", "-target", "arm", "--vector-table", "-o", "o3.bin"],
             "expect_error": "cannot turn the initialiser"},
        ],
    },
    {
        "name": "tls_static_init",
        "why": "_Thread_local at file scope needs static or extern (C11 6.7.1p4) "
               "and the storage-class bits must not disturb the initialiser; on "
               "the flat ARM image TLS lives in ordinary .data/.bss, so the "
               "value semantics are checked by reading the byte back",
        "files": {
            "tls1.c": STARTUP + """\
static _Thread_local int counter = 7;
int main(void)
{
    counter = counter + 1;
    return counter;
}
""",
        },
        "build": [(["tls1.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 8,
    },
    {
        "name": "tls_block_static",
        "why": "block-scope static _Thread_local: one object, initialised once, "
               "kept across calls (3 -> 4 -> 5 -> 6)",
        "files": {
            "tls2.c": STARTUP + """\
int bump(void)
{
    static _Thread_local int n = 3;
    n = n + 1;
    return n;
}
int main(void)
{
    bump();
    bump();
    return bump();
}
""",
        },
        "build": [(["tls2.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 6,
    },
    {
        "name": "tls_reject",
        "why": "_Thread_local is standard C11, so the constraints are enforced "
               "instead of ignored: bare _Thread_local without static/extern, a "
               "function, and a typedef are three separate diagnostics and none "
               "of them may leave an image behind.  armcc's bare __thread stays "
               "exempt (tests/test_tls.c relies on it).  The fifth one covers a "
               "member, where C11 6.7.2.1 has no storage-class specifier at all",
        "files": {
            "bad1.c": "_Thread_local int counter = 0;\nint main(void) { return 0; }\n",
            "bad2.c": "_Thread_local int f(void);\nint main(void) { return 0; }\n",
            "bad3.c": "_Thread_local typedef int myint;\nint main(void) { return 0; }\n",
            "bad4.c": "int g(void) { _Thread_local int x = 1; return x; }\n"
                      "int main(void) { return g(); }\n",
            "bad5.c": "struct S { _Thread_local int x; };\n"
                      "int main(void) { return (int)sizeof(struct S); }\n",
        },
        "build": [],
        "reject": [
            {"argv": ["bad1.c", "-target", "arm", "--vector-table", "-o", "o1.bin"],
             "expect_error": "_Thread_local requires static or extern"},
            {"argv": ["bad2.c", "-target", "arm", "--vector-table", "-o", "o2.bin"],
             "expect_error": "thread-local storage applies to objects, not functions"},
            {"argv": ["bad3.c", "-target", "arm", "--vector-table", "-o", "o3.bin"],
             "expect_error": "thread-local storage cannot be used in a typedef"},
            {"argv": ["bad4.c", "-target", "arm", "--vector-table", "-o", "o4.bin"],
             "expect_error": "_Thread_local requires static or extern"},
            {"argv": ["bad5.c", "-target", "arm", "--vector-table", "-o", "o5.bin"],
             "expect_error": "thread-local storage cannot be used on a struct or union member"},
        ],
    },
    {
        "name": "atomic_rmw",
        "why": "C11 <stdatomic.h> on the flat ARM target: load/store, exchange, "
               "the two compare_exchange paths (success writes the object, failure "
               "writes the *expected* operand back), atomic_flag, and the five "
               "read-modify-write ops.  The 32-bit helpers run in a PRIMASK critical "
               "section, so the compiler needs the MRS/MSR builtins to be reachable "
               "without --asm-extra",
        "include": ["stdlib/include"],
        "files": {
            "a.c": STARTUP + """\
#include <stdatomic.h>

atomic_int g_cnt;
atomic_flag g_lock = ATOMIC_FLAG_INIT;

int main(void)
{
    int i, old, ok, expected;

    atomic_init(&g_cnt, 0);
    for (i = 0; i < 5; i++) {
        old = atomic_fetch_add(&g_cnt, 3);
        if (old != i * 3) return 1;
    }
    if (atomic_load(&g_cnt) != 15) return 2;

    atomic_store(&g_cnt, 7);
    if (atomic_exchange(&g_cnt, 9) != 7) return 3;
    if (atomic_load(&g_cnt) != 9) return 4;

    expected = 9;
    ok = atomic_compare_exchange_strong(&g_cnt, &expected, 11);
    if (ok != 1 || atomic_load(&g_cnt) != 11) return 5;
    expected = 100;
    ok = atomic_compare_exchange_strong(&g_cnt, &expected, 12);
    if (ok != 0 || expected != 11 || atomic_load(&g_cnt) != 11) return 6;

    if (atomic_flag_test_and_set(&g_lock) != 0) return 7;
    if (atomic_flag_test_and_set(&g_lock) != 1) return 8;
    atomic_flag_clear(&g_lock);
    if (atomic_flag_test_and_set(&g_lock) != 0) return 9;

    if (atomic_fetch_sub(&g_cnt, 1) != 11) return 10;
    if (atomic_fetch_or(&g_cnt, 4) != 10) return 11;
    if (atomic_fetch_and(&g_cnt, 12) != 14) return 12;
    if (atomic_fetch_xor(&g_cnt, 6) != 12) return 13;
    if (atomic_load(&g_cnt) != 10) return 14;

    return (int)atomic_load(&g_cnt);
}
""",
        },
        "build": [(["a.c", "-target", "arm", "-c", "--vector-table", "-o", "a.obj"], None),
                  (["-link", "a.obj", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 10,
    },
    {
        "name": "atomic_nested_mask",
        "why": "the interrupt-mask half of the atomic helpers: __arkcc_crit_save must "
               "return the *previous* PRIMASK and then disable interrupts, and "
               "__arkcc_crit_restore must put the saved value back, so nesting "
               "returns 0,1,1,0 rather than 0,0,0,0 (restore that always clears the "
               "mask would hand the caller an interrupt it did not ask for)",
        "files": {
            "m.c": STARTUP + """\
int  __arkcc_crit_save(void);
void __arkcc_crit_restore(int);

int g_dummy;

int main(void)
{
    int s0, s1, s2, s3, v;
    s0 = __arkcc_crit_save();
    s1 = __arkcc_crit_save();
    __arkcc_crit_restore(s1);
    s2 = __arkcc_crit_save();
    __arkcc_crit_restore(s0);
    s3 = __arkcc_crit_save();
    __arkcc_crit_restore(s3);
    v = (s0 & 1) | ((s1 & 1) << 1) | ((s2 & 1) << 2) | ((s3 & 1) << 3);
    return v;
}
""",
        },
        "build": [(["m.c", "-target", "arm", "-c", "--vector-table", "-o", "m.obj"], None),
                  (["-link", "m.obj", "--vector-table", "-o", "out.bin"], "out.bin")],
        "expect": 6,
    },
    {
        "name": "atomic_wide",
        "why": "64-bit atomics cannot be done with one instruction, so atomic_llong / "
               "atomic_ullong take the critical-section path for load and store too, "
               "and compare_exchange needs the two-word equality helper instead of "
               "AEABI vector equality.  The expected value of this case is 12/2 + "
               "4300000000%2 = 6, i.e. a value only reachable if the failing CAS left "
               "the object alone and reported failure",
        "include": ["stdlib/include"],
        "files": {
            "w.c": STARTUP + """\
#include <stdatomic.h>

atomic_llong g_wide;
atomic_ullong g_uwide;

int main(void)
{
    long long old;
    unsigned long long uold;
    long long exp;

    atomic_init(&g_wide, 1000000);
    old = atomic_fetch_add(&g_wide, 500000);
    if (old != 1000000) return 1;
    if (atomic_load(&g_wide) != 1500000) return 2;

    atomic_store(&g_wide, 7);
    if (atomic_exchange(&g_wide, 900000000) != 7) return 3;

    exp = 900000000;
    if (atomic_compare_exchange_strong(&g_wide, &exp, 12) != 1) return 4;
    if (atomic_load(&g_wide) != 12) return 5;
    exp = 99;
    if (atomic_compare_exchange_strong(&g_wide, &exp, 13) != 0) return 6;
    if (exp != 12) return 7;

    atomic_init(&g_uwide, 4000000000u);
    uold = atomic_fetch_add(&g_uwide, 300000000u);
    if (uold != 4000000000u) return 8;
    if (atomic_load(&g_uwide) != 4300000000u) return 9;

    return (int)(atomic_load(&g_wide) / 2) + (int)(atomic_load(&g_uwide) % 2);
}
""",
        },
        "build": link_with_runtime("w.c", "w.obj"),
        "runtime": True,
        "expect": 6,
    },
    {
        "name": "atomic_reject",
        "why": "_Atomic is parsed, not ignored: an array, a function and a struct are "
               "three separate diagnostics and none may leave an image behind",
        "include": ["stdlib/include"],
        "files": {
            "bad1.c": "_Atomic int arr[3];\nint main(void) { return 0; }\n",
            "bad2.c": "_Atomic int f(void);\nint main(void) { return 0; }\n",
            "bad3.c": "struct S { int x; };\n_Atomic struct S s;\n"
                      "int main(void) { return 0; }\n",
        },
        "build": [],
        "reject": [
            {"argv": ["bad1.c", "-target", "arm", "--vector-table", "-o", "o1.bin"],
             "expect_error": "an array type cannot be _Atomic"},
            {"argv": ["bad2.c", "-target", "arm", "--vector-table", "-o", "o2.bin"],
             "expect_error": "_Atomic cannot be applied to a function type"},
            {"argv": ["bad3.c", "-target", "arm", "--vector-table", "-o", "o3.bin"],
             "expect_error": "atomic struct/union types are not supported"},
        ],
    },
]

def build_case(arkcc, workdir, case, extra=()):
    for name, text in case["files"].items():
        with open(os.path.join(workdir, name), "w", newline="\n") as fh:
            fh.write(text)
    # Sources under test are the repository ones, copied in, so the gate
    # exercises exactly what ships: the AEABI helpers a flat image must
    # carry itself (the compiler emits calls to __aeabi_ldivmod & friends
    # but never links them in) and, for the setjmp case, the assembly
    # implementation from stdlib/src/arm.
    root = os.path.dirname(os.path.dirname(os.path.dirname(
        os.path.abspath(__file__))))
    srcdir = os.path.join(root, "stdlib", "src", "arm")
    needed = (("aeabi.c", "aeabi_divmod.s") if case.get("runtime") else ())
    needed = needed + tuple(case.get("copy_stdlib", ()))
    for fn in needed:
        src_path = os.path.join(srcdir, fn)
        if not os.path.exists(src_path):
            return "stdlib source missing: %s" % src_path
        shutil.copyfile(src_path, os.path.join(workdir, fn))
    incs = []
    for rel in case.get("include", ()):
        incs += ["-I", os.path.join(root, rel)]
    for argv, _ in case["build"]:
        proc = subprocess.run([arkcc] + list(argv) + incs + list(extra), cwd=workdir,
                              capture_output=True, text=True)
        if proc.returncode != 0:
            return "compile failed: %s %s" % (" ".join(argv), proc.stderr.strip() or proc.stdout.strip())
    return None


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    ap.add_argument("--keep", action="store_true")
    ap.add_argument("--selfcheck", action="store_true",
                    help="feed one case a deliberately wrong expectation and require "
                         "it to be rejected; a gate that cannot fail is not a gate")
    ap.add_argument("--extra", action="append", default=[],
                    help="extra arkcc flag for every case; repeat it, one flag per "
                         "call, and use the = form: --extra=-fopt-regalloc")
    args = ap.parse_args(argv)

    here = os.path.dirname(os.path.abspath(__file__))
    root = os.path.dirname(os.path.dirname(here))
    arkcc = args.arkcc or os.path.join(root, "arkcc.exe" if os.name == "nt" else "arkcc")
    if not os.path.exists(arkcc):
        print("[arm-exec] arkcc not found at %s; build first" % arkcc)
        return 2
    if not HAVE_UNICORN:
        print("[arm-exec] skipped: python package 'unicorn' is not installed "
              "(pip install unicorn)")
        return 0

    if args.extra:
        print("[arm-exec] extra flags: %s" % " ".join(args.extra))

    if args.selfcheck:
        # Anti-false-green: run the first case with a wrong expectation and
        # require the comparison above to reject it.  If this prints FAIL, the
        # expectations in CASES are not actually being checked.
        case = dict(CASES[0])
        case["expect"] = case["expect"] + 1
        workdir = tempfile.mkdtemp(prefix="arkexec_sc_")
        try:
            err = build_case(arkcc, workdir, case, args.extra)
            out = os.path.join(workdir, "out.bin")
            if err or not os.path.exists(out):
                print("[SELFCHECK] FAIL: could not build the self-check image: %s"
                      % (err or "no image"))
                return 1
            status, value, detail = run_case_image(case, out)
            if status == "returned" and value != case["expect"]:
                print("[SELFCHECK] expectation-mismatch: OK")
            else:
                print("[SELFCHECK] FAIL: the wrong expectation was accepted "
                      "(status=%s value=%d want=%d)" % (status, value, case["expect"]))
                return 1
        finally:
            if not args.keep:
                shutil.rmtree(workdir, ignore_errors=True)
    failures = 0
    for case in CASES:
        workdir = tempfile.mkdtemp(prefix="arkexec_")
        try:
            err = build_case(arkcc, workdir, case, args.extra)
            if err:
                print("[ FAIL ] %-18s %s" % (case["name"], err))
                failures += 1
                continue
            if "reject" in case:
                # Compile-time refuse path: the compiler must fail *and* say
                # why, and it must not leave an image behind.  The positive
                # case above proves the folding works, so this cannot pass
                # just because the feature is dead.
                bad = 0
                for item in case["reject"]:
                    proc = subprocess.run([arkcc] + list(item["argv"]) + list(args.extra),
                                          cwd=workdir, capture_output=True, text=True)
                    text = proc.stderr + proc.stdout
                    if proc.returncode == 0:
                        print("[ FAIL ] %-18s compiled but must refuse: %s"
                              % (case["name"], " ".join(item["argv"])))
                        bad += 1
                    elif item["expect_error"] not in text:
                        print("[ FAIL ] %-18s refused for the wrong reason: %s"
                              % (case["name"], text.strip()[:160]))
                        bad += 1
                    else:
                        out_name = item["argv"][item["argv"].index("-o") + 1]
                        if os.path.exists(os.path.join(workdir, out_name)):
                            print("[ FAIL ] %-18s image written despite the error: %s"
                                  % (case["name"], out_name))
                            bad += 1
                if bad:
                    failures += 1
                else:
                    print("[ ok ] %-18s %s" % (case["name"], case["why"]))
                continue
            if "link_must_fail" in case:
                proc = subprocess.run([arkcc] + case["link_must_fail"], cwd=workdir,
                                      capture_output=True, text=True)
                want = case["expect_error"]
                if proc.returncode == 0:
                    print("[ FAIL ] %-18s link succeeded but must refuse" % case["name"])
                    failures += 1
                elif want not in (proc.stderr + proc.stdout):
                    print("[ FAIL ] %-18s refused for the wrong reason: %s"
                          % (case["name"], (proc.stderr + proc.stdout).strip()[:160]))
                    failures += 1
                else:
                    print("[ ok ] %-18s %s" % (case["name"], case["why"]))
                continue
            out = os.path.join(workdir, "out.bin")
            if not os.path.exists(out):
                print("[ FAIL ] %-18s image not produced" % case["name"])
                failures += 1
                continue
            status, value, detail = run_case_image(case, out)
            if status != "returned":
                print("[ FAIL ] %-18s %s (%s)" % (case["name"], status, detail))
                failures += 1
            elif value != case["expect"]:
                print("[ FAIL ] %-18s returned %d, want %d"
                      % (case["name"], value, case["expect"]))
                failures += 1
            else:
                # Same program with the stack-top register optimisation: the
                # value must not depend on which code path produced it.
                err = build_case(arkcc, workdir, case, ("--reg-top",))
                if err:
                    print("[ FAIL ] %-18s --reg-top build: %s" % (case["name"], err))
                    failures += 1
                else:
                    status, value, detail = run_case_image(case, out)
                    if status != "returned" or value != case["expect"]:
                        print("[ FAIL ] %-18s --reg-top returned %s (%s), want %d"
                              % (case["name"], value, status, case["expect"]))
                        failures += 1
                    else:
                        print("[ ok ] %-18s %s" % (case["name"], case["why"]))
        finally:
            if not args.keep:
                shutil.rmtree(workdir, ignore_errors=True)
            else:
                print("        kept: %s" % workdir)

    print("\n%d failure(s)" % failures)
    return 0 if failures == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
