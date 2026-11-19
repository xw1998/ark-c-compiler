#!/usr/bin/env python
"""Gates for --diag_style=modern.

The modern style is presentation only: it must never change what is reported,
only how.  So the gate asks three separate questions, each of which can fail on
its own:

  1. Shape: a modern header is "f.c:3:9: error: message [#20]", the echo block
     is framed with a right-aligned line number, the caret sits under the token
     it talks about (measured by display width, so a tab counts 1 and a CJK
     character counts 2), and the summary is "N error(s) generated."
  2. Isolation: the default (arm) and ide styles keep their exact measured
     bytes.  A modern leak into either of those is a failure, because those two
     are the armcc-compatible styles the project reproduces byte for byte.
  3. Switches: both spellings work (--diag_style=modern and --diag_style
     modern), "clang" is an alias, a bad value is still C3903U, the last
     --diag_style on the command line wins, and --errors gets the same shape.

Anti-false-green checks (this gate must be able to fail):
  * the note line ("run arkcc --help ...") appears in modern only -- the arm
    run of the same bad option must not contain it;
  * an end-of-source diagnostic is not spelled with armcc's "At end of source"
    in modern, and it never echoes a source block;
  * a build with -DARKCC_FEATURE_DIAG=0 still links (diag_note must exist as a
    no-op there) and still refuses the bad option.

Usage: run_modern_diag_tests.py [path-to-arkcc]
Exit 0 = every check behaved, 1 = a check failed, 2 = setup problem.
"""
import glob
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))

# A tab-indented line: the caret column must count the tab as one column, which
# is what the armcc echo has always done.
SRC_ERR = '''\
int main(void)
{
\tint x = 1;
\treturn y + x;
}
'''

# 4 CJK characters before the offending token: a caret padded by byte count
# would land in the middle of the character, so this checks display width.
SRC_CJK = '''\
int main(void)
{
\tint v = 1; /* \u4e2d\u6587\u6ce8\u91ca */ return v + w;
}
'''

SRC_EOF = '''\
int f(void)
{
\treturn 1;
'''

SRC_WARN = '''\
static int unused_fn(int a) { return a + 1; }
int main(void) { return 0; }
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


def write(path, text):
    with open(path, 'w', newline='\n', encoding='utf-8') as f:
        f.write(text)


def lines(log):
    # The console layer emits CRLF on Windows; compare on LF-normalised text.
    return log.replace('\r\n', '\n').split('\n')


def display_width(s):
    """Columns a line occupies: ASCII 1, tab 1 (the echo convention), CJK 2."""
    w = 0
    for ch in s:
        o = ord(ch)
        if o == 9:
            w += 1
        elif o < 0x80:
            w += 1
        elif 0x1100 <= o <= 0x115F or 0x2E80 <= o <= 0xA4CF or \
                0xAC00 <= o <= 0xD7A3 or 0xF900 <= o <= 0xFAFF or \
                0xFE30 <= o <= 0xFE4F or 0xFF00 <= o <= 0xFF60 or \
                0xFFE0 <= o <= 0xFFE6:
            w += 2
        else:
            w += 1
    return w


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
        return None, ((p.stdout.decode('utf-8', 'replace').splitlines() or
                       ['build failed'])[-1])[:160]
    return out, ''


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_mdiag_')
    try:
        write(os.path.join(work, 'err.c'), SRC_ERR)
        write(os.path.join(work, 'cjk.c'), SRC_CJK)
        write(os.path.join(work, 'eof.c'), SRC_EOF)
        write(os.path.join(work, 'warn.c'), SRC_WARN)

        OBJ = ['-target', 'arm', '--cpu', 'Cortex-M7', '-O1', '-c']

        # --- 1. modern header, framed echo, caret column --------------------
        rc, log = run(arkcc, OBJ + ['err.c', '--diag_style=modern', '-o', 't.o'],
                      work)
        out = lines(log)
        check(rc == 1, 'the bad file still fails (rc=1)', 'rc=%d' % rc)
        check(len(out) >= 4, 'modern prints header + echo + caret + summary',
              '%d lines' % len(out))
        check(out[0] == 'err.c:4:9: error: identifier "y" is undefined [#20]',
              'modern header has the clang shape and keeps the armcc code',
              out[0] if out else '')
        check(out[1] == '    4 | \treturn y + x;',
              'the echo line is framed by a right-aligned 5-column number',
              out[1] if len(out) > 1 else '')
        caret = out[2] if len(out) > 2 else ''
        check(caret.startswith('      | ') and caret.endswith('^'),
              'the caret line repeats a blank 5-column gutter', caret)
        if caret.startswith('      | '):
            pad = caret[len('      | '):-1]
            src = out[1][len('    4 | '):]
            want = display_width(src[:src.index('y')])
            check(display_width(pad) == want,
                  'the caret sits under the token (tab counts one column)',
                  'caret col %d, token col %d' % (display_width(pad), want))
        check(out[3] == '1 error generated.',
              'the summary counts what it printed', out[3] if len(out) > 3 else '')
        check('0 warnings' not in log, 'a zero count is never spelled out')

        # --- 2. CJK: the caret is offset by display width, not byte count ---
        rc, log = run(arkcc, OBJ + ['cjk.c', '--diag_style=modern', '-o', 't.o'],
                      work)
        out = lines(log)
        ok = len(out) >= 3 and out[0].endswith('[#20]') and out[2].endswith('^')
        if ok:
            src = out[1][len('    3 | '):]
            pad = out[2][len('      | '):-1]
            want = display_width(src[:src.index('w')])
            ok = display_width(pad) == want
            detail = 'caret col %d, token col %d' % (display_width(pad), want)
        else:
            detail = out[0] if out else ''
        check(ok, 'a CJK prefix widens the caret by two columns per character',
              detail)

        # --- 3. the armcc styles are untouched ------------------------------
        rc, log = run(arkcc, OBJ + ['err.c', '-o', 't.o'], work)
        out = lines(log)
        check(rc == 1, 'default style still fails', 'rc=%d' % rc)
        check(out[0] == '"err.c", line 4: Error:  #20: identifier "y" is undefined',
              'default (arm) header is byte-identical to armcc', out[0])
        check(out[1] == '  \treturn y + x;',
              'arm echo keeps its two-space gutter', out[1] if len(out) > 1 else '')
        check(out[-2].endswith('1 error') and 'generated.' not in log,
              'arm summary keeps the "N warnings, M errors" line',
              out[-2] if len(out) > 1 else '')
        check('[#20]' not in log and 'error:' not in log,
              'no modern fragment leaks into the arm style')
        check('note:' not in log, 'no note leaks into the arm style')

        rc, log = run(arkcc, OBJ + ['err.c', '--diag_style=ide', '-o', 't.o'],
                      work)
        out = lines(log)
        check(out[0] == 'err.c(4,9) : error  #20: identifier "y" is undefined',
              'ide style is still the one-line clickable form', out[0])
        check(len([x for x in out if x]) == 2,
              'ide still prints no echo block and no caret',
              '%d non-empty lines' % len([x for x in out if x]))

        # --- 4. spelling, alias, invalid value, last-wins -------------------
        rc1, log1 = run(arkcc, OBJ + ['err.c', '--diag_style', 'modern',
                                      '-o', 't.o'], work)
        check(rc1 == 1 and lines(log1)[0].startswith('err.c:4:9: error:'),
              'the space-separated spelling works too',
              lines(log1)[0] if log1 else '')
        rc2, log2 = run(arkcc, OBJ + ['err.c', '--diag_style=clang',
                                      '-o', 't.o'], work)
        check(rc2 == 1 and lines(log2)[0].startswith('err.c:4:9: error:'),
              '"clang" is an alias for modern',
              lines(log2)[0] if log2 else '')

        bad = run(arkcc, ['--diag_style=modern', '--diag_style=bogus'], work)
        check(bad[0] == 1 and 'C3903U' in bad[1] and 'bogus' in bad[1],
              'an unknown style is still refused with C3903U', bad[1].strip())
        check('arkcc: fatal error:' in bad[1] and 'diag_style' in bad[1],
              'the refusal itself is printed in modern',
              bad[1].strip().splitlines()[0] if bad[1].strip() else '')

        sticky = run(arkcc, OBJ + ['err.c', '--diag_style=modern',
                                   '--diag_style=arm', '-o', 't.o'], work)
        check(sticky[0] == 1 and
              lines(sticky[1])[0].startswith('"err.c", line 4:'),
              'the last --diag_style on the command line wins',
              lines(sticky[1])[0] if sticky[1] else '')

        # --- 5. note: modern only ------------------------------------------
        note = run(arkcc, ['--diag_style=modern', '-targt', 'arm'], work)
        nlines = [x for x in lines(note[1]) if x]
        check(note[0] == 1 and nlines and
              nlines[0].startswith('arkcc: fatal error:') and
              '[C3900U]' in nlines[0],
              'a driver diagnostic is prefixed with the tool name in modern',
              nlines[0] if nlines else '')
        check(len(nlines) > 1 and nlines[1].startswith('note: run arkcc --help'),
              'modern adds the note line', nlines[1] if len(nlines) > 1 else '')
        no_note = run(arkcc, ['-targt', 'arm'], work)
        check(no_note[0] == 1 and 'note:' not in no_note[1],
              'the same bad option prints no note in the arm style',
              no_note[1].strip())

        # --- 6. end of source: no "At end of source", no echo --------------
        rc, log = run(arkcc, OBJ + ['eof.c', '--diag_style=modern', '-o', 't.o'],
                      work)
        out = [x for x in lines(log) if x]
        check(rc == 1 and len(out) == 2,
              'modern prints exactly one line plus the summary for EOF',
              '%d lines' % len(out))
        check(out and out[0].startswith('eof.c:') and ': error: ' in out[0],
              'the EOF diagnostic keeps a file:line anchor', out[0] if out else '')
        check('At end of source' not in log,
              'armcc\'s "At end of source" wording is not used in modern')
        rc, log = run(arkcc, OBJ + ['eof.c', '-o', 't.o'], work)
        check('At end of source' in log,
              'the arm style still says "At end of source" (it did not move)')

        # --- 7. a warning keeps its wording, and counts in the summary -----
        rc, log = run(arkcc, OBJ + ['warn.c', '--warn-unused-static',
                                    '--diag_style=modern', '-o', 't.o'], work)
        out = [x for x in lines(log) if x]
        check(rc == 0, 'the warning file compiles', 'rc=%d' % rc)
        check(out and out[0].startswith('warn.c:1: warning: ') and
              'never used' in out[0],
              'a warning uses the lowercase modern word', out[0] if out else '')
        check(out and out[-1] == '1 warning generated.',
              'the summary spells a lone warning out', out[-1] if out else '')

        # --- 8. --errors sink carries the same shape -----------------------
        rc, log = run(arkcc, OBJ + ['err.c', '--diag_style=modern',
                                    '--errors', 'mod.err', '-o', 't.o'], work)
        sink_path = os.path.join(work, 'mod.err')
        ok = rc == 1 and os.path.exists(sink_path)
        if ok:
            with open(sink_path, 'r', encoding='utf-8', newline='') as f:
                sink = f.read()
            ok = ('err.c:4:9: error: identifier "y" is undefined [#20]' in sink
                  and '| ' in sink and '1 error generated.' in sink)
        check(ok, '--errors receives the modern stream unchanged',
              'rc=%d' % rc)

        # --- 9. anti-false-green: cropped build still links and still refuses
        trimmed, why = build_arkcc(work, ['-DARKCC_FEATURE_DIAG=0'],
                                   'arkcc_nodiag')
        if trimmed is None:
            skip('cropped build (-DARKCC_FEATURE_DIAG=0)', why)
        else:
            rc, log = run(trimmed, ['--diag_style=modern', '-targt', 'arm'],
                          work)
            # With ARKCC_FEATURE_DIAG=0 the full layer is replaced by the
            # small fallback, so the wording differs on purpose; what must not
            # change is that the option is refused and the binary is not
            # missing diag_note.
            check(rc == 1 and 'Unrecognized option' in log,
                  'the cropped build links and still refuses the bad option',
                  'rc=%d  %s' % (rc, log.strip().splitlines()[0] if log.strip() else ''))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED%s' % (
            len(failures), (', %d skipped' % len(skips)) if skips else ''))
        for f in failures:
            print('  - ' + f)
        return 1
    print('\nall modern-diagnostic checks passed%s' % (
        (' (%d skipped)' % len(skips)) if skips else ''))
    return 0


if __name__ == '__main__':
    sys.exit(main())
