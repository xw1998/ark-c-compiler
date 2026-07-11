# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .section .rdata,"dr"
ark_str_0:
    .asciz "0.2.0"
ark_str_1:
    .asciz "Ark C Compiler v%s\nUsage: arkcc <file.c> [options]\n  -o <file>          output file\n  -S                 emit assembly text (or .gen.c for -target c)\n  -c                 compile only (produce .ark_obj)\n  -E                 preprocess only, write expanded source\n  -link a.o b.o      link multiple .ark_obj files (use with -o)\n  -v                 verbose\n  -target <name>     select backend (arm|x86_64|riscv32|c)\n  -I <dir>           additional include path\n  -O0/-O1/-O2        optimisation level (accepted but currently unused)\n  -g                 emit debug info (accepted but currently unused)\n  -Wno-unused        suppress unused warnings\n  -config <file>     load arkcc INI config file\n  -f<feature>        enable feature (vla/complex/wchar/trigraph/fpu/dwarf/...)\n  -fno-<feature>     disable feature\n  -mcpu <name>       target CPU (Cortex-M0/M3/M4/M7/M33...); alias: --cpu\n  -MMD               generate dependency file; alias: --depend\n  -MF <file>         dependency output path (use with -MMD)\n  -ffunction-sections  one section per function; alias: --split_sections\n  --scatter <file>   ARM scatter .sct file (parsed and converted to .ld when -S is used)\n  -T <file>          GNU ld linker script .ld (alias: --linker-script; converted to .sct with -S)\n  -config <file>     load arkcc INI config file (overrides defaults; see arkcc.cfg)\n  -profile <name>    select build profile (host_full/stm32_min/cross_compile)\n  -D<name>[=<val>]   define macro (e.g. -DFOO=1 or -D FOO)\n  --list-backends    print available backends and exit\n  -h, --help         this message\n"
ark_str_2:
    .asciz "r"
ark_str_3:
    .asciz "-config"
ark_str_4:
    .asciz "arkcc.cfg"
ark_str_5:
    .asciz "arkcc.cfg"
ark_str_6:
    .asciz "-S"
ark_str_7:
    .asciz "-c"
ark_str_8:
    .asciz "-E"
ark_str_9:
    .asciz "-v"
ark_str_10:
    .asciz "-g"
ark_str_11:
    .asciz "-O"
ark_str_12:
    .asciz "-Wno-unused"
ark_str_13:
    .asciz "-W"
ark_str_14:
    .asciz "-config"
ark_str_15:
    .asciz "--enum_is_int"
ark_str_16:
    .asciz "-fenum-is-int"
ark_str_17:
    .asciz "--dollar"
ark_str_18:
    .asciz "--signed_chars"
ark_str_19:
    .asciz "--unsigned_chars"
ark_str_20:
    .asciz "--wchar16"
ark_str_21:
    .asciz "--wchar32"
ark_str_22:
    .asciz "--dwarf2"
ark_str_23:
    .asciz "--dwarf3"
ark_str_24:
    .asciz "--thumb"
ark_str_25:
    .asciz "--arm"
ark_str_26:
    .asciz "--remarks"
ark_str_27:
    .asciz "--autoinline"
ark_str_28:
    .asciz "--no_autoinline"
ark_str_29:
    .asciz "--vectorize"
ark_str_30:
    .asciz "--no_vectorize"
ark_str_31:
    .asciz "--library_type"
ark_str_32:
    .asciz "--locale"
ark_str_33:
    .asciz "--multibyte_chars"
ark_str_34:
    .asciz "--data_reorder"
ark_str_35:
    .asciz "--diag_style"
ark_str_36:
    .asciz "--remove_unneeded_entities"
ark_str_37:
    .asciz "--scatter"
ark_str_38:
    .asciz "-T"
ark_str_39:
    .asciz "--linker-script"
ark_str_40:
    .asciz "--script"
ark_str_41:
    .asciz "--fpu"
ark_str_42:
    .asciz "-o"
ark_str_43:
    .asciz "-target"
ark_str_44:
    .asciz "-I"
ark_str_45:
    .asciz "-mcpu"
ark_str_46:
    .asciz "--cpu"
ark_str_47:
    .asciz "-MMD"
ark_str_48:
    .asciz "--depend"
ark_str_49:
    .asciz "-MF"
ark_str_50:
    .asciz "-ffunction-sections"
ark_str_51:
    .asciz "--split_sections"
ark_str_52:
    .asciz "-link"
ark_str_53:
    .asciz "--list-backends"
ark_str_54:
    .asciz "-h"
ark_str_55:
    .asciz "--help"
ark_str_56:
    .asciz "-D"
ark_str_57:
    .asciz "-D"
ark_str_58:
    .asciz "[arkcc] unknown option: %s\n"
ark_str_59:
    .asciz "[arkcc] failed with code %d\n"
    .text
_usage:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    leal ark_str_0, %eax
    pushl %eax
    leal ark_str_1, %eax
    pushl %eax
    movl _stderr, %eax
    pushl %eax
    call _fprintf
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_file_exists:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    leal ark_str_2, %eax
    pushl %eax
    pushl -24(%ebp)
    call _fopen
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfile_exists_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfile_exists_0:
.Lfile_exists_1:
    pushl -16(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_reset_opts:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lreset_opts_0:
    pushl -16(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lreset_opts_1
    pushl -24(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lreset_opts_2:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lreset_opts_0
.Lreset_opts_1:
    pushl -24(%ebp)
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lreset_opts_3:
    pushl -16(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lreset_opts_4
    pushl -24(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lreset_opts_5:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lreset_opts_3
.Lreset_opts_4:
    pushl -24(%ebp)
    pushl $232
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $236
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $240
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $244
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $248
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $252
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $260
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $264
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $268
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lreset_opts_6:
    pushl -16(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lreset_opts_7
    pushl -24(%ebp)
    pushl $272
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lreset_opts_8:
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    addl $4, %esp
    jmp .Lreset_opts_6
.Lreset_opts_7:
    pushl -24(%ebp)
    pushl $528
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _arkcc_real_main
_arkcc_real_main:
    pushl %ebp
    movl %esp, %ebp
    subl $848, %esp
    movl 8(%ebp), %eax
    movl %eax, -600(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -592(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    leal -584(%ebp), %eax
    pushl %eax
    call _reset_opts
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -600(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_0
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larkcc_real_main_0:
.Larkcc_real_main_1:
    call _config_init
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Larkcc_real_main_2:
    pushl -48(%ebp)
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_3
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    leal ark_str_3, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_7
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_8
.Larkcc_real_main_7:
    pushl $0
.Larkcc_real_main_8:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_5
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _config_load_file
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_3
.Larkcc_real_main_5:
.Larkcc_real_main_6:
.Larkcc_real_main_4:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_2
.Larkcc_real_main_3:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_11
    leal ark_str_4, %eax
    pushl %eax
    call _file_exists
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_12
.Larkcc_real_main_11:
    pushl $0
.Larkcc_real_main_12:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_9
    leal ark_str_5, %eax
    pushl %eax
    call _config_load_file
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Larkcc_real_main_10
.Larkcc_real_main_9:
.Larkcc_real_main_10:
    pushl -592(%ebp)
    pushl -600(%ebp)
    call _config_apply_args
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Larkcc_real_main_13:
    pushl -48(%ebp)
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_14
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    leal ark_str_6, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_16
    leal -584(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_17
.Larkcc_real_main_16:
    leal ark_str_7, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_18
    leal -584(%ebp), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_19
.Larkcc_real_main_18:
    leal ark_str_8, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_20
    leal -584(%ebp), %eax
    pushl %eax
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_21
.Larkcc_real_main_20:
    leal ark_str_9, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_22
    leal -584(%ebp), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_23
.Larkcc_real_main_22:
    leal ark_str_10, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_24
    leal -584(%ebp), %eax
    pushl %eax
    pushl $240
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_25
.Larkcc_real_main_24:
    pushl $2
    leal ark_str_11, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strncmp
    addl $12, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_26
    leal -584(%ebp), %eax
    pushl %eax
    pushl $236
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_30
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_31
.Larkcc_real_main_30:
    pushl $0
.Larkcc_real_main_31:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_28
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Larkcc_real_main_29
.Larkcc_real_main_28:
    pushl $0
.Larkcc_real_main_29:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_27
.Larkcc_real_main_26:
    leal ark_str_12, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_32
    leal -584(%ebp), %eax
    pushl %eax
    pushl $244
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_33
.Larkcc_real_main_32:
    pushl $2
    leal ark_str_13, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strncmp
    addl $12, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_34
    jmp .Larkcc_real_main_35
.Larkcc_real_main_34:
    leal ark_str_14, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_38
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_39
.Larkcc_real_main_38:
    pushl $0
.Larkcc_real_main_39:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_36
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_37
.Larkcc_real_main_36:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_42
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_43
.Larkcc_real_main_42:
    pushl $0
.Larkcc_real_main_43:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_40
    jmp .Larkcc_real_main_41
.Larkcc_real_main_40:
    leal ark_str_15, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_86
    leal ark_str_16, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_87
.Larkcc_real_main_86:
    pushl $1
.Larkcc_real_main_87:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_84
    leal ark_str_17, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_85
.Larkcc_real_main_84:
    pushl $1
.Larkcc_real_main_85:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_82
    leal ark_str_18, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_83
.Larkcc_real_main_82:
    pushl $1
.Larkcc_real_main_83:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_80
    leal ark_str_19, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_81
.Larkcc_real_main_80:
    pushl $1
.Larkcc_real_main_81:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_78
    leal ark_str_20, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_79
.Larkcc_real_main_78:
    pushl $1
.Larkcc_real_main_79:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_76
    leal ark_str_21, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_77
.Larkcc_real_main_76:
    pushl $1
.Larkcc_real_main_77:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_74
    leal ark_str_22, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_75
.Larkcc_real_main_74:
    pushl $1
.Larkcc_real_main_75:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_72
    leal ark_str_23, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_73
.Larkcc_real_main_72:
    pushl $1
.Larkcc_real_main_73:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_70
    leal ark_str_24, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_71
.Larkcc_real_main_70:
    pushl $1
.Larkcc_real_main_71:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_68
    leal ark_str_25, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_69
.Larkcc_real_main_68:
    pushl $1
.Larkcc_real_main_69:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_66
    leal ark_str_26, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_67
.Larkcc_real_main_66:
    pushl $1
.Larkcc_real_main_67:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_64
    leal ark_str_27, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_65
.Larkcc_real_main_64:
    pushl $1
.Larkcc_real_main_65:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_62
    leal ark_str_28, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_63
.Larkcc_real_main_62:
    pushl $1
.Larkcc_real_main_63:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_60
    leal ark_str_29, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_61
.Larkcc_real_main_60:
    pushl $1
.Larkcc_real_main_61:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_58
    leal ark_str_30, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_59
.Larkcc_real_main_58:
    pushl $1
.Larkcc_real_main_59:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_56
    leal ark_str_31, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_57
.Larkcc_real_main_56:
    pushl $1
.Larkcc_real_main_57:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_54
    leal ark_str_32, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_55
.Larkcc_real_main_54:
    pushl $1
.Larkcc_real_main_55:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_52
    leal ark_str_33, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_53
.Larkcc_real_main_52:
    pushl $1
.Larkcc_real_main_53:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_50
    leal ark_str_34, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_51
.Larkcc_real_main_50:
    pushl $1
.Larkcc_real_main_51:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_48
    leal ark_str_35, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_49
.Larkcc_real_main_48:
    pushl $1
.Larkcc_real_main_49:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_46
    leal ark_str_36, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_47
.Larkcc_real_main_46:
    pushl $1
.Larkcc_real_main_47:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_44
    jmp .Larkcc_real_main_45
.Larkcc_real_main_44:
    leal ark_str_37, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_90
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_91
.Larkcc_real_main_90:
    pushl $0
.Larkcc_real_main_91:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_88
    leal -584(%ebp), %eax
    pushl %eax
    pushl $264
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_89
.Larkcc_real_main_88:
    leal ark_str_38, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_98
    leal ark_str_39, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_99
.Larkcc_real_main_98:
    pushl $1
.Larkcc_real_main_99:
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_96
    leal ark_str_40, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_97
.Larkcc_real_main_96:
    pushl $1
.Larkcc_real_main_97:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_94
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_95
.Larkcc_real_main_94:
    pushl $0
.Larkcc_real_main_95:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_92
    leal -584(%ebp), %eax
    pushl %eax
    pushl $268
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_93
.Larkcc_real_main_92:
    leal ark_str_41, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_102
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_103
.Larkcc_real_main_102:
    pushl $0
.Larkcc_real_main_103:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_100
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_101
.Larkcc_real_main_100:
    leal ark_str_42, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_106
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_107
.Larkcc_real_main_106:
    pushl $0
.Larkcc_real_main_107:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_104
    leal -584(%ebp), %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_105
.Larkcc_real_main_104:
    leal ark_str_43, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_110
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_111
.Larkcc_real_main_110:
    pushl $0
.Larkcc_real_main_111:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_108
    leal -584(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_109
.Larkcc_real_main_108:
    leal ark_str_44, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_114
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_115
.Larkcc_real_main_114:
    pushl $0
.Larkcc_real_main_115:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_112
    leal -584(%ebp), %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_116
    leal -584(%ebp), %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -584(%ebp), %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_117
.Larkcc_real_main_116:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
.Larkcc_real_main_117:
    jmp .Larkcc_real_main_113
.Larkcc_real_main_112:
    leal ark_str_45, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_120
    leal ark_str_46, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_121
.Larkcc_real_main_120:
    pushl $1
.Larkcc_real_main_121:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_118
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_122
    leal -584(%ebp), %eax
    pushl %eax
    pushl $248
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_123
.Larkcc_real_main_122:
.Larkcc_real_main_123:
    jmp .Larkcc_real_main_119
.Larkcc_real_main_118:
    leal ark_str_47, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_126
    leal ark_str_48, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_127
.Larkcc_real_main_126:
    pushl $1
.Larkcc_real_main_127:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_124
    leal -584(%ebp), %eax
    pushl %eax
    pushl $252
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_125
.Larkcc_real_main_124:
    leal ark_str_49, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_130
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_131
.Larkcc_real_main_130:
    pushl $0
.Larkcc_real_main_131:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_128
    leal -584(%ebp), %eax
    pushl %eax
    pushl $256
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_129
.Larkcc_real_main_128:
    leal ark_str_50, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_134
    leal ark_str_51, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_135
.Larkcc_real_main_134:
    pushl $1
.Larkcc_real_main_135:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_132
    leal -584(%ebp), %eax
    pushl %eax
    pushl $260
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_133
.Larkcc_real_main_132:
    leal ark_str_52, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_136
    leal -584(%ebp), %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Larkcc_real_main_138:
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_139
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_140
    jmp .Larkcc_real_main_139
.Larkcc_real_main_140:
.Larkcc_real_main_141:
    leal -584(%ebp), %eax
    pushl %eax
    pushl $232
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_142
    leal -584(%ebp), %eax
    pushl %eax
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -584(%ebp), %eax
    pushl %eax
    pushl $232
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_143
.Larkcc_real_main_142:
.Larkcc_real_main_143:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_138
.Larkcc_real_main_139:
    jmp .Larkcc_real_main_137
.Larkcc_real_main_136:
    leal ark_str_53, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_144
    leal -584(%ebp), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_145
.Larkcc_real_main_144:
    leal ark_str_54, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larkcc_real_main_148
    leal ark_str_55, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_149
.Larkcc_real_main_148:
    pushl $1
.Larkcc_real_main_149:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_146
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larkcc_real_main_146:
    leal ark_str_56, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strcmp
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_152
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_153
.Larkcc_real_main_152:
    pushl $0
.Larkcc_real_main_153:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_150
    leal -584(%ebp), %eax
    pushl %eax
    pushl $528
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_154
    leal -584(%ebp), %eax
    pushl %eax
    pushl $272
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -584(%ebp), %eax
    pushl %eax
    pushl $528
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -592(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_155
.Larkcc_real_main_154:
.Larkcc_real_main_155:
    jmp .Larkcc_real_main_151
.Larkcc_real_main_150:
    pushl $2
    leal ark_str_57, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strncmp
    addl $12, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_158
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_159
.Larkcc_real_main_158:
    pushl $0
.Larkcc_real_main_159:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_156
    leal -584(%ebp), %eax
    pushl %eax
    pushl $528
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_160
    leal -584(%ebp), %eax
    pushl %eax
    pushl $272
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -584(%ebp), %eax
    pushl %eax
    pushl $528
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_161
.Larkcc_real_main_160:
.Larkcc_real_main_161:
    jmp .Larkcc_real_main_157
.Larkcc_real_main_156:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_162
    pushl -24(%ebp)
    leal ark_str_58, %eax
    pushl %eax
    movl _stderr, %eax
    pushl %eax
    call _fprintf
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larkcc_real_main_162:
    leal -584(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Larkcc_real_main_163:
.Larkcc_real_main_157:
.Larkcc_real_main_151:
.Larkcc_real_main_147:
.Larkcc_real_main_145:
.Larkcc_real_main_137:
.Larkcc_real_main_133:
.Larkcc_real_main_129:
.Larkcc_real_main_125:
.Larkcc_real_main_119:
.Larkcc_real_main_113:
.Larkcc_real_main_109:
.Larkcc_real_main_105:
.Larkcc_real_main_101:
.Larkcc_real_main_93:
.Larkcc_real_main_89:
.Larkcc_real_main_45:
.Larkcc_real_main_41:
.Larkcc_real_main_37:
.Larkcc_real_main_35:
.Larkcc_real_main_33:
.Larkcc_real_main_27:
.Larkcc_real_main_25:
.Larkcc_real_main_23:
.Larkcc_real_main_21:
.Larkcc_real_main_19:
.Larkcc_real_main_17:
.Larkcc_real_main_15:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Larkcc_real_main_13
.Larkcc_real_main_14:
    leal -584(%ebp), %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_164
    call _config_print
    pushl %eax
    addl $4, %esp
    jmp .Larkcc_real_main_165
.Larkcc_real_main_164:
.Larkcc_real_main_165:
    leal -584(%ebp), %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_170
    leal -584(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_171
.Larkcc_real_main_170:
    pushl $0
.Larkcc_real_main_171:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_168
    leal -584(%ebp), %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Larkcc_real_main_169
.Larkcc_real_main_168:
    pushl $0
.Larkcc_real_main_169:
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_166
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larkcc_real_main_166:
.Larkcc_real_main_167:
    movl $_g_config, %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_172
    leal -584(%ebp), %eax
    pushl %eax
    pushl $264
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl $_g_config, %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Larkcc_real_main_173
.Larkcc_real_main_172:
.Larkcc_real_main_173:
    leal -584(%ebp), %eax
    pushl %eax
    call _ark_compile
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Larkcc_real_main_174
    pushl -40(%ebp)
    leal ark_str_59, %eax
    pushl %eax
    movl _stderr, %eax
    pushl %eax
    call _fprintf
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larkcc_real_main_174:
.Larkcc_real_main_175:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

