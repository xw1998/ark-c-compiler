#!/usr/bin/env python3
"""Gate for the value-stack -> register allocation pass (0.9.1, -fopt-vstack).

The ARM backend is a stack machine: every intermediate value is materialised
with `PUSH {rN}` and consumed by a matching `POP {rN}`, so a plain expression
like `a + b` costs three memory-touching instructions.  In the 0.9.1 benchmark
corpus half of all emitted instructions were PUSH/POP (`bench1.c`: 253 PUSH +
262 POP of 1024 instructions, 91 adjacent same-register pairs).

The pass rewrites the *emitted assembly* of one function at a time, keeping the
shadow value stack in two callee-saved registers (r5, r7 -- both already saved
by every prologue, so the frame does not change at all).  It is all-or-nothing
per function: any construct it cannot model makes the whole function keep its
original text, byte for byte.

Each claim is checked separately, and each would fail on a plausible wrong
implementation:

  1. OFF IS OFF.  The default build (`-O2`, no flag) and `-O2 -fno-opt-vstack`
     are byte-identical, and so are their images.  The pass is opt-in, exactly
     like every other 0.9.x optimisation.
  2. IT PAYS.  On two stack-heavy fixtures the flag must strictly reduce the
     instruction count *and* the PUSH/POP count, leave no adjacent
     same-register PUSH/POP pair behind, and must never grow the image.
  3. THE ANSWER IS THE SAME.  Four fixtures (arithmetic, loop with branches,
     struct returned by value, variadic callee) return the value computed here
     in Python, on the emulator, in three arms: off, on, and on together with
     `-fopt-regalloc` (two textual passes in a row must not fight).
  4. A LOOP KEEPS ITS DEPTH.  The loop fixture has labels, conditional
     branches, a call-free body and a live value stack across the back edge --
     i.e. the case where a wrong pass silently keeps a register aliased past a
     jump -- and it must still compute the loop's answer.
  6. THE THIRD REGISTER IS ASKED FOR, NOT ASSUMED.  A body that keeps three
     values alive gets r4 as a third pool register -- pushed and popped in the
     frame shape, with the frame grown by one word so 16+8k stays 8-byte
     aligned -- and a body that never goes past two values does not, because a
     word of prologue for nothing is a loss on a microcontroller.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_VSTACK=0 refuses
     `-fopt-vstack` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file normally without the flag.

Usage: run_vstack_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import glob
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import STARTUP, run_image, HAVE_UNICORN
except Exception:                                        # pragma: no cover
    STARTUP, run_image, HAVE_UNICORN = '', None, False

FLAG = '-fopt-vstack'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# --- fixtures ---------------------------------------------------------------
ARITH = """\
int va_pad_a;
static int arith(int a, int b, int c, int d)
{
    int x = a + b;
    int y = c - d;
    int z = x * y;
    int w = z + (a ^ c);
    return (w + (b & d)) - (x | y);
}
int main(void) { return arith(5, 7, 9, 3) & 0xFF; }
"""

LOOP = """\
int va_pad_l;
static int loop(int n)
{
    int i, s = 0, t = 1;
    for (i = 0; i < n; i++) {
        s = s + i * 3;
        t = t ^ (s + i);
        if (s > 1000) s = s - 1000;
    }
    return (s + t) & 0xFF;
}
int main(void) { return loop(12) & 0xFF; }
"""

STRUCT = """\
int va_pad_s;
struct pt { int x, y; };
static struct pt mk(int a, int b) { struct pt p; p.x = a + 1; p.y = b * 2; return p; }
int main(void) { struct pt q = mk(3, 4); return (q.x + q.y) & 0xFF; }
"""

VARIADIC = """\
#include <stdarg.h>
int va_pad_v;
static int vsum(int n, ...)
{
    va_list ap; int i, s = 0;
    va_start(ap, n);
    for (i = 0; i < n; i++) s += va_arg(ap, int);
    va_end(ap);
    return s;
}
int main(void) { return vsum(3, 7, 8, 9) & 0xFF; }
"""


DEEP = """\
int va_pad_d;
static int deep(int a, int b, int c, int d, int e)
{
    return a + (b * (c + (d * (e + a))));
}
int main(void) { return deep(2, 3, 4, 5, 6) & 0xFF; }
"""

SHALLOW = """\
int va_pad_w;
static int shallow(int a, int b) { return a + b; }
int main(void) { return shallow(3, 4) & 0xFF; }
"""

def py_arith(a=5, b=7, c=9, d=3):
    x = a + b
    y = c - d
    z = x * y
    w = z + (a ^ c)
    return ((w + (b & d)) - (x | y)) & 0xFF


def py_loop(n=12):
    s, t = 0, 1
    for i in range(n):
        s = s + i * 3
        t = t ^ (s + i)
        if s > 1000:
            s = s - 1000
    return (s + t) & 0xFF


def py_struct(a=3, b=4):
    return ((a + 1) + b * 2) & 0xFF


def py_variadic():
    return (7 + 8 + 9) & 0xFF


def py_deep():
    return (2 + (3 * (4 + (5 * (6 + 2))))) & 0xFF

def py_shallow():
    return (3 + 4) & 0xFF

# name, body, python answer
CASES = [
    ('arith',    ARITH,    py_arith()),
    ('loop',     LOOP,     py_loop()),
    ('struct',   STRUCT,   py_struct()),
    ('variadic', VARIADIC, py_variadic()),
    ('deep',     DEEP,     py_deep()),
    ('shallow',  SHALLOW,  py_shallow()),
]

# the two fixtures whose instruction count the pass must actually reduce
PAYS = ('arith', 'loop')

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
STKP_RE = re.compile(r'^\s+(PUSH|POP)\b')
PAIR_RE = re.compile(r'^\s+PUSH\s+\{(\w+)\}\s*$')

failures, skips = [], []


def check(cond, what, detail=''):
    if cond:
        print('[ok  ] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
    else:
        print('[FAIL] %s%s' % (what, ('  (%s)' % detail) if detail else ''))
        failures.append(what)
    return bool(cond)


def skip(what, why=''):
    print('[skip] %s%s' % (what, ('  (%s)' % why) if why else ''))
    skips.append(what)


def write(path, text):
    with open(path, 'w', newline='\n', encoding='utf-8') as fh:
        fh.write(STARTUP + text)


def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def build(arkcc, work, name, flags, tag):
    """Compile one fixture twice: assembly text and a bootable image."""
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm] + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img] + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None


def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))


def stack_ops(text):
    return sum(1 for ln in text.splitlines() if STKP_RE.match(ln))


def stack_pairs(text):
    """Adjacent `PUSH {rX}` / `POP {rX}` on the same register."""
    lines = text.splitlines()
    n = 0
    for i, ln in enumerate(lines[:-1]):
        m = PAIR_RE.match(ln)
        if not m:
            continue
        if re.match(r'^\s+POP\s+\{%s\}\s*$' % m.group(1), lines[i + 1]):
            n += 1
    return n


FUNC_RE = re.compile(r'^([A-Za-z_.$][\w.$]*):\s*$')


def split_functions(text):
    """Cut emitted assembly into label-delimited chunks (local labels split too,
    which is harmless: chunks are only compared textually and never span a
    PUSH/POP pair)."""
    funcs, cur, buf = {}, None, None
    for ln in text.splitlines():
        m = FUNC_RE.match(ln)
        if m:
            cur = m.group(1)
            buf = [ln]
            funcs[cur] = buf
        elif buf is not None:
            buf.append(ln)
    return dict((k, '\n'.join(v)) for k, v in funcs.items())


def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    if not srcs or not os.path.exists('include/common.h'):
        return None, 'not run from the repository root'
    out = os.path.join(where, name + ('.exe' if os.name == 'nt' else ''))
    cmd = [cc, '-Wall', '-O2', '-std=c99', '-Wno-unused-parameter',
           '-Wno-unused-but-set-variable', '-Wno-unused-variable',
           '-Wno-unused-function', '-Iinclude'] + defines + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:160]
    return out, ''


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_vstack_')
    try:
        for name, body, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        text_a, blob_a, e1 = build(arkcc, work, 'arith', [], 'plain')
        text_b, blob_b, e2 = build(arkcc, work, 'arith', ['-fno-opt-vstack'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(text_a == text_b and blob_a == blob_b,
                  'the default build ignores the pass (-O2 == -O2 -fno-opt-vstack)',
                  '%d/%d bytes' % (len(blob_a), len(blob_b)))

        # --- 2. it pays -----------------------------------------------------
        for name, body, _ in CASES:
            arms = {}
            for tag, flags in (('off', []), ('on', [FLAG]),
                               ('both', [FLAG, '-fopt-regalloc'])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    arms[tag] = None
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    break
                arms[tag] = (t, blob)
            if any(v is None for v in arms.values()):
                continue

            n_off, n_on = insn_count(arms['off'][0]), insn_count(arms['on'][0])
            s_off, s_on = stack_ops(arms['off'][0]), stack_ops(arms['on'][0])
            if name in PAYS:
                check(n_on < n_off, '%s: instructions drop' % name,
                      '%d -> %d (-%d%%)' % (n_off, n_on,
                                            100 * (n_off - n_on) // n_off))
                check(s_on < s_off, '%s: PUSH/POP drop' % name,
                      '%d -> %d' % (s_off, s_on))
                off_f = split_functions(arms['off'][0])
                on_f = split_functions(arms['on'][0])
                changed = sorted(k for k in off_f
                                 if k in on_f and on_f[k] != off_f[k])
                dirty = sorted(k for k in changed if stack_pairs(on_f[k]))
                check(changed and not dirty,
                      '%s: every rewritten function is pair-free' % name,
                      'rewritten %s / leftovers %s' %
                      (','.join(changed) or 'none', ','.join(dirty) or 'none'))
            check(len(arms['on'][1]) <= len(arms['off'][1]),
                  '%s: the image never grows' % name,
                  '%d -> %d bytes' % (len(arms['off'][1]), len(arms['on'][1])))

            # --- 3/4. same answer -------------------------------------------
            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            want = dict((n, v) for n, _, v in CASES)[name]
            got = {}
            ok = True
            for tag in ('off', 'on', 'both'):
                st, val, _ = run_image(arms[tag][1])
                if st != 'returned':
                    check(False, '%s: %s arm returns' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == want for v in got.values()),
                      '%s: off/on/on+regalloc all return %d' % (name, want),
                      'off=%s on=%s both=%s' % (got['off'], got['on'], got['both']))

        # --- 4b. the third pool register only when the body needs it --------
        # r4 is legal as a third pool register because this codegen never uses
        # it, but it is not free: PUSH/POP each grow a word.  So it is taken
        # only for bodies that keep three or more values alive at once, and
        # then the frame has to grow by the same word to stay 8-byte aligned.
        t_deep, _, e_deep = build(arkcc, work, 'deep', [FLAG], 'r4on')
        t_shal, _, e_shal = build(arkcc, work, 'shallow', [FLAG], 'r4off')
        if e_deep or e_shal:
            check(False, 'the pool-size fixtures build', (e_deep or e_shal)[0][:120])
        else:
            deep_body = [v for k, v in split_functions(t_deep).items()
                         if 'deep' in k and '{r4, r5, r6, r7' in v]
            check(len(deep_body) == 1,
                  'deep: a third value takes r4 and it is saved and restored',
                  '%d function(s) with a five-register frame' % len(deep_body))
            body = deep_body[0] if deep_body else ''
            check('PUSH {r4, r5, r6, r7, lr}' in body and
                  'POP {r4, r5, r6, r7, pc}' in body,
                  'deep: r4 is pushed and popped in the frame shape',
                  'push/pop ok' if body else 'no body')
            sub = [int(l.split('#')[1]) for l in body.splitlines()
                   if l.strip().startswith('SUB') and 'sp, sp, #' in l]
            check(sub and all(n % 8 == 4 for n in sub),
                  'deep: the frame grows by one word so the stack stays aligned',
                  'SUB sp, sp, #%s' % (sub or 'none'))
            grown = [l.strip() for l in t_shal.splitlines()
                     if l.strip().startswith('PUSH') and 'r4' in l and
                     'r5' in l]
            check(not grown,
                  'shallow: a body that never holds three values leaves r4 alone',
                  'grown %s' % (grown[:1] if grown else 'none'))

        # --- 5. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_VSTACK=0'],
                                   'arkcc_novstack')
        if trimmed is None:
            skip('a cropped build refuses -fopt-vstack', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'arith.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-vstack by name',
                  'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'arith.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        shutil.rmtree(work, ignore_errors=True)


if __name__ == '__main__':
    rc = main()
    if failures:
        print('\nvstack: %d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
    else:
        print('\nvstack: all checks passed%s' % (
            (' (%d skipped)' % len(skips)) if skips else ''))
    sys.exit(rc)