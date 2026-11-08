#!/usr/bin/env python3
"""Address elements inside an aggregate initialiser (C11 6.6p9).

A file-scope aggregate may hold address constants:

    int (*tab[2])(int, int) = { add, sub };      /* function pointers     */
    int *pa[2]             = { &gv, &gv };       /* object pointers       */
    struct S s             = { 3, add, &gv };    /* mixed members         */
    struct S t[2]          = { {1, add}, {2, sub} };

None of these are byte patterns.  The address of a function does not exist
until the linker has placed it, so the initialiser cannot be flattened into
constants by the text-driven filler (src/agginit.c) alone: that filler walks
the *serialised text* and cannot tell `add` from a number.

The compiler therefore runs the initialiser through the AST twice:

  * src/irgen.c walks the AST and records (byte offset, symbol, addend) for
    every element that is an address constant -- `IrGlobal.init_refs`;
  * src/agginit.c still fills the bytes (types give the layout), and asks a
    backend hook about each element it cannot read as a number.  The hook
    answers from init_refs by offset.

Two independent derivations of the same layout, cross-checked by offset: the
filler writes zeros where the walk said "address", and the backend then stores
the symbol reference there.  If the two ever disagree about an offset the hook
misses, agginit refuses and the element is not silently written as zero.

This gate covers the value half (execute the bytes, on both machine backends),
the refusal half (forms whose element offsets cannot be placed must be
rejected with a message that says what to fix), and the encoding half (a
riscv32 image must carry a real `.word symbol` relocation, not a number).

Usage (from the compiler repository root):
    python tests/run_agg_addr_tests.py --arm-as <arm binutils dir> \
        [--arm-libgcc <libgcc.a>] --rv-as <riscv binutils dir>

Exit code: 0 = every case passed, 1 = a case failed, 2 = setup problem.
"""
import argparse
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(ROOT, 'examples'))
import run_va_gate as G  # noqa: E402

ADD_SUB = """\
int add(int a, int b) { return a + b; }
int sub(int a, int b) { return a - b; }
"""

CASES = [
    # name, source, expected return value of main()
    ("fp_array", ADD_SUB + """\
int (*tab[2])(int, int) = { add, sub };
int main(void) { return tab[0](20, 3) + tab[1](20, 3); }
""", 40),                                   # 23 + 17; add,add would give 46

    ("fp_array_static", """\
static int inc(int a) { return a + 1; }
static int dec(int a) { return a - 1; }
int (*tab[2])(int) = { inc, dec };
int main(void) { return tab[0](10) * 10 + tab[1](10); }
""", 119),                                  # 11 * 10 + 9

    ("ptr_array", """\
int gv = 7;
int *pa[2] = { &gv, &gv };
int main(void) { *pa[0] = 21; return gv + *pa[1]; }
""", 42),                                   # both entries name the same object

    ("ptr_array_offsets", """\
int arr[4] = {1, 2, 3, 4};
int *pe[2] = { &arr[1], &arr[2] + 1 };
int main(void) { return *pe[0] + *pe[1]; }
""", 6),                                    # 2 + 4 (element stride, not bytes)

    # An address element with a char stride (no literal involved).
    ("char_ptr_array", """\
char ca[8] = "abc";
char *cs[2] = { &ca[1], &ca[2] };
int main(void) { return cs[0][0] + cs[1][0]; }
""", 197),                                  # 'b' + 'c'

    ("struct_mixed", ADD_SUB + """\
int gv = 7;
struct S { int n; int (*fn)(int, int); int *p; };
struct S s = { 3, add, &gv };
int main(void) { return s.fn(4, 5) * 10 + s.n + *s.p; }
""", 100),                                  # 9 * 10 + 3 + 7

    ("struct_array", ADD_SUB + """\
struct C { int k; int (*fn)(int, int); };
struct C t[2] = { {1, add}, {2, sub} };
int main(void) { return t[0].fn(8, 2) + t[1].fn(8, 2) + t[1].k; }
""", 18),                                   # 10 + 6 + 2

    ("nested_braces", ADD_SUB + """\
int gv = 5;
struct S { int (*fn[2])(int, int); int *p; };
struct S s = { { add, sub }, &gv };
int main(void) { return s.fn[0](6, 1) + s.fn[1](6, 1) + *s.p; }
""", 17),                                   # 7 + 5 + 5

    ("ptr_array_ptr", """\
int gv = 9;
int *pg = &gv;
int **pp[2] = { &pg, &pg };
int main(void) { return **pp[0] + **pp[1]; }
""", 18),

    # The same shape *inside* a function: this does not go through
    # ark_agg_fill at all -- the block is built by element stores -- so it
    # pins the other half of the family (C99 6.7.9 applies to automatic
    # aggregates too).
    ("local_init", ADD_SUB + """\
int main(void) {
    int (*tab[2])(int, int) = { add, sub };
    return tab[0](7, 2) * 10 + tab[1](7, 2);
}
""", 95),                                   # 9 * 10 + 5

    ("local_2d", """\
int f(void) { return 1; }
int main(void) {
    int (*m[2][3])(void) = { { f, f, f }, { f, f, f } };
    return m[1][2]() + (int)sizeof(m);
}
""", 25),                                   # 1 + 24

    ("mixed_numbers", ADD_SUB + """\
int gv = 4;
int (*tab[2])(int, int) = { add, sub };
int nums[2] = { 10, 20 };
int main(void) { return tab[0](nums[0], nums[1]) + *&gv; }
""", 34),                                   # 30 + 4

    # A string literal element is an address too: the element holds the
    # address of a pooled literal, not its characters.  Each element needs its
    # own label, keyed by the element offset -- one label for the whole array
    # would make both entries point at the first string.
    ("str_ptr_array", """\
char *cs[2] = { "xy", "cd" };
int main(void) { return cs[0][0] + cs[1][0]; }
""", 219),                                  # 'x' + 'c'; one label gives 240

    ("str_struct_fn", ADD_SUB + """\
struct S { const char *n; int (*f)(int, int); };
struct S s = { "hi", add };
int main(void) { return s.n[0] + s.f(3, 4); }
""", 111),                                  # 'h' = 104, + 7

    ("str_ptr_2d", """\
char *t[2][2] = { {"a", "b"}, {"c", "d"} };
int main(void) { return t[0][0][0] + t[1][1][0]; }
""", 197),                                  # 'a' + 'd'

    # Literal elements and object elements in the same initialiser: the two
    # kinds of reference share one table, so this pins that they do not
    # overwrite each other's offsets.
    ("str_mixed_addr", """\
int g0 = 7;
const char *cs[3] = { "a", "b", "c" };
int *pa[2] = { &g0, &g0 };
int main(void) { return cs[1][0] + *pa[0] + (int)sizeof(cs); }
""", 117),                                  # 'b' = 98, + 7, + 12

    # --- designators: the same offsets, reached by "[k] = value" -------------
    # A designator used to be refused (it moved the element without moving the
    # cursor in lock step).  The AST walk now mirrors the filler's cursor
    # semantics, so the offset it records is the offset the filler asks about.
    ("ptr_designator", """\
int gv = 1;
int *pa[2] = { [1] = &gv };
int main(void) { return *pa[1]; }
""", 1),

    # A constant *expression*, not just a literal, and a gap the filler leaves
    # at its default: both elements of the gap must still be placed.
    ("ptr_designator_gap", """\
int gv = 1;
int *pa[4] = { [0] = &gv, [3] = &gv };
int main(void) { return *pa[0] + *pa[3] + (int)sizeof(pa); }
""", 18),                                   # 1 + 1 + 16

    ("ptr_designator_expr", """\
int gv = 4;
int *pa[3] = { [0 + 1] = &gv };
int main(void) { return *pa[1]; }
""", 4),

    ("str_designator", """\
char *cs[2] = { [1] = "x" };
int main(void) { return cs[1][0]; }
""", 120),                                  # 'x'

    # Field designators still have to land on the right member offsets.
    ("struct_designator", """\
int gv = 1;
struct S { int a; int *p; int b; };
struct S s = { .a = 3, .p = &gv, .b = 5 };
int main(void) { return s.a + *s.p + s.b; }
""", 9),                                    # 3 + 1 + 5

    # A union has exactly one live member, and that member may hold an address.
    ("union_ptr", """\
int gv = 1;
union U { int *p; long long v; };
union U u = { .p = &gv };
int main(void) { return *u.p; }
""", 1),
]

# Sources that must be *rejected*.  `keyword` must appear in the message: a
# gate that only checks the exit code would pass on an unrelated failure.
MUST_FAIL = [
    # Brace elision: the element offsets follow the flattened layout, which the
    # AST walk does not re-derive.  Refusing beats guessing an offset.
    ("brace_elision_struct", """\
int gv = 1;
struct T { int *p; int *q; };
struct T t[1] = { &gv, &gv };
int main(void) { return *t[0].p; }
""", "braces are not spelled out"),

    # An automatic object has no address at load time.
    ("local_element", """\
int gv = 1;
int main(void) { int local = 2; static int *pa[2] = { &local, &gv }; return *pa[1]; }
""", "not a constant expression"),

    # A function designator plus an offset is not an address constant.
    ("func_plus_offset", ADD_SUB + """\
int (*tab[2])(int, int) = { add + 1, sub };
int main(void) { return 0; }
""", "not a constant expression"),

    # A wide literal would have to be widened byte by byte; the initialiser
    # text does not carry that, so it is refused rather than stored narrow.
    ("wide_string_element", """\
char *cs[2] = { L"xy", "cd" };
int main(void) { return 0; }
""", "wide string literal"),

    # A union has exactly one live member (C99 6.7.8p10): two initialised
    # members is not "braces elided", it cannot be represented at all.
    ("union_two_members", """\
int gv = 1;
union U { int a; int *p; };
union U u = { .a = 1, .p = &gv };
int main(void) { return 0; }
""", "a union with more than one"),

    # A designator index must be an integer constant expression (C99 6.6p6).
    # This used to end in an error storm and "memory pool exhausted".
    ("designator_not_constant", """\
int i = 1;
int *pa[2] = { [i] = 0 };
int main(void) { return 0; }
""", "integer constant expression"),
]

# riscv32 keeps the symbol in the data section; a number there would be a
# silently wrong answer that still runs on the host oracle's terms.
RV_ASM_EXPECT = [
    ("fp_array", ADD_SUB + """\
int (*tab[2])(int, int) = { add, sub };
int main(void) { return tab[0](20, 3) + tab[1](20, 3); }
""", [".word add", ".word sub"]),
    # Both the pooled literals and the two distinct labels they are reached
    # through must be in the image: a folded number would run here and be
    # wrong on the board, and one shared label would silently alias them.
    ("str_ptr_array", """\
char *cs[2] = { "xy", "cd" };
int main(void) { return cs[0][0] + cs[1][0]; }
""", ['.asciz "xy"', '.asciz "cd"',
       ".word .Lgstr_cs_0", ".word .Lgstr_cs_4"]),
    # The label offset has to follow the designator: a walk that keeps its own
    # cursor (or an index that is read but not applied) would emit cs_0 here,
    # which still assembles and still runs -- and reads the wrong byte.
    ("str_designator", """\
char *cs[2] = { [1] = "x" };
int main(void) { return cs[1][0]; }
""", ['.asciz "x"', ".word .Lgstr_cs_4"]),
]


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
        srcf = os.path.join(G.TMP, 'agg_%s.c' % name)
        G.write(srcf, src)
        oracle, err = r.oracle(srcf, os.path.join(G.TMP, 'agg_%s_gcc.exe' % name))
        if oracle != want:
            # The oracle disagrees with the hand-computed value: the test is
            # wrong, not the backend.  Say which, instead of blaming arkcc.
            print('FAIL %-22s oracle=%r want=%r %s' % (name, oracle, want, err))
            bad += 1
            continue
        for tname, tool in targets:
            got, err2 = (r.arm('agg_%s_%s' % (name, tname), srcf, tool,
                               args.arm_libgcc) if tname == 'arm'
                         else r.rv('agg_%s_%s' % (name, tname), srcf, tool))
            if got is None:
                print('FAIL %-22s [%s] build/run: %s' % (name, tname, err2))
                bad += 1
                continue
            if got != want:
                print('FAIL %-22s [%s] arkcc=%r want=%r' % (name, tname, got, want))
                bad += 1
                continue
            print('PASS %-22s [%s] %d' % (name, tname, got))
            ok += 1

    for name, src, keyword in MUST_FAIL:
        srcf = os.path.join(G.TMP, 'agg_neg_%s.c' % name)
        G.write(srcf, src)
        for tname, _tool in targets:
            asm = os.path.join(G.TMP, 'agg_neg_%s_%s.s' % (name, tname))
            err3 = r.compile('arm' if tname == 'arm' else 'riscv32', srcf, asm)
            if not err3:
                print('FAIL %-22s [%s] accepted silently' % (name, tname))
                bad += 1
            elif keyword not in err3:
                print('FAIL %-22s [%s] rejected for the wrong reason: %s'
                      % (name, tname, err3))
                bad += 1
            else:
                print('PASS %-22s [%s] rejected' % (name, tname))
                ok += 1

    # Encoding: riscv32 must emit a symbol reference, not a folded number.
    if args.rv_as:
        for name, src, needles in RV_ASM_EXPECT:
            srcf = os.path.join(G.TMP, 'agg_asm_%s.c' % name)
            asm = os.path.join(G.TMP, 'agg_asm_%s.s' % name)
            G.write(srcf, src)
            err4 = r.compile('riscv32', srcf, asm)
            if err4:
                print('FAIL %-22s [rv asm] %s' % (name + '_refs', err4))
                bad += 1
                continue
            text = open(asm, 'r', errors='replace').read()
            missing = [n for n in needles if n not in text]
            if missing:
                print('FAIL %-22s [rv asm] missing %s' % (name + '_refs', missing))
                bad += 1
            else:
                print('PASS %-22s [rv asm] %s' % (name + '_refs', ' + '.join(needles)))
                ok += 1

    # Anti-false-green: a gate that cannot fail is not a gate.  For each case
    # below, take the answer a specific wrong implementation would produce and
    # confirm the expectation rejects it.  (The first entry is the original
    # collapse-to-one-symbol check; the second is the string case, where a
    # single shared literal label would make both entries point at "xy".)
    SELFCHECK = [
        ('fp_array', 46),        # both entries = add
        ('str_ptr_array', 240),  # both entries = the first literal ("xy")
        ('ptr_designator', 0),   # designator ignored, element placed at [0]
        ('ptr_designator_gap', 17),  # cursors not advanced past a designator
    ]
    by_name = {c[0]: c for c in CASES}
    for sname, wrong in SELFCHECK:
        if sname not in by_name:
            print('FAIL selfcheck: case %r is gone, the check is stale' % sname)
            bad += 1
            continue
        want = by_name[sname][2]
        if wrong == want:
            print('FAIL selfcheck %s: the wrong answer equals the expectation' % sname)
            bad += 1
        else:
            print('SELFCHECK %s: wrong answer detectable (%r != %r)'
                  % (sname, wrong, want))

    print('=== %d passed, %d failed ===' % (ok, bad))
    return 0 if bad == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
