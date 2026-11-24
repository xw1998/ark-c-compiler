#!/usr/bin/env python3
"""Gate for the function-level constant cache (0.9.1, -fopt-constcache).

A 32-bit constant is materialised as `MOVW rD, #lo` + `MOVT rD, #hi` every time
it is needed.  When one function needs the same pair c times, this pass builds
it once into a callee-saved register at the entry and turns each of the c
occurrences into `MOV rD, rC`:

    2c  instructions   ->   2 (entry) + c (uses)

and, when the function had no saved register at all, one wider PUSH and one
wider POP on top.  The entry, rather than the first textual occurrence, is what
makes the rewrite dominance-safe: a textual first occurrence can sit inside a
branch that the later uses never take.

Registers are taken from r8-r11 after -fopt-regalloc has picked its slots, and
only those the function's own text never mentions.  -fopt-regalloc therefore
stays the single owner of the PUSH/POP widening and of the frame-offset shift:
this pass only appends registers to the list it widens with.

Checks:

  1. OFF IS OFF.  The default build and `-fno-opt-constcache` are byte
     identical; nothing fires unless the flag is given.
  2. ONLY DECREASE.  Every fixture gets shorter or stays the same size; no
     image grows.
  3. REUSE HAPPENS.  The repeated constant's MOVW/MOVT pairs are gone from the
     uses, `MOV rD, rC` with rC in r8-r11 is what replaced them, the value is
     built once right after the widened PUSH, and the count really drops.
  4. ACROSS A CALL.  A use after a BL still reads the cache register -- the
     whole point of callee-saved -- and returns the right answer.
  5. NOT STEPPING ON -fopt-regalloc.  With both passes on, the cache registers
     and the slot registers are disjoint, and the caller-argument offsets shift
     by exactly one saved block (never twice).
  6. THE ANSWER IS THE SAME.  Every fixture executes on the emulator in three
     arms (off / on / on alone) and returns the Python answer, including a
     six-argument function whose stack arguments are what the offset shift
     moves.
  7. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CONSTCACHE=0
     refuses `-fopt-constcache` by name (C3900U) and still compiles without it.

Usage: run_operand_alloc_tests.py [path-to-arkcc]
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

FLAG = '-fopt-constcache'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']

# The pass runs after the twelve text switches and before -fopt-cmat only in
# the sense that regalloc runs before both; the corpus number in
# docs/OPERAND_ALLOC.md is measured on top of the whole 0.9.1 set plus cmat, so
# that is the baseline here too.
BASE = ['-fopt-vstack', '-fopt-addr', '-fopt-strength', '-fopt-cbz',
        '-fopt-branch', '-fopt-imm', '-fopt-peep', '-fopt-cbranch',
        '-fopt-copyprop', '-fopt-live', '-fopt-prop', '-fopt-deadpush',
        '-fopt-cmat']
# -fopt-vstack rewrites the prologue into its own r4 shape whenever it finds a
# deep value stack, and this pass deliberately does not own that shape (the
# extra pad word it carries would lose its alignment), so the fixtures that are
# about something else run without it.
BASE_NV = [f for f in BASE if f != '-fopt-vstack']

C = '0x12345678u'

# --- fixtures ---------------------------------------------------------------
# Seven rebuilds of one constant, in one function.
REP = """\
unsigned oa_pad;
unsigned oa_rep(unsigned a)
{
    unsigned s = a;
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    s = s - 0x12345678u;
    s = s * 2u;
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    s = s ^ 0x12345678u;
    return s;
}
int main(void) { return (int)(oa_rep(7u) & 255u); }
"""

# Five rebuilds with a call in the middle: the callee is entitled to use r8-r11
# for its own purposes, which is exactly why the cache register is callee-saved.
XC = """\
unsigned oa_pad;
unsigned oa_cal(unsigned x) { return x ^ 0x5A5A5A5Au; }
/* A call the optimiser cannot inline: the callee is entitled to use r8-r11 for
 * its own purposes, which is exactly why the cache register has to be
 * callee-saved.  A plain call gets inlined and tests nothing. */
unsigned (* volatile oa_fp)(unsigned) = oa_cal;
unsigned oa_xc(unsigned a)
{
    unsigned s = a ^ 0x12345678u;
    s = s + oa_fp(s);
    s = s + 0x12345678u;
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    s = s ^ 0x12345678u;
    return s;
}
int main(void) { return (int)(oa_xc(9u) & 255u); }
"""

# Five rebuilds, three of them inside a loop: the entry materialisation has to
# survive every iteration.
LOOP = """\
unsigned oa_pad;
unsigned oa_loop(unsigned n)
{
    unsigned s = 0u, i;
    for (i = 0u; i < n; i++) {
        s = s ^ 0x12345678u;
        s = s + 0x12345678u;
        s = s - 0x12345678u;
    }
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    return s;
}
int main(void) { return (int)(oa_loop(5u) & 255u); }
"""

# Two locals that -fopt-regalloc-near wants in r8/r9, plus the same constant:
# the two passes have to end up on different registers.
MIX = """\
unsigned oa_pad;
unsigned oa_mix(unsigned a, unsigned b)
{
    unsigned t0 = a, t1 = b;
    t0 = t0 ^ 0x12345678u;
    t1 = t1 + 0x12345678u;
    t0 = t0 ^ 0x12345678u;
    t1 = t1 + 0x12345678u;
    t0 = t0 ^ 0x12345678u;
    t1 = t1 + 0x12345678u;
    t0 = t0 ^ 0x12345678u;
    return t0 + t1;
}
int main(void) { return (int)(oa_mix(3u, 5u) & 255u); }
"""
MIX_FLAGS = BASE_NV + ['-fopt-regalloc-near']

# Six parameters: the last two arrive on the caller's stack, above the saved
# block, so growing the block moves them.  They must move exactly once.
SIX = """\
unsigned oa_pad;
unsigned oa_s6(unsigned a, unsigned b, unsigned c, unsigned d,
               unsigned e, unsigned f)
{
    unsigned s = a + b + c + d + e + f;
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    s = s ^ 0x12345678u;
    s = s + 0x12345678u;
    s = s ^ 0x12345678u;
    return s;
}
int main(void) { return (int)(oa_s6(1u, 2u, 3u, 4u, 5u, 6u) & 255u); }
"""

CASES = [
    ('rep', REP, 134, BASE),
    ('xc', XC, 156, BASE_NV),
    ('loop', LOOP, 120, BASE),
    ('six', SIX, 109, BASE),
    ('mix', MIX, 112, MIX_FLAGS),
]

check = V.check
skip = V.skip
write = V.write
run = V.run
build = V.build
insn_count = V.insn_count
build_arkcc = V.build_arkcc

PAIR_RE = re.compile(r'^\s+MOV([WT]) r(\d+), #(\d+)\s*$')
COPY_RE = re.compile(r'^\s+MOV r(\d+), r(\d+)\s*$')
PUSH_RE = re.compile(r'^\s+PUSH \{([^}]*)\}\s*$')
FRAME_RE = re.compile(r'\[r6, #(\d+)\]')
SRC2_RE = re.compile(r'^\s+[A-Z]+(?:\.[WN])?\s+r\d+, r\d+, r(\d+)\s*$')
SRC1_RE = re.compile(r'^\s+(?!MOV|MVN|PUSH|POP|LDR|STR|BL|B|CMP|TST)[A-Z]+(?:\.[WN])?\s+r\d+, r(\d+)\s*$')


def cache_uses(lines, regs):
    """Sites that read the cached constant.

    The pass is stronger than "every remaining occurrence is a `MOV rD, rC`":
    where the constant can be the second source operand of a two-operand ALU
    instruction the cache register is used directly (`EOR r0, r8`), and only the
    shapes that need source and destination apart fall back to a copy.  Both
    count as a use; what must not happen is the constant being rebuilt.
    """
    n = 0
    for ln in lines:
        m = COPY_RE.match(ln)
        if m:
            if int(m.group(2)) in regs:
                n += 1
            continue
        m = SRC2_RE.match(ln) or SRC1_RE.match(ln)
        if m and int(m.group(1)) in regs:
            n += 1
    return n

def rebuilt_pairs(lines, regs, skip_entry=True):
    """MOVW/MOVT pairs written into a cache register, ignoring the one the pass
    inserts at the entry."""
    found = pairs(lines)
    if skip_entry:
        found = found[1:]
    return [p for p in found if p[1] in regs]


def ilen(lines):
    """Instruction count of a list of lines (func_text's output)."""
    return insn_count('\n'.join(lines))


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


def pairs(lines):
    """Every MOVW/MOVT pair, as (index, register, lo, hi)."""
    out = []
    for i, ln in enumerate(lines):
        m = PAIR_RE.match(ln)
        if not m or m.group(1) != 'W' or i + 1 >= len(lines):
            continue
        n = PAIR_RE.match(lines[i + 1])
        if n and n.group(1) == 'T' and n.group(2) == m.group(2):
            out.append((i, int(m.group(2)), int(m.group(3)), int(n.group(3))))
    return out


def entry_cache_regs(lines):
    """Registers built immediately after the prologue PUSH (the materialisation
    this pass inserts), in order."""
    regs = []
    seen_push = False
    for i, ln in enumerate(lines):
        if PUSH_RE.match(ln):
            seen_push = True
            continue
        if not seen_push:
            continue
        m = PAIR_RE.match(ln)
        if m and m.group(1) == 'W' and i + 1 < len(lines):
            n = PAIR_RE.match(lines[i + 1])
            if n and n.group(1) == 'T' and n.group(2) == m.group(2):
                regs.append(int(m.group(2)))
                continue
        if not ln.strip():
            continue
        break
    return regs


def push_words(lines):
    for ln in lines:
        m = PUSH_RE.match(ln)
        if m:
            return len([r for r in m.group(1).split(',') if r.strip()])
    return 0


def frame_offsets(lines):
    out = []
    for ln in lines:
        for m in FRAME_RE.finditer(ln):
            out.append(int(m.group(1)))
    return out


def slot_regs(lines):
    """Registers -fopt-regalloc moves a frame slot through: `MOV rX, r0` /
    `MOV r0, rX`."""
    out = set()
    for ln in lines:
        m = COPY_RE.match(ln)
        if not m:
            continue
        a, b = int(m.group(1)), int(m.group(2))
        if b == 0 and a >= 8:
            out.add(a)
        if a == 0 and b >= 8:
            out.add(b)
    return out


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_constcache_')
    try:
        for name, body, _want, _flags in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        t_a, b_a, e1 = build(arkcc, work, 'rep', BASE, 'plain')
        t_b, b_b, e2 = build(arkcc, work, 'rep',
                             BASE + ['-fno-opt-constcache'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(t_a == t_b and b_a == b_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-constcache)',
                  '%d/%d bytes' % (len(b_a), len(b_b)))
            check(not entry_cache_regs(func_text(t_a, 'oa_rep')),
                  'nothing is cached without the flag',
                  '%d instruction(s)' % len(func_text(t_a, 'oa_rep')))

        # --- 2..3. the rewrite, and only a shorter function ------------------
        arms = {}
        for name, _body, _want, caseflags in CASES:
            t_off, b_off, e3 = build(arkcc, work, name, caseflags,
                                     name + '_off')
            t_on, b_on, e4 = build(arkcc, work, name,
                                   list(caseflags) + [FLAG], name + '_on')
            if e3 or e4:
                check(False, '%s: both arms build' % name,
                      (e3 or e4)[0][:120])
                continue
            arms[name] = (t_off, b_off, t_on, b_on)
            check(insn_count(t_on) <= insn_count(t_off),
                  '%s: no instruction is added' % name,
                  '%d -> %d' % (insn_count(t_off), insn_count(t_on)))
            check(len(b_on) <= len(b_off),
                  '%s: the image never grows' % name,
                  '%d -> %d bytes' % (len(b_off), len(b_on)))

        # The constant really leaves the use sites: fewer pairs, a copy instead.
        if 'rep' in arms:
            t_off, _b_off, t_on, _b_on = arms['rep']
            f_off = func_text(t_off, 'oa_rep')
            f_on = func_text(t_on, 'oa_rep')
            p_off, p_on = pairs(f_off), pairs(f_on)
            regs = entry_cache_regs(f_on)
            check(len(p_on) < len(p_off),
                  'the repeated constant is built fewer times',
                  '%d -> %d pair(s)' % (len(p_off), len(p_on)))
            check(len(regs) >= 1 and all(8 <= r <= 11 for r in regs),
                  'it is built once at the entry, into a callee-saved register',
                  'r%s' % ','.join(str(r) for r in regs))
            uses = cache_uses(f_on, regs)
            check(uses >= 5,
                  'every use site reads the cache register '
                  '(a copy or a two-operand source)',
                  '%d use(s) of r%s' % (uses, ','.join(str(r) for r in regs)))
            check(not rebuilt_pairs(f_on, regs),
                  'the constant is never rebuilt after the entry '
                  'materialisation', '%d pair(s)' % len(rebuilt_pairs(f_on, regs)))
            check(ilen(f_on) < ilen(f_off),
                  'the function got shorter',
                  '%d -> %d' % (ilen(f_off), ilen(f_on)))

        # --- 4. across a call -----------------------------------------------
        if 'xc' in arms:
            t_off, _b_off, t_on, _b_on = arms['xc']
            f_on = func_text(t_on, 'oa_xc')
            regs = entry_cache_regs(f_on)
            # The callee sits behind a volatile function pointer, so the call
            # is an indirect `BLX ip` -- any branch-with-link counts.
            bl = next((i for i, ln in enumerate(f_on)
                       if re.match(r'^\s+(BL|BLX)\b', ln)), None)
            after = [ln for ln in f_on[bl + 1:]] if bl is not None else []
            check(bl is not None and regs and cache_uses(after, regs) > 0,
                  'a use after the call still reads the cache register',
                  'BL at line %s, %d use(s) of r%s'
                  % (bl, cache_uses(after, regs),
                     ','.join(str(r) for r in regs)))
            check(not rebuilt_pairs(after, regs, skip_entry=False),
                  'the constant is not rebuilt after the call either',
                  '%d pair(s)' % len(rebuilt_pairs(after, regs)))

        # --- 5. not stepping on -fopt-regalloc ------------------------------
        if 'mix' in arms:
            t_off, b_off, t_on, b_on = arms['mix']
            f_off = func_text(t_off, 'oa_mix')
            f_on = func_text(t_on, 'oa_mix')
            # The slot registers are read off the arm *without* this pass: with
            # both on, `MOV r0, rC` is also what a cached constant looks like
            # and the two cannot be told apart by shape alone any more.
            sregs = slot_regs(f_off)
            cregs = set(entry_cache_regs(f_on))
            check(bool(sregs) and bool(cregs),
                  '-fopt-regalloc-near really takes slots and the cache really '
                  'takes a register',
                  'slots r%s, cache r%s'
                  % (','.join(str(r) for r in sorted(sregs)) or '-',
                     ','.join(str(r) for r in sorted(cregs)) or '-'))
            check(not (sregs & cregs),
                  'the two passes never share a register',
                  'overlap %s' % sorted(sregs & cregs))
            # Nothing in this fixture is a caller stack argument, so the saved
            # block growth must not move a single local offset.
            o_off, o_on = frame_offsets(f_off), frame_offsets(f_on)
            check(sorted(set(o_off)) == sorted(set(o_on)),
                  'a bigger saved block leaves the local offsets alone '
                  '(they all sit below it)',
                  '%s vs %s' % (sorted(set(o_off)), sorted(set(o_on))))
            check(len(b_on) <= len(b_off),
                  'both passes together still never grow the image',
                  '%d -> %d bytes' % (len(b_off), len(b_on)))

        # --- 5b. the caller-argument image moves exactly one block ----------
        if 'six' in arms:
            t_off, _b_off, t_on, _b_on = arms['six']
            f_off = func_text(t_off, 'oa_s6')
            f_on = func_text(t_on, 'oa_s6')
            extra = 4 * (push_words(f_on) - push_words(f_off))
            o_off, o_on = frame_offsets(f_off), frame_offsets(f_on)
            check(extra > 0 and o_off and o_on and
                  max(o_on) - max(o_off) == extra,
                  'the stack-argument offsets move by exactly one saved block',
                  'extra=%d, max %d -> %d' % (extra, max(o_off), max(o_on)))

        # --- 6. the answers stay the same -----------------------------------
        for name, _body, want, caseflags in CASES:
            if name not in arms:
                continue
            if not V.HAVE_UNICORN:
                skip('%s: emulator value' % name,
                     'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag, flags in (('off', caseflags),
                               ('on', list(caseflags) + [FLAG]),
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

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_CONSTCACHE=0'],
                                   'arkcc_nocc')
        if trimmed is None:
            skip('a cropped build refuses -fopt-constcache', why)
        else:
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'rep.c'), '-o', 't.s', FLAG],
                          work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-constcache by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'rep.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if V.failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if V.failures:
        print('\nconstcache: %d check(s) FAILED%s' % (
            len(V.failures),
            (', %d skipped' % len(V.skips)) if V.skips else ''))
        for f in V.failures:
            print('  - ' + f)
    else:
        print('\nconstcache: all checks passed%s' % (
            (' (%d skipped)' % len(V.skips)) if V.skips else ''))
    sys.exit(rc)
