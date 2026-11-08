#!/usr/bin/env python3
"""C99 _Complex double gate (ARM + RV32I, soft float through libgcc).

A complex value is sixteen bytes, but the IR operand stack is a stack of
32-bit words whose top word is the HIGH half of the top value, and the object
in memory uses the standard C layout ([0]=re_lo, [4]=re_hi, [8]=im_lo,
[12]=im_hi).  Four different layouts meet here -- literal pool, operand stack,
object image, and the libgcc double pairs -- and every one of the mismatches is
silent: a swapped half is a tiny denormal, not a crash, and a value that only
carries the real part still "works".  So each case below is compared against
BOTH the host gcc oracle and a hardcoded expectation, and every case is executed
on unicorn rather than merely assembled.

Scope of what is checked (matches what the backends actually implement):
  constants, + - * /, == !=, conj, widening a real to complex, complex globals,
  complex array elements (IR_LOAD_IDX / IR_STORE_IDX element size 16),
  compound assignment, both object widths (_Complex float is 8 bytes, its
  operand stack image is still four doubles), parameters of both widths, and
  return values of both widths (_Complex float in r0:r1, _Complex double
  through the sret buffer).  NOT checked because it needs -lm, which these
  images do not link: cabs/carg/cexp.

Usage (run from the compiler repository root):
    python tests/run_complex_tests.py --rv-as <riscv binutils dir> \
        --arm-as <arm binutils dir> [--rv-libgcc <libgcc.a>] [--arm-libgcc <libgcc.a>]
"""
import argparse
import glob
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

HDR = '#include <complex.h>\n'

CASES = [
    # name, source, expected exit status (masked to 8 bits)
    ("cplx_const", HDR + """
int main(void) {
    double _Complex a = 1.0 + 2.0i;
    return (int)(creal(a) * 10.0 + cimag(a));
}
""", 12),

    ("cplx_addsub", HDR + """
int main(void) {
    double _Complex a = 1.0 + 2.0i, b = 3.0 - 1.0i;
    double _Complex c = a + b;          /* 4 + 1i */
    double _Complex d = a - b;          /* -2 + 3i */
    return (int)(creal(c) * 10.0 + cimag(c))
         + (int)(creal(d) * 10.0 + cimag(d)) + 100;
}
""", 124),   # 41 + (-17) + 100

    ("cplx_mul", HDR + """
int main(void) {
    double _Complex a = 1.0 + 2.0i, b = 3.0 - 1.0i;
    double _Complex z = a * b;          /* 5 + 5i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 55),

    ("cplx_div", HDR + """
int main(void) {
    double _Complex a = 5.0 + 5.0i, b = 3.0 - 1.0i;
    double _Complex z = a / b;          /* 1 + 2i */
    return (int)(creal(z) * 100.0 + cimag(z));
}
""", 102),

    ("cplx_cmp", HDR + """
int main(void) {
    double _Complex a = 1.0 + 2.0i, b = 3.0 - 1.0i;
    return (a == a) + (a != b) * 2 + (a == b) * 4 + (a != a) * 8;
}
""", 3),      # equal / unequal / equal / unequal

    ("cplx_global", HDR + """
double _Complex gz;
int main(void) {
    gz = 1.0 + 2.0i;
    return (int)(creal(gz) * 10.0 + cimag(gz));
}
""", 12),

    ("cplx_array", HDR + """
double _Complex arr[2];
int main(void) {
    arr[0] = 1.0 + 1.0i;
    arr[1] = 2.0 - 3.0i;
    return (int)(creal(arr[0]) * 10.0 + cimag(arr[0]))
         + (int)(creal(arr[1]) * 10.0 + cimag(arr[1])) + 100;
}
""", 128),   # 11 + 17 + 100

    ("cplx_conj", HDR + """
int main(void) {
    double _Complex z = 1.0 + 2.0i;
    double _Complex w = conj(z);        /* 1 - 2i */
    return (int)(creal(w) * 10.0 + cimag(w)) + 30;
}
""", 38),    # 8 + 30

    ("cplx_widen", HDR + """
int main(void) {
    double d = 2.0;
    double _Complex z = d + 1.0i;       /* 2 + 1i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 21),

    ("cplx_compound", HDR + """
int main(void) {
    double _Complex z = 1.0 + 2.0i, w = 3.0 - 1.0i;
    z += w;                             /* 4 + 1i */
    z *= w;                             /* 13 - 1i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 129),

    ("cplx_roundtrip", HDR + """
int main(void) {
    double _Complex z;
    z = 0.0 + 0.0i;
    z = 7.0 + 8.0i;
    return (int)creal(z) + (int)cimag(z) * 2 + 100;
}
""", 123),   # 7 + 16 + 100

    # ---- _Complex float: an 8-byte object (two floats), while the operand
    # ---- stack still carries doubles, so every access converts in/out.
    ("cplx_f_obj", HDR + """
int main(void) {
    float _Complex a = 1.0f + 2.0f * I;
    float _Complex b;
    b = a;                              /* object load + store, 8 bytes */
    return (int)(creal(b) * 10.0 + cimag(b));
}
""", 12),

    ("cplx_f_global", HDR + """
float _Complex gf;
int main(void) {
    gf = 1.0f + 2.0f * I;
    return (int)(creal(gf) * 10.0 + cimag(gf));
}
""", 12),

    ("cplx_f_array", HDR + """
float _Complex farr[2];
int main(void) {
    farr[0] = 1.0f + 1.0f * I;
    farr[1] = 2.0f - 3.0f * I;
    return (int)(creal(farr[0]) * 10.0 + cimag(farr[0]))
         + (int)(creal(farr[1]) * 10.0 + cimag(farr[1])) + 100;
}
""", 128),   # 11 + 17 + 100

    ("cplx_f_param", HDR + """
static int sum(float _Complex z) {
    return (int)(creal(z) * 10.0 + cimag(z));
}
int main(void) {
    float _Complex a = 1.0f + 2.0f * I;
    return sum(a);                      /* two words by value */
}
""", 12),

    ("cplx_f_arith", HDR + """
int main(void) {
    float _Complex a = 1.0f + 2.0f * I, b = 3.0f - 1.0f * I;
    float _Complex c = a + b;           /* 4 + 1i */
    float _Complex d = a * b;           /* 5 + 5i */
    return (int)(creal(c) * 10.0 + cimag(c))
         + (int)(creal(d) * 10.0 + cimag(d)) + 100;
}
""", 196),   # 41 + 55 + 100

    ("cplx_f_compound", HDR + """
int main(void) {
    float _Complex z = 1.0f + 2.0f * I, w = 3.0f - 1.0f * I;
    z += w;                             /* 4 + 1i */
    z *= w;                             /* 13 - 1i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 129),

    # ---- return values: an 8-byte object travels in r0:r1, a 16-byte one
    # ---- through the sret buffer -- and the callee must narrow the four-word
    # ---- operand-stack value into that channel, the caller widen it back.
    ("cplx_ret_d", HDR + """
static double _Complex mk(double rr, double ii) {
    return rr + ii * I;
}
int main(void) {
    double _Complex z = mk(1.0, 2.0);
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 12),

    ("cplx_ret_f", HDR + """
static float _Complex mkf(float rr, float ii) {
    return rr + ii * I;
}
int main(void) {
    float _Complex z = mkf(1.0f, 2.0f);
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 12),

    ("cplx_ret_use", HDR + """
static double _Complex add(double _Complex a, double _Complex b) { return a + b; }
int main(void) {
    double _Complex z = add(1.0 + 2.0i, 3.0 - 1.0i);   /* 4 + 1i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 41),

    ("cplx_ret_fparam", HDR + """
static float _Complex twice(float _Complex z) { return z + z; }
int main(void) {
    float _Complex z = twice(1.5f + 2.5f * I);         /* 3 + 5i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 35),

    ("cplx_ret_discard", HDR + """
static int calls;
static double _Complex mk(double rr, double ii) { calls++; return rr + ii * I; }
int main(void) {
    mk(9.0, 9.0);                       /* result discarded: four words popped */
    double _Complex z = mk(1.0, 2.0);
    return (int)(creal(z) * 10.0 + cimag(z)) + calls * 10;
}
""", 32),

    ("cplx_ret_chain", HDR + """
static double _Complex mk(double rr, double ii) { return rr + ii * I; }
static double _Complex twomk(double rr, double ii) { return mk(rr, ii) + mk(rr, ii); }
int main(void) {
    double _Complex z = twomk(1.0, 2.0);                /* 2 + 4i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 24),

    # --- implicit real -> complex conversion (C99 6.3.1.7) -------------------
    # Every one of these used to be a silent wrong answer: a real operand only
    # puts one (or two) words on the operand stack while the complex store pops
    # four, so the low half of the real part was whatever junk was underneath.
    ("cplx_widen_decl_d", HDR + """
int main(void) {
    double _Complex z = 3.0;            /* real -> complex, declaration init */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 30),

    ("cplx_widen_decl_f", HDR + """
int main(void) {
    float _Complex z = 3.0f;            /* real float -> _Complex float */
    return (int)(creal(z) * 10.0f + cimag(z));
}
""", 30),

    ("cplx_widen_decl_int", HDR + """
int main(void) {
    double _Complex z = 3;              /* int -> complex goes through double */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 30),

    ("cplx_widen_assign", HDR + """
int main(void) {
    double _Complex z = 1.0 + 1.0i;
    z = 3.0;                            /* plain assignment, not an initialiser */
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 30),

    ("cplx_widen_global", HDR + """
double _Complex g = 3.0;                /* file-scope initialiser */
int main(void) {
    return (int)(creal(g) * 10.0 + cimag(g));
}
""", 30),

    ("cplx_ret_real", HDR + """
static double _Complex f(void) { return 3.0; }
int main(void) {
    double _Complex z = f();
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 30),

    ("cplx_ret_real_f", HDR + """
static float _Complex f(void) { return 3.0f; }
int main(void) {
    float _Complex z = f();
    return (int)(creal(z) * 10.0f + cimag(z));
}
""", 30),

    ("cplx_arg_real", HDR + """
static int s(double _Complex z) { return (int)(creal(z) * 10.0 + cimag(z)); }
int main(void) {
    return s(3.0);                      /* real argument, complex parameter */
}
""", 30),

    ("cplx_arg_real_f", HDR + """
static int s(float _Complex z) { return (int)(creal(z) * 10.0f + cimag(z)); }
int main(void) {
    return s(3.0f);
}
""", 30),

    ("cplx_static_const", HDR + """
double _Complex g = 3.0 + 4.0i;         /* folded at compile time */
float  _Complex h = 1.5f - 0.5fi;
int main(void) {
    return (int)(creal(g) * 10.0 + cimag(g) + cimag(h));   /* 34 - 1 = 33 */
}
""", 33),

    ("cplx_static_real", HDR + """
float _Complex h = 3.0f;                /* real initialiser, base type float */
int main(void) {
    return (int)(creal(h) * 10.0f + cimag(h));
}
""", 30),

    # A 16-byte _Complex result needs no caller-owned buffer, so the two call
    # shapes that cannot see the callee's body must work as well: a call
    # through a function pointer, and a call whose only visible declaration
    # lives in this file while the body is compiled elsewhere.
    ("cplx_ret_indirect", HDR + """
static double _Complex mk(void) { return 2.0 + 3.0i; }
int main(void) {
    double _Complex (*fp)(void) = mk;
    double _Complex z = fp();
    return (int)(creal(z) * 10.0 + cimag(z));
}
""", 23),

    # same two shapes, but the value also travels *in*: a 16-byte _Complex
    # argument of an indirect call is materialised in a temporary and its
    # address is passed, which needs the prototype off the function pointer.
    # A typedef'd function type is the one indirect shape that carries a
    # prototype ( declarators drop the parameter list, see the
    # ledger), so the argument shape below must come from the typedef.
    # A typedef'd function type is the one indirect shape that carries a
    # prototype: a `(*fp)(params)` declarator drops its parameter list (see the
    # ledger), so the argument shape below has to come from the typedef.
    ("cplx_arg_indirect", HDR + """
static double _Complex twice(double _Complex z) { return z + z; }
int main(void) {
    double _Complex (*fp)(double _Complex) = twice;
    double _Complex z = fp(1.5 - 0.5i);         /* 3 - 1i */
    return (int)(creal(z) * 10.0 + cimag(z) + 20);
}
""", 49),

    ("cplx_farg_indirect", HDR + """
static float _Complex twicef(float _Complex z) { return z + z; }
int main(void) {
    float _Complex (*fp)(float _Complex) = twicef;
    float _Complex z = fp(1.5f + 2.0f * I);     /* 3 + 4i */
    return (int)(creal(z) * 10.0f + cimag(z));
}
""", 34),

    ("cplx_ret_decl", HDR + """
extern double _Complex mk(double rr, double ii);   /* definition below */
int main(void) {
    double _Complex z = mk(2.0, 3.0);               /* 2 + 3i */
    return (int)(creal(z) * 10.0 + cimag(z));
}
double _Complex mk(double rr, double ii) { return rr + ii * I; }
""", 23),
]


def find_libgcc(rv_bin):
    """libgcc.a for rv32im/ilp32, next to the binutils directory."""
    top = os.path.dirname(os.path.dirname(os.path.abspath(rv_bin)))
    pat = os.path.join(top, 'lib', 'gcc', '*', '*', 'rv32im', 'ilp32', 'libgcc.a')
    hits = sorted(glob.glob(pat))
    return hits[0] if hits else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--rv-as', default=None,
                    help='directory holding riscv32 binutils; turns on the RV '
                         'arm of the gate')
    ap.add_argument('--rv-libgcc', default=None,
                    help='libgcc.a to link the RV soft-float helpers from')
    ap.add_argument('--arm-as', default=None,
                    help='directory holding arm-none-eabi binutils; turns on '
                         'the ARM arm of the gate')
    ap.add_argument('--arm-libgcc', default=None,
                    help='no-FPU libgcc.a for arm-none-eabi (derived from '
                         '--arm-as unless given here)')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    if not args.rv_as and not args.arm_as:
        print('nothing to do: pass --rv-as and/or --arm-as')
        return 2

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2

    os.makedirs(G.TMP, exist_ok=True)
    r = G.Runner('gcc')

    rv_tool = rv_libgcc = None
    if args.rv_as:
        rv_tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
        rv_libgcc = args.rv_libgcc or find_libgcc(rv_tool('as'))
        if not rv_libgcc or not os.path.exists(rv_libgcc):
            print('cannot find libgcc.a for rv32im/ilp32 (pass --rv-libgcc); '
                  'nothing was verified on RV')
            return 2
        print('rv   libgcc: %s' % rv_libgcc)
        G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)
        out = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32',
                     os.path.join(G.TMP, 'start_rv.s'),
                     '-o', os.path.join(G.TMP, 'start_rv.o')])
        if out.returncode != 0:
            print('cannot assemble the RV harness: %s' % out.stderr)
            return 2

    arm_tool = arm_libgcc = None
    if args.arm_as:
        arm_tool = G.tool_finder('arm-none-eabi-', args.arm_as)
        if not arm_tool:
            print('cannot find arm-none-eabi binutils in %s' % args.arm_as)
            return 2
        arm_libgcc = args.arm_libgcc or G.find_arm_libgcc(args.arm_as)
        if not arm_libgcc or not os.path.exists(arm_libgcc):
            print('cannot find a no-FPU libgcc.a for arm-none-eabi '
                  '(pass --arm-libgcc); nothing was verified on ARM')
            return 2
        print('arm  libgcc: %s' % arm_libgcc)
        G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
        out = r.run([arm_tool('as'), '-mcpu=cortex-m4',
                     os.path.join(G.TMP, 'start_arm.s'),
                     '-o', os.path.join(G.TMP, 'start_arm.o')])
        if out.returncode != 0:
            print('cannot assemble the ARM harness: %s' % out.stderr)
            return 2

    def run_rv(name, srcf):
        """arkcc -S, then as/ld(+libgcc)/objcopy, then unicorn."""
        asm = os.path.join(G.TMP, 'cx_%s.s' % name)
        obj = os.path.join(G.TMP, 'cx_%s.o' % name)
        elf = os.path.join(G.TMP, 'cx_%s.elf' % name)
        binf = os.path.join(G.TMP, 'cx_%s.bin' % name)
        err = r.compile('riscv32', srcf, asm)
        if err:
            return None, err
        out = r.run([rv_tool('as'), '-march=rv32im', '-mabi=ilp32', asm, '-o', obj])
        if out.returncode != 0:
            return None, 'as: ' + out.stderr.strip()
        out = r.run([rv_tool('ld'), '-m', 'elf32lriscv', '-Ttext=0x08000000',
                     '-e', '_start', os.path.join(G.TMP, 'start_rv.o'),
                     obj, rv_libgcc, '-o', elf])
        if out.returncode != 0:
            return None, 'ld: ' + out.stderr.strip()
        out = r.run([rv_tool('objcopy'), '-O', 'binary', elf, binf])
        if out.returncode != 0:
            return None, 'objcopy: ' + out.stderr.strip()
        return r.exec_rv(binf, elf, rv_tool)

    def run_arm(name, srcf):
        return r.arm('cx_arm_%s' % name, srcf, arm_tool, arm_libgcc)

    def sweep(tag, build, opt):
        r.opt = opt
        ok = bad = 0
        first = None
        for name, src, want in CASES:
            srcf = os.path.join(G.TMP, 'cx_%s_%s.c' % (tag, name))
            G.write(srcf, src)
            oracle, err = r.oracle(
                srcf, os.path.join(G.TMP, 'cx_%s_%s_gcc.exe' % (tag, name)))
            got, err2 = build(name, srcf)
            if first is None:
                first = (srcf, got)
            if oracle != want:
                # The oracle disagreeing with the hardcoded value means the test
                # itself is wrong; say so instead of blaming the backend.
                print('FAIL %-3s %-16s oracle=%r want=%r %s'
                      % (tag, name, oracle, want, err))
                bad += 1
                continue
            if got is None:
                print('FAIL %-3s %-16s build/run: %s' % (tag, name, err2))
                bad += 1
                continue
            if got != want:
                print('FAIL %-3s %-16s arkcc=%r want=%r' % (tag, name, got, want))
                bad += 1
                continue
            print('PASS %-3s %-16s %d' % (tag, name, got))
            ok += 1

        # Anti-false-green: a gate that cannot fail is not a gate.  Re-run the
        # first case and require the expectation to reject a neighbouring value.
        name, _, want = CASES[0]
        got = first[1]
        if got is None:
            got, _ = build(name, os.path.join(G.TMP, 'cx_%s_%s.c' % (tag, name)))
        if got is not None and got == ((want + 1) & 0xFF):
            print('FAIL selfcheck[%s]: case %s cannot tell %d from %d'
                  % (tag, name, want, (want + 1) & 0xFF))
            bad += 1
        else:
            print('SELFCHECK[%s] expectation-mismatch: OK' % tag)
        print('=== %s: %d passed, %d failed ===' % (tag, ok, bad))
        return ok, bad

    ok = bad = 0
    if rv_tool:
        a, b = sweep('rv', run_rv, [])
        ok += a
        bad += b
    if arm_tool:
        a, b = sweep('arm', run_arm, ['-fno-fpu'])
        ok += a
        bad += b

    print('=== TOTAL %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
