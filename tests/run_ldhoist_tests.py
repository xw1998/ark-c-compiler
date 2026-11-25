#!/usr/bin/env python3
"""Gate for the load-hoisting pass (0.9.1, -fopt-ldhoist / S12-1).

The pass deletes a reload of the same `[Rb, #imm]` that the function already
did, by loading the value once into a register the function never names at all.
The rules are frozen in docs/EXPR_MODEL.md S12-1; this gate pins the four things
that make the pass trustworthy:

  1. OFF IS OFF.  `-O2 <passes>` and `-O2 <passes> -fno-opt-ldhoist` are
     byte-identical as assembly text, and a build cropped to
     -DARKCC_FEATURE_OPT_LDHOIST=0 produces the same text as the full build
     when the flag is absent.
  2. IT FIRES, AND ONLY IN THE SHAPE THE RULES ALLOW.  On a real translation
     unit exactly one function may change, the reloads it drops must all be
     reloads of one and the same `[Rb, #imm]`, the kept value must land on a
     callee-saved register the function never named before, that register must
     be added to the prologue PUSH and to every return POP, sp must still be
     8-byte aligned, no branch target may be left dangling, and the instruction
     count must drop by exactly the number of dropped reloads.
  3. IT DECLINES WHEN IT MUST.  The other functions of that unit must come out
     byte-identical, the pass must leave far more same-address reloads alone
     than it removes, and a pure-C fixture it has no provable candidate in must
     be byte-identical and still compute the same value.
  4. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_LDHOIST=0 refuses
     `-fopt-ldhoist` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file without the flag.

Why the trigger arm is a real translation unit: the pass runs last among the
text passes, on the frame the earlier ones left, and the shape it eats -- a
struct field reloaded before every test on a straight chain -- is produced by
the other passes on HAL code, not by arkcc's emitter on a small C fixture.  The
26-flag configuration below is the one the pass ships in; with only
vstack/addr/frame the delta on this file is zero.  S12-1's must-not-trigger
fixtures used inline assembly, which was the only way to spell the exact
instruction sequence -- but since S14 (docs/EXPR_MODEL.md §16) a function that
contains user `__asm` is exempt from every text pass, so those fixtures can no
longer exercise this pass at all.  Section 3 keeps the same intent on evidence
that survives: the untouched functions of the real unit, the decline ratio
inside the one function that is rewritten, and the pure-C fixture.

Usage: run_ldhoist_tests.py [path-to-arkcc]
Exit 0 = every check passed, 1 = a check failed, 2 = setup problem.
"""
import collections
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

FLAG = '-fopt-ldhoist'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# The 26 text passes, in the order the corpus sweep uses them.  ldhoist runs
# inside this pipeline, so the gate measures it where it ships.
PASSES = ['-fopt-coalesce', '-fopt-addr', '-fopt-branch', '-fopt-cbranch',
          '-fopt-cbz', '-fopt-constcache', '-fopt-copyprop', '-fopt-deadpush',
          '-fopt-imm', '-fopt-live', '-fopt-peep', '-fopt-prop',
          '-fopt-slotreg', '-fopt-strength', '-fopt-vstack', '-fopt-vreg',
          '-fopt-cmat', '-fopt-pair', '-fopt-litpool', '-fopt-frame',
          '-fopt-voldmb', '-fopt-constcond', '-fopt-boolmat', '-fopt-exit',
          '-fopt-bitmask', '-fopt-spill']

# --- the real translation unit the trigger arm is measured on ---------------
HAL_REL = 'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c'
HAL_INC = ['examples/ark_test/Core/Inc',
           'examples/ark_test/Core/Inc/HAL_Driver/Inc',
           'examples/ark_test/Drivers/STM32F4xx_HAL_Driver/Inc',
           'examples/ark_test/Drivers/CMSIS/Device/ST/STM32F4xx/Include',
           'examples/ark_test/Drivers/CMSIS/Include',
           'stdlib/include']
HAL_DEFS = ['-D', 'STM32F401xE', '-D', 'USE_HAL_DRIVER', '--reloc-data']
TARGET_FN = 'HAL_DMAEx_MultiBufferStart_IT'
# How many reloads of the hottest `[Rb, #imm]` the pass must actually remove
# before the gate treats it as "it fires" rather than "it silently no-oped".
FIRE_FLOOR = 100

# MUST NOTHING: ordinary C.  Whatever the emitter produces here, the pass must
# not find a provable region in it, so the text is byte-identical -- and the
# emulator must still return the Python answer.
PURE_C = """\
volatile int lh_sink;
static int lh_knock(int n)
{
    int a = n * 3;
    int b = a + 2;
    if (n <= 0) return b;
    return b + lh_knock(n - 1);
}
int main(void)
{
    lh_sink = lh_knock(3);
    return lh_sink & 0xFF;
}
"""

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
    return read_text(asm), read_bytes(img), None

def read_text(path):
    # `.file 1` carries the source path in the host code page, so the listing is
    # not guaranteed to be UTF-8.  Nothing this gate looks at lives in it.
    with open(path, encoding='utf-8', errors='replace') as fh:
        return fh.read()

def read_bytes(path):
    with open(path, 'rb') as fh:
        return fh.read()

def build_hal(arkcc, work, flags, tag):
    """Assembly text for the real translation unit (no image: it is a library)."""
    src = os.path.join(ROOT, HAL_REL)
    if not os.path.exists(src):
        return None, ['missing %s' % HAL_REL]
    out = os.path.join(work, 'hal_%s.s' % tag)
    argv = [arkcc] + ASM_ARM + ['-O2'] + HAL_DEFS + list(flags)
    for d in HAL_INC:
        argv += ['-I', os.path.join(ROOT, d)]
    argv += ['-o', out, src]
    rc, log = run(argv, work)
    if rc != 0:
        return None, log.strip().splitlines()[:1] or ['asm failed']
    return read_text(out), None

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
LABEL_DEF_RE = re.compile(r'^\s*(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')
PUSH_RE = re.compile(r'^\s+PUSH\s+\{([^}]*)\}\s*$', re.M)
POP_PC_RE = re.compile(r'^\s+POP\s+\{([^}]*\bpc\b[^}]*)\}\s*$', re.M)
FRAME_RE = re.compile(r'^\s+SUB\s+sp,\s*sp,\s*#(\d+)\s*$', re.M)
LOAD_RE = re.compile(r'^\s+(LDR|LDRB|LDRH|LDRSB|LDRSH)\s+(r\d+),\s*'
                     r'\[(r\d+)(?:,\s*#(\d+))?\]\s*$', re.M)
SAVED_REGS = set(range(4, 12))

def functions(text):
    """name -> body, for every function that carries a .size directive."""
    out = {}
    for m in re.finditer(r'^([A-Za-z_][A-Za-z0-9_]*):\n(.*?)^\.size \1,',
                         text, re.M | re.S):
        out[m.group(1)] = m.group(2)
    return out

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

def load_keys(text):
    """Counter of (mnemonic, base, offset) for every `LDR{,B,H,SB,SH} Rd,[Rb,#i]`."""
    keys = collections.Counter()
    for op, _rd, rb, imm in LOAD_RE.findall(text):
        keys[(op, rb, int(imm or 0))] += 1
    return keys

def load_dests(text, key):
    op, rb, imm = key
    pat = re.compile(r'^\s+%s\s+(r\d+),\s*\[%s(?:,\s*#%d)?\]\s*$'
                     % (op, rb, imm), re.M)
    return pat.findall(text)

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
    def knock(n):
        a = n * 3
        b = a + 2
        if n <= 0:
            return b
        return b + knock(n - 1)
    want = knock(3) & 0xFF
    assert want == 26, 'the Python mirror disagrees with itself: %d' % want
    return want

def main():
    # The repository root is where the Makefile is; run_*_tests.py may be
    # invoked from anywhere.
    global INC
    if not os.path.isdir(INC):
        INC = os.path.join(os.getcwd(), 'stdlib', 'include')

    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_ldh_')
    try:
        write(os.path.join(work, 'pure.c'), PURE_C)

        # --- 1. off is off --------------------------------------------------
        h_off, e1 = build_hal(arkcc, work, PASSES, 'plain')
        h_nofl, e2 = build_hal(arkcc, work,
                               PASSES + ['-fno-opt-ldhoist'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the trigger unit',
                  (e1 or e2)[0][:120])
            h_off = None
        else:
            check(h_off == h_nofl,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-ldhoist)',
                  '%d/%d bytes' % (len(h_nofl), len(h_off)))

        # --- 2. it fires, and only in the shape the rules allow -------------
        h_on, e3 = build_hal(arkcc, work, PASSES + [FLAG], 'on')
        if h_off is None or h_on is None:
            check(False, 'trigger: the on arm builds',
                  (e3 or ['off arm already failed'])[0][:120])
        else:
            fo = functions(h_off)
            fn = functions(h_on)
            changed = [k for k in fo if fo.get(k) != fn.get(k)]
            check(changed == [TARGET_FN],
                  'trigger: exactly one function in the unit changes',
                  ', '.join(changed) or 'none')
            if changed == [TARGET_FN]:
                off_f, on_f = fo[TARGET_FN], fn[TARGET_FN]
                ko, kn = load_keys(off_f), load_keys(on_f)
                key = ko.most_common(1)[0][0] if ko else None
                removed = 0
                if key is not None:
                    removed = ko[key] - kn[key]
                check(key is not None and ko[key] >= 5,
                      'trigger: the unit has one hot [Rb,#imm] worth hoisting',
                      '%s x%d' % ((key[0], key[1], '#%d' % key[2]), ko[key])
                      if key else 'no loads')
                check(removed >= FIRE_FLOOR,
                      'trigger: the pass removes the hot reload, not one of them',
                      '%d of %d' % (removed, ko[key] if key else 0))
                check(insn_count(on_f) == insn_count(off_f) - removed,
                      'trigger: exactly the dropped reloads go, nothing else',
                      '%d -> %d (-%d, removed %d)'
                      % (insn_count(off_f), insn_count(on_f),
                         insn_count(off_f) - insn_count(on_f), removed))
                # The dedicated register: a callee-saved one the function never
                # mentioned before, and the one the hot loads now read from.
                aside = [d for d in (load_dests(on_f, key) if key else [])
                         if not re.search(r'\b%s\b' % d, off_f)]
                check(len(set(aside)) == 1,
                      'trigger: the hoisted value lands on one brand-new register',
                      ','.join(sorted(set(aside))) or 'none')
                dest = sorted(set(aside))[0] if len(set(aside)) == 1 else ''
                if dest:
                    check(int(dest[1:]) in SAVED_REGS,
                          'trigger: that register is callee-saved r4..r11', dest)
                push_off = reg_set(PUSH_RE.search(off_f).group(1)) \
                    if PUSH_RE.search(off_f) else set()
                push_on = reg_set(PUSH_RE.search(on_f).group(1)) \
                    if PUSH_RE.search(on_f) else set()
                pops_off = [reg_set(m.group(1)) for m in POP_PC_RE.finditer(off_f)]
                pops_on = [reg_set(m.group(1)) for m in POP_PC_RE.finditer(on_f)]
                added = push_on - push_off
                if dest:
                    check(int(dest[1:]) in added,
                          'trigger: the frame save is widened by the new '
                          'register',
                          'PUSH %d -> %d regs, added %s'
                          % (len(push_off), len(push_on),
                             ','.join('r%d' % r for r in sorted(added)) or '-'))
                check(bool(pops_on) and len(pops_on) == len(pops_off) and
                      all(p - {15} == push_on - {14} for p in pops_on),
                      'trigger: every return POP restores exactly the saved set',
                      '%d exit(s)' % len(pops_on))
                fr_on = FRAME_RE.search(on_f)
                fbytes = int(fr_on.group(1)) if fr_on else -1
                listing = PUSH_RE.search(on_f)
                nsave = len(push_on) + (1 if listing and 'lr' in
                                        listing.group(1) else 0)
                check(fbytes >= 0 and (4 * nsave + fbytes) % 8 == 0,
                      'trigger: sp stays 8-byte aligned (AAPCS)',
                      '%d saved (incl. lr) + %d frame = %d'
                      % (nsave, fbytes, 4 * nsave + fbytes))
                check(not dangling_labels(h_on),
                      'trigger: every branch target is still defined')
                check(len(h_on) < len(h_off),
                      'trigger: the text shrinks',
                      '%d -> %d bytes' % (len(h_off), len(h_on)))

        # --- 3. it declines when it must ------------------------------------
        if h_off is None or h_on is None:
            check(False, 'decline: the unit has an off and an on arm')
        else:
            fo, fn = functions(h_off), functions(h_on)
            others = [k for k in fo if k != TARGET_FN]
            untouched = [k for k in others if fo[k] == fn.get(k)]
            check(bool(others) and len(untouched) == len(others),
                  'decline: the other functions of the unit are byte-identical',
                  '%d/%d' % (len(untouched), len(others)))
            ko, kn = load_keys(fo.get(TARGET_FN, '')), \
                load_keys(fn.get(TARGET_FN, ''))
            key = ko.most_common(1)[0][0] if ko else None
            if key is None:
                check(False, 'decline: the hot address is there to be declined')
            else:
                kept = kn[key]
                check(kept > ko[key] - kept,
                      'decline: the pass leaves more reloads alone than it '
                      'removes (it is not "hoist everything")',
                      '%d rewritten, %d kept' % (ko[key] - kept, kept))

        # --- 4. plain C is untouched, and still computes --------------------
        arms = {}
        for tag, flags in (('off', PASSES), ('on', PASSES + [FLAG])):
            t, blob, err = build(arkcc, work, 'pure', flags, tag)
            if err:
                check(False, 'pure: %s arm builds' % tag, err[0][:120])
                arms = None
                break
            arms[tag] = (t, blob)
        if arms is not None:
            check(arms['on'][0] == arms['off'][0] and
                  arms['on'][1] == arms['off'][1],
                  'pure C: the pass finds nothing to prove and changes nothing',
                  '%d/%d bytes' % (len(arms['on'][1]), len(arms['off'][1])))
            if not HAVE_UNICORN:
                skip('pure C: emulator value', 'python package unicorn missing')
            else:
                want = py_value()
                got, ok = {}, True
                for tag in ('off', 'on'):
                    st, val, _ = run_image(arms[tag][1])
                    if st != 'returned':
                        check(False, 'pure C: %s arm returns' % tag, st)
                        ok = False
                        break
                    got[tag] = val
                if ok:
                    check(all(v == want for v in got.values()),
                          'pure C: both arms return %d (Python agrees)' % want,
                          ' '.join('%s=%s' % (k, got[k]) for k in ('off', 'on')))

        # --- 5. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_LDHOIST=0'],
                                   'arkcc_noldh')
        if trimmed is None:
            skip('a cropped build refuses -fopt-ldhoist', why)
        else:
            src = os.path.join(ROOT, HAL_REL)
            rc, log = run([trimmed] + ASM_ARM + ['-O2'] + HAL_DEFS +
                          [FLAG, '-o', 't.s', src], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-ldhoist by name',
                  'rc=%d' % rc)
            h_small, e_small = build_hal(trimmed, work, PASSES, 'cropped')
            h_full, e_full = build_hal(arkcc, work, PASSES, 'full')
            if e_small or e_full:
                check(False, 'the cropped build still compiles the unit',
                      (e_small or e_full)[0][:120])
            else:
                check(h_small == h_full,
                      'the cropped build writes the same text as the full '
                      'build when the flag is absent',
                      '%d/%d bytes' % (len(h_small), len(h_full)))
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
