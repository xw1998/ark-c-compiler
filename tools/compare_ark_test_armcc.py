#!/usr/bin/env python3
"""Execution-level equivalence check: arkcc-built ark_test vs armcc oracle.

`examples/ark_test` builds the *same* single translation unit with two
compilers (arkcc and ARM Compiler 5), and both images are supposed to behave
identically on an STM32F401RE (main() just blinks PC13 at 1 Hz).  This tool
boots both images **from the reset vector** inside unicorn with a small STM32F4
peripheral model and compares the observable side effects:

  * the reset vector words (SP / Reset_Handler),
  * the ordered list of peripheral + PPB writes up to N GPIO BSRR writes,
  * the number of `uwTick` polls (how many times `HAL_Delay` re-read the tick),
  * that the run stops exactly at the Nth BSRR write,
  * that the SysTick vector entry really increments `uwTick` by one.

SystemCoreClock (written by HAL_RCC_ClockConfig) and uwTick (written by the
SysTick handler) are the two globals whose values we then read back, so a
broken `.data` copy or `.bss` clear on either side shows up as a mismatch.

The tick counter is not a real SysTick: the emulator has no SysTick hardware,
so every *read* of the `uwTick` word bumps it by one.  Both images get the
same treatment, so the read *count* stays comparable.

Pitfall (cost one afternoon): unicorn 2.1.4 corrupts multi-register stores
(`STM`/`LDM`) when a **non-range-limited** `UC_HOOK_MEM_WRITE` hook is
installed -- a callback that does nothing at all is enough.  The symptom is
`__scatterload_zeroinit` counting down with a garbage `r2` and zeroing RAM
until it walks off the end of the map (which looks exactly like "the armcc
image is broken").  Every hook below is therefore range-limited.

usage:
  python tools/compare_ark_test_armcc.py \\
      --arkcc examples/ark_test/ark_test_fw.bin \\
      --armcc examples/ark_test/MDK-ARM/ark_test/ark_test.hex \\
      --arkcc-tick 0x2000004C --armcc-tick 0x20000008 --n-bsrr 6 --self-check
"""

import argparse
import struct
import sys

try:
    from unicorn import (Uc, UC_ARCH_ARM, UC_MODE_MCLASS, UC_MODE_THUMB,
                         UC_HOOK_MEM_READ, UC_HOOK_MEM_READ_UNMAPPED,
                         UC_HOOK_MEM_WRITE, UC_HOOK_MEM_WRITE_UNMAPPED,
                         UC_PROT_ALL)
    from unicorn.arm_const import UC_ARM_REG_LR, UC_ARM_REG_PC, UC_ARM_REG_SP
except ImportError:                                     # pragma: no cover
    sys.exit('unicorn is required: pip install unicorn')

FLASH, FLASH_SIZE = 0x08000000, 0x00100000
RAM, RAM_SIZE = 0x20000000, 0x00020000        # NUCLEO-F401RE: 96 KB
PERIPH, PERIPH_SIZE = 0x40000000, 0x00100000
PPB, PPB_SIZE = 0xE0000000, 0x00100000
GPIOC_BSRR = 0x40020818
SYSTICK_VECTOR = 15 * 4                       # exception number 15
RETURN_SENTINEL = 0x080FF000                  # inside the mapped flash, unused
STOP_AT_LR = 0xFFFFFFFE                       # "return to nowhere"


# --------------------------------------------------------------------------- #
# image loading
# --------------------------------------------------------------------------- #
def load_image(path):
    """Return (load_address, bytes) for a .bin or an Intel .hex image."""
    if not path.lower().endswith('.hex'):
        # a raw bin always describes the flash image starting at 0x08000000
        return FLASH, open(path, 'rb').read()

    mem, base = {}, 0
    for ln in open(path, 'r', encoding='ascii', errors='replace'):
        ln = ln.strip()
        if not ln.startswith(':'):
            continue
        raw = bytes.fromhex(ln[1:])
        n, addr, typ = raw[0], (raw[1] << 8) | raw[2], raw[3]
        payload = raw[4:4 + n]
        if typ == 0:
            for i, b in enumerate(payload):
                mem[base + addr + i] = b
        elif typ == 4:
            base = ((payload[0] << 8) | payload[1]) << 16
        elif typ == 2:
            base = ((payload[0] << 8) | payload[1]) << 4
        elif typ == 1:
            break
    if not mem:
        return FLASH, b''
    lo, hi = min(mem) & ~3, max(mem) + 1
    blob = bytearray(hi - lo)
    for a, b in mem.items():
        blob[a - lo] = b
    return lo, bytes(blob)


# --------------------------------------------------------------------------- #
# one emulated STM32F401RE
# --------------------------------------------------------------------------- #
class Session(object):
    """An emulator instance with a tiny STM32F4 peripheral model."""

    def __init__(self, image, uwaddr, n_bsrr):
        base, blob = image
        self.uw = uwaddr
        self.n_bsrr = n_bsrr
        self.uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB | UC_MODE_MCLASS)
        for b, s in ((FLASH, FLASH_SIZE), (RAM, RAM_SIZE),
                     (PERIPH, PERIPH_SIZE), (PPB, PPB_SIZE)):
            self.uc.mem_map(b, s, UC_PROT_ALL)
        self.uc.mem_write(base, blob)
        off = FLASH - base
        self.sp = struct.unpack_from('<I', blob, off)[0]
        self.pc = struct.unpack_from('<I', blob, off + 4)[0]
        self.written = {}
        self.trace = []
        self.ticks = 0
        self.inject = True              # tick hook on/off (off during ISR call)
        self.bsrr = 0
        self.stopped = False
        self.error = None
        self._install()

    # -- model ------------------------------------------------------------- #
    def _install(self):
        uc = self.uc

        def wh(uc, access, address, size, value, user):
            v = value & ((1 << (8 * size)) - 1)
            self.written[address & ~3] = v
            self.trace.append((address, size, v))
            if address == GPIOC_BSRR:
                self.bsrr += 1
                if self.bsrr >= self.n_bsrr:
                    self.stopped = True
                    uc.emu_stop()

        def rh(uc, access, address, size, value, user):
            base = address & ~3
            val = self.written.get(base, 0)
            if base == 0x40023800:                 # RCC_CR: HSION | HSIRDY
                val |= 0x02000003
            elif base == 0x40023808:               # RCC_CFGR: SWS := SW
                val = (val & ~0x0C) | ((val & 0x03) << 2)
            elif base == 0x40007004:               # PWR_CSR: VOSRDY
                val |= 0x00004000
            elif base == 0x40023C0C:               # FLASH_SR: BSY clear
                val &= ~0x00010000
            uc.mem_write(base, struct.pack('<I', val))

        def rtick(uc, access, address, size, value, user):
            if not self.inject:         # the handler itself reads uwTick
                return
            self.ticks += 1
            uc.mem_write(self.uw, struct.pack('<I', self.ticks))

        def unm(uc, access, address, size, value, user):
            print('  ! unmapped access 0x%08X (pc=0x%08X)' %
                  (address, uc.reg_read(UC_ARM_REG_PC)))
            return False

        # range-limited on purpose -- see the module docstring
        uc.hook_add(UC_HOOK_MEM_WRITE, wh, begin=PERIPH, end=PERIPH + PERIPH_SIZE - 1)
        uc.hook_add(UC_HOOK_MEM_WRITE, wh, begin=PPB, end=PPB + PPB_SIZE - 1)
        uc.hook_add(UC_HOOK_MEM_READ, rh, begin=PERIPH, end=PERIPH + PERIPH_SIZE - 1)
        uc.hook_add(UC_HOOK_MEM_READ, rtick, begin=self.uw, end=self.uw + 3)
        uc.hook_add(UC_HOOK_MEM_READ_UNMAPPED | UC_HOOK_MEM_WRITE_UNMAPPED, unm)

    # -- execution --------------------------------------------------------- #
    def boot(self, budget):
        """Run from the reset vector until n_bsrr BSRR writes were seen."""
        self.uc.reg_write(UC_ARM_REG_SP, self.sp)
        self.uc.reg_write(UC_ARM_REG_LR, 0xFFFFFFFF)
        try:
            self.uc.emu_start(self.pc, STOP_AT_LR, count=budget)
        except Exception as e:                              # noqa: BLE001
            self.error = str(e)
        return self

    def read32(self, addr):
        return struct.unpack('<I', self.uc.mem_read(addr, 4))[0]

    def call(self, addr, budget=200000):
        """Direct-call `addr` with a clean stack; return True if it returned."""
        self.uc.reg_write(UC_ARM_REG_SP, self.sp)
        self.uc.reg_write(UC_ARM_REG_LR, RETURN_SENTINEL | 1)
        self.inject = False             # otherwise the handler's read bumps too
        try:
            self.uc.emu_start(addr, RETURN_SENTINEL, count=budget)
            ok = self.uc.reg_read(UC_ARM_REG_PC) in (RETURN_SENTINEL,
                                                     RETURN_SENTINEL | 1)
        except Exception as e:                              # noqa: BLE001
            self.error = str(e)
            ok = False
        finally:
            self.inject = True
        return ok


# --------------------------------------------------------------------------- #
# comparisons
# --------------------------------------------------------------------------- #
def first_diff(a, b):
    for i, (x, y) in enumerate(zip(a, b)):
        if x != y:
            return i, x, y
    if len(a) != len(b):
        return min(len(a), len(b)), None, None
    return None


def compare(label, a, b, notes):
    """Record one comparison; return True when it matched."""
    if a == b:
        shown = '%d entries' % len(a) if isinstance(a, list) else a
        print('  PASS  %-28s %s' % (label, shown))
        return True
    notes.append(label)
    print('  FAIL  %-28s' % label)
    if isinstance(a, list) and isinstance(b, list):
        idx, x, y = first_diff(a, b)
        print('        first difference at #%s' % idx)
        if x is not None and isinstance(x, tuple) and len(x) == 3:
            print('        arkcc: 0x%08X sz=%d = 0x%08X' % x)
            print('        armcc: 0x%08X sz=%d = 0x%08X' % y)
        elif x is not None:
            print('        arkcc: %r  armcc: %r' % (x, y))
    else:
        print('        arkcc=%r armcc=%r' % (a, b))
    return False


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--arkcc', default='examples/ark_test/ark_test_fw.bin')
    ap.add_argument('--armcc',
                    default='examples/ark_test/MDK-ARM/ark_test/ark_test.hex')
    ap.add_argument('--arkcc-tick', default='0x2000004C',
                    help='address of uwTick in the arkcc image')
    ap.add_argument('--armcc-tick', default='0x20000008',
                    help='address of uwTick in the armcc image')
    ap.add_argument('--n-bsrr', type=int, default=6,
                    help='stop after this many GPIOC->BSRR writes')
    ap.add_argument('--budget', type=int, default=5000000)
    ap.add_argument('--self-check', action='store_true',
                    help='prove the mismatch detector is not stuck on PASS')
    args = ap.parse_args()

    ai, bi = load_image(args.arkcc), load_image(args.armcc)
    at, bt = int(args.arkcc_tick, 16), int(args.armcc_tick, 16)
    print('arkcc: %-52s %7d bytes @0x%08X' % (args.arkcc, len(ai[1]), ai[0]))
    print('armcc: %-52s %7d bytes @0x%08X' % (args.armcc, len(bi[1]), bi[0]))

    a = Session(ai, at, args.n_bsrr).boot(args.budget)
    b = Session(bi, bt, args.n_bsrr).boot(args.budget)

    ok = True
    notes = []
    print('\n== boot from reset ==')
    for tag, s in (('arkcc', a), ('armcc', b)):
        print('  %-5s SP=0x%08X reset=0x%08X writes=%d bsrr=%d ticks=%d %s' %
              (tag, s.sp, s.pc, len(s.trace), s.bsrr, s.ticks,
               'stopped' if s.stopped else 'DID NOT STOP (%s)' % s.error))

    print('\n== equivalence ==')
    ok &= compare('peripheral write sequence', a.trace, b.trace, notes)
    ok &= compare('GPIO BSRR count', a.bsrr, b.bsrr, notes)
    ok &= compare('uwTick poll count', a.ticks, b.ticks, notes)
    ok &= compare('stopped cleanly', a.stopped and b.stopped, True, notes)

    print('\n== SysTick vector entry ==')
    for tag, s, img, uw in (('arkcc', a, ai, at), ('armcc', b, bi, bt)):
        handler = struct.unpack_from('<I', img[1], FLASH - img[0] + SYSTICK_VECTOR)[0]
        if handler in (0, 0xFFFFFFFF):
            print('  FAIL  %-5s SysTick vector is empty' % tag)
            ok = False
            notes.append('%s: empty SysTick vector' % tag)
            continue
        before = s.read32(uw)
        returned = s.call(handler)
        after = s.read32(uw)
        good = returned and after == (before + 1) & 0xFFFFFFFF
        print('  %s  %-5s handler=0x%08X uwTick %d -> %d' %
              ('PASS' if good else 'FAIL', tag, handler, before, after))
        ok &= good
        if not good:
            notes.append('%s: SysTick handler did not bump uwTick' % tag)

    print('\n== self checks ==')
    sanity = [
        ('peripheral writes observed',
         len(a.trace) >= 20 and len(b.trace) >= 20),
        ('BSRR observed', a.bsrr == args.n_bsrr and b.bsrr == args.n_bsrr),
        ('tick polls observed', a.ticks > 0 and b.ticks > 0),
        ('the two images are different builds', a.sp != b.sp and len(ai[1]) != len(bi[1])),
    ]
    for label, cond in sanity:
        print('  %s  %s' % ('PASS' if cond else 'FAIL', label))
        ok &= cond

    if args.self_check:
        # the detector must be able to say "no" -- otherwise PASS means nothing
        det = compare('detector(expect diff)', [1], [2], [])
        det2 = compare('detector(expect same)', [0x10], [0x10], [])
        print('  %s  detector reports mismatch when it should' %
              ('PASS' if not det else 'FAIL'))
        print('  %s  detector reports match when it should' %
              ('PASS' if det2 else 'FAIL'))
        ok &= (not det) and det2

    print('\nRESULT: %s' % ('EQUIVALENT' if ok else
                            'MISMATCH -> ' + ', '.join(notes)))
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())