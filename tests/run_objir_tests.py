#!/usr/bin/env python
"""Gates for --obj-ir / -link --lto (IR payload in the ARKOBJ2 object).

What the feature promises
------------------------
`-c --obj-ir` writes the unit's IR into the object, after the symbol and
relocation tables, so the object is still an object to every reader that
stops where it always stopped.  `-link --lto` reads those payloads back,
merges the units the way --ipo does, runs the pass pipeline over the merged
program and generates fresh code from it -- cross-file inlining and
cross-file constant folding at link time, not the linker's
concatenate-and-patch.

What the gate has to catch
-------------------------
Two opposite failures:
  * the payload is not carried, or is lost/damaged on the way in -- then the
    --lto answer silently differs from the --ipo answer, or an object that
    cannot be used is accepted anyway (checks 1-12);
  * the payload is carried but something else changed -- an object built
    without --obj-ir must stay byte-identical, and a plain -link over objects
    that do carry payloads must produce exactly the image it always produced
    (checks 13-16).

Anti-false-green
----------------
  * "byte-identical to --ipo" is only meaningful if --ipo itself did the work,
    so the same asm is asserted to contain the cross-unit inline (no `BL one`)
    and the cross-unit folded constant (MOV r0, #100) BEFORE the comparison;
  * the emulator check makes the merged program answer 102, so two equally
    wrong images cannot pass as a match;
  * every corruption test asserts both "non-zero exit" and "no output file
    written", because a diagnostic followed by a stale image would be worse
    than either alone;
  * the cropped build (-DARKCC_FEATURE_OBJ_IR=0) must refuse the flags and
    must produce byte-identical objects for a plain -c -- that is the
    "default off changes nothing" claim, measured rather than asserted.

Usage: run_objir_tests.py [path-to-arkcc]
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
void __arkcc_init_globals(void);
int main(void);
int Reset_Handler(void)
{
    __arkcc_init_globals();
    return main();
}
'''

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']
IMG = ARM + ['-O1', '--vector-table']

# --- cross-unit inline + cross-unit constant fold ------------------------
INL_MAIN = '''\
int g_init = 5;              /* makes the compiler emit __arkcc_init_globals */
const int LIMIT = 100;
extern int one(void);
int main(void) { return one() * 2 + LIMIT; }
''' + STARTUP
INL_LIB = '''\
int one(void) { return 1; }
'''

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
int g_init = 3;              /* makes the compiler emit __arkcc_init_globals */
extern int a(void);
extern int b(void);
int main(void) { return a() * 10 + b(); }
''' + STARTUP

PLAIN = '''\
int main(void) { return 42; }
'''

ASM_INPUT = '''\
    .text
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

def asm_text(path):
    with open(path, 'r', errors='replace') as f:
        return f.read()

def func_body(text, name):
    out = []
    on = False
    for line in text.splitlines():
        s = line.strip()
        if s == name + ':':
            on = True
            continue
        if not on:
            continue
        if s.startswith('.size ') or s.startswith('.global '):
            break
        out.append(line)
    return '\n'.join(out)

def payload_offset(data):
    """Where the IR payload header starts inside an object (or -1)."""
    return data.find(b'ARKIR1\n')

def image_value(arkcc, objs, work, flags, tag):
    img = os.path.join(work, tag + '.bin')
    rc, log = run(arkcc, ['--lto', '-link'] + list(objs) + IMG + flags +
                  ['-o', img], work)
    if rc != 0:
        return None, 'link: ' + log.strip()[:200]
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

    work = tempfile.mkdtemp(prefix='arkcc_objir_')
    try:
        files = {
            'inl_main.c': INL_MAIN, 'inl_lib.c': INL_LIB,
            'stat_a.c': STAT_A, 'stat_b.c': STAT_B, 'stat_main.c': STAT_MAIN,
            'plain.c': PLAIN, 'thing.s': ASM_INPUT,
        }
        for name, text in files.items():
            write(os.path.join(work, name), text)

        # ------------------------------------------- 1. the object carries IR
        rc, log = run(arkcc, ARM + ['-O2', '-c', '--obj-ir', '-o', 'inl_main.o',
                                    'inl_main.c'], work)
        rc2, log2 = run(arkcc, ARM + ['-O2', '-c', '-o', 'inl_main_plain.o',
                                      'inl_main.c'], work)
        data = blob(os.path.join(work, 'inl_main.o')) if rc == 0 else b''
        plain = blob(os.path.join(work, 'inl_main_plain.o')) if rc2 == 0 else b''
        check(rc == 0 and rc2 == 0 and b'ARKIR1\n' in data,
              '-c --obj-ir writes an IR payload into the object',
              'rc=%d rc_plain=%d' % (rc, rc2))
        check(len(data) > len(plain) and plain == data[:len(plain)],
              'the payload is appended after the classic object, prefix unchanged',
              'with=%d without=%d' % (len(data), len(plain)))

        # ------------------------------------ 2. --lto == --ipo, and it did work
        run(arkcc, ARM + ['-O2', '-c', '--obj-ir', '-o', 'inl_lib.o',
                          'inl_lib.c'], work)
        rc, log = run(arkcc, ARM + ['-O2', '--ipo', '--const-global', '-S',
                                    '-o', 'ipo.s', 'inl_main.c', 'inl_lib.c'],
                      work)
        ipo_asm = asm_text(os.path.join(work, 'ipo.s')) if rc == 0 else ''
        body = func_body(ipo_asm, 'main')
        check(rc == 0 and 'BL one' not in body and 'MOV r0, #100' in body,
              'the --ipo reference really inlined across files and folded K',
              'rc=%d has_bl=%s has_100=%s'
              % (rc, 'BL one' in body, 'MOV r0, #100' in body))
        rc, log = run(arkcc, ARM + ['--lto', '-link', 'inl_main.o', 'inl_lib.o',
                                    '-O2', '--const-global', '-S', '-o',
                                    'lto.s'], work)
        lto_asm = asm_text(os.path.join(work, 'lto.s')) if rc == 0 else ''
        check(rc == 0 and digest(os.path.join(work, 'lto.s')) ==
              digest(os.path.join(work, 'ipo.s')),
              '-link --lto reproduces the --ipo assembly byte for byte',
              'rc=%d %s' % (rc, log.strip()[:160]))

        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['inl_main.o', 'inl_lib.o'], work,
                                 ['--const-global'], 'inl')
            check(v == 102, 'the merged program answers 102 (1*2+100)',
                  why or 'got %r' % (v,))
        else:
            skip('the merged program answers 102', 'no unicorn')

        # ------------------------------- 3. images match, too (not just -S)
        rc, _ = run(arkcc, ARM + ['-O2', '--ipo', '--const-global', '-o',
                                  'ipo.bin', 'inl_main.c', 'inl_lib.c'], work)
        rc2, log = run(arkcc, ARM + ['--lto', '-link', 'inl_main.o', 'inl_lib.o',
                                     '-O2', '--const-global', '-o', 'lto.bin'],
                       work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'ipo.bin')) ==
              digest(os.path.join(work, 'lto.bin')),
              'the linked image equals the --ipo image byte for byte',
              'rc=%d/%d %s' % (rc, rc2, log.strip()[:140]))

        # ---------------- 4. file-statics survive the round trip unchanged
        for n in ('stat_a', 'stat_b', 'stat_main'):
            run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', n + '.o', n + '.c'],
                work)
        rc, log = run(arkcc, ARM + ['-O1', '--ipo', '-S', '-o', 'st_ipo.s',
                                    'stat_main.c', 'stat_a.c', 'stat_b.c'], work)
        rc2, log2 = run(arkcc, ARM + ['--lto', '-link', 'stat_main.o',
                                      'stat_a.o', 'stat_b.o', '-O1', '-S', '-o',
                                      'st_lto.s'], work)
        t_ipo = asm_text(os.path.join(work, 'st_ipo.s')) if rc == 0 else ''
        t_lto = asm_text(os.path.join(work, 'st_lto.s')) if rc2 == 0 else ''
        check(rc == 0 and rc2 == 0 and t_ipo == t_lto and
              '__ipo1f_helper' in t_ipo and '__ipo2f_helper' in t_ipo,
              'two same-named statics stay mangled and distinct through the payload',
              'rc=%d/%d' % (rc, rc2))
        if HAVE_UNICORN:
            v, why = image_value(arkcc, ['stat_main.o', 'stat_a.o', 'stat_b.o'],
                                 work, [], 'st')
            check(v == 79, 'that program answers 79 (7*10+9)', why or 'got %r' % (v,))
        else:
            skip('that program answers 79', 'no unicorn')

        # --------------------- 5. object order: same order = same program
        run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', 'a.o', 'stat_a.c'], work)
        run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', 'b.o', 'stat_b.c'], work)
        rc, log = run(arkcc, ARM + ['-O1', '--ipo', '-S', '-o', 'ord1.s',
                                    'stat_a.c', 'stat_b.c'], work)
        rc2, log2 = run(arkcc, ARM + ['-O1', '--lto', '-link', 'a.o', 'b.o',
                                      '-O1', '-S', '-o', 'ord2.s'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'ord1.s')) ==
              digest(os.path.join(work, 'ord2.s')),
              'two units without a main still merge identically (no main needed)',
              'rc=%d/%d %s' % (rc, rc2, (log or log2).strip()[:120]))

        # --------------------------------------- 6. payload damage is refused
        good = blob(os.path.join(work, 'inl_main.o'))
        off = payload_offset(good)
        check(off > 0, 'the payload header was located in the object',
              'offset=%d' % off)

        def damaged(name, data, want):
            p = os.path.join(work, name)
            write_bytes(p, data)
            out = os.path.join(work, name + '.bin')
            rc, log = run(arkcc, ARM + ['--lto', '-link', name, 'inl_lib.o',
                                        '-O1', '-o', name + '.bin'], work)
            check(rc != 0 and not os.path.exists(out) and want in log,
                  want, 'rc=%d %s' % (rc, log.strip().replace('\n', ' ')[:150]))

        damaged('trunc.o', good[:-6], 'payload length does not match the file')
        damaged('magic.o', good[:off] + b'ARKIRZ\n' + good[off + 8:],
                'not an IR payload')
        bad_ver = bytearray(good)
        bad_ver[off + 8:off + 12] = (99).to_bytes(4, 'little')
        damaged('ver.o', bytes(bad_ver), 'is version 99')
        bad_len = bytearray(good)
        blen = int.from_bytes(good[off + 12:off + 16], 'little')
        bad_len[off + 12:off + 16] = (blen + 64).to_bytes(4, 'little')
        damaged('blen.o', bytes(bad_len), 'payload length does not match the file')

        # an object built without --obj-ir is refused by --lto, named
        rc, log = run(arkcc, ARM + ['--lto', '-link', 'inl_main_plain.o',
                                    'inl_lib.o', '-O1', '-o', 'nop.bin'], work)
        check(rc != 0 and 'no IR payload' in log,
              'an object without a payload is refused by name',
              'rc=%d %s' % (rc, log.strip()[:150]))

        # a non-object file is refused as such
        rc, log = run(arkcc, ARM + ['--lto', '-link', 'inl_main.c', '-O1',
                                    '-o', 'notobj.bin'], work)
        check(rc != 0 and 'not an ARKOBJ2 object' in log,
              'a source file given to --lto is refused as not an object',
              'rc=%d %s' % (rc, log.strip()[:150]))

        # ------------------------ 7. the payload does not disturb plain -link
        # (an object pair with no Reset_Handler: the plain linker wants a
        # vector table when one is present, which is a different rule.)
        rc, log = run(arkcc, ARM + ['-O1', '-c', '-o', 'sa_np.o', 'stat_a.c'],
                      work)
        rc, log = run(arkcc, ARM + ['-O1', '-c', '-o', 'sb_np.o', 'stat_b.c'],
                      work)
        rc, log = run(arkcc, ARM + ['-O1', '-link', 'a.o', 'b.o',
                                    '-o', 'pl1.bin'], work)
        rc2, log2 = run(arkcc, ARM + ['-O1', '-link', 'sa_np.o', 'sb_np.o',
                                      '-o', 'pl2.bin'], work)
        check(rc == 0 and rc2 == 0 and
              digest(os.path.join(work, 'pl1.bin')) ==
              digest(os.path.join(work, 'pl2.bin')),
              'plain -link ignores the payload and produces the same image',
              'rc=%d/%d %s' % (rc, rc2, (log or log2).strip()[:120]))

        # ------------------------------------------- 8. option refusals
        run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', 'p.o', 'plain.c'], work)
        refusals = [
            (['--lto', '-link', 'p.o', '-c', '-o', 'x.o'], '-c'),
            (['--lto', '-link', 'p.o', '-E', '-o', 'x.i'], '-E'),
        ]
        for args, what in refusals:
            rc, log = run(arkcc, ARM + args, work)
            check(rc != 0 and '--lto cannot be combined with ' + what in log,
                  '--lto refuses %s with a reason' % what,
                  'rc=%d %s' % (rc, log.strip()[:150]))
        rc, log = run(arkcc, ARM + ['--lto', '-link', 'p.o'], work)
        check(rc != 0 and 'no -o' in log,
              '--lto refuses a link without an output name',
              'rc=%d %s' % (rc, log.strip()[:150]))
        rc, log = run(arkcc, ARM + ['--lto', '-link', '-O1', '-o', 'x.bin'], work)
        check(rc != 0 and 'at least one object' in log,
              '--lto refuses a link with no inputs',
              'rc=%d %s' % (rc, log.strip()[:150]))
        rc, log = run(arkcc, ARM + ['-O1', '-c', '--obj-ir', '-o', 'x.o',
                                    'thing.s'], work)
        check(rc != 0 and 'needs a C source' in log,
              '--obj-ir refuses an assembly input',
              'rc=%d %s' % (rc, log.strip()[:150]))
        rc, log = run(arkcc, ['-target', 'c', '-c', '--obj-ir', '-o', 'x.cobj',
                              'plain.c'], work)
        check(rc != 0 and 'needs an object backend' in log,
              '--obj-ir refuses a backend that writes text',
              'rc=%d %s' % (rc, log.strip()[:150]))

        # ------------------------------- 9. the cropped build refuses both
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_OBJ_IR=0'],
                                   'arkcc_no_objir')
        if not trimmed:
            skip('a build without the feature refuses --obj-ir / --lto', why)
        else:
            rc, log = run(trimmed, ARM + ['-O1', '-c', '--obj-ir', '-o', 'n.o',
                                          'plain.c'], work)
            check(rc != 0 and 'not compiled into this build' in log,
                  'a build without the feature refuses --obj-ir',
                  'rc=%d %s' % (rc, log.strip()[:140]))
            rc, log = run(trimmed, ARM + ['--lto', '-link', 'p.o', '-O1', '-o',
                                          'n.bin'], work)
            check(rc != 0 and 'not compiled into this build' in log,
                  'and it refuses --lto',
                  'rc=%d %s' % (rc, log.strip()[:140]))

            # -------------------- 10. default off changes nothing (objects)
            diffs = 0
            compared = 0
            for src in sorted(glob.glob(os.path.join(os.getcwd(), 'examples',
                                                     '*.c')))[:6]:
                base = os.path.basename(src)
                stamp = ['--build-date', 'Jan  1 2026',
                         '--build-time', '00:00:00']
                rc1, _ = run(arkcc, ARM + ['-O2'] + stamp +
                             ['-c', '-o', os.path.join(work, 'a.o'), src],
                             os.getcwd())
                rc2, _ = run(trimmed, ARM + ['-O2'] + stamp +
                             ['-c', '-o', os.path.join(work, 'b.o'), src],
                             os.getcwd())
                if rc1 != 0 or rc2 != 0:
                    continue
                compared += 1
                if digest(os.path.join(work, 'a.o')) != \
                   digest(os.path.join(work, 'b.o')):
                    diffs += 1
                    print('      differs: %s' % base)
            check(compared > 0 and diffs == 0,
                  'objects from a build without the feature are byte-identical',
                  'compared=%d diff=%d' % (compared, diffs))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    print()
    if failures:
        print('%d check(s) failed' % len(failures))
        return 1
    print('all --obj-ir checks passed%s'
          % (' (%d skipped)' % len(skips) if skips else ''))
    return 0

if __name__ == '__main__':
    sys.exit(main())