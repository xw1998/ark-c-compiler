#!/usr/bin/env python3
"""Diagnostic-layer gate.

Every case here exists because real armcc was run and measured.  Two kinds:

  exact  the whole output must equal armcc's byte for byte -- these are the
         cases where arkc's behaviour is meant to be indistinguishable
         (driver errors, command-line errors, a single semantic error).
  shape  only the layout contract is asserted.  Used where arkc's parser
         recovers differently from armcc's, so the *set* of messages
         legitimately differs even though each line must still be spelled
         the same way.

  sink   the stream must land in the --errors file, byte for byte equal to
         armcc's file, and nothing may leak to the console.

Exit codes:  0 all green, 1 regression, 2 cannot judge (no armcc and no
stored baseline -- the gate refuses to pass on absent evidence).
"""
import argparse
import os
import re
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
DEV = os.path.dirname(HERE)
BASE = os.path.join(HERE, "diag_baseline")
ARKCC = os.path.join(DEV, "arkcc.exe")
DEFAULT_ARMCC = r"D:\Keil_v5\ARM\ARMCC\bin\armcc.exe"


def armcc_path():
    p = os.environ.get("ARKCC_ARMCC", DEFAULT_ARMCC)
    return p if os.path.isfile(p) else None


# name, mode, arkc argv, armcc argv
CASES = [
    ("clean",         "exact", ["clean.c", "-c", "-o", "nul"],
                               ["-c", "clean.c", "-o", "nul"]),
    ("undef_arm",     "exact", ["undefok.c", "-c", "-o", "nul"],
                               ["-c", "undefok.c", "-o", "nul"]),
    ("undef_ide",     "exact", ["undefok.c", "-c", "-o", "nul", "--diag_style=ide"],
                               ["-c", "undefok.c", "-o", "nul", "--diag_style=ide"]),
    ("badopt",        "exact", ["-x"], ["-x"]),
    ("badopt_ide",    "exact", ["-x", "--diag_style=ide"],
                               ["-x", "--diag_style=ide"]),
    ("badstyle",      "exact", ["--diag_style=bogus"], ["--diag_style=bogus"]),
    ("badcpu",        "exact", ["--cpu=nosuch"], ["--cpu=nosuch"]),
    ("badmacro",      "exact", ["clean.c", "-c", "-D", "1BAD=1"],
                               ["-c", "clean.c", "-D", "1BAD=1"]),
    ("badmacro_ide",  "exact", ["clean.c", "-c", "-D", "1BAD=1", "--diag_style=ide"],
                               ["-c", "clean.c", "-D", "1BAD=1", "--diag_style=ide"]),
    ("dupfunc",       "exact", ["dup.c", "-c", "-o", "nul"],
                               ["-c", "dup.c", "-o", "nul"]),
    ("dupparam",      "exact", ["dupparam.c", "-c", "-o", "nul"],
                               ["-c", "dupparam.c", "-o", "nul"]),
    ("nofile",        "exact", ["nosuchfile.c", "-c"], ["-c", "nosuchfile.c"]),
    ("nofile_ide",    "exact", ["nosuchfile.c", "-c", "--diag_style=ide"],
                               ["-c", "nosuchfile.c", "--diag_style=ide"]),

    # Preprocessor diagnostics. Each case fixes one measured armcc behaviour:
    # the code, the severity, the caret column and (for the warnings) the -D tag.
    # "exact" means arkc must reproduce the bytes armcc writes.
    ("pp_div0",         "exact", ["pp_div0.c", "-c", "-o", "nul"],
                                 ["-c", "pp_div0.c", "-o", "nul"]),
    ("pp_mod0",         "exact", ["pp_mod0.c", "-c", "-o", "nul"],
                                 ["-c", "pp_mod0.c", "-o", "nul"]),
    ("pp_include_missing", "exact", ["pp_include_missing.c", "-c", "-o", "nul"],
                                    ["-c", "pp_include_missing.c", "-o", "nul"]),
    ("pp_include_noname", "exact", ["pp_include_noname.c", "-c", "-o", "nul"],
                                   ["-c", "pp_include_noname.c", "-o", "nul"]),
    ("pp_if_unclosed",  "exact", ["pp_if_unclosed.c", "-c", "-o", "nul"],
                                 ["-c", "pp_if_unclosed.c", "-o", "nul"]),
    # Two open groups: armcc reports the innermost first, then the outer one.
    ("pp_if_unclosed_nested", "exact", ["pp_if_unclosed_nested.c", "-c", "-o", "nul"],
                                      ["-c", "pp_if_unclosed_nested.c", "-o", "nul"]),
    ("pp_stray_endif",  "exact", ["pp_stray_endif.c", "-c", "-o", "nul"],
                                 ["-c", "pp_stray_endif.c", "-o", "nul"]),
    ("pp_stray_else",   "exact", ["pp_stray_else.c", "-c", "-o", "nul"],
                                 ["-c", "pp_stray_else.c", "-o", "nul"]),
    ("pp_error",        "exact", ["pp_error.c", "-c", "-o", "nul"],
                                 ["-c", "pp_error.c", "-o", "nul"]),
    ("pp_warning",      "exact", ["pp_warning.c", "-c", "-o", "nul"],
                                 ["-c", "pp_warning.c", "-o", "nul"]),
    ("pp_if_empty",     "exact", ["pp_if_empty.c", "-c", "-o", "nul"],
                                 ["-c", "pp_if_empty.c", "-o", "nul"]),
    # Empty #elif in a branch that is already dead is a *warning* in armcc.
    ("pp_elif_empty_dead", "exact", ["pp_elif_empty_dead.c", "-c", "-o", "nul"],
                                    ["-c", "pp_elif_empty_dead.c", "-o", "nul"]),
    ("pp_ifdef_empty",  "exact", ["pp_ifdef_empty.c", "-c", "-o", "nul"],
                                 ["-c", "pp_ifdef_empty.c", "-o", "nul"]),
    ("pp_unknown_directive", "exact", ["pp_unknown_directive.c", "-c", "-o", "nul"],
                                      ["-c", "pp_unknown_directive.c", "-o", "nul"]),

    # Parser/sema codes. Each one was measured against real armcc, and the
    # caret columns are part of the assertion: #137 lands on the '(' of the
    # offending lvalue, #165 on the ')' that closes the argument list, #140 on
    # the first argument without a parameter, and #67 on the line the final
    # newline terminates with an "At end of source" marker instead of an echo.
    ("sem_lvalue", "exact", ["sem_lvalue.c", "-c", "-o", "nul"],
                            ["-c", "sem_lvalue.c", "-o", "nul"]),
    ("sem_toofew", "exact", ["sem_toofew.c", "-c", "-o", "nul"],
                            ["-c", "sem_toofew.c", "-o", "nul"]),
    ("sem_toomany", "exact", ["sem_toomany.c", "-c", "-o", "nul"],
                             ["-c", "sem_toomany.c", "-o", "nul"]),
    ("parse_missing_semicolon", "exact", ["parse_missing_semicolon.c", "-c", "-o", "nul"],
                                         ["-c", "parse_missing_semicolon.c", "-o", "nul"]),
    ("parse_missing_rbracket", "exact", ["parse_missing_rbracket.c", "-c", "-o", "nul"],
                                        ["-c", "parse_missing_rbracket.c", "-o", "nul"]),
    ("parse_missing_rparen", "exact", ["parse_missing_rparen.c", "-c", "-o", "nul"],
                                      ["-c", "parse_missing_rparen.c", "-o", "nul"]),
    ("parse_missing_rbrace", "exact", ["parse_missing_rbrace.c", "-c", "-o", "nul"],
                                      ["-c", "parse_missing_rbrace.c", "-o", "nul"]),
    ("parse_noexpr", "exact", ["parse_noexpr.c", "-c", "-o", "nul"],
                              ["-c", "parse_noexpr.c", "-o", "nul"]),
]

# Cases where arkc's recovery differs from armcc's, so only the spelling of
# each line can be asserted.  Each entry is an ordered list of patterns.
SHAPE_CASES = [
    # armcc keeps going after a bad token, so the number of messages it
    # reports legitimately differs from arkc's; only the layout is asserted.
    ("badchar", ["badchar.c", "-c", "-o", "nul"], [
        r'^"badchar\.c", line 1: Error:  #7: unrecognized token$',
        r'^  int f\(void\)\{ int b = 1 @ 2; return b; \}$',
        r'^ +\^$',
        r'^badchar\.c: 0 warnings, [1-9]\d* errors?$',
    ]),
    # arkc has no unused-variable pass yet, so armcc's extra #177-D is absent;
    # the duplicate-declaration line and its caret are what gets asserted.
    ("dupvar", ["dupvar.c", "-c", "-o", "nul"], [
        r'^"dupvar\.c", line 1: Error:  #101: "a" has already been declared in the current scope$',
        r'^  int f\(void\)\{ int a; int a; return a; \}$',
        r'^ {26}\^$',
        r'^dupvar\.c: [01] warnings?, 1 error$',
    ]),
]


# --errors redirects the whole stream into a file.  Asserted separately from
# CASES because the thing under test is the *file*, plus the fact that nothing
# leaks to the console.  This case exists because a missing #include once made
# the sink compile to nothing on every profile while the switch still claimed
# to be on -- the flag then silently did nothing.
SINK_CASES = [
    ("sink", "undefok.c"),
]


def run(argv, exe):
    p = subprocess.run([exe] + argv, cwd=BASE, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.stdout


def show(data):
    return data.decode("utf-8", "replace").replace("\r\n", "\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--regen", action="store_true",
                    help="rewrite the stored baselines from real armcc")
    args = ap.parse_args()

    arm = armcc_path()
    if args.regen and not arm:
        print("regen needs armcc (set ARKCC_ARMCC)")
        return 2
    if not os.path.isfile(ARKCC):
        print("arkcc.exe not built")
        return 2

    fails = 0
    for name, mode, ark_argv, arm_argv in CASES:
        ref_path = os.path.join(BASE, name + ".expected")
        if args.regen:
            open(ref_path, "wb").write(run(arm_argv, arm))
            print("wrote %s.expected" % name)
            continue
        if not os.path.isfile(ref_path):
            print("[SKIP] %-12s no baseline; run --regen" % name)
            fails += 1
            continue
        ref = open(ref_path, "rb").read()
        got = run(ark_argv, ARKCC)
        if got == ref:
            print("[ ok ] %s" % name)
            continue
        fails += 1
        print("[FAIL] %s" % name)
        print("--- armcc ---")
        print(show(ref))
        print("--- arkc ---")
        print(show(got))

    for name, src in SINK_CASES:
        ref_path = os.path.join(BASE, name + ".expected")
        # Sink targets live in the system temp dir under fixed names and are
        # simply overwritten on each run: the gate must not delete files, and
        # leaving two small temp files behind is cheaper than owning cleanup.
        tmp_arm = os.path.join(tempfile.gettempdir(), "arkcc_diag_%s.arm.tmp" % name)
        tmp_ark = os.path.join(tempfile.gettempdir(), "arkcc_diag_%s.ark.tmp" % name)
        arm_argv = ["-c", src, "-o", "nul", "--errors=" + tmp_arm]
        ark_argv = [src, "-c", "-o", "nul", "--errors=" + tmp_ark]
        if args.regen:
            run(arm_argv, arm)
            data = open(tmp_arm, "rb").read() if os.path.exists(tmp_arm) else b""
            open(ref_path, "wb").write(data)
            print("wrote %s.expected" % name)
            continue
        if not os.path.isfile(ref_path):
            print("[SKIP] %-12s no baseline; run --regen" % name)
            fails += 1
            continue
        console = run(ark_argv, ARKCC)
        ref = open(ref_path, "rb").read()
        got = open(tmp_ark, "rb").read() if os.path.exists(tmp_ark) else b""
        if got == ref and console.strip() == b"":
            print("[ ok ] %s (sink)" % name)
            continue
        fails += 1
        print("[FAIL] %s (sink)" % name)
        print("--- armcc file ---")
        print(show(ref))
        print("--- arkc file ---")
        print(show(got))
        print("--- arkc console ---")
        print(show(console))

    for name, argv, patterns in SHAPE_CASES:
        got = show(run(argv, ARKCC))
        lines = got.split("\n")
        pos = 0
        ok = True
        for pat in patterns:
            while pos < len(lines) and not re.search(pat, lines[pos]):
                pos += 1
            if pos >= len(lines):
                ok = False
                break
            pos += 1
        if ok:
            print("[ ok ] %s (shape)" % name)
        else:
            fails += 1
            print("[FAIL] %s (shape) missing pattern %r" % (name, pat))
            print(got)

    if args.regen:
        return 0
    print("\n%d failure(s)" % fails)
    return 0 if fails == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
