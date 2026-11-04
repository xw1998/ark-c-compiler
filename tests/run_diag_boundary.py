#!/usr/bin/env python3
"""Boundary assertions for the arkc diagnostic layer.

`run_diag_tests.py` compares arkc against real armcc byte for byte, which only
works where armcc's behaviour was measured and where both compilers agree on
everything else on that line. The cases here are the ones where at least one of
those two conditions fails, so they are asserted against arkc's own documented
contract instead:

  long_line    an over-long line is truncated with a trailing "..." and no
               caret is printed, because a caret that cannot sit under the
               offending character is worse than no caret at all.
  many_errors  exactly DIAG_LIMIT_DEFAULT (30) errors are printed, then
               reporting stops. This matches armcc, measured with 40 duplicate
               declarations (armcc also stops at 30 and says nothing more).
  same_line    two diagnostics on one line each get their own echo and caret.
  cjk          the caret column counts display cells (a CJK character is two
               cells), not bytes. armcc counts bytes, so its caret lands left
               of ours on the same file; that difference is deliberate: our
               sources are UTF-8 and the echo is meant to line up with what the
               terminal shows.
  tab          a tab in the echoed line is replayed as a tab and costs one
               column, so the caret still lines up visually.

Run:  python tests/run_diag_boundary.py [-v]
Exit code 0 means every assertion held.
"""

import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
ARKCC = os.environ.get("ARKCC") or os.path.join(ROOT, "arkcc.exe")

VERBOSE = "-v" in sys.argv[1:]

GUTTER = "  "          # must match DIAG_GUTTER in src/diag.c
LINE_MAX = 512         # must match DIAG_LINE_MAX in src/diag.c


def display_width(s):
    """Display cells of `s`, using the same rule as the diagnostic layer: a
    tab costs one column, a non-ASCII code point costs two."""
    w = 0
    for ch in s:
        if ch == "\t":
            w += 1
        elif ord(ch) < 0x80:
            w += 1
        else:
            w += 2
    return w


def run(source_name, source_text):
    tmp = tempfile.mkdtemp(prefix="arkcc_bnd_")
    src = os.path.join(tmp, source_name)
    with open(src, "w", encoding="utf-8", newline="") as f:
        f.write(source_text)
    obj = os.path.join(tmp, source_name[:-2] + ".o")
    proc = subprocess.run([ARKCC, "-c", src, "-o", obj],
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    out = proc.stdout.decode("utf-8", "replace")
    lines = [ln.rstrip("\r") for ln in out.split("\n")]
    if lines and lines[-1] == "":
        lines.pop()
    return proc.returncode, lines


FAILS = []


def check(name, cond, detail=""):
    if cond:
        if VERBOSE:
            print("  ok   %s" % name)
        return
    FAILS.append("%s%s" % (name, (": " + detail) if detail else ""))
    print("  FAIL %s%s" % (name, (": " + detail) if detail else ""))


def caret_index(line):
    """Index of the caret in a caret line, or -1. Tabs count as one byte here
    because the caret line reproduces them."""
    return line.find("^")


def case_long_line():
    prefix = "int f(void){ int "
    longname = "a" * 560
    text = "%s%s; int %s; return 0; }\n" % (prefix, longname, longname)
    rc, lines = run("long_line.c", text)
    check("long_line/rc", rc == 1, "rc=%d" % rc)
    errs = [ln for ln in lines if ": Error: " in ln]
    check("long_line/one_error", len(errs) == 1, "%d errors" % len(errs))
    check("long_line/message_truncated",
          errs and errs[0].endswith("...") and len(errs[0]) <= LINE_MAX,
          "len=%d tail=%r" % (len(errs[0]) if errs else -1,
                              errs[0][-6:] if errs else ""))
    caret_lines = [ln for ln in lines if ln.strip() == "^" or ln.strip() == "" and "^" in ln]
    carets = [ln for ln in lines if "^" in ln]
    check("long_line/no_caret", not carets, "caret line %r" % (carets[:1],))
    echo = [ln for ln in lines if ln.startswith(GUTTER + "int f(void){")]
    check("long_line/echo_present", len(echo) == 1)
    check("long_line/echo_truncated",
          echo and echo[0].endswith("..."),
          "tail=%r" % (echo[0][-6:] if echo else ""))


def case_many_errors():
    body = "".join(" int a;\n" for _ in range(40))
    text = "int f(void){\n%s return a; }\n" % body
    rc, lines = run("many_errors.c", text)
    errs = [ln for ln in lines if ": Error: " in ln]
    check("many_errors/rc", rc == 1, "rc=%d" % rc)
    check("many_errors/limit", len(errs) == 30, "%d errors" % len(errs))
    summary = [ln for ln in lines if ln.endswith("errors")]
    check("many_errors/summary", summary and summary[-1].endswith("30 errors"),
          summary[-1] if summary else "no summary")


def case_same_line():
    text = "int f(void){ int a; int a; int b; int b; return a; }\n"
    rc, lines = run("same_line.c", text)
    errs = [ln for ln in lines if ": Error: " in ln]
    check("same_line/rc", rc == 1, "rc=%d" % rc)
    check("same_line/two_errors", len(errs) == 2, "%d errors" % len(errs))
    # Each error is followed by an echo and then a caret line.
    carets = [ln for ln in lines if "^" in ln]
    check("same_line/two_carets", len(carets) == 2, "%d caret lines" % len(carets))
    check("same_line/carets_differ", len(carets) == 2 and carets[0] != carets[1],
          "both carets at the same column: %r" % (carets[:1],))


def case_cjk():
    comment = "/* \u4e2d\u6587\u6ce8\u91ca */ "
    text = comment + "int f(void){ int a; int a; return a; }\n"
    rc, lines = run("cjk.c", text)
    errs = [ln for ln in lines if ": Error: " in ln]
    check("cjk/rc", rc == 1, "rc=%d" % rc)
    check("cjk/one_error", len(errs) == 1, "%d errors" % len(errs))
    carets = [ln for ln in lines if "^" in ln]
    check("cjk/caret_present", len(carets) == 1, "%d caret lines" % len(carets))
    if carets:
        # the duplicated `a` is the token after "{ int a; int "
        prefix = comment + "int f(void){ int a; int "
        want = len(GUTTER) + display_width(prefix)
        got = caret_index(carets[0])
        check("cjk/caret_in_display_cells", got == want,
              "caret at %d, want %d (bytes: %d)"
              % (got, want, len(GUTTER.encode()) + len(prefix.encode())))


def case_tab():
    text = "\tint f(void){ int a; int a; return a; }\n"
    rc, lines = run("tab.c", text)
    errs = [ln for ln in lines if ": Error: " in ln]
    check("tab/rc", rc == 1, "rc=%d" % rc)
    check("tab/one_error", len(errs) == 1, "%d errors" % len(errs))
    carets = [ln for ln in lines if "^" in ln]
    check("tab/caret_present", len(carets) == 1, "%d caret lines" % len(carets))
    if carets:
        prefix = "\tint f(void){ int a; int "
        want = len(GUTTER) + display_width(prefix)
        got = caret_index(carets[0])
        check("tab/tab_replayed", "\t" in carets[0], "no tab in caret line")
        check("tab/caret_after_tab", got == want, "caret at %d, want %d" % (got, want))


def main():
    if not os.path.exists(ARKCC):
        print("arkcc not found: %s (set ARKCC=<path>)" % ARKCC)
        return 2
    print("boundary diagnostics against %s" % ARKCC)
    for fn in (case_long_line, case_many_errors, case_same_line, case_cjk, case_tab):
        print(fn.__name__.replace("case_", ""))
        fn()
    if FAILS:
        print("%d failure(s)" % len(FAILS))
        return 1
    print("all boundary assertions held")
    return 0


if __name__ == "__main__":
    sys.exit(main())
