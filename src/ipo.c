/* Ark C Compiler - ipo.c
 * Whole-program compilation (--ipo / -flto).
 *
 * What this is, and what it is not
 * --------------------------------
 * arkcc's object format (ARKOBJ2) carries machine code, a symbol table and
 * relocations.  The IR is consumed by codegen and thrown away, so by the time
 * -link runs there is nothing left to optimise: the linker concatenates code
 * and patches addresses, and that is all it can honestly do.  Cross-file
 * inlining, unused-static removal and cross-file constant propagation are
 * therefore impossible on the object path, no matter how the linker is
 * written.
 *
 * --ipo is the other arrangement: run the front end once per source file in
 * ONE process and ONE arena, append every unit's IR into a single IrProgram
 * (irgen_program_into), resolve the file-scope name collisions the linker
 * would normally resolve, and then run the ordinary pass pipeline over the
 * merged program -- which is what finally gives ir.inline something new to
 * chew on, namely callees that live in another file.
 *
 * It is NOT link-time optimisation of objects: nothing here reads an ARKOBJ2
 * file.  It is whole-program compilation, which reaches the same class of
 * optimisation and is the only form this object format can support.
 *
 * Scope of this first stage (deliberately narrow)
 * ----------------------------------------------
 *   * inputs are C source files, all compiled at once; -c is refused (one
 *     object from N files would need a symbol/relocation answer this stage
 *     does not have to give);
 *   * -g is refused: an IrProgram carries ONE source_file, and labelling
 *     every unit's lines with the first file's name is a wrong answer, not a
 *     missing feature;
 *   * --pipeline / -O decide which passes run, exactly as for one file.  With
 *     -O0 nothing is optimised; with -O2 the merged program is inlined across
 *     files.  --ipo changes the SCOPE of the analysis, not the pass policy;
 *   * static objects and functions are mangled per unit (see ipo_mangle) and
 *     pruned when nothing refers to them any more;
 *   * a symbol defined twice -- two strong definitions, or two initialised
 *     globals -- is a hard error, exactly as the linker would make it.  Two
 *     tentative definitions of the same object merge, as C 6.9.2p2 says.
 *
 * Everything is behind ARKCC_FEATURE_IPO; the runtime flag defaults to off
 * and, when it is off, ark_compile() never calls into this file.
 */
#include "ipo.h"
#include "platform.h"
#include "memory.h"
#include "flash_fs.h"
#include "type.h"
#include "config.h"
#include "diag.h"
#include "pipeline.h"
#include "irser.h"

#if ARKCC_FEATURE_IPO

/* ------------------------------------------------------------------ */
/* Small helpers                                                       */
/* ------------------------------------------------------------------ */

/* Append the decimal form of v to b at *o.  No stdio: this file runs on the
 * same arena discipline as everything else and the board build has no printf. */
static void ipo_put_int(char *b, int *o, int v)
{
    char tmp[12];
    int n = 0;
    if (v < 0) { b[(*o)++] = '-'; v = -v; }
    if (v == 0) tmp[n++] = '0';
    while (v > 0) { tmp[n++] = (char)('0' + (v % 10)); v /= 10; }
    while (n > 0) b[(*o)++] = tmp[--n];
    b[*o] = 0;
}

static int ipo_ends_with(const char *s, const char *suf)
{
    int ls = ark_strlen(s), lf = ark_strlen(suf);
    if (lf > ls) return 0;
    return ark_streq(s + (ls - lf), suf);
}

/* Inputs that are not C source: an .s file has nothing to parse and an object
 * carries no IR (that is what -link is for).  Naming the file and the reason
 * beats letting the preprocessor run on a binary until it emits nonsense. */
static const char *ipo_non_c_reason(const char *path)
{
    if (ipo_ends_with(path, ".s") || ipo_ends_with(path, ".S") ||
        ipo_ends_with(path, ".asm")) return "assembly source";
    if (ipo_ends_with(path, ".o") || ipo_ends_with(path, ".obj") ||
        ipo_ends_with(path, ".ark_obj")) return "object file (use -link)";
    return 0;
}

static int ipo_name_in_program(IrProgram *p, const char *s)
{
    int i;
    for (i = 0; i < p->func_count; i++)
        if (p->funcs[i]->name && ark_streq(p->funcs[i]->name, s)) return 1;
    for (i = 0; i < p->global_count; i++)
        if (p->globals[i]->name && ark_streq(p->globals[i]->name, s)) return 1;
    return 0;
}

/* Mangled name for a file-scope object: __ipo<unit><kind>_<extra '_'>*<name>
 *
 * Why mangle at all: a `static` function named `helper` in two files is two
 * different functions, and the merged program keeps both.  The linker would
 * have kept them apart automatically (each object's local symbols are its
 * own); merging into one IR program removes that boundary, so the
 * distinctness has to be spelled into the name.
 *
 * Why a generated name is checked against the whole program: the result is an
 * assembler label, so a collision would silently bind two entities into one.
 * If the obvious spelling is taken, another '_' is added until it is not --
 * "cannot happen" is not a reason to skip the check. */
static char *ipo_mangle(IrProgram *p, const char *name, int unit, const char *kind)
{
    int extra;
    for (extra = 0; extra < 64; extra++) {
        int cap = 8 + ark_strlen(kind) + 12 + 1 + extra + ark_strlen(name) + 4;
        char *s = (char *)mem_pool_alloc(cap);
        int o = 0, k;
        s[o++] = '_'; s[o++] = '_'; s[o++] = 'i'; s[o++] = 'p'; s[o++] = 'o';
        ipo_put_int(s, &o, unit);
        for (k = 0; kind[k]; k++) s[o++] = kind[k];
        for (k = 0; k <= extra; k++) s[o++] = '_';
        for (k = 0; name[k]; k++) s[o++] = name[k];
        s[o] = 0;
        if (!ipo_name_in_program(p, s)) return s;
    }
    return 0;
}

typedef struct { const char *from; const char *to; } IpoRename;

static const char *ipo_rename_lookup(const IpoRename *ren, int n, const char *name)
{
    int i;
    if (!name) return 0;
    for (i = 0; i < n; i++)
        if (ark_streq(name, ren[i].from)) return ren[i].to;
    return 0;
}

/* Rewrite the symbol references of one unit's instructions.
 *
 * Only the four opcodes that carry a SYMBOL name are touched:
 *   IR_CALL / IR_PUSH_FUNC          -> function name
 *   IR_PUSH_GLOBAL / IR_STORE_GLOBAL / IR_PUSH_GLOBAL_ADDR -> object name
 * The other name-bearing opcodes are deliberately left alone: IR_PUSH_STR's
 * name is the string's bytes, IR_LABEL_NAMED/IR_JMP_NAMED carry a goto label
 * (already function-qualified by every backend), IR_ASM carries asm text. */
static void ipo_rewrite_unit(IrProgram *p, int f0, int f1, int g0, int g1,
                             const IpoRename *ren, int nren)
{
    int i, k, j;
    if (nren == 0) return;
    for (i = f0; i < f1; i++) {
        IrFunc *f = p->funcs[i];
        if (f->alias_target) {
            const char *to = ipo_rename_lookup(ren, nren, f->alias_target);
            if (to) f->alias_target = (char *)to;
        }
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            const char *to;
            switch (I->op) {
            case IR_CALL:
            case IR_PUSH_FUNC:
            case IR_PUSH_GLOBAL:
            case IR_STORE_GLOBAL:
            case IR_PUSH_GLOBAL_ADDR:
                break;
            default:
                continue;
            }
            to = ipo_rename_lookup(ren, nren, I->name);
            if (to) I->name = to;
        }
    }
    for (i = g0; i < g1; i++) {
        IrGlobal *g = p->globals[i];
        const char *to;
        if (g->init_sym) {
            to = ipo_rename_lookup(ren, nren, g->init_sym);
            if (to) g->init_sym = (char *)to;
        }
        for (j = 0; j < g->init_ref_count; j++) {
            if (!g->init_refs[j].sym) continue;
            to = ipo_rename_lookup(ren, nren, g->init_refs[j].sym);
            if (to) g->init_refs[j].sym = (char *)to;
        }
    }
}

/* ------------------------------------------------------------------ */
/* Step 1: make one unit's statics distinct                            */
/* ------------------------------------------------------------------ */

/* Returns ARK_OK, or ARK_ERR_ARG after a diagnostic. */
static int ipo_mangle_unit(IrProgram *p, int unit, int f0, int f1, int g0, int g1)
{
    int nren = (f1 - f0) + (g1 - g0);
    IpoRename *ren;
    int i, n = 0;
    if (nren <= 0) return ARK_OK;
    ren = (IpoRename *)mem_pool_alloc((int)sizeof(IpoRename) * nren);
    for (i = f0; i < f1; i++) {
        IrFunc *f = p->funcs[i];
        if (!f->is_static) continue;
        ren[n].from = f->name;
        ren[n].to   = ipo_mangle(p, f->name, unit, "f");
        if (!ren[n].to) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "cannot make a unique symbol name for static function '%s'",
                      f->name, 0,0,0,0,0);
            return ARK_ERR_ARG;
        }
        f->name = (char *)ren[n].to;
        n++;
    }
    for (i = g0; i < g1; i++) {
        IrGlobal *g = p->globals[i];
        if (!g->is_static) continue;
        ren[n].from = g->name;
        ren[n].to   = ipo_mangle(p, g->name, unit, "g");
        if (!ren[n].to) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "cannot make a unique symbol name for static object '%s'",
                      g->name, 0,0,0,0,0);
            return ARK_ERR_ARG;
        }
        g->name = (char *)ren[n].to;
        n++;
    }
    /* References were made before the rename: rewrite them inside this unit
     * only.  Another unit's identically named static has its own mapping and
     * its own range, and a global of that name is a different symbol. */
    ipo_rewrite_unit(p, f0, f1, g0, g1, ren, n);
    return ARK_OK;
}

/* ------------------------------------------------------------------ */
/* Step 2: resolve names across units                                  */
/* ------------------------------------------------------------------ */

/* Two (or more) external functions with one name: the linker's rule applies,
 * "one strong definition wins, weak ones lose", and two strong ones are an
 * error.  Resolving it HERE instead of leaving duplicate labels to codegen is
 * what keeps the merged image linkable at all. */
static int ipo_dedupe_funcs(IrProgram *p)
{
    int i, kept = 0;
    if (p->func_count <= 0) return ARK_OK;
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        int j, found = -1;
        for (j = 0; j < kept; j++)
            if (ark_streq(p->funcs[j]->name, f->name)) { found = j; break; }
        if (found < 0) { p->funcs[kept++] = f; continue; }
        if (f->is_weak && p->funcs[found]->is_weak) continue;     /* keep the first */
        if (f->is_weak) continue;                                 /* strong beats it */
        if (p->funcs[found]->is_weak) { p->funcs[found] = f; continue; }
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "multiple definition of function '%s' across the --ipo inputs",
                  f->name, 0,0,0,0,0);
        return ARK_ERR_LINK;
    }
    p->func_count = kept;
    return ARK_OK;
}

/* Same for objects, with C's tentative-definition rule:
 *   int g;                 twice  -> one object (6.9.2p2)
 *   int g = 1;             twice  -> error
 *   extern int g + int g          -> the definition survives
 *   extern int g, never defined   -> one extern entry survives, and codegen
 *                                    then either finds a definition or the
 *                                    image build refuses the reference.
 * A strong definition replaces a placeholder so the initialiser is not lost. */
static int ipo_dedupe_globals(IrProgram *p)
{
    int i, kept = 0;
    if (p->global_count <= 0) return ARK_OK;
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        int j, found = -1;
        for (j = 0; j < kept; j++)
            if (ark_streq(p->globals[j]->name, g->name)) { found = j; break; }
        if (found < 0) { p->globals[kept++] = g; continue; }
        {
            IrGlobal *cur = p->globals[found];
            int g_def = (!g->is_extern && g->has_init);
            int c_def = (!cur->is_extern && cur->has_init);
            if (g_def && c_def) {
                diag_tool(DIAG_SEV_ERROR, "arkcc",
                          "multiple definition of '%s' across the --ipo inputs",
                          g->name, 0,0,0,0,0);
                return ARK_ERR_LINK;
            }
            if (g_def) { p->globals[found] = g; continue; }
            if (c_def) continue;
            if (g->is_extern) continue;
            /* two tentative definitions: one object, keep the first */
            continue;
        }
    }
    p->global_count = kept;
    return ARK_OK;
}

/* ------------------------------------------------------------------ */
/* Step 3: drop what nothing refers to any more                        */
/* ------------------------------------------------------------------ */

/* After cross-file inlining, a static helper may have no callers left.  The
 * linker used to be unable to remove it (nothing in an ARKOBJ2 object says
 * "unused"), and codegen would emit it.  Removing it here is a size win only;
 * it must never change behaviour, so every case where "unused" cannot be
 * proved is kept:
 *   - `used`, `constructor`, `destructor`: the definition itself is the use;
 *   - alias target: another symbol names it;
 *   - any inline asm anywhere in the program: its text can name a symbol and
 *     we do not parse assembler (refuse to guess -> skip pruning entirely).
 * Objects keep the same rule plus __at()/section()/used: placement attributes
 * are observable from outside the C program. */
static int ipo_program_has_asm(IrProgram *p)
{
    int i, k;
    for (i = 0; i < p->func_count; i++)
        for (k = 0; k < p->funcs[i]->code_count; k++)
            if (p->funcs[i]->code[k].op == IR_ASM) return 1;
    return 0;
}

static int ipo_name_referenced(IrProgram *p, const char *name)
{
    int i, k, j;
    if (!name) return 0;
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        if (f->alias_target && ark_streq(f->alias_target, name)) return 1;
        for (k = 0; k < f->code_count; k++) {
            IrInst *I = &f->code[k];
            switch (I->op) {
            case IR_CALL:
            case IR_PUSH_FUNC:
            case IR_PUSH_GLOBAL:
            case IR_STORE_GLOBAL:
            case IR_PUSH_GLOBAL_ADDR:
                if (I->name && ark_streq(I->name, name)) return 1;
                break;
            default:
                break;
            }
        }
    }
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        if (g->init_sym && ark_streq(g->init_sym, name)) return 1;
        for (j = 0; j < g->init_ref_count; j++)
            if (g->init_refs[j].sym && ark_streq(g->init_refs[j].sym, name)) return 1;
    }
    return 0;
}

static void ipo_prune_statics(IrProgram *p)
{
    int i, kept;
    if (ipo_program_has_asm(p)) return;

    kept = 0;
    for (i = 0; i < p->func_count; i++) {
        IrFunc *f = p->funcs[i];
        int drop = 0;
        if (f->is_static && !f->is_used && !f->is_constructor && !f->is_destructor &&
            !f->alias_target && !ipo_name_referenced(p, f->name))
            drop = 1;
        if (!drop) p->funcs[kept++] = f;
    }
    p->func_count = kept;

    /* Recompute: the functions just removed may have been the only referrers
     * of a static object. */
    kept = 0;
    for (i = 0; i < p->global_count; i++) {
        IrGlobal *g = p->globals[i];
        int drop = 0;
        if (g->is_static && !g->is_used && !g->has_at && !g->section &&
            !ipo_name_referenced(p, g->name))
            drop = 1;
        if (!drop) p->globals[kept++] = g;
    }
    p->global_count = kept;
}

/* ------------------------------------------------------------------ */
/* The driver                                                          */
/* ------------------------------------------------------------------ */

static int ipo_refuse(const ArkOptions *opts, const char *what, const char *why)
{
    (void)opts;
    diag_tool(DIAG_SEV_ERROR, "arkcc",
              "--ipo cannot be combined with %s: %s", what, why,
              0, 0, 0, 0);
    return ARK_ERR_ARG;
}

int ark_ipo_compile(const ArkOptions *opts)
{
    IrProgram *prog;
    const ArkBackend *be = 0;
    int n, i, rc;

    if (!opts) return ARK_ERR_ARG;
    n = opts->ipo_input_count;
    if (n <= 0) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "--ipo needs at least one source file", 0,0,0,0,0,0);
        return ARK_ERR_ARG;
    }
    for (i = 0; i < n; i++) {
        const char *why = ipo_non_c_reason(opts->ipo_inputs[i]);
        if (why) {
            diag_tool(DIAG_SEV_ERROR, "arkcc",
                      "--ipo input '%s' is not a C source (%s)",
                      opts->ipo_inputs[i], why, 0, 0, 0, 0);
            return ARK_ERR_ARG;
        }
    }
    /* -c: an object holding N translation units would have to answer what an
     * undefined external in unit A means when unit B defines it -- today that
     * is "a relocation", and every unit's statics would then be renamed inside
     * something the linker cannot undo.  Not this stage. */
    if (opts->compile_only)
        return ipo_refuse(opts, "-c",
                          "an object carries no IR, and merging units into one "
                          "object is a different (linker-visible) contract");
    if (opts->preprocess_only)
        return ipo_refuse(opts, "-E",
                          "preprocessing is per file; use -E on each file");
    if (opts->debug_info)
        return ipo_refuse(opts, "-g",
                          "a merged program has one source_file, so every "
                          "unit's lines would be labelled with the first file's "
                          "name -- refuse rather than emit wrong debug info");
    if (opts->link_mode)
        return ipo_refuse(opts, "-link", "-link works on objects; --ipo compiles sources");
    if (!opts->output_path)
        return ipo_refuse(opts, "no -o",
                          "with several inputs there is no single name to "
                          "derive the output from");

    mem_pool_reset();
    prog = ir_program_new();

    for (i = 0; i < n; i++) {
        ArkOptions unit = *opts;
        IrProgram *uir = 0;
        const ArkBackend *ube = 0;
        int f0 = prog->func_count;
        int g0 = prog->global_count;

        unit.input_path = opts->ipo_inputs[i];
        unit.ipo_mode = 0;
        unit.ipo_input_count = 0;

        rc = ark_frontend_unit(&unit, prog, &uir, &ube);
        if (rc != ARK_OK) return rc;
        if (!uir) return ARK_ERR_ARG;   /* refused above; never a silent success */
        be = ube;

        rc = ipo_mangle_unit(prog, i, f0, prog->func_count, g0, prog->global_count);
        if (rc != ARK_OK) return rc;
    }

    rc = ipo_dedupe_funcs(prog);
    if (rc != ARK_OK) return rc;
    rc = ipo_dedupe_globals(prog);
    if (rc != ARK_OK) return rc;

    /* One pipeline run over the whole program -- this is the point of --ipo.
     * The policy is the same one a single file gets; only the scope is new. */
    {
        int lvl = opts->opt_level;
        if (lvl < g_config.opt_level) lvl = g_config.opt_level;
        pipeline_run_ir(prog, lvl, pipeline_profile());
    }
    ipo_prune_statics(prog);

    prog->source_file = opts->ipo_inputs[0];

    return ark_emit_program(opts, prog, be);
}

/* ------------------------------------------------------------------ */
/* Link-time code generation: -link --lto                              */
/* ------------------------------------------------------------------ */

#if ARKCC_FEATURE_OBJ_IR

/* Same shape as ipo_refuse(), different verb: the reader is running the
 * linker, not the whole-program compiler, and the message should say so. */
static int lto_refuse(const ArkOptions *opts, const char *what, const char *why)
{
    (void)opts;
    diag_tool(DIAG_SEV_ERROR, "arkcc",
              "--lto cannot be combined with %s: %s", what, why,
              0, 0, 0, 0);
    return ARK_ERR_ARG;
}

/* Read `path` into buf (ARK_LINK_BUF_SIZE bytes) and return the payload it
 * carries.  Everything that can go wrong here has a name: unreadable file,
 * file larger than the buffer, truncated read, not an ARKOBJ2 object,
 * malformed tables, an object built without --obj-ir.  In every case a
 * diagnostic is printed and -1 is returned; there is no "carry on with what we
 * have", because a link that silently drops a unit's code is a wrong answer. */
static int lto_read_payload(const char *path, unsigned char *buf,
                            IrProgram **out)
{
    const unsigned char *pl = 0;
    int plen = 0;
    int fsz, got, pr;

    *out = 0;
    fsz = fs_file_size(path);
    if (fsz < 0) {
        diag_tool(DIAG_SEV_ERROR, path,
                  "cannot stat object: %s", fs_last_error(),
                  0, 0, 0, 0, 0);
        return -1;
    }
    if (fsz > ARK_LINK_BUF_SIZE) {
        char b1[12], b2[12];
        diag_tool(DIAG_SEV_ERROR, path,
                  "object is %s bytes but this arkcc reads at most %s; "
                  "raise ARK_LINK_BUF_SIZE and rebuild arkcc",
                  diag_num(b1, fsz), diag_num(b2, ARK_LINK_BUF_SIZE),
                  0, 0, 0, 0);
        return -1;
    }
    /* fs_read_file() may truncate silently or refuse outright depending on the
     * port; comparing what it reports with what stat said turns both
     * behaviours into one honest diagnostic. */
    got = fs_read_file(path, (char *)buf, ARK_LINK_BUF_SIZE);
    if (got < 0) {
        diag_tool(DIAG_SEV_ERROR, path,
                  "cannot read object: %s", fs_last_error(),
                  0, 0, 0, 0, 0);
        return -1;
    }
    if (got < fsz) {
        char b1[12], b2[12];
        diag_tool(DIAG_SEV_ERROR, path,
                  "only %s of %s bytes could be read; raise "
                  "ARK_LINK_BUF_SIZE and rebuild arkcc",
                  diag_num(b1, got), diag_num(b2, fsz), 0, 0, 0, 0);
        return -1;
    }
    /* The magic check is explicit rather than trusting the payload search: an
     * object from another tool must be named as such, not reported as a
     * corrupt payload. */
    if (got < 8 || buf[0] != 'A' || buf[1] != 'R' || buf[2] != 'K' ||
        buf[3] != 'O' || buf[4] != 'B' || buf[5] != 'J' ||
        buf[6] != '2' || buf[7] != '\n') {
        diag_tool(DIAG_SEV_ERROR, path,
                  "not an ARKOBJ2 object; --lto reads the objects produced by "
                  "`-c --obj-ir`", 0, 0, 0, 0, 0, 0);
        return -1;
    }
    /* want_payload = 1: an object without an IR payload is the one thing -link
     * --lto cannot work with, and mixing it in would produce an image missing
     * that unit. Refuse, naming the file. */
    pr = ir_obj_find_payload(buf, got, 1, &pl, &plen, path);
    if (pr <= 0) return -1;
    *out = ir_deserialize(pl, plen, path);
    return *out ? 0 : -1;
}

int ark_lto_link(const ArkOptions *opts)
{
    IrProgram *prog;
    const ArkBackend *be;
    unsigned char *buf;
    const char *first_src = 0;
    int n, i, rc;

    if (!opts) return ARK_ERR_ARG;
    n = opts->link_input_count;
    if (n <= 0) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "--lto needs at least one object file",
                  0, 0, 0, 0, 0, 0);
        return ARK_ERR_ARG;
    }
    /* -c under -link --lto would ask for an object built from objects.  The IR
     * could in principle be re-serialised, but nothing asks for that yet and a
     * silent "it worked" would carry a merged symbol table nobody validates. */
    if (opts->compile_only)
        return lto_refuse(opts, "-c",
                          "--lto generates code from IR and writes a program");
    if (opts->preprocess_only)
        return lto_refuse(opts, "-E", "an object is already preprocessed");
    if (opts->debug_info)
        return lto_refuse(opts, "-g",
                          "a merged program has one source_file, so every "
                          "unit's lines would be labelled with the first "
                          "object's name");
    if (!opts->output_path)
        return lto_refuse(opts, "no -o",
                          "with several objects there is no single name to "
                          "derive the output from");

    be = opts->target ? ark_backend_find(opts->target) : ark_backend_default();
    if (!be) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "unknown target '%s' for --lto", opts->target,
                  0, 0, 0, 0, 0);
        return ARK_ERR_ARG;
    }

    /* One arena for the whole link, exactly as --ipo: types deserialised for
     * unit N must outlive the merge of unit N+1. */
    mem_pool_reset();
    buf = (unsigned char *)mem_pool_alloc(ARK_LINK_BUF_SIZE);
    if (!buf) {
        diag_tool(DIAG_SEV_ERROR, "arkcc",
                  "out of memory: cannot allocate the object buffer",
                  0, 0, 0, 0, 0, 0);
        return ARK_ERR_OOM;
    }
    type_set_ptr_size(be->pointer_size);
    prog = ir_program_new();

    for (i = 0; i < n; i++) {
        const char *path = opts->link_inputs[i];
        IrProgram *u = 0;
        int f0, g0;

        if (lto_read_payload(path, buf, &u) != 0) return ARK_ERR_LINK;
        /* The image has one source_file slot; like --ipo, use the first unit's
         * name and refuse -g above rather than mislabel the others. */
        if (i == 0) first_src = u->source_file;
        f0 = prog->func_count;
        g0 = prog->global_count;
        ir_program_append_unit(prog, u, i, path);
        /* Same per-unit mangling --ipo applies: two objects may each carry a
         * file-static `helper`, and after merging they must stay distinct. */
        rc = ipo_mangle_unit(prog, i, f0, prog->func_count, g0, prog->global_count);
        if (rc != ARK_OK) return rc;
    }

    rc = ipo_dedupe_funcs(prog);
    if (rc != ARK_OK) return rc;
    rc = ipo_dedupe_globals(prog);
    if (rc != ARK_OK) return rc;

    /* The point of --lto: the pass pipeline runs over the merged program, so
     * ir.inline sees callees from other objects and cross-TU constant
     * propagation sees definitions from other objects. */
    {
        int lvl = opts->opt_level;
        if (lvl < g_config.opt_level) lvl = g_config.opt_level;
        pipeline_run_ir(prog, lvl, pipeline_profile());
    }
    ipo_prune_statics(prog);

    prog->source_file = first_src;

    return ark_emit_program(opts, prog, be);
}

#else /* !ARKCC_FEATURE_OBJ_IR -- the stub after the IPO block refuses */

#endif /* ARKCC_FEATURE_OBJ_IR */

#else /* !ARKCC_FEATURE_IPO */

/* A build without the feature still exports the symbol, so --ipo is refused
 * with a diagnostic instead of "unrecognized option" hiding a build choice. */
int ark_ipo_compile(const ArkOptions *opts)
{
    (void)opts;
    diag_tool(DIAG_SEV_ERROR, "arkcc",
              "--ipo is not compiled into this build "
              "(rebuild with -DARKCC_FEATURE_IPO=1)",
              0,0,0,0,0,0);
    return ARK_ERR_ARG;
}

#endif /* ARKCC_FEATURE_IPO */

#if !ARKCC_FEATURE_IPO || !ARKCC_FEATURE_OBJ_IR

/* -link --lto needs both halves: --ipo's merge machinery and the IR payload
 * reader/writer.  A build missing either still exports the symbol, so the
 * option is refused with a diagnostic that names the build choice instead of
 * dying with "unrecognized option" -- which would send the reader looking for
 * a typo. */
int ark_lto_link(const ArkOptions *opts)
{
    (void)opts;
    diag_tool(DIAG_SEV_ERROR, "arkcc",
              "--lto is not compiled into this build "
              "(rebuild with -DARKCC_FEATURE_IPO=1 -DARKCC_FEATURE_OBJ_IR=1)",
              0, 0, 0, 0, 0, 0);
    return ARK_ERR_ARG;
}

#endif /* !ARKCC_FEATURE_IPO || !ARKCC_FEATURE_OBJ_IR */
