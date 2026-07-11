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

    .globl _main
_main:
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
    je .Lmain_0
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lmain_0:
.Lmain_1:
    call _config_init
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lmain_2:
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
    je .Lmain_3
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
    je .Lmain_7
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
    jmp .Lmain_8
.Lmain_7:
    pushl $0
.Lmain_8:
    popl %eax
    cmpl $0, %eax
    je .Lmain_5
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
    jmp .Lmain_3
.Lmain_5:
.Lmain_6:
.Lmain_4:
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
    jmp .Lmain_2
.Lmain_3:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lmain_11
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
    jmp .Lmain_12
.Lmain_11:
    pushl $0
.Lmain_12:
    popl %eax
    cmpl $0, %eax
    je .Lmain_9
    leal ark_str_5, %eax
    pushl %eax
    call _config_load_file
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lmain_10
.Lmain_9:
.Lmain_10:
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
.Lmain_13:
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
    je .Lmain_14
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
    je .Lmain_16
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
    jmp .Lmain_17
.Lmain_16:
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
    je .Lmain_18
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
    jmp .Lmain_19
.Lmain_18:
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
    je .Lmain_20
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
    jmp .Lmain_21
.Lmain_20:
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
    je .Lmain_22
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
    jmp .Lmain_23
.Lmain_22:
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
    je .Lmain_24
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
    jmp .Lmain_25
.Lmain_24:
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
    je .Lmain_26
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
    je .Lmain_30
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
    jmp .Lmain_31
.Lmain_30:
    pushl $0
.Lmain_31:
    popl %eax
    cmpl $0, %eax
    je .Lmain_28
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
    jmp .Lmain_29
.Lmain_28:
    pushl $0
.Lmain_29:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lmain_27
.Lmain_26:
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
    je .Lmain_32
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
    jmp .Lmain_33
.Lmain_32:
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
    je .Lmain_34
    jmp .Lmain_35
.Lmain_34:
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
    je .Lmain_38
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
    jmp .Lmain_39
.Lmain_38:
    pushl $0
.Lmain_39:
    popl %eax
    cmpl $0, %eax
    je .Lmain_36
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
    jmp .Lmain_37
.Lmain_36:
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
    je .Lmain_42
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
    jmp .Lmain_43
.Lmain_42:
    pushl $0
.Lmain_43:
    popl %eax
    cmpl $0, %eax
    je .Lmain_40
    jmp .Lmain_41
.Lmain_40:
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
    jne .Lmain_86
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
    jmp .Lmain_87
.Lmain_86:
    pushl $1
.Lmain_87:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_84
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
    jmp .Lmain_85
.Lmain_84:
    pushl $1
.Lmain_85:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_82
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
    jmp .Lmain_83
.Lmain_82:
    pushl $1
.Lmain_83:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_80
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
    jmp .Lmain_81
.Lmain_80:
    pushl $1
.Lmain_81:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_78
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
    jmp .Lmain_79
.Lmain_78:
    pushl $1
.Lmain_79:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_76
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
    jmp .Lmain_77
.Lmain_76:
    pushl $1
.Lmain_77:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_74
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
    jmp .Lmain_75
.Lmain_74:
    pushl $1
.Lmain_75:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_72
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
    jmp .Lmain_73
.Lmain_72:
    pushl $1
.Lmain_73:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_70
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
    jmp .Lmain_71
.Lmain_70:
    pushl $1
.Lmain_71:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_68
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
    jmp .Lmain_69
.Lmain_68:
    pushl $1
.Lmain_69:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_66
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
    jmp .Lmain_67
.Lmain_66:
    pushl $1
.Lmain_67:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_64
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
    jmp .Lmain_65
.Lmain_64:
    pushl $1
.Lmain_65:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_62
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
    jmp .Lmain_63
.Lmain_62:
    pushl $1
.Lmain_63:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_60
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
    jmp .Lmain_61
.Lmain_60:
    pushl $1
.Lmain_61:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_58
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
    jmp .Lmain_59
.Lmain_58:
    pushl $1
.Lmain_59:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_56
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
    jmp .Lmain_57
.Lmain_56:
    pushl $1
.Lmain_57:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_54
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
    jmp .Lmain_55
.Lmain_54:
    pushl $1
.Lmain_55:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_52
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
    jmp .Lmain_53
.Lmain_52:
    pushl $1
.Lmain_53:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_50
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
    jmp .Lmain_51
.Lmain_50:
    pushl $1
.Lmain_51:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_48
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
    jmp .Lmain_49
.Lmain_48:
    pushl $1
.Lmain_49:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_46
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
    jmp .Lmain_47
.Lmain_46:
    pushl $1
.Lmain_47:
    popl %eax
    cmpl $0, %eax
    je .Lmain_44
    jmp .Lmain_45
.Lmain_44:
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
    je .Lmain_90
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
    jmp .Lmain_91
.Lmain_90:
    pushl $0
.Lmain_91:
    popl %eax
    cmpl $0, %eax
    je .Lmain_88
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
    jmp .Lmain_89
.Lmain_88:
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
    jne .Lmain_98
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
    jmp .Lmain_99
.Lmain_98:
    pushl $1
.Lmain_99:
    popl %eax
    cmpl $0, %eax
    jne .Lmain_96
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
    jmp .Lmain_97
.Lmain_96:
    pushl $1
.Lmain_97:
    popl %eax
    cmpl $0, %eax
    je .Lmain_94
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
    jmp .Lmain_95
.Lmain_94:
    pushl $0
.Lmain_95:
    popl %eax
    cmpl $0, %eax
    je .Lmain_92
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
    jmp .Lmain_93
.Lmain_92:
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
    je .Lmain_102
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
    jmp .Lmain_103
.Lmain_102:
    pushl $0
.Lmain_103:
    popl %eax
    cmpl $0, %eax
    je .Lmain_100
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
    jmp .Lmain_101
.Lmain_100:
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
    je .Lmain_106
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
    jmp .Lmain_107
.Lmain_106:
    pushl $0
.Lmain_107:
    popl %eax
    cmpl $0, %eax
    je .Lmain_104
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
    jmp .Lmain_105
.Lmain_104:
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
    je .Lmain_110
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
    jmp .Lmain_111
.Lmain_110:
    pushl $0
.Lmain_111:
    popl %eax
    cmpl $0, %eax
    je .Lmain_108
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
    jmp .Lmain_109
.Lmain_108:
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
    je .Lmain_114
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
    jmp .Lmain_115
.Lmain_114:
    pushl $0
.Lmain_115:
    popl %eax
    cmpl $0, %eax
    je .Lmain_112
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
    je .Lmain_116
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
    jmp .Lmain_117
.Lmain_116:
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
.Lmain_117:
    jmp .Lmain_113
.Lmain_112:
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
    jne .Lmain_120
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
    jmp .Lmain_121
.Lmain_120:
    pushl $1
.Lmain_121:
    popl %eax
    cmpl $0, %eax
    je .Lmain_118
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
    je .Lmain_122
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
    jmp .Lmain_123
.Lmain_122:
.Lmain_123:
    jmp .Lmain_119
.Lmain_118:
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
    jne .Lmain_126
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
    jmp .Lmain_127
.Lmain_126:
    pushl $1
.Lmain_127:
    popl %eax
    cmpl $0, %eax
    je .Lmain_124
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
    jmp .Lmain_125
.Lmain_124:
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
    je .Lmain_130
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
    jmp .Lmain_131
.Lmain_130:
    pushl $0
.Lmain_131:
    popl %eax
    cmpl $0, %eax
    je .Lmain_128
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
    jmp .Lmain_129
.Lmain_128:
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
    jne .Lmain_134
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
    jmp .Lmain_135
.Lmain_134:
    pushl $1
.Lmain_135:
    popl %eax
    cmpl $0, %eax
    je .Lmain_132
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
    jmp .Lmain_133
.Lmain_132:
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
    je .Lmain_136
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
.Lmain_138:
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
    je .Lmain_139
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
    je .Lmain_140
    jmp .Lmain_139
.Lmain_140:
.Lmain_141:
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
    je .Lmain_142
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
    jmp .Lmain_143
.Lmain_142:
.Lmain_143:
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
    jmp .Lmain_138
.Lmain_139:
    jmp .Lmain_137
.Lmain_136:
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
    je .Lmain_144
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
    jmp .Lmain_145
.Lmain_144:
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
    jne .Lmain_148
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
    jmp .Lmain_149
.Lmain_148:
    pushl $1
.Lmain_149:
    popl %eax
    cmpl $0, %eax
    je .Lmain_146
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lmain_146:
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
    je .Lmain_152
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
    jmp .Lmain_153
.Lmain_152:
    pushl $0
.Lmain_153:
    popl %eax
    cmpl $0, %eax
    je .Lmain_150
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
    je .Lmain_154
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
    jmp .Lmain_155
.Lmain_154:
.Lmain_155:
    jmp .Lmain_151
.Lmain_150:
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
    je .Lmain_158
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
    jmp .Lmain_159
.Lmain_158:
    pushl $0
.Lmain_159:
    popl %eax
    cmpl $0, %eax
    je .Lmain_156
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
    je .Lmain_160
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
    jmp .Lmain_161
.Lmain_160:
.Lmain_161:
    jmp .Lmain_157
.Lmain_156:
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
    je .Lmain_162
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
.Lmain_162:
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
.Lmain_163:
.Lmain_157:
.Lmain_151:
.Lmain_147:
.Lmain_145:
.Lmain_137:
.Lmain_133:
.Lmain_129:
.Lmain_125:
.Lmain_119:
.Lmain_113:
.Lmain_109:
.Lmain_105:
.Lmain_101:
.Lmain_93:
.Lmain_89:
.Lmain_45:
.Lmain_41:
.Lmain_37:
.Lmain_35:
.Lmain_33:
.Lmain_27:
.Lmain_25:
.Lmain_23:
.Lmain_21:
.Lmain_19:
.Lmain_17:
.Lmain_15:
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
    jmp .Lmain_13
.Lmain_14:
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
    je .Lmain_164
    call _config_print
    pushl %eax
    addl $4, %esp
    jmp .Lmain_165
.Lmain_164:
.Lmain_165:
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
    je .Lmain_170
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
    jmp .Lmain_171
.Lmain_170:
    pushl $0
.Lmain_171:
    popl %eax
    cmpl $0, %eax
    je .Lmain_168
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
    jmp .Lmain_169
.Lmain_168:
    pushl $0
.Lmain_169:
    popl %eax
    cmpl $0, %eax
    je .Lmain_166
    call _usage
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lmain_166:
.Lmain_167:
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
    je .Lmain_172
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
.Lmain_172:
.Lmain_173:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

