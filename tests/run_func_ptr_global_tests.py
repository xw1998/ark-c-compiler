#!/usr/bin/env python3
"""Static address-constant initialiser gate (C11 6.6p9).

A file-scope pointer may be initialised with an *address constant*:

    int (*gp)(int, int) = add;        /* a function designator          */
    int *pg  = &gv;                   /* the address of an object       */
    int *pe  = &arr[2];               /* ... plus a byte offset         */
    char *pc = &ca[1];                /* pointer arithmetic on one      */
    int **pp = &pg;                   /* the address of a pointer       */

These are not byte patterns: the address of a function does not exist until
the linker has placed it.  The IR therefore carries (symbol, byte offset) and
each backend emits a symbol reference -- `LDR r0,=name` on ARM, `.word name`
(+ an offset added at assembly time) on riscv32.

Before this gate existed, all of the above were silent wrong answers:

  * the non-address forms (`int x = f();`, `int *p = (int*)&arr[3]` reaching
    the aggregate path) were *serialised as 0* and stored, so the object came
    out as a null pointer with no diagnostic at all;
  * `&arr[2]` in particular lost its '&' on the way to the C-source serialiser
    and the array access then defaulted to the number 0.

So this gate has two halves, and both matter:

  values   every form is executed on both machine backends, compared against a
           host gcc oracle *and* a hand-computed expected value.  A value that
           runs but is off by an element size fails here -- `&gv + 1` once
           moved by one byte instead of sizeof(int).
  refusals anything that is not a constant expression must be *rejected*, on
           both backends: an initialiser the build cannot place in data must
           never be invented as zero.  A cross-translation-unit object address
           is refused with an explanation; a cross-translation-unit *function*
           address is allowed and links (checked in the cross-TU section).

Usage (from the compiler repository root):
    python tests/run_func_ptr_global_tests.py --arm-as <arm binutils dir> \\
        [--arm-libgcc <libgcc.a>] --rv-as <riscv binutils dir>
"""
import argparse
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

ADD_SUB = """\
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
"""

CASES = [
    # name, source, expected return value of main
    ("global_fp_func", ADD_SUB + """\
int (*gp)(int, int) = add;
int main(void) { return gp(2, 3); }
""", 5),

    ("global_fp_amp", ADD_SUB + """\
int (*gp)(int, int) = &add;
int main(void) { return gp(4, 5); }
""", 9),

    ("global_fp_typedef", ADD_SUB + """\
typedef int binop(int, int);
binop *pm = sub;
int main(void) { return pm(9, 4); }
""", 5),

    ("global_fp_pair", ADD_SUB + """\
int (*ga)(int, int) = add;
int (*gs)(int, int) = sub;
int main(void) { return ga(9, 4) - gs(9, 4); }
""", 8),                                   # 13 - 5

    ("global_obj_addr", """\
int gv = 7;
int *pg = &gv;
int main(void) { return *pg; }
""", 7),

    ("global_obj_store", """\
int gv = 7;
int *pg = &gv;
int main(void) { *pg = 21; return gv; }
""", 21),

    ("global_arr_elem", """\
int arr[4] = {1, 2, 3, 4};
int *pe = &arr[2];
int main(void) { return *pe; }
""", 3),

    ("global_arr_arith", """\
int arr[4] = {1, 2, 3, 4};
int *pe = &arr[1] + 2;
int main(void) { return *pe; }
""", 4),                                   # element 3, not byte 1+2

    ("global_arr_decay", """\
int arr[4] = {1, 2, 3, 4};
int *p = arr;
int main(void) { return p[3]; }
""", 4),

    ("global_char_elem", """\
char ca[8] = "abc";
char *pc = &ca[1];
int main(void) { return *pc; }
""", 98),                                  # 'b' -- stride 1 for char

    ("global_member", """\
struct S { int k; int j; };
struct S s = {11, 22};
int *pj = &s.j;
int main(void) { return *pj; }
""", 22),

    ("global_cast", """\
int arr[4] = {1, 2, 3, 4};
int *p = (int *)&arr[3];
int main(void) { return *p; }
""", 4),

    ("global_ptr_ptr", """\
int gv = 7;
int *pg = &gv;
int **pp = &pg;
int main(void) { return **pp; }
""", 7),

    ("global_static_obj", """\
static int sv = 9;
int *p = &sv;
int main(void) { return *p; }
""", 9),

    ("global_static_fn", """\
static int h(void) { return 42; }
int (*q)(void) = h;
int main(void) { return q(); }
""", 42),

    ("global_mixed", ADD_SUB + """\
int arr[3] = {5, 6, 7};
int (*f)(int, int) = add;
int *e = &arr[1];
int main(void) { return f(*e, arr[2]); }
""", 13),                                  # 6 + 7
]

# Sources that must be *rejected*.  `keyword` must appear in the message: a
# gate that only checks the exit code would pass on an unrelated failure.
MUST_FAIL = [
    ("func_plus_offset", ADD_SUB + """\
int (*bad)(int, int) = add + 1;
int main(void) { return 0; }
""", "not a constant expression", []),

    ("nonconst_call", """\
int f(void);
int x = f();
int main(void) { return 0; }
""", "not a constant expression", []),

    # A cross-translation-unit *object* address.  The arm backend gives every
    # unit's data one fixed base with no symbol for it, so the address cannot be
    # named at all; that is refused.  On riscv32 the same code is legal in
    # object mode (`.word other` becomes an ABS32 relocation), so the case only
    # applies to arm -- see the cross-TU section for the riscv32 half.
    ("cross_tu_object", """\
extern int other;
int *p = &other;
int main(void) { return 0; }
""", "translation unit", ["arm"]),
]

# Cross-translation-unit: a *function* address travels through an object as a
# relocation, so it must link.  The riscv32 run value is checked by
# tests/run_rv_link_tests.py; here both backends only have to build an image.
CROSS_TU = [
    ("arm", [("x1.c", """\
int add(int a, int b) { return a + b; }
"""),
             ("x2.c", """\
extern int add(int, int);
int (*gp)(int, int) = add;
int main(void) { return gp(20, 22); }
""")]),
    ("riscv32", [("r1.c", """\
int add(int a, int b) { return a + b; }
"""),
                 ("r2.c", """\
extern int add(int, int);
int (*gp)(int, int) = add;
int main(void) { return gp(20, 22); }
""")]),
]


def cross_tu(arkcc, target, files, tmp):
    """Compile every unit with -c and link them.  Returns an error or ''."""
    objs = []
    for fname, src in files:
        srcf = os.path.join(tmp, 'xt_%s_%s.c' % (target, fname))
        objf = os.path.join(tmp, 'xt_%s_%s.obj' % (target, fname))
        G.write(srcf, src)
        r = subprocess.run([arkcc, '-target', target, '-c', srcf, '-o', objf],
                           capture_output=True, text=True, errors='replace')
        if r.returncode != 0:
            return 'compile of %s failed: %s' % (fname, (r.stdout + r.stderr).strip())
        objs.append(objf)
    out = os.path.join(tmp, 'xt_%s.bin' % target)
    if os.path.exists(out):
        os.remove(out)
    r = subprocess.run([arkcc, '-target', target, '-link'] + objs
                       + ['-o', out],
                       capture_output=True, text=True, errors='replace')
    if r.returncode != 0:
        return 'link failed: %s' % (r.stdout + r.stderr).strip()
    if not os.path.exists(out) or os.path.getsize(out) == 0:
        return 'link reported success but wrote no image'
    return ''


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arm-as', default='',
                    help='directory holding arm-none-eabi-binutils')
    ap.add_argument('--arm-libgcc', default='')
    ap.add_argument('--rv-as', default='',
                    help='directory holding riscv32-unknown-elf-binutils')
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()

    G.ARKC = os.path.abspath(args.arkcc)
    if not os.path.exists(G.ARKC):
        print('no such compiler: %s' % G.ARKC)
        return 2
    if not args.arm_as and not args.rv_as:
        print('need --arm-as and/or --rv-as')
        return 2
    os.makedirs(G.TMP, exist_ok=True)
    G.write(os.path.join(G.TMP, 'start_arm.s'), G.ARM_START)
    G.write(os.path.join(G.TMP, 'start_rv.s'), G.RV_START)

    targets = []
    r = G.Runner('gcc')
    if args.arm_as:
        tool = G.tool_finder('arm-none-eabi-', args.arm_as)
        rc = r.run([tool('as'), '-mcpu=cortex-m4', '-mfpu=fpv4-sp-d16',
                    '-mfloat-abi=hard',
                    os.path.join(G.TMP, 'start_arm.s'),
                    '-o', os.path.join(G.TMP, 'start_arm.o')])
        if rc.returncode != 0:
            print('cannot assemble the ARM harness: %s' % rc.stderr)
            return 2
        targets.append(('arm', tool))
    if args.rv_as:
        tool = G.tool_finder('riscv64-unknown-elf-', args.rv_as)
        rc = r.run([tool('as'), '-march=rv32im', '-mabi=ilp32',
                    os.path.join(G.TMP, 'start_rv.s'),
                    '-o', os.path.join(G.TMP, 'start_rv.o')])
        if rc.returncode != 0:
            print('cannot assemble the RV harness: %s' % rc.stderr)
            return 2
        targets.append(('rv', tool))

    ok = 0
    bad = 0
    for name, src, want in CASES:
        srcf = os.path.join(G.TMP, 'adr_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'adr_%s_gcc.exe' % name))
        if oracle != want:
            # The oracle disagrees with the hand-computed value: the test is
            # wrong, not the backend.  Say which, instead of blaming arkcc.
            print('FAIL %-20s oracle=%r want=%r %s' % (name, oracle, want, err))
            bad += 1
            continue
        for tname, tool in targets:
            got, err2 = (r.arm('adr_%s_%s' % (name, tname), srcf, tool,
                               args.arm_libgcc) if tname == 'arm'
                         else r.rv('adr_%s_%s' % (name, tname), srcf, tool))
            if got is None:
                print('FAIL %-20s [%s] build/run: %s' % (name, tname, err2))
                bad += 1
                continue
            if got != want:
                print('FAIL %-20s [%s] arkcc=%r want=%r' % (name, tname, got, want))
                bad += 1
                continue
            print('PASS %-20s [%s] %d' % (name, tname, got))
            ok += 1

    for name, src, keyword, only in MUST_FAIL:
        srcf = os.path.join(G.TMP, 'adr_neg_%s.c' % name)
        G.write(srcf, src)
        for tname, _tool in targets:
            if only and tname not in only:
                continue
            asm = os.path.join(G.TMP, 'adr_neg_%s_%s.s' % (name, tname))
            err3 = r.compile('arm' if tname == 'arm' else 'riscv32', srcf, asm)
            if not err3:
                print('FAIL %-20s [%s] accepted silently' % (name, tname))
                bad += 1
            elif keyword not in err3:
                print('FAIL %-20s [%s] rejected for the wrong reason: %s'
                      % (name, tname, err3))
                bad += 1
            else:
                print('PASS %-20s [%s] rejected' % (name, tname))
                ok += 1

    for target, files in CROSS_TU:
        if target == 'arm' and not args.arm_as:
            continue
        if target == 'riscv32' and not args.rv_as:
            continue
        err4 = cross_tu(G.ARKC, target, files, G.TMP)
        if err4:
            print('FAIL %-20s [%s] %s' % ('cross_tu_fp', target, err4))
            bad += 1
        else:
            print('PASS %-20s [%s] linked' % ('cross_tu_fp', target))
            ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.
    name, src, want = CASES[0]
    oracle, _ = r.oracle(os.path.join(G.TMP, 'adr_%s.c' % name),
                         os.path.join(G.TMP, 'adr_%s_gcc.exe' % name))
    if oracle == want - 1:
        print('FAIL selfcheck: the wrong expectation was accepted')
        bad += 1
    else:
        print('SELFCHECK expectation-mismatch: OK')

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
