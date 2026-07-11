# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
ark_str_0:
    .asciz "[parser] line %d: %s (got token kind %d)\n"
ark_str_1:
    .asciz "aligned"
ark_str_2:
    .asciz "__aligned__"
ark_str_3:
    .asciz "at"
ark_str_4:
    .asciz "__at__"
ark_str_5:
    .asciz "section"
ark_str_6:
    .asciz "__section__"
ark_str_7:
    .asciz "alias"
ark_str_8:
    .asciz "__alias__"
ark_str_9:
    .asciz "packed"
ark_str_10:
    .asciz "__packed__"
ark_str_11:
    .asciz "aligned"
ark_str_12:
    .asciz "__aligned__"
ark_str_13:
    .asciz "weak"
ark_str_14:
    .asciz "__weak__"
ark_str_15:
    .asciz "naked"
ark_str_16:
    .asciz "__naked__"
ark_str_17:
    .asciz "interrupt"
ark_str_18:
    .asciz "__interrupt__"
ark_str_19:
    .asciz "irq"
ark_str_20:
    .asciz "__irq__"
ark_str_21:
    .asciz "used"
ark_str_22:
    .asciz "__used__"
ark_str_23:
    .asciz "unused"
ark_str_24:
    .asciz "__unused__"
ark_str_25:
    .asciz "softfp"
ark_str_26:
    .asciz "__softfp__"
ark_str_27:
    .asciz "always_inline"
ark_str_28:
    .asciz "__always_inline__"
ark_str_29:
    .asciz "forceinline"
ark_str_30:
    .asciz "constructor"
ark_str_31:
    .asciz "__constructor__"
ark_str_32:
    .asciz "destructor"
ark_str_33:
    .asciz "__destructor__"
ark_str_34:
    .asciz "deprecated"
ark_str_35:
    .asciz "__deprecated__"
ark_str_36:
    .asciz "pure"
ark_str_37:
    .asciz "__pure__"
ark_str_38:
    .asciz "const"
ark_str_39:
    .asciz "__const__"
ark_str_40:
    .asciz "may_alias"
ark_str_41:
    .asciz "__may_alias__"
ark_str_42:
    .asciz "nothrow"
ark_str_43:
    .asciz "__nothrow__"
ark_str_44:
    .asciz "visibility"
ark_str_45:
    .asciz "__visibility__"
ark_str_46:
    .asciz "nonnull"
ark_str_47:
    .asciz "__nonnull__"
ark_str_48:
    .asciz "warn_unused_result"
ark_str_49:
    .asciz "__warn_unused_result__"
ark_str_50:
    .asciz "sentinel"
ark_str_51:
    .asciz "__sentinel__"
ark_str_52:
    .asciz "malloc"
ark_str_53:
    .asciz "__malloc__"
ark_str_54:
    .asciz "fastcall"
ark_str_55:
    .asciz "__fastcall__"
ark_str_56:
    .asciz "stdcall"
ark_str_57:
    .asciz "__stdcall__"
ark_str_58:
    .asciz "cdecl"
ark_str_59:
    .asciz "__cdecl__"
ark_str_60:
    .asciz ""
ark_str_61:
    .asciz ""
ark_str_62:
    .asciz ""
ark_str_63:
    .asciz ""
ark_str_64:
    .asciz "("
ark_str_65:
    .asciz ")"
ark_str_66:
    .asciz ","
ark_str_67:
    .asciz "-"
ark_str_68:
    .asciz "+"
ark_str_69:
    .asciz "*"
ark_str_70:
    .asciz "&"
ark_str_71:
    .asciz "="
ark_str_72:
    .asciz "."
ark_str_73:
    .asciz "->"
ark_str_74:
    .asciz "["
ark_str_75:
    .asciz "]"
ark_str_76:
    .asciz "{"
ark_str_77:
    .asciz "}"
ark_str_78:
    .asciz ""
ark_str_79:
    .asciz ""
ark_str_80:
    .asciz "expected field type"
ark_str_81:
    .asciz ""
ark_str_82:
    .asciz "expected enum name"
ark_str_83:
    .asciz "expected enum value (constant expression)"
ark_str_84:
    .asciz "expected declaration at top level"
ark_str_85:
    .asciz "expected identifier in declaration"
ark_str_86:
    .asciz "expected param type"
ark_str_87:
    .asciz "_anon"
ark_str_88:
    .asciz "expected '{' in __asm function body"
ark_str_89:
    .asciz ""
ark_str_90:
    .asciz "expected identifier in declaration"
ark_str_91:
    .asciz "expected label name after goto"
ark_str_92:
    .asciz "_bad_label"
ark_str_93:
    .asciz "?indirect"
ark_str_94:
    .asciz "expected member name"
ark_str_95:
    .asciz ""
ark_str_96:
    .asciz "__func__"
ark_str_97:
    .asciz "__FUNCTION__"
ark_str_98:
    .asciz "__PRETTY_FUNCTION__"
ark_str_99:
    .asciz "?"
ark_str_100:
    .asciz "unexpected token in expression"
    .data
    .globl g_current_func_name
    .local g_current_func_name
g_current_func_name:
    .long 0
    .globl g_attr_is_weak
    .local g_attr_is_weak
g_attr_is_weak:
    .long 0
    .globl g_attr_is_naked
    .local g_attr_is_naked
g_attr_is_naked:
    .long 0
    .globl g_attr_is_irq
    .local g_attr_is_irq
g_attr_is_irq:
    .long 0
    .globl g_attr_section
    .local g_attr_section
g_attr_section:
    .long 0
    .globl g_decl_is_const
    .local g_decl_is_const
g_decl_is_const:
    .long 0
    .globl g_decl_is_volatile
    .local g_decl_is_volatile
g_decl_is_volatile:
    .long 0
    .globl g_attr_is_used
    .local g_attr_is_used
g_attr_is_used:
    .long 0
    .globl g_attr_is_unused
    .local g_attr_is_unused
g_attr_is_unused:
    .long 0
    .globl g_attr_alias_target
    .local g_attr_alias_target
g_attr_alias_target:
    .long 0
    .globl g_attr_align_bytes
    .local g_attr_align_bytes
g_attr_align_bytes:
    .long 0
    .globl g_decl_align_bytes
    .local g_decl_align_bytes
g_decl_align_bytes:
    .long 0
    .globl g_decl_packed_ptr
    .local g_decl_packed_ptr
g_decl_packed_ptr:
    .long 0
    .globl g_vla_size_expr
    .local g_vla_size_expr
g_vla_size_expr:
    .long 0
    .globl g_attr_is_softfp
    .local g_attr_is_softfp
g_attr_is_softfp:
    .long 0
    .globl g_attr_is_forceinline
    .local g_attr_is_forceinline
g_attr_is_forceinline:
    .long 0
    .globl g_decl_is_asm_fn
    .local g_decl_is_asm_fn
g_decl_is_asm_fn:
    .long 0
    .globl g_attr_is_constructor
    .local g_attr_is_constructor
g_attr_is_constructor:
    .long 0
    .globl g_attr_is_destructor
    .local g_attr_is_destructor
g_attr_is_destructor:
    .long 0
    .globl g_attr_is_deprecated
    .local g_attr_is_deprecated
g_attr_is_deprecated:
    .long 0
    .globl g_attr_at_addr
    .local g_attr_at_addr
g_attr_at_addr:
    .long 0
    .globl g_attr_has_at
    .local g_attr_has_at
g_attr_has_at:
    .long 0
    .globl g_func_is_value_in_regs
    .local g_func_is_value_in_regs
g_func_is_value_in_regs:
    .long 0
    .globl g_func_is_pure
    .local g_func_is_pure
g_func_is_pure:
    .long 0
    .globl g_func_is_const_attr
    .local g_func_is_const_attr
g_func_is_const_attr:
    .long 0
    .globl g_func_is_interwork
    .local g_func_is_interwork
g_func_is_interwork:
    .long 0
    .globl g_func_is_deprecated_kw
    .local g_func_is_deprecated_kw
g_func_is_deprecated_kw:
    .long 0
    .globl g_func_mods_declspec
    .local g_func_mods_declspec
g_func_mods_declspec:
    .long 0
    .text
    .globl is_basic_type_token
is_basic_type_token:
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
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_1
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_2
    push dword ptr [ebp-56]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_3
    push dword ptr [ebp-56]
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_4
    push dword ptr [ebp-56]
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_5
    push dword ptr [ebp-56]
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_6
    push dword ptr [ebp-56]
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_7
    push dword ptr [ebp-56]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_8
    push dword ptr [ebp-56]
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_9
    push dword ptr [ebp-56]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_10
    push dword ptr [ebp-56]
    push 74
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_11
    push dword ptr [ebp-56]
    push 75
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_12
    push dword ptr [ebp-56]
    push 76
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_13
    push dword ptr [ebp-56]
    push 66
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_14
    push dword ptr [ebp-56]
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_15
    push dword ptr [ebp-56]
    push 68
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_16
    push dword ptr [ebp-56]
    push 69
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_17
    push dword ptr [ebp-56]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_18
    push dword ptr [ebp-56]
    push 71
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_19
    push dword ptr [ebp-56]
    push 72
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_20
    push dword ptr [ebp-56]
    push 73
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_21
    push dword ptr [ebp-56]
    push 77
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_22
    push dword ptr [ebp-56]
    push 94
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_23
    push dword ptr [ebp-56]
    push 100
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_24
    push dword ptr [ebp-56]
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_25
    push dword ptr [ebp-56]
    push 109
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_26
    push dword ptr [ebp-56]
    push 108
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_27
    push dword ptr [ebp-56]
    push 107
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_28
    push dword ptr [ebp-56]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_29
    push dword ptr [ebp-56]
    push 104
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_30
    push dword ptr [ebp-56]
    push 105
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_31
    push dword ptr [ebp-56]
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_32
    push dword ptr [ebp-56]
    push 106
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_33
    push dword ptr [ebp-56]
    push 103
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_34
    push dword ptr [ebp-56]
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_35
    push dword ptr [ebp-56]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_36
    push dword ptr [ebp-56]
    push 93
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_37
    push dword ptr [ebp-56]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_38
    push dword ptr [ebp-56]
    push 98
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_39
    push dword ptr [ebp-56]
    push 118
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lis_basic_type_token_40
    jmp .Lis_basic_type_token_41
.Lis_basic_type_token_1:
.Lis_basic_type_token_2:
.Lis_basic_type_token_3:
.Lis_basic_type_token_4:
.Lis_basic_type_token_5:
.Lis_basic_type_token_6:
.Lis_basic_type_token_7:
.Lis_basic_type_token_8:
.Lis_basic_type_token_9:
.Lis_basic_type_token_10:
.Lis_basic_type_token_11:
.Lis_basic_type_token_12:
.Lis_basic_type_token_13:
.Lis_basic_type_token_14:
.Lis_basic_type_token_15:
.Lis_basic_type_token_16:
.Lis_basic_type_token_17:
.Lis_basic_type_token_18:
.Lis_basic_type_token_19:
.Lis_basic_type_token_20:
.Lis_basic_type_token_21:
.Lis_basic_type_token_22:
.Lis_basic_type_token_23:
.Lis_basic_type_token_24:
.Lis_basic_type_token_25:
.Lis_basic_type_token_26:
.Lis_basic_type_token_27:
.Lis_basic_type_token_28:
.Lis_basic_type_token_29:
.Lis_basic_type_token_30:
.Lis_basic_type_token_31:
.Lis_basic_type_token_32:
.Lis_basic_type_token_33:
.Lis_basic_type_token_34:
.Lis_basic_type_token_35:
.Lis_basic_type_token_36:
.Lis_basic_type_token_37:
.Lis_basic_type_token_38:
.Lis_basic_type_token_39:
.Lis_basic_type_token_40:
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lis_basic_type_token_41:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lis_basic_type_token_0:
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

    .globl is_decl_start
is_decl_start:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-112]
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-56]
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
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call is_basic_type_token
    mov esp, [ebp-112]
    push eax
    pop eax
    test eax, eax
    jz .Lis_decl_start_0
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_decl_start_1
.Lis_decl_start_0:
.Lis_decl_start_1:
    lea eax, [ebp-56]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lis_decl_start_4
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-112]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lis_decl_start_5
.Lis_decl_start_4:
    push 0
.Lis_decl_start_5:
    pop eax
    test eax, eax
    jz .Lis_decl_start_2
    push 1
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lis_decl_start_3
.Lis_decl_start_2:
.Lis_decl_start_3:
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

    .globl perror_at
perror_at:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 364
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-128], eax
    mov [ebp-112], esp
    push dword ptr [ebp-128]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-112]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
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
    push dword ptr [ebp-56]
    lea eax, [ebp-64]
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
    lea eax, [ark_str_0]
    push eax
    pop eax
    mov [ebp-128], eax
    pop eax
    mov [ebp-132], eax
    pop eax
    mov [ebp-136], eax
    pop eax
    mov [ebp-140], eax
    mov [ebp-112], esp
    push dword ptr [ebp-140]
    push dword ptr [ebp-136]
    push dword ptr [ebp-132]
    push dword ptr [ebp-128]
    and esp, -16
    call ark_log
    mov esp, [ebp-112]
    push eax
    push dword ptr [ebp-48]
    push 4
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

    .globl parse_program
parse_program:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    lea eax, [ebp-56]
    push eax
    push 0
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
    lea eax, [ebp-56]
    push eax
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
    mov [ebp-96], esp
    and esp, -16
    call sym_init
    mov esp, [ebp-96]
    push eax
    push 1
    push 0
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
.Lparse_program_0:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_program_1
    lea eax, [ebp-56]
    push eax
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_top_decl
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lparse_program_2
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_program_4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    test eax, eax
    jz .Lparse_program_6
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lparse_program_7
.Lparse_program_6:
    push 16
.Lparse_program_7:
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    mov [ebp-96], esp
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-96]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_program_5
.Lparse_program_4:
.Lparse_program_5:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-80]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
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
    jmp .Lparse_program_3
.Lparse_program_2:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_program_8
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    jmp .Lparse_program_9
.Lparse_program_8:
.Lparse_program_9:
.Lparse_program_3:
    jmp .Lparse_program_0
.Lparse_program_1:
    push dword ptr [ebp-64]
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

    .globl skip_qualifiers
skip_qualifiers:
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
.Lskip_qualifiers_0:
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-80]
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
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push 66
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lskip_qualifiers_9
    push dword ptr [ebp-72]
    push 67
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
    jmp .Lskip_qualifiers_10
.Lskip_qualifiers_9:
    push 1
.Lskip_qualifiers_10:
    pop eax
    test eax, eax
    jnz .Lskip_qualifiers_7
    push dword ptr [ebp-72]
    push 68
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
    jmp .Lskip_qualifiers_8
.Lskip_qualifiers_7:
    push 1
.Lskip_qualifiers_8:
    pop eax
    test eax, eax
    jnz .Lskip_qualifiers_5
    push dword ptr [ebp-72]
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
    jmp .Lskip_qualifiers_6
.Lskip_qualifiers_5:
    push 1
.Lskip_qualifiers_6:
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_3
    push dword ptr [ebp-72]
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_13
    push dword ptr [ebp-56]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_qualifiers_14
.Lskip_qualifiers_13:
    push 0
.Lskip_qualifiers_14:
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_11
    push dword ptr [ebp-56]
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lskip_qualifiers_12
.Lskip_qualifiers_11:
.Lskip_qualifiers_12:
    push dword ptr [ebp-72]
    push 66
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_17
    push dword ptr [ebp-64]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lskip_qualifiers_18
.Lskip_qualifiers_17:
    push 0
.Lskip_qualifiers_18:
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_15
    push dword ptr [ebp-64]
    push 1
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lskip_qualifiers_16
.Lskip_qualifiers_15:
.Lskip_qualifiers_16:
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-80]
    push eax
    jmp .Lskip_qualifiers_4
.Lskip_qualifiers_3:
    push dword ptr [ebp-72]
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lskip_qualifiers_19
    push 0
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-80]
    jmp .Lskip_qualifiers_20
.Lskip_qualifiers_19:
    jmp .Lskip_qualifiers_1
.Lskip_qualifiers_20:
.Lskip_qualifiers_4:
.Lskip_qualifiers_2:
    jmp .Lskip_qualifiers_0
.Lskip_qualifiers_1:
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

    .globl parse_svc
parse_svc:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 90
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_svc_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_svc_1
.Lparse_svc_0:
.Lparse_svc_1:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_svc_2
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_svc_3
.Lparse_svc_2:
.Lparse_svc_3:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_svc_4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_svc_5
.Lparse_svc_4:
.Lparse_svc_5:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_svc_6
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_svc_7
.Lparse_svc_6:
.Lparse_svc_7:
    push dword ptr [ebp-56]
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

    .globl parse_func_modifiers
parse_func_modifiers:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
.Lparse_func_modifiers_0:
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-80]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_3
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_func_modifiers_4
.Lparse_func_modifiers_3:
    push dword ptr [ebp-64]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_5
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_func_modifiers_6
.Lparse_func_modifiers_5:
    push dword ptr [ebp-64]
    push 93
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_7
    push dword ptr [ebp-56]
    push 4
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_func_modifiers_8
.Lparse_func_modifiers_7:
    push dword ptr [ebp-64]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_9
    push dword ptr [ebp-56]
    push 8
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_func_modifiers_10
.Lparse_func_modifiers_9:
    push dword ptr [ebp-64]
    push 98
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_11
    push dword ptr [ebp-56]
    push 16
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_func_modifiers_12
.Lparse_func_modifiers_11:
    push dword ptr [ebp-64]
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_13
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_value_in_regs], eax
    add esp, 4
    jmp .Lparse_func_modifiers_14
.Lparse_func_modifiers_13:
    push dword ptr [ebp-64]
    push 104
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_15
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_pure], eax
    add esp, 4
    jmp .Lparse_func_modifiers_16
.Lparse_func_modifiers_15:
    push dword ptr [ebp-64]
    push 105
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_17
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_interwork], eax
    add esp, 4
    jmp .Lparse_func_modifiers_18
.Lparse_func_modifiers_17:
    push dword ptr [ebp-64]
    push 116
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_19
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_deprecated_kw], eax
    add esp, 4
    jmp .Lparse_func_modifiers_20
.Lparse_func_modifiers_19:
    push dword ptr [ebp-64]
    push 115
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_func_modifiers_29
    push dword ptr [ebp-64]
    push 117
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
    jmp .Lparse_func_modifiers_30
.Lparse_func_modifiers_29:
    push 1
.Lparse_func_modifiers_30:
    pop eax
    test eax, eax
    jnz .Lparse_func_modifiers_27
    push dword ptr [ebp-64]
    push 114
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
    jmp .Lparse_func_modifiers_28
.Lparse_func_modifiers_27:
    push 1
.Lparse_func_modifiers_28:
    pop eax
    test eax, eax
    jnz .Lparse_func_modifiers_25
    push dword ptr [ebp-64]
    push 112
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
    jmp .Lparse_func_modifiers_26
.Lparse_func_modifiers_25:
    push 1
.Lparse_func_modifiers_26:
    pop eax
    test eax, eax
    jnz .Lparse_func_modifiers_23
    push dword ptr [ebp-64]
    push 113
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
    jmp .Lparse_func_modifiers_24
.Lparse_func_modifiers_23:
    push 1
.Lparse_func_modifiers_24:
    pop eax
    test eax, eax
    jz .Lparse_func_modifiers_21
    jmp .Lparse_func_modifiers_22
.Lparse_func_modifiers_21:
    jmp .Lparse_func_modifiers_1
.Lparse_func_modifiers_22:
.Lparse_func_modifiers_20:
.Lparse_func_modifiers_18:
.Lparse_func_modifiers_16:
.Lparse_func_modifiers_14:
.Lparse_func_modifiers_12:
.Lparse_func_modifiers_10:
.Lparse_func_modifiers_8:
.Lparse_func_modifiers_6:
.Lparse_func_modifiers_4:
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-80]
    push eax
.Lparse_func_modifiers_2:
    jmp .Lparse_func_modifiers_0
.Lparse_func_modifiers_1:
    push dword ptr [ebp-56]
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

    .globl parse_attribute
parse_attribute:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_attribute_1
.Lparse_attribute_0:
.Lparse_attribute_1:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_2
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_attribute_3
.Lparse_attribute_2:
.Lparse_attribute_3:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_attribute_5
.Lparse_attribute_4:
.Lparse_attribute_5:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
.Lparse_attribute_6:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_8
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    jmp .Lparse_attribute_9
.Lparse_attribute_8:
    push 0
.Lparse_attribute_9:
    pop eax
    test eax, eax
    jz .Lparse_attribute_7
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_10
    lea eax, [ebp-64]
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
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_12
    push 1
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_14
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push 1
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_attribute_15
.Lparse_attribute_14:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_16
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lparse_attribute_17
.Lparse_attribute_16:
.Lparse_attribute_17:
.Lparse_attribute_15:
.Lparse_attribute_18:
    push dword ptr [ebp-120]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_20
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    jmp .Lparse_attribute_21
.Lparse_attribute_20:
    push 0
.Lparse_attribute_21:
    pop eax
    test eax, eax
    jz .Lparse_attribute_19
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_22
    push dword ptr [ebp-120]
    push dword ptr [ebp-120]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-120], eax
    add esp, 4
    jmp .Lparse_attribute_23
.Lparse_attribute_22:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_24
    push dword ptr [ebp-120]
    push dword ptr [ebp-120]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-120], eax
    add esp, 4
    jmp .Lparse_attribute_25
.Lparse_attribute_24:
.Lparse_attribute_25:
.Lparse_attribute_23:
    push dword ptr [ebp-120]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_26
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_attribute_27
.Lparse_attribute_26:
.Lparse_attribute_27:
    jmp .Lparse_attribute_18
.Lparse_attribute_19:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_28
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_attribute_29
.Lparse_attribute_28:
.Lparse_attribute_29:
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    jz .Lparse_attribute_32
    lea eax, [ark_str_1]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_34
    lea eax, [ark_str_2]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_35
.Lparse_attribute_34:
    push 1
.Lparse_attribute_35:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_33
.Lparse_attribute_32:
    push 0
.Lparse_attribute_33:
    pop eax
    test eax, eax
    jz .Lparse_attribute_30
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_attribute_36
    push dword ptr [ebp-56]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_attribute_37
.Lparse_attribute_36:
.Lparse_attribute_37:
    push dword ptr [ebp-128]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_align_bytes], eax
    add esp, 4
    jmp .Lparse_attribute_31
.Lparse_attribute_30:
.Lparse_attribute_31:
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    jz .Lparse_attribute_40
    lea eax, [ark_str_3]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_42
    lea eax, [ark_str_4]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_43
.Lparse_attribute_42:
    push 1
.Lparse_attribute_43:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_41
.Lparse_attribute_40:
    push 0
.Lparse_attribute_41:
    pop eax
    test eax, eax
    jz .Lparse_attribute_38
    push dword ptr [ebp-128]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_at_addr], eax
    add esp, 4
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_has_at], eax
    add esp, 4
    jmp .Lparse_attribute_39
.Lparse_attribute_38:
.Lparse_attribute_39:
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lparse_attribute_46
    lea eax, [ark_str_5]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_48
    lea eax, [ark_str_6]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_49
.Lparse_attribute_48:
    push 1
.Lparse_attribute_49:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_47
.Lparse_attribute_46:
    push 0
.Lparse_attribute_47:
    pop eax
    test eax, eax
    jz .Lparse_attribute_44
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    jmp .Lparse_attribute_45
.Lparse_attribute_44:
.Lparse_attribute_45:
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lparse_attribute_52
    lea eax, [ark_str_7]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_54
    lea eax, [ark_str_8]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_55
.Lparse_attribute_54:
    push 1
.Lparse_attribute_55:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_53
.Lparse_attribute_52:
    push 0
.Lparse_attribute_53:
    pop eax
    test eax, eax
    jz .Lparse_attribute_50
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_alias_target], eax
    add esp, 4
    jmp .Lparse_attribute_51
.Lparse_attribute_50:
.Lparse_attribute_51:
    jmp .Lparse_attribute_13
.Lparse_attribute_12:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_attribute_58
    lea eax, [ark_str_9]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_60
    lea eax, [ark_str_10]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_61
.Lparse_attribute_60:
    push 1
.Lparse_attribute_61:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_59
.Lparse_attribute_58:
    push 0
.Lparse_attribute_59:
    pop eax
    test eax, eax
    jz .Lparse_attribute_56
    push dword ptr [ebp-56]
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
    jmp .Lparse_attribute_57
.Lparse_attribute_56:
.Lparse_attribute_57:
    lea eax, [ark_str_11]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_64
    lea eax, [ark_str_12]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_65
.Lparse_attribute_64:
    push 1
.Lparse_attribute_65:
    pop eax
    test eax, eax
    jz .Lparse_attribute_62
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_attribute_66
    push dword ptr [ebp-56]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_attribute_67
.Lparse_attribute_66:
.Lparse_attribute_67:
    push 8
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_align_bytes], eax
    add esp, 4
    jmp .Lparse_attribute_63
.Lparse_attribute_62:
.Lparse_attribute_63:
    lea eax, [ark_str_13]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_70
    lea eax, [ark_str_14]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_71
.Lparse_attribute_70:
    push 1
.Lparse_attribute_71:
    pop eax
    test eax, eax
    jz .Lparse_attribute_68
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_weak], eax
    add esp, 4
    jmp .Lparse_attribute_69
.Lparse_attribute_68:
.Lparse_attribute_69:
    lea eax, [ark_str_15]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_74
    lea eax, [ark_str_16]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_75
.Lparse_attribute_74:
    push 1
.Lparse_attribute_75:
    pop eax
    test eax, eax
    jz .Lparse_attribute_72
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_naked], eax
    add esp, 4
    jmp .Lparse_attribute_73
.Lparse_attribute_72:
.Lparse_attribute_73:
    lea eax, [ark_str_17]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_82
    lea eax, [ark_str_18]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_83
.Lparse_attribute_82:
    push 1
.Lparse_attribute_83:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_80
    lea eax, [ark_str_19]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_81
.Lparse_attribute_80:
    push 1
.Lparse_attribute_81:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_78
    lea eax, [ark_str_20]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_79
.Lparse_attribute_78:
    push 1
.Lparse_attribute_79:
    pop eax
    test eax, eax
    jz .Lparse_attribute_76
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_irq], eax
    add esp, 4
    jmp .Lparse_attribute_77
.Lparse_attribute_76:
.Lparse_attribute_77:
    lea eax, [ark_str_21]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_86
    lea eax, [ark_str_22]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_87
.Lparse_attribute_86:
    push 1
.Lparse_attribute_87:
    pop eax
    test eax, eax
    jz .Lparse_attribute_84
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_used], eax
    add esp, 4
    jmp .Lparse_attribute_85
.Lparse_attribute_84:
.Lparse_attribute_85:
    lea eax, [ark_str_23]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_90
    lea eax, [ark_str_24]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_91
.Lparse_attribute_90:
    push 1
.Lparse_attribute_91:
    pop eax
    test eax, eax
    jz .Lparse_attribute_88
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_unused], eax
    add esp, 4
    jmp .Lparse_attribute_89
.Lparse_attribute_88:
.Lparse_attribute_89:
    lea eax, [ark_str_25]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_94
    lea eax, [ark_str_26]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_95
.Lparse_attribute_94:
    push 1
.Lparse_attribute_95:
    pop eax
    test eax, eax
    jz .Lparse_attribute_92
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_softfp], eax
    add esp, 4
    jmp .Lparse_attribute_93
.Lparse_attribute_92:
.Lparse_attribute_93:
    lea eax, [ark_str_27]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_100
    lea eax, [ark_str_28]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_101
.Lparse_attribute_100:
    push 1
.Lparse_attribute_101:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_98
    lea eax, [ark_str_29]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_99
.Lparse_attribute_98:
    push 1
.Lparse_attribute_99:
    pop eax
    test eax, eax
    jz .Lparse_attribute_96
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_forceinline], eax
    add esp, 4
    jmp .Lparse_attribute_97
.Lparse_attribute_96:
.Lparse_attribute_97:
    lea eax, [ark_str_30]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_104
    lea eax, [ark_str_31]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_105
.Lparse_attribute_104:
    push 1
.Lparse_attribute_105:
    pop eax
    test eax, eax
    jz .Lparse_attribute_102
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_constructor], eax
    add esp, 4
    jmp .Lparse_attribute_103
.Lparse_attribute_102:
.Lparse_attribute_103:
    lea eax, [ark_str_32]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_108
    lea eax, [ark_str_33]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_109
.Lparse_attribute_108:
    push 1
.Lparse_attribute_109:
    pop eax
    test eax, eax
    jz .Lparse_attribute_106
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_destructor], eax
    add esp, 4
    jmp .Lparse_attribute_107
.Lparse_attribute_106:
.Lparse_attribute_107:
    lea eax, [ark_str_34]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_112
    lea eax, [ark_str_35]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_113
.Lparse_attribute_112:
    push 1
.Lparse_attribute_113:
    pop eax
    test eax, eax
    jz .Lparse_attribute_110
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_deprecated], eax
    add esp, 4
    jmp .Lparse_attribute_111
.Lparse_attribute_110:
.Lparse_attribute_111:
    lea eax, [ark_str_36]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_116
    lea eax, [ark_str_37]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_117
.Lparse_attribute_116:
    push 1
.Lparse_attribute_117:
    pop eax
    test eax, eax
    jz .Lparse_attribute_114
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_pure], eax
    add esp, 4
    jmp .Lparse_attribute_115
.Lparse_attribute_114:
.Lparse_attribute_115:
    lea eax, [ark_str_38]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_120
    lea eax, [ark_str_39]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_121
.Lparse_attribute_120:
    push 1
.Lparse_attribute_121:
    pop eax
    test eax, eax
    jz .Lparse_attribute_118
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_const_attr], eax
    add esp, 4
    jmp .Lparse_attribute_119
.Lparse_attribute_118:
.Lparse_attribute_119:
    lea eax, [ark_str_40]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_attribute_160
    lea eax, [ark_str_41]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_161
.Lparse_attribute_160:
    push 1
.Lparse_attribute_161:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_158
    lea eax, [ark_str_42]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_159
.Lparse_attribute_158:
    push 1
.Lparse_attribute_159:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_156
    lea eax, [ark_str_43]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_157
.Lparse_attribute_156:
    push 1
.Lparse_attribute_157:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_154
    lea eax, [ark_str_44]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_155
.Lparse_attribute_154:
    push 1
.Lparse_attribute_155:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_152
    lea eax, [ark_str_45]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_153
.Lparse_attribute_152:
    push 1
.Lparse_attribute_153:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_150
    lea eax, [ark_str_46]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_151
.Lparse_attribute_150:
    push 1
.Lparse_attribute_151:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_148
    lea eax, [ark_str_47]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_149
.Lparse_attribute_148:
    push 1
.Lparse_attribute_149:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_146
    lea eax, [ark_str_48]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_147
.Lparse_attribute_146:
    push 1
.Lparse_attribute_147:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_144
    lea eax, [ark_str_49]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_145
.Lparse_attribute_144:
    push 1
.Lparse_attribute_145:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_142
    lea eax, [ark_str_50]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_143
.Lparse_attribute_142:
    push 1
.Lparse_attribute_143:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_140
    lea eax, [ark_str_51]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_141
.Lparse_attribute_140:
    push 1
.Lparse_attribute_141:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_138
    lea eax, [ark_str_52]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_139
.Lparse_attribute_138:
    push 1
.Lparse_attribute_139:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_136
    lea eax, [ark_str_53]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_137
.Lparse_attribute_136:
    push 1
.Lparse_attribute_137:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_134
    lea eax, [ark_str_54]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_135
.Lparse_attribute_134:
    push 1
.Lparse_attribute_135:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_132
    lea eax, [ark_str_55]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_133
.Lparse_attribute_132:
    push 1
.Lparse_attribute_133:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_130
    lea eax, [ark_str_56]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_131
.Lparse_attribute_130:
    push 1
.Lparse_attribute_131:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_128
    lea eax, [ark_str_57]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_129
.Lparse_attribute_128:
    push 1
.Lparse_attribute_129:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_126
    lea eax, [ark_str_58]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_127
.Lparse_attribute_126:
    push 1
.Lparse_attribute_127:
    pop eax
    test eax, eax
    jnz .Lparse_attribute_124
    lea eax, [ark_str_59]
    push eax
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ark_streq
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_attribute_125
.Lparse_attribute_124:
    push 1
.Lparse_attribute_125:
    pop eax
    test eax, eax
    jz .Lparse_attribute_122
    jmp .Lparse_attribute_123
.Lparse_attribute_122:
.Lparse_attribute_123:
.Lparse_attribute_13:
    jmp .Lparse_attribute_11
.Lparse_attribute_10:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
.Lparse_attribute_11:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_162
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_attribute_163
.Lparse_attribute_162:
.Lparse_attribute_163:
    jmp .Lparse_attribute_6
.Lparse_attribute_7:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_164
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_attribute_165
.Lparse_attribute_164:
.Lparse_attribute_165:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_attribute_166
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_attribute_167
.Lparse_attribute_166:
.Lparse_attribute_167:
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

    .globl parse_init_list
parse_init_list:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 444
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 32
    pop eax
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    mov [ebp-192], esp
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call ast_new
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
.Lparse_init_list_0:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_2
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    jmp .Lparse_init_list_3
.Lparse_init_list_2:
    push 0
.Lparse_init_list_3:
    pop eax
    test eax, eax
    jz .Lparse_init_list_1
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 84
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_4
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_6
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    pop eax
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_7
.Lparse_init_list_6:
.Lparse_init_list_7:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 84
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_init_list_10
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 52
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
    jmp .Lparse_init_list_11
.Lparse_init_list_10:
    push 1
.Lparse_init_list_11:
    pop eax
    test eax, eax
    jz .Lparse_init_list_8
    push dword ptr [ebp-56]
    push 32
    pop eax
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    mov [ebp-192], esp
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call ast_new
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push 0
    pop eax
    mov [ebp-152], eax
    push 0
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 84
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_12
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_14
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    pop eax
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push 1
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_15
.Lparse_init_list_14:
.Lparse_init_list_15:
    jmp .Lparse_init_list_13
.Lparse_init_list_12:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_16
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    push 1
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_17
.Lparse_init_list_16:
.Lparse_init_list_17:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_18
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_19
.Lparse_init_list_18:
.Lparse_init_list_19:
.Lparse_init_list_13:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_20
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_21
.Lparse_init_list_20:
.Lparse_init_list_21:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call parse_initializer
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-56]
    push 33
    pop eax
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    mov [ebp-192], esp
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call ast_new
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop eax
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-192]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 0
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-56]
    push 33
    pop eax
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    mov [ebp-192], esp
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call ast_new
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_22
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    test eax, eax
    jz .Lparse_init_list_24
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lparse_init_list_25
.Lparse_init_list_24:
    push 8
.Lparse_init_list_25:
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    pop eax
    mov [ebp-216], eax
    mov [ebp-192], esp
    push dword ptr [ebp-216]
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-192]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_init_list_23
.Lparse_init_list_22:
.Lparse_init_list_23:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-168]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
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
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_26
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_27
.Lparse_init_list_26:
.Lparse_init_list_27:
    jmp .Lparse_init_list_0
    jmp .Lparse_init_list_9
.Lparse_init_list_8:
.Lparse_init_list_9:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_28
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_29
.Lparse_init_list_28:
.Lparse_init_list_29:
    jmp .Lparse_init_list_5
.Lparse_init_list_4:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 52
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_30
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_32
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    push 1
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_33
.Lparse_init_list_32:
.Lparse_init_list_33:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_34
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_35
.Lparse_init_list_34:
.Lparse_init_list_35:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_36
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_37
.Lparse_init_list_36:
.Lparse_init_list_37:
    jmp .Lparse_init_list_31
.Lparse_init_list_30:
.Lparse_init_list_31:
.Lparse_init_list_5:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call parse_initializer
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-56]
    push 33
    pop eax
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    mov [ebp-192], esp
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call ast_new
    mov esp, [ebp-192]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-104]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-72]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_38
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop eax
    test eax, eax
    jz .Lparse_init_list_40
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lparse_init_list_41
.Lparse_init_list_40:
    push 8
.Lparse_init_list_41:
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-208], eax
    pop eax
    mov [ebp-212], eax
    pop eax
    mov [ebp-216], eax
    mov [ebp-192], esp
    push dword ptr [ebp-216]
    push dword ptr [ebp-212]
    push dword ptr [ebp-208]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-192]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_init_list_39
.Lparse_init_list_38:
.Lparse_init_list_39:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
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
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_42
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_43
.Lparse_init_list_42:
.Lparse_init_list_43:
    jmp .Lparse_init_list_0
.Lparse_init_list_1:
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-192]
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
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_init_list_44
    push dword ptr [ebp-48]
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
    mov [ebp-208], eax
    mov [ebp-192], esp
    push dword ptr [ebp-208]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-192]
    push eax
    jmp .Lparse_init_list_45
.Lparse_init_list_44:
.Lparse_init_list_45:
    push dword ptr [ebp-64]
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

    .globl parse_initializer
parse_initializer:
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_initializer_0
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call parse_init_list
    mov esp, [ebp-64]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_initializer_1
.Lparse_initializer_0:
.Lparse_initializer_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call parse_assign_expr
    mov esp, [ebp-64]
    push eax
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

    .globl infer_array_size_from_init
infer_array_size_from_init:
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
    push dword ptr [ebp-48]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Linfer_array_size_from_init_4
    push dword ptr [ebp-48]
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
    push 10
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
    jmp .Linfer_array_size_from_init_5
.Linfer_array_size_from_init_4:
    push 1
.Linfer_array_size_from_init_5:
    pop eax
    test eax, eax
    jnz .Linfer_array_size_from_init_2
    push dword ptr [ebp-48]
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
    jmp .Linfer_array_size_from_init_3
.Linfer_array_size_from_init_2:
    push 1
.Linfer_array_size_from_init_3:
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Linfer_array_size_from_init_1
.Linfer_array_size_from_init_0:
.Linfer_array_size_from_init_1:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_6
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Linfer_array_size_from_init_7
.Linfer_array_size_from_init_6:
.Linfer_array_size_from_init_7:
    push dword ptr [ebp-56]
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
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_8
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
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
    jz .Linfer_array_size_from_init_10
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
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
    jmp .Linfer_array_size_from_init_11
.Linfer_array_size_from_init_10:
    lea eax, [ark_str_60]
    push eax
.Linfer_array_size_from_init_11:
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
.Linfer_array_size_from_init_12:
    push dword ptr [ebp-64]
    push dword ptr [ebp-72]
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
    jz .Linfer_array_size_from_init_13
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    jmp .Linfer_array_size_from_init_12
.Linfer_array_size_from_init_13:
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
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
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Linfer_array_size_from_init_9
.Linfer_array_size_from_init_8:
.Linfer_array_size_from_init_9:
    push dword ptr [ebp-56]
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
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_14
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Linfer_array_size_from_init_16:
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_17
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_21
    push dword ptr [ebp-88]
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
    push 33
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
    jmp .Linfer_array_size_from_init_22
.Linfer_array_size_from_init_21:
    push 0
.Linfer_array_size_from_init_22:
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_19
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    jz .Linfer_array_size_from_init_23
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_25
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Linfer_array_size_from_init_26
.Linfer_array_size_from_init_25:
.Linfer_array_size_from_init_26:
    jmp .Linfer_array_size_from_init_24
.Linfer_array_size_from_init_23:
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
.Linfer_array_size_from_init_24:
    jmp .Linfer_array_size_from_init_20
.Linfer_array_size_from_init_19:
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
.Linfer_array_size_from_init_20:
.Linfer_array_size_from_init_18:
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
    jmp .Linfer_array_size_from_init_16
.Linfer_array_size_from_init_17:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_27
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Linfer_array_size_from_init_28
.Linfer_array_size_from_init_27:
.Linfer_array_size_from_init_28:
    push dword ptr [ebp-72]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_29
    push dword ptr [ebp-48]
    push 8
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
    jmp .Linfer_array_size_from_init_30
.Linfer_array_size_from_init_29:
.Linfer_array_size_from_init_30:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Linfer_array_size_from_init_15
.Linfer_array_size_from_init_14:
.Linfer_array_size_from_init_15:
    push dword ptr [ebp-56]
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
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_37
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Linfer_array_size_from_init_38
.Linfer_array_size_from_init_37:
    push 0
.Linfer_array_size_from_init_38:
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_35
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    jmp .Linfer_array_size_from_init_36
.Linfer_array_size_from_init_35:
    push 0
.Linfer_array_size_from_init_36:
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_33
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Linfer_array_size_from_init_34
.Linfer_array_size_from_init_33:
    push 0
.Linfer_array_size_from_init_34:
    pop eax
    test eax, eax
    jz .Linfer_array_size_from_init_31
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    jmp .Linfer_array_size_from_init_32
.Linfer_array_size_from_init_31:
.Linfer_array_size_from_init_32:
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

    .globl parse_asm_statement
parse_asm_statement:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 508
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    push 34
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_new
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
.Lparse_asm_statement_0:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_4
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 66
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
    jmp .Lparse_asm_statement_5
.Lparse_asm_statement_4:
    push 1
.Lparse_asm_statement_5:
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_2
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    jmp .Lparse_asm_statement_3
.Lparse_asm_statement_2:
    push 1
.Lparse_asm_statement_3:
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_1
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_6
    push 1
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lparse_asm_statement_7
.Lparse_asm_statement_6:
.Lparse_asm_statement_7:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    jmp .Lparse_asm_statement_0
.Lparse_asm_statement_1:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
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
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_8
    push dword ptr [ebp-64]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_asm_statement_9
.Lparse_asm_statement_8:
.Lparse_asm_statement_9:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
.Lparse_asm_statement_10:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_11
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-104]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lparse_asm_statement_12:
    push dword ptr [ebp-128]
    push dword ptr [ebp-88]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_13
    push dword ptr [ebp-120]
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
    push dword ptr [ebp-80]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lparse_asm_statement_14:
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
    jmp .Lparse_asm_statement_12
.Lparse_asm_statement_13:
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lparse_asm_statement_15:
    push dword ptr [ebp-128]
    push dword ptr [ebp-104]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_16
    push dword ptr [ebp-120]
    push dword ptr [ebp-88]
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-96]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lparse_asm_statement_17:
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
    jmp .Lparse_asm_statement_15
.Lparse_asm_statement_16:
    push dword ptr [ebp-120]
    push dword ptr [ebp-112]
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
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    jmp .Lparse_asm_statement_10
.Lparse_asm_statement_11:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_18
    push dword ptr [ebp-80]
    jmp .Lparse_asm_statement_19
.Lparse_asm_statement_18:
    lea eax, [ark_str_61]
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-256]
    push eax
.Lparse_asm_statement_19:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-80], eax
.Lparse_asm_statement_20:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_22
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 49
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
    jmp .Lparse_asm_statement_23
.Lparse_asm_statement_22:
    push 0
.Lparse_asm_statement_23:
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_21
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 56
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_24
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    push dword ptr [ebp-80]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_26
    push 2
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lparse_asm_statement_27
.Lparse_asm_statement_26:
.Lparse_asm_statement_27:
    jmp .Lparse_asm_statement_20
    jmp .Lparse_asm_statement_25
.Lparse_asm_statement_24:
.Lparse_asm_statement_25:
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
.Lparse_asm_statement_28:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_29
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
    push eax
    lea eax, [ebp-112]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-112]
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
    mov [ebp-160], eax
    push 0
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_32
    push dword ptr [ebp-160]
    push 56
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_34
    push dword ptr [ebp-160]
    push 49
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
    jmp .Lparse_asm_statement_35
.Lparse_asm_statement_34:
    push 1
.Lparse_asm_statement_35:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_asm_statement_33
.Lparse_asm_statement_32:
    push 0
.Lparse_asm_statement_33:
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_30
    jmp .Lparse_asm_statement_29
    jmp .Lparse_asm_statement_31
.Lparse_asm_statement_30:
.Lparse_asm_statement_31:
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_36
    push dword ptr [ebp-96]
    push 2
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-192], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
.Lparse_asm_statement_38:
    push dword ptr [ebp-200]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_39
    push dword ptr [ebp-192]
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
    push dword ptr [ebp-88]
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
.Lparse_asm_statement_40:
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
    jmp .Lparse_asm_statement_38
.Lparse_asm_statement_39:
    push dword ptr [ebp-192]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-192]
    push dword ptr [ebp-96]
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
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lparse_asm_statement_37
.Lparse_asm_statement_36:
.Lparse_asm_statement_37:
    push dword ptr [ebp-160]
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_42
    push dword ptr [ebp-192]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_43
    push dword ptr [ebp-192]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_44
    push dword ptr [ebp-192]
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_45
    push dword ptr [ebp-192]
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_46
    push dword ptr [ebp-192]
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_47
    push dword ptr [ebp-192]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_48
    push dword ptr [ebp-192]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_49
    push dword ptr [ebp-192]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_50
    push dword ptr [ebp-192]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_51
    push dword ptr [ebp-192]
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_52
    push dword ptr [ebp-192]
    push 84
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_53
    push dword ptr [ebp-192]
    push 85
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_54
    push dword ptr [ebp-192]
    push 52
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_55
    push dword ptr [ebp-192]
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_56
    push dword ptr [ebp-192]
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_57
    push dword ptr [ebp-192]
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_asm_statement_58
    jmp .Lparse_asm_statement_59
.Lparse_asm_statement_42:
    lea eax, [ebp-112]
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
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_60
    lea eax, [ebp-112]
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
    jmp .Lparse_asm_statement_61
.Lparse_asm_statement_60:
    lea eax, [ark_str_62]
    push eax
.Lparse_asm_statement_61:
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 3
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-208], eax
    push 0
    pop eax
    mov [ebp-224], eax
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_asm_statement_62:
    push dword ptr [ebp-216]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_63
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-216]
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
.Lparse_asm_statement_64:
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    add esp, 4
    jmp .Lparse_asm_statement_62
.Lparse_asm_statement_63:
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 34
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_asm_statement_65:
    push dword ptr [ebp-216]
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_66
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-112]
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
    push dword ptr [ebp-216]
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
.Lparse_asm_statement_67:
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    add esp, 4
    jmp .Lparse_asm_statement_65
.Lparse_asm_statement_66:
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 34
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
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
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-224]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_43:
    lea eax, [ebp-112]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-200], eax
    push 0
    pop eax
    mov [ebp-208], eax
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-200]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_68
    push 1
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    jmp .Lparse_asm_statement_69
.Lparse_asm_statement_68:
    push dword ptr [ebp-200]
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
.Lparse_asm_statement_69:
    push dword ptr [ebp-224]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_70
    lea eax, [ebp-176]
    push eax
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lparse_asm_statement_71
.Lparse_asm_statement_70:
.Lparse_asm_statement_71:
.Lparse_asm_statement_72:
    push dword ptr [ebp-224]
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_73
    lea eax, [ebp-176]
    push eax
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    push dword ptr [ebp-224]
    push 10
    pop ecx
    pop eax
    xor edx, edx
    div ecx
    push edx
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-224]
    push 10
    pop ecx
    pop eax
    xor edx, edx
    div ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    jmp .Lparse_asm_statement_72
.Lparse_asm_statement_73:
    push dword ptr [ebp-96]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-208]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-232], eax
    push 0
    pop eax
    mov [ebp-248], eax
    push 0
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
.Lparse_asm_statement_74:
    push dword ptr [ebp-240]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_75
    push dword ptr [ebp-232]
    push dword ptr [ebp-248]
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-240]
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
.Lparse_asm_statement_76:
    push dword ptr [ebp-240]
    push dword ptr [ebp-240]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-240], eax
    add esp, 4
    jmp .Lparse_asm_statement_74
.Lparse_asm_statement_75:
    push dword ptr [ebp-208]
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_77
    push dword ptr [ebp-232]
    push dword ptr [ebp-248]
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 45
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lparse_asm_statement_78
.Lparse_asm_statement_77:
.Lparse_asm_statement_78:
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
.Lparse_asm_statement_79:
    push dword ptr [ebp-240]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_80
    push dword ptr [ebp-232]
    push dword ptr [ebp-248]
    push dword ptr [ebp-248]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-248], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-176]
    push eax
    push dword ptr [ebp-240]
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
.Lparse_asm_statement_81:
    push dword ptr [ebp-240]
    push dword ptr [ebp-240]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-240], eax
    add esp, 4
    jmp .Lparse_asm_statement_79
.Lparse_asm_statement_80:
    push dword ptr [ebp-232]
    push dword ptr [ebp-248]
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
    push dword ptr [ebp-232]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-248]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_44:
    lea eax, [ebp-112]
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
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_82
    lea eax, [ebp-112]
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
    jmp .Lparse_asm_statement_83
.Lparse_asm_statement_82:
    lea eax, [ark_str_63]
    push eax
.Lparse_asm_statement_83:
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_45:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    lea eax, [ark_str_64]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_46:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    lea eax, [ark_str_65]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_47:
    lea eax, [ark_str_66]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_48:
    lea eax, [ark_str_67]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_49:
    lea eax, [ark_str_68]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_50:
    lea eax, [ark_str_69]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_51:
    lea eax, [ark_str_70]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_52:
    lea eax, [ark_str_71]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_53:
    lea eax, [ark_str_72]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_54:
    lea eax, [ark_str_73]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_55:
    lea eax, [ark_str_74]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_56:
    lea eax, [ark_str_75]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_57:
    lea eax, [ark_str_76]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_58:
    lea eax, [ark_str_77]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_59:
    lea eax, [ark_str_78]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_41:
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_84
    push dword ptr [ebp-168]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-96]
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-208], eax
    push 0
    pop eax
    mov [ebp-224], eax
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_asm_statement_86:
    push dword ptr [ebp-216]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_87
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-216]
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
.Lparse_asm_statement_88:
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    add esp, 4
    jmp .Lparse_asm_statement_86
.Lparse_asm_statement_87:
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
.Lparse_asm_statement_89:
    push dword ptr [ebp-216]
    push dword ptr [ebp-200]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_90
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
    push dword ptr [ebp-216]
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
.Lparse_asm_statement_91:
    push dword ptr [ebp-216]
    push dword ptr [ebp-216]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-216], eax
    add esp, 4
    jmp .Lparse_asm_statement_89
.Lparse_asm_statement_90:
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
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
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-224]
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lparse_asm_statement_85
.Lparse_asm_statement_84:
.Lparse_asm_statement_85:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    jmp .Lparse_asm_statement_28
.Lparse_asm_statement_29:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_92
    push dword ptr [ebp-88]
    jmp .Lparse_asm_statement_93
.Lparse_asm_statement_92:
    lea eax, [ark_str_79]
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-256]
    push eax
.Lparse_asm_statement_93:
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_94
    jmp .Lparse_asm_statement_95
.Lparse_asm_statement_94:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_96
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_asm_statement_97
.Lparse_asm_statement_96:
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_98
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_asm_statement_99
.Lparse_asm_statement_98:
    push dword ptr [ebp-64]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lparse_asm_statement_99:
.Lparse_asm_statement_97:
.Lparse_asm_statement_95:
    jmp .Lparse_asm_statement_20
.Lparse_asm_statement_21:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_100
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    jmp .Lparse_asm_statement_101
.Lparse_asm_statement_100:
.Lparse_asm_statement_101:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_asm_statement_102
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    jmp .Lparse_asm_statement_103
.Lparse_asm_statement_102:
.Lparse_asm_statement_103:
    push dword ptr [ebp-64]
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

    .globl parse_declspec
parse_declspec:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 492
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_packed_ptr], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_mods_declspec], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_asm_fn], eax
    add esp, 4
.Lparse_declspec_0:
    lea eax, [ebp-136]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-136]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-136]
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
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_4
    push dword ptr [ebp-184]
    push 66
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_5
    push dword ptr [ebp-184]
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_6
    push dword ptr [ebp-184]
    push 68
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_7
    push dword ptr [ebp-184]
    push 69
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_8
    push dword ptr [ebp-184]
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_9
    push dword ptr [ebp-184]
    push 94
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_10
    push dword ptr [ebp-184]
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_11
    push dword ptr [ebp-184]
    push 71
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_12
    push dword ptr [ebp-184]
    push 72
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_13
    push dword ptr [ebp-184]
    push 73
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_14
    push dword ptr [ebp-184]
    push 77
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_15
    push dword ptr [ebp-184]
    push 61
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_16
    push dword ptr [ebp-184]
    push 62
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_17
    push dword ptr [ebp-184]
    push 60
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_18
    push dword ptr [ebp-184]
    push 111
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_19
    push dword ptr [ebp-184]
    push 102
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_20
    push dword ptr [ebp-184]
    push 110
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_21
    push dword ptr [ebp-184]
    push 109
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_22
    push dword ptr [ebp-184]
    push 108
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_23
    push dword ptr [ebp-184]
    push 107
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_24
    push dword ptr [ebp-184]
    push 118
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_25
    push dword ptr [ebp-184]
    push 104
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_26
    push dword ptr [ebp-184]
    push 105
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_27
    push dword ptr [ebp-184]
    push 101
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_28
    push dword ptr [ebp-184]
    push 116
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_29
    push dword ptr [ebp-184]
    push 115
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_30
    push dword ptr [ebp-184]
    push 117
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_31
    push dword ptr [ebp-184]
    push 114
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_32
    push dword ptr [ebp-184]
    push 112
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_33
    push dword ptr [ebp-184]
    push 113
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_34
    push dword ptr [ebp-184]
    push 91
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_35
    push dword ptr [ebp-184]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_36
    push dword ptr [ebp-184]
    push 93
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_37
    push dword ptr [ebp-184]
    push 97
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_38
    push dword ptr [ebp-184]
    push 98
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_39
    push dword ptr [ebp-184]
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_40
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_41
    push dword ptr [ebp-184]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_42
    push dword ptr [ebp-184]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_43
    push dword ptr [ebp-184]
    push 65
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_44
    push dword ptr [ebp-184]
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_45
    push dword ptr [ebp-184]
    push 64
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_46
    push dword ptr [ebp-184]
    push 100
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_47
    push dword ptr [ebp-184]
    push 74
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_48
    push dword ptr [ebp-184]
    push 75
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_49
    push dword ptr [ebp-184]
    push 76
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_50
    push dword ptr [ebp-184]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_51
    jmp .Lparse_declspec_52
.Lparse_declspec_4:
    push 0
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-240]
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_5:
.Lparse_declspec_6:
.Lparse_declspec_7:
.Lparse_declspec_8:
    lea eax, [ebp-136]
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
    push 66
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_53
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_const], eax
    add esp, 4
    jmp .Lparse_declspec_54
.Lparse_declspec_53:
.Lparse_declspec_54:
    lea eax, [ebp-136]
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
    push 67
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_55
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_volatile], eax
    add esp, 4
    jmp .Lparse_declspec_56
.Lparse_declspec_55:
.Lparse_declspec_56:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_9:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-240]
    push eax
    lea eax, [ebp-192]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-192]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call is_basic_type_token
    mov esp, [ebp-240]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_59
    lea eax, [ebp-192]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_61
    lea eax, [ebp-192]
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
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-240]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_62
.Lparse_declspec_61:
    push 0
.Lparse_declspec_62:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_60
.Lparse_declspec_59:
    push 1
.Lparse_declspec_60:
    pop eax
    test eax, eax
    jz .Lparse_declspec_57
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_asm_fn], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
    jmp .Lparse_declspec_58
.Lparse_declspec_57:
.Lparse_declspec_58:
    jmp .LN_parse_declspec_done
.Lparse_declspec_10:
    push 1
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_packed_ptr], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_11:
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_12:
    push dword ptr [ebp-72]
    push 2
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_13:
    push dword ptr [ebp-72]
    push 4
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_14:
    push dword ptr [ebp-72]
    push 8
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_15:
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_16:
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_17:
    push 2
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_18:
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_19:
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_20:
    push dword ptr [ebp-72]
    push 65536
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_21:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_63
    mov [ebp-240], esp
    and esp, -16
    call type_char
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_64
.Lparse_declspec_63:
.Lparse_declspec_64:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_22:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_65
    mov [ebp-240], esp
    and esp, -16
    call type_short
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_66
.Lparse_declspec_65:
.Lparse_declspec_66:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_23:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_67
    mov [ebp-240], esp
    and esp, -16
    call type_int
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_68
.Lparse_declspec_67:
.Lparse_declspec_68:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_24:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_69
    mov [ebp-240], esp
    and esp, -16
    call type_llong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_70
.Lparse_declspec_69:
.Lparse_declspec_70:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_25:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-240]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_71
    push 1
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
.Lparse_declspec_73:
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_75
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-240]
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
    jmp .Lparse_declspec_76
.Lparse_declspec_75:
    push 0
.Lparse_declspec_76:
    pop eax
    test eax, eax
    jz .Lparse_declspec_74
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-240]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_77
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
    jmp .Lparse_declspec_78
.Lparse_declspec_77:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-240]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_79
    push dword ptr [ebp-192]
    push dword ptr [ebp-192]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-192], eax
    add esp, 4
    jmp .Lparse_declspec_80
.Lparse_declspec_79:
.Lparse_declspec_80:
.Lparse_declspec_78:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    jmp .Lparse_declspec_73
.Lparse_declspec_74:
    jmp .Lparse_declspec_72
.Lparse_declspec_71:
.Lparse_declspec_72:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_26:
.Lparse_declspec_27:
.Lparse_declspec_28:
.Lparse_declspec_29:
.Lparse_declspec_30:
.Lparse_declspec_31:
.Lparse_declspec_32:
.Lparse_declspec_33:
.Lparse_declspec_34:
.Lparse_declspec_35:
.Lparse_declspec_36:
.Lparse_declspec_37:
.Lparse_declspec_38:
.Lparse_declspec_39:
    mov eax, [g_func_mods_declspec]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call parse_func_modifiers
    mov esp, [ebp-240]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_mods_declspec], eax
    add esp, 4
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_40:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_81
    mov [ebp-240], esp
    and esp, -16
    call type_short
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_82
.Lparse_declspec_81:
.Lparse_declspec_82:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_41:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_83
    mov [ebp-240], esp
    and esp, -16
    call type_int
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_84
.Lparse_declspec_83:
.Lparse_declspec_84:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_42:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_85
    mov [ebp-240], esp
    and esp, -16
    call type_char
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_86
.Lparse_declspec_85:
.Lparse_declspec_86:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_43:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_87
    mov [ebp-240], esp
    and esp, -16
    call type_void
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_88
.Lparse_declspec_87:
.Lparse_declspec_88:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_44:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_89
    mov [ebp-240], esp
    and esp, -16
    call type_bool
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_90
.Lparse_declspec_89:
.Lparse_declspec_90:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_45:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_91
    mov [ebp-240], esp
    and esp, -16
    call type_float
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_92
.Lparse_declspec_91:
.Lparse_declspec_92:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_46:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_93
    mov [ebp-240], esp
    and esp, -16
    call type_double
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_94
.Lparse_declspec_93:
.Lparse_declspec_94:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_47:
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
    pop eax
    test eax, eax
    jz .Lparse_declspec_95
    push 1
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_declspec_96
.Lparse_declspec_95:
.Lparse_declspec_96:
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_48:
.Lparse_declspec_49:
    lea eax, [ebp-136]
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
    push 75
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    mov [ebp-240], esp
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call parse_struct_or_union
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
    push dword ptr [ebp-200]
    pop eax
    test eax, eax
    jz .Lparse_declspec_97
    push dword ptr [ebp-200]
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
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_98
.Lparse_declspec_97:
.Lparse_declspec_98:
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Lparse_declspec_101
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_102
.Lparse_declspec_101:
    push 0
.Lparse_declspec_102:
    pop eax
    test eax, eax
    jz .Lparse_declspec_99
    push dword ptr [ebp-104]
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
    push 0
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lparse_declspec_100
.Lparse_declspec_99:
.Lparse_declspec_100:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_50:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call parse_enum
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    jz .Lparse_declspec_103
    push dword ptr [ebp-192]
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
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_104
.Lparse_declspec_103:
    mov [ebp-240], esp
    and esp, -16
    call type_int
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lparse_declspec_104:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
.Lparse_declspec_51:
    lea eax, [ebp-136]
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
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-240]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_105
    lea eax, [ebp-136]
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
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call sym_find_typedef
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-48]
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
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-240]
    push eax
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    jz .Lparse_declspec_109
    push dword ptr [ebp-192]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_110
.Lparse_declspec_109:
    push 0
.Lparse_declspec_110:
    pop eax
    test eax, eax
    jz .Lparse_declspec_107
    push dword ptr [ebp-192]
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
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_108
.Lparse_declspec_107:
    mov [ebp-240], esp
    and esp, -16
    call type_int
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lparse_declspec_108:
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    jmp .Lparse_declspec_2
    jmp .Lparse_declspec_106
.Lparse_declspec_105:
.Lparse_declspec_106:
    jmp .LN_parse_declspec_done
.Lparse_declspec_52:
    jmp .LN_parse_declspec_done
.Lparse_declspec_3:
.Lparse_declspec_2:
    jmp .Lparse_declspec_0
.Lparse_declspec_1:
.LN_parse_declspec_done:
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_111
    push dword ptr [ebp-96]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_113
    mov [ebp-240], esp
    and esp, -16
    call type_llong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_114
.Lparse_declspec_113:
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_115
    mov [ebp-240], esp
    and esp, -16
    call type_long
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_116
.Lparse_declspec_115:
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_117
    mov [ebp-240], esp
    and esp, -16
    call type_uint
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_118
.Lparse_declspec_117:
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    jz .Lparse_declspec_119
    mov [ebp-240], esp
    and esp, -16
    call type_int
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_120
.Lparse_declspec_119:
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_declspec_120:
.Lparse_declspec_118:
.Lparse_declspec_116:
.Lparse_declspec_114:
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_121
    push dword ptr [ebp-104]
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
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_124
    push dword ptr [ebp-184]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_125
    push dword ptr [ebp-184]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_126
    push dword ptr [ebp-184]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_127
    push dword ptr [ebp-184]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_128
    jmp .Lparse_declspec_129
.Lparse_declspec_124:
    mov [ebp-240], esp
    and esp, -16
    call type_uchar
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_123
.Lparse_declspec_125:
    mov [ebp-240], esp
    and esp, -16
    call type_ushort
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_123
.Lparse_declspec_126:
    mov [ebp-240], esp
    and esp, -16
    call type_uint
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_123
.Lparse_declspec_127:
    mov [ebp-240], esp
    and esp, -16
    call type_ulong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_123
.Lparse_declspec_128:
    mov [ebp-240], esp
    and esp, -16
    call type_ullong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_123
.Lparse_declspec_129:
    jmp .Lparse_declspec_123
.Lparse_declspec_123:
    jmp .Lparse_declspec_122
.Lparse_declspec_121:
.Lparse_declspec_122:
    jmp .Lparse_declspec_112
.Lparse_declspec_111:
    push dword ptr [ebp-96]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_132
    push dword ptr [ebp-104]
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
    push 3
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
    jmp .Lparse_declspec_133
.Lparse_declspec_132:
    push 0
.Lparse_declspec_133:
    pop eax
    test eax, eax
    jz .Lparse_declspec_130
    mov [ebp-240], esp
    and esp, -16
    call type_llong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_131
.Lparse_declspec_130:
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_136
    push dword ptr [ebp-104]
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
    push 3
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
    jmp .Lparse_declspec_137
.Lparse_declspec_136:
    push 0
.Lparse_declspec_137:
    pop eax
    test eax, eax
    jz .Lparse_declspec_134
    mov [ebp-240], esp
    and esp, -16
    call type_long
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_135
.Lparse_declspec_134:
.Lparse_declspec_135:
.Lparse_declspec_131:
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_138
    push dword ptr [ebp-104]
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
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_141
    push dword ptr [ebp-184]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_142
    push dword ptr [ebp-184]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_143
    push dword ptr [ebp-184]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_144
    push dword ptr [ebp-184]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_145
    jmp .Lparse_declspec_146
.Lparse_declspec_141:
    mov [ebp-240], esp
    and esp, -16
    call type_uchar
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_140
.Lparse_declspec_142:
    mov [ebp-240], esp
    and esp, -16
    call type_ushort
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_140
.Lparse_declspec_143:
    mov [ebp-240], esp
    and esp, -16
    call type_uint
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_140
.Lparse_declspec_144:
    mov [ebp-240], esp
    and esp, -16
    call type_ulong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_140
.Lparse_declspec_145:
    mov [ebp-240], esp
    and esp, -16
    call type_ullong
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_140
.Lparse_declspec_146:
    jmp .Lparse_declspec_140
.Lparse_declspec_140:
    jmp .Lparse_declspec_139
.Lparse_declspec_138:
.Lparse_declspec_139:
.Lparse_declspec_112:
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_declspec_147
    push dword ptr [ebp-56]
    push dword ptr [ebp-72]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_declspec_148
.Lparse_declspec_147:
.Lparse_declspec_148:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_declspec_149
    push dword ptr [ebp-64]
    push dword ptr [ebp-80]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_declspec_150
.Lparse_declspec_149:
.Lparse_declspec_150:
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lparse_declspec_153
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_154
.Lparse_declspec_153:
    push 0
.Lparse_declspec_154:
    pop eax
    test eax, eax
    jz .Lparse_declspec_151
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_157
    push dword ptr [ebp-104]
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
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declspec_159
    push dword ptr [ebp-104]
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
    push 8
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
    jmp .Lparse_declspec_160
.Lparse_declspec_159:
    push 0
.Lparse_declspec_160:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_158
.Lparse_declspec_157:
    push 1
.Lparse_declspec_158:
    pop eax
    test eax, eax
    jz .Lparse_declspec_155
    mov [ebp-240], esp
    and esp, -16
    call type_double
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_156
.Lparse_declspec_155:
.Lparse_declspec_156:
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-256], eax
    mov [ebp-240], esp
    push dword ptr [ebp-256]
    and esp, -16
    call type_complex
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_152
.Lparse_declspec_151:
.Lparse_declspec_152:
    mov eax, [g_decl_is_volatile]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_declspec_163
    mov eax, [g_decl_is_const]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declspec_164
.Lparse_declspec_163:
    push 1
.Lparse_declspec_164:
    pop eax
    test eax, eax
    jz .Lparse_declspec_161
    mov eax, [g_decl_is_const]
    push eax
    mov eax, [g_decl_is_volatile]
    push eax
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-256], eax
    pop eax
    mov [ebp-260], eax
    pop eax
    mov [ebp-264], eax
    mov [ebp-240], esp
    push dword ptr [ebp-264]
    push dword ptr [ebp-260]
    push dword ptr [ebp-256]
    and esp, -16
    call type_qualified
    mov esp, [ebp-240]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    jmp .Lparse_declspec_162
.Lparse_declspec_161:
.Lparse_declspec_162:
    push dword ptr [ebp-104]
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

    .globl parse_struct_or_union
parse_struct_or_union:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 460
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
.Lparse_struct_or_union_0:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_1
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_2
    push dword ptr [ebp-56]
    push 0
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call type_struct
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    jmp .Lparse_struct_or_union_3
.Lparse_struct_or_union_2:
.Lparse_struct_or_union_3:
    push dword ptr [ebp-80]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-208]
    push 1
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_struct_or_union_0
.Lparse_struct_or_union_1:
    lea eax, [ebp-96]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
    push eax
    lea eax, [ebp-96]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-96]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_4
    lea eax, [ebp-96]
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
    pop eax
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call sym_find_tag
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_6
    push dword ptr [ebp-152]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lparse_struct_or_union_7
.Lparse_struct_or_union_6:
.Lparse_struct_or_union_7:
    jmp .Lparse_struct_or_union_5
.Lparse_struct_or_union_4:
.Lparse_struct_or_union_5:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_8
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_10
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call type_struct
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_12
    push 0
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_14
    push 7
    jmp .Lparse_struct_or_union_15
.Lparse_struct_or_union_14:
    push 6
.Lparse_struct_or_union_15:
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    pop eax
    mov [ebp-236], eax
    mov [ebp-208], esp
    push dword ptr [ebp-236]
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call sym_add
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lparse_struct_or_union_13
.Lparse_struct_or_union_12:
.Lparse_struct_or_union_13:
    jmp .Lparse_struct_or_union_11
.Lparse_struct_or_union_10:
.Lparse_struct_or_union_11:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_18
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_struct_or_union_19
.Lparse_struct_or_union_18:
    push 0
.Lparse_struct_or_union_19:
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_16
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_20
    push dword ptr [ebp-72]
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
    jmp .Lparse_struct_or_union_21
.Lparse_struct_or_union_20:
.Lparse_struct_or_union_21:
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_22
    push dword ptr [ebp-72]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_struct_or_union_23
.Lparse_struct_or_union_22:
.Lparse_struct_or_union_23:
    jmp .Lparse_struct_or_union_17
.Lparse_struct_or_union_16:
.Lparse_struct_or_union_17:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
.Lparse_struct_or_union_24:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_26
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    jmp .Lparse_struct_or_union_27
.Lparse_struct_or_union_26:
    push 0
.Lparse_struct_or_union_27:
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_25
    push 0
    pop eax
    mov [ebp-152], eax
    push 0
    pop eax
    mov [ebp-160], eax
    lea eax, [ebp-160]
    push eax
    lea eax, [ebp-152]
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
    call parse_declspec
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_28
    lea eax, [ark_str_80]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call perror_at
    mov esp, [ebp-208]
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_24
    jmp .Lparse_struct_or_union_29
.Lparse_struct_or_union_28:
.Lparse_struct_or_union_29:
.Lparse_struct_or_union_30:
    push 0
    pop eax
    mov [ebp-176], eax
    lea eax, [ebp-176]
    push eax
    push dword ptr [ebp-168]
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
    call parse_declarator
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-184], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 56
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_33
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_35
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_36
.Lparse_struct_or_union_35:
.Lparse_struct_or_union_36:
    jmp .Lparse_struct_or_union_34
.Lparse_struct_or_union_33:
.Lparse_struct_or_union_34:
.Lparse_struct_or_union_37:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_38
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-208]
    jmp .Lparse_struct_or_union_37
.Lparse_struct_or_union_38:
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_39
    push dword ptr [ebp-192]
    push dword ptr [ebp-184]
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_41
    push dword ptr [ebp-176]
    jmp .Lparse_struct_or_union_42
.Lparse_struct_or_union_41:
    lea eax, [ark_str_81]
    push eax
.Lparse_struct_or_union_42:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    pop eax
    mov [ebp-236], eax
    mov [ebp-208], esp
    push dword ptr [ebp-236]
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call type_struct_add_bitfield
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_40
.Lparse_struct_or_union_39:
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_43
    push dword ptr [ebp-184]
    push dword ptr [ebp-176]
    push dword ptr [ebp-72]
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
    call type_struct_add_field
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_44
.Lparse_struct_or_union_43:
    push dword ptr [ebp-184]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_47
    push dword ptr [ebp-184]
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
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_struct_or_union_49
    push dword ptr [ebp-184]
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
    push 12
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
    jmp .Lparse_struct_or_union_50
.Lparse_struct_or_union_49:
    push 1
.Lparse_struct_or_union_50:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_struct_or_union_48
.Lparse_struct_or_union_47:
    push 0
.Lparse_struct_or_union_48:
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_45
    push dword ptr [ebp-184]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call type_struct_add_anonymous
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_46
.Lparse_struct_or_union_45:
.Lparse_struct_or_union_46:
.Lparse_struct_or_union_44:
.Lparse_struct_or_union_40:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_51
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-208]
    push eax
    jmp .Lparse_struct_or_union_32
    jmp .Lparse_struct_or_union_52
.Lparse_struct_or_union_51:
.Lparse_struct_or_union_52:
    jmp .Lparse_struct_or_union_31
.Lparse_struct_or_union_32:
    jmp .Lparse_struct_or_union_30
.Lparse_struct_or_union_31:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-208]
    push eax
    add esp, 4
    jmp .Lparse_struct_or_union_24
.Lparse_struct_or_union_25:
    push 51
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-208]
    push eax
    add esp, 4
.Lparse_struct_or_union_53:
    push dword ptr [ebp-48]
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
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-208]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_54
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-208]
    jmp .Lparse_struct_or_union_53
.Lparse_struct_or_union_54:
    jmp .Lparse_struct_or_union_9
.Lparse_struct_or_union_8:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_55
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call type_struct
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_59
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_struct_or_union_60
.Lparse_struct_or_union_59:
    push 0
.Lparse_struct_or_union_60:
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_57
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_61
    push dword ptr [ebp-72]
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
    jmp .Lparse_struct_or_union_62
.Lparse_struct_or_union_61:
.Lparse_struct_or_union_62:
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_63
    push dword ptr [ebp-72]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_struct_or_union_64
.Lparse_struct_or_union_63:
.Lparse_struct_or_union_64:
    jmp .Lparse_struct_or_union_58
.Lparse_struct_or_union_57:
.Lparse_struct_or_union_58:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_65
    push 0
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_67
    push 7
    jmp .Lparse_struct_or_union_68
.Lparse_struct_or_union_67:
    push 6
.Lparse_struct_or_union_68:
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    pop eax
    mov [ebp-232], eax
    pop eax
    mov [ebp-236], eax
    mov [ebp-208], esp
    push dword ptr [ebp-236]
    push dword ptr [ebp-232]
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call sym_add
    mov esp, [ebp-208]
    push eax
    add esp, 4
    jmp .Lparse_struct_or_union_66
.Lparse_struct_or_union_65:
.Lparse_struct_or_union_66:
    jmp .Lparse_struct_or_union_56
.Lparse_struct_or_union_55:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_71
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_struct_or_union_72
.Lparse_struct_or_union_71:
    push 0
.Lparse_struct_or_union_72:
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_69
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_73
    push dword ptr [ebp-72]
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
    jmp .Lparse_struct_or_union_74
.Lparse_struct_or_union_73:
.Lparse_struct_or_union_74:
    push dword ptr [ebp-80]
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
    pop eax
    test eax, eax
    jz .Lparse_struct_or_union_75
    push dword ptr [ebp-72]
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-80]
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
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_struct_or_union_76
.Lparse_struct_or_union_75:
.Lparse_struct_or_union_76:
    jmp .Lparse_struct_or_union_70
.Lparse_struct_or_union_69:
.Lparse_struct_or_union_70:
.Lparse_struct_or_union_56:
.Lparse_struct_or_union_9:
    push dword ptr [ebp-144]
    push 3
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call ast_new
    mov esp, [ebp-208]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    push 4
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
    push dword ptr [ebp-152]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-152]
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

    .globl parse_enum
parse_enum:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_0
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_enum_1
.Lparse_enum_0:
.Lparse_enum_1:
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_enum
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
    push dword ptr [ebp-56]
    pop eax
    test eax, eax
    jz .Lparse_enum_2
    push 0
    push dword ptr [ebp-64]
    push dword ptr [ebp-56]
    push 8
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    pop eax
    mov [ebp-188], eax
    mov [ebp-160], esp
    push dword ptr [ebp-188]
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call sym_add
    mov esp, [ebp-160]
    push eax
    add esp, 4
    jmp .Lparse_enum_3
.Lparse_enum_2:
.Lparse_enum_3:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_4
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
.Lparse_enum_6:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_8
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    jmp .Lparse_enum_9
.Lparse_enum_8:
    push 0
.Lparse_enum_9:
    pop eax
    test eax, eax
    jz .Lparse_enum_7
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
    push eax
    lea eax, [ebp-88]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-88]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_10
    lea eax, [ark_str_82]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call perror_at
    mov esp, [ebp-160]
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_enum_6
    jmp .Lparse_enum_11
.Lparse_enum_10:
.Lparse_enum_11:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_12
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call parse_cond_expr
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-136], eax
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    jz .Lparse_enum_16
    lea eax, [ebp-144]
    push eax
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call eval_const_expr
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_enum_17
.Lparse_enum_16:
    push 0
.Lparse_enum_17:
    pop eax
    test eax, eax
    jz .Lparse_enum_14
    push dword ptr [ebp-144]
    add esp, 4
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lparse_enum_15
.Lparse_enum_14:
    lea eax, [ark_str_83]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call perror_at
    mov esp, [ebp-160]
.Lparse_enum_15:
    jmp .Lparse_enum_13
.Lparse_enum_12:
.Lparse_enum_13:
    push 0
    mov [ebp-160], esp
    and esp, -16
    call type_int
    mov esp, [ebp-160]
    push eax
    lea eax, [ebp-88]
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
    push 5
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    pop eax
    mov [ebp-188], eax
    mov [ebp-160], esp
    push dword ptr [ebp-188]
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call sym_add
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
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
    push dword ptr [ebp-72]
    push dword ptr [ebp-72]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-72], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_enum_18
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_enum_19
.Lparse_enum_18:
.Lparse_enum_19:
    jmp .Lparse_enum_6
.Lparse_enum_7:
    push 51
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-160]
    push eax
    add esp, 4
    jmp .Lparse_enum_5
.Lparse_enum_4:
.Lparse_enum_5:
    push dword ptr [ebp-80]
    push 3
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ast_new
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
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

    .globl parse_declarator
parse_declarator:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-72], eax
.Lparse_declarator_0:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_1
    push 0
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    lea eax, [ebp-88]
    push eax
    lea eax, [ebp-80]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    mov [ebp-160], esp
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call skip_qualifiers
    mov esp, [ebp-160]
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_pointer
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-80]
    pop eax
    test eax, eax
    jz .Lparse_declarator_2
    push dword ptr [ebp-72]
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
    jmp .Lparse_declarator_3
.Lparse_declarator_2:
.Lparse_declarator_3:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    jz .Lparse_declarator_4
    push dword ptr [ebp-72]
    push 52
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
    jmp .Lparse_declarator_5
.Lparse_declarator_4:
.Lparse_declarator_5:
    mov eax, [g_decl_packed_ptr]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_6
    push dword ptr [ebp-72]
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
    jmp .Lparse_declarator_7
.Lparse_declarator_6:
.Lparse_declarator_7:
    jmp .Lparse_declarator_0
.Lparse_declarator_1:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_10
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-160]
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
    push 17
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
    jmp .Lparse_declarator_11
.Lparse_declarator_10:
    push 0
.Lparse_declarator_11:
    pop eax
    test eax, eax
    jz .Lparse_declarator_8
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
.Lparse_declarator_12:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_13
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_12
.Lparse_declarator_13:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_14
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_declarator_16
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_declarator_17
.Lparse_declarator_16:
.Lparse_declarator_17:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_15
.Lparse_declarator_14:
.Lparse_declarator_15:
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-160]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_18
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push 1
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lparse_declarator_20:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_22
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    jmp .Lparse_declarator_23
.Lparse_declarator_22:
    push 0
.Lparse_declarator_23:
    pop eax
    test eax, eax
    jz .Lparse_declarator_21
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_24
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lparse_declarator_25
.Lparse_declarator_24:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_26
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lparse_declarator_27
.Lparse_declarator_26:
.Lparse_declarator_27:
.Lparse_declarator_25:
    push dword ptr [ebp-80]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_28
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_29
.Lparse_declarator_28:
.Lparse_declarator_29:
    jmp .Lparse_declarator_20
.Lparse_declarator_21:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_30
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_31
.Lparse_declarator_30:
.Lparse_declarator_31:
    jmp .Lparse_declarator_19
.Lparse_declarator_18:
.Lparse_declarator_19:
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_pointer
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_declarator_9
.Lparse_declarator_8:
.Lparse_declarator_9:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_32
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_declarator_34
    push dword ptr [ebp-64]
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-160]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_declarator_35
.Lparse_declarator_34:
.Lparse_declarator_35:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_33
.Lparse_declarator_32:
.Lparse_declarator_33:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_36
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_38
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
.Lparse_declarator_40:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_42
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    jmp .Lparse_declarator_43
.Lparse_declarator_42:
    push 0
.Lparse_declarator_43:
    pop eax
    test eax, eax
    jz .Lparse_declarator_41
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_40
.Lparse_declarator_41:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_44
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_45
.Lparse_declarator_44:
.Lparse_declarator_45:
    jmp .Lparse_declarator_39
.Lparse_declarator_38:
.Lparse_declarator_39:
    jmp .Lparse_declarator_37
.Lparse_declarator_36:
.Lparse_declarator_37:
    push 0
    pop eax
    mov [ebp-112], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-120], eax
.Lparse_declarator_46:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 52
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_47
    push 0
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 70
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_48
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push 1
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_declarator_49
.Lparse_declarator_48:
.Lparse_declarator_49:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_50
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_declarator_51
.Lparse_declarator_50:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_52
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_declarator_53
.Lparse_declarator_52:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call parse_cond_expr
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-144], eax
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lparse_declarator_58
    lea eax, [ebp-152]
    push eax
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call eval_const_expr
    mov esp, [ebp-160]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declarator_59
.Lparse_declarator_58:
    push 0
.Lparse_declarator_59:
    pop eax
    test eax, eax
    jz .Lparse_declarator_56
    push dword ptr [ebp-152]
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_declarator_57
.Lparse_declarator_56:
    push 0
.Lparse_declarator_57:
    pop eax
    test eax, eax
    jz .Lparse_declarator_54
    push dword ptr [ebp-152]
    add esp, 4
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_declarator_55
.Lparse_declarator_54:
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
    pop eax
    test eax, eax
    jz .Lparse_declarator_66
    push dword ptr [ebp-120]
    push 0
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
    jmp .Lparse_declarator_67
.Lparse_declarator_66:
    push 0
.Lparse_declarator_67:
    pop eax
    test eax, eax
    jz .Lparse_declarator_64
    mov eax, [g_vla_size_expr]
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
    jmp .Lparse_declarator_65
.Lparse_declarator_64:
    push 0
.Lparse_declarator_65:
    pop eax
    test eax, eax
    jz .Lparse_declarator_62
    push dword ptr [ebp-136]
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
    jmp .Lparse_declarator_63
.Lparse_declarator_62:
    push 0
.Lparse_declarator_63:
    pop eax
    test eax, eax
    jz .Lparse_declarator_60
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-144]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_vla_size_expr], eax
    add esp, 4
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_declarator_61
.Lparse_declarator_60:
    push 1
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lparse_declarator_61:
.Lparse_declarator_55:
.Lparse_declarator_53:
.Lparse_declarator_51:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 53
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_68
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_declarator_69
.Lparse_declarator_68:
.Lparse_declarator_69:
    push dword ptr [ebp-112]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_70
    lea eax, [ebp-80]
    push eax
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_declarator_71
.Lparse_declarator_70:
.Lparse_declarator_71:
    jmp .Lparse_declarator_46
.Lparse_declarator_47:
    push dword ptr [ebp-112]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_72
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
.Lparse_declarator_74:
    push dword ptr [ebp-128]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_declarator_75
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
    jz .Lparse_declarator_77
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call type_pointer
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-72]
    push 44
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
    jmp .Lparse_declarator_78
.Lparse_declarator_77:
    lea eax, [ebp-80]
    push eax
    push dword ptr [ebp-128]
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
    push dword ptr [ebp-72]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call type_array
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
.Lparse_declarator_78:
.Lparse_declarator_76:
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    add esp, 4
    jmp .Lparse_declarator_74
.Lparse_declarator_75:
    jmp .Lparse_declarator_73
.Lparse_declarator_72:
.Lparse_declarator_73:
    push dword ptr [ebp-72]
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

    .globl parse_at_keyword
parse_at_keyword:
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
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 96
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_at_keyword_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_at_keyword_1
.Lparse_at_keyword_0:
.Lparse_at_keyword_1:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_at_keyword_2
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_at_keyword_4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_at_addr], eax
    add esp, 4
    push 1
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_has_at], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_at_keyword_5
.Lparse_at_keyword_4:
.Lparse_at_keyword_5:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_at_keyword_6
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_at_keyword_7
.Lparse_at_keyword_6:
.Lparse_at_keyword_7:
    jmp .Lparse_at_keyword_3
.Lparse_at_keyword_2:
.Lparse_at_keyword_3:
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

    .globl parse_global_reg
parse_global_reg:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 103
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_global_reg_0
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_global_reg_1
.Lparse_global_reg_0:
.Lparse_global_reg_1:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_global_reg_2
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_global_reg_4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_global_reg_5
.Lparse_global_reg_4:
.Lparse_global_reg_5:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_global_reg_6
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_global_reg_7
.Lparse_global_reg_6:
.Lparse_global_reg_7:
    jmp .Lparse_global_reg_3
.Lparse_global_reg_2:
.Lparse_global_reg_3:
    push dword ptr [ebp-56]
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

    .globl parse_smc
parse_smc:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 106
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_smc_0
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_smc_1
.Lparse_smc_0:
.Lparse_smc_1:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_smc_2
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_smc_4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_smc_5
.Lparse_smc_4:
.Lparse_smc_5:
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-64]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_smc_6
    push dword ptr [ebp-48]
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
    mov [ebp-80], eax
    mov [ebp-64], esp
    push dword ptr [ebp-80]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-64]
    push eax
    jmp .Lparse_smc_7
.Lparse_smc_6:
.Lparse_smc_7:
    jmp .Lparse_smc_3
.Lparse_smc_2:
.Lparse_smc_3:
    push dword ptr [ebp-56]
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

    .globl parse_top_decl
parse_top_decl:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 620
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push 0
    pop eax
    mov [ebp-96], eax
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-144], eax
    push 0
    pop eax
    mov [ebp-152], eax
    push 0
    pop eax
    mov [ebp-160], eax
    push 0
    pop eax
    mov [ebp-168], eax
    push 0
    pop eax
    mov [ebp-176], eax
    push 0
    pop eax
    mov [ebp-184], eax
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_weak], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_naked], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_irq], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_const], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_volatile], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_used], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_unused], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_alias_target], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_align_bytes], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_align_bytes], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_softfp], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_forceinline], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_has_at], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_at_addr], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_constructor], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_destructor], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_deprecated], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_packed_ptr], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_vla_size_expr], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_value_in_regs], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_pure], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_const_attr], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_interwork], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_func_is_deprecated_kw], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_0
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-368]
    push eax
    lea eax, [ebp-192]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-192]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call is_basic_type_token
    mov esp, [ebp-368]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_4
    lea eax, [ebp-192]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_6
    lea eax, [ebp-192]
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
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-368]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_7
.Lparse_top_decl_6:
    push 0
.Lparse_top_decl_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_5
.Lparse_top_decl_4:
    push 1
.Lparse_top_decl_5:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_2
    push 1
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_3
.Lparse_top_decl_2:
.Lparse_top_decl_3:
    jmp .Lparse_top_decl_1
.Lparse_top_decl_0:
.Lparse_top_decl_1:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_8
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_10
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_12
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_13
.Lparse_top_decl_12:
.Lparse_top_decl_13:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_14
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_15
.Lparse_top_decl_14:
.Lparse_top_decl_15:
    jmp .Lparse_top_decl_11
.Lparse_top_decl_10:
.Lparse_top_decl_11:
    jmp .Lparse_top_decl_9
.Lparse_top_decl_8:
.Lparse_top_decl_9:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 96
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_16
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_at_keyword
    mov esp, [ebp-368]
    jmp .Lparse_top_decl_17
.Lparse_top_decl_16:
.Lparse_top_decl_17:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 103
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_18
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_global_reg
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lparse_top_decl_19
.Lparse_top_decl_18:
.Lparse_top_decl_19:
    push dword ptr [ebp-88]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_func_modifiers
    mov esp, [ebp-368]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    lea eax, [ebp-64]
    push eax
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-88]
    mov eax, [g_func_mods_declspec]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-112]
    mov eax, [g_decl_is_asm_fn]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    mov eax, [g_decl_is_const]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    mov eax, [g_attr_section]
    push eax
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
    mov eax, [g_attr_align_bytes]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_22
    push dword ptr [ebp-120]
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
    jmp .Lparse_top_decl_23
.Lparse_top_decl_22:
    push 0
.Lparse_top_decl_23:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_20
    mov eax, [g_attr_align_bytes]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lparse_top_decl_21
.Lparse_top_decl_20:
.Lparse_top_decl_21:
    push dword ptr [ebp-56]
    push 65536
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_24
    push 1
    jmp .Lparse_top_decl_25
.Lparse_top_decl_24:
    push 0
.Lparse_top_decl_25:
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 103
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_28
    push dword ptr [ebp-144]
    push 0
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
    jmp .Lparse_top_decl_29
.Lparse_top_decl_28:
    push 0
.Lparse_top_decl_29:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_26
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_global_reg
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    jmp .Lparse_top_decl_27
.Lparse_top_decl_26:
.Lparse_top_decl_27:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_30
    lea eax, [ark_str_84]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call perror_at
    mov esp, [ebp-368]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_31
.Lparse_top_decl_30:
.Lparse_top_decl_31:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_32
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-80]
    push 4
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_new
    mov esp, [ebp-368]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_33
.Lparse_top_decl_32:
.Lparse_top_decl_33:
    push 0
    pop eax
    mov [ebp-192], eax
    push 0
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-88]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_func_modifiers
    mov esp, [ebp-368]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 90
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_34
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_svc
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-200], eax
    push dword ptr [ebp-200]
    add esp, 4
    jmp .Lparse_top_decl_35
.Lparse_top_decl_34:
.Lparse_top_decl_35:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 106
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_36
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_smc
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_top_decl_37
.Lparse_top_decl_36:
.Lparse_top_decl_37:
    push dword ptr [ebp-88]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_func_modifiers
    mov esp, [ebp-368]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    mov eax, [g_func_is_value_in_regs]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    mov eax, [g_func_is_pure]
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    mov eax, [g_func_is_const_attr]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    mov eax, [g_func_is_interwork]
    push eax
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    mov eax, [g_func_is_deprecated_kw]
    push eax
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    lea eax, [ebp-192]
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_38
    lea eax, [ark_str_85]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call perror_at
    mov esp, [ebp-368]
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_39
.Lparse_top_decl_38:
.Lparse_top_decl_39:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_40
    push 0
    pop eax
    mov [ebp-216], eax
    push 0
    pop eax
    mov [ebp-224], eax
    push 0
    pop eax
    mov [ebp-232], eax
    push 0
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-248], eax
    push 0
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_44
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-368]
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
    push 49
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
    jmp .Lparse_top_decl_45
.Lparse_top_decl_44:
    push 0
.Lparse_top_decl_45:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_42
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_43
.Lparse_top_decl_42:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_46
.Lparse_top_decl_48:
    push 0
    pop eax
    mov [ebp-264], eax
    push 0
    pop eax
    mov [ebp-272], eax
    push 0
    pop eax
    mov [ebp-296], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 86
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_51
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push 1
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
    jmp .Lparse_top_decl_49
    jmp .Lparse_top_decl_52
.Lparse_top_decl_51:
.Lparse_top_decl_52:
    lea eax, [ebp-272]
    push eax
    lea eax, [ebp-264]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-280], eax
    push dword ptr [ebp-280]
    add esp, 4
    push dword ptr [ebp-280]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_53
    lea eax, [ark_str_86]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call perror_at
    mov esp, [ebp-368]
    jmp .Lparse_top_decl_49
    jmp .Lparse_top_decl_54
.Lparse_top_decl_53:
.Lparse_top_decl_54:
    lea eax, [ebp-296]
    push eax
    push dword ptr [ebp-280]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
    push dword ptr [ebp-288]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_57
    push dword ptr [ebp-288]
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
    jmp .Lparse_top_decl_58
.Lparse_top_decl_57:
    push 0
.Lparse_top_decl_58:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_55
    push dword ptr [ebp-288]
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
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call type_pointer
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
    jmp .Lparse_top_decl_56
.Lparse_top_decl_55:
.Lparse_top_decl_56:
    push dword ptr [ebp-296]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_59
    lea eax, [ark_str_87]
    push eax
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-296], eax
    push dword ptr [ebp-296]
    add esp, 4
    jmp .Lparse_top_decl_60
.Lparse_top_decl_59:
.Lparse_top_decl_60:
    push dword ptr [ebp-80]
    push 0
    push dword ptr [ebp-288]
    push dword ptr [ebp-296]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_var_decl
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-304], eax
    push dword ptr [ebp-224]
    push dword ptr [ebp-232]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_61
    push dword ptr [ebp-232]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_63
    push dword ptr [ebp-232]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lparse_top_decl_64
.Lparse_top_decl_63:
    push 4
.Lparse_top_decl_64:
    pop eax
    mov [ebp-312], eax
    push dword ptr [ebp-312]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-232]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-216]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    push dword ptr [ebp-312]
    pop eax
    mov [ebp-232], eax
    push dword ptr [ebp-232]
    add esp, 4
    jmp .Lparse_top_decl_62
.Lparse_top_decl_61:
.Lparse_top_decl_62:
    push dword ptr [ebp-216]
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-304]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_65
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_50
    jmp .Lparse_top_decl_66
.Lparse_top_decl_65:
.Lparse_top_decl_66:
    jmp .Lparse_top_decl_49
.Lparse_top_decl_50:
    jmp .Lparse_top_decl_48
.Lparse_top_decl_49:
    jmp .Lparse_top_decl_47
.Lparse_top_decl_46:
.Lparse_top_decl_47:
.Lparse_top_decl_43:
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-368]
    push eax
    add esp, 4
.Lparse_top_decl_67:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_68
    push dword ptr [ebp-248]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-368]
    jmp .Lparse_top_decl_67
.Lparse_top_decl_68:
    push dword ptr [ebp-88]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_func_modifiers
    mov esp, [ebp-368]
    push eax
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    mov eax, [g_attr_is_irq]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_69
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_top_decl_70
.Lparse_top_decl_69:
.Lparse_top_decl_70:
    mov eax, [g_attr_is_weak]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_71
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_top_decl_72
.Lparse_top_decl_71:
.Lparse_top_decl_72:
    mov eax, [g_attr_is_naked]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_73
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_top_decl_74
.Lparse_top_decl_73:
.Lparse_top_decl_74:
    mov eax, [g_func_is_value_in_regs]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_75
    push 1
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lparse_top_decl_76
.Lparse_top_decl_75:
.Lparse_top_decl_76:
    mov eax, [g_func_is_pure]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_77
    push 1
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
    jmp .Lparse_top_decl_78
.Lparse_top_decl_77:
.Lparse_top_decl_78:
    mov eax, [g_func_is_const_attr]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_79
    push 1
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    jmp .Lparse_top_decl_80
.Lparse_top_decl_79:
.Lparse_top_decl_80:
    mov eax, [g_func_is_interwork]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_81
    push 1
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lparse_top_decl_82
.Lparse_top_decl_81:
.Lparse_top_decl_82:
    mov eax, [g_func_is_deprecated_kw]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_83
    push 1
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
    jmp .Lparse_top_decl_84
.Lparse_top_decl_83:
.Lparse_top_decl_84:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_85
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-80]
    push 0
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    push dword ptr [ebp-248]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    pop eax
    mov [ebp-400], eax
    pop eax
    mov [ebp-404], eax
    mov [ebp-368], esp
    push dword ptr [ebp-404]
    push dword ptr [ebp-400]
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_func_def
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-264], eax
    push dword ptr [ebp-264]
    add esp, 4
    push dword ptr [ebp-264]
    push 0
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
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-240]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_87
    push 1
    jmp .Lparse_top_decl_88
.Lparse_top_decl_87:
    push 0
.Lparse_top_decl_88:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_89
    push 1
    jmp .Lparse_top_decl_90
.Lparse_top_decl_89:
    push 0
.Lparse_top_decl_90:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_91
    push 1
    jmp .Lparse_top_decl_92
.Lparse_top_decl_91:
    push 0
.Lparse_top_decl_92:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_93
    push 1
    jmp .Lparse_top_decl_94
.Lparse_top_decl_93:
    push 0
.Lparse_top_decl_94:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 68
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_97
    mov eax, [g_attr_is_softfp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_98
.Lparse_top_decl_97:
    push 1
.Lparse_top_decl_98:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_95
    push 1
    jmp .Lparse_top_decl_96
.Lparse_top_decl_95:
    push 0
.Lparse_top_decl_96:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 16
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_101
    mov eax, [g_attr_is_forceinline]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_102
.Lparse_top_decl_101:
    push 1
.Lparse_top_decl_102:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_99
    push 1
    jmp .Lparse_top_decl_100
.Lparse_top_decl_99:
    push 0
.Lparse_top_decl_100:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_used]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_unused]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_alias_target]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 72
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_constructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 76
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_destructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_deprecated]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 96
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 104
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 108
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 112
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
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
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_86
.Lparse_top_decl_85:
.Lparse_top_decl_86:
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_103
    push 0
    pop eax
    mov [ebp-272], eax
    push 0
    pop eax
    mov [ebp-280], eax
    push 0
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_105
    lea eax, [ark_str_88]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call perror_at
    mov esp, [ebp-368]
    jmp .Lparse_top_decl_106
.Lparse_top_decl_105:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
    push eax
    lea eax, [ebp-296]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-296]
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
    pop eax
    test eax, eax
    jz .Lparse_top_decl_107
    lea eax, [ebp-296]
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
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    jmp .Lparse_top_decl_108
.Lparse_top_decl_107:
    push 0
.Lparse_top_decl_108:
    pop eax
    mov [ebp-272], eax
    push dword ptr [ebp-272]
    add esp, 4
    push 0
    pop eax
    mov [ebp-344], eax
.Lparse_top_decl_109:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    mov [ebp-352], eax
    push dword ptr [ebp-352]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_112
    jmp .Lparse_top_decl_110
    jmp .Lparse_top_decl_113
.Lparse_top_decl_112:
.Lparse_top_decl_113:
    push dword ptr [ebp-352]
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_114
    push dword ptr [ebp-344]
    push dword ptr [ebp-344]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-344], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_111
    jmp .Lparse_top_decl_115
.Lparse_top_decl_114:
.Lparse_top_decl_115:
    push dword ptr [ebp-352]
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_116
    push dword ptr [ebp-344]
    push dword ptr [ebp-344]
    push -1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-344], eax
    add esp, 4
    push dword ptr [ebp-344]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_118
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    pop eax
    mov [ebp-280], eax
    push dword ptr [ebp-280]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_110
    jmp .Lparse_top_decl_119
.Lparse_top_decl_118:
.Lparse_top_decl_119:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    jmp .Lparse_top_decl_111
    jmp .Lparse_top_decl_117
.Lparse_top_decl_116:
.Lparse_top_decl_117:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
.Lparse_top_decl_111:
    jmp .Lparse_top_decl_109
.Lparse_top_decl_110:
    push dword ptr [ebp-272]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_124
    push dword ptr [ebp-280]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_125
.Lparse_top_decl_124:
    push 0
.Lparse_top_decl_125:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_122
    push dword ptr [ebp-280]
    push dword ptr [ebp-272]
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
    jmp .Lparse_top_decl_123
.Lparse_top_decl_122:
    push 0
.Lparse_top_decl_123:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_120
    push dword ptr [ebp-280]
    push dword ptr [ebp-272]
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-344], eax
    push dword ptr [ebp-344]
    push dword ptr [ebp-272]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call mem_strndup
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
    jmp .Lparse_top_decl_121
.Lparse_top_decl_120:
    lea eax, [ark_str_89]
    push eax
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-288]
    add esp, 4
.Lparse_top_decl_121:
.Lparse_top_decl_106:
    push dword ptr [ebp-80]
    push 0
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    push dword ptr [ebp-248]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    pop eax
    mov [ebp-400], eax
    pop eax
    mov [ebp-404], eax
    mov [ebp-368], esp
    push dword ptr [ebp-404]
    push dword ptr [ebp-400]
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_func_def
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-264], eax
    push dword ptr [ebp-264]
    add esp, 4
    push dword ptr [ebp-264]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 36
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-240]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_126
    push 1
    jmp .Lparse_top_decl_127
.Lparse_top_decl_126:
    push 0
.Lparse_top_decl_127:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 88
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-288]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_used]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_unused]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_alias_target]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 72
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_constructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 76
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_destructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_deprecated]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 96
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 104
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 108
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 112
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
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
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_104
.Lparse_top_decl_103:
.Lparse_top_decl_104:
    push dword ptr [ebp-192]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_current_func_name], eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_block
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-256]
    add esp, 4
    push dword ptr [ebp-80]
    push dword ptr [ebp-256]
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    push dword ptr [ebp-248]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    pop eax
    mov [ebp-400], eax
    pop eax
    mov [ebp-404], eax
    mov [ebp-368], esp
    push dword ptr [ebp-404]
    push dword ptr [ebp-400]
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_func_def
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-264], eax
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-240]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_128
    push 1
    jmp .Lparse_top_decl_129
.Lparse_top_decl_128:
    push 0
.Lparse_top_decl_129:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-200]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_130
    push 1
    jmp .Lparse_top_decl_131
.Lparse_top_decl_130:
    push 0
.Lparse_top_decl_131:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 2
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_132
    push 1
    jmp .Lparse_top_decl_133
.Lparse_top_decl_132:
    push 0
.Lparse_top_decl_133:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_134
    push 1
    jmp .Lparse_top_decl_135
.Lparse_top_decl_134:
    push 0
.Lparse_top_decl_135:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 68
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 8
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_138
    mov eax, [g_attr_is_softfp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_139
.Lparse_top_decl_138:
    push 1
.Lparse_top_decl_139:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_136
    push 1
    jmp .Lparse_top_decl_137
.Lparse_top_decl_136:
    push 0
.Lparse_top_decl_137:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-88]
    push 16
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_142
    mov eax, [g_attr_is_forceinline]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_top_decl_143
.Lparse_top_decl_142:
    push 1
.Lparse_top_decl_143:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_140
    push 1
    jmp .Lparse_top_decl_141
.Lparse_top_decl_140:
    push 0
.Lparse_top_decl_141:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 52
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_used]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_unused]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 84
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_alias_target]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 72
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_constructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 76
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_destructor]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_deprecated]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 92
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 96
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 100
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-168]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 104
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-176]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 108
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 112
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-264]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 80
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
    push dword ptr [ebp-184]
    pop ecx
    pop eax
    or eax, ecx
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_current_func_name], eax
    add esp, 4
    push dword ptr [ebp-264]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_41
.Lparse_top_decl_40:
.Lparse_top_decl_41:
    push dword ptr [ebp-64]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_144
    push 0
    push dword ptr [ebp-208]
    push dword ptr [ebp-192]
    push 4
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call sym_add
    mov esp, [ebp-368]
    push eax
    add esp, 4
.Lparse_top_decl_146:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_147
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    lea eax, [ebp-216]
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    add esp, 4
    push dword ptr [ebp-216]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_148
    push 0
    push dword ptr [ebp-208]
    push dword ptr [ebp-216]
    push 4
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call sym_add
    mov esp, [ebp-368]
    push eax
    add esp, 4
    jmp .Lparse_top_decl_149
.Lparse_top_decl_148:
.Lparse_top_decl_149:
    jmp .Lparse_top_decl_146
.Lparse_top_decl_147:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-368]
    push eax
    add esp, 4
    push dword ptr [ebp-80]
    push 31
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_new
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-192]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-216]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-208]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-216]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_top_decl_145
.Lparse_top_decl_144:
.Lparse_top_decl_145:
    push 0
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-96]
    pop eax
    mov [ebp-232], eax
.Lparse_top_decl_150:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_top_decl_152
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 96
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
    jmp .Lparse_top_decl_153
.Lparse_top_decl_152:
    push 1
.Lparse_top_decl_153:
    pop eax
    test eax, eax
    jz .Lparse_top_decl_151
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 96
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_154
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_at_keyword
    mov esp, [ebp-368]
    jmp .Lparse_top_decl_155
.Lparse_top_decl_154:
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    push dword ptr [ebp-208]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-368]
    mov eax, [g_attr_section]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_156
    mov eax, [g_attr_section]
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
    jmp .Lparse_top_decl_157
.Lparse_top_decl_156:
.Lparse_top_decl_157:
.Lparse_top_decl_155:
    jmp .Lparse_top_decl_150
.Lparse_top_decl_151:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_158
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_initializer
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-216]
    add esp, 4
    jmp .Lparse_top_decl_159
.Lparse_top_decl_158:
.Lparse_top_decl_159:
    push dword ptr [ebp-216]
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call infer_array_size_from_init
    mov esp, [ebp-368]
    push 0
    push dword ptr [ebp-208]
    push dword ptr [ebp-192]
    push 0
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call sym_add
    mov esp, [ebp-368]
    push eax
    add esp, 4
    push dword ptr [ebp-80]
    push dword ptr [ebp-216]
    push dword ptr [ebp-208]
    push dword ptr [ebp-192]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_var_decl
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_160
    push 1
    jmp .Lparse_top_decl_161
.Lparse_top_decl_160:
    push 0
.Lparse_top_decl_161:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_162
    push 1
    jmp .Lparse_top_decl_163
.Lparse_top_decl_162:
    push 0
.Lparse_top_decl_163:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-232]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-224]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_164
    push dword ptr [ebp-120]
    jmp .Lparse_top_decl_165
.Lparse_top_decl_164:
    mov eax, [g_attr_align_bytes]
    push eax
.Lparse_top_decl_165:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_used]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_unused]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 36
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_has_at]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 32
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_at_addr]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 60
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 64
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-144]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lparse_top_decl_166:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_167
    push 0
    pop eax
    mov [ebp-248], eax
    push 0
    pop eax
    mov [ebp-264], eax
    push 0
    pop eax
    mov [ebp-272], eax
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    lea eax, [ebp-248]
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    mov [ebp-368], esp
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-256], eax
    push dword ptr [ebp-256]
    add esp, 4
.Lparse_top_decl_168:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_169
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    push dword ptr [ebp-256]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-368]
    mov eax, [g_attr_section]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_170
    mov eax, [g_attr_section]
    push eax
    pop eax
    mov [ebp-272], eax
    push dword ptr [ebp-272]
    add esp, 4
    jmp .Lparse_top_decl_171
.Lparse_top_decl_170:
.Lparse_top_decl_171:
    jmp .Lparse_top_decl_168
.Lparse_top_decl_169:
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-368]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_172
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call parse_initializer
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-264], eax
    push dword ptr [ebp-264]
    add esp, 4
    jmp .Lparse_top_decl_173
.Lparse_top_decl_172:
.Lparse_top_decl_173:
    push dword ptr [ebp-264]
    push dword ptr [ebp-256]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call infer_array_size_from_init
    mov esp, [ebp-368]
    push dword ptr [ebp-248]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_174
    push 0
    push dword ptr [ebp-256]
    push dword ptr [ebp-248]
    push 0
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call sym_add
    mov esp, [ebp-368]
    push eax
    add esp, 4
    jmp .Lparse_top_decl_175
.Lparse_top_decl_174:
.Lparse_top_decl_175:
    push dword ptr [ebp-248]
    pop eax
    test eax, eax
    jz .Lparse_top_decl_176
    push dword ptr [ebp-80]
    push dword ptr [ebp-264]
    push dword ptr [ebp-256]
    push dword ptr [ebp-248]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    pop eax
    mov [ebp-392], eax
    pop eax
    mov [ebp-396], eax
    mov [ebp-368], esp
    push dword ptr [ebp-396]
    push dword ptr [ebp-392]
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call ast_var_decl
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-280], eax
    push dword ptr [ebp-280]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-280]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_178
    push 1
    jmp .Lparse_top_decl_179
.Lparse_top_decl_178:
    push 0
.Lparse_top_decl_179:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-280]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    push 2
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_180
    push 1
    jmp .Lparse_top_decl_181
.Lparse_top_decl_180:
    push 0
.Lparse_top_decl_181:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-280]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-232]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-280]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-272]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-240]
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
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_top_decl_182
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-384], eax
    mov [ebp-368], esp
    push dword ptr [ebp-384]
    and esp, -16
    call ast_block
    mov esp, [ebp-368]
    push eax
    pop eax
    mov [ebp-288], eax
    push dword ptr [ebp-240]
    push dword ptr [ebp-288]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-280]
    push dword ptr [ebp-288]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-368]
    push eax
    push dword ptr [ebp-288]
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
    jmp .Lparse_top_decl_183
.Lparse_top_decl_182:
    push dword ptr [ebp-280]
    push dword ptr [ebp-240]
    pop eax
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-368]
    push eax
.Lparse_top_decl_183:
    jmp .Lparse_top_decl_177
.Lparse_top_decl_176:
.Lparse_top_decl_177:
    jmp .Lparse_top_decl_166
.Lparse_top_decl_167:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-384], eax
    pop eax
    mov [ebp-388], eax
    mov [ebp-368], esp
    push dword ptr [ebp-388]
    push dword ptr [ebp-384]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-368]
    push eax
    add esp, 4
    push dword ptr [ebp-240]
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

    .globl parse_block
parse_block:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-80]
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
    pop eax
    mov [ebp-56], eax
    push 50
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-80]
    push eax
    add esp, 4
    mov [ebp-80], esp
    and esp, -16
    call sym_enter_scope
    mov esp, [ebp-80]
    push eax
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call ast_block
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    add esp, 4
.Lparse_block_0:
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-80]
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
    push 51
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_block_2
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-80]
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
    jmp .Lparse_block_3
.Lparse_block_2:
    push 0
.Lparse_block_3:
    pop eax
    test eax, eax
    jz .Lparse_block_1
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-96], eax
    mov [ebp-80], esp
    push dword ptr [ebp-96]
    and esp, -16
    call parse_statement
    mov esp, [ebp-80]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lparse_block_4
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-80]
    push eax
    jmp .Lparse_block_5
.Lparse_block_4:
.Lparse_block_5:
    jmp .Lparse_block_0
.Lparse_block_1:
    mov [ebp-80], esp
    and esp, -16
    call sym_leave_scope
    mov esp, [ebp-80]
    push eax
    push 51
    push dword ptr [ebp-48]
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
    mov [ebp-96], eax
    pop eax
    mov [ebp-100], eax
    mov [ebp-80], esp
    push dword ptr [ebp-100]
    push dword ptr [ebp-96]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-80]
    push eax
    add esp, 4
    push dword ptr [ebp-64]
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

    .globl parse_local_var_decl
parse_local_var_decl:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 412
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    mov eax, [ebp+20]
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    pop eax
    mov [ebp-80], eax
    push 0
    pop eax
    mov [ebp-88], eax
    mov eax, [g_decl_is_const]
    push eax
    pop eax
    mov [ebp-96], eax
.Lparse_local_var_decl_0:
    push 0
    pop eax
    mov [ebp-104], eax
    lea eax, [ebp-104]
    push eax
    push dword ptr [ebp-56]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    mov [ebp-160], esp
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-104]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_3
    lea eax, [ark_str_90]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call perror_at
    mov esp, [ebp-160]
    jmp .Lparse_local_var_decl_1
    jmp .Lparse_local_var_decl_4
.Lparse_local_var_decl_3:
.Lparse_local_var_decl_4:
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_5
    push 0
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push 4
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    pop eax
    mov [ebp-188], eax
    mov [ebp-160], esp
    push dword ptr [ebp-188]
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call sym_add
    mov esp, [ebp-160]
    push eax
    add esp, 4
    jmp .Lparse_local_var_decl_6
.Lparse_local_var_decl_5:
.Lparse_local_var_decl_6:
.Lparse_local_var_decl_7:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 87
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_8
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call parse_attribute
    mov esp, [ebp-160]
    mov eax, [g_attr_section]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_9
    mov eax, [g_attr_section]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_local_var_decl_10
.Lparse_local_var_decl_9:
.Lparse_local_var_decl_10:
    jmp .Lparse_local_var_decl_7
.Lparse_local_var_decl_8:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_11
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call parse_initializer
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lparse_local_var_decl_12
.Lparse_local_var_decl_11:
.Lparse_local_var_decl_12:
    push dword ptr [ebp-120]
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call infer_array_size_from_init
    mov esp, [ebp-160]
    push dword ptr [ebp-80]
    push dword ptr [ebp-120]
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    pop eax
    mov [ebp-188], eax
    mov [ebp-160], esp
    push dword ptr [ebp-188]
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call ast_var_decl
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_15
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_local_var_decl_16
.Lparse_local_var_decl_15:
    push 0
.Lparse_local_var_decl_16:
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_13
    push 0
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push 0
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    pop eax
    mov [ebp-184], eax
    pop eax
    mov [ebp-188], eax
    mov [ebp-160], esp
    push dword ptr [ebp-188]
    push dword ptr [ebp-184]
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call sym_add
    mov esp, [ebp-160]
    push eax
    add esp, 4
    jmp .Lparse_local_var_decl_14
.Lparse_local_var_decl_13:
.Lparse_local_var_decl_14:
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_17
    push 1
    jmp .Lparse_local_var_decl_18
.Lparse_local_var_decl_17:
    push 0
.Lparse_local_var_decl_18:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 2
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_19
    push 1
    jmp .Lparse_local_var_decl_20
.Lparse_local_var_decl_19:
    push 0
.Lparse_local_var_decl_20:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-96]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 40
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_align_bytes]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 44
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_used]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 48
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_attr_is_unused]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 60
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    push 65536
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_21
    push 1
    jmp .Lparse_local_var_decl_22
.Lparse_local_var_decl_21:
    push 0
.Lparse_local_var_decl_22:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    mov eax, [g_vla_size_expr]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_25
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_local_var_decl_26
.Lparse_local_var_decl_25:
    push 0
.Lparse_local_var_decl_26:
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_23
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 52
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
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 56
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov eax, [g_vla_size_expr]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_vla_size_expr], eax
    add esp, 4
    jmp .Lparse_local_var_decl_24
.Lparse_local_var_decl_23:
.Lparse_local_var_decl_24:
    push dword ptr [ebp-88]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_27
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_local_var_decl_28
.Lparse_local_var_decl_27:
    push dword ptr [ebp-88]
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
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_29
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call ast_block
    mov esp, [ebp-160]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-88]
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-136]
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-160]
    push eax
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    jmp .Lparse_local_var_decl_30
.Lparse_local_var_decl_29:
    push dword ptr [ebp-136]
    push dword ptr [ebp-88]
    pop eax
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call block_add_stmt
    mov esp, [ebp-160]
    push eax
.Lparse_local_var_decl_30:
.Lparse_local_var_decl_28:
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-160]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_local_var_decl_31
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    mov [ebp-160], esp
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-160]
    push eax
    jmp .Lparse_local_var_decl_2
    jmp .Lparse_local_var_decl_32
.Lparse_local_var_decl_31:
.Lparse_local_var_decl_32:
    jmp .Lparse_local_var_decl_1
.Lparse_local_var_decl_2:
    jmp .Lparse_local_var_decl_0
.Lparse_local_var_decl_1:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-176], eax
    pop eax
    mov [ebp-180], eax
    mov [ebp-160], esp
    push dword ptr [ebp-180]
    push dword ptr [ebp-176]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-160]
    push eax
    add esp, 4
    push dword ptr [ebp-88]
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

    .globl parse_statement
parse_statement:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-104], eax
    lea eax, [ebp-56]
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
    push 88
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_0
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_asm_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_statement_1
.Lparse_statement_0:
.Lparse_statement_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call is_decl_start
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 95
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
    jmp .Lparse_statement_5
.Lparse_statement_4:
    push 1
.Lparse_statement_5:
    pop eax
    test eax, eax
    jz .Lparse_statement_2
    push 0
    pop eax
    mov [ebp-112], eax
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_const], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_volatile], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_align_bytes], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_used], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_is_unused], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_packed_ptr], eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 95
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_6
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_8
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_10
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    jmp .Lparse_statement_11
.Lparse_statement_10:
.Lparse_statement_11:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_12
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    jmp .Lparse_statement_13
.Lparse_statement_12:
.Lparse_statement_13:
    jmp .Lparse_statement_9
.Lparse_statement_8:
.Lparse_statement_9:
    jmp .Lparse_statement_7
.Lparse_statement_6:
.Lparse_statement_7:
    lea eax, [ebp-120]
    push eax
    lea eax, [ebp-112]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    jz .Lparse_statement_16
    mov eax, [g_attr_align_bytes]
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
    jmp .Lparse_statement_17
.Lparse_statement_16:
    push 0
.Lparse_statement_17:
    pop eax
    test eax, eax
    jz .Lparse_statement_14
    push dword ptr [ebp-136]
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_align_bytes], eax
    add esp, 4
    jmp .Lparse_statement_15
.Lparse_statement_14:
.Lparse_statement_15:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_18
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push 4
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_statement_19
.Lparse_statement_18:
.Lparse_statement_19:
    push dword ptr [ebp-120]
    push dword ptr [ebp-112]
    push dword ptr [ebp-128]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_local_var_decl
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_statement_3
.Lparse_statement_2:
.Lparse_statement_3:
    lea eax, [ebp-56]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_22
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-176]
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
    push 56
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
    jmp .Lparse_statement_23
.Lparse_statement_22:
    push 0
.Lparse_statement_23:
    pop eax
    test eax, eax
    jz .Lparse_statement_20
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-104]
    push 29
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-112]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_statement_21
.Lparse_statement_20:
.Lparse_statement_21:
    lea eax, [ebp-56]
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
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_25
    push dword ptr [ebp-112]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_26
    push dword ptr [ebp-112]
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_27
    push dword ptr [ebp-112]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_28
    push dword ptr [ebp-112]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_29
    push dword ptr [ebp-112]
    push 79
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_30
    push dword ptr [ebp-112]
    push 80
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_31
    push dword ptr [ebp-112]
    push 81
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_32
    push dword ptr [ebp-112]
    push 82
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_33
    push dword ptr [ebp-112]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_34
    push dword ptr [ebp-112]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_35
    push dword ptr [ebp-112]
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_36
    push dword ptr [ebp-112]
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_statement_37
    jmp .Lparse_statement_38
.Lparse_statement_25:
    push 0
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_39
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lparse_statement_40
.Lparse_statement_39:
.Lparse_statement_40:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 5
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-128]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_26:
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 48
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_41
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_statement_42
.Lparse_statement_41:
.Lparse_statement_42:
    push dword ptr [ebp-104]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_if
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_27:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 48
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-104]
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_while
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_28:
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 48
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    mov [ebp-176], esp
    and esp, -16
    call sym_enter_scope
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_43
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call is_decl_start
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_45
    push 0
    pop eax
    mov [ebp-152], eax
    push 0
    pop eax
    mov [ebp-160], eax
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_const], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_decl_is_volatile], eax
    add esp, 4
    push 0
    mov eax, [esp]
    push eax
    pop eax
    mov [g_attr_section], eax
    add esp, 4
    lea eax, [ebp-160]
    push eax
    lea eax, [ebp-152]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    add esp, 4
    push dword ptr [ebp-160]
    push dword ptr [ebp-152]
    push dword ptr [ebp-168]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_local_var_decl
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .LN_parse_statement_for_have_init_semi
    jmp .Lparse_statement_46
.Lparse_statement_45:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
.Lparse_statement_46:
    jmp .Lparse_statement_44
.Lparse_statement_43:
.Lparse_statement_44:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
.LN_parse_statement_for_have_init_semi:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 54
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_47
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_statement_48
.Lparse_statement_47:
.Lparse_statement_48:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_49
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_statement_50
.Lparse_statement_49:
.Lparse_statement_50:
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    mov [ebp-176], esp
    and esp, -16
    call sym_leave_scope
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push dword ptr [ebp-144]
    push dword ptr [ebp-136]
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    pop eax
    mov [ebp-208], eax
    mov [ebp-176], esp
    push dword ptr [ebp-208]
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_for
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_29:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 7
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push 48
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 9
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_30:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 48
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-104]
    push 25
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
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
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-136]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_31:
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cond_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lparse_statement_51
    lea eax, [ebp-136]
    push eax
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call eval_const_expr
    mov esp, [ebp-176]
    push eax
    add esp, 4
    jmp .Lparse_statement_52
.Lparse_statement_51:
.Lparse_statement_52:
    push 56
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 26
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_32:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 56
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 27
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_statement
    mov esp, [ebp-176]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_33:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-128]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-128]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_53
    lea eax, [ark_str_91]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call perror_at
    mov esp, [ebp-176]
    jmp .Lparse_statement_54
.Lparse_statement_53:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
.Lparse_statement_54:
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 28
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-128]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_statement_55
    lea eax, [ebp-128]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-176]
    push eax
    jmp .Lparse_statement_56
.Lparse_statement_55:
    lea eax, [ark_str_92]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-176]
    push eax
.Lparse_statement_56:
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-120]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_34:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 10
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_35:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 11
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_36:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_block
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_37:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push 4
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_38:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push 54
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push 20
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-128]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_statement_24:
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

    .globl parse_expr
parse_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_assign_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_expr_0:
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_assign_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push dword ptr [ebp-64]
    push 30
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-80]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 55
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_expr_0
.Lparse_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_assign_expr
parse_assign_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 380
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call parse_cond_expr
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-128]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
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
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_20
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
    push 36
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
    jmp .Lparse_assign_expr_21
.Lparse_assign_expr_20:
    push 1
.Lparse_assign_expr_21:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_18
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
    push 37
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
    jmp .Lparse_assign_expr_19
.Lparse_assign_expr_18:
    push 1
.Lparse_assign_expr_19:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_16
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
    push 38
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
    jmp .Lparse_assign_expr_17
.Lparse_assign_expr_16:
    push 1
.Lparse_assign_expr_17:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_14
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
    push 39
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
    jmp .Lparse_assign_expr_15
.Lparse_assign_expr_14:
    push 1
.Lparse_assign_expr_15:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_12
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
    push 40
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
    jmp .Lparse_assign_expr_13
.Lparse_assign_expr_12:
    push 1
.Lparse_assign_expr_13:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_10
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
    push 41
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
    jmp .Lparse_assign_expr_11
.Lparse_assign_expr_10:
    push 1
.Lparse_assign_expr_11:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_8
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
    push 42
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
    jmp .Lparse_assign_expr_9
.Lparse_assign_expr_8:
    push 1
.Lparse_assign_expr_9:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_6
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
    push 43
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
    jmp .Lparse_assign_expr_7
.Lparse_assign_expr_6:
    push 1
.Lparse_assign_expr_7:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_4
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
    push 44
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
    jmp .Lparse_assign_expr_5
.Lparse_assign_expr_4:
    push 1
.Lparse_assign_expr_5:
    pop eax
    test eax, eax
    jnz .Lparse_assign_expr_2
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
    jmp .Lparse_assign_expr_3
.Lparse_assign_expr_2:
    push 1
.Lparse_assign_expr_3:
    pop eax
    test eax, eax
    jz .Lparse_assign_expr_0
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
    mov [ebp-112], eax
    push dword ptr [ebp-48]
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
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-128]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-144], eax
    mov [ebp-128], esp
    push dword ptr [ebp-144]
    and esp, -16
    call parse_assign_expr
    mov esp, [ebp-128]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    lea eax, [ebp-64]
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
    push dword ptr [ebp-120]
    push dword ptr [ebp-56]
    push dword ptr [ebp-112]
    pop eax
    mov [ebp-144], eax
    pop eax
    mov [ebp-148], eax
    pop eax
    mov [ebp-152], eax
    pop eax
    mov [ebp-156], eax
    mov [ebp-128], esp
    push dword ptr [ebp-156]
    push dword ptr [ebp-152]
    push dword ptr [ebp-148]
    push dword ptr [ebp-144]
    and esp, -16
    call ast_assign
    mov esp, [ebp-128]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_assign_expr_1
.Lparse_assign_expr_0:
.Lparse_assign_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_cond_expr
parse_cond_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_or_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_cond_expr_0
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-64], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    push 56
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-96]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_cond_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-64]
    push 14
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    mov [ebp-96], esp
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_new
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-56]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
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
    push dword ptr [ebp-88]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-88]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_cond_expr_1
.Lparse_cond_expr_0:
.Lparse_cond_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_or_expr
parse_or_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_and_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_or_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_or_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 28
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_or_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_and_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_or_expr_3
.Lparse_or_expr_2:
    jmp .Lparse_or_expr_1
.Lparse_or_expr_3:
    jmp .Lparse_or_expr_0
.Lparse_or_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_and_expr
parse_and_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitor_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_and_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_and_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 27
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_and_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitor_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_and_expr_3
.Lparse_and_expr_2:
    jmp .Lparse_and_expr_1
.Lparse_and_expr_3:
    jmp .Lparse_and_expr_0
.Lparse_and_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_bitor_expr
parse_bitor_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitxor_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_bitor_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_bitor_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bitor_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitxor_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_bitor_expr_3
.Lparse_bitor_expr_2:
    jmp .Lparse_bitor_expr_1
.Lparse_bitor_expr_3:
    jmp .Lparse_bitor_expr_0
.Lparse_bitor_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_bitxor_expr
parse_bitxor_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitand_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_bitxor_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_bitxor_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bitxor_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_bitand_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_bitxor_expr_3
.Lparse_bitxor_expr_2:
    jmp .Lparse_bitxor_expr_1
.Lparse_bitxor_expr_3:
    jmp .Lparse_bitxor_expr_0
.Lparse_bitxor_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_bitand_expr
parse_bitand_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_eq_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_bitand_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_bitand_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_bitand_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_eq_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_bitand_expr_3
.Lparse_bitand_expr_2:
    jmp .Lparse_bitand_expr_1
.Lparse_bitand_expr_3:
    jmp .Lparse_bitand_expr_0
.Lparse_bitand_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_eq_expr
parse_eq_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_rel_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_eq_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_eq_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_eq_expr_4
    push dword ptr [ebp-64]
    push 22
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
    jmp .Lparse_eq_expr_5
.Lparse_eq_expr_4:
    push 1
.Lparse_eq_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_eq_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_rel_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_eq_expr_3
.Lparse_eq_expr_2:
    jmp .Lparse_eq_expr_1
.Lparse_eq_expr_3:
    jmp .Lparse_eq_expr_0
.Lparse_eq_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_rel_expr
parse_rel_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_shift_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_rel_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_rel_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_rel_expr_8
    push dword ptr [ebp-64]
    push 24
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
    jmp .Lparse_rel_expr_9
.Lparse_rel_expr_8:
    push 1
.Lparse_rel_expr_9:
    pop eax
    test eax, eax
    jnz .Lparse_rel_expr_6
    push dword ptr [ebp-64]
    push 25
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
    jmp .Lparse_rel_expr_7
.Lparse_rel_expr_6:
    push 1
.Lparse_rel_expr_7:
    pop eax
    test eax, eax
    jnz .Lparse_rel_expr_4
    push dword ptr [ebp-64]
    push 26
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
    jmp .Lparse_rel_expr_5
.Lparse_rel_expr_4:
    push 1
.Lparse_rel_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_rel_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_shift_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_rel_expr_3
.Lparse_rel_expr_2:
    jmp .Lparse_rel_expr_1
.Lparse_rel_expr_3:
    jmp .Lparse_rel_expr_0
.Lparse_rel_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_shift_expr
parse_shift_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_add_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_shift_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_shift_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_shift_expr_4
    push dword ptr [ebp-64]
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
    jmp .Lparse_shift_expr_5
.Lparse_shift_expr_4:
    push 1
.Lparse_shift_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_shift_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_add_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_shift_expr_3
.Lparse_shift_expr_2:
    jmp .Lparse_shift_expr_1
.Lparse_shift_expr_3:
    jmp .Lparse_shift_expr_0
.Lparse_shift_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_add_expr
parse_add_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_mul_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_add_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_add_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_add_expr_4
    push dword ptr [ebp-64]
    push 16
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
    jmp .Lparse_add_expr_5
.Lparse_add_expr_4:
    push 1
.Lparse_add_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_add_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_mul_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_add_expr_3
.Lparse_add_expr_2:
    jmp .Lparse_add_expr_1
.Lparse_add_expr_3:
    jmp .Lparse_add_expr_0
.Lparse_add_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_mul_expr
parse_mul_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_mul_expr_0:
    push 1
    pop eax
    test eax, eax
    jz .Lparse_mul_expr_1
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    mov [ebp-64], eax
    push dword ptr [ebp-64]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_mul_expr_6
    push dword ptr [ebp-64]
    push 18
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
    jmp .Lparse_mul_expr_7
.Lparse_mul_expr_6:
    push 1
.Lparse_mul_expr_7:
    pop eax
    test eax, eax
    jnz .Lparse_mul_expr_4
    push dword ptr [ebp-64]
    push 19
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
    jmp .Lparse_mul_expr_5
.Lparse_mul_expr_4:
    push 1
.Lparse_mul_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_mul_expr_2
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-96]
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
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-48]
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
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-96]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-72]
    push dword ptr [ebp-80]
    push dword ptr [ebp-56]
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    pop eax
    mov [ebp-124], eax
    mov [ebp-96], esp
    push dword ptr [ebp-124]
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call ast_binary
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_mul_expr_3
.Lparse_mul_expr_2:
    jmp .Lparse_mul_expr_1
.Lparse_mul_expr_3:
    jmp .Lparse_mul_expr_0
.Lparse_mul_expr_1:
    push dword ptr [ebp-56]
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

    .globl type_size_of_token
type_size_of_token:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push 0
    pop eax
    mov [ebp-56], eax
    push 0
    pop eax
    mov [ebp-64], eax
    lea eax, [ebp-64]
    push eax
    lea eax, [ebp-56]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    mov [ebp-96], esp
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-72]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Ltype_size_of_token_0
    push 4
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Ltype_size_of_token_1
.Ltype_size_of_token_0:
.Ltype_size_of_token_1:
    lea eax, [ebp-88]
    push eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    pop eax
    mov [ebp-116], eax
    pop eax
    mov [ebp-120], eax
    mov [ebp-96], esp
    push dword ptr [ebp-120]
    push dword ptr [ebp-116]
    push dword ptr [ebp-112]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
    push dword ptr [ebp-88]
    add esp, 4
    push dword ptr [ebp-80]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call type_size
    mov esp, [ebp-96]
    push eax
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

    .globl parse_cast_expr
parse_cast_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_cast_expr_0
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-56]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call is_basic_type_token
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_cast_expr_4
    lea eax, [ebp-56]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_cast_expr_6
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_cast_expr_7
.Lparse_cast_expr_6:
    push 0
.Lparse_cast_expr_7:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_cast_expr_5
.Lparse_cast_expr_4:
    push 1
.Lparse_cast_expr_5:
    pop eax
    test eax, eax
    jz .Lparse_cast_expr_2
    push 0
    pop eax
    mov [ebp-104], eax
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-112]
    push eax
    lea eax, [ebp-104]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_declspec
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    lea eax, [ebp-144]
    push eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call parse_declarator
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 50
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_cast_expr_8
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_init_list
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-120]
    push 35
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_new
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-168], eax
    push dword ptr [ebp-168]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-168]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-136]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-168]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-160]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-168]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_cast_expr_9
.Lparse_cast_expr_8:
.Lparse_cast_expr_9:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    push dword ptr [ebp-120]
    push dword ptr [ebp-152]
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_cast
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_cast_expr_3
.Lparse_cast_expr_2:
.Lparse_cast_expr_3:
    jmp .Lparse_cast_expr_1
.Lparse_cast_expr_0:
.Lparse_cast_expr_1:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_unary_expr
    mov esp, [ebp-176]
    push eax
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

    .globl parse_unary_expr
parse_unary_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-104], eax
    lea eax, [ebp-56]
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
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_1
    push dword ptr [ebp-112]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_2
    push dword ptr [ebp-112]
    push 29
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_3
    push dword ptr [ebp-112]
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_4
    push dword ptr [ebp-112]
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_5
    push dword ptr [ebp-112]
    push 47
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_6
    push dword ptr [ebp-112]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_7
    push dword ptr [ebp-112]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_8
    push dword ptr [ebp-112]
    push 78
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_9
    jmp .Lparse_unary_expr_10
.Lparse_unary_expr_1:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_2:
.Lparse_unary_expr_3:
.Lparse_unary_expr_4:
.Lparse_unary_expr_5:
.Lparse_unary_expr_6:
    lea eax, [ebp-56]
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
    mov [ebp-120], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_unary
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_7:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-176]
    push eax
    push 17
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_unary
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_8:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-104]
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_cast_expr
    mov esp, [ebp-176]
    push eax
    push 30
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_unary
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_9:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_11
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek2
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-128]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-128]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call is_basic_type_token
    mov esp, [ebp-176]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_unary_expr_15
    lea eax, [ebp-128]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_17
    lea eax, [ebp-128]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sym_is_typedef
    mov esp, [ebp-176]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_unary_expr_18
.Lparse_unary_expr_17:
    push 0
.Lparse_unary_expr_18:
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_unary_expr_16
.Lparse_unary_expr_15:
    push 1
.Lparse_unary_expr_16:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_13
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size_of_token
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-104]
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_sizeof_val
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_unary_expr_14
.Lparse_unary_expr_13:
.Lparse_unary_expr_14:
    jmp .Lparse_unary_expr_12
.Lparse_unary_expr_11:
.Lparse_unary_expr_12:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_unary_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-128], eax
    push 4
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_21
    push dword ptr [ebp-128]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_unary_expr_22
.Lparse_unary_expr_21:
    push 0
.Lparse_unary_expr_22:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_19
    push dword ptr [ebp-128]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_unary_expr_20
.Lparse_unary_expr_19:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_25
    push dword ptr [ebp-128]
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
    push 17
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
    jmp .Lparse_unary_expr_26
.Lparse_unary_expr_25:
    push 0
.Lparse_unary_expr_26:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_23
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sym_find
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_29
    push dword ptr [ebp-144]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_unary_expr_30
.Lparse_unary_expr_29:
    push 0
.Lparse_unary_expr_30:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_27
    push dword ptr [ebp-144]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_unary_expr_28
.Lparse_unary_expr_27:
.Lparse_unary_expr_28:
    jmp .Lparse_unary_expr_24
.Lparse_unary_expr_23:
    push dword ptr [ebp-128]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_33
    push dword ptr [ebp-128]
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
    push 18
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
    jmp .Lparse_unary_expr_34
.Lparse_unary_expr_33:
    push 0
.Lparse_unary_expr_34:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_31
    push dword ptr [ebp-128]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_37
    push dword ptr [ebp-144]
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
    push 17
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
    jmp .Lparse_unary_expr_38
.Lparse_unary_expr_37:
    push 0
.Lparse_unary_expr_38:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_35
    push dword ptr [ebp-144]
    push 24
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call sym_find
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_43
    push dword ptr [ebp-152]
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_unary_expr_44
.Lparse_unary_expr_43:
    push 0
.Lparse_unary_expr_44:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_41
    push dword ptr [ebp-152]
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
    jmp .Lparse_unary_expr_42
.Lparse_unary_expr_41:
    push 0
.Lparse_unary_expr_42:
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_39
    push dword ptr [ebp-152]
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
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call type_size
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_unary_expr_40
.Lparse_unary_expr_39:
.Lparse_unary_expr_40:
    jmp .Lparse_unary_expr_36
.Lparse_unary_expr_35:
.Lparse_unary_expr_36:
    jmp .Lparse_unary_expr_32
.Lparse_unary_expr_31:
.Lparse_unary_expr_32:
.Lparse_unary_expr_24:
.Lparse_unary_expr_20:
    push dword ptr [ebp-136]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setle al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_unary_expr_45
    push 4
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_unary_expr_46
.Lparse_unary_expr_45:
.Lparse_unary_expr_46:
    push dword ptr [ebp-104]
    push dword ptr [ebp-136]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_sizeof_val
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_10:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_postfix_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
.Lparse_unary_expr_0:
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

    .globl parse_postfix_expr
parse_postfix_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 428
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_primary_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-56], eax
.Lparse_postfix_expr_0:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-64]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-64]
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
    pop eax
    mov [ebp-112], eax
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
    push 52
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_3
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push 53
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-120]
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_array_access
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_postfix_expr_4
.Lparse_postfix_expr_3:
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_5
    push 0
    pop eax
    mov [ebp-120], eax
    push 0
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 49
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_7
.Lparse_postfix_expr_9:
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call parse_assign_expr
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-128]
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_12
    push dword ptr [ebp-136]
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_14
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    jmp .Lparse_postfix_expr_15
.Lparse_postfix_expr_14:
    push 4
.Lparse_postfix_expr_15:
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-136]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call mem_realloc
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-160]
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    add esp, 4
    jmp .Lparse_postfix_expr_13
.Lparse_postfix_expr_12:
.Lparse_postfix_expr_13:
    push dword ptr [ebp-120]
    push dword ptr [ebp-128]
    push dword ptr [ebp-128]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
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
    push 55
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_16
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    jmp .Lparse_postfix_expr_17
.Lparse_postfix_expr_16:
    jmp .Lparse_postfix_expr_10
.Lparse_postfix_expr_17:
.Lparse_postfix_expr_11:
    jmp .Lparse_postfix_expr_9
.Lparse_postfix_expr_10:
    jmp .Lparse_postfix_expr_8
.Lparse_postfix_expr_7:
.Lparse_postfix_expr_8:
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-176]
    push eax
    add esp, 4
    push dword ptr [ebp-56]
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
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_18
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-152], eax
    lea eax, [ark_str_93]
    push eax
    pop eax
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call mem_strdup
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_func_call
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-152]
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_postfix_expr_19
.Lparse_postfix_expr_18:
    push dword ptr [ebp-56]
    push 24
    pop ecx
    pop eax
    add eax, ecx
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
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-112]
    push dword ptr [ebp-128]
    push dword ptr [ebp-120]
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_func_call
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
.Lparse_postfix_expr_19:
    jmp .Lparse_postfix_expr_6
.Lparse_postfix_expr_5:
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
    push 84
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_postfix_expr_22
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
    jmp .Lparse_postfix_expr_23
.Lparse_postfix_expr_22:
    push 1
.Lparse_postfix_expr_23:
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_20
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
    push 85
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-128]
    push eax
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-176]
    push eax
    lea eax, [ebp-128]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    add esp, 4
    lea eax, [ebp-128]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_24
    lea eax, [ark_str_94]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    mov [ebp-176], esp
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call perror_at
    mov esp, [ebp-176]
    push dword ptr [ebp-56]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_postfix_expr_25
.Lparse_postfix_expr_24:
.Lparse_postfix_expr_25:
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-112]
    push dword ptr [ebp-120]
    lea eax, [ebp-128]
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
    push dword ptr [ebp-56]
    pop eax
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    pop eax
    mov [ebp-204], eax
    mov [ebp-176], esp
    push dword ptr [ebp-204]
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_member
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_postfix_expr_21
.Lparse_postfix_expr_20:
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
    push 46
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_postfix_expr_28
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
    push 47
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
    jmp .Lparse_postfix_expr_29
.Lparse_postfix_expr_28:
    push 1
.Lparse_postfix_expr_29:
    pop eax
    test eax, eax
    jz .Lparse_postfix_expr_26
    push dword ptr [ebp-48]
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
    mov [ebp-192], eax
    mov [ebp-176], esp
    push dword ptr [ebp-192]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-176]
    push eax
    push dword ptr [ebp-112]
    push dword ptr [ebp-56]
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
    mov [ebp-192], eax
    pop eax
    mov [ebp-196], eax
    pop eax
    mov [ebp-200], eax
    mov [ebp-176], esp
    push dword ptr [ebp-200]
    push dword ptr [ebp-196]
    push dword ptr [ebp-192]
    and esp, -16
    call ast_unary
    mov esp, [ebp-176]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    push dword ptr [ebp-120]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
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
    push dword ptr [ebp-120]
    pop eax
    mov [ebp-56], eax
    push dword ptr [ebp-56]
    add esp, 4
    jmp .Lparse_postfix_expr_27
.Lparse_postfix_expr_26:
    jmp .Lparse_postfix_expr_1
.Lparse_postfix_expr_27:
.Lparse_postfix_expr_21:
.Lparse_postfix_expr_6:
.Lparse_postfix_expr_4:
.Lparse_postfix_expr_2:
    jmp .Lparse_postfix_expr_0
.Lparse_postfix_expr_1:
    push dword ptr [ebp-56]
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

    .globl parse_primary_expr
parse_primary_expr:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 508
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
    push eax
    lea eax, [ebp-56]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-104], eax
    lea eax, [ebp-56]
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
    push 83
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_0
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    push 16
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_new
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push dword ptr [ebp-112]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-56]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    movq xmm0, [esp]
    add esp, 8
    cvttsd2si eax, xmm0
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    push dword ptr [ebp-112]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-56]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    lea eax, [ebp-56]
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
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_2
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-256], esp
    and esp, -16
    call type_double
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call type_complex
    mov esp, [ebp-256]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    push dword ptr [ebp-112]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop eax
    neg eax
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop edx
    pop ecx
    pop eax
    mov dword ptr [eax], edx
    mov dword ptr [eax+4], ecx
    push edx
    add esp, 4
    add esp, 4
    jmp .Lparse_primary_expr_3
.Lparse_primary_expr_2:
    lea eax, [ebp-56]
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
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_4
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-256], esp
    and esp, -16
    call type_float
    mov esp, [ebp-256]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_primary_expr_5
.Lparse_primary_expr_4:
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-256], esp
    and esp, -16
    call type_double
    mov esp, [ebp-256]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
.Lparse_primary_expr_5:
.Lparse_primary_expr_3:
    push dword ptr [ebp-112]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_1
.Lparse_primary_expr_0:
.Lparse_primary_expr_1:
    lea eax, [ebp-56]
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
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_6
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    lea eax, [ebp-56]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_num
    mov esp, [ebp-256]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_7
.Lparse_primary_expr_6:
.Lparse_primary_expr_7:
    lea eax, [ebp-56]
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
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_8
    lea eax, [ebp-56]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 1
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_10
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_primary_expr_11
.Lparse_primary_expr_10:
    push 0
.Lparse_primary_expr_11:
    pop eax
    mov [ebp-120], eax
    push 64
    pop eax
    mov [ebp-128], eax
    push 0
    pop eax
    mov [ebp-136], eax
    push 0
    pop eax
    mov [ebp-144], eax
    push 1
    pop eax
    mov [ebp-152], eax
.Lparse_primary_expr_12:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_peek
    mov esp, [ebp-256]
    push eax
    lea eax, [ebp-160]
    push eax
    pop edi
    pop esi
    mov ecx, 48
    rep movsb
    lea eax, [ebp-160]
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
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_15
    jmp .Lparse_primary_expr_13
    jmp .Lparse_primary_expr_16
.Lparse_primary_expr_15:
.Lparse_primary_expr_16:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    lea eax, [ebp-160]
    push eax
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 1
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_19
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
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_primary_expr_20
.Lparse_primary_expr_19:
    push 0
.Lparse_primary_expr_20:
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_17
    push 1
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    add esp, 4
    jmp .Lparse_primary_expr_18
.Lparse_primary_expr_17:
.Lparse_primary_expr_18:
    lea eax, [ebp-160]
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
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_21
    lea eax, [ebp-160]
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
    jmp .Lparse_primary_expr_22
.Lparse_primary_expr_21:
    lea eax, [ark_str_95]
    push eax
.Lparse_primary_expr_22:
    pop eax
    mov [ebp-208], eax
    push dword ptr [ebp-208]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-216], eax
    push dword ptr [ebp-152]
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_23
    push dword ptr [ebp-128]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push 0
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-152]
    add esp, 4
    jmp .Lparse_primary_expr_24
.Lparse_primary_expr_23:
.Lparse_primary_expr_24:
.Lparse_primary_expr_25:
    push dword ptr [ebp-136]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-128]
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_26
    push dword ptr [ebp-128]
    push 2
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-232], eax
    push 0
    pop eax
    mov [ebp-240], eax
    push dword ptr [ebp-240]
    add esp, 4
.Lparse_primary_expr_27:
    push dword ptr [ebp-240]
    push dword ptr [ebp-136]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_28
    push dword ptr [ebp-232]
    push dword ptr [ebp-240]
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
    push dword ptr [ebp-240]
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
.Lparse_primary_expr_29:
    push dword ptr [ebp-240]
    push dword ptr [ebp-240]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-240], eax
    add esp, 4
    jmp .Lparse_primary_expr_27
.Lparse_primary_expr_28:
    push dword ptr [ebp-232]
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-224]
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    add esp, 4
    jmp .Lparse_primary_expr_25
.Lparse_primary_expr_26:
    push 0
    pop eax
    mov [ebp-224], eax
    push dword ptr [ebp-224]
    add esp, 4
.Lparse_primary_expr_30:
    push dword ptr [ebp-224]
    push dword ptr [ebp-216]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_31
    push dword ptr [ebp-144]
    push dword ptr [ebp-136]
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-136], eax
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-208]
    push dword ptr [ebp-224]
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
.Lparse_primary_expr_32:
    push dword ptr [ebp-224]
    push dword ptr [ebp-224]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-224], eax
    add esp, 4
    jmp .Lparse_primary_expr_30
.Lparse_primary_expr_31:
.Lparse_primary_expr_14:
    jmp .Lparse_primary_expr_12
.Lparse_primary_expr_13:
    push dword ptr [ebp-152]
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_33
    push 1
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call mem_pool_alloc
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    add esp, 4
    push dword ptr [ebp-144]
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
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    jmp .Lparse_primary_expr_34
.Lparse_primary_expr_33:
.Lparse_primary_expr_34:
    push dword ptr [ebp-144]
    push dword ptr [ebp-136]
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
    push dword ptr [ebp-104]
    push dword ptr [ebp-144]
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_str
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push dword ptr [ebp-120]
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_35
    push dword ptr [ebp-112]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    mov [ebp-256], esp
    and esp, -16
    call type_wchar
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call type_pointer
    mov esp, [ebp-256]
    push eax
    pop edx
    pop eax
    mov dword ptr [eax], edx
    push edx
    add esp, 4
    jmp .Lparse_primary_expr_36
.Lparse_primary_expr_35:
.Lparse_primary_expr_36:
    push dword ptr [ebp-112]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_9
.Lparse_primary_expr_8:
.Lparse_primary_expr_9:
    lea eax, [ebp-56]
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
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_37
    lea eax, [ark_str_96]
    push eax
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ark_streq
    mov esp, [ebp-256]
    push eax
    pop eax
    test eax, eax
    jnz .Lparse_primary_expr_43
    lea eax, [ark_str_97]
    push eax
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ark_streq
    mov esp, [ebp-256]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_primary_expr_44
.Lparse_primary_expr_43:
    push 1
.Lparse_primary_expr_44:
    pop eax
    test eax, eax
    jnz .Lparse_primary_expr_41
    lea eax, [ark_str_98]
    push eax
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ark_streq
    mov esp, [ebp-256]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lparse_primary_expr_42
.Lparse_primary_expr_41:
    push 1
.Lparse_primary_expr_42:
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_39
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    mov eax, [g_current_func_name]
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_45
    mov eax, [g_current_func_name]
    push eax
    jmp .Lparse_primary_expr_46
.Lparse_primary_expr_45:
    lea eax, [ark_str_99]
    push eax
.Lparse_primary_expr_46:
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_str
    mov esp, [ebp-256]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_40
.Lparse_primary_expr_39:
.Lparse_primary_expr_40:
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call sym_find
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_49
    push dword ptr [ebp-112]
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
    push 5
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
    jmp .Lparse_primary_expr_50
.Lparse_primary_expr_49:
    push 0
.Lparse_primary_expr_50:
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_47
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    push dword ptr [ebp-112]
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
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_num
    mov esp, [ebp-256]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_48
.Lparse_primary_expr_47:
.Lparse_primary_expr_48:
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    lea eax, [ebp-56]
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
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_var
    mov esp, [ebp-256]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_38
.Lparse_primary_expr_37:
.Lparse_primary_expr_38:
    lea eax, [ebp-56]
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
    push 48
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lparse_primary_expr_51
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call parse_expr
    mov esp, [ebp-256]
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
    push 49
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_expect
    mov esp, [ebp-256]
    push eax
    add esp, 4
    push dword ptr [ebp-112]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Lparse_primary_expr_52
.Lparse_primary_expr_51:
.Lparse_primary_expr_52:
    lea eax, [ark_str_100]
    push eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call perror_at
    mov esp, [ebp-256]
    push dword ptr [ebp-48]
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
    mov [ebp-272], eax
    mov [ebp-256], esp
    push dword ptr [ebp-272]
    and esp, -16
    call lexer_advance
    mov esp, [ebp-256]
    push eax
    push dword ptr [ebp-104]
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    pop eax
    mov [ebp-272], eax
    pop eax
    mov [ebp-276], eax
    mov [ebp-256], esp
    push dword ptr [ebp-276]
    push dword ptr [ebp-272]
    and esp, -16
    call ast_num
    mov esp, [ebp-256]
    push eax
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

