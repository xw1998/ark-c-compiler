#!/usr/bin/env python3
"""Gate for the stack-frame bookkeeping pass (0.9.1, -fopt-stackframe / S13).

The pass deletes the frame-base register and the alignment padding of a
function whose body never needs them:

  * P type -- the body addresses every local through `[r6, #imm]`.  The
    prologue `MOV r6, sp` and the exit `MOV sp, r6` are pure bookkeeping
    once nothing moves sp inside the body, so they go and every `[r6, #imm]`
    becomes `[sp, #imm]`.  The `SUB sp, sp, #N` / `ADD sp, sp, #N` pair stays:
    it still reserves the frame.
  * Q type -- the frame exists only to keep sp 8-byte aligned after an odd
    save set; nothing ever reads it.  Then `SUB sp, sp, #N` and its matching
    `ADD sp, sp, #N` go as a pair, which is why the save set may be odd only
    when the body contains no call (AAPCS wants 8-byte alignment at a call).

The rules are frozen in docs/EXPR_MODEL.md S14; this gate pins what makes
them trustworthy:

  1. OFF IS OFF.  `-O2 <passes>` and `-O2 <passes> -fno-opt-stackframe` are
     byte-identical both as assembly text and as an image.
  2. THE P TYPE FIRES, AND ONLY AS DESCRIBED.  Exactly one instruction goes
     (`MOV r6, sp`), no `[r6` survives, every rewritten address is `[sp` or
     `[sp, #imm]`, the save/restore sets are untouched and still match, and
     the image returns the same value the Python mirror computes.
  3. THE Q TYPE FIRES AS A PAIR.  Both the `SUB sp, sp, #N` and its `ADD`
     disappear, the PUSH/POP sets are untouched, exactly two instructions go.
  4. IT DECLINES WHEN IT MUST.  A body that names sp, a body that uses r6 as
     a plain value, and an odd save set with a call in the body all come out
     byte-identical.
  5. NO CALL EVER RUNS WITH A MISALIGNED STACK.  Over the whole fixture file,
     every function that contains a call and saves an odd number of registers
     still has a `SUB sp, sp, #` realignment in its prologue.

Usage: run_stackframe_tests.py [path-to-arkcc]
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

FLAG = '-fopt-stackframe'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']
# The pass runs last, on the frame the earlier passes left; the gate measures
# it in the configuration it ships in (the 26 flags of the 0.9.1 line plus the
# spill and load-hoist passes that already shipped).
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop', '-fopt-slotreg',
          '-fopt-strength', '-fopt-vstack', '-fopt-vreg', '-fopt-cmat',
          '-fopt-pair', '-fopt-litpool', '-fopt-frame', '-fopt-voldmb',
          '-fopt-constcond', '-fopt-boolmat', '-fopt-exit', '-fopt-bitmask',
          '-fopt-spill', '-fopt-ldhoist']

FIXTURE = r'''
struct sfS { unsigned a; unsigned b; };

void sf_sink(unsigned v) { *(volatile unsigned *)0x20000014u = v; }

/* P type: the locals live in the frame and are read back through it. */
unsigned sf_probe(struct sfS *p)
{
    unsigned a = p->a;
    unsigned b = p->b;
    unsigned s = a + b;
    return s * 3u + a;
}

/* Q type: a frame that exists only to realign sp after an odd save set. */
void sf_q(void)
{
    *(volatile unsigned *)0x20000010u &= ~0x2u;
}

/* MUST NOT TRIGGER: odd save set, but a call in the body needs alignment. */
void sf_dcall(unsigned x)
{
    *(volatile unsigned *)0x20000010u = x;
    sf_sink(x);
}

/* MUST NOT TRIGGER: the body names sp itself. */
void sf_sp(void)
{
    __asm volatile("    ADD r0, sp, #0");
}

/* MUST NOT TRIGGER: r6 is a plain value, the frame base is gone. */
unsigned sf_r6val(unsigned x)
{
    unsigned a = x + 1u;
    __asm volatile("    MOV r6, r0");
    return a;
}

static struct sfS sf_g = { 3u, 5u };
int main(void) { return (int)(sf_probe(&sf_g) & 0xFFu); }
'''

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
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['asm failed']
    img = os.path.join(work, '%s_%s.bin' % (name, tag))
    rc, log = run([arkcc] + IMG_ARM + ['-O2', '-I', INC, src, '-o', img]
                  + list(flags), work)
    if rc != 0:
        return None, None, log.strip().splitlines()[:1] or ['image failed']
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
LABEL_DEF_RE = re.compile(r'^\s*(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')
PUSH_RE = re.compile(r'^\s+PUSH\s+\{([^}]*)\}\s*$', re.M)
POP_PC_RE = re.compile(r'^\s+POP\s+\{([^}]*\bpc\b[^}]*)\}\s*$', re.M)
SUB_SP_RE = re.compile(r'^\s+SUB\s+sp,\s*sp,\s*#(\d+)\s*$', re.M)
ADD_SP_RE = re.compile(r'^\s+ADD\s+sp,\s*sp,\s*#(\d+)\s*$', re.M)
CALL_RE = re.compile(r'^\s+BL(?:X)?\s+\S', re.M)
FUNC_RE = re.compile(r'^([A-Za-z_][A-Za-z0-9_]*):\n(.*?)^\.size \1,', re.M | re.S)

def func_text(text, name):
    m = re.search(r'^%s:\n(.*?)^\.size %s,' % (re.escape(name), re.escape(name)),
                  text, re.M | re.S)
    return m.group(1) if m else ''

def funcs(text):
    return FUNC_RE.findall(text)

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def dangling_labels(text):
    defs = set(LABEL_DEF_RE.findall(text))
    refs = set()
    for ln in text.splitlines():
        m = BRANCH_REF_RE.match(ln)
        if m:
            refs.add(m.group(1))
    return refs - defs

def reg_set(listing):
    return set(int(x) for x in re.findall(r'r(\d+)', listing))

def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(glob.glob('src/*.c')) +
            sorted(glob.glob('src/backend/*/*.c')) +
            ['src/backend/registry.c', 'port/host/flash_fs_host.c',
             'port/host/platform_host.c', 'port/host/debug_host.c'])
    if not srcs:
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

def py_value():
    """Mirror of main(): ((3+5)*3 + 3) & 0xFF."""
    a, b = 3, 5
    want = ((a + b) * 3 + a) & 0xFF
    assert want == 27, 'the Python mirror disagrees with itself: %d' % want
    return want

def main():
    global INC
    if not os.path.isdir(INC):
        INC = os.path.join(os.getcwd(), 'stdlib', 'include')

    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_sf_')
    try:
        write(os.path.join(work, 'sf.c'), FIXTURE)

        # --- 1. off is off --------------------------------------------------
        ta, ba, e1 = build(arkcc, work, 'sf', PASSES, 'plain')
        tb, bb, e2 = build(arkcc, work, 'sf', PASSES + ['-fno-opt-stackframe'],
                           'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixtures',
                  (e1 or e2)[0][:120])
            return 1
        check(ta == tb and ba == bb,
              'the default build ignores the pass '
              '(-O2 == -O2 -fno-opt-stackframe)',
              '%d/%d bytes' % (len(ta), len(tb)))

        arms = {}
        for tag, flags in (('off', PASSES), ('on', PASSES + [FLAG])):
            t, blob, err = build(arkcc, work, 'sf', flags, tag)
            if err:
                check(False, '%s arm builds' % tag, err[0][:120])
                return 1
            arms[tag] = (t, blob)
        off_t, off_bin = arms['off']
        on_t, on_bin = arms['on']

        # --- 2. the P type fires, exactly as described ----------------------
        po, pn = func_text(off_t, 'sf_probe'), func_text(on_t, 'sf_probe')
        if not po or not pn:
            check(False, 'P type: sf_probe is in the assembly')
        else:
            check('MOV r6, sp' in po and 'MOV r6, sp' not in pn,
                  'P type: the frame base `MOV r6, sp` is gone', '1 -> 0')
            check(len(re.findall(r'\[r6', po)) > 0 and
                  len(re.findall(r'\[r6', pn)) == 0,
                  'P type: no `[r6` survives',
                  '%d -> 0' % len(re.findall(r'\[r6', po)))
            check(len(re.findall(r'\[sp', pn)) == len(re.findall(r'\[r6', po)),
                  'P type: every frame address became `[sp`',
                  '%d -> %d' % (len(re.findall(r'\[r6', po)),
                                len(re.findall(r'\[sp', pn))))
            check(len(SUB_SP_RE.findall(pn)) == 1 and
                  len(ADD_SP_RE.findall(pn)) == 1,
                  'P type: the frame allocation pair stays (still needed)')
            check(PUSH_RE.search(po).group(1) == PUSH_RE.search(pn).group(1) and
                  [m.group(1) for m in POP_PC_RE.finditer(po)] ==
                  [m.group(1) for m in POP_PC_RE.finditer(pn)],
                  'P type: the save/restore sets are untouched',
                  PUSH_RE.search(pn).group(1))
            check(insn_count(po) - insn_count(pn) == 1,
                  'P type: exactly one instruction goes',
                  '%d -> %d' % (insn_count(po), insn_count(pn)))

        # --- 3. the Q type fires as a pair ----------------------------------
        qo, qn = func_text(off_t, 'sf_q'), func_text(on_t, 'sf_q')
        if not qo or not qn:
            check(False, 'Q type: sf_q is in the assembly')
        else:
            check(len(SUB_SP_RE.findall(qo)) == 1 and
                  len(SUB_SP_RE.findall(qn)) == 0 and
                  len(ADD_SP_RE.findall(qo)) == 1 and
                  len(ADD_SP_RE.findall(qn)) == 0,
                  'Q type: `SUB sp` and its `ADD sp` both go',
                  '%d/%d -> 0/0'
                  % (len(SUB_SP_RE.findall(qo)), len(ADD_SP_RE.findall(qo))))
            check(PUSH_RE.search(qo).group(1) == PUSH_RE.search(qn).group(1) and
                  [m.group(1) for m in POP_PC_RE.finditer(qo)] ==
                  [m.group(1) for m in POP_PC_RE.finditer(qn)],
                  'Q type: the save/restore sets are untouched',
                  PUSH_RE.search(qn).group(1))
            check(insn_count(qo) - insn_count(qn) == 2,
                  'Q type: exactly two instructions go',
                  '%d -> %d' % (insn_count(qo), insn_count(qn)))
            check(not re.search(r'\bsp\b', qn),
                  'Q type: nothing addresses sp afterwards')

        # --- 4. it declines when it must ------------------------------------
        for name, why in (('sf_dcall', 'an odd save set with a call in the body'),
                          ('sf_sp', 'a body that names sp'),
                          ('sf_r6val', 'a body that uses r6 as a value')):
            fo, fn = func_text(off_t, name), func_text(on_t, name)
            check(bool(fo) and fo == fn,
                  '%s: %s leaves the text byte-identical' % (name, why),
                  '%d/%d bytes' % (len(fo), len(fn)))

        # --- 5. no call runs with a misaligned stack ------------------------
        viol = []
        for name, body in funcs(on_t):
            if not CALL_RE.search(body):
                continue
            m = PUSH_RE.search(body)
            if not m:
                continue
            nwords = len([t for t in m.group(1).split(',') if t.strip()])
            if nwords % 2 == 1 and not SUB_SP_RE.search(body):
                viol.append(name)
        check(not viol,
              'every function that calls with an odd save set keeps its '
              '`SUB sp` realignment', ','.join(viol) or 'none')

        check(not dangling_labels(on_t),
              'every branch target is still defined')

        # --- 6. the image still computes the same thing ---------------------
        if not HAVE_UNICORN:
            skip('the image returns the mirrored value',
                 'python package unicorn missing')
        else:
            want = py_value()
            got, ok = {}, True
            for tag, (t, blob) in (('off', (off_t, off_bin)),
                                   ('on', (on_t, on_bin))):
                st, val, _ = run_image(blob)
                if st != 'returned':
                    check(False, '%s arm returns' % tag, st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == want for v in got.values()),
                      'both arms return %d (Python agrees)' % want,
                      ' '.join('%s=%s' % (k, got[k]) for k in ('off', 'on')))
                check(len(on_bin) <= len(off_bin),
                      'the image never grows',
                      'off/on=%d/%d bytes' % (len(off_bin), len(on_bin)))

        # --- 7. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_STACKFRAME=0'],
                                   'arkcc_nosf')
        if trimmed is None:
            skip('a cropped build refuses -fopt-stackframe', why)
        else:
            src = os.path.join(work, 'sf.c')
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC, src,
                          '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-stackframe by name',
                  'rc=%d' % rc)
            rc2, log2 = run([trimmed] + ASM_ARM + ['-O2', '-I', INC, src,
                             '-o', 't2.s'] + PASSES, work)
            rc3, log3 = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src,
                             '-o', 't3.s'] + PASSES, work)
            if rc2 != 0 or rc3 != 0:
                check(False, 'the cropped build still compiles the fixture',
                      (log2 or log3).strip().splitlines()[:1])
            else:
                check(open(os.path.join(work, 't2.s'), encoding='utf-8').read() ==
                      open(os.path.join(work, 't3.s'), encoding='utf-8').read(),
                      'the cropped build writes the same text as the full '
                      'build when the flag is absent')
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
