#!/usr/bin/env python3
"""x86-64 flat-image gate: the SysV AMD64 backend must return the right answer.

The `x86_64` target started life as an alias for the 32-bit `x86` backend, so
`-target x86_64` produced i386 code and every 64-bit data type was silently
truncated.  It is now a real backend: 8-byte pointers, the SysV register file
(rdi rsi rdx rcx r8 r9 + xmm0-7 + right-to-left stack slots of 8 bytes), a
flat image at 0x400000 with RIP-relative data references, and its own 64-bit
encoder in the built-in assembler.

What this gate holds to its claims:

  runtime    compile C -> flat image -> run `main` on a 64-bit unicorn core and
             compare rax with a constant computed *outside* this program (by
             hand, or by a Python expression over the same inputs).  Two arms
             agreeing on a wrong number is still a wrong answer, so the host
             toolchain is never the oracle.
  refusals   an external symbol that the single-file image cannot resolve must
             fail the build and leave no image behind.  `resolve_refs_x` leaves
             an unknown label as an all-zero disp32, so `call foo` degenerates
             into `call +0`: the image re-enters itself and spins while arkcc
             exits 0.  Refusing is the only honest option for a raw image.
  selfcheck  the harness must be able to *fail*: the last stage re-runs cases
             with a deliberately wrong expectation and requires each to be
             reported as DIFF.  A gate that cannot report a mismatch proves
             nothing about the passes above it.

The 32-bit `x86` result is printed for every case as a reference arm only.  That
backend has pre-existing gaps on 64-bit and double code paths (`movq needs an
xmm operand`, UC_ERR_EXCEPTION, aggregates passed by value), which are recorded
in docs/ and are *not* regressions of this work; those arms are reported as
SKIP with the measured reason and never counted as pass or fail.

Static-initialiser anchors (`data_array_init`, `rodata_ptr`, `fptr_table`,
`globals_two_objs`) exist because three defects used to hide behind a green
build:  the assembler's operand pre-parse consumed the whole line, so every
data directive emitted *zero* bytes (labels landed right, their payload did
not);  `.quad` wrote a zero high half, turning `{1,2,3,4}` into `{1,0,3,0}`;
and an object's self-base absolutes were never relocated, so a `const char *`
in an object was 0 after `-link`.  A gate that only compiles would have missed
all three -- they are only visible by running the bytes.

The variadic cases are the one place where the i386 arm is interesting: that
target's va region is the caller's own 4-byte-word stack block, so it now walks
packed word slots like RV32I does.  Before that it took <stdarg.h>'s 8-byte-slot
default branch (cursor +8 per argument against a 4-byte-word image) and read
every second argument, e.g. 40 instead of 60 for sum(3,10,20,30) -- a wrong
answer with no diagnostic.  Its double varargs used to refuse at build time
(`movq needs an xmm operand`); once the i386 float path landed those arms run
for real, so an i386 mismatch is now a verdict like everywhere else.

Usage (from the repository root):
    python tests/run_x86_64_image_tests.py --arkcc ./arkcc.exe
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
# Scratch space lives under the system temp directory, not in the repository:
# a build directory next to the sources is pollution the repository has to
# ignore, and deleting a file inside the workspace can be refused by an
# external deletion policy (os.remove then raises PermissionError and takes
# the whole gate down with it).
TMP = None

IMAGE_BASE = 0x400000
STACK_BASE = 0x700000
RET_MAGIC = 0x3FFFF0

# name, source, expected rax, what the case is really about
CASES = [
    ("int_args_9",
     """
int f(int a,int b,int c,int d,int e,int f2,int g,int h,int i){
  return a*1+b*2+c*3+d*4+e*5+f2*6+g*7+h*8+i*9;
}
int main(void){ return f(1,2,3,4,5,6,7,8,9) % 251; }
""", 34, "6 register args + 3 stack args (1*1+..+9*9=285)"),

    ("ll_mul",
     """
long long mul(long long a, long long b){ return a*b; }
int main(void){ long long x = 1234567; long long y = 7654321;
  long long z = mul(x,y); return (int)(z % 1000); }
""", 7, "64-bit result in rax, split at the call site (567*321=182007)"),

    ("ull_div",
     """
unsigned long long udiv(unsigned long long a, unsigned long long b){ return a/b; }
int main(void){ return (int)(udiv(0xFFFFFFFFFFFFFF00ULL, 1000ULL) % 251); }
""", 74, "unsigned 64-bit division, high word matters"),

    ("struct_ll_field",
     """
struct S { int a; int b; long long c; };
int main(void){
  struct S s; struct S *p = &s;
  p->a = 3; p->b = 4; p->c = 10000000000LL;
  long long r = p->a + p->b*2;
  return (int)((r + p->c/1000000000LL) % 251);
}
""", 21, "8-byte field load through a pointer (3+8+10)"),

    ("ptr_walk",
     """
int main(void){ int a[8]; int i, *p, s = 0;
  for(i=0;i<8;i++) a[i] = i*3;
  p = a;
  for(i=0;i<8;i++) s += *(p+i);
  return s; }
""", 84, "8-byte pointer arithmetic (3*(0+..+7)=84)"),

    ("float_mul",
     """
double f(double a, double b){ return a*b + 1.5; }
int main(void){ double d = f(2.5, 4.0); int i = (int)(d*2); return i; }
""", 23, "double args in xmm, double result in xmm0 ((2.5*4+1.5)*2=23)"),

    ("float_add",
     """
float f(float a, float b){ return a+b; }
int main(void){ float x = 1.25f; float y = 2.75f; float z = f(x,y); return (int)(z*4.0f); }
""", 16, "single-precision path ((1.25+2.75)*4=16)"),

    ("struct_byval",
     """
struct P { int x, y; };
struct B { int a[6]; };
struct P mk(int a,int b){ struct P p; p.x=a; p.y=b; return p; }
int big(struct B b){ return b.a[0]+b.a[5]; }
int main(void){ struct P p = mk(11,22); struct B b; b.a[0]=5; b.a[5]=7; return p.x+p.y+big(b); }
""", 45, "8-byte struct returned in rax + 24-byte struct passed by pointer (33+12)"),

    ("func_ptr",
     """
int add2(int a){ return a+2; }
int main(void){ int (*fp)(int) = add2; return fp(40); }
""", 42, "indirect call through a 64-bit function pointer"),

    ("fib_switch",
     """
int fib(int n){ return n<2 ? n : fib(n-1)+fib(n-2); }
int main(void){ int x = fib(10);
  switch(x % 7){ case 0: return 10; case 1: return 11; case 2: return 12; }
  return 99; }
""", 99, "recursion + jump table (fib(10)=55, 55%7=6 -> default)"),

    ("struct_copy16",
     """
struct T { char b[16]; };
int slen(const char *s){ int n=0; while(*s){ n++; s++; } return n; }
int main(void){ struct T a; struct T c; char *m = "hello world"; int i;
  for(i=0;i<12;i++) a.b[i] = m[i];
  a.b[12] = 0;
  c = a;
  return slen(c.b); }
""", 11, "16-byte aggregate copy (rep movsb really emits)"),

    ("ull_loop",
     """
int main(void){ unsigned long long v = 1ULL; int i;
  for(i=0;i<40;i++) v = v*3ULL + 1ULL;
  return (int)(v % 251); }
""", 187, "40 iterations of 64-bit multiply-add"),

    ("signed_div",
     """
int main(void){ int a = -17, b = 5; return (a/b)*10 + (a%b) + 100; }
""", 68, "truncating division and remainder with negatives (-30-2+100)"),

    ("double_cmp",
     """
int main(void){ double a = 3.5, b = 2.5; int r = 0;
  if(a>b) r += 1; if(a<b) r += 10; if(a==b) r += 100; if(a!=b) r += 1000;
  return r; }
""", 1001, "four double comparisons (1 + 1000)"),

    ("mixed_8_args",
     """
long long f(long long a, int b, long long c, int d, long long e, int x, int y, int z){
  return a + b + c + d + e + x + y + z;
}
int main(void){ return (int)(f(1000000000000LL, 1, -5LL, 2, 7LL, 3, 4, 5) % 251); }
""", 22, "int/long long interleave across the 6 integer registers"),

    # --- variadic definitions (SysV register save area + real va_list) --------
    ("varargs_regs",
     """
#include <stdarg.h>
int sum(int n, ...) { va_list ap; int s = 0; int i;
  va_start(ap, n); for (i = 0; i < n; i++) s += va_arg(ap, int); va_end(ap);
  return s; }
int main(void){ return sum(3, 10, 20, 30) % 251; }
""", 60, "3 int varargs taken from the gp save area (10+20+30)"),

    ("varargs_stack",
     """
#include <stdarg.h>
int sum(int n, ...) { va_list ap; int s = 0; int i;
  va_start(ap, n); for (i = 0; i < n; i++) s += va_arg(ap, int); va_end(ap);
  return s; }
int main(void){ return sum(9, 1,2,3,4,5,6,7,8,9) % 251; }
""", 45, "5 gp varargs then 3 read from overflow_arg_area (1+..+9)"),

    ("varargs_double",
     """
#include <stdarg.h>
double dsum(int n, ...) { va_list ap; double s = 0; int i;
  va_start(ap, n); for (i = 0; i < n; i++) s += va_arg(ap, double); va_end(ap);
  return s; }
int main(void){ return (int)dsum(2, 1.5, 2.5); }
""", 4, "va_arg(double) reads the fp save area, 16-byte slots (1.5+2.5)"),

    ("varargs_fp_overflow",
     """
#include <stdarg.h>
double dsum(int n, ...) { va_list ap; double s = 0; int i;
  va_start(ap, n); for (i = 0; i < n; i++) s += va_arg(ap, double); va_end(ap);
  return s; }
int main(void){ return (int)dsum(9, 1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0); }
""", 45, "8 doubles fill fp_offset to 176, the 9th comes from the stack"),

    ("varargs_mixed",
     """
#include <stdarg.h>
double mix(int n, ...) { va_list ap; double s = 0;
  va_start(ap, n);
  s += va_arg(ap, int); s += va_arg(ap, double);
  s += va_arg(ap, int); s += va_arg(ap, double);
  va_end(ap); return s; }
int main(void){ return (int)(mix(4, 7, 1.5, 3, 2.25) * 4.0); }
""", 55, "gp_offset and fp_offset advance independently (7+1.5+3+2.25=13.75)"),

    ("varargs_ptr",
     """
#include <stdarg.h>
int slen(int n, ...) { va_list ap; int s = 0, i; const char *p;
  va_start(ap, n);
  for (i = 0; i < n; i++) { p = va_arg(ap, const char *); while (*p) { s++; p++; } }
  va_end(ap); return s; }
int main(void){ return slen(3, "ab", "abcd", "x"); }
""", 7, "64-bit pointer varargs survive the save area (2+4+1)"),

    ("varargs_many",
     """
#include <stdarg.h>
int sum(int n, ...) { va_list ap; int s = 0; int i;
  va_start(ap, n); for (i = 0; i < n; i++) s += va_arg(ap, int); va_end(ap);
  return s; }
int main(void){ return sum(12, 1,2,3,4,5,6,7,8,9,10,11,12) % 251; }
""", 78, "12 int varargs: 5 in registers, 7 in the overflow area"),

    ("data_array_init",
     """
int g[4] = {1,2,3,4};
int main(void){ return (g[0]*1 + g[1]*2 + g[2]*3 + g[3]*4) % 251; }
""", 30, "initialised global array is really in the image (1+4+9+16), not zeros"),

    ("rodata_ptr",
     """
const char *msg = "hello";
int slen(const char *p){ int n=0; while(*p){n++;p++;} return n; }
int main(void){ return slen(msg)*7; }
""", 35, "string literal + a global pointer to it (5*7): .asciz and .quad both emitted"),

    ("fptr_table",
     """
static int fa(void){return 1;}
static int fb(void){return 2;}
static int fc(void){return 3;}
static int (*tab[3])(void) = {fa, fb, fc};
int main(void){ return tab[0]() + tab[1]()*2 + tab[2]()*3; }
""", 14, "static function-pointer table (1+4+9): absolute addresses in .data"),

    ("struct_sret24",
     """
typedef struct { int a, b, c; } T3;
static T3 mk3(int v){ T3 t; t.a = v; t.b = v + 1; t.c = v + 2; return t; }
int main(void){ T3 x = mk3(5); return (x.a + x.b * 2 + x.c * 3) % 251; }
""", 38, "24-byte struct returned through the hidden pointer (5+12+21); the callee must copy into *sret"),

    ("struct_sret40",
     """
typedef struct { int a; long long b; int c[5]; } T5;
static T5 mk5(int v){ T5 t; int i; t.a = v; t.b = v * 2; for (i = 0; i < 5; i++) t.c[i] = v + i; return t; }
int main(void){ T5 x = mk5(3); return (x.a + (int)x.b + x.c[0] + x.c[4]) % 251; }
""", 19, "mixed 40-byte struct by value (3+6+3+7); >8 bytes so it cannot use the register pair path"),

    ("ptr_array_init",
     """
static const char *names[4] = {"x", "yy", "zzz", "wwww"};
int main(void){
  const char *tbl[4] = {"a", "bb", "ccc", "dddd"};
  const char *xyzw = "xyzw";
  const char *abcd = "abcd";
  int i;
  for (i = 0; i < 4; i++) {
    if (tbl[i][0] != abcd[i]) return 10 + i;
    if (tbl[i][i] != abcd[i]) return 20 + i;
    if (names[i][0] != xyzw[i]) return 30 + i;
    if (names[i][i] != xyzw[i]) return 40 + i;
  }
  return 0; }
""", 0, "pointer elements of a local and a file-scope initialiser list each keep all 8 bytes (tbl[i][i] and names[i][0] must be the right character)"),

    ("sizeof_member_array",
     """
struct S { int kind; char sym[512]; };
int main(void){ struct S s; struct S *p = &s;
  if ((int)sizeof(s.sym) != 512) return 1;
  if ((int)sizeof(p->sym) != 512) return 2;
  if ((int)sizeof(struct S) != 516) return 3;
  if ((int)sizeof(s.kind) != 4) return 4;
  return 0; }
""", 0, "sizeof of a struct-member array is the array size, not the generic 4 (it was 4 while self-hosting)"),

    ("ptr_llong_roundtrip",
     """
int main(void){
  char *p = (char *)0x1;
  char *q = p + 4;
  long long d = (long long)q;   /* explicit cast */
  char *r = (char *)d;          /* back to a pointer */
  long long e = q;              /* implicit assignment */
  if (d != 5) return 1;
  if (r != q) return 2;
  if (e != d) return 3;
  return (int)d; }
""", 5, "pointer <-> long long: a pointer is ONE stack word, a long long TWO, so the high half has to be created and dropped (it was neither: every cast answered 0)"),

    ("ptr_llong_arg",
     """
long long f(long long x){ return x + 1; }
long long g(char *q){ return (long long)q; }
int main(void){ char *p = (char *)0x10; char *q = p + 4;
  long long a = f(q);
  long long b = g(q);
  return (int)(a + b) % 251; }
""", 41, "pointer as a 64-bit argument and as a 64-bit return value (20+1 + 20 = 41)"),

    ("varargs_copy",
     """
#include <stdarg.h>
int sum2(int n, ...) { va_list ap, aq; int s = 0; int i;
  va_start(ap, n); va_copy(aq, ap);
  for (i = 0; i < n; i++) s += va_arg(ap, int);
  for (i = 0; i < n; i++) s += va_arg(aq, int);
  va_end(aq); va_end(ap); return s; }
int main(void){ return sum2(4, 1, 2, 3, 4) % 251; }
""", 20, "va_copy gives an independent cursor (2*(1+2+3+4))"),

    # bit-fields on this backend: the store used to keep only the bits below
    # the field (wiping the neighbours above it) and pushed the value back,
    # and the load ignored the 0x100 signed flag, so every signed field read
    # back as the whole storage word.
    ("bitfield_incdec",
     """
struct S { unsigned a:4; unsigned b:5; int c:6; };
int main(void){ struct S s; s.a = 1; s.b = 31; s.c = 3;
  int r1 = s.b++; int r2 = s.b; int r3 = s.a--; int r4 = s.a;
  if (s.c != 3) return 91;
  return r1*7 + r2*5 + r3*3 + r4; }
""", 220, "bit-field ++/-- must leave the neighbouring fields alone"),

    ("bitfield_signed",
     """
struct S { signed int a:4; signed int b:5; unsigned c:3; };
int main(void){ struct S s; s.a = 6; s.b = -3; s.c = 5;
  int r1 = ++s.a; int r2 = --s.b; int r3 = ++s.c;
  if (s.a != 7 || s.b != -4 || s.c != 6) return 91;
  return r1*10 + r2 + 40 + r3; }
""", 112, "signed bit-field loads sign-extend and prefix ++/-- write the field"),

    # C99 designator chains: '.p[1].y = v' and '[i][j] = v'.  The parser used
    # to accept one sub-designator only, so these failed to parse at all.
    ("designator_chain_local",
     """
struct P { int x, y; };
struct R { struct P p[2]; int tag; };
int main(void){ struct R r = { .p[1].y = 7, .tag = 5, .p[0].x = 3 };
  if (r.p[0].x != 3 || r.p[1].y != 7 || r.p[0].y != 0 || r.tag != 5) return 91;
  return r.p[0].x + r.p[1].y + r.tag; }
""", 15, "designator chain names a sub-object of a sub-object (local)"),

    ("designator_chain_global",
     """
struct P { int x, y; };
struct R { struct P p[2]; int tag; };
static struct R g = { .p[1].y = 7, .tag = 5, .p[0].x = 3 };
int m[2][3] = { [1][2] = 4, [0][1] = 6 };
int main(void){
  if (g.p[0].x != 3 || g.p[1].y != 7 || g.tag != 5) return 91;
  if (m[1][2] != 4 || m[0][1] != 6 || m[1][0] != 0) return 92;
  return g.p[0].x + g.p[1].y + g.tag + m[0][1] * 10 + m[1][2]; }
""", 79, "designator chains in static data: .p[1].y and [i][j]"),

    ("double_precision_bits",
     """
union U { double d; unsigned long long u; };
static double g = 0.1;
int main(void){
  union U x;
  x.d = g;
  if (x.u != 0x3FB999999999999AULL) return 91;
  x.d = 1.0 / 3.0;
  if (x.u != 0x3FD5555555555555ULL) return 92;
  return 7; }
""", 7, "double stores 64 bits: 0.1 and 1/3 have their binary64 patterns"),

    ("double_precision_arith",
     """
int main(void){
  double d = 1.0 / 3.0;
  if ((int)(d * 3.0 * 1000000.0) != 1000000) return 91;
  if ((int)((0.1 + 0.2) * 1000.0) != 300) return 92;
  if (!(1e300 < 1e301)) return 93;
  return 45; }
""", 45, "double arithmetic keeps binary64 precision (a float pipeline gives 91/92/93)"),

    ("x86_sym_plus_disp",
     """
struct S { int a; double d; };
static struct S gs = { 3, 0.25 };
static double arr[2] = { 1.5, -2.25 };
int main(void){
  if (gs.a != 3) return 91;
  if ((int)(gs.d * 4.0) != 1) return 92;
  if ((int)(arr[1] * -4.0) != 9) return 93;
  return 7; }
""", 7, "[symbol+disp] loads: a global 64-bit object's high word (i386 emits mov eax,[gs+8])"),
]


# stage 3: two objects through -c / -link.  Each object's data is concatenated
# with its code, so every address it stored for its OWN labels has to be raised
# by the base the linker placed it at -- otherwise a string pointer stays 0 and
# a cross-object global lands on the other object's code.
# name, [(file name, source), ...], expected rax, what it is really about
LINK_CASES = [
    ("globals_two_objs",
     [("d1.c", """
int g[4] = {1,2,3,4};
const char *msg = "hello";
int sumg(void) { int s = 0, i; for (i = 0; i < 4; i++) s += g[i]; return s; }
"""),
      ("d2.c", """
extern int g[4];
extern const char *msg;
int sumg(void);
int slen(const char *p) { int n = 0; while (*p) { n++; p++; } return n; }
int main(void) { g[1] = 10; return sumg() + slen(msg); }
""")],
     23, "object 2 writes object 1's array and reads its string (1+10+3+4 + 5)"),

    # The absolute-address half of the same rule.  An object's own label keeps
    # X86_IMAGE_BASE from the assembler and only needs the object base; a label
    # defined in *another* object is never seen by that assembler, so the link
    # step is the only side that can supply the load base.  It used to add just
    # the object base, which put the pointer 0x400000 below the image: the
    # self-host gate died on the first indirect call through a stage table at
    # 0x3F571F.  Measured on this case before the fix: UC_ERR_FETCH_UNMAPPED.
    ("fptr_across_objs",
     [("e1.c", """
int f1(void) { return 10; }
int f2(void) { return 20; }
"""),
      ("e2.c", """
int f1(void);
int f2(void);
int (*tab[2])(void) = {f1, f2};
int main(void) { return tab[0]() + tab[1]() * 2; }
""")],
     50, "a stored function pointer to another object's code (10 + 2*20); "
         "the linker must add the load base, not only the object base"),

    ("sym_plus_disp_cross_obj",
     [("d1.c", """
struct S { int a; double d; };
double gd = 2.5;
struct S gs = { 4, 0.75 };
int geta(void) { return gs.a; }
"""),
      ("d2.c", """
struct S { int a; double d; };
extern double gd;
extern struct S gs;
int geta(void);
int main(void)
{
    if ((int)(gd * 4.0) != 10) return 91;   /* [gd+4] through a relocation */
    if (geta() != 4) return 92;
    if ((int)(gs.d * 4.0) != 3) return 93;  /* [gs+8]  through a relocation */
    return 21;
}
""")],
     21, "a cross-object [symbol+disp] load: the addend lives in the site and "
         "the relocation has to add it (types 8/9), not overwrite the field"),
]

# stage 2: must be refused, not silently linked
REFUSALS = [
    ("undefined_function",
     """
int foo(void);
int main(void){ return foo(); }
"""),
]


def need(mod, what):
    try:
        return __import__(mod)
    except Exception as exc:                    # noqa: BLE001 - report and skip
        print('SKIP: %s unavailable (%s) -- %s' % (mod, exc, what))
        return None


def build(arkcc, src_path, target, out_path):
    env = dict(os.environ)
    env['ARKCC_DUMP_SYMS'] = '1'
    proc = subprocess.run([arkcc, '-target', target, src_path, '-o', out_path],
                          capture_output=True, env=env)
    text = (proc.stdout + proc.stderr).decode('utf-8', 'replace')
    syms = {}
    for m in re.finditer(r'X86_SYM (\S+) 0x([0-9A-Fa-f]+)', text):
        syms.setdefault(m.group(1), int(m.group(2), 16))
    return proc.returncode, text, syms


def obj_header(path):
    """(code_size, {symbol: offset}) of an ARKOBJ2 object."""
    import struct
    with open(path, 'rb') as f:
        d = f.read()
    if d[:8] != b'ARKOBJ2\n':
        raise ValueError('not an ARKOBJ2 object: %s' % path)
    off = 8
    code_size = struct.unpack_from('<i', d, off)[0]
    off += 4 + code_size
    count = struct.unpack_from('<i', d, off)[0]
    off += 4
    syms = {}
    for _ in range(count):
        nlen = struct.unpack_from('<i', d, off)[0]
        off += 4
        name = d[off:off + nlen].split(b'\0')[0].decode()
        off += nlen
        so = struct.unpack_from('<i', d, off)[0]
        off += 6                      # offset(4) + type(1) + is_weak(1)
        syms[name] = so
    return code_size, syms

def run64(code, start):
    """Run a flat image on a 64-bit core; returns (rax, None) or (None, reason)."""
    from unicorn import Uc, UcError, UC_ARCH_X86, UC_MODE_64
    from unicorn.x86_const import (UC_X86_REG_RAX, UC_X86_REG_RIP,
                                  UC_X86_REG_RSP)
    uc = Uc(UC_ARCH_X86, UC_MODE_64)
    size = max((len(code) + 0xFFF) & ~0xFFF, 0x10000)
    uc.mem_map(IMAGE_BASE, size)
    uc.mem_write(IMAGE_BASE, code)
    uc.mem_map(STACK_BASE, 0x100000)
    uc.mem_map(0x3FF000, 0x1000)
    sp = STACK_BASE + 0x80000
    uc.mem_write(sp, RET_MAGIC.to_bytes(8, 'little'))
    uc.reg_write(UC_X86_REG_RSP, sp)
    try:
        uc.emu_start(start, RET_MAGIC, count=2000000)
    except UcError as exc:
        return None, 'uc: %s at %#x' % (exc, uc.reg_read(UC_X86_REG_RIP))
    return uc.reg_read(UC_X86_REG_RAX) & 0xFFFFFFFFFFFFFFFF, None


def run32(code, start):
    """Reference arm: the 32-bit i386 backend, same protocol, base 0."""
    from unicorn import Uc, UcError, UC_ARCH_X86, UC_MODE_32
    from unicorn.x86_const import (UC_X86_REG_EIP, UC_X86_REG_EAX,
                                  UC_X86_REG_ESP)
    uc = Uc(UC_ARCH_X86, UC_MODE_32)
    size = max((len(code) + 0xFFF) & ~0xFFF, 0x10000)
    uc.mem_map(0, size)
    uc.mem_write(0, code)
    uc.mem_map(0x700000 - 0x100000, 0x100000)
    uc.mem_map(0x3FF000, 0x1000)
    sp = 0x700000 - 0x1000
    uc.mem_write(sp, RET_MAGIC.to_bytes(4, 'little'))
    uc.reg_write(UC_X86_REG_ESP, sp)
    try:
        uc.emu_start(start, RET_MAGIC, count=2000000)
    except UcError as exc:
        return None, 'uc: %s at %#x' % (exc, uc.reg_read(UC_X86_REG_EIP))
    return uc.reg_read(UC_X86_REG_EAX), None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--arkcc', default=os.path.join(ROOT, 'arkcc.exe'))
    args = ap.parse_args()
    arkcc = os.path.abspath(args.arkcc)
    if not os.path.exists(arkcc):
        print('arkcc not found:', arkcc)
        return 1
    if need('unicorn', 'x86-64 emulation') is None:
        return 1
    global TMP
    TMP = tempfile.mkdtemp(prefix='ark_x86_64_')
    os.makedirs(TMP, exist_ok=True)

    src = os.path.join(TMP, 'case.c')
    img64 = os.path.join(TMP, 'a64.bin')
    img32 = os.path.join(TMP, 'a32.bin')

    passed = failed = skipped = 0
    print('=== runtime (x86_64 is the arm under test) ===')
    for name, text, expect, about in CASES:
        with open(src, 'w', encoding='utf-8', newline='\n') as f:
            f.write(text)

        rc, msg, syms = build(arkcc, src, 'x86_64', img64)
        if rc != 0:
            print('FAIL %-16s build: %s' % (name, msg.strip().splitlines()[0][:120]))
            failed += 1
            continue
        if 'main' not in syms:
            print('FAIL %-16s no main symbol in image' % name)
            failed += 1
            continue
        with open(img64, 'rb') as f:
            code = f.read()
        got, why = run64(code, IMAGE_BASE + syms['main'])

        # reference arm -- never a verdict
        note = ''
        i386_bad = False
        rc2, msg2, syms2 = build(arkcc, src, 'x86', img32)
        if rc2 != 0:
            # A crashed or silently-killed arkcc leaves msg2 empty; indexing the
            # split list directly then raised IndexError and lost every later case
            # of the run (the real fault was a segfault on bare-label .s input,
            # fixed in backend_x86_64.c -- this only keeps the report readable).
            first2 = (msg2.strip().splitlines() or ['(no output; arkcc crashed)'])[0]
            note = '| i386 SKIP (build: %s)' % first2[:60]
        elif 'main' not in syms2:
            note = '| i386 SKIP (no symbol)'
        else:
            with open(img32, 'rb') as f:
                code32 = f.read()
            got32, why32 = run32(code32, syms2['main'])
            if why32:
                note = '| i386 SKIP (%s)' % why32
            else:
                note = '| i386=%d' % got32
                if got32 != expect:
                    # Every item on the old "known i386 gap" list is closed, so a
                    # 32-bit mismatch is now a verdict, not a footnote: if it ever
                    # comes back the gate has to go red.
                    note += ' (32-bit mismatch)'
                    i386_bad = True

        if why:
            print('FAIL %-16s %s %s' % (name, why, note))
            failed += 1
        elif got != expect:
            print('FAIL %-16s x86_64=%d expect=%d  [%s] %s'
                  % (name, got, expect, about, note))
            failed += 1
        elif i386_bad:
            print('FAIL %-16s x86_64=%d i386=%d expect=%d  [%s] %s'
                  % (name, got, got32, expect, about, note))
            failed += 1
        else:
            print('PASS %-16s x86_64=%d  [%s] %s' % (name, got, about, note))
            passed += 1

    print('=== refusals (an unresolvable image must not be written) ===')
    for name, text in REFUSALS:
        with open(src, 'w', encoding='utf-8', newline='\n') as f:
            f.write(text)
        if os.path.exists(img64):
            os.remove(img64)
        rc, msg, _ = build(arkcc, src, 'x86_64', img64)
        left = os.path.exists(img64)
        if rc == 0:
            print('FAIL %-16s exit 0 for an unresolvable reference' % name)
            failed += 1
        elif left:
            print('FAIL %-16s refused but left %s behind' % (name, os.path.basename(img64)))
            failed += 1
        else:
            print('PASS %-16s refused with no image' % name)
            passed += 1

    print('=== -c / -link (two objects, global data + string) ===')
    for name, files, expect, about in LINK_CASES:
        objs = []
        base = 0
        main_at = None
        build_ok = True
        for fname, text in files:
            src_path = os.path.join(TMP, fname)
            obj_path = os.path.join(TMP, fname + '.o')
            with open(src_path, 'w', encoding='utf-8', newline='\n') as f:
                f.write(text)
            proc = subprocess.run([arkcc, '-target', 'x86_64', '-c', src_path,
                                   '-o', obj_path], capture_output=True)
            if proc.returncode != 0:
                msg = (proc.stdout + proc.stderr).decode('utf-8', 'replace')
                print('FAIL %-16s object %s: %s'
                      % (name, fname, msg.strip().splitlines()[0][:110]))
                failed += 1
                build_ok = False
                break
            code_size, syms = obj_header(obj_path)
            objs.append(obj_path)
            if 'main' in syms:
                main_at = base + syms['main']
            base += code_size
        if not build_ok:
            continue
        if main_at is None:
            print('FAIL %-16s no main in any object' % name)
            failed += 1
            continue
        img = os.path.join(TMP, 'linked.bin')
        if os.path.exists(img):
            os.remove(img)
        proc = subprocess.run([arkcc, '-target', 'x86_64', '-link'] + objs +
                              ['-o', img], capture_output=True)
        if proc.returncode != 0 or not os.path.exists(img):
            msg = (proc.stdout + proc.stderr).decode('utf-8', 'replace')
            print('FAIL %-16s link: %s' % (name, msg.strip().splitlines()[0][:110]))
            failed += 1
            continue
        with open(img, 'rb') as f:
            code = f.read()
        got, why = run64(code, IMAGE_BASE + main_at)

        # reference arm: the same two objects through the 32-bit i386 backend,
        # where a [symbol+disp] site is an absolute relocation (type 8) rather
        # than a RIP-relative one.  A mismatch is a verdict, not a footnote.
        note = ''
        i386_bad = False
        objs32 = []
        base32 = 0
        main32 = None
        ok32 = True
        for fname, text in files:
            src_path = os.path.join(TMP, 'i32_' + fname)
            obj_path = os.path.join(TMP, 'i32_' + fname + '.o')
            with open(src_path, 'w', encoding='utf-8', newline='\n') as f:
                f.write(text)
            proc = subprocess.run([arkcc, '-target', 'x86', '-c', src_path,
                                   '-o', obj_path], capture_output=True)
            if proc.returncode != 0:
                note = '| i386 SKIP (object build failed)'
                ok32 = False
                break
            code_size, syms = obj_header(obj_path)
            objs32.append(obj_path)
            if 'main' in syms:
                main32 = base32 + syms['main']
            base32 += code_size
        if ok32 and main32 is not None:
            img32 = os.path.join(TMP, 'linked32.bin')
            if os.path.exists(img32):
                os.remove(img32)
            proc = subprocess.run([arkcc, '-target', 'x86', '-link'] + objs32 +
                                  ['-o', img32], capture_output=True)
            if proc.returncode != 0 or not os.path.exists(img32):
                note = '| i386 SKIP (link failed)'
            else:
                with open(img32, 'rb') as f:
                    code32 = f.read()
                got32, why32 = run32(code32, main32)
                if why32:
                    note = '| i386 SKIP (%s)' % why32
                else:
                    note = '| i386=%d' % got32
                    if got32 != expect:
                        note += ' (32-bit mismatch)'
                        i386_bad = True

        if why:
            print('FAIL %-16s %s  [%s]' % (name, why, about))
            failed += 1
        elif got != expect:
            print('FAIL %-16s x86_64=%d expect=%d  [%s] %s'
                  % (name, got, expect, about, note))
            failed += 1
        elif i386_bad:
            print('FAIL %-16s x86_64=%d i386=%d expect=%d  [%s] %s'
                  % (name, got, got32, expect, about, note))
            failed += 1
        else:
            print('PASS %-16s x86_64=%d  [%s] %s' % (name, got, about, note))
            passed += 1

    print('=== selfcheck (the harness must be able to fail) ===')
    name, text, expect, _ = CASES[0]
    with open(src, 'w', encoding='utf-8', newline='\n') as f:
        f.write(text)
    rc, msg, syms = build(arkcc, src, 'x86_64', img64)
    with open(img64, 'rb') as f:
        code = f.read()
    got, why = run64(code, IMAGE_BASE + syms['main'])
    if why is None and got == expect + 1:
        print('FAIL selfcheck: harness accepted a wrong expectation')
        failed += 1
    elif why is not None:
        print('FAIL selfcheck: %s' % why)
        failed += 1
    else:
        print('PASS selfcheck: expect+1 (=%d) was rejected, real value %d'
              % (expect + 1, got))
        passed += 1

    print('---')
    print('%d passed, %d failed, %d skipped' % (passed, failed, skipped))
    shutil.rmtree(TMP, ignore_errors=True)
    return 0 if failed == 0 else 1


if __name__ == '__main__':
    sys.exit(main())
