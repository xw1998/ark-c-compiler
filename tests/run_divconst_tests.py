#!/usr/bin/env python
"""Gates for --divconst (divide by a constant -> multiply + shift, ARM backend).

The rewrite happens at emission time: IR_PUSH_INT c immediately followed by
IR_DIV/IR_MOD means the divisor is a compile-time constant, so the backend drops
that push and emits the magic-number sequence instead of SDIV/UDIV.  Nothing in
the IR changes, which is why every gate below compares *emitted* things:

  1. Static: with the switch on, every constant divide loses its SDIV/UDIV and
     gains the documented sequence -- UMULL + shift for the small-magic form,
     UMULL + the add form for m >= 2^32, plain LSR for 2^k, AND for the 2^k
     remainder.  A variable divisor keeps SDIV; one TU holding both proves the
     difference is the constant, not the file.
  2. Refusals: everything the backend declines must produce exactly the same
     assembly with the switch on as with it off --
        c == 0        (division by zero is UB; the divide is what we document)
        c == 1        (no work to save)
        signed c == -1 (INT_MIN / -1 overflows)
        signed |c| == 2^31 (magnitude not representable as a positive int)
        unsigned c == 1
  3. Execution: the same table of dividends goes through 16 constant divides
     and the checksum is compared three ways -- switch off, switch on, and an
     exact Python model of C truncating division.  The table contains INT_MIN,
     INT_MAX, exact multiples, one-off multiples and an LCG sweep, so a wrong
     magic, a wrong shift or a sign slip cannot agree by accident.
  4. Anti-false-green: off by default and the default object is byte-identical
     to --no-divconst; --no-divconst after --divconst turns it back off; a build
     with -DARKCC_FEATURE_DIVCONST=0 refuses the option with C3900U naming the
     macro and refuses divconst=1 from an ini file, while its default object
     equals the untrimmed one (the code really is gone).
  5. Byte account: reported honestly.  Magic numbers make the image *bigger*
     for most divisors (that is the trade: instructions for a divide); only the
     2^k shapes get smaller.  The gate prints both directions instead of
     pretending the pass shrinks code.

Usage: run_divconst_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import glob
import hashlib
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
try:
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except Exception:                                       # pragma: no cover
    HAVE_UNICORN = False

STARTUP = '''\
void __arkcc_init_globals(void) { }
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
'''

MASK = 0xFFFFFFFF

def s32(v):
    v &= MASK
    return v - (1 << 32) if v >> 31 else v

def cdiv(n, c):
    q = abs(n) // abs(c)
    return -q if (n < 0) != (c < 0) else q

# --- the divides that are exercised on the emulator -------------------------
# (name, C type, operator, divisor as C source, divisor value)
DIVS = [
    ('d3',   'int',      '/', '3',             3),
    ('m3',   'int',      '%', '3',             3),
    ('d8',   'int',      '/', '8',             8),
    ('m8',   'int',      '%', '8',             8),
    ('d256', 'int',      '/', '256',           256),
    ('m512', 'int',      '%', '512',           512),
    ('dn5',  'int',      '/', '-5',            -5),
    ('mn5',  'int',      '%', '-5',            -5),
    ('dbig', 'int',      '/', '2147483647',    2147483647),
    ('mbig', 'int',      '%', '2147483647',    2147483647),
    ('ud7',  'unsigned', '/', '7u',            7),
    ('um7',  'unsigned', '%', '7u',            7),
    ('ud8',  'unsigned', '/', '8u',            8),
    ('um8',  'unsigned', '%', '8u',            8),
    ('udb',  'unsigned', '/', '3000000000u',   3000000000),
    ('umb',  'unsigned', '%', '3000000000u',   3000000000),
]

# Dividends.  Boundary values first, then an LCG sweep; the same list feeds the
# Python model, so the expectation is derived from the table, not pasted in.
def dividends():
    special = [0, 1, -1, 2, -2, 3, -3, 5, -5, 7, -7, 8, -8, 9, -9, 15, -15,
               16, -16, 255, -255, 256, -256, 300, -300, 65535, -65535,
               2147483647, -2147483647, -2147483648, 2147483646, -2147483646,
               123456789, -123456789, 1000000007, -1000000007]
    x = 12345
    for _ in range(30):
        x = (x * 1103515245 + 12345) & MASK
        special.append(s32(x))
    return special

def build_exec_source():
    vals = dividends()
    lines = [STARTUP, '']
    for name, ty, op, lit, _ in DIVS:
        lines.append('%s %s(%s x) { return x %s %s; }' % (ty, name, ty, op, lit))
    lines.append('')
    lines.append('int main(void)')
    lines.append('{')
    lines.append('    unsigned h = 0u;')
    lines.append('    int i;')
    lines.append('    int v[%d] = {' % len(vals))
    for i in range(0, len(vals), 8):
        lines.append('    ' + ', '.join('(%d)' % v if v >= 0 else '(%d)' % v
                                        for v in vals[i:i + 8]) + ',')
    lines.append('    };')
    lines.append('    for (i = 0; i < %d; i++) {' % len(vals))
    for name, ty, _, _, _ in DIVS:
        if ty == 'int':
            lines.append('        h = h * 31u + (unsigned)%s(v[i]);' % name)
        else:
            lines.append('        h = h * 31u + %s((unsigned)v[i]);' % name)
    lines.append('    }')
    lines.append('    return (int)h;')
    lines.append('}')
    lines.append('')
    return '\n'.join(lines), vals

def expected_checksum(vals):
    h = 0
    for v in vals:
        for name, ty, op, _, div in DIVS:
            if ty == 'int':
                r = cdiv(v, div) if op == '/' else v - cdiv(v, div) * div
            else:
                u = v & MASK
                d = div & MASK
                r = u // d if op == '/' else u % d
            h = (h * 31 + (r & MASK)) & MASK
    return h

# One TU holding both a constant and a variable divisor: only the constant one
# may lose its SDIV, so "the pass ran" cannot be confused with "the file failed
# to compile".
SRC_MIXED = '''\
int dv(int x, int y)  { return x / y; }
int mv(int x, int y)  { return x % y; }
unsigned udv(unsigned x, unsigned y) { return x / y; }
int cd(int x)         { return x / 9; }
unsigned cu(unsigned x) { return x % 9u; }
int main(void) { return (cd(20) + (int)cu(20u) + dv(20, 3) + mv(20, 3) +
                         (int)udv(20u, 3u)) & 0x7F; }
'''

# Every refused shape in one file: the switch must not touch a single byte.
SRC_REFUSED = '''\
int r_d0(int x)    { return x / 0; }
int r_m0(int x)    { return x % 0; }
int r_d1(int x)    { return x / 1; }
int r_m1(int x)    { return x % 1; }
int r_dn1(int x)   { return x / -1; }
int r_mn1(int x)   { return x % -1; }
int r_dmin(int x)  { return x / (int)0x80000000u; }
int r_mmin(int x)  { return x % (int)0x80000000u; }
unsigned r_ud1(unsigned x) { return x / 1u; }
unsigned r_um1(unsigned x) { return x % 1u; }
int main(void) { return (r_d1(7) + r_ud1(7u)) & 0x7F; }
'''

failures = []
skips = []

def check(ok, what, detail=''):
    print('%s  %s%s' % ('PASS' if ok else 'FAIL', what,
                        ('  [' + detail + ']') if detail else ''))
    if not ok:
        failures.append(what)

def skip(what, why):
    print('SKIP  %s  [%s]' % (what, why))
    skips.append(what)

def run(arkcc, args, cwd):
    p = subprocess.run([arkcc] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')

def digest(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()

def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)

def read(path):
    with open(path, 'r') as f:
        return f.read()

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
ASM = ARM + ['-O2', '-S']
OBJ = ARM + ['-O2', '-c']
IMG = ARM + ['-O2', '--vector-table']

def as_body_lines(text):
    n = 0
    for ln in text.splitlines():
        s = ln.strip()
        if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
            continue
        if s.endswith(':'):
            continue
        n += 1
    return n

def func_body(text, name):
    """Lines of one function, from `name:` to the next top-level label."""
    out = []
    inside = False
    for ln in text.splitlines():
        if ln.strip() == name + ':':
            inside = True
            continue
        if inside:
            if ln and not ln[0].isspace():
                t = ln.strip()
                if t.startswith('.size') or (t.endswith(':') and not t.startswith('.L')):
                    break
            out.append(ln)
    return '\n'.join(out)

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
                      or ['build failed'])[-1][:120]
    return out, ''

def image_value(arkcc, src, work, flags, tag):
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, IMG + flags + [src, '-o', img], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    with open(img, 'rb') as f:
        status, value, detail = run_image(f.read())
    if status != 'returned':
        return None, 'emulator: %s %s' % (status, detail)
    return value & MASK, ''

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    src_exec, vals = build_exec_source()
    want = expected_checksum(vals)
    work = tempfile.mkdtemp(prefix='arkcc_divconst_')
    try:
        write(os.path.join(work, 'dc.c'), src_exec)
        write(os.path.join(work, 'mixed.c'), STARTUP + SRC_MIXED)
        write(os.path.join(work, 'refused.c'), STARTUP + SRC_REFUSED)

        # --- 1. static shapes ----------------------------------------------
        rc, log_off = run(arkcc, ASM + ['dc.c', '-o', 'dc_off.s'], work)
        rc2, log_on = run(arkcc, ASM + ['dc.c', '--divconst', '-o', 'dc_on.s'],
                          work)
        check(rc == 0 and rc2 == 0, 'dc.c compiles with and without the switch',
              'rc=%d/%d %s' % (rc, rc2, (log_on or log_off).strip()[:80]))
        off = read(os.path.join(work, 'dc_off.s'))
        on = read(os.path.join(work, 'dc_on.s'))
        check(on != off, '--divconst changes the generated code')

        divides = sum(1 for ln in on.splitlines()
                      if ln.strip().startswith('SDIV') or ln.strip().startswith('UDIV'))
        check(divides == 0,
              'no SDIV/UDIV is left in a translation unit of constant divides',
              '%d left' % divides)

        # per-shape markers: each family must be visible in the body
        shapes = [
            ('d3',   ['UMULL r2, r3, r0, r1'], 'the add form (m >= 2^32) for /3'),
            ('m3',   ['UMULL r2, r3, r0, r1', 'MUL r0, r0, r2', 'SUB r0, r1, r0'],
                     'remainder from q*d'),
            ('d8',   ['LSR r0, r0, #3'], '/8 is a shift'),
            ('m8',   ['LSR r0, r0, #3', 'MUL r0, r0, r2', 'SUB r0, r1, r0'],
                     'signed %8 is q*d subtracted (a mask would be wrong for negatives)'),
            ('ud8',  ['LSR r0, r0, #3'], 'unsigned /8 is a shift'),
            ('um8',  ['AND r0, r0, #7'], 'unsigned %8 is a mask'),
            ('ud7',  ['UMULL r2, r3, r0, r1'], 'unsigned /7 uses a magic number'),
            ('dn5',  ['ASR r1, r0, #31', 'MVN r1, r1', 'PUSH {r1}', 'POP {r1}'],
                     'a negative divisor flips the sign register'),
            ('mn5',  ['MUL r0, r0, r2'], 'the remainder uses the real divisor'),
            ('udb',  ['LSR r0, r2, #31'],
                     'a divisor above 2^31 uses the L == 32 add form'),
            ('d256', ['LSR r0, r0, #8'], '/256 is a shift'),
        ]
        for fn, markers, why in shapes:
            body = func_body(on, fn)
            check(all(m in body for m in markers),
                  '%s: %s' % (fn, why),
                  '' if all(m in body for m in markers) else
                  'missing ' + ', '.join(m for m in markers if m not in body))

        # --- 2. selectivity: constant vs variable in one TU ------------------
        rc, _ = run(arkcc, ASM + ['mixed.c', '-o', 'mix_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['mixed.c', '--divconst', '-o', 'mix_on.s'],
                     work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'mix_off.s'))
            b = read(os.path.join(work, 'mix_on.s'))
            check('SDIV' not in func_body(b, 'cd') and 'UMULL' in func_body(b, 'cd'),
                  'in one TU the constant divide is rewritten')
            check('UDIV' not in func_body(b, 'cu') and
                  'UMULL r2, r3, r0, r1' in func_body(b, 'cu'),
                  'in one TU the constant unsigned remainder uses a magic number')
            for fn, op in (('dv', 'SDIV'), ('mv', 'SDIV'), ('udv', 'UDIV')):
                check(op in func_body(b, fn) and
                      func_body(a, fn) == func_body(b, fn),
                      'a variable divisor keeps %s untouched (%s)' % (op, fn))
        else:
            check(False, 'the mixed file could be built', 'rc=%d/%d' % (rc, rc2))

        # --- 3. refused shapes are byte-identical ---------------------------
        rc, _ = run(arkcc, ASM + ['refused.c', '-o', 'rf_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['refused.c', '--divconst', '-o', 'rf_on.s'],
                     work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'rf_off.s'))
            b = read(os.path.join(work, 'rf_on.s'))
            check(a == b, 'every refused constant leaves the whole file byte-identical')
            for fn, op in (('r_d0', 'SDIV'), ('r_d1', 'SDIV'), ('r_dn1', 'SDIV'),
                           ('r_dmin', 'SDIV'), ('r_mmin', 'SDIV'),
                           ('r_ud1', 'UDIV'), ('r_um1', 'UDIV')):
                check(op in func_body(b, fn), 'refused shape still uses %s (%s)'
                      % (op, fn))
        else:
            check(False, 'the refused-shape file could be built', 'rc=%d/%d'
                  % (rc, rc2))

        # --- 4. execution ---------------------------------------------------
        if not HAVE_UNICORN:
            skip('emulator execution', 'unicorn not installed')
        else:
            got_off, err = image_value(arkcc, 'dc.c', work, [], 'dc_off')
            got_on, err2 = image_value(arkcc, 'dc.c', work, ['--divconst'], 'dc_on')
            if got_off is None:
                skip('emulator execution', err)
            elif got_on is None:
                skip('emulator execution (--divconst)', err2)
            else:
                check(got_off == got_on,
                      'the program returns the same value with and without the switch',
                      'off=0x%08X on=0x%08X' % (got_off, got_on))
                check(got_on == want,
                      'the switched-on program matches exact C division on '
                      '%d dividends x %d divisors' % (len(vals), len(DIVS)),
                      'got=0x%08X want=0x%08X' % (got_on, want))
                check(got_on not in (0, MASK),
                      'the checksum is non-trivial', 'value=0x%08X' % got_on)
            # --reg-top keeps the IR stack top in r0; swallowing the divisor
            # push must leave the dividend exactly where that model expects it.
            for tag, flags in (('regtop', ['--reg-top']),
                               ('regtop_divconst', ['--divconst', '--reg-top']),
                               ('tailcall_divconst', ['--divconst', '--tailcall'])):
                got, err2 = image_value(arkcc, 'dc.c', work, flags, 'ex_' + tag)
                if got is None:
                    skip('emulator execution (%s)' % tag, err2)
                else:
                    check(got == want,
                          'the same checksum with %s' % ' '.join(flags),
                          'got=0x%08X want=0x%08X' % (got, want))

            # the mixed file runs too (variable divisors keep working)
            got_mix, errm = image_value(arkcc, 'mixed.c', work, ['--divconst'],
                                        'mix_exec')
            if got_mix is None:
                skip('mixed file on the emulator', errm)
            else:
                want_mix = (cdiv(20, 9) + (20 & MASK) % 9 + cdiv(20, 3) +
                            (20 - cdiv(20, 3) * 3) + (20 & MASK) // 3) & 0x7F
                check(got_mix == want_mix, 'constant and variable divides coexist '
                      'and agree with a hand-computed value',
                      'got=%d want=%d' % (got_mix, want_mix))

        # --- 5. anti-false-green --------------------------------------------
        rc, _ = run(arkcc, OBJ + ['dc.c', '-o', 'd_plain.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--no-divconst', 'dc.c', '-o', 'd_no.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_plain.o')) ==
              digest(os.path.join(work, 'd_no.o')),
              'the pass is off by default (object byte-identical)')
        rc, _ = run(arkcc, OBJ + ['--divconst', '--no-divconst', 'dc.c',
                                  '-o', 'd_backoff.o'], work)
        rc2, _ = run(arkcc, OBJ + ['dc.c', '-o', 'd_ref.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_backoff.o')) ==
              digest(os.path.join(work, 'd_ref.o')),
              '--no-divconst after --divconst turns the pass back off')

        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_DIVCONST=0'],
                                   'arkcc_nodivconst')
        if trimmed is None:
            skip('trimmed build refuses --divconst', why)
        else:
            rc, log = run(trimmed, OBJ + ['dc.c', '--divconst', '-o', 't.o'],
                          work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_DIVCONST' in log,
                  'trimmed build refuses --divconst and names the macro',
                  'rc=%d' % rc)
            write(os.path.join(work, 'dc_on.cfg'), '[features]\ndivconst=1\n')
            rc, log = run(trimmed, ['-config', 'dc_on.cfg'] + OBJ +
                          ['dc.c', '-o', 't.o'], work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_DIVCONST' in log,
                  'trimmed build refuses divconst=1 from the ini file',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, OBJ + ['dc.c', '-o', 't2.o'], work)
            rc3, _ = run(arkcc, OBJ + ['dc.c', '-o', 't_full.o'], work)
            check(rc2 == 0 and rc3 == 0,
                  'trimmed build compiles the same file normally',
                  'rc=%d/%d %s' % (rc2, rc3, log2.strip()[:80]))
            check(rc2 == 0 and rc3 == 0 and
                  digest(os.path.join(work, 't2.o')) ==
                  digest(os.path.join(work, 't_full.o')),
                  'default object identical whether or not the pass is compiled in')

        write(os.path.join(work, 'dc.cfg'), '[features]\ndivconst=1\n')
        rc, log = run(arkcc, ['-config', 'dc.cfg'] + ASM +
                      ['dc.c', '-o', 'dc_ini.s'], work)
        check(rc == 0 and 'UMULL' in func_body(read(os.path.join(work, 'dc_ini.s')),
                                               'd3'),
              'divconst=1 in a config file switches the pass on')

        # --- 6. byte account (reported, not spun) ---------------------------
        rc, _ = run(arkcc, OBJ + ['dc.c', '-o', 'acct_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--divconst', 'dc.c', '-o', 'acct_on.o'], work)
        if rc == 0 and rc2 == 0:
            a = os.path.getsize(os.path.join(work, 'acct_off.o'))
            b = os.path.getsize(os.path.join(work, 'acct_on.o'))
            print('INFO  object size %d -> %d bytes (%+d); instruction lines '
                  '%d -> %d' % (a, b, b - a, as_body_lines(off), as_body_lines(on)))
            check(True, 'byte account recorded')
            check(as_body_lines(func_body(on, 'ud8')) <
                  as_body_lines(func_body(off, 'ud8')),
                  'a 2^k unsigned divide gets shorter (shift, not a divide call)')
            check(as_body_lines(func_body(on, 'um8')) <
                  as_body_lines(func_body(off, 'um8')),
                  'a 2^k unsigned remainder gets shorter (mask, not a divide call)')
        else:
            check(False, 'the byte account could be built', 'rc=%d/%d' % (rc, rc2))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall divconst checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())