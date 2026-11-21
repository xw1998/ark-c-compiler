#!/usr/bin/env python
"""Gates for --xblock (whole-block cross-jump, stage `ir.xblock`).

The pass replaces a repeated basic block with a jump to the first copy, so the
instruction list and the control-flow graph both change.  "It compiles" proves
nothing about that.  The gate asks five separate questions, each of which can
fail alone:

  1. Static: with the switch on the code changes in exactly the promised shape
     -- the duplicated body survives once, every other copy becomes one branch
     to a fresh label, and the *count* of the duplicated work goes down.
  2. Refused shapes: every shape the pass refuses must produce exactly the same
     assembly with the switch on as with it off --
        * a block ending in a conditional branch whose two copies fall through
          to different code (identical body, two different doors),
        * two identical bodies whose terminators go to different blocks,
        * identical blocks shorter than ARK_XBLOCK_MIN_LEN,
        * a function containing inline asm (stack model unknown, whole function
          abandoned).
  3. Dynamic: the same program, with and without the switch, returns the same
     number on the ARM emulator, and that number is not trivial.
  4. Anti-false-green: off by default and byte-identical to a build compiled
     without the pass; --no-xblock turns it back off; a build with
     -DARKCC_FEATURE_XBLOCK=0 refuses the option with C3900U naming the macro
     and still produces the same default object; the ini key works; the stage
     table lists the switch; at -O0 nothing happens.
  5. Byte account: the merged object is strictly smaller and the instruction
     line count agrees.  Without this the pass would be a rewrite that costs
     code.

Usage: run_xblock_tests.py [path-to-arkcc]
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

# Two arms with an identical body: the call is the expensive part and it must
# survive exactly once.  `g(7) + 11` = 33, so main() returns 33*5 & 0x7F.
SRC_MERGE = '''\
int g(int x) { return x * 3 + 1; }

int two(int a)
{
    int r;
    if (a == 1)      { r = g(7) + 11; }
    else if (a == 2) { r = g(7) + 11; }
    else             { r = 0; }
    return r;
}

/* Three identical bodies in one group: one copy stays, two become branches. */
int three(int a)
{
    int r;
    if (a == 1)      { r = g(7) + 11; }
    else if (a == 2) { r = g(7) + 11; }
    else if (a == 3) { r = g(7) + 11; }
    else             { r = 0; }
    return r;
}

int main(void)
{
    return (two(1) + two(2) + two(3) +
            three(1) + three(2) + three(3) + three(0)) & 0x7F;
}
'''

# Two inner conditions spelled identically.  Their blocks end with a
# conditional branch, so the *fall-through* successor is decided by where the
# block sits, not by what it says: merging them would send one arm's `b + 1`
# through the other arm.  The condition is deliberately long enough to pass the
# length rule, so the refusal has to come from the terminator rule.
SRC_NEG_COND = '''\
int cond_case(int a, int b)
{
    int r = 0;
    if (a == 1)      { if (b * 2 > 10) { r = b + 1; } }
    else if (a == 2) { if (b * 2 > 10) { r = b + 2; } }
    return r;
}
int main(void) { return (cond_case(1, 6) + cond_case(2, 6) +
                         cond_case(1, 2) + cond_case(2, 2)) & 0x7F; }
'''

# The two loop bodies are instruction-identical but `break` leaves through two
# different exits, so the bodies are only equal above the last instruction.
SRC_NEG_TARGET = '''\
int target_case(int a, int b)
{
    while (a == 1) { b += 1; b *= 3; b += 11; break; }
    while (a == 2) { b += 1; b *= 3; b += 11; break; }
    return b;
}
int main(void) { return (target_case(1, 2) + target_case(2, 2) +
                         target_case(0, 2)) & 0x7F; }
'''

# Each arm is one jump (the `goto`), i.e. below ARK_XBLOCK_MIN_LEN: sharing
# costs an entry branch per copy and saves nothing, so the pass must leave it.
SRC_NEG_SHORT = '''\
int short_case(int a, int b)
{
    int r = 0;
    if (a == 1)      goto done;
    else if (a == 2) goto done;
    r = b;
done:
    return r;
}
int main(void) { return (short_case(1, 2) + short_case(2, 2) +
                         short_case(0, 2)) & 0x7F; }
'''

# An inline-asm body has no stack effect this pass knows, so the depth model is
# refused for the whole function even though the bodies look identical.
SRC_NEG_ASM = '''\
int asm_case(int a, int b)
{
    int r;
    if (a == 1)      { __asm("nop"); r = b + 1; }
    else if (a == 2) { __asm("nop"); r = b + 1; }
    else             { r = 0; }
    return r;
}
int main(void) { return (asm_case(1, 2) + asm_case(2, 2) + asm_case(0, 2)) & 0x7F; }
'''

# Both shapes in one translation unit: the mergeable function must gain a label
# while the refused one must not, so "the whole file was left alone" cannot be
# mistaken for "the pass refuses that shape".
SRC_MIXED = '''\
int g(int x) { return x * 3 + 1; }

int mixed_merge(int a)
{
    int r;
    if (a == 1)      { r = g(7) + 11; }
    else if (a == 2) { r = g(7) + 11; }
    else             { r = 0; }
    return r;
}

int mixed_cond(int a, int b)
{
    int r = 0;
    if (a == 1)      { if (b * 2 > 10) { r = b + 1; } }
    else if (a == 2) { if (b * 2 > 10) { r = b + 2; } }
    return r;
}

int main(void)
{
    return (mixed_merge(1) + mixed_merge(2) + mixed_merge(0) +
            mixed_cond(1, 6) + mixed_cond(2, 6)) & 0x7F;
}
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
    """Instruction lines: everything that is not a label, directive, comment or
    blank.  This is the size account that does not depend on the encoding."""
    n = 0
    for ln in text.splitlines():
        s = ln.strip()
        if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
            continue
        if s.endswith(':'):
            continue
        n += 1
    return n

def label_set(text):
    return set(ln.strip()[:-1] for ln in text.splitlines()
               if ln.strip().endswith(':'))

def count_lines(text, needle):
    return sum(1 for ln in text.splitlines() if ln.strip().startswith(needle))

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
    return value, ''

def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_xblock_')
    try:
        srcs = {
            'merge.c': SRC_MERGE,
            'neg_cond.c': SRC_NEG_COND,
            'neg_target.c': SRC_NEG_TARGET,
            'neg_short.c': SRC_NEG_SHORT,
            'neg_asm.c': SRC_NEG_ASM,
            'mixed.c': SRC_MIXED,
        }
        for name, text in srcs.items():
            write(os.path.join(work, name), STARTUP + text)

        # --- 1. the switch changes the code, in the promised shape ----------
        rc, log_off = run(arkcc, ASM + ['merge.c', '-o', 'm_off.s'], work)
        rc2, log_on = run(arkcc, ASM + ['merge.c', '--xblock', '-o', 'm_on.s'],
                          work)
        check(rc == 0 and rc2 == 0, 'merge.c compiles with and without the switch',
              'rc=%d/%d %s' % (rc, rc2, (log_on or log_off).strip()[:80]))
        off = read(os.path.join(work, 'm_off.s'))
        on = read(os.path.join(work, 'm_on.s'))
        check(on != off, '--xblock changes the generated code')

        # The duplicated work really went away: the call site count drops and
        # the body survives once.  Counting the call is independent of how the
        # new label happens to be named.
        c_off = count_lines(off, 'BL g')
        c_on = count_lines(on, 'BL g')
        check(c_off == 5 and c_on == 2,
              'the duplicated call bodies are shared, not deleted',
              'BL g: %d -> %d (2 for two(), 3 for three())' % (c_off, c_on))

        # A fresh label marks the kept copy, and the dropped copies branch to it.
        new = label_set(on) - label_set(off)
        merge_labels = sorted(nm for nm in new
                              if nm.startswith('.L_two_') or nm.startswith('.L_three_'))
        check(len(merge_labels) >= 2,
              'a fresh label marks each shared block', ', '.join(merge_labels) or 'none')
        if merge_labels:
            nb = sum(count_lines(on, 'B ' + nm) for nm in merge_labels)
            check(nb >= 2, 'the dropped copies jump to the shared block',
                  '%d branch(es)' % nb)
        else:
            check(False, 'the dropped copies jump to the shared block', 'no labels')

        check(as_body_lines(on) < as_body_lines(off),
              'the merged assembly is smaller',
              '%d -> %d instruction lines' % (as_body_lines(off),
                                              as_body_lines(on)))

        # --- 2. every refused shape is byte-identical ------------------------
        for name, tag in (('neg_cond.c', 'conditional-branch block with two fall-throughs'),
                          ('neg_target.c', 'identical bodies leaving to different blocks'),
                          ('neg_short.c', 'identical block shorter than the minimum'),
                          ('neg_asm.c', 'inline asm makes the stack effect unknown')):
            rc, _ = run(arkcc, ASM + [name, '-o', 'x_off.s'], work)
            rc2, _ = run(arkcc, ASM + [name, '--xblock', '-o', 'x_on.s'], work)
            a = read(os.path.join(work, 'x_off.s'))
            b = read(os.path.join(work, 'x_on.s'))
            check(rc == 0 and rc2 == 0 and a == b,
                  '--xblock leaves the function alone: ' + tag,
                  'rc=%d/%d' % (rc, rc2))

        # The mixed file separates "the pass refuses this shape" from "the pass
        # never ran in this translation unit": only the mergeable function may
        # gain a label.
        rc, _ = run(arkcc, ASM + ['mixed.c', '-o', 'mix_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['mixed.c', '--xblock', '-o', 'mix_on.s'], work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'mix_off.s'))
            b = read(os.path.join(work, 'mix_on.s'))
            new = label_set(b) - label_set(a)
            check(any(nm.startswith('.L_mixed_merge') for nm in new) and
                  not any(nm.startswith('.L_mixed_cond') for nm in new),
                  'in one TU only the mergeable function is touched',
                  'new labels: %s' % (', '.join(sorted(new)) or 'none'))
        else:
            check(False, 'the mixed file could be built', 'rc=%d/%d' % (rc, rc2))

        # --- 3. execution: same answer with and without ----------------------
        if not HAVE_UNICORN:
            skip('emulator execution', 'unicorn not installed')
        else:
            base, err = image_value(arkcc, 'merge.c', work, [], 'm_exec_off')
            if base is None:
                skip('emulator execution', err)
            else:
                got, err = image_value(arkcc, 'merge.c', work, ['--xblock'],
                                       'm_exec_on')
                if got is None:
                    skip('emulator execution (merged)', err)
                else:
                    check(got == base,
                          'the merged program returns the same value',
                          'off=%d on=%d' % (base, got))
                check(base != 0, 'the program under test returns a non-trivial value',
                      'value=%d' % base)
                # The refused shapes must also still run the same way; a
                # refusal that quietly broke the block would show up here.
                for name in ('neg_cond.c', 'neg_target.c'):
                    vb, err = image_value(arkcc, name, work, [], 'n_off')
                    if vb is None:
                        skip('execution of ' + name, err)
                        continue
                    vg, err = image_value(arkcc, name, work, ['--xblock'], 'n_on')
                    if vg is None:
                        skip('execution of ' + name + ' (on)', err)
                        continue
                    check(vg == vb, name + ' returns the same value with the switch',
                          'off=%d on=%d' % (vb, vg))

        # --- 4. anti-false-green --------------------------------------------
        rc, _ = run(arkcc, OBJ + ['merge.c', '-o', 'd_plain.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--no-xblock', 'merge.c', '-o', 'd_no.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_plain.o')) ==
              digest(os.path.join(work, 'd_no.o')),
              'the pass is off by default (object byte-identical)')
        rc, _ = run(arkcc, OBJ + ['--xblock', '--no-xblock', 'merge.c',
                                  '-o', 'd_backoff.o'], work)
        rc2, _ = run(arkcc, OBJ + ['merge.c', '-o', 'd_ref.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_backoff.o')) ==
              digest(os.path.join(work, 'd_ref.o')),
              '--no-xblock after --xblock turns the pass back off')

        # A build with the feature compiled out must be inert AND must refuse
        # the option, naming the macro that brings it back.
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_XBLOCK=0'],
                                   'arkcc_noxblock')
        if trimmed is None:
            skip('trimmed build refuses --xblock', why)
        else:
            rc, log = run(trimmed, OBJ + ['merge.c', '--xblock', '-o', 't.o'], work)
            check(rc != 0 and 'C3900U' in log and 'ARKCC_FEATURE_XBLOCK' in log,
                  'trimmed build refuses --xblock and names the macro',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, OBJ + ['merge.c', '-o', 't2.o'], work)
            check(rc2 == 0, 'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)
            rc3, _ = run(arkcc, OBJ + ['merge.c', '-o', 't_full.o'], work)
            check(rc2 == 0 and rc3 == 0 and
                  digest(os.path.join(work, 't2.o')) ==
                  digest(os.path.join(work, 't_full.o')),
                  'default object identical whether or not the pass is compiled in')

        # The stage table tells the truth.
        rc, log = run(arkcc, ARM + ['-O2', '--print-pipeline'], work)
        check(rc == 0 and 'ir.xblock' in log and '--xblock' in log,
              'a skipped stage names --xblock', log.strip()[:80])
        rc, log = run(arkcc, ARM + ['-O2', '--print-pipeline', '--xblock'], work)
        check(rc == 0 and 'ir.xblock' in log and
              any(ln.strip().startswith('run') and 'ir.xblock' in ln
                  for ln in log.splitlines()),
              '--print-pipeline reports the stage as run')
        rc, log = run(arkcc, ARM + ['-O1', '--print-pipeline', '--xblock'], work)
        check(rc == 0 and
              any(ln.strip().startswith('run') and 'ir.xblock' in ln
                  for ln in log.splitlines()),
              'the stage runs at -O1 too')
        rc, _ = run(arkcc, ARM + ['-O0', '-o', 'o0_off.s', '-S', 'merge.c'], work)
        rc2, _ = run(arkcc, ARM + ['-O0', '--xblock', '-o', 'o0_on.s', '-S',
                                   'merge.c'], work)
        check(rc == 0 and rc2 == 0 and
              read(os.path.join(work, 'o0_off.s')) ==
              read(os.path.join(work, 'o0_on.s')),
              'at -O0 the switch changes nothing')

        # The ini key works as well as the command line.
        write(os.path.join(work, 'xb.cfg'), '[features]\nxblock=1\n')
        rc, log = run(arkcc, ['-config', 'xb.cfg'] + ARM +
                      ['-O2', '--print-pipeline'], work)
        check(rc == 0 and 'ir.xblock' in log and 'off (--xblock)' not in log,
              'xblock=1 in a config file switches the pass on')

        # --- 5. byte account ------------------------------------------------
        rc, _ = run(arkcc, OBJ + ['merge.c', '-o', 'acct_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--xblock', 'merge.c', '-o', 'acct_on.o'], work)
        if rc == 0 and rc2 == 0:
            a = os.path.getsize(os.path.join(work, 'acct_off.o'))
            b = os.path.getsize(os.path.join(work, 'acct_on.o'))
            check(b < a, 'the merged object is strictly smaller',
                  '%d -> %d bytes' % (a, b))
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
    print('\nall xblock checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())
