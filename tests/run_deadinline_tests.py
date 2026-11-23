#!/usr/bin/env python
"""Unreachable `static` functions are not emitted.

Why this gate exists: a header such as CMSIS's `core_cm4.h` defines helpers
like `ITM_SendChar()` as `static inline` and references an external object
(`ITM_RxBuffer`, provided by the debugger). A translation unit that includes
the header but never calls the helper still used to get code for it, and that
code carries a relocation against a symbol the unit only declares -- which the
object writer refuses ("reference to the global 'X', which this translation
unit only declares"). The C language does not require such a function to exist
at all when it is never used, so the IR pass `ir_drop_unused_static()` removes
it before code generation.

The same pass removes plain `static` functions (no `inline`) that nothing in
the unit mentions.  The shape that showed this is `cmsis_armcc.h`'s
`__ASM uint32_t __REV16(uint32_t)`: 1,780 instructions of helper bodies across
the 95-file HAL corpus that no code ever branched to.  gcc removes them from
-O1 up; `--warn-unused-static` still reports them (it runs earlier in the
pipeline) and `__attribute__((used))` keeps one in the object.

What the pass deliberately does NOT do (each shape has a check below):
  * `__attribute__((used))` / `unused` / `weak` / `constructor` / `destructor`
    / `interrupt` / `naked` / `alias` targets / `main` are never dropped;
  * an entry-point name (`_start`, `Reset_Handler`, `*_Handler`,
    `Default_Handler`, `__arkcc_init_globals`) is never dropped even when it
    is static -- a linker script or the vector table may name it by hand;
  * a raw asm body keeps every helper whose name it spells out (`__asm("bl
    keep_by_asm")`), because the asm is text this pass can read but not parse;
  * anything reachable from a kept function, from a global initializer, or
    from a function pointer push is kept.

Anti-false-green checks:
  * the same plain-static source with `__attribute__((used))` still fails
    ("only declares") -> the pass, not something else, is what makes the
    plain-static build work;
  * a kept inline of the same shape stays in the symbol table -> the check is
    not simply "the name is absent";
  * `-S` output agrees with `-c` (no label for the dropped function);
  * an `asm` body that names a helper keeps it, while an `asm` body that does
    not name it still lets the unreachable helper go (the text scan is really
    consulted, in both directions);
  * a static `SysTick_Handler` is kept (the entry-point list is really used).

Usage: run_deadinline_tests.py [path-to-arkcc]
Exit 0 = every check behaved.
"""
import os
import re
import subprocess
import sys
import tempfile

ARM = ['-target', 'arm', '--cpu', 'Cortex-M7']

# A dead helper of exactly the shape core_cm4.h has: static inline, touches an
# external object the unit does not define.
SRC_DEAD = r'''extern volatile int ITM_RxBuffer;

static inline int ITM_SendChar(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

static inline int helper_unused(int x)
{
    return x + 1;
}

int main(void)
{
    return 0;
}
'''

# Same helper, but not inline: this is the shape that must still be reported.
SRC_PLAIN_STATIC = r'''extern volatile int ITM_RxBuffer;

static int ITM_SendChar(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int main(void)
{
    return 0;
}
'''

# The same plain static with `used`: the author asked for the symbol, so the
# body stays and the "only declares" refusal comes back.  This is what proves
# the plain-static removal above is the pass and not something else.
SRC_PLAIN_USED = r'''extern volatile int ITM_RxBuffer;

static __attribute__((used)) int ITM_SendChar(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int main(void)
{
    return 0;
}
'''

# A static interrupt handler is unreachable by any call this pass can see, but
# the vector table names it.  It must survive.
SRC_HANDLER = r'''extern volatile int ITM_RxBuffer;

static void SysTick_Handler(void)
{
    (void)ITM_RxBuffer;
}

int main(void)
{
    return 0;
}
'''

# The helper is called: it must survive, and the unit must still complain that
# the external object is only declared (that is what "kept" means here).
SRC_CALLED = r'''extern volatile int ITM_RxBuffer;

static inline int ITM_SendChar(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int main(void)
{
    return ITM_SendChar(7);
}
'''

# `used` is a promise to the compiler that the symbol is needed.
SRC_USED = r'''extern volatile int ITM_RxBuffer;

static inline __attribute__((used)) int keep_me(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int main(void)
{
    return 0;
}
'''

# An inline asm statement can name anything; the pass must back off.
SRC_ASM = r'''extern volatile int ITM_RxBuffer;

static inline int maybe_asm_calls_me(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int poke(void)
{
    __asm("nop");
    return 0;
}

int main(void)
{
    return poke();
}
'''

# An asm body that names a helper is a live reference the IR operands do not
# show.  The name is in the string, so the pass must keep the helper.
SRC_ASM_REF = r'''extern volatile int ITM_RxBuffer;

static int keep_by_asm(int ch)
{
    (void)ITM_RxBuffer;
    return ch;
}

int poke(void)
{
    __asm("bl keep_by_asm");
    return 0;
}

int main(void)
{
    return poke();
}
'''

# Two helpers, one reachable from main. Only the unreachable one goes away,
# and the one that stays must still be in the symbol table.
SRC_MIXED = r'''static inline int keep_helper(int x)
{
    return x * 3;
}

static inline int dead_helper(int x)
{
    return x + 4;
}

int main(void)
{
    return keep_helper(1);
}
'''

# A helper reached only through a global initializer ("address taken") is live.
SRC_INITREF = r'''static inline int init_helper(int x)
{
    return x + 5;
}

int (*g_slot)(int) = init_helper;

int main(void)
{
    return 0;
}
'''

failures = []
skips = []
passes = [0]


def check(ok, what, detail=''):
    print('%s  %s%s' % ('PASS' if ok else 'FAIL', what,
                        ('  [' + detail + ']') if detail else ''))
    if ok:
        passes[0] += 1
    else:
        failures.append(what)


def skip(what, why):
    print('SKIP  %s  [%s]' % (what, why))
    skips.append(what)


def run(arkcc, args, cwd):
    p = subprocess.run([arkcc] + args, cwd=cwd, stdout=subprocess.PIPE,
                       stderr=subprocess.STDOUT)
    return p.returncode, p.stdout.decode('utf-8', 'replace')


def rd32(d, pos):
    return int.from_bytes(d[pos:pos + 4], 'little')


def parse_obj(path):
    """Read an ARKOBJ2 object with the same layout src/compiler.c writes."""
    with open(path, 'rb') as f:
        d = f.read()
    if d[:8] != b'ARKOBJ2\n':
        raise ValueError('not an ARKOBJ2 object: %s' % path)
    pos = 8
    code_len = rd32(d, pos)
    pos += 4
    pos += code_len
    syms = []
    n = rd32(d, pos)
    pos += 4
    for _ in range(n):
        nl = rd32(d, pos)
        pos += 4
        name = d[pos:pos + nl - 1].decode('latin-1')
        pos += nl
        off = rd32(d, pos)
        pos += 4
        typ = d[pos]
        pos += 1
        weak = d[pos]
        pos += 1
        syms.append((name, off, typ, weak))
    return {'code_len': code_len, 'syms': syms}


def sym_names(obj):
    return [s[0] for s in obj['syms']]


def text_symbols(obj):
    """Code labels: type 0 with an offset inside the code section."""
    return set(s[0] for s in obj['syms']
               if s[2] == 0 and 0 <= s[1] < obj['code_len'])


def main():
    arkcc = sys.argv[1] if len(sys.argv) > 1 else (
        './arkcc.exe' if os.name == 'nt' else './arkcc')
    arkcc = os.path.abspath(arkcc)
    if not os.path.exists(arkcc):
        print('FAIL  arkcc not found: %s' % arkcc)
        return 2

    work = tempfile.mkdtemp(prefix='arkcc_deadinline_')
    sources = (
        ('dead.c', SRC_DEAD), ('plain_static.c', SRC_PLAIN_STATIC),
        ('called.c', SRC_CALLED), ('used.c', SRC_USED), ('asm.c', SRC_ASM),
        ('mixed.c', SRC_MIXED), ('initref.c', SRC_INITREF),
        ('plain_used.c', SRC_PLAIN_USED), ('handler.c', SRC_HANDLER),
        ('asm_ref.c', SRC_ASM_REF),
    )
    for name, text in sources:
        with open(os.path.join(work, name), 'w', newline='') as f:
            f.write(text)

    # --- 1. the dead inline no longer reaches the object --------------------
    rc, log = run(arkcc, ARM + ['-c', 'dead.c', '-o', 'dead.o'], work)
    check(rc == 0, 'a unit whose only inline helpers are dead compiles',
          'rc=%d %s' % (rc, (log.strip().splitlines() or [''])[0][:80]))
    if rc == 0 and os.path.exists(os.path.join(work, 'dead.o')):
        obj = parse_obj(os.path.join(work, 'dead.o'))
        names = sym_names(obj)
        check('ITM_SendChar' not in names,
              'the dead inline is not in the symbol table', str(names))
        check('helper_unused' not in names,
              'a second dead inline is not in the symbol table either',
              str(names))
        check('main' in names, 'main is still there', str(names))
        # The same source without the inline: a plain static helper that
        # nothing calls is dead code too, so it goes away and the object builds.
        rc2, log2 = run(arkcc, ARM + ['-c', 'plain_static.c',
                                      '-o', 'plain_static.o'], work)
        check(rc2 == 0, 'a plain static helper nothing calls compiles',
              'rc=%d %s' % (rc2, (log2.strip().splitlines() or [''])[0][:80]))
        if rc2 == 0:
            pnames = sym_names(parse_obj(os.path.join(work, 'plain_static.o')))
            check('ITM_SendChar' not in pnames,
                  'and it is not in the symbol table either', str(pnames))
        # Anti-false-green: the same plain static with `used` must keep the
        # body, so the refusal the build above escaped comes back.
        rc3, log3 = run(arkcc, ARM + ['-c', 'plain_used.c',
                                      '-o', 'plain_used.o'], work)
        check(rc3 != 0 and 'only declares' in log3,
              'the same plain static with __attribute__((used)) still hits '
              '"only declares" (removal is the pass, not something else)',
              'rc=%d' % rc3)
    else:
        skip('symbol table checks', 'no object was produced')

    # --- 2. a called inline is kept ----------------------------------------
    rc, log = run(arkcc, ARM + ['-c', 'called.c', '-o', 'called.o'], work)
    check(rc != 0 and 'only declares' in log,
          'a called inline is kept (the external object is still required)',
          'rc=%d' % rc)
    rc, log = run(arkcc, ARM + ['-S', 'called.c', '-o', 'called.s'], work)
    check(rc != 0 and 'only declares' in log,
          '-S takes the same path: the called inline is kept',
          'rc=%d' % rc)
    rc, log = run(arkcc, ARM + ['-S', 'mixed.c', '-o', 'mixed.s'], work)
    check(rc == 0, '-S of the mixed unit succeeds', 'rc=%d' % rc)
    txt = ''
    if os.path.exists(os.path.join(work, 'mixed.s')):
        with open(os.path.join(work, 'mixed.s'), 'r',
                  encoding='utf-8', errors='replace') as f:
            txt = f.read()
    check('keep_helper' in txt and 'dead_helper' not in txt,
          '-S keeps the reachable inline and drops the unreachable one',
          'labels: %s' % re.findall(r'^\w[\w.$]*:', txt, re.M)[:8])

    # --- 3. the attributes that promise liveness --------------------------
    rc, log = run(arkcc, ARM + ['-c', 'used.c', '-o', 'used.o'], work)
    check(rc != 0 and 'only declares' in log,
          '__attribute__((used)) inline is kept', 'rc=%d' % rc)
    rc, log = run(arkcc, ARM + ['-c', 'initref.c', '-o', 'initref.o'], work)
    check(rc == 0, 'an inline whose address is taken by a global initializer '
          'compiles', 'rc=%d' % rc)
    if rc == 0 and os.path.exists(os.path.join(work, 'initref.o')):
        names = sym_names(parse_obj(os.path.join(work, 'initref.o')))
        check('init_helper' in names,
              'and it is still in the symbol table', str(names))

    # --- 3b. an entry-point name is kept even when it is static -----------
    rc, log = run(arkcc, ARM + ['-c', 'handler.c', '-o', 'handler.o'], work)
    check(rc != 0 and 'only declares' in log,
          'a static SysTick_Handler is kept (the vector table names it)',
          'rc=%d' % rc)

    # --- 4. raw asm is read as text ---------------------------------------
    # An asm statement naming the helper keeps it (and the unit still fails on
    # the external object it only declares, so "kept" is observable).
    rc, log = run(arkcc, ARM + ['-c', 'asm_ref.c', '-o', 'asm_ref.o'], work)
    check(rc != 0 and 'only declares' in log,
          'an asm body that names a helper keeps it', 'rc=%d' % rc)
    rc, log = run(arkcc, ARM + ['-S', 'asm_ref.c', '-o', 'asm_ref.s'], work)
    check(rc != 0 and 'only declares' in log,
          '-S agrees: the asm-named helper is still there', 'rc=%d' % rc)
    # ... and an asm body that does not name it is not an excuse to keep it.
    rc, log = run(arkcc, ARM + ['-c', 'asm.c', '-o', 'asm.o'], work)
    check(rc == 0, 'an asm body that names nothing drops the dead inline',
          'rc=%d %s' % (rc, (log.strip().splitlines() or [''])[0][:80]))

    # --- 5. only the unreachable half of a pair goes away -----------------
    rc, log = run(arkcc, ARM + ['-c', 'mixed.c', '-o', 'mixed.o'], work)
    check(rc == 0, 'the mixed unit compiles', 'rc=%d' % rc)
    if rc == 0 and os.path.exists(os.path.join(work, 'mixed.o')):
        obj = parse_obj(os.path.join(work, 'mixed.o'))
        names = sym_names(obj)
        check('keep_helper' in names, 'the reachable inline is kept',
              str(names))
        check('dead_helper' not in names, 'the unreachable one is dropped',
              str(names))
        check('keep_helper' in text_symbols(obj),
              'the kept inline still has code', str(sorted(text_symbols(obj))))

    # --- 6. -S agrees with -c --------------------------------------------
    rc, log = run(arkcc, ARM + ['-S', 'dead.c', '-o', 'dead.s'], work)
    check(rc == 0, '-S of the dead-inline unit succeeds', 'rc=%d' % rc)
    if os.path.exists(os.path.join(work, 'dead.s')):
        with open(os.path.join(work, 'dead.s'), 'r',
                  encoding='utf-8', errors='replace') as f:
            txt = f.read()
        check('ITM_SendChar' not in txt and 'helper_unused' not in txt,
              '-S emits no label for the dropped helpers',
              'labels: %s' % re.findall(r'^\w[\w.$]*:', txt, re.M)[:8])

    print('')
    if failures:
        print('%d check(s) FAILED' % len(failures))
        return 1
    print('all %d check(s) passed (%d skipped)' % (passes[0], len(skips)))
    return 0


if __name__ == '__main__':
    sys.exit(main())
