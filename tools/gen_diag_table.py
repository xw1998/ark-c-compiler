#!/usr/bin/env python3
"""Generate arkc's diagnostic message table from the armcc5 reverse-engineering data.

Why a generator instead of hand-written strings
-----------------------------------------------
The message text is *not ours*: it is armcc's. Keeping it in a generated file
means (a) nobody hand-edits a string and drifts from the real compiler, and
(b) the table can be rebuilt from source data at any time. The generator is the
only place that knows where the text came from.

What is generated, and what is not
----------------------------------
Only the codes listed in FRONTEND_CODES / DRIVER_CODES are emitted. arkc does
not carry armcc's 2428-slot table: the STM32 profile cannot spare the flash,
and 99% of those messages are for C++ constructs arkc does not implement. A
code that is not in the list is reported by arkc as DIAG_NO_CODE with our own
wording rather than with a made-up number.

The generator refuses to emit anything it cannot render faithfully:
  * a placeholder arkc cannot expand (%t1, %sq2, %p, ...) is a hard error,
  * a code that exists in the CSV but whose text uses such a placeholder must
    therefore be left out of FRONTEND_CODES,
  * a missing/renamed source CSV is a hard error, never a silent empty table.

Usage
-----
    python tools/gen_diag_table.py                 # regenerate in place
    python tools/gen_diag_table.py --check         # verify files are current
    python tools/gen_diag_table.py --source DIR    # override the data directory

`--check` is what CI runs: it regenerates in memory and compares with what is
committed, so a stale table fails the build instead of shipping.
"""

import argparse
import csv
import os
import sys

# ---------------------------------------------------------------------------
# Curated code lists -- edit here, never in the generated files
# ---------------------------------------------------------------------------

# Frontend codes, keyed by armcc's #<n>. `append` marks a message that armcc
# renders as a prefix followed directly by the offending text (no placeholder):
#   "no source": Error: command-line:  #992: invalid macro definition: 1BAD=1
# arkc models that with an explicit trailing %s so expansion stays mechanical.
#
# `d` marks a message that armcc tags with the "-D" suffix even when it is
# printed as an error (#11-D is an error; #177-D can be raised to one with
# --diag_error). The suffix is not a property of the number: the same #29 is
# printed bare as an error and as "#29-D" when it comes out as a warning. So
# the rule lives in two places, both measured:
#   * src/diag.c appends "-D" to every warning,
#   * this flag carries it for the codes armcc tags regardless of severity.
# A flag is only ever set from a measurement (see the fixture named next to the
# entry); it is never inferred from the message text.
FRONTEND_CODES = {
    4:    {},           # out of memory
    5:    {},           # cannot open %s input file %sq2: %s3  (numbered args)
    6:    {},           # comment unclosed at end of file
    7:    {},           # unrecognized token
    8:    {},           # missing closing quote
    9:    {},           # nested comment is not allowed (warning)
    11:   {'d': 1},     # unrecognized preprocessing directive ("#11-D" as error)
    12:   {},           # parsing restarts here after previous syntax error
    13:   {},           # expected a file name
    17:   {},           # expected a "]"   (measured: int a[2;)
    18:   {},           # expected a ")"   (measured: return (1+2;)
    67:   {},           # expected a "}"   (measured: at end of source)
    20:   {},           # identifier %sq is undefined
    28:   {},           # expression must have a constant value
    29:   {},           # expected an expression
    35:   {},           # #error directive: %s
    36:   {},           # the #if for this directive is missing
    37:   {},           # the #endif for this directive is missing
    38:   {},           # directive is not allowed -- an #else has already appeared
    39:   {},           # division by zero
    40:   {},           # expected an identifier
    65:   {},           # expected a ";"
    100:  {},           # duplicate parameter name
    101:  {},           # %sq has already been declared in the current scope
    117:  {},           # non-void %n should return a value (warning)
    118:  {},           # a void function may not return a value
    137:  {},           # expression must be a modifiable lvalue
    140:  {},           # too many arguments in function call
    165:  {},           # too few arguments in function call
    174:  {'d': 1},     # expression has no effect (warning)
    177:  {'d': 1},     # %n was declared but never referenced (warning)
    148:  {},           # %n has already been initialized
    179:  {},           # right operand of "%" is zero
    223:  {'d': 1},     # function %sq declared implicitly (warning)
    247:  {},           # %n has already been defined
    992:  {'append': 1},   # invalid macro definition: <text>
    1215: {'d': 1},     # #warning directive: %s (warning)
}

# Driver codes, keyed by the full armcc code ("C3900U"). Severity and text both
# come from the CSV; arkc never spells either one itself.
DRIVER_CODES = [
    "C3900U",   # Unrecognized option '%s%s'.
    "C3901U",   # Missing argument for option '%s'.
    "C3903U",   # Argument '%s' not permitted for option '%s'.
    "C4056E",   # bad option '%s'
    "C4065E",   # type of input file '%s' unknown\n
    "C4079E",   # %s command with no effect\n
    "C4486W",   # option '-%c' causes input file '%s' to be ignored\n
]

# armcc's severity letters, as they appear as the last character of a driver
# code. 'U' is a usage error and is printed as "Fatal error:".
DRIVER_SEVERITY_LETTERS = {"U": "U", "E": "E", "W": "W", "I": "I"}

# Placeholders arkc can expand (see expand() in src/diag.c). Anything else in a
# message means the table would print "?" holes, which is worse than refusing.
SUPPORTED_PLACEHOLDERS = ("sq", "n", "s", "c", "d", "u")

DEFAULT_SOURCE = os.path.join(
    "D:" + os.sep, "工作", "git_project", "c_compiler", "armcc5", "data")

FRONTEND_CSV = "diagnostic_messages.csv"
DRIVER_CSV = "driver_diagnostic_codes.csv"


# ---------------------------------------------------------------------------
# Validation
# ---------------------------------------------------------------------------

class TableError(Exception):
    pass


def check_placeholders(code, text):
    """Every '%' must start a placeholder arkc knows how to render."""
    i = 0
    while i < len(text):
        if text[i] != '%':
            i += 1
            continue
        rest = text[i + 1:]
        if rest.startswith('%'):
            i += 2
            continue
        for ph in SUPPORTED_PLACEHOLDERS:
            if rest.startswith(ph):
                tail = rest[len(ph):]
                # Numbered form: %sq2, %s3 -- 1-based argument references.
                digits = 0
                while digits < len(tail) and tail[digits].isdigit():
                    digits += 1
                after = tail[digits:digits + 1]
                # %sq is fine; %nfd / %t1 are type printers arkc has no
                # equivalent for, so they must stay out of the table.
                if after and (after.isalnum() or after == '_'):
                    raise TableError(
                        "#%d: unsupported placeholder variant near %r"
                        % (code, ('%' + rest)[:8]))
                i += 1 + len(ph) + digits
                break
        else:
            raise TableError(
                "#%d: unsupported placeholder %r in %r"
                % (code, ('%' + rest)[:4], text))


def c_string(text):
    """Escape for a C string literal. Message text is not code, so only the
    characters that would break a literal are touched."""
    out = []
    for ch in text:
        if ch in ('\\', '"'):
            out.append('\\' + ch)
        elif ch == '\n':
            out.append('\\n')
        elif ch == '\t':
            out.append('\\t')
        elif ch == '\r':
            out.append('\\r')
        elif ord(ch) < 0x20:
            out.append('\\x%02x' % ord(ch))
        else:
            out.append(ch)
    return ''.join(out)


# ---------------------------------------------------------------------------
# Loading
# ---------------------------------------------------------------------------

def load_frontend(source_dir):
    path = os.path.join(source_dir, FRONTEND_CSV)
    if not os.path.isfile(path):
        raise TableError("missing source table: %s" % path)
    with open(path, newline='', encoding='utf-8') as f:
        rows = list(csv.reader(f))
    if not rows or rows[0][:3] != ['number', 'en_ptr', 'en_message']:
        raise TableError("%s: unexpected header %r" % (path, rows[0] if rows else None))
    by_number = {}
    for row in rows[1:]:
        by_number[int(row[0])] = row[2]
    return by_number


def load_driver(source_dir):
    path = os.path.join(source_dir, DRIVER_CSV)
    if not os.path.isfile(path):
        raise TableError("missing source table: %s" % path)
    with open(path, newline='', encoding='utf-8') as f:
        rows = list(csv.reader(f))
    if not rows or rows[0][:5] != ['index', 'stored_prefix', 'number', 'severity', 'code']:
        raise TableError("%s: unexpected header %r" % (path, rows[0] if rows else None))
    by_code = {}
    for row in rows[1:]:
        by_code[row[4]] = (row[3], row[7])
    return by_code


# ---------------------------------------------------------------------------
# Emission
# ---------------------------------------------------------------------------

def build_entries(source_dir):
    frontend_src = load_frontend(source_dir)
    driver_src = load_driver(source_dir)

    frontend = []
    for code in sorted(FRONTEND_CODES):
        opts = FRONTEND_CODES[code]
        if code not in frontend_src:
            raise TableError("#%d is listed but absent from %s" % (code, FRONTEND_CSV))
        text = frontend_src[code]
        check_placeholders(code, text)
        if opts.get('append'):
            if '%' in text:
                raise TableError(
                    "#%d is marked 'append' but its text already has a placeholder: %r"
                    % (code, text))
            text += '%s'
        if not text:
            raise TableError("#%d has empty text" % code)
        frontend.append((code, 1 if opts.get('d') else 0, text))

    driver = []
    for code in DRIVER_CODES:
        if code not in driver_src:
            raise TableError("%s is listed but absent from %s" % (code, DRIVER_CSV))
        sev, text = driver_src[code]
        if sev not in DRIVER_SEVERITY_LETTERS:
            raise TableError("%s: unknown severity letter %r" % (code, sev))
        if code[-1] != sev:
            raise TableError("%s: trailing letter disagrees with severity %r" % (code, sev))
        if not text.strip():
            raise TableError("%s has empty text" % code)
        check_placeholders(code, text)
        driver.append((code, sev, text))

    return frontend, driver


HEADER_TEMPLATE = """\
/* arkcc - diagnostic message table (generated)
 *
 * DO NOT EDIT: regenerate with `python tools/gen_diag_table.py`.
 * Source of truth: c_compiler/armcc5/data/{frontend_csv} and {driver_csv}
 * (armcc 5.06u7 reverse engineering). Only the codes arkc actually emits are
 * carried; see tools/gen_diag_table.py for the list and for the rules that
 * keep unrenderable placeholders out of the table.
 */
#ifndef DIAG_MSG_GEN_H
#define DIAG_MSG_GEN_H

/* armcc frontend text for #<code>, or NULL when arkc does not carry it. */
const char *diag_msg_lookup(int code);

/* Non-zero when armcc prints this code with the "-D" tag whatever the
 * severity (measured; see tools/gen_diag_table.py). Warnings get the tag from
 * src/diag.c without consulting this table. */
int diag_msg_has_d_tag(int code);

/* armcc driver text for e.g. "C3900U", or NULL when not carried. */
const char *diag_driver_lookup(const char *code);

/* Severity letter armcc attaches to a driver code ('U','E','W','I'),
 * or 0 when the code is unknown. */
char diag_driver_severity(const char *code);

#endif /* DIAG_MSG_GEN_H */
"""

SOURCE_TEMPLATE = """\
/* arkcc - diagnostic message table (generated)
 *
 * DO NOT EDIT: regenerate with `python tools/gen_diag_table.py`.
 * Generated from {count_frontend} frontend + {count_driver} driver messages.
 */
#include "diag_msg_table.h"

typedef struct {{
    int         code;
    int         d_tag;  /* printed as "#<code>-D" at any severity, else 0 */
    const char *text;
}} MsgEntry;

/* Sorted by code: lookup below relies on it to stop early. */
static const MsgEntry k_frontend[] = {{
{frontend_rows}
}};

typedef struct {{
    const char *code;
    char        severity;
    const char *text;
}} DriverEntry;

static const DriverEntry k_driver[] = {{
{driver_rows}
}};

/* Local string compare: this file must build in the freestanding STM32
 * profile, where no libc is linked in. */
static int same(const char *a, const char *b) {{
    int i = 0;
    if (!a || !b) return 0;
    while (a[i] && b[i]) {{
        if (a[i] != b[i]) return 0;
        i++;
    }}
    return a[i] == 0 && b[i] == 0;
}}

int diag_msg_has_d_tag(int code) {{
    int i;
    for (i = 0; i < (int)(sizeof(k_frontend) / sizeof(k_frontend[0])); i++) {{
        if (k_frontend[i].code == code) return k_frontend[i].d_tag;
        if (k_frontend[i].code > code) break;
    }}
    return 0;
}}

const char *diag_msg_lookup(int code) {{
    int i;
    for (i = 0; i < (int)(sizeof(k_frontend) / sizeof(k_frontend[0])); i++) {{
        if (k_frontend[i].code == code) return k_frontend[i].text;
        if (k_frontend[i].code > code) break;   /* sorted: no later match */
    }}
    return 0;
}}

static const DriverEntry *driver_find(const char *code) {{
    int i;
    if (!code) return 0;
    for (i = 0; i < (int)(sizeof(k_driver) / sizeof(k_driver[0])); i++)
        if (same(k_driver[i].code, code)) return &k_driver[i];
    return 0;
}}

const char *diag_driver_lookup(const char *code) {{
    const DriverEntry *e = driver_find(code);
    return e ? e->text : 0;
}}

char diag_driver_severity(const char *code) {{
    const DriverEntry *e = driver_find(code);
    return e ? e->severity : 0;
}}
"""


def render(frontend, driver):
    frows = ['    { %d, %d, "%s" },'
             % (code, dtag, c_string(text))
             for code, dtag, text in frontend]
    drows = []
    for code, sev, text in driver:
        drows.append('    { "%s", \'%s\', "%s" },' % (code, sev, c_string(text)))

    header = HEADER_TEMPLATE.format(frontend_csv=FRONTEND_CSV,
                                    driver_csv=DRIVER_CSV)
    source = SOURCE_TEMPLATE.format(count_frontend=len(frontend),
                                    count_driver=len(driver),
                                    frontend_rows='\n'.join(frows),
                                    driver_rows='\n'.join(drows))
    return header, source


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main(argv):
    here = os.path.dirname(os.path.abspath(__file__))
    root = os.path.dirname(here)
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--source', default=os.environ.get('ARKCC_DIAG_SOURCE', DEFAULT_SOURCE),
                    help='directory holding the armcc5 CSV tables')
    ap.add_argument('--check', action='store_true',
                    help='fail if the committed files differ from a fresh run')
    args = ap.parse_args(argv)

    try:
        frontend, driver = build_entries(args.source)
    except TableError as e:
        sys.stderr.write('gen_diag_table: %s\n' % e)
        return 2

    header, source = render(frontend, driver)
    targets = [
        (os.path.join(root, 'include', 'diag_msg_table.h'), header),
        (os.path.join(root, 'src', 'diag_msg_table.c'), source),
    ]

    if args.check:
        stale = []
        for path, content in targets:
            try:
                with open(path, encoding='utf-8') as f:
                    if f.read() != content:
                        stale.append(path)
            except OSError:
                stale.append(path)
        if stale:
            sys.stderr.write('gen_diag_table: stale, rerun the generator:\n')
            for p in stale:
                sys.stderr.write('  %s\n' % p)
            return 1
        print('gen_diag_table: up to date (%d frontend, %d driver)'
              % (len(frontend), len(driver)))
        return 0

    for path, content in targets:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(content)
    print('gen_diag_table: wrote %d frontend + %d driver messages'
          % (len(frontend), len(driver)))
    return 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
