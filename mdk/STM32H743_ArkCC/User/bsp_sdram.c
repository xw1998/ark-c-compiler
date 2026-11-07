/* bsp_sdram.c -- FMC SDRAM bring-up for the FK743M5-XIH6 core board.
 *
 * Hardware (from the vendor example
 *   2.参考例程/1.基础例程/FMC—SDRAM测试/Drivers/User/Src/sdram.c, 反客科技 V1.0):
 *   - STM32H743XIH6 core board, 25 MHz HSE (not used here: this firmware runs
 *     from HSI, so the FMC kernel clock is whatever HCLK currently is)
 *   - SDRAM W9825G6: 32 MB, 16-bit bus, 13 row bits, 9 column bits,
 *     4 internal banks, CAS latency 3
 *   - wired to FMC SDRAM bank1 => window 0xC0000000..0xC1FFFFFF
 *
 * Register bit fields were taken from the official stm32h743xx.h
 * (FMC_SDCRx_NC/NR/MWID/NB/CAS/WP/SDCLK/RBURST/RPIPE, FMC_SDTRx_TMRD/TXSR/
 * TRAS/TRC/TWR/TRP/TRCD, FMC_SDCMR_MODE/CTB1/NRFS/MRD, FMC_SDRTR_COUNT,
 * FMC_SDSR_BUSY), not typed from memory.
 *
 * Clocking: RCC_D1CCIPR.FMCSEL stays at its reset value 00 = D1HCLK, so
 *   fmc_ker_ck = HCLK, SDCLK = HCLK / 2 (SDCLK bits = 10; 00 disables it).
 * The timing numbers below are the vendor's, which were validated at
 * HCLK 240 MHz / SDCLK 120 MHz.  Running slower only stretches every one of
 * them, so they stay legal; the one parameter that must be recomputed is the
 * refresh counter, and that is done from the real SDCLK below.
 */

#include "stm32h7xx.h"
#include "bsp_sdram.h"

#define REG32(addr)        (*(volatile uint32_t *)(addr))

/* RCC (RM0433 5.8) */
#define RCC_BASE           0x58024400UL
#define RCC_D1CCIPR        REG32(RCC_BASE + 0x4CU)
#define RCC_AHB3ENR        REG32(RCC_BASE + 0xD4U)
#define RCC_AHB4ENR        REG32(RCC_BASE + 0xE0U)

/* FMC (RM0433 22.7): SDRAM registers start at 0x140 */
#define FMC_BASE           0x52004000UL
#define FMC_BCR1           REG32(FMC_BASE + 0x000U)
#define FMC_SDCR1          REG32(FMC_BASE + 0x140U)
#define FMC_SDCR2          REG32(FMC_BASE + 0x144U)
#define FMC_SDTR1          REG32(FMC_BASE + 0x148U)
#define FMC_SDTR2          REG32(FMC_BASE + 0x14CU)
#define FMC_SDCMR          REG32(FMC_BASE + 0x150U)
#define FMC_SDRTR          REG32(FMC_BASE + 0x154U)
#define FMC_SDSR           REG32(FMC_BASE + 0x158U)

/* FMC_SDCMR */
#define SDCMR_MODE_CLK_ENABLE     (1UL << 0)
#define SDCMR_MODE_PALL           (2UL << 0)
#define SDCMR_MODE_AUTOREFRESH    (3UL << 0)
#define SDCMR_MODE_LOAD_MODE      (4UL << 0)
#define SDCMR_CTB1                (1UL << 4)
#define SDCMR_NRFS(n)             (((uint32_t)(n) & 0xFUL) << 5)
#define SDCMR_MRD(v)              (((uint32_t)(v) & 0x1FFFUL) << 9)

/* FMC_SDSR */
#define SDSR_BUSY                 (1UL << 5)
#define SDSR_MODES1_MASK          (3UL << 1)

/* The placeholder stm32h743xx.h only declares GPIOA/GPIOB; the SDRAM needs
 * C..H.  Same GPIO_TypeDef layout, bases are 0x400 apart from 0x58020000. */
#define GPIO_BASE(n)       (0x58020000UL + 0x400UL * (unsigned)(n))
#define GPIOC_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(2))
#define GPIOD_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(3))
#define GPIOE_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(4))
#define GPIOF_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(5))
#define GPIOG_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(6))
#define GPIOH_SDRAM        ((GPIO_TypeDef *)GPIO_BASE(7))

#define GPIO_AF12_FMC      12U

/* 32 MB / 2 bytes per 16-bit word */
#define SDRAM_WORDS        (SDRAM_SIZE_BYTES / 2UL)

/* SystemCoreClock lives in system_stm32h7xx.c (64 MHz on HSI). */
extern uint32_t SystemCoreClock;

/* Busy wait in CPU loops.  Used only during the power-up sequence, where the
 * part asks for 100us..1ms before the first command.  The counter is volatile
 * so the loop cannot be optimised away; at HSI 64 MHz one iteration is a few
 * cycles, i.e. sdram_spin(20000) is a few milliseconds. */
static volatile uint32_t g_spin_sink;
static void sdram_spin(uint32_t n)
{
    while (n--) { g_spin_sink++; }
}

/* Put every pin of `mask` on `port` into alternate-function push-pull mode. */
static void sdram_gpio_af(GPIO_TypeDef *port, uint32_t mask, unsigned af)
{
    uint32_t i;
    for (i = 0; i < 16U; i++) {
        if ((mask & (1UL << i)) == 0U) continue;
        port->MODER   = (port->MODER   & ~(3UL << (i * 2U))) | (2UL << (i * 2U));
        port->OTYPER &= ~(1UL << i);                       /* push-pull */
        port->OSPEEDR = (port->OSPEEDR & ~(3UL << (i * 2U))) | (3UL << (i * 2U));
        port->PUPDR   = (port->PUPDR   & ~(3UL << (i * 2U)));  /* no pull */
        if (i < 8U) {
            port->AFR[0] = (port->AFR[0] & ~(0xFUL << (i * 4U)))
                         | ((uint32_t)af << (i * 4U));
        } else {
            port->AFR[1] = (port->AFR[1] & ~(0xFUL << ((i - 8U) * 4U)))
                         | ((uint32_t)af << ((i - 8U) * 4U));
        }
    }
}

/* Pin map, copied from the vendor example's comment block:
 *   PF0..PF5  -> A0..A5      PD14,PD15 -> D0,D1     PC0  -> SDNWE
 *   PF12..PF15-> A6..A9      PD0,PD1   -> D2,D3     PG15 -> SDNCAS
 *   PG0..PG2  -> A10..A12    PE7..PE15 -> D4..D12   PF11 -> SDNRAS
 *   PG4,PG5   -> BA0,BA1     PD8,PD9,PD10 -> D13..D15  PH3 -> SDNE0
 *   PG8       -> SDCLK       PE0,PE1   -> NBL0,NBL1    PH2 -> SDCKE0
 * If NBL0/NBL1 are swapped the 16-bit test still passes and only the 8-bit
 * probe fails -- that is why bsp_sdram_check8() exists. */
static void sdram_gpio_init(void)
{
    RCC_AHB4ENR |= (1UL << 2) | (1UL << 3) | (1UL << 4)
                 | (1UL << 5) | (1UL << 6) | (1UL << 7);   /* GPIOC..GPIOH */

    sdram_gpio_af(GPIOF_SDRAM, 0x0000F83FUL, GPIO_AF12_FMC); /* A0-A5,A6-A9,RAS */
    sdram_gpio_af(GPIOG_SDRAM, 0x00008137UL, GPIO_AF12_FMC); /* A10-A12,BA0,BA1,CLK,CAS */
    sdram_gpio_af(GPIOE_SDRAM, 0x0000FF83UL, GPIO_AF12_FMC); /* D4-D12,NBL0,NBL1 */
    sdram_gpio_af(GPIOD_SDRAM, 0x0000C703UL, GPIO_AF12_FMC); /* D0-D3,D13-D15 */
    sdram_gpio_af(GPIOH_SDRAM, 0x0000000CUL, GPIO_AF12_FMC); /* SDNE0,SDCKE0 */
    sdram_gpio_af(GPIOC_SDRAM, 0x00000001UL, GPIO_AF12_FMC); /* SDNWE */
}

/* SDCLK in kHz as this chip is actually clocked.  HCLK is derived from
 * SystemCoreClock and the D1 HPRE divider (D1CFGR bits 3:0, 0 = /1). */
static uint32_t sdram_sdclk_khz(void)
{
    uint32_t hclk = SystemCoreClock;
    uint32_t hpre = REG32(RCC_BASE + 0x18U) & 0xFUL;
    if (hpre & 0x8UL) {
        uint32_t sh = (hpre & 0x7UL) + 1UL;      /* 0b1xxx: /2^(n+1) */
        hclk = hclk >> sh;
    } else if (hpre & 0x4UL) {
        hclk = hclk / 2UL;
    } else if (hpre & 0x2UL) {
        hclk = hclk / 4UL;
    } else {
        /* /1 */
    }
    return hclk / 2000UL;                        /* Hz -> kHz, SDCLK = HCLK/2 */
}

/* Wait until the SDRAM controller finished the command it was given. */
static int sdram_wait_idle(void)
{
    uint32_t guard = 100000UL;
    while ((FMC_SDSR & SDSR_BUSY) != 0U) {
        if (--guard == 0U) return -1;
    }
    return 0;
}

/* 13 rows refreshed every 64 ms: COUNT = 64ms/8192 * SDCLK - 20 (RM0433). */
static uint32_t sdram_refresh_count(uint32_t sdclk_khz)
{
    uint32_t c = (sdclk_khz * 64UL) / 8192UL;
    if (c < 20UL) return 1UL;
    return c - 20UL;
}

/* Set when SDSR.BUSY was observed right after a command write.  If it stays 0
 * for every command the FMC never executed anything -- that is a different
 * failure from "command ran but the part did not answer". */
uint32_t g_sdram_busy_seen;
uint32_t g_sdram_sdsr_after_load;
/* Register state around the init, so the shell can show WHY it failed. */
uint32_t g_fmc_bcr1_before;
uint32_t g_fmc_bcr1_after;
uint32_t g_rcc_d1ccipr;
uint32_t g_rcc_ahb3enr;

int bsp_sdram_init(void)
{
    uint32_t sdclk_khz;
    uint32_t mrd;

    /* FMC kernel clock = D1HCLK (FMCSEL = 00, its reset value).  Written
     * explicitly so a later clock-tree change cannot leave the SDRAM running
     * off PLL2R without anybody noticing. */
    RCC_D1CCIPR &= ~(3UL << 0);
    RCC_AHB3ENR |= (1UL << 12);                  /* FMCEN */
    g_rcc_d1ccipr = RCC_D1CCIPR;
    g_rcc_ahb3enr = RCC_AHB3ENR;

    /* FMC_BCR1 bit 31 (FMCEN) gates the whole FMC.  Its reset value is not
     * documented as 1, and an access to an FMC bank while the controller is
     * disabled comes back as an AXI error -- exactly the imprecise bus fault
     * the first SDRAM attempt produced.  Record it, then make sure it is on. */
    g_fmc_bcr1_before = FMC_BCR1;

    sdram_gpio_init();

    /* --- FMC_SDCR1 ---------------------------------------------------------
     * Field encodings are the numeric values of the vendor HAL's
     * FMC_SDRAM_* constants (stm32h7xx_ll_fmc.h), not from memory:
     *   NC    = 01 : 9 column bits       (00 is *8* -- the first attempt used
     *                                    00 and left 9th column unaddressed)
     *   NR    = 10 : 13 row bits
     *   MWID  = 01 : 16-bit memory bus
     *   NB    = 1  : 4 internal banks
     *   CAS   = 11 : latency 3           (10 is latency 2)
     *   WP    = 0  : write enable
     *   SDCLK = 10 : SDCLK = HCLK / 2    ** 00 is CLOCK_DISABLE, not /2 **
     *   RBURST= 1  : burst reads
     *   RPIPE = 01 : 1 HCLK read-pipe delay
     * SDCLK = 00 was THE bug: with the SDRAM clock disabled the command
     * sequencer never ran (SDCMR/SDRTR writes went nowhere, SDSR stayed 0) and
     * any access to 0xC0000000 came back as an AXI error -> IMPRECISERR.
     * The resulting value is 0x000039D9, byte for byte what the vendor firmware
     * has in this register while it passes its own 32 MB write/read test on
     * this board. */
    FMC_SDCR1 = (1UL << 0)                   /* NC    = 9 column bits     */
              | (2UL << 2)                   /* NR    = 13 row bits       */
              | (1UL << 4)                   /* MWID  = 16-bit bus        */
              | (1UL << 6)                   /* NB    = 4 internal banks  */
              | (3UL << 7)                   /* CAS   = latency 3         */
              | (0UL << 9)                   /* WP    = writes allowed    */
              | (2UL << 10)                  /* SDCLK = HCLK / 2          */
              | (1UL << 12)                  /* RBURST = burst reads      */
              | (1UL << 13);                 /* RPIPE  = 1 HCLK pipe delay*/
    /* FMC_SDCR2 / FMC_SDTR2 are deliberately left at their reset values: the
     * board only populates bank 1. */

    /* --- FMC_SDTR1 ---------------------------------------------------------
     * Timing fields are written as (cycles - 1) -- that is what the vendor HAL
     * does (FMC_SDRAM_Timing_Init subtracts 1 from every field), so a field of
     * n means n+1 SDCLK cycles.
     * 0x00126361 is the value read back from this register on the vendor
     * firmware while it passes the 32 MB test, i.e. TMRD 2 / TXSR 7 / TRAS 4 /
     * TRC 7 / TWR 3 / TRP 2 / TRCD 1 cycle.  It is copied from the working
     * board rather than re-derived so that first light-up is not a second
     * experiment; with our slower SDCLK (32 MHz instead of 120 MHz) every one
     * of those cycle counts is a longer time in ns, so it stays legal (the
     * shortest, TRCD = 1 cycle, is 31 ns against the W9825G6 18 ns minimum). */
    FMC_SDTR1 = (1UL << 0)                   /* TMRD = 2 cycles  */
              | (6UL << 4)                   /* TXSR = 7 cycles  */
              | (3UL << 8)                   /* TRAS = 4 cycles  */
              | (6UL << 12)                  /* TRC  = 7 cycles  */
              | (2UL << 16)                  /* TWR  = 3 cycles  */
              | (1UL << 20)                  /* TRP  = 2 cycles  */
              | (0UL << 24);                 /* TRCD = 1 cycle   */

    /* Enable the controller, in the same order ST's own HAL does it
     * (HAL_SDRAM_Init: FMC_SDRAM_Init, FMC_SDRAM_Timing_Init,
     * __FMC_ENABLE()).  With FMCEN = 0 the SDCR/SDTR writes still
     * land, but the command generator never runs and the refresh
     * timer never counts -- which is exactly what the first attempt
     * showed (SDRTR stuck at 0, 0xC0000000 access -> AXI error). */
    FMC_BCR1 = g_fmc_bcr1_before | 0x80000000UL;
    g_fmc_bcr1_after = FMC_BCR1;

    /* 1. Clock enable, then wait the 100 us the part needs before anything
     *    else may be issued. */
    FMC_SDCMR = SDCMR_MODE_CLK_ENABLE | SDCMR_CTB1 | SDCMR_NRFS(1);
    if (sdram_wait_idle() != 0) return -1;
    sdram_spin(20000UL);

    /* 2. Precharge all banks. */
    FMC_SDCMR = SDCMR_MODE_PALL | SDCMR_CTB1 | SDCMR_NRFS(1);
    if (sdram_wait_idle() != 0) return -2;

    /* 3. Eight auto-refresh cycles. */
    FMC_SDCMR = SDCMR_MODE_AUTOREFRESH | SDCMR_CTB1 | SDCMR_NRFS(8);
    if ((FMC_SDSR & SDSR_BUSY) != 0U) g_sdram_busy_seen = 1;
    if (sdram_wait_idle() != 0) return -3;

    /* 4. Load the mode register: burst length 2, sequential, CAS 3, standard
     *    operating mode, single write burst (0x231). */
    mrd = (1UL << 0) | (0UL << 3) | (3UL << 4) | (0UL << 7) | (1UL << 9);
    FMC_SDCMR = SDCMR_MODE_LOAD_MODE | SDCMR_CTB1 | SDCMR_NRFS(1)
              | SDCMR_MRD(mrd);
    if ((FMC_SDSR & SDSR_BUSY) != 0U) g_sdram_busy_seen = 1;
    if (sdram_wait_idle() != 0) return -4;
    g_sdram_sdsr_after_load = FMC_SDSR;

    /* 5. Refresh timer.  At HSI 64 MHz -> HCLK 64 MHz -> SDCLK 32 MHz this is
     *    230; at the vendor's 120 MHz it reproduces their 918. */
    sdclk_khz = sdram_sdclk_khz();
    FMC_SDRTR = (sdram_refresh_count(sdclk_khz) << 1);

    return 0;
}

void bsp_sdram_info(uint32_t *sdcr, uint32_t *sdtr, uint32_t *sdrtr,
                    uint32_t *sdsr, uint32_t *sdclk_khz)
{
    if (sdcr)      *sdcr      = FMC_SDCR1;
    if (sdtr)      *sdtr      = FMC_SDTR1;
    if (sdrtr)     *sdrtr     = FMC_SDRTR;
    if (sdsr)      *sdsr      = FMC_SDSR;
    if (sdclk_khz) *sdclk_khz = sdram_sdclk_khz();
}

int bsp_sdram_write16(uint32_t nwords)
{
    uint32_t i;
    if (nwords > SDRAM_WORDS) nwords = SDRAM_WORDS;
    for (i = 0; i < nwords; i++) {
        *(volatile uint16_t *)(SDRAM_BANK_ADDR + 2UL * i) = (uint16_t)i;
    }
    return 0;
}

int bsp_sdram_check16(uint32_t nwords, uint32_t *bad_off,
                      uint32_t *got, uint32_t *exp)
{
    uint32_t i;
    uint16_t want, have;
    if (nwords > SDRAM_WORDS) nwords = SDRAM_WORDS;
    for (i = 0; i < nwords; i++) {
        want = (uint16_t)i;
        have = *(volatile uint16_t *)(SDRAM_BANK_ADDR + 2UL * i);
        if (have != want) {
            if (bad_off) *bad_off = 2UL * i;
            if (got)     *got     = have;
            if (exp)     *exp     = want;
            return -1;
        }
    }
    return 0;
}

int bsp_sdram_check8(uint32_t n, uint32_t *bad_off, uint32_t *got, uint32_t *exp)
{
    uint32_t i;
    unsigned char want, have;
    if (n > 255U) n = 255U;
    for (i = 0; i < n; i++) {
        *(volatile unsigned char *)(SDRAM_BANK_ADDR + i) = (unsigned char)i;
    }
    for (i = 0; i < n; i++) {
        want = (unsigned char)i;
        have = *(volatile unsigned char *)(SDRAM_BANK_ADDR + i);
        if (have != want) {
            if (bad_off) *bad_off = i;
            if (got)     *got     = have;
            if (exp)     *exp     = want;
            return -1;
        }
    }
    return 0;
}
