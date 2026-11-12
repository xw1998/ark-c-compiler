/* Ark C Compiler - backend.h
 * Backend abstraction layer: turns "emit assembly/machine code" into an interface.
 *
 * Each backend is implemented in src/backend/<name>/backend_<name>.c and exposes
 * an ArkBackend pointer via the exported function ark_backend_<name>().
 * registry.c links all available backends together; main selects one via -target.
 *
 * Most backends do the bulk of their work in emit_asm; assemble/link can be stubs
 * for software-style backends (c/x86_64/riscv32), simply dumping the assembly text
 * as bytes and letting the user post-process with gcc/as/nasm.
 */
#ifndef ARK_BACKEND_H
#define ARK_BACKEND_H

#include "common.h"
#include "arkcc_config.h"   /* ARKCC_BACKEND_* switches live here */
#include "ir.h"

/* Placeholder link context, used by the ARM backend; other backends may ignore it. */
struct LinkContext {
    int dummy;
};

/* ABI selector (B01: x86 backend now targets i386 cdecl).
 *   0 = cdecl (default): all args on stack, caller cleans up.
 *   1 = MSVC x64 ABI (legacy, now maps to cdecl). ARK_ABI_MSVC is retained
 *       for source compatibility but the x86 backend ignores it. */
#define ARK_ABI_SYSV 0
#define ARK_ABI_MSVC 1

typedef struct ArkBackend {
    const char *name;            /* "arm", "x86_64", "riscv32", "c" */
    const char *triple;          /* description string */
    int  pointer_size;           /* bytes */
    /* IR -> text assembly. Returns bytes written (excluding terminating NUL); -1 on failure. */
    int  (*emit_asm)(IrProgram *m, char *out, int cap);
    /* Text assembly -> machine code. Returns -1 on failure. */
    int  (*assemble)(const char *asm_text, unsigned char *out, int cap);
    /* Linker relocation. Returns -1 on failure. */
    int  (*link)(unsigned char *code, int size, struct LinkContext *lc);
    int  abi;                    /* x86 ABI: ARK_ABI_SYSV (cdecl, default) or ARK_ABI_MSVC (legacy) */
} ArkBackend;

const ArkBackend *ark_backend_find(const char *name);
const ArkBackend *ark_backend_default(void);
void ark_backend_list(void);

/* Per-backend exported functions */
const ArkBackend *ark_backend_arm(void);
const ArkBackend *ark_backend_x86_64(void);
const ArkBackend *ark_backend_x86_64_msvc(void);
/* True 64-bit backend (name "x86_64", SysV AMD64, pointer_size 8).
 * ark_backend_i386() is the same object ark_backend_x86_64() returns. */
const ArkBackend *ark_backend_amd64(void);
const ArkBackend *ark_backend_i386(void);
const ArkBackend *ark_backend_riscv32(void);
const ArkBackend *ark_backend_c(void);

/* ARM backend debug flag (defined in backend_arm.c). When set, the ARM
 * assembler dumps its symbol map after assembly. On host it is latched from
 * the ARKCC_DUMP_SYMS environment variable at arkcc startup via
 * arm_dump_syms_init(); on STM32 getenv() is unavailable under semihosting,
 * so the flag is set via a UART "debug syms" command instead. */
extern int g_arm_dump_syms;

/* ARM backend: reserve the Cortex-M vector-table area at the front of the code
 * image (--vector-table).  When set, the assembler starts emitting at
 * ARM_VT_SIZE instead of 0 and the linker writes the table into the reserved
 * gap, so code keeps the addresses the assembler gave it.
 *
 * Why this exists: arm_link used to *prepend* the table and shift the whole
 * image right by 0x400 at link time.  Thumb-2 branches survive a uniform shift
 * (they are PC-relative), but absolute addresses baked in by the assembler do
 * not: a string literal linked at 0x24070000 stays encoded as 0x24070000 while
 * its bytes move to 0x24070400.  Reserving up front removes the shift, so both
 * kinds of reference stay correct. */
extern int g_arm_vt_reserve;
/* 1 = the selected CPU has a double-precision FPU (see backend_arm.c). */
extern int g_arm_fpu_dp;

/* riscv32 object mode: 1 when the driver is producing an ARKOBJ2 object (-c)
 * rather than a flat image.  It changes exactly one thing -- a reference to a
 * symbol this translation unit does not define becomes a relocation instead of
 * a hard error.  Zero by default, so every flat-image path is byte-identical. */
extern int g_rv_obj_mode;
extern int g_x86_obj_mode;

/* x86 / x86_64 -c objects place their own data and code in one blob, and
 * the linker concatenates those blobs, so a label this object defines is
 * still not at the address the object stored.  A type-4 (absolute) site
 * whose target is an own label is therefore kept as this relocation: the
 * driver adds the base it placed the object at.  It names no symbol, so it
 * is applied while the object is read and never enters the reloc table. */
#define X86_RELOC_SELF_BASE 7

/* Where an x86_64 image is assumed to be loaded.  Code references are
 * RIP-relative (position independent), but a static absolute pointer --
 * "const char *msg = \"hi\";", a function-pointer table -- has to carry a
 * real address, and the assembler is the only place that knows which part
 * of it is fixed.  i386 images are loaded at 0 (that is what the reference
 * arm does), so this constant only applies to the 64-bit encoder. */
#define X86_IMAGE_BASE 0x400000u

/* riscv32 cross-object relocation, applied by the -link driver after the
 * objects have been placed.  `off` is the site and `target` the symbol, both as
 * offsets inside the merged image (the flash base cancels in the PC-relative
 * form and is added back for an absolute .word).  Returns 0 on success, -1 when
 * the site does not hold the instruction pair the relocation describes or the
 * displacement does not fit -- the caller must then refuse to write the image.
 * The type numbers live here because both the assembler (which records them)
 * and the driver (which applies them) have to agree on them. */
#define RV_RELOC_AUIPC  13
#define RV_RELOC_ABS32  14
int rv_patch_reloc(unsigned char *code, int code_size, int off, int target,
                   int type, unsigned image_base);
void arm_dump_syms_init(void);

#endif /* ARK_BACKEND_H */
