/* Ark C Compiler - scatter.h
 * ARM linker scatter load description file parser.
 * Supports a practical subset of armlink scatter syntax:
 *   LR_<name> <addr> [attrs] { ER_<name> <addr> [attrs] { <selectors> } ... }
 * Parse results are stored in ScatterDesc for the backend/link stage to query section placement.
 *
 * Also provides a GNU ld .ld script parser (linker_script_parse_file) and
 * conversion helpers (scatter_to_ld_script / scatter_to_sct_file) so the ARM
 * backend can emit a matching linker script when the user supplies either form.
 */
#ifndef ARK_SCATTER_H
#define ARK_SCATTER_H

/* Re-export the feature macro from arkcc_config.h so callers that only include
 * scatter.h still see the switch. arkcc_config.h is the single source of truth. */
#include "arkcc_config.h"

/* Execution region (ER): corresponds to a runtime address space, placing several input section selectors. */
typedef struct ScatterExecRegion {
    char *name;            /* ER name */
    unsigned load_addr;    /* execution address */
    unsigned size;         /* region size (0 = unspecified) */
    char *selectors;       /* section selector raw text (e.g. "*.o (RO)"), stored as a whole string for simplicity */
    struct ScatterExecRegion *next;
} ScatterExecRegion;

/* Load region (LR): corresponds to a load address space, contains several execution regions. */
typedef struct ScatterLoadRegion {
    char *name;            /* LR name */
    unsigned load_addr;    /* load address */
    unsigned size;         /* region size (0 = unspecified) */
    ScatterExecRegion *exec_regions;  /* execution region linked list */
    struct ScatterLoadRegion *next;
} ScatterLoadRegion;

/* Parse result of the whole scatter file. */
typedef struct ScatterDesc {
    ScatterLoadRegion *load_regions;
    int error_count;
} ScatterDesc;

/* Parse a scatter file path; returns 0 on success, non-zero on error.
 * Parse result is stored in *out (caller-provided pointer). Multiple calls accumulate (no reset). */
int scatter_parse_file(const char *path, ScatterDesc *out);

/* Parse a GNU ld .ld script path; returns 0 on success.
 * The parser recognizes MEMORY{} and SECTIONS{} blocks enough to extract
 * region addresses; output is converted into ScatterDesc form. */
int linker_script_parse_file(const char *path, ScatterDesc *out);

/* Free resources outside the memory pool held by the parse result (arkcc mostly uses memory pools; here only clears list heads). */
void scatter_free(ScatterDesc *desc);

/* Print parse result to log (for debugging). */
void scatter_dump(const ScatterDesc *desc);

/* Look up the execution address for a given section selector.
 * Returns 0 if not found; otherwise returns the address.
 * Used by the ARM backend to place sections at scatter-defined addresses. */
unsigned scatter_lookup_addr(const ScatterDesc *desc, const char *section_name);

/* Convert a ScatterDesc into a GNU ld .ld script string.
 * Writes to buf; returns required length (may exceed cap, caller should retry). */
int scatter_to_ld_script(const ScatterDesc *desc, char *buf, int cap);

/* Convert a ScatterDesc into an ARM scatter .sct string. */
int scatter_to_sct_file(const ScatterDesc *desc, char *buf, int cap);

#endif /* ARK_SCATTER_H */
