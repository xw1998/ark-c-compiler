#!/usr/bin/env python3
"""Gate for the redundant frame access removal (0.9.1, -fopt-slotreg).

The backend keeps every named local in the frame and moves it through r0: a
statement that assigns one loads it, a later statement loads it again.  Inside
one straight-line block that second load is redundant whenever r0 still holds
the value, and a store whose value is never loaded at all is dead.  This pass
removes exactly those two shapes and nothing else:

  R1  `LDR r0, [r6, #o]` dropped when the block already established that r0
      holds slot o (an earlier `LDR`/`STR r0` of the same slot, with nothing in
      between that writes r0 or changes the slot).

  R2  `STR r0, [r6, #o]` dropped when no `LDR r0` reads the slot anywhere in
      the function and no escaped frame address reaches it, or when a later
      store to the same slot in the same block overwrites it before any load.

Safety rests on two things this gate pins: (a) a line that names r6 in a shape
other than those two abandons the function, and an address that escapes the
frame marks every slot at or above it as indirectly readable, so "nothing loads
it" stops counting as evidence; (b) nothing is ever inserted, so a function can
only get shorter.

Checks:

  1. OFF IS OFF.  Default build and `-fno-opt-slotreg` are byte-identical.
  2. R1 FIRES.  A second load of a slot whose value is already in r0 is gone
     and the instruction count drops.
  3. R2 FIRES.  A zero-initialising store that the next statement overwrites
     is gone.
  4. ONLY THOSE TWO SHAPES.  Every removed line is `LDR r0, [r6, #n]` or
     `STR r0, [r6, #n]`; the kept text is a subsequence of the original text
     (nothing is rewritten or inserted); no image grows.
  5. ESCAPE AND VOLATILE ARE LEFT ALONE.  A struct copy through `memcpy` and a
     `volatile` local come out byte-identical -- these are the two shapes whose
     removal would change an answer without changing the instruction budget.
  6. A CALL IS A BOUNDARY.  The body of a function that stores a local, calls,
     and then loads it back keeps every line.
  7. THE ANSWER IS THE SAME.  Every fixture is executed on the emulator in
     three arms (off / on / on alone) and must return the Python answer.
  8. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_SLOTREG=0 refuses
     `-fopt-slotreg` by name (C3900U) and still compiles without the flag.

Usage: run_slotreg_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import difflib
import os
import re
import shutil
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
try:
    import run_vstack_tests as V
except Exception:                                        # pragma: no cover
    print('FAIL  cannot import tests/run_vstack_tests.py helpers')
    sys.exit(2)

FLAG = '-fopt-slotreg'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The pass runs before -fopt-cmat, so the gate measures it on top of the whole
# 0.9.1 set: the twelve switches plus cmat are the baseline the corpus number
# in docs/SLOTREG.md was taken against.
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch',
        '-fopt-copyprop', '-fopt-live', '-fopt-prop', '-fopt-deadpush',
        '-fopt-cmat']

# --- fixtures ---------------------------------------------------------------
# R1: the second `s = ...` reads a slot whose value is already in r0.
CHAIN = """\
int sr_pad;
int sr_chain(int a, int b)
{
    int s;
    s = a + b;
    s = s + a;
    return s;
}
int main(void) { return sr_chain(3, 4); }
"""

# R2: the zero initialiser is overwritten by the very next statement.
DEAD = """\
int sr_pad;
int sr_dead(int a)
{
    int s = 0;
    s = a * 2;
    return s;
}
int main(void) { return sr_dead(6); }
"""

# Two branches that write the same slot, then one read of it.
IFELSE = """\
int sr_pad;
int sr_pick(int k, int a, int b)
{
    int r;
    if (k) r = a * 3; else r = b + 7;
    return r;
}
int main(void) { return sr_pick(1, 4, 9) + sr_pick(0, 4, 9); }
"""

# A store, a call, then a load of the same slot: the load must not be folded
# across the call even though nothing in the callee can name the slot.
CALL = """\
int sr_pad;
int sr_cal(int x) { return x * 5; }
int sr_bl(int a)
{
    int t = a + 1;
    int u = 0;
    u = a * 2;
    t = t + sr_cal(a);
    return t + u;
}
int main(void) { return sr_bl(3); }
"""

# The address of a local escapes into memcpy: "nothing loads this slot" is not
# evidence of "nothing reads it", so the function must come out untouched.
ESCAPE = """\
int sr_pad;
struct srP { int x, y; };
int sr_sum(struct srP p) { return p.x + p.y; }
int sr_esc(int k, struct srP a, struct srP b)
{
    struct srP c;
    c = k ? a : b;
    return sr_sum(c) + c.y;
}
int main(void)
{
    struct srP a = {1, 2}, b = {3, 4};
    return sr_esc(1, a, b) + sr_esc(0, a, b);
}
"""

# volatile exists to keep the accesses it names.
VOLATILE = """\
int sr_pad;
int sr_vol(void)
{
    volatile int v = 1;
    v = v + 2;
    v = 3;
    return v;
}
int main(void) { return sr_vol(); }
"""

# 64-bit locals are two words with separate loads; only the low word can ever
# be cached in r0, so the shape must stay correct on both halves.
WIDE = """\
int sr_pad;
long long sr_w(long long a, int n) { long long s = a; s = s + n; return s; }
int main(void) { return (int)sr_w(40, 10); }
"""

CASES = [
    ('chain', CHAIN, 10),
    ('dead', DEAD, 12),
    ('ifelse', IFELSE, 28),
    ('call', CALL, 25),
    ('escape', ESCAPE, 16),
    ('volatile', VOLATILE, 3),
    ('wide', WIDE, 50),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

SLOT_RE = re.compile(r'^\s+(?:LDR|STR) r0, \[r6, #\d+\]\s*$')


def func_text(text, name):
    """The body of one function, from `name:` up to the line before .size."""
    out = []
    inside = False
    for ln in text.splitlines():
        st = ln.strip()
        if not inside:
            if st == name + ':':
                inside = True
            continue
        if st.startswith('.size') and name in st:
            break
        out.append(ln)
    return out


def removed(off, on):
    """Lines present in `off` and absent from `on`, in order."""
    sm = difflib.SequenceMatcher(None, off, on)
    gone = []
    for tag, i1, i2, _j1, _j2 in sm.get_opcodes():
        if tag in ('delete', 'replace'):
            gone.extend(off[i1:i2])
    return gone


def is_subsequence(small, big):
    it = iter(big)
    return all(any(x == y for y in it) for x in small)


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_slotreg_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'chain', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'chain',
                             BASE + ['-fno-opt-slotreg'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-slotreg)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2..4. the two rules, and only them -----------------------------
        arms = {}
        for name, _body, _want in CASES:
            t_off, b_off, e3 = build(arkcc, work, name, BASE, name + '_off')
            t_on, b_on, e4 = build(arkcc, work, name, BASE + [FLAG],
                                   name + '_on')
            if e3 or e4:
                check(False, '%s: both arms build' % name,
                      (e3 or e4)[0][:120])
                continue
            arms[name] = (t_off, b_off, t_on, b_on)
            gone = removed(t_off.splitlines(), t_on.splitlines())
            bad = [ln for ln in gone if not SLOT_RE.match(ln)]
            check(not bad,
                  '%s: every removed line is a frame access through r0' % name,
                  ('%d line(s), e.g. %r' % (len(bad), bad[0].strip()))
                  if bad else '%d line(s) removed' % len(gone))
            check(is_subsequence(t_on.splitlines(), t_off.splitlines()),
                  '%s: the output is the input with lines removed' % name,
                  '%d -> %d line(s)' % (len(t_off.splitlines()),
                                        len(t_on.splitlines())))
            check(len(b_on) <= len(b_off),
                  '%s: the image never grows' % name,
                  '%d -> %d bytes' % (len(b_off), len(b_on)))

        # --- 2. R1 fires inside the function under test ---------------------
        # sr_pick spills its parameter and the first use of it is a reload of
        # the very same register -- value stack or not, that load is redundant.
        if 'ifelse' in arms:
            t_off, _b_off, t_on, _b_on = arms['ifelse']
            f_off = func_text(t_off, 'sr_pick')
            f_on = func_text(t_on, 'sr_pick')
            gone = removed(f_off, f_on)
            check(any('LDR r0, [r6, #' in ln for ln in gone) and
                  insn_count('\n'.join(f_on)) < insn_count('\n'.join(f_off)),
                  'R1: a load of a slot already in r0 is gone',
                  '%d -> %d instruction(s)'
                  % (insn_count('\n'.join(f_off)), insn_count('\n'.join(f_on))))

        # --- 3. R2 fires inside the function under test ---------------------
        if 'dead' in arms:
            t_off, _b_off, t_on, _b_on = arms['dead']
            f_off = func_text(t_off, 'sr_dead')
            f_on = func_text(t_on, 'sr_dead')
            gone = removed(f_off, f_on)
            check(sum(1 for ln in gone if 'STR r0, [r6, #' in ln) >= 2 and
                  insn_count('\n'.join(f_on)) < insn_count('\n'.join(f_off)),
                  'R2: a store the next statement overwrites is gone',
                  '%d -> %d instruction(s)'
                  % (insn_count('\n'.join(f_off)), insn_count('\n'.join(f_on))))

        # --- 5. escape and volatile are left alone --------------------------
        for name, fn in (('escape', 'sr_esc'), ('volatile', 'sr_vol')):
            if name not in arms:
                continue
            t_off, _b_off, t_on, _b_on = arms[name]
            f_off = func_text(t_off, fn)
            f_on = func_text(t_on, fn)
            check(f_off == f_on,
                  '%s: %s keeps every line (its accesses are not redundant)'
                  % (name, fn),
                  '%d/%d line(s)' % (len(f_off), len(f_on)))

        # --- 6. a call is a boundary ----------------------------------------
        if 'call' in arms:
            t_off, _b_off, t_on, _b_on = arms['call']
            f_off = func_text(t_off, 'sr_bl')
            f_on = func_text(t_on, 'sr_bl')
            gone = removed(f_off, f_on)
            check(not any('LDR r0, [r6, #' in ln for ln in gone),
                  'call: no load is folded across the call',
                  '%d line(s) removed' % len(gone))

        # --- 7. the answers stay the same -----------------------------------
        for name, _body, want in CASES:
            if name not in arms:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name,
                     'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag, flags in (('off', BASE), ('on', BASE + [FLAG]),
                               ('alone', [FLAG])):
                t, blob, err = build(arkcc, work, name, flags, 'v' + tag)
                if err:
                    check(False, '%s: %s arm builds' % (name, tag),
                          err[0][:120])
                    ok = False
                    break
                st, val, _ = V.run_image(blob)
                got[tag] = val if st == 'returned' else st
            if ok:
                check(all(got[t] == want for t in got),
                      '%s: off/on/alone return the Python answer' % name,
                      ' '.join('%s=%s' % (t, got[t])
                               for t in ('off', 'on', 'alone'))
                      + ' want=%s' % want)

        # --- 8. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_SLOTREG=0'],
                                   'arkcc_noslotreg')
        if trimmed is None:
            skip('a cropped build refuses -fopt-slotreg', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'chain.c'), '-o', 't.s', FLAG],
                          work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-slotreg by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'chain.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nslotreg: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nslotreg: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
