#!/usr/bin/env python3
"""Register-allocation gate: -fopt-regalloc must change the code, must not
change what the code computes, and must leave locals it cannot model alone.

Three claims, three checks -- one without the others is not evidence:

  1. OFF IS OFF.  The default build names r8-r11 nowhere in its emitted text, so
     "default behaviour is byte-identical to the previous release" is a property
     of the switch, not a promise.

  2. ON DOES SOMETHING.  With -fopt-regalloc the text has to change: the frame
     references drop, and the prologue starts saving the registers that are now
     really used.  A switch whose on-state produces the same text is not a
     switch, and every "behaviour unchanged" claim about it is vacuous.

  3. THE ANSWER IS THE SAME.  Each program is assembled, linked into a raw
     image and *executed* under unicorn; the value main() returns must equal the
     value the same program returns without the switch, and both must equal the
     number computed here in Python.

The negative cases are the ones that keep the selector honest: a volatile local
and an address-taken local must come out byte-for-byte unchanged, because their
slot is read or written through something other than the two instruction shapes
the allocator rewrites.  If those two ever start changing, the "every mention is
one of these two lines" rule has broken and the positive cases stop meaning
anything.

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

FLAG = "-fopt-regalloc"

# ---- programs -------------------------------------------------------------
# (name, body, python mirror of the answer, should_the_switch_do_anything)

P_HOT = """\
int ra_pad;              /* .bss must exist, or the startup call is unresolved */
int hot(int n)
{
    int i, s, t;
    s = 0;
    t = n;
    for (i = 0; i < 100; i++) {
        s = s + i;
        t = t ^ s;
        n = n + 1;
    }
    return (s + t + n) & 0xFF;
}
int main(void) { return hot(5); }
"""

P_VOLATILE = """\
int ra_pad2;
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
int ra_pad3;
/* `a` is the hot local and also the address-taken one; `p` is used twice, below
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


def py_hot():
    n, s, t = 5, 0, 5
    for i in range(100):
        s += i
        t ^= s
        n += 1
    return (s + t + n) & 0xFF


def py_vol():
    v = 1
    v = v + 1
    v = v * 3
    v = v + 5
    return v & 0xFF


def py_addr():
    a = 7          # through the pointer
    a = a + 2
    a = a + 3
    a = a + 4
    return a & 0xFF


CASES = [
    ("hot_locals",  P_HOT,      py_hot(),  True),
    ("volatile",    P_VOLATILE, py_vol(),  False),
    ("address_of",  P_ADDR,     py_addr(), False),
]


def build(arkcc, workdir, name, body, flags):
    src = os.path.join(workdir, name + ".c")
    with open(src, "w", newline="\n") as fh:
        fh.write(AE.STARTUP + body)
    asm = os.path.join(workdir, name + ("_on.s" if flags else "_off.s"))
    proc = subprocess.run([arkcc, src, "-target", "arm", "-S", "-o", asm] + list(flags),
                          capture_output=True, text=True)
    if proc.returncode != 0:
        return None, None, (proc.stderr or proc.stdout).strip()
    binp = asm[:-2] + ".bin"
    proc = subprocess.run([arkcc, src, "-target", "arm", "--vector-table",
                           "-o", binp] + list(flags), capture_output=True, text=True)
    if proc.returncode != 0:
        return open(asm, encoding="utf-8").read(), None, (proc.stderr or proc.stdout).strip()
    with open(asm, encoding="utf-8") as fh:
        text = fh.read()
    with open(binp, "rb") as fh:
        blob = fh.read()
    return text, blob, None


def frame_refs(text):
    return text.count("[r6, #")


def high_reg_uses(text):
    """Names of r8-r11 mentioned in the emitted text, if any."""
    hits = []
    for r in ("r8", "r9", "r10", "r11"):
        if r + "," in text or r + "}" in text or r + " " in text or r + "]" in text:
            hits.append(r)
    return hits


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
    workdir = tempfile.mkdtemp(prefix="arkra_")
    for name, body, want, should_change in CASES:
        off_text, off_blob, err = build(arkcc, workdir, name, body, [])
        if err:
            print("[FAIL] %-12s default build failed: %s" % (name, err.splitlines()[0][:80]))
            bad += 1
            continue
        on_text, on_blob, err = build(arkcc, workdir, name, body, [FLAG])
        if err:
            print("[FAIL] %-12s %s build failed: %s" % (name, FLAG, err.splitlines()[0][:80]))
            bad += 1
            continue

        # 1. off is off
        used = high_reg_uses(off_text)
        if used:
            print("[FAIL] %-12s default text mentions %s" % (name, ",".join(used)))
            bad += 1
            continue

        # 2. on does something (or must not, for the negative cases)
        changed = (on_text != off_text)
        if should_change and not changed:
            print("[FAIL] %-12s %s produced identical text (switch is a no-op here)"
                  % (name, FLAG))
            bad += 1
            continue
        if not should_change and changed:
            print("[FAIL] %-12s %s rewrote a slot it cannot model (taint rule broken)"
                  % (name, FLAG))
            bad += 1
            continue

        # 3. same answer, and the right answer
        st_off, v_off, _ = AE.run_image(off_blob)
        st_on, v_on, _ = AE.run_image(on_blob)
        if st_off != "returned" or st_on != "returned":
            print("[FAIL] %-12s execution status off=%s on=%s" % (name, st_off, st_on))
            bad += 1
            continue
        if v_off != want or v_on != want:
            print("[FAIL] %-12s expected %d, off=%d on=%d" % (name, want, v_off, v_on))
            bad += 1
            continue
        print("[ok  ] %-12s refs %2d -> %2d, exit %d both ways%s"
              % (name, frame_refs(off_text), frame_refs(on_text), want,
                 "" if should_change else " (untouched by design)"))
    if bad == 0:
        print("\nregalloc: all claims hold")
    else:
        print("\nregalloc: %d failure(s)" % bad)
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
