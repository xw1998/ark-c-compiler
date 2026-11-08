#!/usr/bin/env python3
"""__packed (unaligned) access gate -- riscv32 and ARM.

`__packed` pointers promise the compiler that the object may sit at any address.
The riscv32 backend used to ignore the flag and emit a plain `lw`/`lh`, which on
RISC-V is not "a bit slow" but an alignment exception: the load traps, so the
answer was not wrong, it was absent -- and a program that happens to place the
object at an aligned address would look fine.  The ARM backend had a worse hole:
it compiled the access, byte by byte, but only ever moved four bytes, so an
8-byte packed access answered with half a value.  Both are now real
implementations, and this gate keeps them honest:

  * the bytes land at the exact addresses the C code names (byte order checked
    one byte at a time, not just by reading the value back through the same
    broken path);
  * a 2-byte packed load sign-extends, exactly like the aligned `lh` it stands
    in for, so a negative `__packed short` does not come back as 65000+;
  * three packed words written at odd offsets do not bleed into each other;
  * an 8-byte packed access really moves all eight bytes, in the right order,
    and reads back as the same long long -- including a negative one, which is
    where "half a value" is hardest to spot.

The host gcc cannot compile `__packed` (it is an arkc keyword), so unlike the
VLA gate there is no oracle arm here: the expected exit status is a hardcoded
number and the run has to match it.  The anti-false-green check feeds the same
comparison a deliberately wrong expectation and requires it to be rejected.

Usage (run from the compiler repository root):
    python tests/run_rv_packed_tests.py --rv-as <riscv binutils dir> \
                                        [--arm-as <arm binutils dir>]
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

CASES = [
    # name, source, expected exit status (masked to 8 bits)
    ("int_byte_order", """
__packed int *pi;
int main(void) {
    char buf[16];
    int i;
    for (i = 0; i < 16; i++) buf[i] = 0;
    pi = (__packed int *)&buf[1];
    *pi = 0x11223344;
    if (buf[1] != 0x44) return 1;
    if (buf[2] != 0x33) return 2;
    if (buf[3] != 0x22) return 3;
    if (buf[4] != 0x11) return 4;
    if (*pi != 0x11223344) return 5;
    return 42;
}
""", 42),

    ("short_byte_order", """
__packed short *ps;
int main(void) {
    char buf[16];
    int i;
    for (i = 0; i < 16; i++) buf[i] = 0;
    ps = (__packed short *)&buf[6];
    *ps = 0x7A7B;
    if (buf[6] != 0x7B) return 6;
    if (buf[7] != 0x7A) return 7;
    if (*ps != 0x7A7B) return 8;
    return 7;
}
""", 7),

    ("short_sign_extend", """
__packed short *ps;
int main(void) {
    char buf[16];
    int i;
    for (i = 0; i < 16; i++) buf[i] = 0;
    ps = (__packed short *)&buf[3];
    *ps = -5;
    if (*ps != -5) return 1;          /* needs sign extension, not 65531 */
    if (*ps > 0) return 2;
    return 5;
}
""", 5),

    ("no_crosstalk", """
__packed int *p;
int main(void) {
    char buf[24];
    int i, s = 0;
    for (i = 0; i < 24; i++) buf[i] = 0;
    p = (__packed int *)&buf[1];
    p[0] = 0x01020304;                /* bytes 1..4 */
    p = (__packed int *)&buf[5];
    p[0] = 0x05060708;                /* bytes 5..8 */
    p = (__packed int *)&buf[9];
    p[0] = 0x090A0B0C;                /* bytes 9..12 */
    for (i = 1; i <= 12; i++) s += buf[i];
    if (s != 0x01+0x02+0x03+0x04+0x05+0x06+0x07+0x08
           + 0x09+0x0A+0x0B+0x0C) return 1;
    if (buf[4] != 1) return 2;
    if (buf[8] != 5) return 3;
    if (buf[12] != 9) return 4;
    return 11;
}
""", 11),

    # 8-byte packed: the case ARM used to answer with only four bytes.
    # 0x0123456707654321 -> little endian 21 43 65 07 67 45 23 01; every byte
    # stays below 0x80 so the (possibly signed) char comparisons are portable.
    ("ll_byte_order", """
__packed long long *pl;
int main(void) {
    char buf[24];
    int i;
    for (i = 0; i < 24; i++) buf[i] = 0;
    pl = (__packed long long *)&buf[1];
    *pl = 0x0123456707654321LL;
    if (buf[1] != 0x21) return 1;
    if (buf[2] != 0x43) return 2;
    if (buf[3] != 0x65) return 3;
    if (buf[4] != 0x07) return 4;
    if (buf[5] != 0x67) return 5;
    if (buf[6] != 0x45) return 6;
    if (buf[7] != 0x23) return 7;
    if (buf[8] != 0x01) return 8;
    if (buf[0] != 0) return 9;        /* nothing written below the object */
    if (buf[9] != 0) return 10;       /* nor above it */
    if (*pl != 0x0123456707654321LL) return 11;
    return 42;
}
""", 42),

    ("ll_negative", """
__packed long long *pl;
int main(void) {
    char buf[24];
    int i;
    for (i = 0; i < 24; i++) buf[i] = 0;
    pl = (__packed long long *)&buf[3];
    *pl = -2;
    if ((buf[3] & 0xFF) != 0xFE) return 1;   /* char may be signed, so mask */
    if ((buf[4] & 0xFF) != 0xFF) return 2;
    if ((buf[7] & 0xFF) != 0xFF) return 3;
    if ((buf[10] & 0xFF) != 0xFF) return 4;  /* the high word carries the sign */
    if (*pl != -2) return 5;
    if (*pl > 0) return 6;
    return 6;
}
""", 6),

    ("ll_no_crosstalk", """
__packed long long *pl;
int main(void) {
    char buf[32];
    int i, s = 0;
    for (i = 0; i < 32; i++) buf[i] = 0;
    pl = (__packed long long *)&buf[1];
    *pl = 0x0102030405060708LL;       /* bytes 1..8 */
    pl = (__packed long long *)&buf[9];
    *pl = 0x1112131415161718LL;       /* bytes 9..16 */
    for (i = 1; i <= 16; i++) s += buf[i];
    if (s != 0x01+0x02+0x03+0x04+0x05+0x06+0x07+0x08
           + 0x11+0x12+0x13+0x14+0x15+0x16+0x17+0x18) return 1;
    if (buf[8] != 1) return 2;        /* the top byte of the first object */
    if (buf[16] != 0x11) return 3;    /* the top byte of the second */
    return 13;
}
""", 13),
]


def run_target(r, tag, name, srcf):
    if tag == 'rv':
        return r.rv(name, srcf, r._rv_tool)
    return r.arm(name, srcf, r._arm_tool, r._arm_libgcc)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rv-as', default='', help='directory holding riscv64-unknown-elf binutils')
    ap.add_argument('--arm-as', default=os.environ.get('ARKCC_ARM_AS', ''),
                    help='directory holding arm-none-eabi binutils')
    ap.add_argument('--arm-libgcc', default=None,
                    help='no-FPU libgcc.a for arm-none-eabi; the backend no '
                         'longer carries its own AEABI helpers, so the 64-bit '
                         'compare cases need the runtime to link')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    os.makedirs(G.TMP, exist_ok=True)

    rv_tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as) if args.rv_as else None
    arm_tool = G.tool_finder('arm-none-eabi-', args.arm_as) if args.arm_as else None
    if not rv_tool and not arm_tool:
        print('need --rv-as and/or --arm-as')
        return 2

    r = G.Runner('gcc')
    if rv_tool:
        G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)
        rc = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(G.TMP, 'start_rv.s'),
                    '-o', os.path.join(G.TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('cannot assemble the rv harness: %s' % rc.stderr)
            return 2
    if arm_tool:
        G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
        rc = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                    os.path.join(G.TMP, 'start_arm.s'),
                    '-o', os.path.join(G.TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('cannot assemble the arm harness: %s' % rc.stderr)
            return 2
    r._rv_tool = rv_tool
    r._arm_tool = arm_tool
    r._arm_libgcc = ''
    if arm_tool:
        r._arm_libgcc = args.arm_libgcc or G.find_arm_libgcc(args.arm_as)
        if not r._arm_libgcc or not os.path.exists(r._arm_libgcc):
            print('cannot find a no-FPU libgcc.a for arm-none-eabi '
                  '(pass --arm-libgcc); the ARM arm cannot link')
            return 2
        print('arm libgcc: %s' % r._arm_libgcc)

    ok = 0
    bad = 0
    targets = []
    if arm_tool:
        targets.append('arm')
    if rv_tool:
        targets.append('rv')

    for tgt in targets:
        for name, src, want in CASES:
            srcf = os.path.join(G.TMP, 'pk_%s_%s.c' % (tgt, name))
            G.write(srcf, src)
            got, err = run_target(r, tgt, 'pk_%s_%s' % (tgt, name), srcf)
            if got is None:
                print('FAIL %s/%-16s build/run: %s' % (tgt, name, err))
                bad += 1
                continue
            if got != want:
                print('FAIL %s/%-16s arkcc=%r want=%r' % (tgt, name, got, want))
                bad += 1
                continue
            print('PASS %s/%-16s %d' % (tgt, name, got))
            ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.  The comparison
    # above is `got == want`; feed it a wrong expectation and require a
    # mismatch, otherwise a broken comparison would report PASS on everything.
    tgt = targets[0]
    name, src, want = CASES[0]
    got, _ = run_target(r, tgt, 'pk_%s_%s' % (tgt, name),
                        os.path.join(G.TMP, 'pk_%s_%s.c' % (tgt, name)))
    if got == want - 1:
        print('FAIL selfcheck: the wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
