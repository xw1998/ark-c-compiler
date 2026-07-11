# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "0.2.0"
ark_str_1:
    .asciz "Ark C Compiler v%s\nUsage: arkcc <file.c> [options]\n  -o <file>          output file\n  -S                 emit assembly text (or .gen.c for -target c)\n  -c                 compile only (produce .ark_obj)\n  -E                 preprocess only, write expanded source\n  -link a.o b.o      link multiple .ark_obj files (use with -o)\n  -v                 verbose\n  -target <name>     select backend (arm|x86|riscv32|c)\n  -I <dir>           additional include path\n  -O0/-O1/-O2        optimisation level (accepted but currently unused)\n  -g                 emit debug info (accepted but currently unused)\n  -Wno-unused        suppress unused warnings\n  -config <file>     load arkcc INI config file\n  -f<feature>        enable feature (vla/complex/wchar/trigraph/fpu/dwarf/...)\n  -fno-<feature>     disable feature\n  -mcpu <name>       target CPU (Cortex-M0/M3/M4/M7/M33...); alias: --cpu\n  -MMD               generate dependency file; alias: --depend\n  -MF <file>         dependency output path (use with -MMD)\n  -ffunction-sections  one section per function; alias: --split_sections\n  --scatter <file>   ARM scatter .sct file (parsed and converted to .ld when -S is used)\n  -T <file>          GNU ld linker script .ld (alias: --linker-script; converted to .sct with -S)\n  -config <file>     load arkcc INI config file (overrides defaults; see arkcc.cfg)\n  -profile <name>    select build profile (host_full/stm32_min/cross_compile)\n  -D<name>[=<val>]   define macro (e.g. -DFOO=1 or -D FOO)\n  --list-backends    print available backends and exit\n  -h, --help         this message\n"
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
    .data
    .text
    .globl usage
usage:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ark_str_0]
    push eax
    lea eax, [ark_str_1]
    push eax
    mov eax, [stderr]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    pop eax
    mov [ebp-88], eax
    mov [ebp-64], esp
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call fprintf
    mov esp, [ebp-64]
    push eax
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl file_exists
file_exists:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    lea eax, [ark_str_2]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call fopen
    mov esp, [ebp-64]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lfile_exists_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lfile_exists_1
.Lfile_exists_0:
.Lfile_exists_1:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call fclose
    mov esp, [ebp-64]
    push eax
    add esp, 4
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl reset_opts
reset_opts:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lreset_opts_0:
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lreset_opts_1
    push dword ptr [ebp-48]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lreset_opts_2:
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lreset_opts_0
.Lreset_opts_1:
    push dword ptr [ebp-48]
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 96
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lreset_opts_3:
    push dword ptr [ebp-56]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lreset_opts_4
    push dword ptr [ebp-48]
    push 104
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lreset_opts_5:
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lreset_opts_3
.Lreset_opts_4:
    push dword ptr [ebp-48]
    push 232
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 236
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 240
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 244
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 248
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 252
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 256
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 260
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 264
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
    push 268
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lreset_opts_6:
    push dword ptr [ebp-56]
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lreset_opts_7
    push dword ptr [ebp-48]
    push 272
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lreset_opts_8:
    push dword ptr [ebp-56]
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    add esp, 4
    jmp .Lreset_opts_6
.Lreset_opts_7:
    push dword ptr [ebp-48]
    push 528
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl main
main:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 892
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-616], eax
    lea eax, [ebp-64]
    push eax
    pop eax
    mov [ebp-656], eax
    mov [ebp-640], esp
    push dword ptr [ebp-656]
    and esp, -16
    call reset_opts
    mov esp, [ebp-640]
    push dword ptr [ebp-48]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_0
    mov [ebp-640], esp
    and esp, -16
    call usage
    mov esp, [ebp-640]
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmain_1
.Lmain_0:
.Lmain_1:
    mov [ebp-640], esp
    and esp, -16
    call config_init
    mov esp, [ebp-640]
    push eax
    push 1
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    add esp, 4
.Lmain_2:
    push dword ptr [ebp-600]
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_3
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-624], eax
    lea eax, [ark_str_3]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_7
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_8
.Lmain_7:
    push 0
.Lmain_8:
    pop eax
    test eax, eax
    jz .Lmain_5
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-656], eax
    mov [ebp-640], esp
    push dword ptr [ebp-656]
    and esp, -16
    call config_load_file
    mov esp, [ebp-640]
    push eax
    push 1
    pop eax
    mov [ebp-616], eax
    push dword ptr [ebp-616]
    add esp, 4
    jmp .Lmain_3
    jmp .Lmain_6
.Lmain_5:
.Lmain_6:
.Lmain_4:
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_2
.Lmain_3:
    push dword ptr [ebp-616]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_11
    lea eax, [ark_str_4]
    push eax
    pop eax
    mov [ebp-656], eax
    mov [ebp-640], esp
    push dword ptr [ebp-656]
    and esp, -16
    call file_exists
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_12
.Lmain_11:
    push 0
.Lmain_12:
    pop eax
    test eax, eax
    jz .Lmain_9
    lea eax, [ark_str_5]
    push eax
    pop eax
    mov [ebp-656], eax
    mov [ebp-640], esp
    push dword ptr [ebp-656]
    and esp, -16
    call config_load_file
    mov esp, [ebp-640]
    push eax
    jmp .Lmain_10
.Lmain_9:
.Lmain_10:
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call config_apply_args
    mov esp, [ebp-640]
    push eax
    push 1
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    add esp, 4
.Lmain_13:
    push dword ptr [ebp-600]
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_14
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-624], eax
    lea eax, [ark_str_6]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_16
    lea eax, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_17
.Lmain_16:
    lea eax, [ark_str_7]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_18
    lea eax, [ebp-64]
    push eax
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_19
.Lmain_18:
    lea eax, [ark_str_8]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_20
    lea eax, [ebp-64]
    push eax
    push 96
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_21
.Lmain_20:
    lea eax, [ark_str_9]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_22
    lea eax, [ebp-64]
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_23
.Lmain_22:
    lea eax, [ark_str_10]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_24
    lea eax, [ebp-64]
    push eax
    push 240
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_25
.Lmain_24:
    push 2
    lea eax, [ark_str_11]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    pop eax
    mov [ebp-664], eax
    mov [ebp-640], esp
    push dword ptr [ebp-664]
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strncmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_26
    lea eax, [ebp-64]
    push eax
    push 236
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-624]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_30
    push dword ptr [ebp-624]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_31
.Lmain_30:
    push 0
.Lmain_31:
    pop eax
    test eax, eax
    jz .Lmain_28
    push dword ptr [ebp-624]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 48
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    jmp .Lmain_29
.Lmain_28:
    push 0
.Lmain_29:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_27
.Lmain_26:
    lea eax, [ark_str_12]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_32
    lea eax, [ebp-64]
    push eax
    push 244
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_33
.Lmain_32:
    push 2
    lea eax, [ark_str_13]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    pop eax
    mov [ebp-664], eax
    mov [ebp-640], esp
    push dword ptr [ebp-664]
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strncmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_34
    jmp .Lmain_35
.Lmain_34:
    lea eax, [ark_str_14]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_38
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_39
.Lmain_38:
    push 0
.Lmain_39:
    pop eax
    test eax, eax
    jz .Lmain_36
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_37
.Lmain_36:
    push dword ptr [ebp-624]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_42
    push dword ptr [ebp-624]
    push 1
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_43
.Lmain_42:
    push 0
.Lmain_43:
    pop eax
    test eax, eax
    jz .Lmain_40
    jmp .Lmain_41
.Lmain_40:
    lea eax, [ark_str_15]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_86
    lea eax, [ark_str_16]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_87
.Lmain_86:
    push 1
.Lmain_87:
    pop eax
    test eax, eax
    jnz .Lmain_84
    lea eax, [ark_str_17]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_85
.Lmain_84:
    push 1
.Lmain_85:
    pop eax
    test eax, eax
    jnz .Lmain_82
    lea eax, [ark_str_18]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_83
.Lmain_82:
    push 1
.Lmain_83:
    pop eax
    test eax, eax
    jnz .Lmain_80
    lea eax, [ark_str_19]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_81
.Lmain_80:
    push 1
.Lmain_81:
    pop eax
    test eax, eax
    jnz .Lmain_78
    lea eax, [ark_str_20]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_79
.Lmain_78:
    push 1
.Lmain_79:
    pop eax
    test eax, eax
    jnz .Lmain_76
    lea eax, [ark_str_21]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_77
.Lmain_76:
    push 1
.Lmain_77:
    pop eax
    test eax, eax
    jnz .Lmain_74
    lea eax, [ark_str_22]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_75
.Lmain_74:
    push 1
.Lmain_75:
    pop eax
    test eax, eax
    jnz .Lmain_72
    lea eax, [ark_str_23]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_73
.Lmain_72:
    push 1
.Lmain_73:
    pop eax
    test eax, eax
    jnz .Lmain_70
    lea eax, [ark_str_24]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_71
.Lmain_70:
    push 1
.Lmain_71:
    pop eax
    test eax, eax
    jnz .Lmain_68
    lea eax, [ark_str_25]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_69
.Lmain_68:
    push 1
.Lmain_69:
    pop eax
    test eax, eax
    jnz .Lmain_66
    lea eax, [ark_str_26]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_67
.Lmain_66:
    push 1
.Lmain_67:
    pop eax
    test eax, eax
    jnz .Lmain_64
    lea eax, [ark_str_27]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_65
.Lmain_64:
    push 1
.Lmain_65:
    pop eax
    test eax, eax
    jnz .Lmain_62
    lea eax, [ark_str_28]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_63
.Lmain_62:
    push 1
.Lmain_63:
    pop eax
    test eax, eax
    jnz .Lmain_60
    lea eax, [ark_str_29]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_61
.Lmain_60:
    push 1
.Lmain_61:
    pop eax
    test eax, eax
    jnz .Lmain_58
    lea eax, [ark_str_30]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_59
.Lmain_58:
    push 1
.Lmain_59:
    pop eax
    test eax, eax
    jnz .Lmain_56
    lea eax, [ark_str_31]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_57
.Lmain_56:
    push 1
.Lmain_57:
    pop eax
    test eax, eax
    jnz .Lmain_54
    lea eax, [ark_str_32]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_55
.Lmain_54:
    push 1
.Lmain_55:
    pop eax
    test eax, eax
    jnz .Lmain_52
    lea eax, [ark_str_33]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_53
.Lmain_52:
    push 1
.Lmain_53:
    pop eax
    test eax, eax
    jnz .Lmain_50
    lea eax, [ark_str_34]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_51
.Lmain_50:
    push 1
.Lmain_51:
    pop eax
    test eax, eax
    jnz .Lmain_48
    lea eax, [ark_str_35]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_49
.Lmain_48:
    push 1
.Lmain_49:
    pop eax
    test eax, eax
    jnz .Lmain_46
    lea eax, [ark_str_36]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_47
.Lmain_46:
    push 1
.Lmain_47:
    pop eax
    test eax, eax
    jz .Lmain_44
    jmp .Lmain_45
.Lmain_44:
    lea eax, [ark_str_37]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_90
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_91
.Lmain_90:
    push 0
.Lmain_91:
    pop eax
    test eax, eax
    jz .Lmain_88
    lea eax, [ebp-64]
    push eax
    push 264
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_89
.Lmain_88:
    lea eax, [ark_str_38]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_98
    lea eax, [ark_str_39]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_99
.Lmain_98:
    push 1
.Lmain_99:
    pop eax
    test eax, eax
    jnz .Lmain_96
    lea eax, [ark_str_40]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_97
.Lmain_96:
    push 1
.Lmain_97:
    pop eax
    test eax, eax
    jz .Lmain_94
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_95
.Lmain_94:
    push 0
.Lmain_95:
    pop eax
    test eax, eax
    jz .Lmain_92
    lea eax, [ebp-64]
    push eax
    push 268
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_93
.Lmain_92:
    lea eax, [ark_str_41]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_102
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_103
.Lmain_102:
    push 0
.Lmain_103:
    pop eax
    test eax, eax
    jz .Lmain_100
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_101
.Lmain_100:
    lea eax, [ark_str_42]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_106
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_107
.Lmain_106:
    push 0
.Lmain_107:
    pop eax
    test eax, eax
    jz .Lmain_104
    lea eax, [ebp-64]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_105
.Lmain_104:
    lea eax, [ark_str_43]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_110
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_111
.Lmain_110:
    push 0
.Lmain_111:
    pop eax
    test eax, eax
    jz .Lmain_108
    lea eax, [ebp-64]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_109
.Lmain_108:
    lea eax, [ark_str_44]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_114
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_115
.Lmain_114:
    push 0
.Lmain_115:
    pop eax
    test eax, eax
    jz .Lmain_112
    lea eax, [ebp-64]
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_116
    lea eax, [ebp-64]
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_117
.Lmain_116:
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
.Lmain_117:
    jmp .Lmain_113
.Lmain_112:
    lea eax, [ark_str_45]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_120
    lea eax, [ark_str_46]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_121
.Lmain_120:
    push 1
.Lmain_121:
    pop eax
    test eax, eax
    jz .Lmain_118
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_122
    lea eax, [ebp-64]
    push eax
    push 248
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_123
.Lmain_122:
.Lmain_123:
    jmp .Lmain_119
.Lmain_118:
    lea eax, [ark_str_47]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_126
    lea eax, [ark_str_48]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_127
.Lmain_126:
    push 1
.Lmain_127:
    pop eax
    test eax, eax
    jz .Lmain_124
    lea eax, [ebp-64]
    push eax
    push 252
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_125
.Lmain_124:
    lea eax, [ark_str_49]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_130
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_131
.Lmain_130:
    push 0
.Lmain_131:
    pop eax
    test eax, eax
    jz .Lmain_128
    lea eax, [ebp-64]
    push eax
    push 256
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_129
.Lmain_128:
    lea eax, [ark_str_50]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_134
    lea eax, [ark_str_51]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_135
.Lmain_134:
    push 1
.Lmain_135:
    pop eax
    test eax, eax
    jz .Lmain_132
    lea eax, [ebp-64]
    push eax
    push 260
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_133
.Lmain_132:
    lea eax, [ark_str_52]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_136
    lea eax, [ebp-64]
    push eax
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lmain_138:
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_139
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-632], eax
    push dword ptr [ebp-632]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_140
    jmp .Lmain_139
    jmp .Lmain_141
.Lmain_140:
.Lmain_141:
    lea eax, [ebp-64]
    push eax
    push 232
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_142
    lea eax, [ebp-64]
    push eax
    push 104
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    push 232
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-632]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_143
.Lmain_142:
.Lmain_143:
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_138
.Lmain_139:
    jmp .Lmain_137
.Lmain_136:
    lea eax, [ark_str_53]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_144
    lea eax, [ebp-64]
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_145
.Lmain_144:
    lea eax, [ark_str_54]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lmain_148
    lea eax, [ark_str_55]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_149
.Lmain_148:
    push 1
.Lmain_149:
    pop eax
    test eax, eax
    jz .Lmain_146
    mov [ebp-640], esp
    and esp, -16
    call usage
    mov esp, [ebp-640]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmain_147
.Lmain_146:
    lea eax, [ark_str_56]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    mov [ebp-640], esp
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strcmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_152
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_153
.Lmain_152:
    push 0
.Lmain_153:
    pop eax
    test eax, eax
    jz .Lmain_150
    lea eax, [ebp-64]
    push eax
    push 528
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_154
    lea eax, [ebp-64]
    push eax
    push 272
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    push 528
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    push dword ptr [ebp-600]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_155
.Lmain_154:
.Lmain_155:
    jmp .Lmain_151
.Lmain_150:
    push 2
    lea eax, [ark_str_57]
    push eax
    push dword ptr [ebp-624]
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    pop eax
    mov [ebp-664], eax
    mov [ebp-640], esp
    push dword ptr [ebp-664]
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call strncmp
    mov esp, [ebp-640]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_158
    push dword ptr [ebp-624]
    push 2
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_159
.Lmain_158:
    push 0
.Lmain_159:
    pop eax
    test eax, eax
    jz .Lmain_156
    lea eax, [ebp-64]
    push eax
    push 528
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_160
    lea eax, [ebp-64]
    push eax
    push 272
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-64]
    push eax
    push 528
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    pop ecx
    push eax
    push ecx
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-624]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_161
.Lmain_160:
.Lmain_161:
    jmp .Lmain_157
.Lmain_156:
    push dword ptr [ebp-624]
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 45
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_162
    push dword ptr [ebp-624]
    lea eax, [ark_str_58]
    push eax
    mov eax, [stderr]
    push eax
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    pop eax
    mov [ebp-664], eax
    mov [ebp-640], esp
    push dword ptr [ebp-664]
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call fprintf
    mov esp, [ebp-640]
    push eax
    add esp, 4
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmain_163
.Lmain_162:
    lea eax, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-624]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
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
    push dword ptr [ebp-600]
    push dword ptr [ebp-600]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-600], eax
    add esp, 4
    jmp .Lmain_13
.Lmain_14:
    lea eax, [ebp-64]
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lmain_164
    mov [ebp-640], esp
    and esp, -16
    call config_print
    mov esp, [ebp-640]
    push eax
    jmp .Lmain_165
.Lmain_164:
.Lmain_165:
    lea eax, [ebp-64]
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_170
    lea eax, [ebp-64]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_171
.Lmain_170:
    push 0
.Lmain_171:
    pop eax
    test eax, eax
    jz .Lmain_168
    lea eax, [ebp-64]
    push eax
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lmain_169
.Lmain_168:
    push 0
.Lmain_169:
    pop eax
    test eax, eax
    jz .Lmain_166
    mov [ebp-640], esp
    and esp, -16
    call usage
    mov esp, [ebp-640]
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmain_167
.Lmain_166:
.Lmain_167:
    lea eax, [g_config]
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lmain_172
    lea eax, [ebp-64]
    push eax
    push 264
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [g_config]
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lmain_173
.Lmain_172:
.Lmain_173:
    lea eax, [ebp-64]
    push eax
    pop eax
    mov [ebp-656], eax
    mov [ebp-640], esp
    push dword ptr [ebp-656]
    and esp, -16
    call ark_compile
    mov esp, [ebp-640]
    push eax
    pop eax
    mov [ebp-608], eax
    push dword ptr [ebp-608]
    add esp, 4
    push dword ptr [ebp-608]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lmain_174
    push dword ptr [ebp-608]
    lea eax, [ark_str_59]
    push eax
    mov eax, [stderr]
    push eax
    pop eax
    mov [ebp-656], eax
    pop eax
    mov [ebp-660], eax
    pop eax
    mov [ebp-664], eax
    mov [ebp-640], esp
    push dword ptr [ebp-664]
    push dword ptr [ebp-660]
    push dword ptr [ebp-656]
    and esp, -16
    call fprintf
    mov esp, [ebp-640]
    push eax
    add esp, 4
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lmain_175
.Lmain_174:
.Lmain_175:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

