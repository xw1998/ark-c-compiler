#!/usr/bin/env python
"""Gates for -r (partial link: merge ARKOBJ2 objects into one object).

What the feature promises
------------------------
`-r -link a.o b.o -o merged.o` concatenates the code sections, merges the
symbol tables with the same strong/weak policy the image linker uses, and
re-emits every relocation with its offset shifted by the object base.  The
output is still an ARKOBJ2 object: unresolved names stay unresolved, so
`-link merged.o more.o` or a second `-r` can finish the job.

What the gate has to catch
-------------------------
Two opposite failures:
  * the merge loses or misplaces something -- a symbol offset not rebased, a
    relocation pointing at the wrong site, a global whose absolute address was
    shifted -- and the merged object still links and runs, just wrongly
    (checks 1-8);
  * the merge accepts an input it cannot represent -- an IR payload it would
    silently drop, two RAM owners, a foreign architecture, a damaged object --
    and writes an object anyway (checks 9-15).

Anti-false-green
----------------
  * "same image as the direct link" is only meaningful if the image does the
    work: the emulator check makes the merged program answer a value that only
    the correct merge produces (13, i.e. 2+3+3+5 across the two units);
  * every refusal asserts both a non-zero exit and that no output file was
    written, because "diagnostic plus stale object" is worse than either;
  * the inputs are hashed before and after the merge, so a merge that rewrote
    its inputs cannot pass;
  * the cropped build (-DARKCC_FEATURE_PARTIAL_LINK=0) must refuse -r and must
    produce byte-identical objects and images for plain compiles -- the
    "default off changes nothing" claim, measured rather than asserted.

Usage: run_partiallink_tests.py [path-to-arkcc]
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

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']

STARTUP = '''\
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    __arkcc_init_globals();
    return main();
}
'''

# --- two units, one global, one cross-unit call --------------------------
LIB = '''\
int add(int x, int y) { return x + y; }
int helper2(void) { return 3; }
'''
MAIN = '''\
extern int add(int, int);
extern int helper2(void);
int g_init = 5;
int main(void) { return add(2, 3) + helper2() + g_init; }
''' + STARTUP

# --- two units that each define a file-static of the same name -----------
STAT_A = '''\
static int helper(void) { return 7; }
int a(void) { return helper(); }
'''
STAT_B = '''\
static int helper(void) { return 9; }
int b(void) { return helper(); }
'''
STAT_MAIN = '''\
extern int a(void);
extern int b(void);
int g_init = 3;
int main(void) { return a() * 10 + b(); }
''' + STARTUP

# --- a symbol that only a third object can satisfy ------------------------
CALLER = '''\
extern int far_away(void);
int call_far(void) { return far_away() + 1; }
'''
PROVIDER = '''\
int far_away(void) { return 40; }
'''
CALLER_MAIN = '''\
extern int call_far(void);
int g_init = 2;
int main(void) { return call_far(); }
''' + STARTUP

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


def blob(path):
    with open(path, 'rb') as f:
        return f.read()


def digest(path):
    return hashlib.sha256(blob(path)).hexdigest()


def write(path, text):
    with open(path, 'w', newline='\n') as f:
        f.write(text)


def write_bytes(path, data):
    with open(path, 'wb') as f:
        f.write(data)


def rd32(d, pos):
    return int.from_bytes(d[pos:pos + 4], 'little')


def parse_obj(path):
    """Read an ARKOBJ2 object with the same layout src/compiler.c writes."""
    d = blob(path)
    if d[:8] != b'ARKOBJ2\n':
        raise ValueError('not an ARKOBJ2 object: %s' % path)
    pos = 8
    code_len = rd32(d, pos)
    pos += 4
    code = d[pos:pos + code_len]
    pos += code_len
    syms = []
    n = rd32(d, pos)
    pos += 4
    for _ in range(n):
        nl = rd32(d, pos)
        pos += 4
        name = d[pos:pos + nl - 1].decode('latin-1')
        pos += nl
        off = rd32(d, pos)
        pos += 4
        typ = d[pos]
        pos += 1
        weak = d[pos]
        pos += 1
        syms.append((name, off, typ, weak))
    rels = []
    n = rd32(d, pos)
    pos += 4
    for _ in range(n):
        nl = rd32(d, pos)
        pos += 4
        name = d[pos:pos + nl - 1].decode('latin-1')
        pos += nl
        off = rd32(d, pos)
        pos += 4
        typ = d[pos]
        pos += 1
        rels.append((name, off, typ))
    return {'code_len': code_len, 'code': code, 'syms': syms, 'rels': rels,
            'trailing': len(d) - pos, 'size': len(d)}


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


def image_value(arkcc, objs, work, tag, extra=None):
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, ARM + ['-link'] + list(objs) + ['--vector-table'] +
                  ['-o', img] + (extra or []), work)
    if rc != 0:
        return None, 'link: ' + log.strip()[:200]
    status, value, detail = run_image(blob(img))
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

    work = tempfile.mkdtemp(prefix='arkcc_rlink_')
    try:
        files = {
            'lib.c': LIB, 'main.c': MAIN,
            'stat_a.c': STAT_A, 'stat_b.c': STAT_B, 'stat_main.c': STAT_MAIN,
            'caller.c': CALLER, 'provider.c': PROVIDER,
            'caller_main.c': CALLER_MAIN,
        }
        for name, text in files.items():
            write(os.path.join(work, name), text)

        # the first object reserves the vector-table hole (see -link)
        rc, log = run(arkcc, ARM + ['-O1', '-c', '--vector-table', '-o',
                                    'lib.o', 'lib.c'], work)
        check(rc == 0, 'setup: lib.o (with --vector-table) compiles', log.strip()[:120])
        for n in ('main', 'stat_b', 'stat_main', 'provider', 'caller_main'):
            run(arkcc, ARM + ['-O1', '-c', '-o', n + '.o', n + '.c'], work)
        # these two are linked *first* after the merge, so they carry the hole
        for n in ('stat_a', 'caller'):
            run(arkcc, ARM + ['-O1', '-c', '--vector-table', '-o', n + '.o',
                              n + '.c'], work)

        # ------------------------------------------- 1. the output is an object
        before = {n: digest(os.path.join(work, n + '.o'))
                  for n in ('lib', 'main')}
        rc, log = run(arkcc, ['-r', '-link', 'lib.o', 'main.o', '-o', 'merged.o'],
                      work)
        check(rc == 0 and os.path.exists(os.path.join(work, 'merged.o')),
              '-r writes a merged object (no image)', log.strip()[:160])
        after = {n: digest(os.path.join(work, n + '.o'))
                 for n in ('lib', 'main')}
        check(before == after, 'the inputs are left untouched',
              str(sorted(before.items()))[:120])
        try:
            mo = parse_obj(os.path.join(work, 'merged.o'))
            ok_obj = (blob(os.path.join(work, 'merged.o'))[:8] == b'ARKOBJ2\n'
                      and mo['trailing'] == 0
                      and mo['code_len'] == (parse_obj(os.path.join(work, 'lib.o'))['code_len'] +
                                             parse_obj(os.path.join(work, 'main.o'))['code_len']))
        except Exception as e:                          # pragma: no cover
            ok_obj, mo = False, None
            log = str(e)
        check(ok_obj,
              'it is ARKOBJ2, nothing trails the tables, code is the sum of the inputs',
              '' if ok_obj else log[:160])

        if mo:
            lo = parse_obj(os.path.join(work, 'lib.o'))
            mi = parse_obj(os.path.join(work, 'main.o'))
            base = lo['code_len']
            sym = dict((s[0], s[1]) for s in mo['syms'] if s[2] == 0)
            # 'main' lives in main.o: its offset must carry lib.o's code size
            want_main = dict((s[0], s[1]) for s in mi['syms'] if s[2] == 0).get('main')
            check(want_main is not None and sym.get('main') == base + want_main,
                  'code symbols are rebased by the object base',
                  'main merged=%r expected=%r' % (sym.get('main'),
                                                  None if want_main is None else base + want_main))
            # a relocation from main.o must point into main.o's slice
            mr = dict((r[0], r[1]) for r in mi['rels'])
            mg = dict((r[0], r[1]) for r in mo['rels'])
            name = 'add' if 'add' in mr else (mi['rels'][0][0] if mi['rels'] else None)
            check(name is not None and mg.get(name) == base + mr.get(name),
                  'relocations are rebased by the object base',
                  '%r merged=%r expected=%r' % (name, mg.get(name),
                                                None if name is None else base + mr.get(name)))
            # the global's absolute address must NOT move
            ds = dict((s[0], s[1]) for s in mi['syms'] if s[2] == 1)
            dm = dict((s[0], s[1]) for s in mo['syms'] if s[2] == 1)
            check('g_init' in ds and dm.get('g_init') == ds.get('g_init'),
                  'a global keeps its absolute address (data is not relocated)',
                  'g_init %r -> %r' % (ds.get('g_init'), dm.get('g_init')))
            # the RAM window descriptor survives, unchanged
            rs = dict((s[0], s[1]) for s in mi['syms'] if s[2] == 2)
            rm = dict((s[0], s[1]) for s in mo['syms'] if s[2] == 2)
            check(rs and rm == rs,
                  'the single RAM window descriptor survives unchanged',
                  '%r -> %r' % (rs, rm))

        # ------------------------- 2. the merged object links to the same image
        rc, log = run(arkcc, ARM + ['-link', 'lib.o', 'main.o', '--vector-table',
                                    '-o', 'direct.bin'], work)
        rc2, log2 = run(arkcc, ARM + ['-link', 'merged.o', '--vector-table',
                                      '-o', 'merged.bin'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'direct.bin')) ==
              digest(os.path.join(work, 'merged.bin')),
              'linking the merged object reproduces the direct image byte for byte',
              'rc=%d/%d %s' % (rc, rc2, (log + log2).strip()[:160]))

        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['merged.o'], work, 'mval')
            check(v == 13, 'that image answers 13 (2+3+3+5 across the two units)',
                  why or 'got %r' % (v,))
        else:
            skip('the merged image answers 13', 'no unicorn')

        # ------------------------------------------ 3. merging is associative
        rc, log = run(arkcc, ['-r', '-link', 'merged.o', '-o', 'again.o'], work)
        rc2, log2 = run(arkcc, ARM + ['-link', 'again.o', '--vector-table', '-o',
                                      'again.bin'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'direct.bin')) ==
              digest(os.path.join(work, 'again.bin')),
              '-r over its own output is idempotent (re-merge then link matches)',
              'rc=%d/%d %s' % (rc, rc2, (log + log2).strip()[:160]))

        # --------------------- 4. an unresolved name stays unresolved, then resolves
        rc, log = run(arkcc, ['-r', '-link', 'caller.o', '-o', 'caller_only.o'], work)
        syms = dict((s[0], s[2]) for s in
                    parse_obj(os.path.join(work, 'caller_only.o'))['syms']) if rc == 0 else {}
        check(rc == 0 and 'far_away' not in syms,
              'a name only a third object can define is not invented by -r',
              'rc=%d syms=%r' % (rc, sorted(syms)[:8]))
        rc, log = run(arkcc, ARM + ['-link', 'caller_only.o', 'provider.o',
                                    'caller_main.o', '--vector-table', '-o',
                                    'far.bin'], work)
        check(rc == 0, '-link resolves it against an object that arrives later',
              log.strip()[:160])
        if HAVE_UNICORN and rc == 0:
            status, value, detail = run_image(blob(os.path.join(work, 'far.bin')))
            check(status == 'returned' and value == 41,
                  'and the image answers 41 (40+1)', '%s %s' % (status, detail))
        else:
            skip('the late-resolved image answers 41', 'no unicorn or link failed')

        # ------------------------------------- 5. same-named statics stay apart
        rc, log = run(arkcc, ['-r', '-link', 'stat_a.o', 'stat_b.o',
                              'stat_main.o', '-o', 'stat_m.o'], work)
        rc2, log2 = run(arkcc, ['-r', '-link', 'stat_a.o', 'stat_b.o', '-o',
                                'stat_ab.o'], work)
        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['stat_m.o'], work, 'statm')
            check(rc == 0 and v == 79,
                  'two file-statics of the same name still give 7*10+9',
                  'rc=%d %s' % (rc, why or 'got %r' % (v,)))
        else:
            skip('two same-named statics still answer 79', 'no unicorn')
        check(rc2 == 0, 'merging without a main is allowed (a library unit)',
              log2.strip()[:160])

        # ------------------------------------------- 6. refusals (each: no output)
        def refused(args, out, what, expect_text=''):
            path = os.path.join(work, out)
            if os.path.exists(path):
                os.remove(path)
            rc, log = run(arkcc, args, work)
            ok = (rc != 0 and not os.path.exists(path) and
                  (expect_text in log if expect_text else True))
            check(ok, what, 'rc=%d out=%s %s' % (rc,
                                                 os.path.exists(path),
                                                 log.strip().splitlines()[0][:110]
                                                 if log.strip() else ''))

        run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', 'main_ir.o', 'main.c'], work)
        check(blob(os.path.join(work, 'main_ir.o')).find(b'ARKIR1\n') > 0,
              'setup: main_ir.o really carries an IR payload')
        refused(['-r', '-link', 'lib.o', 'main_ir.o', '-o', 'bad_ir.o'], 'bad_ir.o',
                'an input with an IR payload is refused, never silently stripped',
                'IR payload')
        refused(['-r', '-link', 'main.o', 'stat_main.o', '-o', 'bad_ram.o'],
                'bad_ram.o', 'two objects that both place .data/.bss are refused',
                '.data/.bss')
        refused(['-r', '-link', 'lib.o', 'lib.c', '-o', 'bad_txt.o'], 'bad_txt.o',
                'a non-object input is refused by name', 'not one')

        rv_src = os.path.join(work, 'rv.c')
        write(rv_src, 'int rv_one(void) { return 1; }\n')
        rc, _ = run(arkcc, ['-target', 'riscv32', '-O1', '-c', '-o', 'rv.o', 'rv.c'],
                    work)
        if rc == 0:
            refused(['-r', '-link', 'lib.o', 'rv.o', '-o', 'bad_isa.o'], 'bad_isa.o',
                    'mixing riscv32 and ARM objects is refused', 'riscv32')
        else:
            skip('mixed-ISA refusal', 'riscv32 object build failed')

        half = blob(os.path.join(work, 'lib.o'))[:len(blob(os.path.join(work, 'lib.o'))) // 2]
        write_bytes(os.path.join(work, 'trunc.o'), half)
        refused(['-r', '-link', 'trunc.o', '-o', 'bad_trunc.o'], 'bad_trunc.o',
                'a truncated object is refused (no half-parsed tables)')

        # ------------------------------------------- 7. option validation
        refused(['-r', 'lib.o', '-o', 'x.o'], 'x.o', '-r without -link is refused',
                'needs -link')
        refused(['-r', '-link', 'lib.o'], 'x.o', '-r without -o is refused',
                'needs -o')
        refused(['-r', '-link', 'lib.o', '--lto', '-o', 'x.o'], 'x.o',
                '-r with --lto is refused (two different merges)', '--lto')
        refused(['-r', '-c', '-link', 'lib.o', '-o', 'x.o'], 'x.o',
                '-r with -c is refused', '-c')
        rc, log = run(arkcc, ['-r', '-link', '-o', 'x.o'], work)
        check(rc != 0 and not os.path.exists(os.path.join(work, 'x.o')),
              '-r with no objects is refused', log.strip()[:110])

        # ------------------------------ 8. cropped build: refuses and changes nothing
        cropped, why = build_arkcc(work, ['-DARKCC_FEATURE_PARTIAL_LINK=0'],
                                   'arkcc_nopl')
        if cropped:
            path = os.path.join(work, 'x.o')
            if os.path.exists(path):
                os.remove(path)
            rc, log = run(cropped, ['-r', '-link', 'lib.o', '-o', 'x.o'], work)
            check(rc != 0 and not os.path.exists(path) and 'C3900U' in log,
                  'the cropped build refuses -r with C3900U',
                  log.strip().splitlines()[0][:110] if log.strip() else '')
            rc1, _ = run(cropped, ARM + ['-O1', '-c', '--vector-table', '-o',
                                         'lib_c.o', 'lib.c'], work)
            rc2, _ = run(cropped, ARM + ['-link', 'lib.o', 'main.o',
                                         '--vector-table', '-o', 'crop.bin'], work)
            check(rc1 == 0 and rc2 == 0 and
                  digest(os.path.join(work, 'lib_c.o')) ==
                  digest(os.path.join(work, 'lib.o')) and
                  digest(os.path.join(work, 'crop.bin')) ==
                  digest(os.path.join(work, 'direct.bin')),
                  'without -r the cropped build writes byte-identical objects and images')
        else:
            skip('cropped-build claims', why)

    finally:
        shutil.rmtree(work, ignore_errors=True)

    print('')
    if failures:
        print('%d FAILED, %d skipped' % (len(failures), len(skips)))
        for f in failures:
            print('  - ' + f)
        return 1
    print('all checks passed (%d skipped)' % len(skips))
    return 0


if __name__ == '__main__':
    sys.exit(main())
