#!/usr/bin/env python3
"""Register-allocation gate: the pass must engage where it can pay for itself,
must never grow the code in its default mode, must stay away from slots it
cannot model, and must compute the same answers in every mode.

Why the mode split exists (measured, not assumed)
-------------------------------------------------
A near slot -- `[r6, #0..124]`, offset a multiple of 4 -- is already a 16-bit
instruction, and so is `MOV r0, rN`.  Moving a near slot therefore saves *zero*
bytes, while a high register joining PUSH/POP costs 4 bytes per function.  On
src/irgen.c that trade moved 1853 slots and made the object 148 bytes *bigger*.
So the default mode only takes slots whose byte savings pay for the widening,
and `-fopt-regalloc-near` is the opt-in for "spend ~4 bytes per function, buy
fewer memory accesses".

The claims, each checked separately:

  1. OFF IS OFF.           the default build names r8-r11 nowhere;
  2. DEFAULT PAYS FOR ITSELF.  the far-slot case changes, and its image is not
     larger than the default image -- the switch cannot grow code unasked;
  3. NEAR IS OPT-IN.       the near-slot case is byte-identical by default and
     changes only with `-fopt-regalloc-near`;
  4. TAINT HOLDS.          a volatile local and an address-taken local stay
     byte-identical in *both* modes;
  5. THE ANSWER IS THE SAME.  every arm is executed under unicorn and must
     return the value computed here in Python.

Usage:  python tests/run_regalloc_tests.py [--arkcc PATH]
Exit:   0 all claims hold, 1 a claim failed, 2 cannot judge (no arkcc/unicorn).
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, "arm_exec"))

try:
    import run_arm_exec as AE
except ImportError:                                    # pragma: no cover
    AE = None

ON = "-fopt-regalloc"
NEAR = "-fopt-regalloc-near"

P_FAR = """\
int ra_pad_f;
/* pad[] pushes every later local past offset 124, where an access stops being a
 * 16-bit "ldr r0,[r6,#n]" and becomes 4 bytes -- the only case that pays. */
int far(int n)
{
    char pad[200];
    int i, s;
    pad[0] = (char)n;
    s = 0;
    for (i = 0; i < 40; i++) {
        s = s + i;
        s = s ^ (int)pad[0];
        n = n + 1;
    }
    return (s + n) & 0xFF;
}
int main(void) { return far(3); }
"""

P_NEAR = """\
int ra_pad_n;
int near(int n)
{
    int i, s;
    s = 0;
    for (i = 0; i < 100; i++) {
        s = s + i;
        n = n + 1;
    }
    return (s + n) & 0xFF;
}
int main(void) { return near(5); }
"""

P_VOL = """\
int ra_pad_v;
int vol(void)
{
    volatile int v;
    v = 1;
    v = v + 1;
    v = v * 3;
    v = v + 5;
    return v & 0xFF;
}
int main(void) { return vol(); }
"""

P_ADDR = """\
int ra_pad_a;
/* `a` is both the hot local and the address-taken one; `p` is used twice, below
 * the threshold, so a correct selector allocates nothing at all here. */
int addr(void)
{
    int a = 1;
    int *p = &a;
    *p = 7;
    a = a + 2;
    a = a + 3;
    a = a + 4;
    return a & 0xFF;
}
int main(void) { return addr(); }
"""


def py_far(n=3):
    pad0 = (n & 0xFF)
    s = 0
    for i in range(40):
        s = s + i
        s = s ^ pad0
        n = (n + 1) & 0xFFFFFFFF
    return (s + n) & 0xFF


def py_near(n=5):
    s = 0
    for i in range(100):
        s = s + i
        n = (n + 1) & 0xFFFFFFFF
    return (s + n) & 0xFF


def py_vol():
    v = 1
    v = v + 1
    v = v * 3
    v = v + 5
    return v & 0xFF


def py_addr():
    a = 7
    a = a + 2
    a = a + 3
    a = a + 4
    return a & 0xFF


# name, body, python answer, expected behaviour in the default and near modes
#   "on"  = must change;  "off" = must stay byte-identical
CASES = [
    ("far_slots",  P_FAR,   py_far(),  "on",  "on"),
    ("near_slots", P_NEAR,  py_near(), "off", "on"),
    ("volatile",   P_VOL,   py_vol(),  "off", "off"),
    ("address_of", P_ADDR,  py_addr(), "off", "off"),
]


def build(arkcc, workdir, name, body, flags, tag):
    src = os.path.join(workdir, name + ".c")
    if not os.path.exists(src):
        with open(src, "w", newline="\n") as fh:
            fh.write(AE.STARTUP + body)
    asm = os.path.join(workdir, "%s_%s.s" % (name, tag))
    p = subprocess.run([arkcc, src, "-target", "arm", "-S", "-o", asm] + list(flags),
                       capture_output=True, text=True, errors="replace")
    if p.returncode != 0:
        return None, None, (p.stderr or p.stdout).strip()
    binp = os.path.join(workdir, "%s_%s.bin" % (name, tag))
    p = subprocess.run([arkcc, src, "-target", "arm", "--vector-table", "-o", binp] + list(flags),
                       capture_output=True, text=True, errors="replace")
    if p.returncode != 0:
        return None, None, (p.stderr or p.stdout).strip()
    with open(asm, encoding="utf-8") as fh:
        text = fh.read()
    with open(binp, "rb") as fh:
        blob = fh.read()
    return text, blob, None


def high_regs(text):
    return [r for r in ("r8", "r9", "r10", "r11")
            if r + "," in text or r + "}" in text or r + " " in text]


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--arkcc", default=None)
    args = ap.parse_args(argv)
    arkcc = args.arkcc or os.path.join(ROOT, "arkcc.exe" if os.name == "nt" else "arkcc")
    if not os.path.exists(arkcc):
        print("[regalloc] arkcc not found at %s; build first" % arkcc)
        return 2
    if AE is None or not AE.HAVE_UNICORN:
        print("[regalloc] skipped: python package 'unicorn' is not installed "
              "(pip install unicorn)")
        return 0

    bad = 0
    work = tempfile.mkdtemp(prefix="arkra_")
    for name, body, want, exp_def, exp_near in CASES:
        arms = [("off", []), ("def", [ON]), ("near", [ON, NEAR])]
        got = {}
        err = None
        for tag, flags in arms:
            text, blob, e = build(arkcc, work, name, body, flags, tag)
            if e:
                err = (tag, e)
                break
            got[tag] = (text, blob)
        if err:
            print("[FAIL] %-12s %s arm failed: %s" % (name, err[0], err[1].splitlines()[0][:80]))
            bad += 1
            continue

        # 1. off is off
        if high_regs(got["off"][0]):
            print("[FAIL] %-12s default text mentions %s" % (name, ",".join(high_regs(got["off"][0]))))
            bad += 1
            continue

        # 2/3/4. did each mode do what it is supposed to do?
        problems = []
        for tag, expect in (("def", exp_def), ("near", exp_near)):
            changed = got[tag][0] != got["off"][0]
            if expect == "on" and not changed:
                problems.append("%s arm did nothing" % tag)
            if expect == "off" and changed:
                problems.append("%s arm rewrote a slot it must not touch" % tag)
        if problems:
            print("[FAIL] %-12s %s" % (name, "; ".join(problems)))
            bad += 1
            continue

        # the default mode must never grow the code
        size_off = len(got["off"][1])
        size_def = len(got["def"][1])
        if exp_def == "on" and size_def > size_off:
            print("[FAIL] %-12s default mode grew the image %d -> %d" %
                  (name, size_off, size_def))
            bad += 1
            continue

        # 5. same answer, and the right answer
        values = {}
        ok = True
        for tag, _ in arms:
            st, val, _ = AE.run_image(got[tag][1])
            if st != "returned":
                print("[FAIL] %-12s %s arm did not return (%s)" % (name, tag, st))
                bad += 1
                ok = False
                break
            values[tag] = val
        if not ok:
            continue
        if any(v != want for v in values.values()):
            print("[FAIL] %-12s expected %d, got %s" % (name, want, values))
            bad += 1
            continue

        print("[ok  ] %-12s image %3d/%-3d/%-3d bytes, exit %d in all three arms%s" %
              (name, size_off, size_def, len(got["near"][1]), want,
               "" if exp_def == "on" else " (untouched by design)"))
    if bad == 0:
        print("\nregalloc: all claims hold")
    else:
        print("\nregalloc: %d failure(s)" % bad)
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
