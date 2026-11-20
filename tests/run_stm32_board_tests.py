#!/usr/bin/env python3
"""On-board gate: run the whole arkcc feature surface on the STM32H743 itself.

The board runs arkcc as its own firmware, so a case here is compiled by the
same sources that the host gates build -- only the compiler *and* the target CPU
are different.  The firmware shell gives us exactly three primitives:

    put <name>    receive a text file into a RAM slot (terminated by @@EOF@@)
    run <file>    compile it, link it against crt.c, load it at 0x24070000 and
                  call its reset handler, printing `[arkcc] program returned N`
    opt <0|1|2>   the optimisation level used by both of the above

so the reading for a case is the value `main` returns, and the same source runs
at every optimisation level.  The expected values live in board_cases.py and
come from the x86-64 flat-image gate, where they were computed outside the
program under test -- the board is not allowed to grade itself.

What this gate refuses to do:

  * send a whole file in one blast.  Measured on this board: the shell echoes
    the command line through a blocking HAL_UART_Transmit while the rest of the
    burst keeps arriving, the 16-byte RX FIFO overruns and bytes are dropped.
    A 46-byte one-shot upload lost 32 bytes and stored a 14-byte file, and the
    failure looked like `run` doing nothing.  So the file body is paced in
    chunks and the command line is sent on its own, and every upload is
    confirmed by the board's own `[put] stored N bytes` line.
  * accept a partially stored file.  If the board reports a different byte
    count than the source it received, that is a failure, not a smaller test.
  * grade a case that never ran.  A missing `program returned` line is reported
    as an error even if the exit status of everything else looked fine.

Usage (COM3 must be free; the mdkdebug serial monitor holds it, so stop that
first -- `serial_monitor_stop`):

    python tests/run_stm32_board_tests.py --port COM3
    python tests/run_stm32_board_tests.py --only struct_sret24 --opt 0
"""
import argparse
import os
import re
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, 'stm32_board'))
from board_cases import CASES                                  # noqa: E402

PROMPT = 'arkcc> '
SLOT_NAME = 't.c'          # one slot, overwritten every case: 8 slots on board
STREAM_CHUNK = 96          # bytes per write while the shell is in put mode


class BoardError(Exception):
    pass

def fnv1a32(data):
    h = 2166136261
    for byte in data:
        h = ((h ^ byte) * 16777619) & 0xFFFFFFFF
    return h


class Board(object):
    def __init__(self, port, baud, verbose=False):
        import serial
        self.ser = serial.Serial(port, baud, timeout=0.02)
        self.buf = ''
        self.verbose = verbose

    # ---- raw io ----------------------------------------------------------
    def _pump(self):
        n = self.ser.in_waiting
        if n:
            self.buf += self.ser.read(n).decode('utf-8', 'replace')
        # keep the buffer bounded: only the tail can still match a pattern
        if len(self.buf) > 200000:
            self.buf = self.buf[-100000:]

    def mark(self):
        self._pump()
        return len(self.buf)

    def since(self, mark):
        self._pump()
        return self.buf[mark:]

    def write(self, data):
        self.ser.write(data.encode('utf-8'))
        self.ser.flush()

    def wait(self, pattern, timeout, mark=None, fail_on=None):
        """Return the match (or None) and the text seen, within `timeout` s."""
        rx = re.compile(pattern)
        dead = re.compile(fail_on) if fail_on else None
        end = time.time() + timeout
        base = self.mark() if mark is None else mark
        while True:
            text = self.since(base)
            m = rx.search(text)
            if m:
                return m, text
            if dead is not None and dead.search(text):
                return None, text
            if time.time() > end:
                return None, text
            time.sleep(0.01)

    def close(self):
        try:
            self.ser.close()
        except Exception:                                      # noqa: BLE001
            pass

    # ---- shell commands --------------------------------------------------
    def sync(self, timeout=5.0):
        """Wait for the shell prompt; a bare newline flushes any half line."""
        m, _ = self.wait(re.escape(PROMPT), timeout)
        if m:
            return
        self.write('\n')
        m, _ = self.wait(re.escape(PROMPT), timeout)
        if not m:
            raise BoardError('no shell prompt on the port; is the firmware '
                             'running and is the port the right one?')

    def command(self, line):
        self.write(line + '\n')

    def command_checked(self, line, pattern, timeout=6.0, tries=4, what=None):
        """Send a shell line and insist on the reply it must produce.

        Measured on this board: a command line that arrives while the shell is
        still transmitting the previous reply can lose bytes in the 16-byte RX
        FIFO, and the board then answers `Unknown command` (or the line is
        swallowed entirely).  That is a wire problem, not a compiler result, so
        it must never be graded as a failure: resync and send the line again.
        """
        label = what or line
        for attempt in range(tries):
            self.sync()
            time.sleep(0.05)
            mark = self.mark()
            self.command(line)
            m, seen = self.wait(pattern, timeout, mark=mark,
                                fail_on=r'Unknown command|^\s*Error:')
            if m:
                return m
            time.sleep(0.15)
        raise BoardError('%r did not answer %r in %d attempts' %
                         (label, pattern, tries))

    def file_sum(self, name, timeout=10.0):
        """(size, fnv1a32) of the board's copy, from the `sum` command."""
        pat = r'\[sum\] ' + re.escape(name) + r' size=(\d+) fnv=0x([0-9a-fA-F]{8})'
        m = self.command_checked('sum ' + name, pat, timeout=timeout)
        return int(m.group(1)), int(m.group(2), 16)

    def put(self, name, text, timeout=20.0):
        body = text.replace('\r\n', '\n').replace('\r', '\n')
        if not body.endswith('\n'):
            body += '\n'
        self.command('put ' + name)
        m, seen = self.wait(r'end with @@EOF@@', 5.0)
        if not m:
            raise BoardError('put %r was not accepted: %r' % (name, seen[-300:]))
        i = 0
        while i < len(body):
            j = min(i + STREAM_CHUNK, len(body))
            cut = body.rfind('\n', i, j)
            if cut < 0 or cut == i:
                cut = j - 1
            self.write(body[i:cut + 1])
            i = cut + 1
            time.sleep(0.01)
        self.write('@@EOF@@\n')
        m, seen = self.wait(r'\[put\] stored (\d+) bytes', timeout,
                           fail_on=r'\[put\] refused')
        if not m:
            raise BoardError('put %r did not store: %r' % (name, seen[-300:]))
        stored = int(m.group(1))
        # the board appends CRLF per line and keeps whatever the host sent, so
        # the count is the number of body bytes it received plus one CRLF per
        # line; anything smaller means bytes were dropped on the wire.
        lines = body.count('\n')
        want_min = len(body) + lines          # one LF becomes CRLF per line
        if stored < want_min:
            raise BoardError('put %r stored %d bytes, source needs %d: the '
                             'upload lost data' % (name, stored, want_min))
        return stored

    def put_verified(self, name, text, timeout=60.0):
        """put, then prove the board holds exactly those bytes.

        The byte count alone cannot catch a duplicated chunk, and `cat` stops
        at a 4 KB console buffer, so a mangled 12 KB source could be compiled
        and then graded as a compiler answer.  `sum` hashes the slot on the
        board; the upload is accepted only when size and hash both match.
        The shell stores one CRLF per input line, so both spellings are tried.
        """
        body = text.replace('\r\n', '\n').replace('\r', '\n')
        if not body.endswith('\n'):
            body += '\n'
        variants = [body.replace('\n', '\r\n').encode('utf-8'),
                    body.encode('utf-8')]
        for attempt in range(3):
            self.put(name, text, timeout)
            size, h = self.file_sum(name)
            for v in variants:
                if size == len(v) and h == fnv1a32(v):
                    return
        raise BoardError('put %r did not survive the sum check (board size=%d '
                         'fnv=0x%08x)' % (name, size, h))

    def run(self, name, timeout=60.0):
        """Compile + link + execute <name>; returns (value, output_text).

        The mark is taken *before* the command is sent: the image line and the
        return line can both arrive inside one read, and a window opened after
        the command would drop the value that came with them.
        """
        mark = self.mark()
        self.command('run ' + name)
        # The trailing CRLF belongs to the pattern.  The port hands the number
        # over in pieces, so `-?\d+` alone matches the moment the first digit
        # lands and grades a truncated value: measured, 2 of 162 runs came back
        # as 1 instead of 11 (struct_copy16 -O1) and 6 instead of 68
        # (signed_div -O2), and both passed when re-run on their own.  Waiting
        # for the newline the shell prints right after put_int_dec() means the
        # value is complete before it can be graded.
        m, seen = self.wait(r'\[arkcc\] program returned (-?\d+)\r?\n', timeout, mark=mark,
                            fail_on=r'compile failed|link failed|vector table '
                                    r'looks wrong|Unknown command|^\s*Error:')
        if not m:
            raise BoardError('run %r printed no return value: %r'
                             % (name, seen[-600:]))
        between = seen.split('--- program output')[1] if '--- program output' in seen else ''
        return int(m.group(1)), between


REPO = os.path.dirname(HERE)
AEABI_SRC = [('aeabi.c', os.path.join(REPO, 'stdlib', 'src', 'arm', 'aeabi.c')),
             ('aeabi_divmod.s',
              os.path.join(REPO, 'stdlib', 'src', 'arm', 'aeabi_divmod.s'))]

# Headers a case may #include.  The board's filesystem is a RAM disk, so a
# header is only reachable once it has been uploaded -- `fs_read_file()` is the
# preprocessor's only lookup path.  <stdarg.h> is uploaded because the varargs
# case has to compile the *real* header: a hand-written va_list in the test
# would stop exercising the part users depend on.  The compiler's own copy is
# 9.8 KB, which is why PP_INC_BUF for the STM32 profile had to grow to 16 KB
# (an 8 KB include buffer refused it as "larger than the include buffer").
HEADER_SRC = [('stdarg.h', os.path.join(REPO, 'stdlib', 'include', 'stdarg.h'))]

def reset_board(target='stm32h743xx', timeout=90.0):
    """Reset the MCU through the debug probe and let it run again.

    This is the only way back when the shell stops answering mid-run, and it
    is deliberately *not* done through the console: a dead shell cannot read
    a command.  A Cortex-M soft reset leaves SDRAM untouched, so the RAM disk
    survives -- but the harness re-installs crt.c / app.sct and the AEABI
    objects anyway, because "the disk survived" is an assumption and a case
    graded against a half-reinstalled disk would be a wrong answer.
    """
    cmd = [sys.executable, '-m', 'pyocd', 'commander', '-t', target,
           '-c', 'reset', '-c', 'go']
    env = dict(os.environ)
    env.pop('PYTHONPATH', None)
    env.pop('PYTHONHOME', None)
    # cwd matters: `python -m pyocd` imports stdlib modules by name, and a
    # stray cmd.py / pdb.py in the caller's working directory shadows them
    # (measured: "module 'cmd' has no attribute 'Cmd'" only when the gate was
    # launched from a directory holding an unrelated cmd.py).
    proc = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout,
                          env=env, cwd=HERE)
    if 'Successfully resumed' not in (proc.stdout + proc.stderr):
        raise BoardError('board reset failed: %r'
                         % ((proc.stdout + proc.stderr).strip()[-300:]))


def install_runtime(board):
    """Upload the AEABI sources and let the firmware compile them into RAM.

    Skipping this makes every float/double case fail at link time with an
    unresolved __aeabi_* -- which is a real environment gap, not a compiler
    bug, so it is a hard failure here rather than a silent skip.
    """
    for name, path in HEADER_SRC + AEABI_SRC:
        if not os.path.exists(path):
            raise BoardError('missing runtime source %s' % path)
        with open(path, 'r', encoding='utf-8', newline='') as f:
            board.put_verified(name, f.read(), timeout=60.0)
    # The board prints what it found *in the object file* it just wrote, not
    # what it intended to build: `runtime ready: aeabi.o <size> B (<code> code,
    # <syms> syms, <relocs> relocs, <text> text)`.  `text` counts .arktext
    # relocations.  Measured, same source: built without --reloc-text the object
    # is 12607 B / 26 syms / 0 relocs / 0 text and three double->64-bit cases
    # answer wrongly; with it, 12833 B / 27 syms / 11 relocs / 11 text and they
    # are correct.  So `text > 0` is the fact that has to be true here -- a
    # runtime that merely claims to be ready is exactly the state that produced
    # wrong answers before.
    m = board.command_checked(
        'runtime',
        r'\[arkcc\] runtime ready: aeabi\.o (\d+) B \((\d+) code, (\d+) syms, '
        r'(\d+) relocs, (\d+) text\) \+ aeabi_div\.o',
        timeout=180.0, what='runtime build')
    size, code, syms, relocs, text = (int(m.group(i)) for i in range(1, 6))
    if text <= 0:
        raise BoardError('aeabi.o on the board has %d .arktext relocations '
                         '(%d B, %d syms, %d relocs): it was built without '
                         '--reloc-text, so its constant-pool addresses point '
                         'at 0x08000000' % (text, size, syms, relocs))
    print('[board] runtime built on board: aeabi.o %d B (%d code, %d syms, '
          '%d relocs, %d .arktext) + aeabi_div.o'
          % (size, code, syms, relocs, text))


def bring_back(port, baud):
    """Reset the MCU and rebuild the board-side test environment on it."""
    reset_board()
    board = Board(port, baud)
    board.sync(timeout=20.0)
    board.command_checked('demo', r'Now run: build', timeout=15.0,
                          what='demo (reinstall after reset)')
    install_runtime(board)
    return board


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--port', default='COM3')
    ap.add_argument('--baud', type=int, default=115200)
    ap.add_argument('--opt', default='0,1,2')
    ap.add_argument('--only', default='')
    ap.add_argument('--timeout', type=float, default=60.0)
    ap.add_argument('--no-selfcheck', action='store_true')
    args = ap.parse_args()

    opts = [int(x) for x in args.opt.split(',') if x != '']
    cases = CASES
    if args.only:
        want = set(x.strip() for x in args.only.split(',') if x.strip())
        cases = [c for c in CASES if c[0] in want]
        missing = want - set(c[0] for c in cases)
        if missing:
            print('no such case: %s' % ', '.join(sorted(missing)))
            return 2

    board = Board(args.port, args.baud)
    failed = []
    started = time.time()
    try:
        board.sync()
        print('[board] %s @ %d, %d cases x %d opt levels'
              % (args.port, args.baud, len(cases), len(opts)))
        m = board.command_checked('version', r'Ark C Compiler v[0-9.]+', timeout=5.0)
        seen = ''
        print('[board] firmware: %s' % (m.group(0) if m else 'version not read'))

        # demo installs crt.c + app.sct; `run` refuses without them.  It also
        # clears the RAM slots, so it must come before the first put.
        board.command_checked('demo', r'Now run: build', timeout=10.0,
                              what="demo (installs crt.c + app.sct)")

        # The AEABI helpers are the one thing the board cannot get from the
        # firmware: a compiled image at 0x24070000 is self-contained, so
        # __aeabi_* can only exist if it is linked *into* that image.  The
        # firmware compiles them itself from the same sources the host gate
        # uses (stdlib/src/arm), so there is one copy of the truth.
        install_runtime(board)

        for lvl in opts:
            board.command_checked('opt %d' % lvl, r'opt level: %d' % lvl,
                                  timeout=5.0)
            print('\n[board] ===== -O%d =====' % lvl)
            for name, src, expect, about in cases:
                t0 = time.time()
                got = None
                for attempt in range(2):
                    try:
                        board.put_verified(SLOT_NAME, src, timeout=20.0)
                        got, _ = board.run(SLOT_NAME, args.timeout)
                        break
                    except BoardError as exc:
                        if attempt:
                            print('FAIL %-24s O%d  %s' % (name, lvl, exc))
                            failed.append((name, lvl, str(exc)))
                            break
                        # A quiet shell is the wire or a dead shell, never a
                        # compiler answer: the 16-byte RX FIFO can swallow a
                        # `put` header (the board then waits for @@EOF@@
                        # forever) and a test image that faults on the M7 can
                        # leave the shell dead.  Reset over the probe, rebuild
                        # the environment and give the case exactly one more
                        # try; the note makes the retry visible, so a case that
                        # needed one is never upgraded silently.
                        print('[board] note: %s\n[board] note: resetting the '
                              'board and re-running %s O%d once'
                              % (exc, name, lvl))
                        try:
                            board.close()
                            board = bring_back(args.port, args.baud)
                            board.command_checked('opt %d' % lvl,
                                                  r'opt level: %d' % lvl,
                                                  timeout=5.0)
                        except BoardError as rexc:
                            print('FAIL %-24s O%d  board did not come back: %s'
                                  % (name, lvl, rexc))
                            failed.append((name, lvl, 'board lost: %s' % rexc))
                            raise
                if got is None:
                    continue
                dt = time.time() - t0
                if got == expect:
                    print('PASS %-24s O%d  returned %d  (%.1fs)'
                          % (name, lvl, got, dt))
                else:
                    print('FAIL %-24s O%d  returned %d expect %d  (%.1fs)  [%s]'
                          % (name, lvl, got, expect, dt, about))
                    failed.append((name, lvl, 'returned %d expect %d'
                                   % (got, expect)))

        if not args.no_selfcheck and cases:
            # The harness has to be able to fail.  Re-run one case with an
            # expectation that is off by one and require it to be reported.
            name, src, expect, _ = cases[0]
            board.put_verified(SLOT_NAME, src, timeout=20.0)
            got, _ = board.run(SLOT_NAME, args.timeout)
            if got == expect + 1:
                print('\nFAIL selfcheck: harness accepted a wrong expectation')
                failed.append((name, opts[0], 'selfcheck'))
            else:
                print('\nPASS selfcheck: an expectation of %d was rejected '
                      '(the real value is %d)' % (expect + 1, got))
    except BoardError as exc:
        print('[board] ERROR: %s' % exc)
        failed.append(('<harness>', -1, str(exc)))
    finally:
        board.close()

    total = len(cases) * len(opts)
    print('\n[board] %d/%d case-runs passed in %.1fs'
          % (total - len([f for f in failed if f[0] != '<harness>']), total,
             time.time() - started))
    if failed:
        print('[board] FAILURES:')
        for name, lvl, why in failed:
            print('  %-24s -O%d  %s' % (name, lvl, why))
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
