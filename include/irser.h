/* Ark C Compiler - irser.h
 * IR serialisation: one translation unit's IrProgram as a byte string, and
 * back.  This is the payload a `-c --obj-ir` object carries so that a later
 * `-link --lto` has something to optimise.
 *
 * Why bytes and not a second in-memory copy: the object file is the transport.
 * The IR has to survive a process boundary (compile now, link later), so its
 * representation has to be written down.  Everything below the header is
 * little-endian and self-describing, and every reader validates before it
 * allocates -- a corrupt payload must be a diagnostic, never a wrong answer.
 *
 * Format (see also write_ark_obj() in src/compiler.c, which appends the
 * payload after the relocation table so that older readers, which stop there,
 * are unaffected):
 *
 *   "ARKIR1\n" | u32 version | u32 body_len | body
 *
 * body:
 *   u32 ntypes,   type records      (indices are unit-local; -1 = NULL)
 *   u32 nstrings, string records
 *   u32 nfloats,  f64 each
 *   u32 ncomplex, {f64 re, f64 im} each
 *   u32 nargbytes, i32 each
 *   sstr source_file
 *   u32 nglobals, global records
 *   u32 nfuncs,   function records
 *
 * sstr = i32 present (0 = NULL) + u32 len + len bytes (no NUL; may contain
 * any byte except that a present string with len 0 is an empty string).
 */
#ifndef ARK_IRSER_H
#define ARK_IRSER_H

#include "common.h"
#include "ir.h"
#include "arkcc_config.h"

#define ARK_IR_MAGIC      "ARKIR1\n"
#define ARK_IR_MAGIC_LEN  8
#define ARK_IR_VERSION    1

/* Serialise p into buf (capacity cap).  Returns the number of bytes written,
 * including the 16-byte header, or -1 when the payload does not fit or the IR
 * contains something the format cannot express (that case is reported through
 * diag_tool, so the caller must not print a second generic message).
 * `who` names the file for the diagnostic. */
int ir_serialize(IrProgram *p, unsigned char *buf, int cap, const char *who);

/* Read a payload produced by ir_serialize() into a fresh IrProgram.  Returns
 * 0 and sets *err_msg on any inconsistency: bad magic, wrong version, length
 * mismatch, an out-of-range pool index, an opcode that carries a name it may
 * not carry.  On failure nothing has been returned and the diagnostics are
 * already printed. */
IrProgram *ir_deserialize(const unsigned char *buf, int len, const char *who);

/* Append unit's contents to dst (which --ipo also fills another way), fixing
 * up the three pool indices an IrInst carries: IR_PUSH_STR.val,
 * IR_PUSH_FLOAT.val and IR_CALL.aux2.  Types are unit-local and stay as they
 * are.  `unit_index` is only used for diagnostics. */
void ir_program_append_unit(IrProgram *dst, IrProgram *unit, int unit_index,
                            const char *who);

/* Serialise the unit that is about to be emitted into the payload buffer and
 * remember it; write_ark_obj() then appends it to the object.  Called from
 * ark_frontend_unit() *before* the pass pipeline runs, so what travels in the
 * object is the IR as the front end produced it (see compiler.h).  A failure
 * has already been reported through diag_tool, and ir_stashed_payload()
 * then returns no payload at all -- an object that claims --obj-ir but has an
 * empty payload would be worse than a failed compile. */
void ir_stash_payload(IrProgram *p, const char *who);

/* The stashed payload (NULL/len 0 when there is none). */
const unsigned char *ir_stashed_payload(int *len);

/* Locate the payload inside a finished ARKOBJ2 image: skip the header, the
 * code body, the symbol table and the relocation table, then require the
 * payload header.  Returns 1 and stores the payload and its length on success; 0 when the
 * object simply has no payload (an object built without --obj-ir); -1 when
 * the object is malformed or the payload header is damaged, in which case a
 * diagnostic has already been printed. */
int ir_obj_find_payload(const unsigned char *obj, int obj_len, int want_payload,
                        const unsigned char **payload, int *plen,
                        const char *who);

#endif /* ARK_IRSER_H */