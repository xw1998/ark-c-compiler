#!/usr/bin/env python3
"""Gate for slot promotion (0.9.1, -fopt-vreg / S6a).

Every named local lives in the frame and travels through r0: a straight-line
run reloads a slot it has just stored.  -fopt-regalloc and -fopt-constcache
keep a *value* in r8-r11 but still pay one MOV per access, so the count never
moves.  -fopt-vreg promotes the *slot*: the load that feeds the very next
instruction is deleted and that instruction reads the cache register instead
(rename elision), a store becomes a copy, and a load whose consumer cannot be
renamed becomes a copy.  Nothing is ever inserted that was not there before,
so the pass cannot grow a function.

Checks, each of which a plausible wrong implementation would fail:

  1. OFF IS OFF.  The default build and `-fno-opt-vreg` are byte-identical,
     assembly and image.
  2. IT PAYS.  On the reload fixtures the flag strictly reduces the instruction
     count, and no fixture's instruction count grows -- the pass has no form
     that adds an instruction.
  3. THE FRAME IS ONE FRAME.  When a promotion happens the prologue and the
     epilogue gain the *same* registers, exactly the ones the frame pointer's
     base moved by, and every frame offset at or above that base grows by four
     bytes per register -- otherwise the callee's arguments and the va region
     would be read from the wrong place.
  4. IT DOES NOT TOUCH WHAT IT CANNOT PROVE.  A local whose address escapes and
     a `volatile` local come out byte-identical.
  5. THE ANSWER IS THE SAME.  Every fixture is executed on the emulator in
     three arms (off / on / on alone) and must return the Python answer, which
     is what catches a rename that crosses a branch or a slot the callee writes.
  6. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_VREG=0 refuses
     `-fopt-vreg` by name (C3900U) and still compiles without the flag.

Usage: run_vreg_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
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

FLAG = '-fopt-vreg'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The pass runs after -fopt-regalloc (and the constant cache inside it), so the
# gate measures it on top of the 0.9.1 set with regalloc and the cache on.
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch',
        '-fopt-copyprop', '-fopt-live', '-fopt-prop', '-fopt-deadpush',
        '-fopt-cmat', '-fopt-regalloc', '-fopt-constcache']

# --- fixtures ---------------------------------------------------------------
# A named local lives in the frame and is reloaded for every use.  The reload
# fixtures read *through a pointer to a struct with distant members*, which is
# what makes the backend emit `LDR r0/r5, [r6, #n]` immediately followed by the
# instruction that consumes it -- the shape the pass can rename away (a plain
# `s = s + a` keeps its operands in r0 already and has nothing to remove).
# `V.write` prepends the Reset_Handler shim; the `int vg_pad;` global makes the
# compiler emit an __arkcc_init_globals body, which that shim needs.
HEAD = """\
int vg_pad;
struct VgS { int a, b, c, d, e, f, g, h; };
"""

# A straight-line chain of reloads of one slot: every load feeds the next
# statement, so every one of them can be renamed away.
CHAIN = HEAD + """\
int vg_chain(struct VgS *p, int n)
{
    int s;
    s = p->a;
    s = s + p->d;
    s = s + p->h;
    return s + n;
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    return vg_chain(&v, 9);
}
"""

# The same slot read inside a loop: the back edge ends the rewrite region, so
# the promoted register must be re-established on every iteration and the loop
# must still add up to the same number.
LOOP = HEAD + """\
int vg_loop(struct VgS *p, int n)
{
    int i, s;
    s = 0;
    for (i = 0; i < n; i++) {
        s = s + p->d;
        s = s + p->h;
    }
    return s;
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    return vg_loop(&v, 3);
}
"""

# More slots than the pass has registers: it must promote what it can and leave
# the rest in memory, and the sum must not change.
MANY = HEAD + """\
int vg_many(struct VgS *p, struct VgS *q)
{
    int s;
    s = p->a; s = s + p->b; s = s + p->c; s = s + p->d;
    s = s + q->a; s = s + q->b; s = s + q->c; s = s + q->d;
    s = s + p->e; s = s + q->e;
    return s;
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    struct VgS w = {10, 20, 30, 40, 50, 60, 70, 80};
    return vg_many(&v, &w);
}
"""

# The address of a local escapes into a callee: "nobody loads it here" is not
# evidence the value stays, so the function keeps every line.
ESCAPE = """\
int vg_pad;
struct vgP { int x, y; };
int vg_sum(struct vgP p) { return p.x + p.y; }
int vg_esc(int k, struct vgP a, struct vgP b)
{
    struct vgP c;
    c = k ? a : b;
    return vg_sum(c) + c.y;
}
int main(void)
{
    struct vgP a = {1, 2}, b = {3, 4};
    return vg_esc(1, a, b) + vg_esc(0, a, b);
}
"""

# volatile exists to keep the accesses it names.
VOLATILE = """\
int vg_pad;
int vg_vol(void)
{
    volatile int v = 1;
    v = v + 2;
    v = 3;
    return v;
}
int main(void) { return vg_vol(); }
"""

# A call in the middle: the cache register is callee-saved, so the value is
# still there afterwards -- but only a correct widening of the frame keeps it,
# and the promoted slot must survive a call that clobbers r0-r3.
CALL = HEAD + """\
int vg_twice(int x) { return x * 2; }
int vg_cl(struct VgS *p, int n)
{
    int s;
    s = p->a;
    s = s + vg_twice(p->d);
    s = s + p->h;
    return s + vg_twice(n);
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    return vg_cl(&v, 4);
}
"""

# S6b: the region is the rest of the *block*, not just the next instruction.
# A value loaded early must stay valid across straight-line work (the multiply
# and the add) and feed an instruction several lines later; the same block also
# promotes a second slot, so one line can read two cache registers at once.
DEEP = HEAD + """\
int vg_deep(struct VgS *p, int n)
{
    int s, t;
    s = p->a;
    n = n * 3;
    n = n + 1;
    t = p->h;
    s = s + n;
    t = t + s;
    return t + p->b;
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    return vg_deep(&v, 4);
}
"""

# Two-word locals must stay correct on both halves.
WIDE = """\
int vg_pad;
long long vg_w(long long a, int n)
{
    long long s;
    s = a;
    s = s + n;
    s = s + a;
    return s;
}
int main(void) { return (int)vg_w(11, 7); }
"""

# S6c: the region may walk through a call.  `s` is stored before the call and
# read after it; the callee is deliberately too big to inline, so the reload in
# the plain arm really sits on the far side of a `BL`.  This is the only shape
# where a rename is kept across a call, and it is sound only because the cache
# register is callee-saved and this function's own prologue saves it -- a wrong
# widening of that rule returns a clobbered value, which the emulator arm below
# catches.
CROSSBL = HEAD + """\
int vg_work(int x, int y)
{
    int i, t;
    t = 0;
    for (i = 0; i < y; i++) {
        t = t + x * 3 + i;
        if (t & 1) t = t + x;
    }
    return t & 0xff;
}
int vg_cb(struct VgS *p, int n)
{
    int s;
    s = p->a;
    s = s + p->d;
    n = vg_work(n, 5);
    s = s + p->h;
    return s + n;
}
int main(void)
{
    struct VgS v = {1, 2, 3, 40, 5, 6, 7, 100};
    return vg_cb(&v, 4);
}
"""

CASES = [
    ('chain', CHAIN, 150),    # 1 + 40 + 100 + 9
    ('loop', LOOP, 420),      # (40 + 100) * 3
    ('many', MANY, 201),      # 1+2+3+40 + 10+20+30+40 + 5+50
    ('escape', ESCAPE, 16),   # 3+4 + 3+4 + 4
    ('volatile', VOLATILE, 3),
    ('call', CALL, 189),      # 1 + 2*40 + 100 + 2*4
    ('wide', WIDE, 29),       # 11 + 7 + 11
    ('deep', DEEP, 116),      # n=4*3+1=13, s=1+13=14, t=100+14=114, +2
    ('crossbl', CROSSBL, 219),  # s=1+40=41 (+100), vg_work(4,5)=78, 41+100+78
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

FRAME_RE = re.compile(r'^\s+(PUSH|POP)\s+\{([^}]*)\}\s*$')
OFF_RE = re.compile(r'\[r6, #(\d+)\]')
LDR_RE = re.compile(r'^\s+LDR r0, \[r6, #\d+\]\s*$')


def regs_of(line):
    m = FRAME_RE.match(line)
    if not m:
        return None, []
    return m.group(1), [t.strip() for t in m.group(2).split(',') if t.strip()]


def frame_lists(text):
    """The prologue PUSH and the matching epilogue POP of the first function.

    The prologue is the first list that ends in `lr` and names r5/r6/r7; the
    epilogue is the first list after it that ends in pc or lr."""
    push = pop = None
    for ln in text.splitlines():
        kind, regs = regs_of(ln)
        if not regs or not ('r5' in regs and 'r6' in regs and 'r7' in regs):
            continue
        if push is None and regs[-1] == 'lr':
            push = regs
        elif push is not None and regs[-1] in ('pc', 'lr'):
            pop = regs
            break
    return push, pop


def frame_lists_named(text, fn):
    """Prologue PUSH and matching epilogue POP of the named function.

    Scanned in the whole file because a function body can contain local labels,
    so a body split at the next label may stop before the epilogue."""
    started = False
    push = pop = None
    for ln in text.splitlines():
        if not started:
            if re.match(r'^%s:\s*$' % re.escape(fn), ln):
                started = True
            continue
        kind, regs = regs_of(ln)
        if not regs:
            continue
        if push is None and kind == 'PUSH' and 'r6' in regs and regs[-1] == 'lr':
            push = regs
        elif push is not None and kind == 'POP' and regs[-1] in ('pc', 'lr'):
            pop = regs
            break
    return push, pop

def offsets(text):
    return [int(m) for m in OFF_RE.findall(text)]

SUB_RE = re.compile(r'^\s+SUB\s+sp,\s+sp,\s+#(\d+)\s*$')

def local_words(text):
    """The frame size the prologue asks for (the local area, in bytes)."""
    for ln in text.splitlines():
        m = SUB_RE.match(ln)
        if m:
            return int(m.group(1))
    return 0

# Which function each fixture is expected to promote.
FN = {'chain': 'vg_chain', 'loop': 'vg_loop', 'many': 'vg_many',
      'call': 'vg_cl', 'deep': 'vg_deep', 'crossbl': 'vg_cb'}


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_vreg_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'chain', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'chain',
                             BASE + ['-fno-opt-vreg'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-vreg)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))

        # --- 2..4. the rule, the count, the frame ---------------------------
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
            n_off = insn_count(t_off)
            n_on = insn_count(t_on)
            check(n_on <= n_off,
                  '%s: the pass never adds an instruction' % name,
                  '%d -> %d' % (n_off, n_on))
            body_off = (V.split_functions(t_off).get(FN[name], '')
                        if name in FN else t_off)
            body_on = (V.split_functions(t_on).get(FN[name], '')
                       if name in FN else t_on)
            if name in FN:
                p_off, q_off = frame_lists_named(t_off, FN[name])
                p_on, q_on = frame_lists_named(t_on, FN[name])
            else:
                p_off, q_off = frame_lists(body_off)
                p_on, q_on = frame_lists(body_on)
            if p_off is None or p_on is None:
                check(False, '%s: both arms have a frame save' % name)
                continue
            added = [r for r in p_on if r not in p_off]
            check(all(r in q_on for r in added) and
                  [r for r in q_on if r not in q_off] == added,
                  '%s: PUSH and POP gain the same registers' % name,
                  'push +%s pop +%s' % (added,
                                        [r for r in q_on if r not in q_off]))
            if name in FN:
                check(bool(added),
                      '%s: the promoted function asks the frame for a register'
                      % name, 'push %s' % (p_on,))
            if added:
                # base = local words + 4 saved words (lr included); every
                # offset at or above it belongs to the caller/va region and
                # must move by the same amount the frame grew.
                base_off = local_words(body_off) + 4 * len(p_off)
                shift = 4 * len(added)
                o_off = offsets(body_off)
                o_on = offsets(body_on)
                above_off = sorted(o for o in o_off if o >= base_off)
                above_on = sorted(o for o in o_on if o >= base_off + shift)
                check([o + shift for o in above_off] ==
                      [o for o in o_on if o >= base_off + shift],
                      '%s: every offset above the frame base shifts by 4x%d'
                      % (name, len(added)),
                      '%d offset(s)' % len(above_off))
                check(len([o for o in o_on if base_off <= o < base_off + shift])
                      == 0,
                      '%s: no offset is left inside the widened save' % name)

        # --- 2. it pays -----------------------------------------------------
        for name in ('chain', 'loop', 'many', 'call', 'deep', 'crossbl'):
            if name not in arms:
                continue
            t_off, _b, t_on, _b2 = arms[name]
            check(insn_count(t_on) < insn_count(t_off),
                  '%s: promotion removes instructions' % name,
                  '%d -> %d' % (insn_count(t_off), insn_count(t_on)))

        # --- 4. escape and volatile are left alone --------------------------
        for name, fn in (('escape', 'vg_esc'), ('volatile', 'vg_vol')):
            if name not in arms:
                continue
            t_off, _b, t_on, _b2 = arms[name]
            f_off = V.split_functions(t_off).get(fn, '')
            f_on = V.split_functions(t_on).get(fn, '')
            check(f_off == f_on,
                  '%s: %s keeps every line' % (name, fn),
                  '%d/%d line(s)' % (len(f_off.splitlines()),
                                     len(f_on.splitlines())))

        # --- 3. the answer is the same --------------------------------------
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

        # --- 5. S6c: the region really crosses the call ----------------------
        # Counting frame loads in the three lines after each BL is the
        # difference between "the reload is now on the other side of a call"
        # and "the reload simply moved".  The plain arm must show one, the
        # promoted arm must show none.
        if 'crossbl' in arms:
            t_off, _b, t_on, _b2 = arms['crossbl']
            f_off = V.split_functions(t_off).get('vg_cb', '')
            f_on = V.split_functions(t_on).get('vg_cb', '')

            def loads_after_call(body, window):
                lines = [l for l in body.splitlines() if l.strip()]
                for q, l in enumerate(lines):
                    if re.match(r'^\s+BL(X)?\s', l):
                        return sum(
                            1 for l2 in lines[q + 1:q + 1 + window]
                            if re.match(r'^\s+LDR\s+r\d+,\s*\[r6,\s*#\d+\]',
                                        l2))
                return -1

            n_off = loads_after_call(f_off, 3)
            n_on = loads_after_call(f_on, 3)
            check(n_off >= 1,
                  'crossbl: the plain arm reloads the slot after the call',
                  '%d frame load(s) in the next 3 lines' % n_off)
            check(n_on == 0,
                  'crossbl: the promoted arm keeps the value across the call',
                  '%d frame load(s) in the next 3 lines' % n_on)

        # --- 6. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_VREG=0'],
                                   'arkcc_novreg')
        if trimmed is None:
            skip('a cropped build refuses -fopt-vreg', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'chain.c'), '-o', 't.s', FLAG],
                          work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-vreg by name',
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
        print('\nvreg: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nvreg: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)