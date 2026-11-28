#!/usr/bin/env python3
"""Measure what an RMIR emitter would have to beat (S58 pre-registration).

Section 58 freezes alpha-3's target before any emitter exists, so the baseline
is measured, not guessed:

  * the corpus total under the measured optimisation stack (pinned at HEAD);
  * that total split per function, so the part carried by the functions the
    register machine can translate is known;
  * the split again by the 8-register pool's spill count, because a function
    that spills is not emitted in the first slice (0-4 spills is admitted with
    one frame slot per spill; more than 4 stays on the old path);
  * the three instruction families an emitter can actually remove -- the
    accumulator round trip, the value-stack PUSH/POP, and frame-slot access --
    counted over the emitted set.

Usage:
    python tools/measure_rmir_emit_baseline.py [path/to/arkcc.exe]

The numbers this prints are the ones section 58 pins.
"""
import collections
import os
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tests'))
import run_chainfold_tests as H                       # noqa: E402

STACK = ['-fopt-chainfold', '-fopt-pushpop', '-fopt-remat']
SPILL_BUDGET = 4          # spills admitted per function in alpha-3


def split_funcs(text):
    """Split emitted text into (name, [instruction lines])."""
    cur, buf = None, []
    for ln in text.splitlines():
        s = ln.strip()
        if s.endswith(':') and not s.startswith('.') and len(s) > 1:
            if cur is not None:
                yield cur, buf
            cur, buf = s[:-1], []
        elif cur is not None:
            buf.append(ln)
    if cur is not None:
        yield cur, buf


def main():
    arkcc = os.path.abspath(sys.argv[1] if len(sys.argv) > 1
                            else os.path.join(ROOT, 'arkcc.exe'))
    work = tempfile.mkdtemp(prefix='rmir_emit_')
    fam = collections.Counter()
    total = 0
    in_set = out_set = 0
    n_in = n_out = 0
    spillers = []
    for src in H.corpus_units():
        out = os.path.join(work, 'o.s')
        cmd = [arkcc] + H.ASM_ARM + H.COMMON + ['-S', '-o', out, src]
        for d in H.INC_DIRS:
            cmd += ['-I', d]
        cmd += list(H.BASE) + STACK
        p = subprocess.run(cmd, cwd=work, stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT)
        if p.returncode != 0:
            print('build failed: %s' % src)
            return 2
        text = H.read_text(out)
        env = dict(os.environ)
        env.update({'ARKCC_RMIR_COV': '1', 'ARKCC_RMIR_PHI': '1',
                    'ARKCC_RMIR_LS': '1', 'ARKCC_RMIR_DUMP': '1'})
        log = subprocess.run(cmd, cwd=work, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT,
                             env=env).stdout.decode('utf-8', 'replace')
        ls = {}
        for ln in log.splitlines():
            if ln.startswith('rmir-ls ') and ': values=' in ln:
                nm, rest = ln[len('rmir-ls '):].split(': ', 1)
                ls[nm] = dict((k, int(v)) for k, v in
                              (kv.split('=') for kv in rest.split()))
        for nm, lines in split_funcs(text):
            n = sum(1 for ln in lines if H.is_insn(ln))
            total += n
            d = ls.get(nm)
            if d is None:
                continue
            if d['spills8'] > SPILL_BUDGET:
                out_set += n
                n_out += 1
                spillers.append((nm, d['spills8'], n))
                continue
            in_set += n
            n_in += 1
            for ln in lines:
                mn, rest = H.insn(ln)
                if mn is None:
                    continue
                fam['all'] += 1
                if mn in ('MOV', 'MOVW', 'MOVT'):
                    fam['mov'] += 1
                    if 'r0' in rest:
                        fam['mov_r0'] += 1
                if mn in ('PUSH', 'POP'):
                    fam['pushpop'] += 1
                if mn.startswith(('LDR', 'STR')):
                    if 'sp' in rest:
                        fam['frame'] += 1
                    else:
                        fam['mem_other'] += 1
    print('corpus total            %d' % total)
    print('emitted set (<=%d spills) %d insns in %d functions'
          % (SPILL_BUDGET, in_set, n_in))
    print('old-path set            %d insns in %d functions'
          % (out_set, n_out))
    for nm, s8, n in sorted(spillers, key=lambda x: -x[2]):
        print('   %-36s spills8=%-4d insns=%d' % (nm, s8, n))
    print('families over the emitted set: %s'
          % dict((k, fam[k]) for k in ('all', 'mov', 'mov_r0', 'pushpop',
                                       'frame', 'mem_other')))
    return 0


if __name__ == '__main__':
    sys.exit(main())
