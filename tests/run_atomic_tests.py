#!/usr/bin/env python3
"""Gate for C11 <stdatomic.h> and for the compiler-emitted target identity macros.

What this proves -- and what it deliberately does not:

  * Exactly one __ARKCC_TARGET_* macro is defined per target, and the armcc
    arm macros (__arm__, __thumb__, __ARMCC_VERSION, ...) exist on the arm
    target only.  A header that decides "I am on ARM, take the critical
    section" must not be able to see __arm__ while compiling for x86_64: that
    would compile the wrong body *and* the wrong body would be accepted.
  * On the four non-ARM targets every atomic operation is a *compile-time*
    error naming the reason.  The alternative -- expanding, say, atomic_store
    to a plain store -- is a silent wrong answer, so it has to be unreachable
    rather than documented.
  * atomic_init stays portable: it is a plain assignment, and it is the one
    thing that must keep compiling everywhere, including targets with no
    atomics at all.

Correct behaviour on the arm target (real PRIMASK critical sections, the
64-bit path, compare_exchange writing the expected operand back on failure) is
executed rather than compiled by tests/arm_exec/run_arm_exec.py, cases
atomic_rmw / atomic_nested_mask / atomic_wide / atomic_reject.

The last stage is an anti-false-green self-check: the "must refuse" detector is
run against the arm target, where the same source must compile.  A gate whose
failure detector cannot tell the two apart is not a gate.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

TARGETS = ("arm", "x86", "x86_64", "riscv32", "c")
NON_ARM = tuple(t for t in TARGETS if t != "arm")
EXPECTED_NAME = {"arm": "arm", "x86": "x86", "x86_64": "x86_64",
                 "riscv32": "riscv32", "c": "c"}

# One operation per atomic API family.  The macro name each one expands to is
# what the error must quote, so a header that stops routing an operation
# through __ARKCC_NOATOMIC is caught by name and not by "some error appeared".
ATOMIC_OPS = [
    ("atomic_load",        "atomic_load(&g)",                        "load"),
    ("atomic_store",       "atomic_store(&g, 1)",                    "store"),
    ("atomic_exchange",    "atomic_exchange(&g, 1)",                 "exchange"),
    ("atomic_cas_strong",  "atomic_compare_exchange_strong(&g, &e, 1)", "compare_exchange"),
    ("atomic_cas_weak",    "atomic_compare_exchange_weak(&g, &e, 1)",   "compare_exchange"),
    ("atomic_fetch_add",   "atomic_fetch_add(&g, 1)",                "fetch_add"),
    ("atomic_fetch_xor",   "atomic_fetch_xor(&g, 1)",                "fetch_xor"),
    ("atomic_flag_set",    "atomic_flag_test_and_set(&f)",           "flag_test_and_set"),
    ("atomic_flag_clear",  "atomic_flag_clear(&f)",                  "flag_clear"),
    ("atomic_thread_fence", "atomic_thread_fence(memory_order_seq_cst)", "thread_fence"),
    ("atomic_signal_fence", "atomic_signal_fence(memory_order_seq_cst)", "signal_fence"),
]

IDENTITY_SRC = """\
#if !defined(__ARKCC_TARGET_NAME)
#error no target identity macro
#endif
#if (defined(__ARKCC_TARGET_ARM) + defined(__ARKCC_TARGET_X86) + \\
     defined(__ARKCC_TARGET_X86_64) + defined(__ARKCC_TARGET_RISCV32) + \\
     defined(__ARKCC_TARGET_C)) != 1
#error target identity is not exactly one macro
#endif
const char *arkcc_target_name = __ARKCC_TARGET_NAME;
#ifdef __arm__
int saw_arm = 1;
#endif
#ifdef __thumb__
int saw_thumb = 1;
#endif
#ifdef __ARMCC_VERSION
int saw_armcc = 1;
#endif
"""

ATOMIC_CALL_SRC = """\
#include <stdatomic.h>
atomic_int g;
atomic_flag f = ATOMIC_FLAG_INIT;
int main(void)
{
    int e = 0;
    long long r = (long long)(%s);
    return (int)r;
}
"""

def write(path, text):
    with open(path, "w", newline="\n") as fh:
        fh.write(text)


class Gate:
    def __init__(self, arkcc, incdir):
        self.arkcc = os.path.abspath(arkcc)
        self.incdir = incdir
        self.fail = 0

    def bad(self, msg):
        print("FAIL %s" % msg)
        self.fail += 1

    def run(self, argv, cwd):
        return subprocess.run([self.arkcc] + list(argv), cwd=cwd,
                              capture_output=True, text=True, errors="replace")

    # -- 1: target identity --------------------------------------------------
    def check_identity(self, work, target):
        src = os.path.join(work, "ident.c")
        write(src, IDENTITY_SRC)
        out = os.path.join(work, "ident.i")
        args = [src, "-target", target, "-E", "-o", out]
        proc = self.run(args, work)
        if proc.returncode != 0:
            self.bad("%-8s identity source refused to preprocess: %s"
                     % (target, (proc.stderr + proc.stdout).strip()[:200]))
            return
        text = open(out, encoding="utf-8", errors="replace").read()
        want = '"%s"' % EXPECTED_NAME[target]
        if ("arkcc_target_name = %s;" % want) not in text:
            self.bad("%-8s __ARKCC_TARGET_NAME did not expand to %s"
                     % (target, want))
        for macro in ("saw_arm", "saw_thumb", "saw_armcc"):
            present = macro in text
            if present != (target == "arm"):
                self.bad("%-8s %s %s" % (target, macro,
                         "is defined but must not be" if present else "is missing"))
        print("ok   identity   %-8s exactly one __ARKCC_TARGET_*, armcc arm macros "
              "%s" % (target, "present" if target == "arm" else "absent"))

    # -- 2: every atomic op must be refused off ARM --------------------------
    def check_refusal(self, work, target):
        for label, expr, what in ATOMIC_OPS:
            src = os.path.join(work, "op.c")
            write(src, ATOMIC_CALL_SRC % expr)
            out = os.path.join(work, "op.s")
            if os.path.exists(out):
                os.remove(out)
            proc = self.run([src, "-target", target, "-I", self.incdir,
                             "-S", "-o", out], work)
            text = proc.stderr + proc.stdout
            needle = "__arkcc_atomic_%s_not_supported_on_this_target_use_a_mutex" % what
            if proc.returncode == 0:
                self.bad("%-8s %s compiled but has no atomic path on this target"
                         % (target, label))
            elif needle not in text:
                self.bad("%-8s %s refused for the wrong reason: %s"
                         % (target, label, text.strip()[:160]))
            elif os.path.exists(out):
                self.bad("%-8s %s wrote %s despite the error"
                         % (target, label, os.path.basename(out)))
        print("ok   refuse     %-8s %d atomic operations are compile-time errors "
              "naming the reason" % (target, len(ATOMIC_OPS)))

    # -- 3: atomic_init stays portable --------------------------------------
    def check_init(self, work, target):
        src = os.path.join(work, "init.c")
        write(src, "#include <stdatomic.h>\n"
                   "atomic_int g;\n"
                   "int main(void) { atomic_init(&g, 5); return g - 5; }\n")
        proc = self.run([src, "-target", target, "-I", self.incdir,
                         "-S", "-o", os.path.join(work, "init.s")], work)
        if proc.returncode != 0:
            self.bad("%-8s atomic_init is a plain assignment and must compile: %s"
                     % (target, (proc.stderr + proc.stdout).strip()[:200]))
            return
        print("ok   init       %-8s atomic_init (and the typedefs) compile" % target)

    # -- 4: anti-false-green -------------------------------------------------
    def selfcheck(self, work):
        """The refusal detector must not fire on the arm target."""
        src = os.path.join(work, "sc.c")
        write(src, ATOMIC_CALL_SRC % "atomic_load(&g)")
        proc = self.run([src, "-target", "arm", "-I", self.incdir,
                         "-S", "-o", os.path.join(work, "sc.s")], work)
        if proc.returncode != 0:
            print("[SELFCHECK] FAIL: the same source was refused on arm too, so "
                  "'refused off ARM' proves nothing: %s"
                  % (proc.stderr + proc.stdout).strip()[:200])
            return False
        print("[SELFCHECK] refusal-is-target-specific: OK")
        return True


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    ap.add_argument("--keep", action="store_true")
    args = ap.parse_args(argv)

    here = os.path.dirname(os.path.abspath(__file__))
    root = os.path.dirname(here)
    arkcc = args.arkcc or os.path.join(root, "arkcc.exe" if os.name == "nt" else "arkcc")
    if not os.path.exists(arkcc):
        print("[atomic] arkcc not found at %s; build first" % arkcc)
        return 2
    incdir = os.path.join(root, "stdlib", "include")
    if not os.path.exists(os.path.join(incdir, "stdatomic.h")):
        print("[atomic] %s/stdatomic.h is missing" % incdir)
        return 2

    work = tempfile.mkdtemp(prefix="arkatomic_")
    try:
        gate = Gate(arkcc, incdir)
        for target in TARGETS:
            gate.check_identity(work, target)
        for target in NON_ARM:
            gate.check_refusal(work, target)
        for target in TARGETS:
            gate.check_init(work, target)
        if not gate.selfcheck(work):
            gate.fail += 1
    finally:
        if not args.keep:
            shutil.rmtree(work, ignore_errors=True)

    if gate.fail:
        print("=== %d failure(s) ===" % gate.fail)
        return 1
    print("=== atomic: all checks passed ===")
    return 0


if __name__ == "__main__":
    sys.exit(main())
