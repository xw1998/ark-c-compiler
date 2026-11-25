#!/usr/bin/env python3
"""Gate for the branch-fusion pass (0.9.1, -fopt-cbz).

`if (x)` / `if (!x)` reaches the ARM backend as a stack pop plus a compare
against zero plus a conditional branch:

    POP {r0}            ; or MOV r0, r5 under -fopt-vstack
    CMP r0, #0
    BEQ .L_fn_N         ; BNE for the negated form

Cortex-M has one two-byte instruction that does the whole job: `CBZ rN, label`
(`CBNZ`).  The pass rewrites the pair in the emitted text, after -fopt-vstack
and -fopt-addr have already shortened the function, so it works on the final
shape.  It is opt-in like every other 0.9.x pass: the default output is
byte-identical.

What is checked:

  1. OFF IS OFF.  `-O2` and `-O2 -fno-opt-cbz` are byte-identical, as
     assembly text and as image.
  2. IT PAYS.  Instruction count strictly drops and the CBZ the pass is
     supposed to produce actually appears -- a rule that silently never fires
     would still pass a count-only check.
  3. IT DECLINES WHEN IT MUST.  A body longer than the 0..62-byte T1 range
     keeps its CMP/BEQ pair: the bound is an upper bound on the region, so a
     candidate that is out of range can never be fused.
  4. THE ANSWER IS THE SAME.  One fixture returns the value computed here in
     Python on the emulator, in five arms; a wrong branch offset would take
     the wrong path (or fetch from the middle of an instruction) and change
     the value or fault.
  5. CROPPED OUT, REFUSED.  A build with -DARKCC_FEATURE_OPT_CBZ=0 refuses
     `-fopt-cbz` by name (C3900U) instead of accepting it and doing nothing,
     and still compiles the same file without the flag.
  6. THE RETARGET STAYS ENCODABLE.  -fopt-live may forward a `MOV r0, rS`
     into the CBZ/CBNZ that tests it, but T1 encodes only r0-r7.  A retarget
     that names r8-r12 must be declined: the encoder masks the register with
     &7, so an accepted one would silently become `CBNZ r0` on the board.
     The same fixture pins the register copy in lv_repl_reg: forwarding a
     register past a branch target used to copy the label through a 7-char
     buffer, turning `.L_HAL_RCC_OscConfig_0` into `.L_HAL_R` (an undefined
     label).  Every branch target in the output must be defined.
  7. THE ASSEMBLER REFUSES IT TOO.  `CBZ r8` is an error (naming r0-r7),
     not a silent `CBZ r0`: an assembler that masks its operand is the other
     half of the same wrong answer.
  8. A CALL KILLS THE FLAGS.  AAPCS does not preserve NZCV across a call, so
     the flags a CMP set cannot be relied on after a BL.  A pair whose
     fall-through runs into a call is therefore still fusable, and the pass
     must take it.  Two arms must return the same number afterwards.
  9. A REGION THAT READS THE FLAGS KEEPS THE PAIR.  If the fall-through
     consumes the flags before anything overwrites them (an `ITE` block in
     this fixture), the CMP must stay: on/off are byte-identical.

Usage: run_cbz_tests.py [path-to-arkcc]
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

FLAG = '-fopt-cbz'
INC = os.path.join(ROOT, 'stdlib', 'include')
ASM_ARM = ['-target', 'arm', '-mcpu', 'Cortex-M4', '-S']
IMG_ARM = ['-target', 'arm', '--vector-table']

# short_body: every `if` body is a handful of instructions, well inside the
# T1 range.  long_body: 20 statements in the body -- the region bound is
# 20*4 = 80 bytes, so the pass must leave that pair alone.
SHORT = """\
int cbz_pad_a;
static int add2(int a, int b) { return a + b; }
static int short_body(int a, int b)
{
    int s = 0;
    if (a) s += b;
    if (!b) s -= a;
    if (a > b) s ^= 3;
    s = add2(s, a);
    if (s == 0) s = 7;
    return s;
}
static int twice(int x)
{
    int y = 0;
    if (x) { y = x * 3; }
    if (y < 10) y += 1;
    return y;
}
int main(void)
{
    return (short_body(3, 5) + short_body(0, 5) + twice(2) + twice(0)) & 0xFF;
}
"""

LONG = """\
int cbz_pad_b;
static int long_body(int n, int k)
{
    int s = 0;
    if (n) {
        s += 1; s += 2; s += 3; s += 4; s += 5;
        s += 6; s += 7; s += 8; s += 9; s += 10;
        s += 11; s += 12; s += 13; s += 14; s += 15;
        s += 16; s += 17; s += 18; s += 19; s += k;
    }
    return s;
}
int main(void) { return long_body(1, 5) & 0xFF; }
"""

def py_short():
    def body(a, b):
        s = 0
        if a: s += b
        if not b: s -= a
        if a > b: s ^= 3
        s = s + a
        if s == 0: s = 7
        return ((s + (1 << 31)) % (1 << 32)) - (1 << 31)
    def twice(x):
        y = 0
        if x: y = x * 3
        if y < 10: y += 1
        return y
    return (body(3, 5) + body(0, 5) + twice(2) + twice(0)) & 0xFF

def py_long():
    s = 0
    for i in range(1, 20):
        s += i
    s += 5
    return s & 0xFF

RETARGET = """\
int cbz_rt_pad = 1;
int g_rt_buf[4] = {1, 2, 3, 4};
static int cbz_label_keep_a_long_name(int *p, int n)
{
    int s = 0, i;
    if (p == 0) return 1;
    for (i = 0; i < n; i++) s += p[i];
    if (s == 0) return 2;
    s += p[0];
    s += p[n > 0 ? n - 1 : 0];
    s += p[1];
    return s;
}
int main(void)
{
    return cbz_label_keep_a_long_name(g_rt_buf, 4) & 0xFF;
}
"""
RETARGET_WANT = 17

# CALL: the fall-through of the guarded branch runs straight into a call.
# `cbzbl_callee` has a loop so the inliner leaves it alone; the body of the
# `if` is one BL plus two stores, so the skip target is inside the T1 range
# and the pair is fusable on distance -- the only question is the flags.
CALL = """\
int cbzbl_pad;
int g_cbzbl;
int cbzbl_callee(int v)
{
    int s = 0, i;
    for (i = 0; i < v; i++) s += i;
    return s + 7;
}
static int cbzbl_body(int a)
{
    if (a) g_cbzbl = cbzbl_callee(3);
    return g_cbzbl;
}
int main(void) { return (cbzbl_body(1) + cbzbl_body(0)) & 0xFF; }
"""
CALL_WANT = 20          # callee(3) = 0+1+2+7 = 10, kept by the a==0 arm

# FLAGREAD: the fall-through opens with an IT block, i.e. it consumes the
# very flags the CMP set.  Fusing here would delete them.
FLAGREAD = """\
int cbzfr_pad;
static int cbzfr_body(int a)
{
    int s = 0;
    if (a) {
        __asm__("ITE EQ\n Moveq r0, #1\n MOVne r0, #2");
        s = 1;
    }
    return s;
}
int main(void) { return cbzfr_body(1) & 0xFF; }
"""
FLAGREAD_WANT = 1

CASES = [
    ('short', SHORT, py_short(), True),
    ('long', LONG, py_long(), False),
]

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

INSN_RE = re.compile(r'^\s+[A-Za-z][A-Za-z0-9.]*\s')
CBZ_RE = re.compile(r'^\s+(?:CBZ|CBNZ)\s+r[0-7]\s*,\s*\.L_')
CMP0_RE = re.compile(r'^\s+CMP\s+r0\s*,\s*#0\s*$')
BEQ_RE = re.compile(r'^\s+(?:BEQ|BNE)\s+\.L_')
HIGH_CBZ_RE = re.compile(r'^\s+(?:CBZ|CBNZ)\s+r(?:[89]|1[0-2])\b')
BRANCH_REF_RE = re.compile(
    r'^\s+(?:B[A-Z]*|CBZ|CBNZ)\s+(\.[A-Za-z0-9_.]+)\s*$')
LABEL_DEF_RE = re.compile(r'^(\.[A-Za-z0-9_.]+):', re.M)

def dangling_labels(text):
    """Branch targets that name no label defined in the same text."""
    defs = set(LABEL_DEF_RE.findall(text))
    refs = set()
    for ln in text.splitlines():
        m = BRANCH_REF_RE.match(ln)
        if m:
            refs.add(m.group(1))
    return refs - defs

def insn_count(text):
    return sum(1 for ln in text.splitlines() if INSN_RE.match(ln))

def count_cbz(text):
    return sum(1 for ln in text.splitlines() if CBZ_RE.match(ln))

def count_cmp_branch(text):
    """Adjacent `CMP r0, #0` + BEQ/BNE: the pair the pass should have taken."""
    lines = [ln.rstrip() for ln in text.splitlines()]
    n = 0
    for i in range(len(lines) - 1):
        if CMP0_RE.match(lines[i]) and BEQ_RE.match(lines[i + 1]):
            n += 1
    return n

FLAG_WRITERS = ('CMP', 'CMN', 'TST', 'TEQ', 'ADDS', 'SUBS', 'ANDS', 'ORRS',
                'EORS', 'BICS', 'MVNS', 'LSLS', 'LSRS', 'ASRS', 'RORS',
                'MULS', 'MOVS', 'NEGS')


def pairs_reaching_call(text):
    """`CMP rX, #0` + Bcc pairs whose fall-through reaches a BL first.

    AAPCS does not preserve the flags across a call, so these pairs are the
    ones the pass may fuse even though the flags look live.  A flags writer or
    an IT block reached earlier means the region does consume the flags, and
    the pair must stay.
    """
    lines = [ln.strip() for ln in text.splitlines()]
    n = 0
    for i in range(len(lines) - 1):
        if not (CMP0_RE.match(' ' + lines[i] + ' ') or
                re.match(r'^CMP\s+r\d+\s*,\s*#0$', lines[i])):
            continue
        if not re.match(r'^(?:BEQ|BNE)\s+\.L_', lines[i + 1]):
            continue
        for ln in lines[i + 2:i + 66]:
            if not ln or ln.startswith('.'):
                continue
            mn = ln.split()[0]
            if mn == 'BL':
                n += 1
                break
            if mn in FLAG_WRITERS or mn.startswith('IT'):
                break
            if mn.startswith('BX') or mn.startswith('BLX'):
                break
    return n


def cbz_before_call(text):
    """CBZ/CBNZ instructions whose fall-through runs into a BL.

    These are the sites this gate exists for: the CMP that used to set the
    flags is gone, so the conditional is now a single instruction and the
    call that follows cannot have been relying on those flags.
    """
    lines = [ln.strip() for ln in text.splitlines()]
    n = 0
    for i, ln in enumerate(lines):
        if not re.match(r'^(?:CBZ|CBNZ)\s+r\d+\s*,\s*\.L_', ln):
            continue
        for nxt in lines[i + 1:i + 66]:
            if not nxt or nxt.startswith('.'):
                continue
            mn = nxt.split()[0]
            if mn == 'BL':
                n += 1
                break
            if mn in FLAG_WRITERS or mn.startswith('IT'):
                break
            if mn.startswith('BX') or mn.startswith('BLX'):
                break
    return n


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

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_cbz_')
    try:
        for name, body, _, _ in CASES:
            write(os.path.join(work, name + '.c'), body)

        # --- 1. off is off --------------------------------------------------
        text_a, blob_a, e1 = build(arkcc, work, 'short', [], 'plain')
        text_b, blob_b, e2 = build(arkcc, work, 'short', ['-fno-opt-cbz'], 'nofl')
        if e1 or e2:
            check(False, 'the default build compiles the fixture',
                  (e1 or e2)[0][:120])
        else:
            check(text_a == text_b and blob_a == blob_b,
                  'the default build ignores the pass '
                  '(-O2 == -O2 -fno-opt-cbz)',
                  '%d/%d bytes' % (len(blob_a), len(blob_b)))

        for name, body, _want, fusible in CASES:
            arms = {}
            for tag, flags in (('base', []),
                               ('off', ['-fno-opt-cbz']),
                               ('on', [FLAG]),
                               ('va', ['-fopt-vstack', '-fopt-addr']),
                               ('all', ['-fopt-vstack', '-fopt-addr', FLAG])):
                t, blob, err = build(arkcc, work, name, flags, tag)
                if err:
                    arms[tag] = None
                    check(False, '%s: %s arm builds' % (name, tag), err[0][:120])
                    break
                arms[tag] = (t, blob)
            if any(v is None for v in arms.values()):
                continue

            n_base = insn_count(arms['base'][0])
            n_on = insn_count(arms['on'][0])
            n_all = insn_count(arms['all'][0])
            c_base = count_cbz(arms['base'][0])
            c_on = count_cbz(arms['on'][0])
            c_all = count_cbz(arms['all'][0])

            if fusible:
                check(c_base == 0 and c_on > 0,
                      '%s: CBZ/CBNZ appear only with the flag' % name,
                      'base=%d on=%d' % (c_base, c_on))
                check(n_on < n_base, '%s: instructions drop' % name,
                      '%d -> %d' % (n_base, n_on))
                check(count_cmp_branch(arms['on'][0]) <
                      count_cmp_branch(arms['base'][0]),
                      '%s: the CMP #0 + branch pairs are consumed' % name,
                      'pairs base=%d on=%d'
                      % (count_cmp_branch(arms['base'][0]),
                         count_cmp_branch(arms['on'][0])))
                n_va = insn_count(arms['va'][0])
                check(n_all < n_va,
                      '%s: it still pays on top of -fopt-vstack/-fopt-addr' % name,
                      '%d -> %d' % (n_va, n_all))
                check(c_all > 0, '%s: the pass runs after the other two' % name,
                      'all=%d' % c_all)
            else:
                check(c_on == 0 and c_all == 0,
                      '%s: an out-of-range body is left alone' % name,
                      'on=%d all=%d' % (c_on, c_all))
                check(n_on == n_base,
                      '%s: nothing is rewritten when the target is too far' % name,
                      '%d -> %d' % (n_base, n_on))

            check(len(arms['on'][1]) <= len(arms['base'][1]) and
                  len(arms['all'][1]) <= len(arms['va'][1]),
                  '%s: the image never grows' % name,
                  'base/on=%d/%d va/all=%d/%d bytes'
                  % (len(arms['base'][1]), len(arms['on'][1]),
                     len(arms['va'][1]), len(arms['all'][1])))

            if not HAVE_UNICORN:
                skip('%s: emulator value' % name, 'python package unicorn missing')
                continue
            got = {}
            ok = True
            for tag in ('base', 'off', 'on', 'va', 'all'):
                st, val, _ = run_image(arms[tag][1])
                if st != 'returned':
                    check(False, '%s: %s arm returns' % (name, tag), st)
                    ok = False
                    break
                got[tag] = val
            if ok:
                check(all(v == _want for v in got.values()),
                      '%s: all five arms return %d' % (name, _want),
                      ' '.join('%s=%s' % (k, got[k]) for k in
                               ('base', 'off', 'on', 'va', 'all')))

        # --- 6. retarget stays encodable, labels stay whole ----------------
        write(os.path.join(work, 'retarget.c'), RETARGET)
        rt_flags = ['-fopt-vstack', '-fopt-vreg', '-fopt-live',
                    '-fopt-cbranch', '-fopt-imm', FLAG]
        rt_text, rt_blob, rt_err = build(arkcc, work, 'retarget', rt_flags, 'all6')
        if rt_err:
            check(False, 'the six-pass fixture builds', rt_err[0][:120])
        else:
            check(count_cbz(rt_text) > 0,
                  'the six-pass fixture really fuses a branch',
                  'cbz=%d' % count_cbz(rt_text))
            high = [ln for ln in rt_text.splitlines()
                    if HIGH_CBZ_RE.match(ln)]
            check(not high,
                  'no CBZ/CBNZ is retargeted onto r8-r12',
                  '; '.join(h.strip() for h in high[:3]) or 'none')
            dangling = dangling_labels(rt_text)
            check(not dangling,
                  'every branch target is defined (no 7-char label truncation)',
                  ', '.join(sorted(dangling)[:4]) or 'all resolve')
            if HAVE_UNICORN:
                st, val, _ = run_image(rt_blob)
                check(st == 'returned' and val == RETARGET_WANT,
                      'the six-pass fixture returns %d' % RETARGET_WANT,
                      '%s=%s' % (st, val))
            else:
                skip('the six-pass fixture value', 'unicorn missing')

        # --- 8. a call kills the flags --------------------------------------
        write(os.path.join(work, 'call.c'), CALL)
        c_off, c_offb, c_e1 = build(arkcc, work, 'call', [], 'base')
        c_on, c_onb, c_e2 = build(arkcc, work, 'call', [FLAG], 'on')
        if c_e1 or c_e2:
            check(False, 'the call fixture builds', (c_e1 or c_e2)[0][:120])
        else:
            p_off, p_on = count_cmp_branch(c_off), count_cmp_branch(c_on)
            r_off = pairs_reaching_call(c_off)
            check(r_off > 0,
                  'the call fixture has pairs whose fall-through reaches a BL',
                  'sites=%d of %d pairs' % (r_off, p_off))
            check(cbz_before_call(c_off) == 0 and cbz_before_call(c_on) >= 2,
                  'those pairs become CBZ/CBNZ that branch into the call',
                  'cbz-before-call off=%d on=%d'
                  % (cbz_before_call(c_off), cbz_before_call(c_on)))
            check(p_on < p_off,
                  'the CMP #0 + branch pairs are consumed', 'pairs %d -> %d'
                  % (p_off, p_on))
            check(count_cbz(c_on) > count_cbz(c_off),
                  'the call fixture gains a CBZ', 'cbz %d -> %d'
                  % (count_cbz(c_off), count_cbz(c_on)))
            check(insn_count(c_on) < insn_count(c_off),
                  'the call fixture loses instructions',
                  '%d -> %d' % (insn_count(c_off), insn_count(c_on)))
            check(len(c_onb) <= len(c_offb), 'its image does not grow',
                  '%d -> %d bytes' % (len(c_offb), len(c_onb)))
            if not HAVE_UNICORN:
                skip('call: emulator value', 'unicorn missing')
            else:
                got, ok = {}, True
                for tag, blob in (('base', c_offb), ('on', c_onb)):
                    st, val, _ = run_image(blob)
                    if st != 'returned':
                        check(False, 'call: %s arm returns' % tag, st)
                        ok = False
                        break
                    got[tag] = val
                if ok:
                    check(all(v == CALL_WANT for v in got.values()),
                          'call: both arms return %d (the call still happens)'
                          % CALL_WANT,
                          ' '.join('%s=%s' % (k, got[k]) for k in
                                   ('base', 'on')))

        # --- 9. a fall-through that reads the flags keeps the pair ----------
        write(os.path.join(work, 'flagread.c'), FLAGREAD)
        f_off, f_offb, f_e1 = build(arkcc, work, 'flagread', [], 'base')
        f_on, f_onb, f_e2 = build(arkcc, work, 'flagread', [FLAG], 'on')
        if f_e1 or f_e2:
            check(False, 'the flag-reading fixture builds', (f_e1 or f_e2)[0][:120])
        else:
            check(count_cmp_branch(f_on) == count_cmp_branch(f_off) > 0,
                  'a fall-through that consumes the flags keeps its CMP/branch',
                  'pairs base=%d on=%d'
                  % (count_cmp_branch(f_off), count_cmp_branch(f_on)))
            check(f_on == f_off and f_onb == f_offb,
                  'the flag-reading fixture is byte-identical on/off',
                  '%d bytes as text, %d as image' % (len(f_on), len(f_onb)))
            if not HAVE_UNICORN:
                skip('flagread: emulator value', 'unicorn missing')
            else:
                st, val, _ = run_image(f_onb)
                check(st == 'returned' and val == FLAGREAD_WANT,
                      'flagread: the guarded branch still works (%d)'
                      % FLAGREAD_WANT, '%s=%s' % (st, val))

        # --- 7. the assembler refuses a high CBZ register -------------------
        asm_src = os.path.join(work, 'cbz_high.s')
        with open(asm_src, 'w', newline='\n', encoding='utf-8') as fh:
            fh.write('Reset_Handler:\n    MOV r0, #1\n    CBZ r8, L1\n'
                     '    BX lr\nL1:\n    BX lr\n')
        rc, log = run([arkcc, '-target', 'arm', '-c', '-o',
                       os.path.join(work, 'cbz_high.o'), asm_src], work)
        check(rc != 0 and 'r0-r7' in log,
              'the assembler rejects `CBZ r8` instead of masking it',
              'rc=%d' % rc)

        # --- 5. cropped out, refused ----------------------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_CBZ=0'], 'arkcc_nocbz')
        if trimmed is None:
            skip('a cropped build refuses -fopt-cbz', why)
        else:
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'short.c'), '-o', 't.s', FLAG], work)
            check(rc != 0 and 'C3900U' in log and FLAG in log,
                  'the cropped build refuses -fopt-cbz by name', 'rc=%d' % rc)
            rc, log = run([trimmed, '-S'] + ASM_ARM + ['-O2', '-I', INC,
                          os.path.join(work, 'short.c'), '-o', 't.s'], work)
            check(rc == 0, 'the cropped build still compiles without the flag',
                  'rc=%d' % rc)
        return 1 if failures else 0
    finally:
        if '--keep' not in sys.argv:
            shutil.rmtree(work, ignore_errors=True)

if __name__ == '__main__':
    sys.exit(main())
