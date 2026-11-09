#!/usr/bin/env python
"""--reloc-text gates: in-section absolute addresses must survive a link.

The defect this guards: codegen bakes `g_flash_base + offset` into a MOVW/MOVT
pair for every local label it takes the address of (a string literal is the
common case).  The linker is the first thing that knows where the object really
lands, and until 0.8.0 there was nothing in the object telling it what base the
object had assumed -- so a multi-object image whose objects sat anywhere other
than 0x08000000 read its string literals out of flash and printed garbage.

What is checked, and why each one is needed:

  1. descriptor -- with --reloc-text the object carries __arkcc_text_base;
                   without it, it must not (that is what makes the switch a
                   switch and keeps the default output byte-identical).
  2. object #0  -- its literal address equals image_base + offset.
  3. object #1  -- same, but this is the case that a global delta would pass
                   and a per-object delta is required for: object #1 is linked
                   after object #0, so its baked addresses are short by exactly
                   object #0's size.
  4. switch off -- the old, wrong address comes back (0x08000000 + offset),
                   i.e. the gate is measuring the feature and not an accident.
  5. layout     -- the image size is identical either way: the pass rewrites
                   immediates, it never moves anything.

Exit code 0 = all five behaved.  Host arkcc only, no toolchain needed.
Usage: run_reloc_text_tests.py [path-to-arkcc]
"""
import os
import shutil
import struct
import subprocess
import sys
import tempfile

IMAGE_BASE = 0x24070000
VECTOR_SIZE = 0x400          # what --vector-table reserves at the front
FLASH_DEFAULT = 0x08000000   # the base an object assumes with no --scatter

SRC_HELLO = r'''#include <unistd.h>

static const char msg[] = "hello, world\r\n";

int main(void);
int main(void)
{
    write(1, msg, sizeof(msg) - 1);
    write(1, "written by arkcc running on the STM32H743 itself\r\n",
          sizeof("written by arkcc running on the STM32H743 itself\r\n") - 1);
    return 0;
}
'''

SRC_CRT = r'''extern void __arkcc_init_globals(void);
extern int main(void);

#define ARK_PUTN_ADDR 0x2407F001u

int write(int fd, const void *buf, unsigned int len);
int write(int fd, const void *buf, unsigned int len)
{
    int (*putn)(const void *, unsigned int);
    (void)fd;
    putn = (int (*)(const void *, unsigned int))ARK_PUTN_ADDR;
    return putn(buf, len);
}

int say(const char *s, unsigned int n);
int say(const char *s, unsigned int n)
{
    return write(1, s, n);
}

int Reset_Handler(void);
int Reset_Handler(void)
{
    __arkcc_init_globals();
    say("runtime message from object #1\r\n",
        sizeof("runtime message from object #1\r\n") - 1);
    return main();
}
'''

SRC_UNISTD = 'int write(int fd, const void *buf, unsigned int len);\n'
# RESET is required because the objects are compiled with --vector-table: the
# compiler reserves 0x400 at the front for the table and refuses a layout that
# does not promise that region is the first thing in the image.
SRC_SCT = ('LR_APP 0x24070000 0x0000F000 {\n'
           '    ER_APP 0x24070000 0x0000F000 {\n'
           '        *(InRoot$$Sections)\n'
           '        *.o (RESET, +First)\n'
           '        .ANY (+RO)\n'
           '        .ANY (+RW +ZI)\n'
           '    }\n'
           '}\n')

LIT0 = b'written by arkcc running on the STM32H743 itself\r\n'
LIT1 = b'runtime message from object #1\r\n'

failures = []


def check(ok, what, detail=''):
    print('%s  %s%s' % ('PASS' if ok else 'FAIL', what,
                        ('  [' + detail + ']') if detail else ''))
    if not ok:
        failures.append(what)


def run(arkcc, args, cwd):
    p = subprocess.run([arkcc] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def mov_imm(hi, lo):
    """Decode a Thumb-2 MOVW/MOVT halfword pair.  None if it is neither."""
    if (hi & 0xFBF0) != 0xF240 and (hi & 0xFBF0) != 0xF2C0:
        return None
    is_movt = 1 if (hi & 0x0080) else 0
    rd = (lo >> 8) & 0xF
    imm = ((hi & 0xF) << 12) | (((hi >> 10) & 1) << 11) | \
          (((lo >> 12) & 7) << 8) | (lo & 0xFF)
    return is_movt, rd, imm


def addresses(img):
    """Every absolute value built by a MOVW + same-register MOVT pair."""
    out = []
    for off in range(0, len(img) - 7, 2):
        hi, lo = struct.unpack_from('<HH', img, off)
        d1 = mov_imm(hi, lo)
        if not d1 or d1[0]:
            continue
        hi2, lo2 = struct.unpack_from('<HH', img, off + 4)
        d2 = mov_imm(hi2, lo2)
        if not d2 or d2[0] != 1 or d2[1] != d1[1]:
            continue
        out.append((off, d1[2] | (d2[2] << 16)))
    return out


def build(arkcc, where, reloc_text, scatter=True):
    """Compile both objects and link them; return (obj0, obj1, image).

    The objects are compiled WITH the same --scatter as the link.  That is not
    a detail: arkc bakes the absolute .data/.bss and .rodata addresses into the
    instruction stream, so an object only knows the right addresses when it was
    compiled for the layout it will run at.  This gate used to compile at the
    default base (0x08000000 / 0x20000000) and link at the app window, which
    only looked fine because it never ran the image and the data base was not
    checked -- the linker now refuses that combination (see refuse() below).
    """
    flag = ['--reloc-text'] if reloc_text else []
    sflag = ['--scatter', 'app.sct'] if scatter else []
    common = ['-target', 'arm', '--cpu', 'Cortex-M7', '-I', '.']
    rc, log = run(arkcc, ['-c', 'hello.c', '-o', 'hello.o', '--vector-table'] +
                  common + sflag + flag, where)
    assert rc == 0, 'compile hello.c failed:\n' + log
    rc, log = run(arkcc, ['-c', 'crt.c', '-o', 'crt.o'] + common + sflag + flag,
                  where)
    assert rc == 0, 'compile crt.c failed:\n' + log
    rc, log = run(arkcc, ['-link', 'hello.o', 'crt.o', '-o', 'app.bin',
                          '--scatter', 'app.sct', '--vector-table'] + flag, where)
    assert rc == 0, 'link failed:\n' + log
    obj0 = open(os.path.join(where, 'hello.o'), 'rb').read()
    obj1 = open(os.path.join(where, 'crt.o'), 'rb').read()
    img = open(os.path.join(where, 'app.bin'), 'rb').read()
    return obj0, obj1, img


def refuse(arkcc, where):
    """Objects compiled against the default base must not link into an image
    for another layout: their .data/.bss addresses are stale and nothing can
    rewrite them.  Returns (rc, log) of that attempt."""
    common = ['-target', 'arm', '--cpu', 'Cortex-M7', '-I', '.']
    rc, log = run(arkcc, ['-c', 'hello.c', '-o', 'n0.o', '--vector-table'] +
                  common, where)
    assert rc == 0, 'compile hello.c (no scatter) failed:\n' + log
    rc, log = run(arkcc, ['-c', 'crt.c', '-o', 'n1.o'] + common, where)
    assert rc == 0, 'compile crt.c (no scatter) failed:\n' + log
    return run(arkcc, ['-link', 'n0.o', 'n1.o', '-o', 'bad.bin',
                       '--scatter', 'app.sct', '--vector-table'], where)


def literal_addrs(img):
    """Address of each literal, as the instruction stream actually holds it."""
    found = {}
    for name, lit in (('obj0', LIT0), ('obj1', LIT1)):
        at = img.find(lit)
        if at < 0:
            found[name] = None
            continue
        want = IMAGE_BASE + at
        got = [a for _, a in addresses(img) if a == want]
        if not got:                       # maybe it still points at the old base
            got = [a for _, a in addresses(img) if a == FLASH_DEFAULT + at]
        found[name] = got[0] if got else None
        found[name + '_at'] = at
    return found


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_reloctext_')
    try:
        for name, text in (('unistd.h', SRC_UNISTD), ('hello.c', SRC_HELLO),
                           ('crt.c', SRC_CRT), ('app.sct', SRC_SCT)):
            with open(os.path.join(work, name), 'w', newline='') as f:
                f.write(text)

        on0, on1, on_img = build(arkcc, work, True)
        off0, off1, off_img = build(arkcc, work, False)

        # 1. the descriptor is what makes the correction possible at all
        check(b'__arkcc_text_base' in on0, 'object carries __arkcc_text_base '
              'with --reloc-text')
        check(b'__arkcc_text_base' not in off0, 'object carries no descriptor '
              'without --reloc-text')

        # 2/3. both objects, because a global (rather than per-object) delta
        #      passes the first one and fails the second
        on = literal_addrs(on_img)
        expected0 = IMAGE_BASE + (on.get('obj0_at') or 0)
        expected1 = IMAGE_BASE + (on.get('obj1_at') or 0)
        check(on.get('obj0') == expected0, 'object #0 literal address corrected',
              '%.8X' % on['obj0'] if on.get('obj0') is not None else 'not found')
        check(on.get('obj1') == expected1, 'object #1 literal address corrected',
              '%.8X' % on['obj1'] if on.get('obj1') is not None else 'not found')

        # 4. switch off: object #1's literal still carries its compile-time
        #    address, i.e. it is short by object #0's size.  Object #0 sits
        #    exactly where it was compiled, so only #1 can show the difference
        #    (that is also why it is the interesting one).
        #     Compare the immediate at the *same instruction offset*: the code
        #     layout does not change, only the value baked into the pair, so
        #     this is the exact site object #1 uses to load its literal.
        on_pairs = {o: a for o, a in addresses(on_img)}
        off_pairs = {o: a for o, a in addresses(off_img)}
        sites = [o for o, a in on_pairs.items() if a == expected1]
        off_at = off_pairs.get(sites[0]) if len(sites) == 1 else None
        check(len(sites) == 1, 'object #1 literal address site is unique',
              '%d site(s)' % len(sites))
        check(off_at is not None and off_at != expected1,
              'without the flag object #1 keeps its stale address',
              '%.8X' % off_at if off_at is not None else 'not found')

        # 4b. and the linker refuses the combination that cannot be repaired:
        #     objects compiled at the default base, linked for the app window
        refuse_rc, refuse_log = refuse(arkcc, work)
        check(refuse_rc != 0 and 'puts .data/.bss at' in refuse_log,
              'link refuses objects compiled for another layout',
              (refuse_log.strip().splitlines() or [''])[-1][:90])

        # 5. the pass rewrites immediates, it does not move anything
        check(len(on_img) == len(off_img), 'image size unchanged by the pass',
              '%d vs %d' % (len(on_img), len(off_img)))

        # bonus: object #1 must start after object #0, otherwise test 3 was
        # checking the same thing twice
        check((on.get('obj1_at') or 0) > (on.get('obj0_at') or 0),
              'object #1 really is linked after object #0',
              '+0x%X vs +0x%X' % (on.get('obj1_at') or 0, on.get('obj0_at') or 0))
    finally:
        shutil.rmtree(work, ignore_errors=True)

    if failures:
        print('\n%d check(s) FAILED' % len(failures))
        return 1
    print('\nall --reloc-text checks passed')
    return 0


if __name__ == '__main__':
    sys.exit(main())
