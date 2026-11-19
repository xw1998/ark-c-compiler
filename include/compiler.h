/* Ark C Compiler - compiler.h */
#ifndef ARK_COMPILER_H
#define ARK_COMPILER_H

#include "common.h"
#include "arkcc_config.h"   /* ARK_PP_MAX_INC_DIRS / ARK_LINK_MAX_OBJS */

typedef struct {
    const char *input_path;
    const char *output_path;  /* NULL = derive default */
    int         emit_asm;     /* -S */
    int         verbose;
    const char *target;       /* -target <name>; NULL = default */
    /* Sized from arkcc_config.h (host 128 / board 16, overridable). Both the
     * -I list and the -link input list used to be hard-coded here and filled
     * with a bare `if (count < N)`, so going over them dropped arguments in
     * silence: the 17th search path vanished (surfacing later as "cannot open
     * source input file") and the 33rd object never reached the linker. */
    const char *include_dirs[ARK_PP_MAX_INC_DIRS];
    int         include_dir_count;
    int         list_backends;
    /* === 0.3.0 additions === */
    int         compile_only;     /* -c: generate object file only */
    int         preprocess_only;  /* -E: output preprocessor result only */
    int         link_mode;        /* -link: link multiple objects */
    int         vector_table;     /* --vector-table: reserve ARM_VT_SIZE at the
                                   * front of the image and emit a Cortex-M
                                   * vector table there (no image shift) */
    const char *link_inputs[ARK_LINK_MAX_OBJS];  /* -link inputs */
    int         link_input_count;
    int         opt_level;        /* -O0/-O1/-O2: applied by src/opt.c (range-fold + constant fold) */
    int         debug_info;       /* -g: emits DWARF .debug_info/.debug_abbrev/.debug_line */
    int         no_unused_warn;   /* -Wno-unused */
    /* === 0.6.0 additions: armcc 5 compatibility === */
    const char *cpu;            /* --cpu/-mcpu target CPU name (e.g. Cortex-M4) */
    int         gen_depend;     /* -MMD/--depend: generate dependency file */
    const char *depend_file;    /* -MF dependency file output path */
    int         split_sections; /* -ffunction-sections/--split_sections: one section per function */
    /* === 0.7.0 additions: scatter/linker script support === */
    const char *scatter_file;  /* --scatter <file>: ARM scatter .sct file */
    const char *linker_script; /* -T <file>: GNU ld linker script .ld file */
    /* === 0.7.1 additions: -D command-line macro defines === */
    const char *pre_defines[ARK_MAX_PRE_DEFINES]; /* -DNAME or -DNAME=VALUE entries */
    int         pre_define_count;
    /* === 0.8.0 additions: MDK project auto-discovery === */
    const char *uvprojx;  /* --uvprojx <file>: MDK .uvprojx to auto-extract -I/-D */
    /* === 0.8.0 === */
    const char *build_date;       /* --build-date "Mmm dd yyyy" : 覆盖 __DATE__ */
    const char *build_time;       /* --build-time "hh:mm:ss"   : 覆盖 __TIME__ */
    long long   build_epoch;      /* --source-date-epoch <sec> : 由纪元秒推出上面两个 */
    /* === 0.8.5 === */
    int         print_pipeline;   /* --print-pipeline: 打印 Pass 管线决策表后退出 */
    /* === 0.8.7 === */
    /* --ipo / -flto: whole-program compilation.  Instead of one .c -> one
     * object -> -link, the driver runs the front end once per file in ONE
     * process and one memory pool, merges the IR (src/ipo.c) and generates
     * code once.  That is what makes cross-file inlining possible at all:
     * an ARKOBJ2 object carries machine code and symbols, no IR, so the
     * linker has nothing higher-level to optimise.
     *
     * Off by default; when off, not one byte of the pipeline changes. */
    int         ipo_mode;                        /* --ipo / -flto */
    const char *ipo_inputs[ARK_LINK_MAX_OBJS];   /* the .c files, in order */
    int         ipo_input_count;
    /* --obj-ir: write this unit's IR into the object (after the relocation
     * table, behind an "ARKIR1\n" header) so that a later -link --lto can
     * re-compile it.  Only meaningful with -c and a machine-code backend.
     * The payload is the IR *before* the pass pipeline: --lto runs the
     * pipeline over the merged program, and running it twice would make the
     * result depend on how the units happened to be split. */
    int         obj_ir;                          /* --obj-ir */
    /* -link --lto: instead of concatenating code, deserialise every object's
     * IR, merge the units the way --ipo does, run the pipeline and emit once.
     * An object without a payload is refused, never mixed in. */
    int         lto_link;                        /* -link --lto */
    /* -r: partial link.  With -link, merge the input objects into one
     * ARKOBJ2 object (code + symbols + relocations) instead of writing an
     * image.  The output still names its external references, so it can be
     * linked again later -- that is the whole point: merge several objects
     * into one without resolving anything yet. */
    int         partial_link;                    /* -r (with -link) */
} ArkOptions;

int ark_compile(const ArkOptions *opts);

/* Address of the compiler's own work buffers (.ark_buf), for boot-time
 * reporting of where the linker actually placed them. */
unsigned long arkcc_buf_addr(void);
int ark_compile_and_run(const char *path);

#endif /* ARK_COMPILER_H */
