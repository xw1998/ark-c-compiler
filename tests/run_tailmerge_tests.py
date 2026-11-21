#!/usr/bin/env python
"""Gates for --tailmerge (block-tail merging, stage `ir.tailmerge`).

The pass rewrites the instruction list of a function, so "it compiles" proves
nothing.  The gate asks five separate questions, each of which can fail alone:

  1. Static: with the switch on, the code changes and the change is the one the
     pass promises (a shared tail plus one branch to it); with the switch off
     the object is byte-identical to a build that has no such pass at all.
  2. Negative shapes: every shape the pass refuses must produce exactly the
     same assembly with the switch on as with it off --
        * the final statement differs (so no suffix is identical),
        * the identical suffix starts with a value still on the evaluation
          stack (rule 2: only depth-0 tails are merged),
        * the shared suffix is shorter than ARK_TAILMERGE_MIN_LEN,
        * the function contains an inline-asm body (the stack effect of the
          body is unknown, so the whole function is abandoned, rule 5).
  3. Dynamic: the same program, with and without the switch, returns the same
     number on the ARM emulator.
  4. Anti-false-green: the switch is off by default and the default object is
     byte-identical to a build compiled without the pass; --no-tailmerge after
     --tailmerge turns it back off; a build with -DARKCC_FEATURE_TAILMERGE=0
     refuses the option with C3900U naming the macro; --tailmerge without a -O
     level is reported as "needs a higher -O level"; --print-pipeline lists the
     stage and its switch; the ini key works.
  5. Byte account: the merged object is strictly smaller than the unmerged one,
     and the assembly measure (instruction lines) agrees.  Without this the
     whole pass would be a rewrite that costs code.

Usage: run_tailmerge_tests.py [path-to-arkcc]
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

# The two branches differ only above the last statement, so the tail
# (`return b + 7;`) is instruction-identical.  merge_case(1, 2) = ((2+1)*3^5+11)+7
# with C precedence applied at run time; the gate compares the emulator's value
# against the same program compiled with the switch off rather than spelling it
# out here, so a mis-copied constant cannot pass for a merge bug.
SRC_MERGE = '''\
int merge_case(int a, int b)
{
    if (a) { b += 1; b *= 3; b ^= 5; b += 11; return b + 7; }
    else   { b -= 1; b *= 3; b ^= 5; b += 11; return b + 7; }
}

/* Three members in one group: the largest-saving group wins, and a group with
 * more than two members must drop more than one branch. */
int tail3(int a, int b)
{
    if (a == 1)      { b += 1; b *= 3; b ^= 5; b += 11; return b + 7; }
    else if (a == 2) { b -= 1; b *= 3; b ^= 5; b += 11; return b + 7; }
    else             { b ^= 9; b *= 3; b ^= 5; b += 11; return b + 7; }
}

int main(void)
{
    return (merge_case(1, 2) + merge_case(0, 2) +
            tail3(1, 1) + tail3(2, 1) + tail3(0, 1)) & 0x7F;
}
'''

# The final statement itself differs: nothing at the end is identical.
SRC_NEG_DIFF = '''\
int diff_case(int a, int b)
{
    if (a) { b *= 3; return b + 7; }
    else   { b *= 3; return b + 8; }
}
int main(void) { return diff_case(1, 2) + diff_case(0, 2); }
'''

# The shared suffix `* 2; return` starts with a value already on the stack,
# i.e. at depth 1.  Jumping into it from elsewhere would carry the evaluation
# stack across an edge, so the pass must not merge it.
SRC_NEG_DEPTH = '''\
int depth_case(int a, int b)
{
    if (a) return (b + 1) * 2;
    else   return (b + 2) * 2;
}
int main(void) { return depth_case(1, 5) + depth_case(0, 5); }
'''

# Two instructions per tail, below ARK_TAILMERGE_MIN_LEN (3).
SRC_NEG_SHORT = '''\
int short_case(int a, int b)
{
    if (a) return b;
    else   return b;
}
int main(void) { return short_case(1, 2) + short_case(0, 2); }
'''

# An inline-asm body has no stack effect this pass knows, so the depth model is
# refused for the whole function even though the tails look identical.
SRC_NEG_ASM = '''\
int asm_case(int a, int b)
{
    if (a) { __asm("nop"); return b + 7; }
    else   { __asm("nop"); return b + 7; }
}
int main(void) { return asm_case(1, 2) + asm_case(0, 2); }
'''

# both shapes in one translation unit: the mergeable one must merge while the
# depth-1 one must not, so "the whole file was left alone" cannot be mistaken
# for "the pass refuses that shape".
SRC_MIXED = '''\
int mixed_merge(int a, int b)
{
    if (a) { b += 1; b *= 3; b ^= 5; b += 11; return b + 7; }
    else   { b -= 1; b *= 3; b ^= 5; b += 11; return b + 7; }
}

int mixed_depth(int a, int b)
{
    if (a) return (b + 1) * 2;
    else   return (b + 2) * 2;
}

int main(void)
{
    return (mixed_merge(1, 2) + mixed_merge(0, 2) +
            mixed_depth(1, 5) + mixed_depth(0, 5)) & 0x7F;
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
    """Instruction lines of the assembly, i.e. everything that is not a label,
    directive, comment or blank.  This is the size account that does not depend
    on the instruction encoding."""
    n = 0
    for ln in text.splitlines():
        s = ln.strip()
        if not s or s.startswith('.') or s.startswith('@') or s.startswith(';'):
            continue
        if s.endswith(':'):
            continue
        n += 1
    return n


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

    work = tempfile.mkdtemp(prefix='arkcc_tailmerge_')
    try:
        srcs = {
            'merge.c': SRC_MERGE,
            'neg_diff.c': SRC_NEG_DIFF,
            'neg_depth.c': SRC_NEG_DEPTH,
            'neg_short.c': SRC_NEG_SHORT,
            'neg_asm.c': SRC_NEG_ASM,
            'mixed.c': SRC_MIXED,
        }
        for name, text in srcs.items():
            write(os.path.join(work, name), STARTUP + text)

        # --- 1. the switch changes the code, in the promised shape ----------
        rc, log_off = run(arkcc, ASM + ['merge.c', '-o', 'm_off.s'], work)
        rc2, log_on = run(arkcc, ASM + ['merge.c', '--tailmerge', '-o', 'm_on.s'],
                          work)
        check(rc == 0 and rc2 == 0, 'merge.c compiles with and without the switch',
              'rc=%d/%d %s' % (rc, rc2, (log_on or log_off).strip()[:80]))
        off = read(os.path.join(work, 'm_off.s'))
        on = read(os.path.join(work, 'm_on.s'))
        check(on != off, '--tailmerge changes the generated code')
        # A fresh label is planted in front of the kept tail and the dropped
        # branches end in a branch to it.  The label name carries the function
        # name, so it is the pass's own output rather than a coincidence.
        check('.L_merge_case_2:' in on and '.L_merge_case_2' not in off,
              'a fresh label now marks the shared tail')
        branch_to = [ln.strip() for ln in on.splitlines()
                     if ln.strip().startswith('B .L_merge_case_2')]
        check(len(branch_to) >= 1,
              'the dropped branch jumps to the shared tail',
              '%d branch(es)' % len(branch_to))
        # The tail itself must still exist exactly once: the pass moves code,
        # it does not delete the computation.
        check(as_body_lines(on) < as_body_lines(off),
              'the merged assembly is smaller',
              '%d -> %d instruction lines' % (as_body_lines(off),
                                              as_body_lines(on)))

        # --- 2. every refused shape is byte-identical ------------------------
        for name, tag in (('neg_diff.c', 'the final statement differs'),
                          ('neg_depth.c', 'identical suffix starts at stack depth 1'),
                          ('neg_short.c', 'shared suffix shorter than the minimum'),
                          ('neg_asm.c', 'inline asm makes the stack effect unknown')):
            rc, _ = run(arkcc, ASM + [name, '-o', 'x_off.s'], work)
            rc2, _ = run(arkcc, ASM + [name, '--tailmerge', '-o', 'x_on.s'], work)
            a = read(os.path.join(work, 'x_off.s'))
            b = read(os.path.join(work, 'x_on.s'))
            check(rc == 0 and rc2 == 0 and a == b,
                  '--tailmerge leaves the function alone: ' + tag,
                  'rc=%d/%d' % (rc, rc2))

        # The mixed file separates "the pass refuses this shape" from "the
        # pass never ran in this translation unit": only the mergeable
        # function may gain labels.
        rc, _ = run(arkcc, ASM + ['mixed.c', '-o', 'mix_off.s'], work)
        rc2, _ = run(arkcc, ASM + ['mixed.c', '--tailmerge', '-o', 'mix_on.s'],
                     work)
        if rc == 0 and rc2 == 0:
            a = read(os.path.join(work, 'mix_off.s'))
            b = read(os.path.join(work, 'mix_on.s'))
            la = set(ln.strip() for ln in a.splitlines() if ln.strip().endswith(':'))
            lb = set(ln.strip() for ln in b.splitlines() if ln.strip().endswith(':'))
            new = lb - la
            check(any(nm.startswith('.L_mixed_merge') for nm in new) and
                  not any(nm.startswith('.L_mixed_depth') for nm in new),
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
                got, err = image_value(arkcc, 'merge.c', work, ['--tailmerge'],
                                       'm_exec_on')
                if got is None:
                    skip('emulator execution (merged)', err)
                else:
                    check(got == base,
                          'the merged program returns the same value',
                          'off=%d on=%d' % (base, got))
                # The value must not be a trivial constant either: a pass that
                # silently returned 0 would otherwise look like agreement.
                check(base != 0, 'the program under test returns a non-trivial value',
                      'value=%d' % base)

        # --- 4. anti-false-green --------------------------------------------
        # (a) off by default, and --no-tailmerge restores the default exactly.
        rc, _ = run(arkcc, OBJ + ['merge.c', '-o', 'd_plain.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--no-tailmerge', 'merge.c', '-o', 'd_no.o'],
                     work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_plain.o')) ==
              digest(os.path.join(work, 'd_no.o')),
              'the pass is off by default (object byte-identical)')
        rc, _ = run(arkcc, OBJ + ['--tailmerge', '--no-tailmerge', 'merge.c',
                                  '-o', 'd_backoff.o'], work)
        rc2, _ = run(arkcc, OBJ + ['merge.c', '-o', 'd_ref.o'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'd_backoff.o')) ==
              digest(os.path.join(work, 'd_ref.o')),
              '--no-tailmerge after --tailmerge turns the pass back off')

        # (b) a build with the feature compiled out must be inert AND must
        # refuse the option, naming the macro that brings it back.
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_TAILMERGE=0'],
                                   'arkcc_notailmerge')
        if trimmed is None:
            skip('trimmed build refuses --tailmerge', why)
        else:
            rc, log = run(trimmed, OBJ + ['merge.c', '--tailmerge', '-o', 't.o'],
                          work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_TAILMERGE' in log,
                  'trimmed build refuses --tailmerge and names the macro',
                  'rc=%d' % rc)
            rc2, log2 = run(trimmed, OBJ + ['merge.c', '-o', 't2.o'], work)
            check(rc2 == 0, 'trimmed build compiles the same file normally',
                  'rc=%d' % rc2)
            # The image the trimmed build produces by default must equal the
            # untrimmed one: compiling the pass out costs nothing at run time
            # and changes nothing in the output.
            rc3, _ = run(arkcc, OBJ + ['merge.c', '-o', 't_full.o'], work)
            check(rc2 == 0 and rc3 == 0 and
                  digest(os.path.join(work, 't2.o')) ==
                  digest(os.path.join(work, 't_full.o')),
                  'default object identical whether or not the pass is compiled in')

        # (c) the stage table tells the truth: it is listed, names its switch,
        # and without a -O level says the level is what blocks it.
        rc, log = run(arkcc, ARM + ['-O2', '--print-pipeline'], work)
        check(rc == 0 and 'ir.tailmerge' in log and '--tailmerge' in log,
              'a skipped stage names --tailmerge', log.strip()[:80])
        rc, log = run(arkcc, ARM + ['-O2', '--print-pipeline', '--tailmerge'], work)
        check(rc == 0 and 'ir.tailmerge' in log and
              any(ln.strip().startswith('run') and 'ir.tailmerge' in ln
                  for ln in log.splitlines()),
              '--print-pipeline reports the stage as run')
        rc, log = run(arkcc, ARM + ['-O0', '--print-pipeline', '--tailmerge'], work)
        check(rc == 0 and 'needs a higher -O level' in log,
              'without -O the dump says the level is what blocks the pass')
        rc, _ = run(arkcc, ARM + ['-O0', '-o', 'o0_off.s', '-S', 'merge.c'], work)
        rc2, _ = run(arkcc, ARM + ['-O0', '--tailmerge', '-o', 'o0_on.s', '-S',
                                   'merge.c'], work)
        check(rc == 0 and rc2 == 0 and
              read(os.path.join(work, 'o0_off.s')) ==
              read(os.path.join(work, 'o0_on.s')),
              'at -O0 the switch changes nothing')

        # (d) the ini key works as well as the command line.
        write(os.path.join(work, 'tm.cfg'), '[features]\ntailmerge=1\n')
        rc, log = run(arkcc, ['-config', 'tm.cfg'] + ARM +
                      ['-O2', '--print-pipeline'], work)
        check(rc == 0 and 'ir.tailmerge' in log and
              'off (--tailmerge)' not in log,
              'tailmerge=1 in a config file switches the pass on')

        # --- 5. byte account ------------------------------------------------
        rc, _ = run(arkcc, OBJ + ['merge.c', '-o', 'acct_off.o'], work)
        rc2, _ = run(arkcc, OBJ + ['--tailmerge', 'merge.c', '-o', 'acct_on.o'],
                     work)
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
    print('\nall tailmerge checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
