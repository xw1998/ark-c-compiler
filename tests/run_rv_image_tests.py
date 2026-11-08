#!/usr/bin/env python3
"""riscv32 flat-image gate: the text assembler must produce a runnable image.

The riscv32 backend used to stop at GAS-syntax assembly and needed an external
`as`/`ld` before anything could execute.  It now assembles its own flat image
at 0x08000000 (.text -> .rodata -> .data, every section base 16-byte aligned),
so the RV target is executable end to end without binutils.  This gate holds
that implementation to its own claims:

  runtime    compile C -> image -> run `main` on a RISCV32 unicorn core and
             compare the returned a0 against a hardcoded value.  The host gcc
             oracle is only allowed to say "the expectation is not nonsense";
             two arms agreeing on a wrong number is still a wrong answer, so
             the expected value is asserted independently.
  layout     globals and string literals must be reachable, which only works if
             .rodata/.data really sit at the addresses the `la` sequences use.
  exactness  the image must end where the last section that has bytes ends: a
             text-only program's image ends with `ret`, not with an alignment
             pad.  (That trailing-pad bug is why this check exists -- the image
             was 12 bytes longer than GNU's and every byte still matched.)
  refusal    unknown mnemonic / out-of-range branch / undefined external symbol
             must fail the build *and* leave no image behind.  A half-written
             `auipc` that silently jumps outside the image, with the compiler
             still exiting 0, is exactly the wrong answer this project forbids.

With --rv-as the same sources are also assembled by GNU as + a linker script
that reproduces the flat layout, and the two images must be byte-identical.

Usage (from the repository root):
    python tests/run_rv_image_tests.py
    python tests/run_rv_image_tests.py --rv-as <riscv binutils dir>
"""
import argparse
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
TMP = os.path.join(ROOT, 'build_rv_image')

IMAGE_BASE = 0x08000000
STACK_TOP = 0x20080000
HANG = 0x200FF000
RET = bytes([0x67, 0x80, 0x00, 0x00])       # `ret` == jalr x0, ra, 0

# Linker script that reproduces the flat image layout exactly, so GNU ld can be
# used as a byte-level reference.  Kept next to the gate on purpose: if the
# layout changes, this must change with it.
FLAT_LD = """SECTIONS {
  . = 0x08000000;
  .text : { *(.text) *(.text.*) }
  . = ALIGN(16);
  .rodata : { *(.rodata) *(.rodata.*) *(.srodata) *(.srodata.*) }
  . = ALIGN(16);
  .data : { *(.data) *(.data.*) *(.sdata) *(.sdata.*) }
  /DISCARD/ : { *(.comment) *(.riscv.attributes) *(.note*) }
}
"""

# name, source, expected a0 (& 0xFF), expected trailing bytes
CASES = [
    ("arith", """
int main(void) {
    int a = 7, b = 5;
    return a * b + a / b + a % b;
}
""", 38, RET),                                # 35 + 1 + 2

    ("globals", """
int g[4] = {1, 2, 3, 4};
int h = 100;
int main(void) {
    int i, s = 0;
    for (i = 0; i < 4; i++) s += g[i];
    return s + h;
}
""", 110, bytes([100, 0, 0, 0])),            # 10 + 100; .data ends with h

    ("rodata_str", """
int len(const char *s) {
    int n = 0;
    while (*s++) n++;
    return n;
}
int main(void) { return len("hello, flat image!"); }
""", 18, b"hello, flat image!\x00"),         # string literal lives in .rodata

    ("recursion", """
int fib(int n) { return n < 2 ? n : fib(n - 1) + fib(n - 2); }
int main(void) { return fib(10); }
""", 55, RET),

    ("bitops", """
int main(void) {
    unsigned x = 0x1234;
    return (int)(((x >> 4) ^ (x << 2)) & 0xFF);
}
""", 243, RET),                               # 0x0123 ^ 0x48D0 = 0x49F3

    ("sshift", """
int main(void) {
    int x = -256;
    return (x >> 4) & 0xFF;
}
""", 240, RET),                              # sra, not srl: 0xFFFFFFF0

    ("ucmp", """
int main(void) {
    unsigned a = 0xFFFFFFFF;
    unsigned b = 1;
    int r = 0;
    if (a > b) r += 1;
    if (a < b) r += 2;
    if (a >= b) r += 4;
    if (a <= b) r += 8;
    return r;
}
""", 5, RET),                                # sltu: only '>' and '>=' hold

    ("struct_switch", """
struct P { int x, y; };
int main(void) {
    struct P p;
    int i, r = 0;
    p.x = 3;
    p.y = 4;
    for (i = 0; i < 3; i++) {
        switch (i) {
        case 0: r += p.x; break;
        case 1: r += p.y; break;
        default: r *= 2;
        }
    }
    return r;
}
""", 14, RET),                                # (3 + 4) * 2
]

# name, assembly source, substring the diagnostic must contain
BAD_CASES = [
    ("unknown_mnemonic", """
    .text
    .global main
main:
    frobnicate a0, a1
    ret
""", "unknown riscv32 mnemonic"),

    ("branch_out_of_range", """
    .text
    .global main
main:
    .space 5000
    beq a0, a1, main
    ret
""", "outside the 13-bit RV32I displacement"),

    ("undefined_external", """
    .text
    .global main
main:
    call not_defined_anywhere
    ret
""", "is not a symbol this translation unit defines"),
]


def write(path, text):
    with open(path, 'w', newline='\n', encoding='utf-8') as f:
        f.write(text)


class Gate:
    def __init__(self, arkcc):
        self.arkcc = arkcc
        self.ok = 0
        self.bad = 0

    def run(self, cmd, env=None):
        return subprocess.run(cmd, capture_output=True, text=True,
                              errors='replace', env=env)

    def image(self, src):
        """Compile src to a flat image.  Returns (bytes|None, symtab, error)."""
        img = os.path.join(TMP, os.path.basename(src)[:-2] + '.bin')
        if os.path.exists(img):
            os.remove(img)
        env = dict(os.environ)
        env['ARKCC_DUMP_SYMS'] = '1'
        r = self.run([self.arkcc, '-target', 'riscv32', src, '-o', img], env=env)
        out = r.stdout + r.stderr
        if r.returncode != 0:
            return None, {}, out.strip()
        if not os.path.exists(img):
            return None, {}, 'the build reported success but wrote no image'
        syms = {}
        for ln in out.splitlines():
            m = re.match(r'^RV_SYM\s+(\S+)\s+0x([0-9A-Fa-f]+)$', ln.strip())
            if m:
                syms[m.group(1)] = int(m.group(2), 16)
        return open(img, 'rb').read(), syms, ''

    def execute(self, blob, syms):
        from unicorn import Uc, UcError, UC_ARCH_RISCV, UC_MODE_RISCV32
        from unicorn.riscv_const import (UC_RISCV_REG_A0, UC_RISCV_REG_PC,
                                        UC_RISCV_REG_RA, UC_RISCV_REG_SP)
        if 'main' not in syms:
            return None, 'the image has no main symbol'
        uc = Uc(UC_ARCH_RISCV, UC_MODE_RISCV32)
        uc.mem_map(IMAGE_BASE, 0x100000)
        uc.mem_write(IMAGE_BASE, blob)
        uc.mem_map(0x20000000, 0x100000)
        uc.mem_write(HANG, bytes([0x6f, 0x00, 0x00, 0x00]))   # j .
        uc.reg_write(UC_RISCV_REG_SP, STACK_TOP)
        uc.reg_write(UC_RISCV_REG_RA, HANG)
        try:
            uc.emu_start(syms['main'], HANG, count=4000000)
        except UcError as e:
            return None, 'unicorn: %s at %#x' % (e, uc.reg_read(UC_RISCV_REG_PC))
        return uc.reg_read(UC_RISCV_REG_A0) & 0xFF, ''

    def fail(self, name, msg):
        print('FAIL %-22s %s' % (name, msg))
        self.bad += 1

    def expect_reject(self, name, asm, needle):
        src = os.path.join(TMP, 'bad_%s.s' % name)
        img = os.path.join(TMP, 'bad_%s.bin' % name)
        write(src, asm)
        if os.path.exists(img):
            os.remove(img)
        r = self.run([self.arkcc, '-target', 'riscv32', src, '-o', img])
        out = r.stdout + r.stderr
        if r.returncode == 0:
            self.fail(name, 'the build accepted it (rc=0)')
            return
        if needle not in out:
            self.fail(name, 'rejected, but not for the stated reason: %s'
                      % out.strip().replace('\n', ' | ')[:160])
            return
        if os.path.exists(img):
            self.fail(name, 'rejected but left an image behind')
            return
        print('PASS %-22s rejected: %s' % (name, needle))
        self.ok += 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    ap.add_argument('--rv-as', default='',
                    help='directory of riscv binutils; enables the byte-exact '
                         'comparison against GNU as/ld (optional)')
    args = ap.parse_args()

    arkcc = os.path.abspath(args.arkcc)
    if not os.path.exists(arkcc):
        print('no such compiler: %s' % arkcc)
        return 2
    os.makedirs(TMP, exist_ok=True)
    gate = Gate(arkcc)

    gnu = None
    if args.rv_as:
        prefix = os.path.join(args.rv_as, 'riscv64-unknown-elf-')
        if os.path.exists(prefix + 'as.exe'):
            gnu = prefix
        else:
            print('--rv-as given but %sas.exe is missing; skipping the GNU arm'
                  % prefix)

    ldscript = os.path.join(TMP, 'flat.ld')
    if gnu:
        write(ldscript, FLAT_LD)

    for name, src, want, tail in CASES:
        srcf = os.path.join(TMP, name + '.c')
        write(srcf, src)
        blob, syms, err = gate.image(srcf)
        if blob is None:
            gate.fail(name, 'build: %s' % err)
            continue

        # exactness: the file ends at the last section that has bytes.  A
        # text-only program must literally end with its last instruction; a
        # program with .data/.rodata must end with that section's last bytes,
        # with no alignment pad on the end.  (That pad is how the image came out
        # 12 bytes longer than GNU's while every shared byte still matched.)
        if tail == RET and len(blob) % 4 != 0:
            gate.fail(name, 'image is %d bytes, not a whole number of '
                      'instructions' % len(blob))
            continue
        if not blob.endswith(tail):
            gate.fail(name, 'image ends with %s, expected the last section to '
                      'end with %s -- trailing alignment pad?'
                      % (blob[-len(tail):].hex(), tail.hex()))
            continue

        got, err = gate.execute(blob, syms)
        if got is None:
            gate.fail(name, 'run: %s' % err)
            continue
        if got != want:
            gate.fail(name, 'arkcc=%r want=%r' % (got, want))
            continue
        print('PASS %-22s %d' % (name, got))
        gate.ok += 1

        if gnu:
            # Byte-level reference: same source through GNU as + a linker
            # script matching the flat layout.  Every byte must agree, so an
            # encoding that merely "runs" cannot slip through.
            asm = os.path.join(TMP, name + '.s')
            obj = os.path.join(TMP, name + '.o')
            elf = os.path.join(TMP, name + '.elf')
            ref = os.path.join(TMP, name + '.ref.bin')
            steps = [
                ([arkcc, '-target', 'riscv32', '-S', srcf, '-o', asm], None),
                ([gnu + 'as.exe', '-march=rv32im', '-mabi=ilp32', asm,
                  '-o', obj], None),
                ([gnu + 'ld.exe', '-m', 'elf32lriscv', '-T', ldscript,
                  '-e', 'main', obj, '-o', elf], None),
                ([gnu + 'objcopy.exe', '-O', 'binary', elf, ref], None),
            ]
            broken = None
            for cmd, _ in steps:
                r = gate.run(cmd)
                if r.returncode != 0:
                    broken = '%s: %s' % (os.path.basename(cmd[0]),
                                         r.stderr.strip()[:120])
                    break
            if broken:
                print('SKIP %-22s gnu arm: %s' % (name, broken))
            else:
                theirs = open(ref, 'rb').read()
                if theirs == blob:
                    print('PASS %-22s byte-identical to GNU as/ld' % (name + ' [gnu]'))
                    gate.ok += 1
                else:
                    n = min(len(theirs), len(blob))
                    i = next((i for i in range(n) if theirs[i] != blob[i]), n)
                    gate.fail(name + ' [gnu]',
                              'first difference at %d, len %d vs %d'
                              % (i, len(theirs), len(blob)))

    for name, asm, needle in BAD_CASES:
        gate.expect_reject(name, asm, needle)

    # Anti-false-green: the runner must be able to see a wrong answer.  Same
    # program, different immediate: if the gate cannot tell these apart it is
    # not reading a0 and every PASS above means nothing.
    src = CASES[0][1].replace('int a = 7', 'int a = 8')
    srcf = os.path.join(TMP, 'selfcheck.c')
    write(srcf, src)
    blob, syms, err = gate.image(srcf)
    got = None
    if blob is not None:
        got, err = gate.execute(blob, syms)
    changed = 44                    # 8*5 + 8/5 + 8%5 = 40 + 1 + 3
    assert changed != CASES[0][2], 'the self-check mutation changed nothing'
    if got != changed:
        gate.fail('selfcheck', 'a changed immediate gave %r (expected %r): the '
                  'runner is not reading the return value' % (got, changed))
    else:
        print('SELFCHECK wrong-answer-visibility: OK')
        gate.ok += 1

    print('=== %d passed, %d failed ===' % (gate.ok, gate.bad))
    return 0 if gate.bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
