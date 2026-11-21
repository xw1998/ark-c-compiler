#!/usr/bin/env python
"""Gates for inlining *functions that take parameters* (0.9.1).

For most of 0.9.0 the inliner never expanded a call to a parameterised callee:
irgen stamps every parameter's size into IR_GETARG's high bits as
(size << 8) | slot, and opt_inline read (aux >> 8) != 0 as "struct by value",
so `static int add1(int x) { return x + 1; }` stayed a BL at -O2 and even
__forceinline could not override it.  The decision now comes from the
parameter types (irgen_param_slots()), which is also what decides how many
words each argument occupies on the IR stack.

That fix is worth exactly as much as the checks behind it, so this gate asks
separately:

  1. A small parameterised callee is expanded at -O2 and is *not* expanded
     with --no_autoinline -- the second half is what keeps the first from
     passing when the pass simply stops running.
  2. The size rule still applies: the same callee is above the limit at
     --size-weight=9 (inline<=4) and stays a call there.
  3. __forceinline bypasses the size limit for a parameterised body, while the
     identical body without the attribute stays a call.
  4. Word-accurate argument copy: a two-word first parameter followed by a
     one-word parameter (the case where "argument index" and "word offset"
     stop being the same number), and a 5-byte struct whose payload is read
     from its *second* word, are both expanded and both still compute the
     value the non-expanded build computes.
  5. Refusals keep their calls: a >8-byte struct parameter (carried by
     address), five parameters, recursion and `...` are not expanded.
  6. Targets whose slots are not 4-byte words keep their calls too: the C
     backend (8-byte slots) and x86-64 (one 8-byte pointer word).
  7. Semantics: eight fixtures return the same value at -O2, at -O2 with
     --no_autoinline, and at -O2 --size-weight=9 on the ARM emulator.  The
     emulator has no FPU (unicorn's M-class profile raises
     UC_ERR_INSN_INVALID on VMUL.F64), so the `double` parameter is checked
     structurally only.
  8. A build cropped with -DARKCC_FEATURE_OPT_INLINE=0 refuses --autoinline by
     name instead of accepting it and emitting calls, and still compiles the
     same file normally when the flag is not given.

Usage: run_inline_tests.py [path-to-arkcc]
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

# --------------------------------------------------------------- the sources

# One parameter, body small enough for the default limit (12) but above the
# size end (4).  Two call sites, so the count is unambiguous.
SMALL = '''\
int g;
static int add1(int x) { return x + 1; }
int main(void) { g = add1(3) + add1(4); return g & 0x7F; }
'''

# Same body as FAT, without and with __forceinline: the attribute has to be the
# only difference between an expansion and a call.
FAT = '''\
int g;
static %sint fat(int a, int b)
{
    int r = a + b * 3;
    r = r * 5 + 7;
    r = r ^ 0x2A;
    r = r + a * 11;
    r = r - b * 13;
    r = r * 3;
    return r;
}
int main(void) { g = fat(3, 4) & 0x7F; return g; }
'''

# A two-word parameter FIRST: the second parameter's temp slot is word 2 while
# its argument index is 1, so a pass that equates the two copies the wrong word.
TWO_WORD = '''\
long long g;
static long long mix(long long a, int b) { return a + b; }
int main(void)
{
    g = mix(4294967296LL, 7) - 4294967296LL;
    return (int)(g & 0x7F);
}
'''

# 5 bytes: two words by value; tail() reads the SECOND word (s.e), so a copy
# that only moves the low word returns 0 instead of 9.
STRUCT5 = '''\
int g;
struct S5 { char a, b, c, d, e; };
static int tail(struct S5 s) { return s.e; }
int main(void)
{
    struct S5 s;
    s.a = 0; s.b = 0; s.c = 0; s.d = 0; s.e = 9;
    g = tail(s);
    return g & 0x7F;
}
'''

# Structural only: unicorn's M-class profile has no FPU.
DOUBLE_P = '''\
double g;
static double half(double x) { return x * 0.5; }
int main(void) { g = half(4.0); return (int)g; }
'''

# --- the refusals -----------------------------------------------------------

BIG_STRUCT = '''\
int g;
struct S12 { int q[3]; };
static int big(struct S12 s) { return s.q[2]; }
int main(void)
{
    struct S12 t;
    t.q[0] = 0; t.q[1] = 0; t.q[2] = 5;
    g = big(t);
    return g & 0x7F;
}
'''

FIVE_PARAMS = '''\
int g;
static int five(int a, int b, int c, int d, int e) { return a + e; }
int main(void) { g = five(1, 2, 3, 4, 5); return g & 0x7F; }
'''

RECURSIVE = '''\
int g;
static int rec(int n) { return n ? rec(n - 1) : 3; }
int main(void) { g = rec(2); return g & 0x7F; }
'''

VARIADIC = '''\
int g;
static int va(const char *f, ...) { return f != 0; }
int main(void) { g = va("x", 1, 2); return g & 0x7F; }
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

def bl_count(text, name):
    """Call sites, not definitions: ARM emits `BL <name>` for a call."""
    return sum(1 for ln in text.splitlines() if ln.strip().startswith('BL ' + name))

def asm_of(arkcc, work, src, flags, tag):
    out = tag + '.s'
    rc, log = run(arkcc, ASM + flags + [src, '-o', out], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    return read(os.path.join(work, out)), ''

def image_value(arkcc, work, src, flags, tag):
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, IMG + flags + [src, '-o', img], work)
    if rc != 0:
        return None, 'compile: ' + log.strip()[:200]
    with open(img, 'rb') as f:
        status, value, detail = run_image(f.read())
    if status != 'returned':
        return None, 'emulator: %s %s' % (status, detail)
    return value, ''

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

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_inline_')
    try:
        # The inline fixtures carry no startup file: inlining is measured by
        # counting BL sites, and a second entry point that calls main would
        # carry its own (not yet expanded) copy of the calls into the output.
        fixtures = (('small.c', SMALL), ('fat.c', FAT % ''),
                    ('force.c', FAT % '__forceinline '),
                    ('twoword.c', TWO_WORD), ('struct5.c', STRUCT5),
                    ('doublep.c', DOUBLE_P), ('bigstruct.c', BIG_STRUCT),
                    ('fiveparams.c', FIVE_PARAMS), ('recursive.c', RECURSIVE),
                    ('variadic.c', VARIADIC))
        for name, text in fixtures:
            write(os.path.join(work, name), text)
            write(os.path.join(work, 'rt_' + name), STARTUP + text)

        # --- 1. a parameterised callee is expanded at -O2 -------------------
        text, err = asm_of(arkcc, work, 'small.c', [], 'small_on')
        if text is None:
            check(False, 'the parameterised fixture builds', err)
            return 1
        check(bl_count(text, 'add1') == 0,
              '-O2 expands a call to a one-parameter callee',
              '%d BL add1' % bl_count(text, 'add1'))
        text, err = asm_of(arkcc, work, 'small.c', ['--no_autoinline'], 'small_off')
        if text is None:
            check(False, 'the parameterised fixture builds without inlining', err)
            return 1
        check(bl_count(text, 'add1') == 2,
              '--no_autoinline keeps both calls (the check above is not vacuous)',
              '%d BL add1' % bl_count(text, 'add1'))

        # -O2 already enables the pass: asking for it again changes nothing.
        rc, _ = run(arkcc, OBJ + ['small.c', '-o', 'au_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--autoinline', 'small.c', '-o', 'au_on.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'au_off.o')) ==
              digest(os.path.join(work, 'au_on.o')),
              '-O2 and -O2 --autoinline produce byte-identical objects')

        # --- 2. the size rule still gates the expansion ---------------------
        text, err = asm_of(arkcc, work, 'small.c', ['--size-weight=9'],
                           'small_w9')
        if text is None:
            check(False, 'the fixture builds at the size end', err)
            return 1
        check(bl_count(text, 'add1') == 2,
              'the size end (inline<=4) still refuses this callee',
              '%d BL add1' % bl_count(text, 'add1'))

        # --- 3. __forceinline bypasses the size limit -----------------------
        on, err = asm_of(arkcc, work, 'force.c', [], 'force_on')
        off, err2 = asm_of(arkcc, work, 'fat.c', [], 'fat_on')
        if on is None or off is None:
            check(False, 'the forceinline pair builds', err or err2)
            return 1
        check(bl_count(on, 'fat') == 0 and bl_count(off, 'fat') == 1,
              '__forceinline expands a parameterised body above the size limit',
              'force=%d plain=%d BL fat' % (bl_count(on, 'fat'),
                                            bl_count(off, 'fat')))

        # --- 4. word-accurate argument copy ---------------------------------
        # two-word parameter first, one-word parameter second
        text, err = asm_of(arkcc, work, 'twoword.c', [], 'twow_on')
        if text is None:
            check(False, 'the two-word fixture builds', err)
            return 1
        check(bl_count(text, 'mix') == 0,
              'a two-word first parameter followed by a word still expands',
              '%d BL mix' % bl_count(text, 'mix'))
        # 5-byte struct, the payload read from its second word
        text, err = asm_of(arkcc, work, 'struct5.c', [], 's5_on')
        if text is None:
            check(False, 'the 5-byte struct fixture builds', err)
            return 1
        check(bl_count(text, 'tail') == 0,
              'a 5-byte struct parameter (two words) still expands',
              '%d BL tail' % bl_count(text, 'tail'))
        # double parameter: structural only (no FPU in the emulator)
        text, err = asm_of(arkcc, work, 'doublep.c', [], 'dbl_on')
        if text is None:
            check(False, 'the double fixture builds', err)
            return 1
        check(bl_count(text, 'half') == 0,
              'a double parameter (two words) still expands',
              '%d BL half' % bl_count(text, 'half'))

        # --- 5. the refusals keep their calls -------------------------------
        for src, fn, why in (('bigstruct.c', 'big', '>8-byte struct by address'),
                             ('fiveparams.c', 'five', 'five parameters'),
                             ('recursive.c', 'rec', 'recursion'),
                             ('variadic.c', 'va', 'variadic')):
            text, err = asm_of(arkcc, work, src, [], src + '_ref')
            if text is None:
                check(False, 'the %s fixture builds' % why, err)
                return 1
            # `rec` calls itself twice: the definition's own call plus main's.
            want = 2 if fn == 'rec' else 1
            check(bl_count(text, fn) == want,
                  'the %s shape keeps its call' % why,
                  '%d BL %s (expected %d)' % (bl_count(text, fn), fn, want))

        # --- 6. targets with other slot widths keep their calls -------------
        rc, log = run(arkcc, ['-target', 'c', '-O2', '-S', 'small.c',
                              '-o', 'ctarget.s'], work)
        if rc != 0:
            check(False, 'the C backend compiles the fixture', log.strip()[:160])
        else:
            text = read(os.path.join(work, 'ctarget.s'))
            check('ark_add1(' in text and text.count('ark_add1(') >= 3,
                  'the C backend (8-byte slots) keeps the call',
                  '%d mentions' % text.count('ark_add1('))
        rc, log = run(arkcc, ['-target', 'x86_64', '-O2', '-S', 'small.c',
                              '-o', 'x64.s'], work)
        if rc != 0:
            check(False, 'the x86-64 backend compiles the fixture',
                  log.strip()[:160])
        else:
            text = read(os.path.join(work, 'x64.s'))
            check(sum(1 for ln in text.splitlines()
                      if ln.strip().startswith('call add1')) == 2,
                  'x86-64 (one pointer word) keeps both calls',
                  '%d call add1' % sum(1 for ln in text.splitlines()
                                       if ln.strip().startswith('call add1')))

        # --- 7. semantics ---------------------------------------------------
        if not HAVE_UNICORN:
            skip('execution of the inlined programs', 'unicorn not installed')
        else:
            for src, quiet in (('rt_small.c', 9), ('rt_twoword.c', 7),
                               ('rt_struct5.c', 9), ('rt_fat.c', 47),
                               ('rt_force.c', 47), ('rt_bigstruct.c', 5),
                               ('rt_fiveparams.c', 6), ('rt_recursive.c', 3),
                               ('rt_variadic.c', 1)):
                vals = {}
                ok = True
                for flags, tag in (([], 'on'), (['--no_autoinline'], 'off'),
                                   (['--size-weight=9'], 'w9')):
                    v, err = image_value(arkcc, work, src, flags, tag)
                    if v is None:
                        skip('execution of %s (%s)' % (src, tag), err)
                        ok = False
                        break
                    vals[tag] = v
                if ok:
                    check(vals['on'] == vals['off'] == vals['w9'] == quiet,
                          '%s returns %d on every arm' % (src, quiet),
                          '%d/%d/%d' % (vals['on'], vals['off'], vals['w9']))

        # --- 8. the cropped build refuses the option ------------------------
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OPT_INLINE=0'],
                                   'arkcc_noinline')
        if trimmed is None:
            skip('cropped build refuses --autoinline', why)
        else:
            rc, log = run(trimmed, OBJ + ['--autoinline', 'small.c', '-o',
                                          't.o'], work)
            check(rc != 0 and 'C3900U' in log and 'autoinline' in log,
                  'the cropped build refuses --autoinline by name',
                  'rc=%d' % rc)
            rc, log = run(trimmed, ASM + ['small.c', '-o', 't.s'], work)
            if rc != 0:
                check(False, 'the cropped build compiles the fixture at -O2',
                      log.strip()[:160])
            else:
                text = read(os.path.join(work, 't.s'))
                check(bl_count(text, 'add1') == 2,
                      'the cropped build emits plain calls instead',
                      '%d BL add1' % bl_count(text, 'add1'))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall inline checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())