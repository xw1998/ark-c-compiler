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

    failures = 0
    for case in CASES:
        workdir = tempfile.mkdtemp(prefix="arkexec_")
        try:
            err = build_case(arkcc, workdir, case)
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
