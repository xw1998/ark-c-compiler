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


def run_image(blob, max_insn=5000000):
    """Execute one raw arkc image.  Returns (status, value, detail)."""
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
        "build": [(["ll.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
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
        "build": [(["s.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
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
        "build": [(["a.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
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
        "build": [(["l.c", "-target", "arm", "--vector-table", "-o", "out.bin"], "out.bin")],
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
]


def build_case(arkcc, workdir, case, extra=()):
    for name, text in case["files"].items():
        with open(os.path.join(workdir, name), "w", newline="\n") as fh:
            fh.write(text)
    for argv, _ in case["build"]:
        proc = subprocess.run([arkcc] + list(argv) + list(extra), cwd=workdir,
                              capture_output=True, text=True)
        if proc.returncode != 0:
            return "compile failed: %s %s" % (" ".join(argv), proc.stderr.strip() or proc.stdout.strip())
    return None


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    ap.add_argument("--keep", action="store_true")
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
    failures = 0
    for case in CASES:
        workdir = tempfile.mkdtemp(prefix="arkexec_")
        try:
            err = build_case(arkcc, workdir, case, args.extra)
            if err:
                print("[ FAIL ] %-18s %s" % (case["name"], err))
                failures += 1
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
            with open(out, "rb") as fh:
                status, value, detail = run_image(fh.read())
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
                    with open(out, "rb") as fh:
                        status, value, detail = run_image(fh.read())
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
