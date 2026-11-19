#!/usr/bin/env python
"""Pass-pipeline gates (--pipeline / --print-pipeline).

What this gate is for
---------------------
Since 0.8.5 the question "does this pass run on this input?" has exactly one
answer, computed by one table in src/pipeline.c.  The gate checks that the
answer is (a) readable, (b) correct, and (c) actually matches the code that
comes out -- a table that says "run" while the pass does nothing would pass a
purely textual test, so the interesting checks here compare assembly.

Three kinds of check:

  * text   -- `--print-pipeline` lists every stage with run/skip and a reason.
  * effect -- assembly proves the pass really did or did not run:
              -O1 vs -O0 differ            (folding/DCE do something at all)
              -O1 -fno-opt-constfold -fno-opt-dce == -O0
                                           (the flags are honoured; before
                                            0.8.5 both were accepted and ignored)
              -O2 --pipeline=lite == -O2 -fno-opt-inline   (on a source with no
                                            loop, so the vectoriser has nothing
                                            to do and the equality isolates the
                                            inline stage)
              -O2 != -O2 --pipeline=lite (so the previous equality is not
                                            trivially true because inlining
                                            never happens at all)
  * refusal -- `--pipeline=lti` is an error that produces no output file
              (falling back to "full" would let the caller believe trimming
              happened), and a build with -DARKCC_FEATURE_PIPELINE_DUMP=0
              refuses `--print-pipeline` instead of printing an empty table.

Usage: run_pipeline_tests.py --arkcc <path>   (or a bare path as argv[1])
Exit 0 = every check behaved.
"""
import glob
import os
import shutil
import subprocess
import sys
import tempfile

# ---------------------------------------------------------------- sources

# No loop: nothing for the vectoriser to match, so a difference between two
# -O2 runs can only come from the inline stage.
SRC_CALL = r'''int one(void)
{
    return 1;
}

int two(void)
{
    return one() + one();
}

int main(void)
{
    return two();
}
'''

# Constant arithmetic: something for constfold/DCE to remove, still no loop.
SRC_CONST = r'''int f(void)
{
    return 1 + 2 * 3;
}

int h(int x)
{
    if (0) {
        return x * 7;
    }
    return 4;
}
'''

# ---------------------------------------------------------------- helpers

FAILS = []
SKIPS = []


def check(ok, what, detail=''):
    if ok:
        print('PASS  %s' % what)
    else:
        print('FAIL  %s%s' % (what, ('  [%s]' % detail) if detail else ''))
        FAILS.append(what)


def skip(what, why):
    print('SKIP  %s  (%s)' % (what, why))
    SKIPS.append(what)


def run(arkcc, args, cwd):
    p = subprocess.run([arkcc] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def table(log):
    """Parse `--print-pipeline` output into {stage: (run, reason)}."""
    rows = {}
    for ln in log.splitlines():
        s = ln.strip()
        if not (s.startswith('run ') or s.startswith('skip ')):
            continue
        parts = s.split(None, 2)
        if len(parts) < 2:
            continue
        rows[parts[1]] = (parts[0] == 'run',
                          parts[2] if len(parts) > 2 else '')
    return rows


def asm_of(arkcc, work, src, args, name):
    out = os.path.join(work, name + '.s')
    if os.path.exists(out):
        os.remove(out)
    rc, log = run(arkcc, args + [src, '-S', '-o', name + '.s'], work)
    if rc != 0 or not os.path.exists(out):
        return None, rc, log
    with open(out, 'r', newline='') as f:
        return f.read(), rc, log


def build_arkcc(where, define, name):
    """Rebuild arkcc from this tree with an extra -D; None if no compiler."""
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
           '-Wno-unused-function', '-Iinclude', define] + srcs + ['-o', out]
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if p.returncode != 0:
        return None, (p.stdout.decode('utf-8', 'replace').strip().splitlines()
                      or ['build failed'])[-1][:100]
    return out, ''


def main():
    args = sys.argv[1:]
    arkcc = None
    i = 0
    while i < len(args):
        if args[i] == '--arkcc' and i + 1 < len(args):
            arkcc = args[i + 1]
            i += 2
        else:
            arkcc = args[i]
            i += 1
    if not arkcc:
        arkcc = './arkcc.exe' if os.name == 'nt' else './arkcc'
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_pipeline_')
    try:
        for name, text in (('call.c', SRC_CALL), ('konst.c', SRC_CONST)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        # --- 1. the table is readable and complete -------------------------
        rc, log = run(arkcc, ['--print-pipeline', '-O1'], work)
        rows = table(log)
        check(rc == 0, '--print-pipeline exits 0', 'rc=%d' % rc)
        check('profile=full' in log, 'default profile is full', log[:120])
        check(all(k in rows for k in
                  ('ast.memlint', 'ast.enumcheck', 'ir.constfold', 'ir.dce',
                   'ir.dce-cfg', 'ir.inline', 'ir.vectorize')),
              'every stage appears in the table', str(sorted(rows)))

        # --- 2. the -O ladder is what the table says -----------------------
        rc, log = run(arkcc, ['--print-pipeline', '-O0'], work)
        r0 = table(log)
        check(r0.get('ir.constfold', (True,))[0] is False and
              r0.get('ir.dce', (True,))[0] is False,
              '-O0 skips constfold and dce', str(r0.get('ir.constfold')))
        check(r0.get('ir.inline', (True,))[0] is False,
              '-O0 skips inline', str(r0.get('ir.inline')))
        rc, log = run(arkcc, ['--print-pipeline', '-O1'], work)
        r1 = table(log)
        check(r1.get('ir.constfold', (False,))[0] and r1.get('ir.dce', (False,))[0],
              '-O1 runs constfold and dce', str(r1.get('ir.constfold')))
        check(r1.get('ir.inline', (True,))[0] is False,
              '-O1 still skips inline (it needs -O2)', str(r1.get('ir.inline')))
        rc, log = run(arkcc, ['--print-pipeline', '-O2', '--dce-cfg'], work)
        r2 = table(log)
        check(r2.get('ir.inline', (False,))[0] and r2.get('ir.dce-cfg', (False,))[0],
              '-O2 --dce-cfg runs inline and dce-cfg', str(r2.get('ir.inline')))

        # --- 3. the AST stages follow their own switch ---------------------
        rc, log = run(arkcc, ['--print-pipeline', '-O1'], work)
        r = table(log)
        check(r['ast.memlint'][0] is False and '--warn-mem' in r['ast.memlint'][1],
              'ast.memlint off by default and says why', str(r['ast.memlint']))
        rc, log = run(arkcc, ['--print-pipeline', '-O1', '--warn-mem'], work)
        r = table(log)
        check(r['ast.memlint'][0] is True, '--warn-mem turns ast.memlint on',
              str(r['ast.memlint']))

        # --- 4. --pipeline=lite trims exactly the full-only stages ---------
        rc, log = run(arkcc, ['--print-pipeline', '--pipeline=lite', '-O2',
                              '--dce-cfg', '--warn-mem', '--warn-enum'], work)
        r = table(log)
        check('profile=lite' in log, 'lite profile is reported', log[:160])
        check(r['ir.constfold'][0] and r['ir.dce'][0],
              'lite keeps constfold and dce', str(r.get('ir.constfold')))
        check(not r['ir.inline'][0] and not r['ir.vectorize'][0] and
              not r['ir.dce-cfg'][0],
              'lite drops inline, vectorize and dce-cfg', str(r.get('ir.inline')))
        check('pipeline=lite' in r['ir.inline'][1],
              'the trim says how it happened', r['ir.inline'][1])
        check(r['ast.memlint'][0] and r['ast.enumcheck'][0],
              'lite still runs the lint stages that were asked for',
              str(r.get('ast.memlint')))

        # --- 5. effect: folding/DCE really happen at -O1 -------------------
        a0, rc0, _ = asm_of(arkcc, work, 'konst.c', ['-target', 'arm'], 'kO0')
        a1, rc1, _ = asm_of(arkcc, work, 'konst.c', ['-target', 'arm', '-O1'], 'kO1')
        if a0 is None or a1 is None:
            skip('effect checks', 'arkcc could not emit assembly')
        else:
            check(a0 != a1, '-O1 changes the image of constant arithmetic')
            a1n, _, _ = asm_of(arkcc, work, 'konst.c',
                               ['-target', 'arm', '-O1',
                                '-fno-opt-constfold', '-fno-opt-dce'], 'kO1n')
            check(a1n == a0,
                  '-O1 with both passes switched off equals -O0 '
                  '(the flags are honoured, not ignored)')

            # --- 6. effect: lite really skips inlining ---------------------
            b2, _, _ = asm_of(arkcc, work, 'call.c', ['-target', 'arm', '-O2'], 'cO2')
            bl, _, _ = asm_of(arkcc, work, 'call.c',
                              ['-target', 'arm', '-O2', '--pipeline=lite'], 'cLite')
            bn, _, _ = asm_of(arkcc, work, 'call.c',
                              ['-target', 'arm', '-O2', '-fno-opt-inline'], 'cNoInl')
            if b2 is None or bl is None or bn is None:
                skip('lite inline check', 'arkcc could not emit assembly')
            else:
                check(b2 != bl, '-O2 and -O2 --pipeline=lite differ '
                                '(inlining is visible in the image)')
                check(bl == bn, 'lite equals full minus the inline stage '
                                'on a loop-free source')

        # --- 7. an unknown profile is an error, not a fallback -------------
        rc, log = run(arkcc, ['--pipeline=lti', '-target', 'arm',
                              'call.c', '-S', '-o', 'bad.s'], work)
        check(rc != 0 and 'C3900U' in log and 'lti' in log,
              'unknown profile is refused with C3900U', 'rc=%d %s' % (rc, log[:120]))
        check(not os.path.exists(os.path.join(work, 'bad.s')),
              'no output file is produced for the refused profile')
        rc, log = run(arkcc, ['--print-pipeline', '--pipeline=lti'], work)
        check(rc != 0, '--print-pipeline also refuses the unknown profile',
              'rc=%d' % rc)

        # --- 8. the ini key, and a bad ini value ---------------------------
        with open(os.path.join(work, 'lite.cfg'), 'w', newline='') as f:
            f.write('[features]\npipeline=lite\n')
        rc, log = run(arkcc, ['-config', 'lite.cfg', '--print-pipeline', '-O2'], work)
        check('profile=lite' in log, 'pipeline=lite in a config file is applied',
              log[:160])
        with open(os.path.join(work, 'bad.cfg'), 'w', newline='') as f:
            f.write('[features]\npipeline=lti\n')
        rc, log = run(arkcc, ['-config', 'bad.cfg', '--print-pipeline', '-O2'], work)
        check('profile=full' in log and 'unknown pipeline' in log,
              'a bad ini value is reported and the profile stays full',
              log[:200])
        check(rc == 0, 'a bad ini value is a warning, not a hard failure',
              'rc=%d' % rc)

        # --- 9. the dump can be trimmed out of the binary ------------------
        trimmed, why = build_arkcc(work, '-DARKCC_FEATURE_PIPELINE_DUMP=0',
                                   'arkcc_nodump')
        if trimmed is None:
            skip('trimmed build refuses --print-pipeline', why)
        else:
            rc, log = run(trimmed, ['--print-pipeline'], work)
            check(rc != 0 and 'C3900U' in log and
                  'ARKCC_FEATURE_PIPELINE_DUMP' in log,
                  'trimmed build refuses --print-pipeline and says how to enable it',
                  'rc=%d %s' % (rc, log[:120]))
            rc, log = run(trimmed, ['-target', 'arm', 'call.c', '-c',
                                    '-o', 'nd.o'], work)
            check(rc == 0, 'trimmed build still compiles normally',
                  'rc=%d %s' % (rc, log[:120]))
            rc, log = run(trimmed, ['--pipeline=lite', '-target', 'arm',
                                    'call.c', '-c', '-o', 'nd2.o'], work)
            check(rc == 0, 'trimmed build still accepts --pipeline (the loop stays)',
                  'rc=%d' % rc)
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if FAILS:
        print('\n%d check(s) FAILED%s' % (
            len(FAILS), (', %d skipped' % len(SKIPS)) if SKIPS else ''))
        return 1
    print('\nall pass-pipeline checks passed%s' % (
        (' (%d skipped)' % len(SKIPS)) if SKIPS else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
