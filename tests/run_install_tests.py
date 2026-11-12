#!/usr/bin/env python3
"""Gate for `make install` (tools/install.py).

Installing is only correct if the *installed tree* is the one that works, so
this gate does not stop at "the files are there":

  1. stage into a throwaway DESTDIR and compare every installed file with its
     source, byte for byte (a copy that was truncated or written as text on
     Windows would show up here and nowhere else);
  2. run the installer twice and require the second run to touch nothing --
     `make install` must not keep re-stamping files it did not change;
  3. require `--dry-run` to write nothing at all;
  4. require DESTDIR + an absolute PREFIX to be rejected instead of silently
     installing into PREFIX (Windows os.path.join() drops an absolute second
     element, which is exactly what MSYS produces for "/usr/local");
  5. build a program against the *installed* headers and library sources --
     no path into the source tree -- link it, and run it on the ARM emulator,
     asserting a number the program computed (malloc + div + qsort).

Usage:
    python tests/run_install_tests.py [--arkcc PATH]
Exit status 0 = every check passed.  A missing emulator is a SKIP of check 5
only, reported as such -- never a silent pass.
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
PYTHON = sys.executable

try:
    sys.path.insert(0, os.path.join(HERE, 'arm_exec'))
    from run_arm_exec import run_image
    HAVE_UNICORN = True
except ImportError:                                     # pragma: no cover
    HAVE_UNICORN = False

CPU_OPTS = ['-mcpu', 'cortex-m7', '-ffpu']
LIB_TUS = ['stdlib.c', 'heap.c', 'errno.c', 'exit.c', 'signal.c', 'math.c']
AEABI_TUS = [('aeabi', 'arm/aeabi.c'), ('aeabi_div', 'arm/aeabi_divmod.s')]

STARTUP_C = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    int rc;
    __arkcc_init_globals();
    rc = main();
    return rc;
}
'''

EXIT_STUB_S = '''\
    .syntax unified
    .thumb
    .global _ark_exit
    .thumb_func
_ark_exit:
    movw r1, #0
    movt r1, #0x1000
    orr r1, r1, #1
    bx r1
'''

# Uses malloc, div() and qsort() so that the image needs heap.c, stdlib.c and
# the cross-TU 5..8 byte struct return value all at once.
MAIN_C = '''\
#include <stdlib.h>
int cmp(const void *a, const void *b);
int main(void)
{
    int i;
    unsigned acc = 0;
    div_t d;
    int *v = (int *)malloc(12 * sizeof(int));
    if (v == 0)
        return 1;
    v[0] = 42; v[1] = -7; v[2] = 13; v[3] = 0;  v[4] = -30; v[5] = 99;
    v[6] = 2;  v[7] = 8;  v[8] = 61; v[9] = 17; v[10] = -7; v[11] = 5;
    qsort(v, 12, sizeof(int), cmp);
    /* sorted: -30 -7 -7 0 2 5 8 13 17 42 61 99 */
    for (i = 0; i < 12; i++)
        acc = acc * 31u + (unsigned)v[i];   /* unsigned: wrapping is defined */
    d = div(17, 5);
    free(v);
    return (int)(acc % 200u) + d.quot * 10 + d.rem;
}
'''

CMP_C = '''\
int cmp(const void *a, const void *b)
{
    int x = *(const int *)a;
    int y = *(const int *)b;
    if (x < y)
        return -1;
    if (x > y)
        return 1;
    return 0;
}
'''


# The install manifest is asserted exactly: adding a file to stdlib/include,
# stdlib/src or stdlib/src/arm must bump this number, so an accidental change
# to what gets installed cannot pass unnoticed.
EXPECTED_INSTALL_FILES = 39

class Gate:
    def __init__(self, arkcc, tmp):
        self.arkcc = os.path.abspath(arkcc)
        self.tmp = tmp
        self.fail = 0

    def bad(self, msg):
        print('FAIL %s' % msg)
        self.fail += 1

    def run(self, cmd, **kw):
        return subprocess.run(cmd, capture_output=True, text=True,
                              errors='replace', **kw)

    def install(self, *args):
        return self.run([PYTHON, os.path.join(ROOT, 'tools', 'install.py'),
                         '--arkcc', self.arkcc] + list(args))

    # -- 1..4: the installer itself ------------------------------------------
    def check_copy_exact(self, dest):
        pairs = []
        inc = os.path.join(dest, 'usr', 'local', 'include', 'ark')
        lib = os.path.join(dest, 'usr', 'local', 'lib', 'ark')
        n = 0
        for src_dir, dst_dir, exts in (
                (os.path.join(ROOT, 'stdlib', 'include'), inc, ('.h',)),
                (os.path.join(ROOT, 'stdlib', 'src'), os.path.join(lib, 'src'),
                 ('.c', '.s')),
                (os.path.join(ROOT, 'stdlib', 'src', 'arm'),
                 os.path.join(lib, 'src', 'arm'), ('.c', '.s'))):
            for f in sorted(os.listdir(src_dir)):
                if not f.endswith(exts):
                    continue
                pairs.append((os.path.join(src_dir, f),
                              os.path.join(dst_dir, f)))
                n += 1
        pairs.append((self.arkcc,
                      os.path.join(dest, 'usr', 'local', 'bin',
                                   os.path.basename(self.arkcc))))
        n += 1
        pairs.append((None, os.path.join(lib, 'README.md')))
        n += 1
        if n != EXPECTED_INSTALL_FILES:
            self.bad('expected %d installable files, counted %d'
                     % (EXPECTED_INSTALL_FILES, n))
        for src, dst in pairs:
            if not os.path.isfile(dst):
                self.bad('missing installed file %s' % dst)
                continue
            if src is None:
                continue
            a = open(src, 'rb').read()
            b = open(dst, 'rb').read()
            if a != b:
                self.bad('%s differs from its source (%d vs %d bytes)'
                         % (dst, len(b), len(a)))
        print('ok   install: %d files present and byte-identical to source'
              % n)

    def check_idempotent(self, dest):
        def snap():
            out = {}
            for root, _dirs, files in os.walk(dest):
                for f in files:
                    p = os.path.join(root, f)
                    out[p] = os.stat(p).st_mtime_ns
            return out
        before = snap()
        r = self.install('--prefix', 'usr/local', '--destdir', dest)
        after = snap()
        if r.returncode != 0:
            self.bad('second install failed: %s' % (r.stdout + r.stderr)[:300])
            return
        changed = sorted(p for p in before if before[p] != after.get(p))
        if changed or set(after) != set(before):
            self.bad('second install rewrote %d file(s): %s'
                     % (len(changed), changed[:3]))
            return
        print('ok   install: re-running it touches nothing (%d files)'
              % len(before))

    def check_dry_run(self, dest):
        r = self.install('--prefix', 'usr/local', '--destdir', dest,
                         '--dry-run')
        if r.returncode != 0:
            self.bad('--dry-run failed: %s' % (r.stdout + r.stderr)[:300])
            return
        if os.path.exists(dest):
            self.bad('--dry-run created %s' % dest)
            return
        print('ok   install: --dry-run writes nothing')

    def check_destdir_guard(self, dest):
        # An absolute PREFIX would make os.path.join() drop DESTDIR on Windows,
        # so the file lands in PREFIX itself.  That must be refused, not obeyed:
        # this gate must never be able to install outside its own temp dir.
        probe = os.path.join(self.tmp, 'escape')
        r = self.install('--prefix', probe, '--destdir', dest, '--dry-run')
        if r.returncode == 0:
            self.bad('absolute PREFIX with DESTDIR was accepted (would install '
                     'into %s, ignoring DESTDIR)' % probe)
            return
        txt = (r.stdout + r.stderr)
        if 'absolute' not in txt:
            self.bad('guard fired but said something else: %s' % txt[:200])
            return
        print('ok   install: absolute PREFIX + DESTDIR is refused '
              '(DESTDIR cannot be silently dropped)')

    # -- 5: the installed tree actually compiles and runs --------------------
    def build_installed(self, dest):
        base = os.path.join(dest, 'usr', 'local')
        inc = os.path.join(base, 'include', 'ark')
        libsrc = os.path.join(base, 'lib', 'ark', 'src')
        work = os.path.join(self.tmp, 'work')
        os.makedirs(work)

        def w(name, text):
            p = os.path.join(work, name)
            with open(p, 'w', newline='\n') as f:
                f.write(text)
            return p

        def obj(name, src, vector=False):
            o = os.path.join(work, name + '.obj')
            cmd = [self.arkcc, src, '-target', 'arm', '-c',
                   '--reloc-data', '--reloc-text'] + CPU_OPTS + [
                   '-I', inc, '-o', o]
            if vector:
                cmd.insert(5, '--vector-table')
            r = self.run(cmd)
            if r.returncode != 0:
                return None, (r.stdout + r.stderr).strip()[:300]
            return o, ''

        objs = []
        for name, text, vec in (('startup', STARTUP_C, True),
                                ('cmp', CMP_C, False),
                                ('main', MAIN_C, False)):
            o, err = obj(name, w(name + '.c', text), vec)
            if o is None:
                return None, '%s: %s' % (name, err)
            objs.append(o)
        for t in LIB_TUS:
            src = os.path.join(libsrc, t)
            if not os.path.isfile(src):
                return None, 'installed library is missing %s' % src
            o, err = obj(t[:-2], src)
            if o is None:
                return None, '%s: %s' % (t, err)
            objs.append(o)
        for name, rel in AEABI_TUS:
            src = os.path.join(libsrc, rel)
            if not os.path.isfile(src):
                return None, 'installed library is missing %s' % src
            o, err = obj(name, src)
            if o is None:
                return None, '%s: %s' % (rel, err)
            objs.append(o)
        stub = w('exitstub.s', EXIT_STUB_S)
        r = self.run([self.arkcc, stub, '-target', 'arm', '-c'] + CPU_OPTS +
                     ['-o', os.path.join(work, 'exitstub.obj')])
        if r.returncode != 0:
            return None, 'exitstub: ' + (r.stdout + r.stderr).strip()[:300]
        objs.insert(0, os.path.join(work, 'startup.obj'))
        objs.append(os.path.join(work, 'exitstub.obj'))

        out = os.path.join(work, 'prog.bin')
        r = self.run([self.arkcc, '-link'] + objs +
                     ['--reloc-data', '--reloc-text', '--vector-table',
                      '-o', out])
        if r.returncode != 0:
            return None, 'link: ' + (r.stdout + r.stderr).strip()[:400]
        return out, ''

    def check_runs(self, dest):
        img, err = self.build_installed(dest)
        if img is None:
            self.bad('build against the installed tree failed: %s' % err)
            return
        if not HAVE_UNICORN:
            print('SKIP the installed tree builds, but running it needs '
                  'unicorn (not installed)')
            return
        status, value, detail = run_image(open(img, 'rb').read())
        if status != 'returned':
            self.bad('image did not run to completion (%s: %s)'
                     % (status, detail))
            return
        want, how = self.expect()
        if value != want:
            self.bad('program returned %r, expected %r (%s)'
                     % (value, want, how))
            return
        print('ok   install: program built from the installed tree runs and '
              'returns %d (%s)' % (value, how))

    def expect(self):
        """The expected return value comes from the host libc when a host
        compiler is available: same source, same question, independent
        implementation.  The hard-coded fallback was computed from the source
        by hand and is only used when there is no host compiler."""
        cc = os.environ.get('CC') or 'gcc'
        work = os.path.join(self.tmp, 'oracle')
        try:
            os.makedirs(work)
            src = os.path.join(work, 'main.c')
            with open(src, 'w', newline='\n') as f:
                f.write(MAIN_C + CMP_C)
            exe = os.path.join(work, 'main.exe' if os.name == 'nt' else 'a.out')
            r = self.run([cc, '-O1', '-o', exe, src])
            if r.returncode == 0:
                run = self.run([exe])
                if run.returncode is not None and 0 <= run.returncode < 256:
                    return run.returncode, 'host %s oracle' % os.path.basename(cc)
        except OSError:
            pass
        return 181, 'hand-computed fallback (no host compiler)'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(
        ROOT, 'arkcc.exe' if os.name == 'nt' else 'arkcc'))
    ap.add_argument('--keep', action='store_true')
    args = ap.parse_args()
    if not os.path.isfile(args.arkcc):
        print('SKIP: arkcc not found at %s (build it with `make`)'
              % args.arkcc)
        return 0

    tmp = tempfile.mkdtemp(prefix='arkinstall_')
    try:
        g = Gate(args.arkcc, tmp)
        dest = os.path.join(tmp, 'stage')
        r = g.install('--prefix', 'usr/local', '--destdir', dest)
        if r.returncode != 0:
            print('FAIL install: %s' % ((r.stdout + r.stderr).strip()[:500],))
            return 1
        g.check_copy_exact(dest)
        g.check_idempotent(dest)
        g.check_dry_run(os.path.join(tmp, 'dry'))
        g.check_destdir_guard(os.path.join(tmp, 'guard'))
        g.check_runs(dest)
        if g.fail:
            print('\n=== %d failure(s) ===' % g.fail)
            return 1
        print('\n=== install: all checks passed ===')
        return 0
    finally:
        if args.keep:
            print('kept %s' % tmp)
        else:
            shutil.rmtree(tmp, ignore_errors=True)


if __name__ == '__main__':
    sys.exit(main())
