#!/usr/bin/env python3
"""Gate for the load-hoisting pass (0.9.1, -fopt-ldhoist / S12-1).

The pass deletes a reload of the same `[Rb, #imm]` that the function already
did a few lines earlier, by loading the value once into a register the
function never names at all.  The rules are frozen in docs/EXPR_MODEL.md
S12-1; this gate pins the four things that make the pass trustworthy:

  1. OFF IS OFF.  `-O2 <passes>` and `-O2 <passes> -fno-opt-ldhoist` are
     byte-identical as assembly text and as image, and a build cropped to
     -DARKCC_FEATURE_OPT_LDHOIST=0 produces the same text as the full build
     when the flag is absent.
  2. IT FIRES, AND ONLY IN THE SHAPE THE RULES ALLOW.  The trigger fixture has
     two loads of `[r8, #0]` on one single-predecessor chain, each followed by
     `CMP` and killed by a `MOV` before the next level.  Exactly one load may
     survive, its destination must be a register the function never named, that
     register must be the one both `CMP`s read, the frame save/restore must be
     widened by exactly the same set, sp must still be 8-byte aligned, and the
     instruction count must drop.
  3. IT DECLINES WHEN IT MUST.  A possibly-aliasing store, a call, and a label
     with two predecessors each sit between the two loads; every one of those
     three fixtures must come out byte-identical.  So must a pure-C fixture
     that the pass has no provable candidate in.
  4. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_LDHOIST=0 refuses
     `-fopt-ldhoist` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file without the flag.

Why the fixtures are inline assembly: the seven frozen rules are narrow enough
that arkcc's own code generation cannot produce a qualifying function from C
(two loads of one address on a straight chain, with the destination killed
between them and the result temporary landed on the same register).  The
assembler copies `__asm volatile` text through verbatim, so the fixtures below
spell the exact instruction sequence.  Mnemonics must be upper case: the text
pass compares mnemonics literally, exactly as the emitter spells them.

Usage: run_ldhoist_tests.py [path-to-arkcc]
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

FLAG = '-fopt-ldhoist'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']
# The pass runs last among the text passes, on the frame the earlier ones left,
# so the gate measures it in the configuration it ships in.
PASSES = ['-fopt-vstack', '-fopt-addr', '-fopt-frame']

# --- fixtures -------------------------------------------------------------
# Every fixture is one instruction per __asm statement, so a difference
# between two arms is exactly the pass's edit and nothing else.

def _body(name, call_and_tail, between):
    """A probe function with the two loads and a pluggable middle section."""
    return (
        'struct S { unsigned a; unsigned b; };\n'
        'extern void lh_callee(void);\n'
        'int lh_guard = 1;\n'
        'unsigned %s(struct S *p)\n'
        '{\n'
        '    unsigned t = 0;\n'
        '    __asm volatile("    MOV r8, r0");\n'
        '    __asm volatile("    MOV r10, #11");\n'
        '    __asm volatile("    MOV r11, #22");\n'
        '    __asm volatile("    LDR r5, [r8, #0]");\n'
        '    __asm volatile("    CMP r5, r10");\n'
        '    __asm volatile("    BNE .Lt1");\n'
        '    __asm volatile("    MOV r5, #10");\n'
        '%s'
        '    __asm volatile(".Lt1:");\n'
        '    __asm volatile("    LDR r5, [r8, #0]");\n'
        '    __asm volatile("    CMP r5, r11");\n'
        '    __asm volatile("    BNE .Lt2");\n'
        '    __asm volatile("    MOV r5, #20");\n'
        '%s'
        '    __asm volatile(".Lt2:");\n'
        '    __asm volatile("    MOV r5, #0");\n'
        '    __asm volatile(".Lend:");\n'
        '    t = 1;\n'
        '    return t + (unsigned)p;\n'
        '}\n'
        'int main(void) { return 0; }\n'
        % (name, between, call_and_tail))


# MUST TRIGGER: nothing between the two loads but a compare, a branch and the
# write that kills the destination.
TRIGGER = '    __asm volatile("    B .Lend");\n'
TRIGGER_C = _body('lh_probe', TRIGGER, TRIGGER)

# MUST NOT TRIGGER #1: a store that may alias any address ends the region.
NOSTORE_C = _body('lh_nostore',
                  '    __asm volatile("    B .Lend");\n',
                  '    __asm volatile("    STR r0, [r8, #4]");\n'
                  '    __asm volatile("    B .Lend");\n')

# MUST NOT TRIGGER #2: a call can clobber the hoisted register's memory.
NOCALL_C = _body('lh_nocall',
                 '    __asm volatile("    B .Lend");\n',
                 '    __asm volatile("    BL lh_callee");\n'
                 '    __asm volatile("    B .Lend");\n')

# MUST NOT TRIGGER #3: a label with two predecessors (one of them a branch
# out of the arm above it) ends the region before the second load.
NOLABEL_C = (
    'struct S { unsigned a; unsigned b; };\n'
    'int lh_guard = 1;\n'
    'unsigned lh_nolabel(struct S *p)\n'
    '{\n'
    '    unsigned t = 0;\n'
    '    __asm volatile("    MOV r8, r0");\n'
    '    __asm volatile("    MOV r10, #11");\n'
    '    __asm volatile("    MOV r11, #22");\n'
    '    __asm volatile("    LDR r5, [r8, #0]");\n'
    '    __asm volatile("    CMP r5, r10");\n'
    '    __asm volatile("    BNE .Lm");\n'
    '    __asm volatile("    MOV r5, #10");\n'
    '    __asm volatile("    BEQ .Lm");\n'
    '    __asm volatile("    MOV r5, #12");\n'
    '    __asm volatile(".Lm:");\n'
    '    __asm volatile("    LDR r5, [r8, #0]");\n'
    '    __asm volatile("    CMP r5, r11");\n'
    '    __asm volatile("    BNE .Lz");\n'
    '    __asm volatile("    MOV r5, #20");\n'
    '    __asm volatile(".Lz:");\n'
    '    __asm volatile("    MOV r5, #0");\n'
    '    __asm volatile(".Lend:");\n'
    '    t = 1;\n'
    '    return t + (unsigned)p;\n'
    '}\n'
    'int main(void) { return 0; }\n')

# MUST NOT TRIGGER #4: ordinary C.  Whatever the emitter produces here, the
# pass must not find a provable region in it, so the text is byte-identical --
# and the emulator must still return the Python answer.
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
    with open(asm, encoding='utf-8') as fh:
        text = fh.read()
    with open(img, 'rb') as fh:
        blob = fh.read()
    return text, blob, None

def build_asm(arkcc, work, name, flags, tag):
    """Assembly only, for fixtures whose image would not run on its own."""
    src = os.path.join(work, name + '.c')
    asm = os.path.join(work, '%s_%s.s' % (name, tag))
    rc, log = run([arkcc] + ASM_ARM + ['-O2', '-I', INC, src, '-o', asm]
                  + list(flags), work)
    if rc != 0:
        return None, log.strip().splitlines()[:1] or ['asm failed']
    with open(asm, encoding='utf-8') as fh:
        return fh.read(), None

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
LABEL_DEF_RE = re.compile(r'^\s*(\.[A-Za-z0-9_.]+):', re.M)
BRANCH_REF_RE = re.compile(r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')
PUSH_RE = re.compile(r'^\s+PUSH\s+\{([^}]*)\}\s*$', re.M)
POP_PC_RE = re.compile(r'^\s+POP\s+\{([^}]*\bpc\b[^}]*)\}\s*$', re.M)
FRAME_RE = re.compile(r'^\s+SUB\s+sp,\s*sp,\s*#(\d+)\s*$', re.M)
LOAD_RE = re.compile(r'^\s+LDR\s+(r\d+),\s*\[r8, #0\]\s*$', re.M)
CMP_RE = re.compile(r'^\s+CMP\s+(r\d+),\s*(r\d+)\s*$', re.M)

def func_text(text, name):
    m = re.search(r'^%s:\n(.*?)^\.size %s,' % (re.escape(name), re.escape(name)),
                  text, re.M | re.S)
    return m.group(1) if m else ''

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
        for name, body in (('trigger', TRIGGER_C), ('nostore', NOSTORE_C),
                           ('nocall', NOCALL_C), ('nolabel', NOLABEL_C),
                           ('pure', PURE_C)):
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        ta, ba, e1 = build(arkcc, work, 'trigger', PASSES, 'plain')
        tb, bb, e2 = build(arkcc, work, 'trigger',
                           PASSES + ['-fno-opt-ldhoist'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the trigger fixture',
                  (e1 or e2)[0][:120])
        else:
            check(ta == tb and ba == bb,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-ldhoist)',
                  '%d/%d bytes' % (len(ba), len(bb)))

        # --- 2. it fires, and only in the shape the rules allow -------------
        arms = {}
        for tag, flags in (('off', PASSES), ('on', PASSES + [FLAG])):
            t, blob, err = build(arkcc, work, 'trigger', flags, tag)
            if err:
                check(False, 'trigger: %s arm builds' % tag, err[0][:120])
                arms = None
                break
            arms[tag] = (t, blob)
        if arms is not None:
            off_t = func_text(arms['off'][0], 'lh_probe')
            on_t = func_text(arms['on'][0], 'lh_probe')
            if not off_t or not on_t:
                check(False, 'trigger: lh_probe is in the assembly')
            else:
                ld_off = LOAD_RE.findall(off_t)
                ld_on = LOAD_RE.findall(on_t)
                check(len(ld_off) == 2 and len(ld_on) == 1,
                      'trigger: two loads of [r8,#0] collapse to one',
                      '%d -> %d' % (len(ld_off), len(ld_on)))
                dest = ld_on[0] if ld_on else ''
                if dest:
                    n = int(dest[1:])
                    check(4 <= n <= 11,
                          'trigger: the kept value lands on a callee-saved '
                          'register r4..r11', dest)
                    check(not re.search(r'\b%s\b' % dest, off_t),
                          'trigger: that register is one the function never '
                          'named', dest)
                    cmps_off = CMP_RE.findall(off_t)
                    cmps_on = CMP_RE.findall(on_t)
                    check(len(cmps_on) == 2 and
                          all(dest in pair for pair in cmps_on),
                          'trigger: both compares read the hoisted register',
                          ' '.join('CMP %s, %s' % p for p in cmps_on))
                    check(cmps_off and
                          not any(dest in pair for pair in cmps_off),
                          'trigger: and neither did before',
                          ' '.join('CMP %s, %s' % p for p in cmps_off))
                push_off = reg_set(PUSH_RE.search(off_t).group(1)) \
                    if PUSH_RE.search(off_t) else set()
                push_on = reg_set(PUSH_RE.search(on_t).group(1)) \
                    if PUSH_RE.search(on_t) else set()
                pops_off = [reg_set(m.group(1)) for m in POP_PC_RE.finditer(off_t)]
                pops_on = [reg_set(m.group(1)) for m in POP_PC_RE.finditer(on_t)]
                added = push_on - push_off
                if dest:
                    check(dest[0] == 'r' and int(dest[1:]) in added,
                          'trigger: the frame save is widened by the new '
                          'register',
                          'PUSH %d -> %d regs, added %s'
                          % (len(push_off), len(push_on),
                             ','.join('r%d' % r for r in sorted(added)) or '-'))
                check(bool(pops_on) and len(pops_on) == len(pops_off) and
                      all(p - {15} == push_on - {14} for p in pops_on),
                      'trigger: every return POP restores exactly the saved '
                      'set',
                      '%d exit(s)' % len(pops_on))
                check(len(added) in (1, 2),
                      'trigger: one or two registers are added, never more',
                      '%d' % len(added))
                fr_on = FRAME_RE.search(on_t)
                fbytes = int(fr_on.group(1)) if fr_on else -1
                listing = PUSH_RE.search(on_t)
                nsave = len(push_on) + (1 if listing and 'lr' in
                                        listing.group(1) else 0)
                check(fbytes >= 0 and (4 * nsave + fbytes) % 8 == 0,
                      'trigger: sp stays 8-byte aligned (AAPCS)',
                      '%d saved (incl. lr) + %d frame = %d'
                      % (nsave, fbytes, 4 * nsave + fbytes))
                check(insn_count(on_t) == insn_count(off_t) - 1,
                      'trigger: exactly one instruction goes (the reload)',
                      '%d -> %d' % (insn_count(off_t), insn_count(on_t)))
                check(not dangling_labels(on_t),
                      'trigger: every branch target is still defined')
                check(len(arms['on'][1]) <= len(arms['off'][1]),
                      'trigger: the image never grows',
                      'off/on=%d/%d bytes'
                      % (len(arms['off'][1]), len(arms['on'][1])))

        # --- 3. it declines when it must ------------------------------------
        for name, func in (('nostore', 'lh_nostore'),
                           ('nocall', 'lh_nocall'),
                           ('nolabel', 'lh_nolabel')):
            on_t, eo = build_asm(arkcc, work, name, PASSES + [FLAG], 'on')
            off_t, ef = build_asm(arkcc, work, name, PASSES, 'off')
            if eo or ef:
                check(False, '%s: the fixture builds' % name,
                      (eo or ef)[0][:120])
                continue
            check(on_t == off_t,
                  '%s: a %s between the two loads leaves the text '
                  'byte-identical' % (name, {
                      'nostore': 'possibly-aliasing store',
                      'nocall': 'call',
                      'nolabel': 'two-predecessor label'}[name]),
                  '%d/%d bytes' % (len(on_t), len(off_t)))

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
                  'pure C: the pass finds nothing to prove and changes '
                  'nothing',
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
            src = os.path.join(work, 'trigger.c')
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC, src,
                          '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-ldhoist by name',
                  'rc=%d' % rc)
            t_small, e_small = build_asm(trimmed, work, 'trigger', PASSES,
                                         'cropped')
            t_full, e_full = build_asm(arkcc, work, 'trigger', PASSES, 'full')
            if e_small or e_full:
                check(False, 'the cropped build still compiles the fixture',
                      (e_small or e_full)[0][:120])
            else:
                check(t_small == t_full,
                      'the cropped build writes the same text as the full '
                      'build when the flag is absent',
                      '%d/%d bytes' % (len(t_small), len(t_full)))
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
