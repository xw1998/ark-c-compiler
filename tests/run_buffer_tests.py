#!/usr/bin/env python3
"""Gate: a too-small buffer must be named, never silently truncated.

Both limits in this file were found the hard way, and both failed the same
way -- the tool answered something plausible instead of "buffer too small":

  * ARK_SRC_BUF_SIZE: fs_read_file() truncates, so a 2 MB CMSIS device header
    reported `#37 the #endif ... is missing` (the tail was never read).
  * ARK_ASM_BUF_SIZE: the ARM/C/RV/x86_64 emitters copied the prefix of the
    program text, so a 92 KB assembly (the AEABI runtime at -O0) reached the
    assembler cut mid-line and the board answered
    `unknown mnemonic "P" at code offset 8906` -- a frontend-looking error for
    a buffer that was simply 64 KB.  That cost an hour on the H743; the fix is
    to refuse, and this gate is what keeps it refused.
  * PP_BUF_SIZE: buf_putc() dropped the byte that did not fit and set a flag
    that only the two macro-expansion paths ever read.  A plain #include body
    that ran past the buffer was therefore cut MID-TRANSLATION-UNIT with no
    diagnostic: measured on STM32F401 HAL stm32f4xx_hal_gpio.c at
    PP_BUF_SIZE=256 KB, arkcc emitted 537 bytes of assembly (the runtime
    helpers only) and exited 0 -- a silently incomplete object, which is the
    one failure mode this project refuses.  It is an error now.

Each check builds a cropped arkcc (the buffer macros are compile-time sizes,
so there is no way to reach the limit from a normal build) and requires:

  1. the run fails (non-zero exit),
  2. the diagnostic names the macro to enlarge,
  3. no output file exists -- a truncated result must not be left on disk.

Usage: run_buffer_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import os
import shutil
import subprocess
import sys
import tempfile

RESULTS = []


def check(ok, what, detail=''):
    print('%s %s%s' % ('PASS' if ok else 'FAIL', what,
                       '' if ok else '  [%s]' % detail))
    RESULTS.append((ok, what, detail))
    return ok


def build_arkcc(where, defines, name):
    cc = os.environ.get('CC', 'gcc')
    if not shutil.which(cc):
        return None, 'no %s on PATH' % cc
    srcs = (sorted(__import__('glob').glob('src/*.c')) +
            sorted(__import__('glob').glob('src/backend/*/*.c')) +
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
        tail = p.stdout.decode('utf-8', 'replace').strip().splitlines()
        return None, (tail or ['build failed'])[-1][:160]
    return out, ''


def run(argv, cwd):
    p = subprocess.run(argv, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


# A source whose -O0 assembly is a few KB: 300 functions, each with a couple of
# statements, so no backend can fit it in a 4 KB text buffer.
BIG_SRC = ''.join('int f%d(int a, int b) { int c = a * 7 + b; return c - a; }\n'
                  % i for i in range(300)) + 'int main(void) { return f0(1, 2); }\n'


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_buf_')
    try:
        src = os.path.join(work, 'big.c')
        with open(src, 'w', encoding='utf-8', newline='\n') as f:
            f.write(BIG_SRC)

        # ---- 1. a 4 KB assembly buffer must refuse, not truncate ----------
        small, why = build_arkcc(work, ['-DARK_ASM_BUF_SIZE=4096'], 'arkcc_asm4k')
        if not small:
            check(False, 'a 4 KB assembly buffer refuses a bigger program', why)
        else:
            out = os.path.join(work, 'asm4k.o')
            rc, log = run([small, '-c', src, '-o', out, '--cpu', 'Cortex-M7',
                           '--thumb', '-O0'], work)
            check(rc != 0, 'a 4 KB assembly buffer refuses a bigger program',
                  'rc=%d %s' % (rc, log.strip()[:160]))
            check('ARK_ASM_BUF_SIZE' in log,
                  'the refusal names ARK_ASM_BUF_SIZE',
                  log.strip()[:160])
            check(not os.path.exists(out),
                  'no object is left behind by the refusal',
                  'wrote %s' % out)

        # ---- 2. a 1 KB source buffer must refuse, not truncate ------------
        small2, why = build_arkcc(work, ['-DARK_SRC_BUF_SIZE=1024'], 'arkcc_src1k')
        if not small2:
            check(False, 'a 1 KB source buffer refuses a bigger file', why)
        else:
            out = os.path.join(work, 'src1k.o')
            rc, log = run([small2, '-c', src, '-o', out, '--cpu', 'Cortex-M7',
                           '--thumb', '-O0'], work)
            check(rc != 0, 'a 1 KB source buffer refuses a bigger file',
                  'rc=%d %s' % (rc, log.strip()[:160]))
            check('ARK_SRC_BUF_SIZE' in log,
                  'the refusal names ARK_SRC_BUF_SIZE', log.strip()[:160])
            check(not os.path.exists(out),
                  'no object is left behind by the refusal',
                  'wrote %s' % out)

        # ---- 2b. a 4 KB preprocessed-output buffer must refuse ----------
        # BIG_SRC expands to well over 4 KB, so the truncated text would parse
        # as a shorter unit; the point of the check is that it does not.
        small3, why = build_arkcc(work, ['-DPP_BUF_SIZE=4096'], 'arkcc_pp4k')
        if not small3:
            check(False, 'a 4 KB preprocessed-output buffer refuses', why)
        else:
            out = os.path.join(work, 'pp4k.o')
            rc, log = run([small3, '-c', src, '-o', out, '--cpu', 'Cortex-M7',
                           '--thumb', '-O0'], work)
            check(rc != 0, 'a 4 KB preprocessed-output buffer refuses',
                  'rc=%d %s' % (rc, log.strip()[:160]))
            check('PP_BUF_SIZE' in log,
                  'the refusal names PP_BUF_SIZE', log.strip()[:160])
            check(not os.path.exists(out),
                  'no object is left behind by the refusal',
                  'wrote %s' % out)

        # ---- 3. the same program is fine with the real buffer -------------
        # Without this the gate would pass on a build that refuses everything.
        out = os.path.join(work, 'ok.o')
        rc, log = run([os.path.abspath(arkcc), '-c', src, '-o', out,
                       '--cpu', 'Cortex-M7', '--thumb', '-O0'], work)
        check(rc == 0 and os.path.exists(out),
              'the normal build still compiles the same program',
              'rc=%d %s' % (rc, log.strip()[:160]))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    bad = [r for r in RESULTS if not r[0]]
    print()
    if bad:
        print('%d check(s) failed' % len(bad))
        return 1
    print('all buffer checks passed')
    return 0


if __name__ == '__main__':
    sys.exit(main())
