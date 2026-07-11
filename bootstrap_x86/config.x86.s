# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "features"
ark_str_1:
    .asciz "vla"
ark_str_2:
    .asciz "complex"
ark_str_3:
    .asciz "wchar"
ark_str_4:
    .asciz "trigraph"
ark_str_5:
    .asciz "fpu_hw"
ark_str_6:
    .asciz "dwarf"
ark_str_7:
    .asciz "opt_constfold"
ark_str_8:
    .asciz "opt_dce"
ark_str_9:
    .asciz "opt_regalloc"
ark_str_10:
    .asciz "opt_inline"
ark_str_11:
    .asciz "opt_vectorize"
ark_str_12:
    .asciz "general"
ark_str_13:
    .asciz "opt_level"
ark_str_14:
    .asciz "debug_info"
ark_str_15:
    .asciz "split_sections"
ark_str_16:
    .asciz "function-sections"
ark_str_17:
    .asciz ""
ark_str_18:
    .asciz "[config] cannot open config file '%s' (ignored)\n"
ark_str_19:
    .asciz "-g"
ark_str_20:
    .asciz "-config"
ark_str_21:
    .asciz "--cpp"
ark_str_22:
    .asciz "[arkcc] error: C++ (--cpp) is not supported\n"
ark_str_23:
    .asciz "--enum_is_int"
ark_str_24:
    .asciz "-fenum-is-int"
ark_str_25:
    .asciz "--dollar"
ark_str_26:
    .asciz "--signed_chars"
ark_str_27:
    .asciz "--unsigned_chars"
ark_str_28:
    .asciz "--wchar16"
ark_str_29:
    .asciz "--wchar32"
ark_str_30:
    .asciz "--dwarf2"
ark_str_31:
    .asciz "--dwarf3"
ark_str_32:
    .asciz "--scatter"
ark_str_33:
    .asciz "--fpu"
ark_str_34:
    .asciz "none"
ark_str_35:
    .asciz "--thumb"
ark_str_36:
    .asciz "--arm"
ark_str_37:
    .asciz "--remarks"
ark_str_38:
    .asciz "--library_type"
ark_str_39:
    .asciz "--locale"
ark_str_40:
    .asciz "--multibyte_chars"
ark_str_41:
    .asciz "--data_reorder"
ark_str_42:
    .asciz "--diag_style"
ark_str_43:
    .asciz "--remove_unneeded_entities"
ark_str_44:
    .asciz "--autoinline"
ark_str_45:
    .asciz "--no_autoinline"
ark_str_46:
    .asciz "--vectorize"
ark_str_47:
    .asciz "--no_vectorize"
ark_str_48:
    .asciz "vla"
ark_str_49:
    .asciz "complex"
ark_str_50:
    .asciz "wchar"
ark_str_51:
    .asciz "trigraph"
ark_str_52:
    .asciz "fpu"
ark_str_53:
    .asciz "fpu_hw"
ark_str_54:
    .asciz "fpu-hw"
ark_str_55:
    .asciz "dwarf"
ark_str_56:
    .asciz "opt-constfold"
ark_str_57:
    .asciz "constfold"
ark_str_58:
    .asciz "opt-dce"
ark_str_59:
    .asciz "dce"
ark_str_60:
    .asciz "opt-regalloc"
ark_str_61:
    .asciz "regalloc"
ark_str_62:
    .asciz "opt-inline"
ark_str_63:
    .asciz "autoinline"
ark_str_64:
    .asciz "opt-vectorize"
ark_str_65:
    .asciz "vectorize"
ark_str_66:
    .asciz "function-sections"
ark_str_67:
    .asciz "split_sections"
ark_str_68:
    .asciz "enum-is-int"
ark_str_69:
    .asciz "dollar"
ark_str_70:
    .asciz "[arkcc] config:\n"
ark_str_71:
    .asciz "  vla=%d complex=%d wchar=%d trigraph=%d\n"
ark_str_72:
    .asciz "  fpu_hw=%d dwarf=%d\n"
ark_str_73:
    .asciz "  opt_constfold=%d opt_dce=%d opt_regalloc=%d\n"
ark_str_74:
    .asciz "  opt_inline=%d opt_vectorize=%d\n"
ark_str_75:
    .asciz "  opt_level=%d debug_info=%d split_sections=%d\n"
ark_str_76:
    .asciz "(none)"
ark_str_77:
    .asciz "  config_file=%s\n"
    .data
    .globl g_config
g_config:
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .globl ark_sl_config_load_file_cfg_buf
    .local ark_sl_config_load_file_cfg_buf
ark_sl_config_load_file_cfg_buf:
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .quad 0
    .text
    .globl parse_bool
parse_bool:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jmp .Lparse_bool_3
.Lparse_bool_2:
    push 1
.Lparse_bool_3:
    pop eax
    test eax, eax
    jz .Lparse_bool_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_1
.Lparse_bool_0:
.Lparse_bool_1:
    push dword ptr [ebp-48]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bool_6
    push dword ptr [ebp-48]
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
    jmp .Lparse_bool_7
.Lparse_bool_6:
    push 0
.Lparse_bool_7:
    pop eax
    test eax, eax
    jz .Lparse_bool_4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_5
.Lparse_bool_4:
.Lparse_bool_5:
    push dword ptr [ebp-48]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bool_10
    push dword ptr [ebp-48]
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
    jmp .Lparse_bool_11
.Lparse_bool_10:
    push 0
.Lparse_bool_11:
    pop eax
    test eax, eax
    jz .Lparse_bool_8
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_9
.Lparse_bool_8:
.Lparse_bool_9:
    push dword ptr [ebp-48]
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
    push 116
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_22
    push dword ptr [ebp-48]
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
    push 84
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
    jmp .Lparse_bool_23
.Lparse_bool_22:
    push 1
.Lparse_bool_23:
    pop eax
    test eax, eax
    jz .Lparse_bool_20
    push dword ptr [ebp-48]
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
    push 114
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_24
    push dword ptr [ebp-48]
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
    push 82
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
    jmp .Lparse_bool_25
.Lparse_bool_24:
    push 1
.Lparse_bool_25:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_21
.Lparse_bool_20:
    push 0
.Lparse_bool_21:
    pop eax
    test eax, eax
    jz .Lparse_bool_18
    push dword ptr [ebp-48]
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
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_26
    push dword ptr [ebp-48]
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
    push 85
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
    jmp .Lparse_bool_27
.Lparse_bool_26:
    push 1
.Lparse_bool_27:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_19
.Lparse_bool_18:
    push 0
.Lparse_bool_19:
    pop eax
    test eax, eax
    jz .Lparse_bool_16
    push dword ptr [ebp-48]
    push 3
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
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_28
    push dword ptr [ebp-48]
    push 3
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
    push 69
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
    jmp .Lparse_bool_29
.Lparse_bool_28:
    push 1
.Lparse_bool_29:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_17
.Lparse_bool_16:
    push 0
.Lparse_bool_17:
    pop eax
    test eax, eax
    jz .Lparse_bool_14
    push dword ptr [ebp-48]
    push 4
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
    jmp .Lparse_bool_15
.Lparse_bool_14:
    push 0
.Lparse_bool_15:
    pop eax
    test eax, eax
    jz .Lparse_bool_12
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_13
.Lparse_bool_12:
.Lparse_bool_13:
    push dword ptr [ebp-48]
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
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_42
    push dword ptr [ebp-48]
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
    push 70
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
    jmp .Lparse_bool_43
.Lparse_bool_42:
    push 1
.Lparse_bool_43:
    pop eax
    test eax, eax
    jz .Lparse_bool_40
    push dword ptr [ebp-48]
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
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_44
    push dword ptr [ebp-48]
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
    push 65
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
    jmp .Lparse_bool_45
.Lparse_bool_44:
    push 1
.Lparse_bool_45:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_41
.Lparse_bool_40:
    push 0
.Lparse_bool_41:
    pop eax
    test eax, eax
    jz .Lparse_bool_38
    push dword ptr [ebp-48]
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
    push 108
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_46
    push dword ptr [ebp-48]
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
    push 76
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
    jmp .Lparse_bool_47
.Lparse_bool_46:
    push 1
.Lparse_bool_47:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_39
.Lparse_bool_38:
    push 0
.Lparse_bool_39:
    pop eax
    test eax, eax
    jz .Lparse_bool_36
    push dword ptr [ebp-48]
    push 3
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
    push 115
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_48
    push dword ptr [ebp-48]
    push 3
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
    push 83
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
    jmp .Lparse_bool_49
.Lparse_bool_48:
    push 1
.Lparse_bool_49:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_37
.Lparse_bool_36:
    push 0
.Lparse_bool_37:
    pop eax
    test eax, eax
    jz .Lparse_bool_34
    push dword ptr [ebp-48]
    push 4
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
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_bool_50
    push dword ptr [ebp-48]
    push 4
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
    push 69
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
    jmp .Lparse_bool_51
.Lparse_bool_50:
    push 1
.Lparse_bool_51:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_bool_35
.Lparse_bool_34:
    push 0
.Lparse_bool_35:
    pop eax
    test eax, eax
    jz .Lparse_bool_32
    push dword ptr [ebp-48]
    push 5
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
    jmp .Lparse_bool_33
.Lparse_bool_32:
    push 0
.Lparse_bool_33:
    pop eax
    test eax, eax
    jz .Lparse_bool_30
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_31
.Lparse_bool_30:
.Lparse_bool_31:
    push dword ptr [ebp-48]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bool_54
    push dword ptr [ebp-48]
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
    jmp .Lparse_bool_55
.Lparse_bool_54:
    push 0
.Lparse_bool_55:
    pop eax
    test eax, eax
    jz .Lparse_bool_52
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_bool_53
.Lparse_bool_52:
.Lparse_bool_53:
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

    .globl parse_int
parse_int:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 1
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_int_2
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jmp .Lparse_int_3
.Lparse_int_2:
    push 1
.Lparse_int_3:
    pop eax
    test eax, eax
    jz .Lparse_int_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_int_1
.Lparse_int_0:
.Lparse_int_1:
    push dword ptr [ebp-48]
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
    jz .Lparse_int_4
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_int_5
.Lparse_int_4:
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 43
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_int_6
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    jmp .Lparse_int_7
.Lparse_int_6:
.Lparse_int_7:
.Lparse_int_5:
.Lparse_int_8:
    push dword ptr [ebp-48]
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
    jz .Lparse_int_10
    push dword ptr [ebp-48]
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
    jmp .Lparse_int_11
.Lparse_int_10:
    push 0
.Lparse_int_11:
    pop eax
    test eax, eax
    jz .Lparse_int_9
    push dword ptr [ebp-72]
    push 10
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-48]
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
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
    push dword ptr [ebp-48]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-48], eax
    add esp, 4
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lparse_int_8
.Lparse_int_9:
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_int_12
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_int_13
.Lparse_int_12:
.Lparse_int_13:
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
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

    .globl config_init
config_init:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [g_config]
    push eax
    push 0
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
    lea eax, [g_config]
    push eax
    push 4
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
    lea eax, [g_config]
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
    lea eax, [g_config]
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
    lea eax, [g_config]
    push eax
    push 16
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
    lea eax, [g_config]
    push eax
    push 20
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
    lea eax, [g_config]
    push eax
    push 24
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
    lea eax, [g_config]
    push eax
    push 28
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
    lea eax, [g_config]
    push eax
    push 32
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
    lea eax, [g_config]
    push eax
    push 36
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
    lea eax, [g_config]
    push eax
    push 40
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
    lea eax, [g_config]
    push eax
    push 44
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
    lea eax, [g_config]
    push eax
    push 48
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
    lea eax, [g_config]
    push eax
    push 52
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
    lea eax, [g_config]
    push eax
    push 56
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
    lea eax, [g_config]
    push eax
    push 60
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
    lea eax, [g_config]
    push eax
    push 64
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
    lea eax, [g_config]
    push eax
    push 68
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
    lea eax, [g_config]
    push eax
    push 72
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
    lea eax, [g_config]
    push eax
    push 76
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
    lea eax, [g_config]
    push eax
    push 80
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
    lea eax, [g_config]
    push eax
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
    lea eax, [g_config]
    push eax
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
    lea eax, [g_config]
    push eax
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

    .globl apply_kv
apply_kv:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lapply_kv_2
    push dword ptr [ebp-64]
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
    jmp .Lapply_kv_3
.Lapply_kv_2:
    push 1
.Lapply_kv_3:
    pop eax
    test eax, eax
    jz .Lapply_kv_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lapply_kv_1
.Lapply_kv_0:
.Lapply_kv_1:
    lea eax, [ark_str_0]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_4
    lea eax, [ark_str_1]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_6
    lea eax, [g_config]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_7
.Lapply_kv_6:
    lea eax, [ark_str_2]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_8
    lea eax, [g_config]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_9
.Lapply_kv_8:
    lea eax, [ark_str_3]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_10
    lea eax, [g_config]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_11
.Lapply_kv_10:
    lea eax, [ark_str_4]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_12
    lea eax, [g_config]
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_13
.Lapply_kv_12:
    lea eax, [ark_str_5]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_14
    lea eax, [g_config]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_15
.Lapply_kv_14:
    lea eax, [ark_str_6]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_16
    lea eax, [g_config]
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_17
.Lapply_kv_16:
    lea eax, [ark_str_7]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_18
    lea eax, [g_config]
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_19
.Lapply_kv_18:
    lea eax, [ark_str_8]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_20
    lea eax, [g_config]
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_21
.Lapply_kv_20:
    lea eax, [ark_str_9]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_22
    lea eax, [g_config]
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_23
.Lapply_kv_22:
    lea eax, [ark_str_10]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_24
    lea eax, [g_config]
    push eax
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_25
.Lapply_kv_24:
    lea eax, [ark_str_11]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_26
    lea eax, [g_config]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_27
.Lapply_kv_26:
.Lapply_kv_27:
.Lapply_kv_25:
.Lapply_kv_23:
.Lapply_kv_21:
.Lapply_kv_19:
.Lapply_kv_17:
.Lapply_kv_15:
.Lapply_kv_13:
.Lapply_kv_11:
.Lapply_kv_9:
.Lapply_kv_7:
    jmp .Lapply_kv_5
.Lapply_kv_4:
    lea eax, [ark_str_12]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_28
    lea eax, [ark_str_13]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_30
    push 0
    pop eax
    mov [ebp-72], eax
    lea eax, [ebp-72]
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call parse_int
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_32
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_34
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lapply_kv_35
.Lapply_kv_34:
.Lapply_kv_35:
    push dword ptr [ebp-72]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_36
    push 2
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lapply_kv_37
.Lapply_kv_36:
.Lapply_kv_37:
    lea eax, [g_config]
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_33
.Lapply_kv_32:
.Lapply_kv_33:
    jmp .Lapply_kv_31
.Lapply_kv_30:
    lea eax, [ark_str_14]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_38
    lea eax, [g_config]
    push eax
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_40
    push 1
    jmp .Lapply_kv_41
.Lapply_kv_40:
    push 0
.Lapply_kv_41:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_39
.Lapply_kv_38:
    lea eax, [ark_str_15]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jnz .Lapply_kv_44
    lea eax, [ark_str_16]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call ark_streq
    mov esp, [ebp-80]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lapply_kv_45
.Lapply_kv_44:
    push 1
.Lapply_kv_45:
    pop eax
    test eax, eax
    jz .Lapply_kv_42
    lea eax, [g_config]
    push eax
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_bool
    mov esp, [ebp-80]
    push eax
    pop eax
    test eax, eax
    jz .Lapply_kv_46
    push 1
    jmp .Lapply_kv_47
.Lapply_kv_46:
    push 0
.Lapply_kv_47:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lapply_kv_43
.Lapply_kv_42:
.Lapply_kv_43:
.Lapply_kv_39:
.Lapply_kv_31:
    jmp .Lapply_kv_29
.Lapply_kv_28:
.Lapply_kv_29:
.Lapply_kv_5:
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

    .globl config_load_file
config_load_file:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 460
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-60], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-68], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-76], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-84], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-92], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-100], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-108], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-116], eax
    push 1
    lea eax, [ark_str_17]
    push eax
    lea eax, [ebp-56]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    mov [ebp-208], esp
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call memcpy
    mov esp, [ebp-208]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lconfig_load_file_1
.Lconfig_load_file_0:
.Lconfig_load_file_1:
    push 4096
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    mov [ebp-208], esp
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call fs_read_file
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-120]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_2
    push dword ptr [ebp-48]
    lea eax, [ark_str_18]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call ark_log
    mov esp, [ebp-208]
    push eax
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lconfig_load_file_3
.Lconfig_load_file_2:
.Lconfig_load_file_3:
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-120]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [g_config]
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lconfig_load_file_4:
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_5
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_9
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
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
    push 10
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
    jmp .Lconfig_load_file_10
.Lconfig_load_file_9:
    push 1
.Lconfig_load_file_10:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_7
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_11
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lconfig_load_file_12
.Lconfig_load_file_11:
.Lconfig_load_file_12:
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
.Lconfig_load_file_13:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_15
    push dword ptr [ebp-144]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    push 13
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
    jmp .Lconfig_load_file_16
.Lconfig_load_file_15:
    push 0
.Lconfig_load_file_16:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_14
    push dword ptr [ebp-144]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lconfig_load_file_13
.Lconfig_load_file_14:
.Lconfig_load_file_17:
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_19
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 9
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
    jmp .Lconfig_load_file_20
.Lconfig_load_file_19:
    push 1
.Lconfig_load_file_20:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_18
    push dword ptr [ebp-144]
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-144], eax
    add esp, 4
    jmp .Lconfig_load_file_17
.Lconfig_load_file_18:
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
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
    jnz .Lconfig_load_file_25
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 59
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
    jmp .Lconfig_load_file_26
.Lconfig_load_file_25:
    push 1
.Lconfig_load_file_26:
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_23
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 35
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
    jmp .Lconfig_load_file_24
.Lconfig_load_file_23:
    push 1
.Lconfig_load_file_24:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_21
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lconfig_load_file_6
    jmp .Lconfig_load_file_22
.Lconfig_load_file_21:
.Lconfig_load_file_22:
    push dword ptr [ebp-144]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_27
    push dword ptr [ebp-144]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    pop eax
    mov [ebp-192], eax
.Lconfig_load_file_29:
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_31
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 93
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
    jmp .Lconfig_load_file_32
.Lconfig_load_file_31:
    push 0
.Lconfig_load_file_32:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_30
    push dword ptr [ebp-192]
    push dword ptr [ebp-192]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    add esp, 4
    jmp .Lconfig_load_file_29
.Lconfig_load_file_30:
    push dword ptr [ebp-192]
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-200], eax
.Lconfig_load_file_33:
    push dword ptr [ebp-184]
    push dword ptr [ebp-200]
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
    pop eax
    test eax, eax
    jz .Lconfig_load_file_35
    push dword ptr [ebp-200]
    push 64
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
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
    jmp .Lconfig_load_file_36
.Lconfig_load_file_35:
    push 0
.Lconfig_load_file_36:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_34
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-184]
    push dword ptr [ebp-200]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-200]
    push dword ptr [ebp-200]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-200], eax
    add esp, 4
    jmp .Lconfig_load_file_33
.Lconfig_load_file_34:
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-200]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lconfig_load_file_6
    jmp .Lconfig_load_file_28
.Lconfig_load_file_27:
.Lconfig_load_file_28:
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
.Lconfig_load_file_37:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_39
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
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
    jmp .Lconfig_load_file_40
.Lconfig_load_file_39:
    push 0
.Lconfig_load_file_40:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_38
    push dword ptr [ebp-168]
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-168], eax
    add esp, 4
    jmp .Lconfig_load_file_37
.Lconfig_load_file_38:
    push dword ptr [ebp-168]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_41
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lconfig_load_file_6
    jmp .Lconfig_load_file_42
.Lconfig_load_file_41:
.Lconfig_load_file_42:
    push dword ptr [ebp-168]
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
.Lconfig_load_file_43:
    push dword ptr [ebp-176]
    push dword ptr [ebp-144]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_45
    push dword ptr [ebp-176]
    push 1
    pop eax
    neg eax
    push eax
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
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_47
    push dword ptr [ebp-176]
    push 1
    pop eax
    neg eax
    push eax
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
    push 9
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
    jmp .Lconfig_load_file_48
.Lconfig_load_file_47:
    push 1
.Lconfig_load_file_48:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_load_file_46
.Lconfig_load_file_45:
    push 0
.Lconfig_load_file_46:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_44
    push dword ptr [ebp-176]
    push dword ptr [ebp-176]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-176], eax
    add esp, 4
    push dword ptr [ebp-176]
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lconfig_load_file_43
.Lconfig_load_file_44:
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push dword ptr [ebp-168]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
.Lconfig_load_file_49:
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_51
    push dword ptr [ebp-160]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 9
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
    jmp .Lconfig_load_file_52
.Lconfig_load_file_51:
    push 1
.Lconfig_load_file_52:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_50
    push dword ptr [ebp-160]
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    add esp, 4
    jmp .Lconfig_load_file_49
.Lconfig_load_file_50:
    push dword ptr [ebp-160]
    pop eax
    mov [ebp-184], eax
.Lconfig_load_file_53:
    push dword ptr [ebp-184]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_54
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lconfig_load_file_53
.Lconfig_load_file_54:
.Lconfig_load_file_55:
    push dword ptr [ebp-184]
    push dword ptr [ebp-160]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_load_file_57
    push dword ptr [ebp-184]
    push 1
    pop eax
    neg eax
    push eax
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
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_load_file_59
    push dword ptr [ebp-184]
    push 1
    pop eax
    neg eax
    push eax
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
    push 9
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
    jmp .Lconfig_load_file_60
.Lconfig_load_file_59:
    push 1
.Lconfig_load_file_60:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_load_file_58
.Lconfig_load_file_57:
    push 0
.Lconfig_load_file_58:
    pop eax
    test eax, eax
    jz .Lconfig_load_file_56
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    push dword ptr [ebp-184]
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lconfig_load_file_55
.Lconfig_load_file_56:
    push dword ptr [ebp-160]
    push dword ptr [ebp-152]
    lea eax, [ebp-56]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    mov [ebp-208], esp
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call apply_kv
    mov esp, [ebp-208]
    lea eax, [ark_sl_config_load_file_cfg_buf]
    push eax
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lconfig_load_file_8
.Lconfig_load_file_7:
.Lconfig_load_file_8:
.Lconfig_load_file_6:
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    add esp, 4
    jmp .Lconfig_load_file_4
.Lconfig_load_file_5:
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

    .globl config_apply_args
config_apply_args:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lconfig_apply_args_1
.Lconfig_apply_args_0:
.Lconfig_apply_args_1:
    push 1
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lconfig_apply_args_2:
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_3
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
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
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_7
    push dword ptr [ebp-72]
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
    jmp .Lconfig_apply_args_8
.Lconfig_apply_args_7:
    push 1
.Lconfig_apply_args_8:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_5
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_6
.Lconfig_apply_args_5:
.Lconfig_apply_args_6:
    push dword ptr [ebp-72]
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
    jz .Lconfig_apply_args_17
    push dword ptr [ebp-72]
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
    push 79
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
    jmp .Lconfig_apply_args_18
.Lconfig_apply_args_17:
    push 0
.Lconfig_apply_args_18:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_15
    push dword ptr [ebp-72]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_16
.Lconfig_apply_args_15:
    push 0
.Lconfig_apply_args_16:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_13
    push dword ptr [ebp-72]
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
    jmp .Lconfig_apply_args_14
.Lconfig_apply_args_13:
    push 0
.Lconfig_apply_args_14:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_11
    push dword ptr [ebp-72]
    push 3
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
    jmp .Lconfig_apply_args_12
.Lconfig_apply_args_11:
    push 0
.Lconfig_apply_args_12:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_9
    lea eax, [g_config]
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [g_config]
    push eax
    push 44
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
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_19
    lea eax, [g_config]
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 2
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_20
.Lconfig_apply_args_19:
.Lconfig_apply_args_20:
    lea eax, [g_config]
    push eax
    push 44
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
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_21
    lea eax, [g_config]
    push eax
    push 36
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
    lea eax, [g_config]
    push eax
    push 40
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
    jmp .Lconfig_apply_args_22
.Lconfig_apply_args_21:
.Lconfig_apply_args_22:
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_10
.Lconfig_apply_args_9:
.Lconfig_apply_args_10:
    lea eax, [ark_str_19]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_23
    lea eax, [g_config]
    push eax
    push 48
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_24
.Lconfig_apply_args_23:
.Lconfig_apply_args_24:
    lea eax, [ark_str_20]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_27
    push dword ptr [ebp-64]
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
    jmp .Lconfig_apply_args_28
.Lconfig_apply_args_27:
    push 0
.Lconfig_apply_args_28:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_25
    lea eax, [g_config]
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
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
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_26
.Lconfig_apply_args_25:
.Lconfig_apply_args_26:
    lea eax, [ark_str_21]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_29
    lea eax, [ark_str_22]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call ark_log
    mov esp, [ebp-96]
    push eax
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_30
.Lconfig_apply_args_29:
.Lconfig_apply_args_30:
    lea eax, [ark_str_23]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_33
    lea eax, [ark_str_24]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_34
.Lconfig_apply_args_33:
    push 1
.Lconfig_apply_args_34:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_31
    lea eax, [g_config]
    push eax
    push 60
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_32
.Lconfig_apply_args_31:
.Lconfig_apply_args_32:
    lea eax, [ark_str_25]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_35
    lea eax, [g_config]
    push eax
    push 64
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_36
.Lconfig_apply_args_35:
.Lconfig_apply_args_36:
    lea eax, [ark_str_26]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_37
    lea eax, [g_config]
    push eax
    push 68
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
    lea eax, [g_config]
    push eax
    push 72
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_38
.Lconfig_apply_args_37:
.Lconfig_apply_args_38:
    lea eax, [ark_str_27]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_39
    lea eax, [g_config]
    push eax
    push 72
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
    lea eax, [g_config]
    push eax
    push 68
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_40
.Lconfig_apply_args_39:
.Lconfig_apply_args_40:
    lea eax, [ark_str_28]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_41
    lea eax, [g_config]
    push eax
    push 76
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
    lea eax, [g_config]
    push eax
    push 80
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_42
.Lconfig_apply_args_41:
.Lconfig_apply_args_42:
    lea eax, [ark_str_29]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_43
    lea eax, [g_config]
    push eax
    push 80
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
    lea eax, [g_config]
    push eax
    push 76
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_44
.Lconfig_apply_args_43:
.Lconfig_apply_args_44:
    lea eax, [ark_str_30]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_45
    lea eax, [g_config]
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 2
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_46
.Lconfig_apply_args_45:
.Lconfig_apply_args_46:
    lea eax, [ark_str_31]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_47
    lea eax, [g_config]
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 3
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_48
.Lconfig_apply_args_47:
.Lconfig_apply_args_48:
    lea eax, [ark_str_32]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_51
    push dword ptr [ebp-64]
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
    jmp .Lconfig_apply_args_52
.Lconfig_apply_args_51:
    push 0
.Lconfig_apply_args_52:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_49
    lea eax, [g_config]
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
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
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_50
.Lconfig_apply_args_49:
.Lconfig_apply_args_50:
    lea eax, [ark_str_33]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_55
    push dword ptr [ebp-64]
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
    jmp .Lconfig_apply_args_56
.Lconfig_apply_args_55:
    push 0
.Lconfig_apply_args_56:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_53
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
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
    mov [ebp-80], eax
    lea eax, [g_config]
    push eax
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    lea eax, [ark_str_34]
    push eax
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_57
    lea eax, [g_config]
    push eax
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
    jmp .Lconfig_apply_args_58
.Lconfig_apply_args_57:
    lea eax, [g_config]
    push eax
    push 16
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
.Lconfig_apply_args_58:
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_54
.Lconfig_apply_args_53:
.Lconfig_apply_args_54:
    lea eax, [ark_str_35]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_75
    lea eax, [ark_str_36]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_76
.Lconfig_apply_args_75:
    push 1
.Lconfig_apply_args_76:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_73
    lea eax, [ark_str_37]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_74
.Lconfig_apply_args_73:
    push 1
.Lconfig_apply_args_74:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_71
    lea eax, [ark_str_38]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_72
.Lconfig_apply_args_71:
    push 1
.Lconfig_apply_args_72:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_69
    lea eax, [ark_str_39]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_70
.Lconfig_apply_args_69:
    push 1
.Lconfig_apply_args_70:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_67
    lea eax, [ark_str_40]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_68
.Lconfig_apply_args_67:
    push 1
.Lconfig_apply_args_68:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_65
    lea eax, [ark_str_41]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_66
.Lconfig_apply_args_65:
    push 1
.Lconfig_apply_args_66:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_63
    lea eax, [ark_str_42]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_64
.Lconfig_apply_args_63:
    push 1
.Lconfig_apply_args_64:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_61
    lea eax, [ark_str_43]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_62
.Lconfig_apply_args_61:
    push 1
.Lconfig_apply_args_62:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_59
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_60
.Lconfig_apply_args_59:
.Lconfig_apply_args_60:
    lea eax, [ark_str_44]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_77
    lea eax, [g_config]
    push eax
    push 36
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_78
.Lconfig_apply_args_77:
.Lconfig_apply_args_78:
    lea eax, [ark_str_45]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_79
    lea eax, [g_config]
    push eax
    push 36
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_80
.Lconfig_apply_args_79:
.Lconfig_apply_args_80:
    lea eax, [ark_str_46]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_81
    lea eax, [g_config]
    push eax
    push 40
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_82
.Lconfig_apply_args_81:
.Lconfig_apply_args_82:
    lea eax, [ark_str_47]
    push eax
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_83
    lea eax, [g_config]
    push eax
    push 40
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
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_84
.Lconfig_apply_args_83:
.Lconfig_apply_args_84:
    push dword ptr [ebp-72]
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
    jz .Lconfig_apply_args_87
    push dword ptr [ebp-72]
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
    jmp .Lconfig_apply_args_88
.Lconfig_apply_args_87:
    push 0
.Lconfig_apply_args_88:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_85
    push dword ptr [ebp-72]
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
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_93
    push dword ptr [ebp-72]
    push 3
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
    push 111
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
    jmp .Lconfig_apply_args_94
.Lconfig_apply_args_93:
    push 0
.Lconfig_apply_args_94:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_91
    push dword ptr [ebp-72]
    push 4
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_92
.Lconfig_apply_args_91:
    push 0
.Lconfig_apply_args_92:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_89
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push 5
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lconfig_apply_args_90
.Lconfig_apply_args_89:
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lconfig_apply_args_90:
    push dword ptr [ebp-88]
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_95
    jmp .Lconfig_apply_args_4
    jmp .Lconfig_apply_args_96
.Lconfig_apply_args_95:
.Lconfig_apply_args_96:
    lea eax, [ark_str_48]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_97
    lea eax, [g_config]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_98
.Lconfig_apply_args_97:
    lea eax, [ark_str_49]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_99
    lea eax, [g_config]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_100
.Lconfig_apply_args_99:
    lea eax, [ark_str_50]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_101
    lea eax, [g_config]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_102
.Lconfig_apply_args_101:
    lea eax, [ark_str_51]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_103
    lea eax, [g_config]
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_104
.Lconfig_apply_args_103:
    lea eax, [ark_str_52]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_109
    lea eax, [ark_str_53]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_110
.Lconfig_apply_args_109:
    push 1
.Lconfig_apply_args_110:
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_107
    lea eax, [ark_str_54]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_108
.Lconfig_apply_args_107:
    push 1
.Lconfig_apply_args_108:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_105
    lea eax, [g_config]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_106
.Lconfig_apply_args_105:
    lea eax, [ark_str_55]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_111
    lea eax, [g_config]
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_112
.Lconfig_apply_args_111:
    lea eax, [ark_str_56]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_115
    lea eax, [ark_str_57]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_116
.Lconfig_apply_args_115:
    push 1
.Lconfig_apply_args_116:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_113
    lea eax, [g_config]
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_114
.Lconfig_apply_args_113:
    lea eax, [ark_str_58]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_119
    lea eax, [ark_str_59]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_120
.Lconfig_apply_args_119:
    push 1
.Lconfig_apply_args_120:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_117
    lea eax, [g_config]
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_118
.Lconfig_apply_args_117:
    lea eax, [ark_str_60]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_123
    lea eax, [ark_str_61]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_124
.Lconfig_apply_args_123:
    push 1
.Lconfig_apply_args_124:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_121
    lea eax, [g_config]
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_122
.Lconfig_apply_args_121:
    lea eax, [ark_str_62]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_127
    lea eax, [ark_str_63]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_128
.Lconfig_apply_args_127:
    push 1
.Lconfig_apply_args_128:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_125
    lea eax, [g_config]
    push eax
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_126
.Lconfig_apply_args_125:
    lea eax, [ark_str_64]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_131
    lea eax, [ark_str_65]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_132
.Lconfig_apply_args_131:
    push 1
.Lconfig_apply_args_132:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_129
    lea eax, [g_config]
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_130
.Lconfig_apply_args_129:
    lea eax, [ark_str_66]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jnz .Lconfig_apply_args_135
    lea eax, [ark_str_67]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lconfig_apply_args_136
.Lconfig_apply_args_135:
    push 1
.Lconfig_apply_args_136:
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_133
    lea eax, [g_config]
    push eax
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_134
.Lconfig_apply_args_133:
    lea eax, [ark_str_68]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_137
    lea eax, [g_config]
    push eax
    push 60
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_138
.Lconfig_apply_args_137:
    lea eax, [ark_str_69]
    push eax
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ark_streq
    mov esp, [ebp-96]
    push eax
    pop eax
    test eax, eax
    jz .Lconfig_apply_args_139
    lea eax, [g_config]
    push eax
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lconfig_apply_args_140
.Lconfig_apply_args_139:
.Lconfig_apply_args_140:
.Lconfig_apply_args_138:
.Lconfig_apply_args_134:
.Lconfig_apply_args_130:
.Lconfig_apply_args_126:
.Lconfig_apply_args_122:
.Lconfig_apply_args_118:
.Lconfig_apply_args_114:
.Lconfig_apply_args_112:
.Lconfig_apply_args_106:
.Lconfig_apply_args_104:
.Lconfig_apply_args_102:
.Lconfig_apply_args_100:
.Lconfig_apply_args_98:
    jmp .Lconfig_apply_args_86
.Lconfig_apply_args_85:
.Lconfig_apply_args_86:
.Lconfig_apply_args_4:
    push dword ptr [ebp-64]
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-64], eax
    add esp, 4
    jmp .Lconfig_apply_args_2
.Lconfig_apply_args_3:
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

    .globl config_print
config_print:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [ark_str_70]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
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
    lea eax, [g_config]
    push eax
    push 8
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
    lea eax, [g_config]
    push eax
    push 4
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
    lea eax, [g_config]
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
    lea eax, [ark_str_71]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    pop eax
    mov [ebp-88], eax
    pop eax
    mov [ebp-92], eax
    pop eax
    mov [ebp-96], eax
    mov [ebp-64], esp
    push dword ptr [ebp-96]
    push dword ptr [ebp-92]
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
    push eax
    push 20
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
    lea eax, [g_config]
    push eax
    push 16
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
    lea eax, [ark_str_72]
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
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
    push eax
    push 32
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
    lea eax, [g_config]
    push eax
    push 28
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
    lea eax, [g_config]
    push eax
    push 24
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
    lea eax, [ark_str_73]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    pop eax
    mov [ebp-88], eax
    pop eax
    mov [ebp-92], eax
    mov [ebp-64], esp
    push dword ptr [ebp-92]
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
    push eax
    push 40
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
    lea eax, [g_config]
    push eax
    push 36
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
    lea eax, [ark_str_74]
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
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
    push eax
    push 52
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
    lea eax, [g_config]
    push eax
    push 48
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
    lea eax, [g_config]
    push eax
    push 44
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
    lea eax, [ark_str_75]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    pop eax
    mov [ebp-88], eax
    pop eax
    mov [ebp-92], eax
    mov [ebp-64], esp
    push dword ptr [ebp-92]
    push dword ptr [ebp-88]
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
    lea eax, [g_config]
    push eax
    push 56
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
    jz .Lconfig_print_0
    lea eax, [g_config]
    push eax
    push 56
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
    jmp .Lconfig_print_1
.Lconfig_print_0:
    lea eax, [ark_str_76]
    push eax
.Lconfig_print_1:
    lea eax, [ark_str_77]
    push eax
    pop eax
    mov [ebp-80], eax
    pop eax
    mov [ebp-84], eax
    mov [ebp-64], esp
    push dword ptr [ebp-84]
    push dword ptr [ebp-80]
    and esp, -16
    call ark_log
    mov esp, [ebp-64]
    push eax
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

