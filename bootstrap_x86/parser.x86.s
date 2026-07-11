# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_current_func_name
_g_current_func_name:
    .long 0
    .globl _g_attr_is_weak
_g_attr_is_weak:
    .zero 4
    .globl _g_attr_is_naked
_g_attr_is_naked:
    .zero 4
    .globl _g_attr_is_irq
_g_attr_is_irq:
    .zero 4
    .globl _g_attr_section
_g_attr_section:
    .zero 4
    .globl _g_decl_is_const
_g_decl_is_const:
    .zero 4
    .globl _g_decl_is_volatile
_g_decl_is_volatile:
    .zero 4
    .globl _g_attr_is_used
_g_attr_is_used:
    .zero 4
    .globl _g_attr_is_unused
_g_attr_is_unused:
    .zero 4
    .globl _g_attr_alias_target
_g_attr_alias_target:
    .zero 4
    .globl _g_attr_align_bytes
_g_attr_align_bytes:
    .zero 4
    .globl _g_decl_align_bytes
_g_decl_align_bytes:
    .zero 4
    .globl _g_decl_packed_ptr
_g_decl_packed_ptr:
    .zero 4
    .globl _g_vla_size_expr
_g_vla_size_expr:
    .zero 4
    .globl _g_attr_is_softfp
_g_attr_is_softfp:
    .zero 4
    .globl _g_attr_is_forceinline
_g_attr_is_forceinline:
    .zero 4
    .globl _g_decl_is_asm_fn
_g_decl_is_asm_fn:
    .zero 4
    .globl _g_attr_is_constructor
_g_attr_is_constructor:
    .zero 4
    .globl _g_attr_is_destructor
_g_attr_is_destructor:
    .zero 4
    .globl _g_attr_is_deprecated
_g_attr_is_deprecated:
    .zero 4
    .globl _g_attr_at_addr
_g_attr_at_addr:
    .zero 4
    .globl _g_attr_has_at
_g_attr_has_at:
    .zero 4
    .globl _g_func_is_value_in_regs
_g_func_is_value_in_regs:
    .zero 4
    .globl _g_func_is_pure
_g_func_is_pure:
    .zero 4
    .globl _g_func_is_const_attr
_g_func_is_const_attr:
    .zero 4
    .globl _g_func_is_interwork
_g_func_is_interwork:
    .zero 4
    .globl _g_func_is_deprecated_kw
_g_func_is_deprecated_kw:
    .zero 4
    .globl _g_func_mods_declspec
_g_func_mods_declspec:
    .zero 4
    .section .rdata,"dr"
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
    .text
_is_basic_type_token:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_1
    pushl -16(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_2
    pushl -16(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_3
    pushl -16(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_4
    pushl -16(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_5
    pushl -16(%ebp)
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_6
    pushl -16(%ebp)
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_7
    pushl -16(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_8
    pushl -16(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_9
    pushl -16(%ebp)
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_10
    pushl -16(%ebp)
    pushl $74
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_11
    pushl -16(%ebp)
    pushl $75
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_12
    pushl -16(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_13
    pushl -16(%ebp)
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_14
    pushl -16(%ebp)
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_15
    pushl -16(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_16
    pushl -16(%ebp)
    pushl $69
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_17
    pushl -16(%ebp)
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_18
    pushl -16(%ebp)
    pushl $71
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_19
    pushl -16(%ebp)
    pushl $72
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_20
    pushl -16(%ebp)
    pushl $73
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_21
    pushl -16(%ebp)
    pushl $77
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_22
    pushl -16(%ebp)
    pushl $94
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_23
    pushl -16(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_24
    pushl -16(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_25
    pushl -16(%ebp)
    pushl $109
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_26
    pushl -16(%ebp)
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_27
    pushl -16(%ebp)
    pushl $107
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_28
    pushl -16(%ebp)
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_29
    pushl -16(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_30
    pushl -16(%ebp)
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_31
    pushl -16(%ebp)
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_32
    pushl -16(%ebp)
    pushl $106
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_33
    pushl -16(%ebp)
    pushl $103
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_34
    pushl -16(%ebp)
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_35
    pushl -16(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_36
    pushl -16(%ebp)
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_37
    pushl -16(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_38
    pushl -16(%ebp)
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_39
    pushl -16(%ebp)
    pushl $118
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_basic_type_token_40
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_basic_type_token_41:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_basic_type_token_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_decl_start:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -64(%ebp), %eax
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
    call _is_basic_type_token
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_decl_start_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_decl_start_0:
.Lis_decl_start_1:
    leal -64(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_decl_start_4
    leal -64(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_decl_start_5
.Lis_decl_start_4:
    pushl $0
.Lis_decl_start_5:
    popl %eax
    cmpl $0, %eax
    je .Lis_decl_start_2
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_decl_start_2:
.Lis_decl_start_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_perror_at:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl -72(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -56(%ebp), %eax
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
    pushl -64(%ebp)
    leal -56(%ebp), %eax
    pushl %eax
    pushl $28
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
    leal ark_str_0, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
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

    .globl _parse_program
_parse_program:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    leal -48(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -48(%ebp), %eax
    pushl %eax
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
    call _sym_init
    pushl %eax
    addl $4, %esp
    pushl $1
    pushl $0
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
.Lparse_program_0:
    pushl -56(%ebp)
    call _lexer_peek
    addl $4, %esp
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_program_1
    leal -48(%ebp), %eax
    pushl %eax
    call _parse_top_decl
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_program_2
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl -24(%ebp)
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_program_4
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    je .Lparse_program_6
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lparse_program_7
.Lparse_program_6:
    pushl $16
.Lparse_program_7:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
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
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    jmp .Lparse_program_5
.Lparse_program_4:
.Lparse_program_5:
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
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
    jmp .Lparse_program_3
.Lparse_program_2:
    pushl -56(%ebp)
    call _lexer_peek
    addl $4, %esp
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_program_8
    pushl -56(%ebp)
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_program_9
.Lparse_program_8:
.Lparse_program_9:
.Lparse_program_3:
    jmp .Lparse_program_0
.Lparse_program_1:
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_qualifiers:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_qualifiers_0:
    pushl -40(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lskip_qualifiers_9
    pushl -16(%ebp)
    pushl $67
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
    jmp .Lskip_qualifiers_10
.Lskip_qualifiers_9:
    pushl $1
.Lskip_qualifiers_10:
    popl %eax
    cmpl $0, %eax
    jne .Lskip_qualifiers_7
    pushl -16(%ebp)
    pushl $68
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
    jmp .Lskip_qualifiers_8
.Lskip_qualifiers_7:
    pushl $1
.Lskip_qualifiers_8:
    popl %eax
    cmpl $0, %eax
    jne .Lskip_qualifiers_5
    pushl -16(%ebp)
    pushl $69
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
    jmp .Lskip_qualifiers_6
.Lskip_qualifiers_5:
    pushl $1
.Lskip_qualifiers_6:
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_3
    pushl -16(%ebp)
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_13
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lskip_qualifiers_14
.Lskip_qualifiers_13:
    pushl $0
.Lskip_qualifiers_14:
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_11
    pushl -32(%ebp)
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lskip_qualifiers_12
.Lskip_qualifiers_11:
.Lskip_qualifiers_12:
    pushl -16(%ebp)
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_17
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lskip_qualifiers_18
.Lskip_qualifiers_17:
    pushl $0
.Lskip_qualifiers_18:
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_15
    pushl -24(%ebp)
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lskip_qualifiers_16
.Lskip_qualifiers_15:
.Lskip_qualifiers_16:
    pushl -40(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lskip_qualifiers_4
.Lskip_qualifiers_3:
    pushl -16(%ebp)
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_qualifiers_19
    pushl $0
    pushl -40(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lskip_qualifiers_20
.Lskip_qualifiers_19:
    jmp .Lskip_qualifiers_1
.Lskip_qualifiers_20:
.Lskip_qualifiers_4:
.Lskip_qualifiers_2:
    jmp .Lskip_qualifiers_0
.Lskip_qualifiers_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_svc:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $90
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_svc_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_svc_0:
.Lparse_svc_1:
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_svc_2
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_svc_2:
.Lparse_svc_3:
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_svc_4
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_svc_5
.Lparse_svc_4:
.Lparse_svc_5:
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_svc_6
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_svc_7
.Lparse_svc_6:
.Lparse_svc_7:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_func_modifiers:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
.Lparse_func_modifiers_0:
    pushl -40(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_3
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_func_modifiers_4
.Lparse_func_modifiers_3:
    pushl -24(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_5
    pushl -32(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_func_modifiers_6
.Lparse_func_modifiers_5:
    pushl -24(%ebp)
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_7
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_func_modifiers_8
.Lparse_func_modifiers_7:
    pushl -24(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_9
    pushl -32(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_func_modifiers_10
.Lparse_func_modifiers_9:
    pushl -24(%ebp)
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_11
    pushl -32(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_func_modifiers_12
.Lparse_func_modifiers_11:
    pushl -24(%ebp)
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_13
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_value_in_regs
    addl $4, %esp
    jmp .Lparse_func_modifiers_14
.Lparse_func_modifiers_13:
    pushl -24(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_15
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_pure
    addl $4, %esp
    jmp .Lparse_func_modifiers_16
.Lparse_func_modifiers_15:
    pushl -24(%ebp)
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_17
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_interwork
    addl $4, %esp
    jmp .Lparse_func_modifiers_18
.Lparse_func_modifiers_17:
    pushl -24(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_19
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_deprecated_kw
    addl $4, %esp
    jmp .Lparse_func_modifiers_20
.Lparse_func_modifiers_19:
    pushl -24(%ebp)
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_func_modifiers_29
    pushl -24(%ebp)
    pushl $117
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
    jmp .Lparse_func_modifiers_30
.Lparse_func_modifiers_29:
    pushl $1
.Lparse_func_modifiers_30:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_func_modifiers_27
    pushl -24(%ebp)
    pushl $114
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
    jmp .Lparse_func_modifiers_28
.Lparse_func_modifiers_27:
    pushl $1
.Lparse_func_modifiers_28:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_func_modifiers_25
    pushl -24(%ebp)
    pushl $112
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
    jmp .Lparse_func_modifiers_26
.Lparse_func_modifiers_25:
    pushl $1
.Lparse_func_modifiers_26:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_func_modifiers_23
    pushl -24(%ebp)
    pushl $113
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
    jmp .Lparse_func_modifiers_24
.Lparse_func_modifiers_23:
    pushl $1
.Lparse_func_modifiers_24:
    popl %eax
    cmpl $0, %eax
    je .Lparse_func_modifiers_21
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
    pushl -40(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_func_modifiers_2:
    jmp .Lparse_func_modifiers_0
.Lparse_func_modifiers_1:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_attribute:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_attribute_0:
.Lparse_attribute_1:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_2
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_attribute_2:
.Lparse_attribute_3:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_attribute_4:
.Lparse_attribute_5:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_attribute_6:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_8
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_attribute_9
.Lparse_attribute_8:
    pushl $0
.Lparse_attribute_9:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_7
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -104(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -104(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_10
    leal -104(%ebp), %eax
    pushl %eax
    pushl $24
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
    movl %eax, -56(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_12
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_14
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_attribute_15
.Lparse_attribute_14:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_16
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_attribute_17
.Lparse_attribute_16:
.Lparse_attribute_17:
.Lparse_attribute_15:
.Lparse_attribute_18:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_20
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_attribute_21
.Lparse_attribute_20:
    pushl $0
.Lparse_attribute_21:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_19
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_22
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
    jmp .Lparse_attribute_23
.Lparse_attribute_22:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_24
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    addl $4, %esp
    jmp .Lparse_attribute_25
.Lparse_attribute_24:
.Lparse_attribute_25:
.Lparse_attribute_23:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_26
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_attribute_27
.Lparse_attribute_26:
.Lparse_attribute_27:
    jmp .Lparse_attribute_18
.Lparse_attribute_19:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_28
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_attribute_29
.Lparse_attribute_28:
.Lparse_attribute_29:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_32
    leal ark_str_1, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_34
    leal ark_str_2, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_35
.Lparse_attribute_34:
    pushl $1
.Lparse_attribute_35:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_33
.Lparse_attribute_32:
    pushl $0
.Lparse_attribute_33:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_30
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_36
    pushl -112(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_attribute_37
.Lparse_attribute_36:
.Lparse_attribute_37:
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_align_bytes
    addl $4, %esp
    jmp .Lparse_attribute_31
.Lparse_attribute_30:
.Lparse_attribute_31:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_40
    leal ark_str_3, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_42
    leal ark_str_4, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_43
.Lparse_attribute_42:
    pushl $1
.Lparse_attribute_43:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_41
.Lparse_attribute_40:
    pushl $0
.Lparse_attribute_41:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_38
    pushl -40(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_at_addr
    addl $4, %esp
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_has_at
    addl $4, %esp
    jmp .Lparse_attribute_39
.Lparse_attribute_38:
.Lparse_attribute_39:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_46
    leal ark_str_5, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_48
    leal ark_str_6, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_49
.Lparse_attribute_48:
    pushl $1
.Lparse_attribute_49:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_47
.Lparse_attribute_46:
    pushl $0
.Lparse_attribute_47:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_44
    pushl -24(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    jmp .Lparse_attribute_45
.Lparse_attribute_44:
.Lparse_attribute_45:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_52
    leal ark_str_7, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_54
    leal ark_str_8, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_55
.Lparse_attribute_54:
    pushl $1
.Lparse_attribute_55:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_53
.Lparse_attribute_52:
    pushl $0
.Lparse_attribute_53:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_50
    pushl -24(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_alias_target
    addl $4, %esp
    jmp .Lparse_attribute_51
.Lparse_attribute_50:
.Lparse_attribute_51:
    jmp .Lparse_attribute_13
.Lparse_attribute_12:
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_58
    leal ark_str_9, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_60
    leal ark_str_10, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_61
.Lparse_attribute_60:
    pushl $1
.Lparse_attribute_61:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_59
.Lparse_attribute_58:
    pushl $0
.Lparse_attribute_59:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_56
    pushl -112(%ebp)
    pushl $36
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
    jmp .Lparse_attribute_57
.Lparse_attribute_56:
.Lparse_attribute_57:
    leal ark_str_11, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_64
    leal ark_str_12, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_65
.Lparse_attribute_64:
    pushl $1
.Lparse_attribute_65:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_62
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_66
    pushl -112(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_attribute_67
.Lparse_attribute_66:
.Lparse_attribute_67:
    pushl $8
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_align_bytes
    addl $4, %esp
    jmp .Lparse_attribute_63
.Lparse_attribute_62:
.Lparse_attribute_63:
    leal ark_str_13, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_70
    leal ark_str_14, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_71
.Lparse_attribute_70:
    pushl $1
.Lparse_attribute_71:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_68
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_weak
    addl $4, %esp
    jmp .Lparse_attribute_69
.Lparse_attribute_68:
.Lparse_attribute_69:
    leal ark_str_15, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_74
    leal ark_str_16, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_75
.Lparse_attribute_74:
    pushl $1
.Lparse_attribute_75:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_72
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_naked
    addl $4, %esp
    jmp .Lparse_attribute_73
.Lparse_attribute_72:
.Lparse_attribute_73:
    leal ark_str_17, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_82
    leal ark_str_18, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_83
.Lparse_attribute_82:
    pushl $1
.Lparse_attribute_83:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_80
    leal ark_str_19, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_81
.Lparse_attribute_80:
    pushl $1
.Lparse_attribute_81:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_78
    leal ark_str_20, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_79
.Lparse_attribute_78:
    pushl $1
.Lparse_attribute_79:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_76
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_irq
    addl $4, %esp
    jmp .Lparse_attribute_77
.Lparse_attribute_76:
.Lparse_attribute_77:
    leal ark_str_21, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_86
    leal ark_str_22, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_87
.Lparse_attribute_86:
    pushl $1
.Lparse_attribute_87:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_84
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_used
    addl $4, %esp
    jmp .Lparse_attribute_85
.Lparse_attribute_84:
.Lparse_attribute_85:
    leal ark_str_23, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_90
    leal ark_str_24, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_91
.Lparse_attribute_90:
    pushl $1
.Lparse_attribute_91:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_88
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_unused
    addl $4, %esp
    jmp .Lparse_attribute_89
.Lparse_attribute_88:
.Lparse_attribute_89:
    leal ark_str_25, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_94
    leal ark_str_26, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_95
.Lparse_attribute_94:
    pushl $1
.Lparse_attribute_95:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_92
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_softfp
    addl $4, %esp
    jmp .Lparse_attribute_93
.Lparse_attribute_92:
.Lparse_attribute_93:
    leal ark_str_27, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_100
    leal ark_str_28, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_101
.Lparse_attribute_100:
    pushl $1
.Lparse_attribute_101:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_98
    leal ark_str_29, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_99
.Lparse_attribute_98:
    pushl $1
.Lparse_attribute_99:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_96
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_forceinline
    addl $4, %esp
    jmp .Lparse_attribute_97
.Lparse_attribute_96:
.Lparse_attribute_97:
    leal ark_str_30, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_104
    leal ark_str_31, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_105
.Lparse_attribute_104:
    pushl $1
.Lparse_attribute_105:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_102
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_constructor
    addl $4, %esp
    jmp .Lparse_attribute_103
.Lparse_attribute_102:
.Lparse_attribute_103:
    leal ark_str_32, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_108
    leal ark_str_33, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_109
.Lparse_attribute_108:
    pushl $1
.Lparse_attribute_109:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_106
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_destructor
    addl $4, %esp
    jmp .Lparse_attribute_107
.Lparse_attribute_106:
.Lparse_attribute_107:
    leal ark_str_34, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_112
    leal ark_str_35, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_113
.Lparse_attribute_112:
    pushl $1
.Lparse_attribute_113:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_110
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_deprecated
    addl $4, %esp
    jmp .Lparse_attribute_111
.Lparse_attribute_110:
.Lparse_attribute_111:
    leal ark_str_36, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_116
    leal ark_str_37, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_117
.Lparse_attribute_116:
    pushl $1
.Lparse_attribute_117:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_114
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_pure
    addl $4, %esp
    jmp .Lparse_attribute_115
.Lparse_attribute_114:
.Lparse_attribute_115:
    leal ark_str_38, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_120
    leal ark_str_39, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_121
.Lparse_attribute_120:
    pushl $1
.Lparse_attribute_121:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_118
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_const_attr
    addl $4, %esp
    jmp .Lparse_attribute_119
.Lparse_attribute_118:
.Lparse_attribute_119:
    leal ark_str_40, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_160
    leal ark_str_41, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_161
.Lparse_attribute_160:
    pushl $1
.Lparse_attribute_161:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_158
    leal ark_str_42, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_159
.Lparse_attribute_158:
    pushl $1
.Lparse_attribute_159:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_156
    leal ark_str_43, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_157
.Lparse_attribute_156:
    pushl $1
.Lparse_attribute_157:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_154
    leal ark_str_44, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_155
.Lparse_attribute_154:
    pushl $1
.Lparse_attribute_155:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_152
    leal ark_str_45, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_153
.Lparse_attribute_152:
    pushl $1
.Lparse_attribute_153:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_150
    leal ark_str_46, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_151
.Lparse_attribute_150:
    pushl $1
.Lparse_attribute_151:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_148
    leal ark_str_47, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_149
.Lparse_attribute_148:
    pushl $1
.Lparse_attribute_149:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_146
    leal ark_str_48, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_147
.Lparse_attribute_146:
    pushl $1
.Lparse_attribute_147:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_144
    leal ark_str_49, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_145
.Lparse_attribute_144:
    pushl $1
.Lparse_attribute_145:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_142
    leal ark_str_50, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_143
.Lparse_attribute_142:
    pushl $1
.Lparse_attribute_143:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_140
    leal ark_str_51, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_141
.Lparse_attribute_140:
    pushl $1
.Lparse_attribute_141:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_138
    leal ark_str_52, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_139
.Lparse_attribute_138:
    pushl $1
.Lparse_attribute_139:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_136
    leal ark_str_53, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_137
.Lparse_attribute_136:
    pushl $1
.Lparse_attribute_137:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_134
    leal ark_str_54, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_135
.Lparse_attribute_134:
    pushl $1
.Lparse_attribute_135:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_132
    leal ark_str_55, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_133
.Lparse_attribute_132:
    pushl $1
.Lparse_attribute_133:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_130
    leal ark_str_56, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_131
.Lparse_attribute_130:
    pushl $1
.Lparse_attribute_131:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_128
    leal ark_str_57, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_129
.Lparse_attribute_128:
    pushl $1
.Lparse_attribute_129:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_126
    leal ark_str_58, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_127
.Lparse_attribute_126:
    pushl $1
.Lparse_attribute_127:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_attribute_124
    leal ark_str_59, %eax
    pushl %eax
    pushl -56(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_attribute_125
.Lparse_attribute_124:
    pushl $1
.Lparse_attribute_125:
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_122
    jmp .Lparse_attribute_123
.Lparse_attribute_122:
.Lparse_attribute_123:
.Lparse_attribute_13:
    jmp .Lparse_attribute_11
.Lparse_attribute_10:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_attribute_11:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_162
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_attribute_163
.Lparse_attribute_162:
.Lparse_attribute_163:
    jmp .Lparse_attribute_6
.Lparse_attribute_7:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_164
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_attribute_165
.Lparse_attribute_164:
.Lparse_attribute_165:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_attribute_166
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_attribute_167
.Lparse_attribute_166:
.Lparse_attribute_167:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_init_list:
    pushl %ebp
    movl %esp, %ebp
    subl $400, %esp
    movl 8(%ebp), %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    pushl $32
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_init_list_0:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_2
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_init_list_3
.Lparse_init_list_2:
    pushl $0
.Lparse_init_list_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_1
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $84
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_4
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_6
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_7
.Lparse_init_list_6:
.Lparse_init_list_7:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $84
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_init_list_10
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $52
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
    jmp .Lparse_init_list_11
.Lparse_init_list_10:
    pushl $1
.Lparse_init_list_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_8
    pushl -144(%ebp)
    pushl $32
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $84
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_12
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_14
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_15
.Lparse_init_list_14:
.Lparse_init_list_15:
    jmp .Lparse_init_list_13
.Lparse_init_list_12:
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_16
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_17
.Lparse_init_list_16:
.Lparse_init_list_17:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_18
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_19
.Lparse_init_list_18:
.Lparse_init_list_19:
.Lparse_init_list_13:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_20
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_21
.Lparse_init_list_20:
.Lparse_init_list_21:
    pushl -152(%ebp)
    call _parse_initializer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -144(%ebp)
    pushl $33
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl -144(%ebp)
    pushl $33
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -88(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_22
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    je .Lparse_init_list_24
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lparse_init_list_25
.Lparse_init_list_24:
    pushl $8
.Lparse_init_list_25:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    jmp .Lparse_init_list_23
.Lparse_init_list_22:
.Lparse_init_list_23:
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_26
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_27
.Lparse_init_list_26:
.Lparse_init_list_27:
    jmp .Lparse_init_list_0
.Lparse_init_list_8:
.Lparse_init_list_9:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_28
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_29
.Lparse_init_list_28:
.Lparse_init_list_29:
    jmp .Lparse_init_list_5
.Lparse_init_list_4:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_30
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_32
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_33
.Lparse_init_list_32:
.Lparse_init_list_33:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_34
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_35
.Lparse_init_list_34:
.Lparse_init_list_35:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_36
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_37
.Lparse_init_list_36:
.Lparse_init_list_37:
    jmp .Lparse_init_list_31
.Lparse_init_list_30:
.Lparse_init_list_31:
.Lparse_init_list_5:
    pushl -152(%ebp)
    call _parse_initializer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    pushl $33
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -88(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_38
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    je .Lparse_init_list_40
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lparse_init_list_41
.Lparse_init_list_40:
    pushl $8
.Lparse_init_list_41:
    popl %eax
    movl %eax, -72(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_init_list_39
.Lparse_init_list_38:
.Lparse_init_list_39:
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
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
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_42
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_43
.Lparse_init_list_42:
.Lparse_init_list_43:
    jmp .Lparse_init_list_0
.Lparse_init_list_1:
    pushl -152(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_init_list_44
    pushl -152(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_init_list_45
.Lparse_init_list_44:
.Lparse_init_list_45:
    pushl -136(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_initializer:
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _lexer_peek
    addl $4, %esp
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
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_initializer_0
    pushl -24(%ebp)
    call _parse_init_list
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_initializer_0:
.Lparse_initializer_1:
    pushl -24(%ebp)
    call _parse_assign_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_infer_array_size_from_init:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Linfer_array_size_from_init_4
    pushl -56(%ebp)
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
    pushl $10
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
    jmp .Linfer_array_size_from_init_5
.Linfer_array_size_from_init_4:
    pushl $1
.Linfer_array_size_from_init_5:
    popl %eax
    cmpl $0, %eax
    jne .Linfer_array_size_from_init_2
    pushl -56(%ebp)
    pushl $8
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
    jmp .Linfer_array_size_from_init_3
.Linfer_array_size_from_init_2:
    pushl $1
.Linfer_array_size_from_init_3:
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Linfer_array_size_from_init_0:
.Linfer_array_size_from_init_1:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_6
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Linfer_array_size_from_init_6:
.Linfer_array_size_from_init_7:
    pushl -48(%ebp)
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
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_8
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    je .Linfer_array_size_from_init_10
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    jmp .Linfer_array_size_from_init_11
.Linfer_array_size_from_init_10:
    leal ark_str_60, %eax
    pushl %eax
.Linfer_array_size_from_init_11:
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
.Linfer_array_size_from_init_12:
    pushl -40(%ebp)
    pushl -32(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_13
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    addl $4, %esp
    jmp .Linfer_array_size_from_init_12
.Linfer_array_size_from_init_13:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Linfer_array_size_from_init_8:
.Linfer_array_size_from_init_9:
    pushl -48(%ebp)
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
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_14
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Linfer_array_size_from_init_16:
    pushl -40(%ebp)
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_17
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -40(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_21
    pushl -16(%ebp)
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
    pushl $33
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
    jmp .Linfer_array_size_from_init_22
.Linfer_array_size_from_init_21:
    pushl $0
.Linfer_array_size_from_init_22:
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_19
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    je .Linfer_array_size_from_init_23
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_25
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Linfer_array_size_from_init_26
.Linfer_array_size_from_init_25:
.Linfer_array_size_from_init_26:
    jmp .Linfer_array_size_from_init_24
.Linfer_array_size_from_init_23:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
.Linfer_array_size_from_init_24:
    jmp .Linfer_array_size_from_init_20
.Linfer_array_size_from_init_19:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
.Linfer_array_size_from_init_20:
.Linfer_array_size_from_init_18:
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    addl $4, %esp
    jmp .Linfer_array_size_from_init_16
.Linfer_array_size_from_init_17:
    pushl -24(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_27
    pushl -24(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Linfer_array_size_from_init_28
.Linfer_array_size_from_init_27:
.Linfer_array_size_from_init_28:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_29
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Linfer_array_size_from_init_30
.Linfer_array_size_from_init_29:
.Linfer_array_size_from_init_30:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Linfer_array_size_from_init_14:
.Linfer_array_size_from_init_15:
    pushl -48(%ebp)
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
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_37
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Linfer_array_size_from_init_38
.Linfer_array_size_from_init_37:
    pushl $0
.Linfer_array_size_from_init_38:
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_35
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl $10
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
    jmp .Linfer_array_size_from_init_36
.Linfer_array_size_from_init_35:
    pushl $0
.Linfer_array_size_from_init_36:
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_33
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Linfer_array_size_from_init_34
.Linfer_array_size_from_init_33:
    pushl $0
.Linfer_array_size_from_init_34:
    popl %eax
    cmpl $0, %eax
    je .Linfer_array_size_from_init_31
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl $8
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
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Linfer_array_size_from_init_31:
.Linfer_array_size_from_init_32:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_asm_statement:
    pushl %ebp
    movl %esp, %ebp
    subl $464, %esp
    movl 8(%ebp), %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    pushl $34
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -200(%ebp)
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_asm_statement_0:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_4
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $66
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
    jmp .Lparse_asm_statement_5
.Lparse_asm_statement_4:
    pushl $1
.Lparse_asm_statement_5:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_2
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $69
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
    jmp .Lparse_asm_statement_3
.Lparse_asm_statement_2:
    pushl $1
.Lparse_asm_statement_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_1
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_6
    pushl $1
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_7
.Lparse_asm_statement_6:
.Lparse_asm_statement_7:
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_asm_statement_0
.Lparse_asm_statement_1:
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -192(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_8
    pushl -200(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_asm_statement_8:
.Lparse_asm_statement_9:
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
.Lparse_asm_statement_10:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_11
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -176(%ebp)
    pushl -160(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
.Lparse_asm_statement_12:
    pushl -136(%ebp)
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_13
    pushl -144(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    pushl -136(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_14:
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_12
.Lparse_asm_statement_13:
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
.Lparse_asm_statement_15:
    pushl -136(%ebp)
    pushl -160(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_16
    pushl -144(%ebp)
    pushl -176(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl -136(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_17:
    pushl -136(%ebp)
    pushl -136(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_15
.Lparse_asm_statement_16:
    pushl -144(%ebp)
    pushl -152(%ebp)
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_asm_statement_10
.Lparse_asm_statement_11:
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_18
    pushl -184(%ebp)
    jmp .Lparse_asm_statement_19
.Lparse_asm_statement_18:
    leal ark_str_61, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
.Lparse_asm_statement_19:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
.Lparse_asm_statement_20:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_22
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
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
    jmp .Lparse_asm_statement_23
.Lparse_asm_statement_22:
    pushl $0
.Lparse_asm_statement_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_21
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_24
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_26
    pushl $2
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_27
.Lparse_asm_statement_26:
.Lparse_asm_statement_27:
    jmp .Lparse_asm_statement_20
.Lparse_asm_statement_24:
.Lparse_asm_statement_25:
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
.Lparse_asm_statement_28:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_29
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -152(%ebp), %eax
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
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_32
    pushl -104(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_34
    pushl -104(%ebp)
    pushl $49
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
    jmp .Lparse_asm_statement_35
.Lparse_asm_statement_34:
    pushl $1
.Lparse_asm_statement_35:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_asm_statement_33
.Lparse_asm_statement_32:
    pushl $0
.Lparse_asm_statement_33:
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_30
    jmp .Lparse_asm_statement_29
.Lparse_asm_statement_30:
.Lparse_asm_statement_31:
    pushl -168(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_36
    pushl -168(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
.Lparse_asm_statement_38:
    pushl -64(%ebp)
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_39
    pushl -72(%ebp)
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl -64(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_40:
    pushl -64(%ebp)
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_38
.Lparse_asm_statement_39:
    pushl -72(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $32
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_37
.Lparse_asm_statement_36:
.Lparse_asm_statement_37:
    pushl -104(%ebp)
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_42
    pushl -72(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_43
    pushl -72(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_44
    pushl -72(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_45
    pushl -72(%ebp)
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_46
    pushl -72(%ebp)
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_47
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_48
    pushl -72(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_49
    pushl -72(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_50
    pushl -72(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_51
    pushl -72(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_52
    pushl -72(%ebp)
    pushl $84
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_53
    pushl -72(%ebp)
    pushl $85
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_54
    pushl -72(%ebp)
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_55
    pushl -72(%ebp)
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_56
    pushl -72(%ebp)
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_57
    pushl -72(%ebp)
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_asm_statement_58
    jmp .Lparse_asm_statement_59
.Lparse_asm_statement_42:
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
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
    je .Lparse_asm_statement_60
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
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
    jmp .Lparse_asm_statement_61
.Lparse_asm_statement_60:
    leal ark_str_62, %eax
    pushl %eax
.Lparse_asm_statement_61:
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -168(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lparse_asm_statement_62:
    pushl -48(%ebp)
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_63
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl -48(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_64:
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
    jmp .Lparse_asm_statement_62
.Lparse_asm_statement_63:
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $34
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lparse_asm_statement_65:
    pushl -48(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_66
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
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
    pushl -48(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_67:
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
    jmp .Lparse_asm_statement_65
.Lparse_asm_statement_66:
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $34
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_43:
    leal -152(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_68
    pushl $1
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_69
.Lparse_asm_statement_68:
    pushl -64(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lparse_asm_statement_69:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_70
    leal -88(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_asm_statement_71
.Lparse_asm_statement_70:
.Lparse_asm_statement_71:
.Lparse_asm_statement_72:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_73
    leal -88(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    xorl %edx, %edx
    divl %ecx
    pushl %edx
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    xorl %edx, %edx
    divl %ecx
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_72
.Lparse_asm_statement_73:
    pushl -168(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_asm_statement_74:
    pushl -24(%ebp)
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_75
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl -24(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_76:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_74
.Lparse_asm_statement_75:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_77
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $45
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_asm_statement_78
.Lparse_asm_statement_77:
.Lparse_asm_statement_78:
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_asm_statement_79:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_80
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -88(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_81:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_79
.Lparse_asm_statement_80:
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_44:
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
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
    je .Lparse_asm_statement_82
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
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
    jmp .Lparse_asm_statement_83
.Lparse_asm_statement_82:
    leal ark_str_63, %eax
    pushl %eax
.Lparse_asm_statement_83:
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_45:
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    leal ark_str_64, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_46:
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    leal ark_str_65, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_47:
    leal ark_str_66, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_48:
    leal ark_str_67, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_49:
    leal ark_str_68, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_50:
    leal ark_str_69, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_51:
    leal ark_str_70, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_52:
    leal ark_str_71, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_53:
    leal ark_str_72, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_54:
    leal ark_str_73, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_55:
    leal ark_str_74, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_56:
    leal ark_str_75, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_57:
    leal ark_str_76, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_58:
    leal ark_str_77, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_59:
    leal ark_str_78, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_41
.Lparse_asm_statement_41:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_84
    pushl -96(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -168(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lparse_asm_statement_86:
    pushl -48(%ebp)
    pushl -168(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_87
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    pushl -48(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_88:
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
    jmp .Lparse_asm_statement_86
.Lparse_asm_statement_87:
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lparse_asm_statement_89:
    pushl -48(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_90
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -48(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_91:
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
    jmp .Lparse_asm_statement_89
.Lparse_asm_statement_90:
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    jmp .Lparse_asm_statement_85
.Lparse_asm_statement_84:
.Lparse_asm_statement_85:
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_asm_statement_28
.Lparse_asm_statement_29:
    pushl -176(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_92
    pushl -176(%ebp)
    jmp .Lparse_asm_statement_93
.Lparse_asm_statement_92:
    leal ark_str_79, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
.Lparse_asm_statement_93:
    popl %eax
    movl %eax, -152(%ebp)
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_94
    jmp .Lparse_asm_statement_95
.Lparse_asm_statement_94:
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_96
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_asm_statement_97
.Lparse_asm_statement_96:
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_98
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_asm_statement_99
.Lparse_asm_statement_98:
    pushl -200(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_asm_statement_99:
.Lparse_asm_statement_97:
.Lparse_asm_statement_95:
    jmp .Lparse_asm_statement_20
.Lparse_asm_statement_21:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_100
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_asm_statement_101
.Lparse_asm_statement_100:
.Lparse_asm_statement_101:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_asm_statement_102
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_asm_statement_103
.Lparse_asm_statement_102:
.Lparse_asm_statement_103:
    pushl -200(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_declspec:
    pushl %ebp
    movl %esp, %ebp
    subl $448, %esp
    movl 8(%ebp), %eax
    movl %eax, -200(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -192(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -184(%ebp)
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_packed_ptr
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_mods_declspec
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_asm_fn
    addl $4, %esp
.Lparse_declspec_0:
    leal -112(%ebp), %eax
    pushl %eax
    pushl -200(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    addl $4, %esp
    leal -112(%ebp), %eax
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_4
    pushl -64(%ebp)
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_5
    pushl -64(%ebp)
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_6
    pushl -64(%ebp)
    pushl $68
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_7
    pushl -64(%ebp)
    pushl $69
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_8
    pushl -64(%ebp)
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_9
    pushl -64(%ebp)
    pushl $94
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_10
    pushl -64(%ebp)
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_11
    pushl -64(%ebp)
    pushl $71
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_12
    pushl -64(%ebp)
    pushl $72
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_13
    pushl -64(%ebp)
    pushl $73
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_14
    pushl -64(%ebp)
    pushl $77
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_15
    pushl -64(%ebp)
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_16
    pushl -64(%ebp)
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_17
    pushl -64(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_18
    pushl -64(%ebp)
    pushl $111
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_19
    pushl -64(%ebp)
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_20
    pushl -64(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_21
    pushl -64(%ebp)
    pushl $109
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_22
    pushl -64(%ebp)
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_23
    pushl -64(%ebp)
    pushl $107
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_24
    pushl -64(%ebp)
    pushl $118
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_25
    pushl -64(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_26
    pushl -64(%ebp)
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_27
    pushl -64(%ebp)
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_28
    pushl -64(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_29
    pushl -64(%ebp)
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_30
    pushl -64(%ebp)
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_31
    pushl -64(%ebp)
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_32
    pushl -64(%ebp)
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_33
    pushl -64(%ebp)
    pushl $113
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_34
    pushl -64(%ebp)
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_35
    pushl -64(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_36
    pushl -64(%ebp)
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_37
    pushl -64(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_38
    pushl -64(%ebp)
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_39
    pushl -64(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_40
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_41
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_42
    pushl -64(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_43
    pushl -64(%ebp)
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_44
    pushl -64(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_45
    pushl -64(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_46
    pushl -64(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_47
    pushl -64(%ebp)
    pushl $74
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_48
    pushl -64(%ebp)
    pushl $75
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_49
    pushl -64(%ebp)
    pushl $76
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_50
    pushl -64(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_51
    jmp .Lparse_declspec_52
.Lparse_declspec_4:
    pushl $0
    pushl -200(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_5:
.Lparse_declspec_6:
.Lparse_declspec_7:
.Lparse_declspec_8:
    leal -112(%ebp), %eax
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
    pushl $66
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_53
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_const
    addl $4, %esp
    jmp .Lparse_declspec_54
.Lparse_declspec_53:
.Lparse_declspec_54:
    leal -112(%ebp), %eax
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
    pushl $67
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_55
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_volatile
    addl $4, %esp
    jmp .Lparse_declspec_56
.Lparse_declspec_55:
.Lparse_declspec_56:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_9:
    pushl -200(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -56(%ebp), %eax
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
    call _is_basic_type_token
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_59
    leal -56(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_61
    leal -56(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_62
.Lparse_declspec_61:
    pushl $0
.Lparse_declspec_62:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_60
.Lparse_declspec_59:
    pushl $1
.Lparse_declspec_60:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_57
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_asm_fn
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_57:
.Lparse_declspec_58:
    jmp .L_parse_declspec_done
.Lparse_declspec_10:
    pushl $1
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_packed_ptr
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_11:
    pushl -176(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_12:
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_13:
    pushl -176(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_14:
    pushl -176(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_15:
    pushl $1
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_16:
    pushl $1
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_17:
    pushl $2
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_18:
    pushl -152(%ebp)
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_19:
    pushl $1
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_20:
    pushl -176(%ebp)
    pushl $65536
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_21:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_63
    call _type_char
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_64
.Lparse_declspec_63:
.Lparse_declspec_64:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_22:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_65
    call _type_short
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_66
.Lparse_declspec_65:
.Lparse_declspec_66:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_23:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_67
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_68
.Lparse_declspec_67:
.Lparse_declspec_68:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_24:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_69
    call _type_llong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_70
.Lparse_declspec_69:
.Lparse_declspec_70:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_25:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -200(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_71
    pushl $1
    popl %eax
    movl %eax, -56(%ebp)
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_declspec_73:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_75
    pushl -200(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_declspec_76
.Lparse_declspec_75:
    pushl $0
.Lparse_declspec_76:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_74
    pushl -200(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_77
    pushl -56(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_78
.Lparse_declspec_77:
    pushl -200(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_79
    pushl -56(%ebp)
    pushl -56(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_80
.Lparse_declspec_79:
.Lparse_declspec_80:
.Lparse_declspec_78:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declspec_73
.Lparse_declspec_74:
    jmp .Lparse_declspec_72
.Lparse_declspec_71:
.Lparse_declspec_72:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
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
    movl _g_func_mods_declspec, %eax
    pushl %eax
    pushl -200(%ebp)
    call _parse_func_modifiers
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_mods_declspec
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_40:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_81
    call _type_short
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_82
.Lparse_declspec_81:
.Lparse_declspec_82:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_41:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_83
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_84
.Lparse_declspec_83:
.Lparse_declspec_84:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_42:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_85
    call _type_char
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_86
.Lparse_declspec_85:
.Lparse_declspec_86:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_43:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_87
    call _type_void
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_88
.Lparse_declspec_87:
.Lparse_declspec_88:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_44:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_89
    call _type_bool
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_90
.Lparse_declspec_89:
.Lparse_declspec_90:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_45:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_91
    call _type_float
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_92
.Lparse_declspec_91:
.Lparse_declspec_92:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_46:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_93
    call _type_double
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_94
.Lparse_declspec_93:
.Lparse_declspec_94:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_47:
    movl $_g_config, %eax
    pushl %eax
    pushl $4
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
    je .Lparse_declspec_95
    pushl $1
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_96
.Lparse_declspec_95:
.Lparse_declspec_96:
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_48:
.Lparse_declspec_49:
    leal -112(%ebp), %eax
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
    pushl $75
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    pushl -200(%ebp)
    call _parse_struct_or_union
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_97
    pushl -48(%ebp)
    pushl $4
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
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_98
.Lparse_declspec_97:
.Lparse_declspec_98:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_101
    pushl -144(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_102
.Lparse_declspec_101:
    pushl $0
.Lparse_declspec_102:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_99
    pushl -144(%ebp)
    pushl $36
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
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_100
.Lparse_declspec_99:
.Lparse_declspec_100:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_50:
    pushl -200(%ebp)
    call _parse_enum
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_103
    pushl -56(%ebp)
    pushl $4
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
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_104
.Lparse_declspec_103:
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
.Lparse_declspec_104:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_51:
    leal -112(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_105
    leal -112(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_find_typedef
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -200(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_109
    pushl -56(%ebp)
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_110
.Lparse_declspec_109:
    pushl $0
.Lparse_declspec_110:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_107
    pushl -56(%ebp)
    pushl $8
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
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_108
.Lparse_declspec_107:
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
.Lparse_declspec_108:
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_2
.Lparse_declspec_105:
.Lparse_declspec_106:
    jmp .L_parse_declspec_done
.Lparse_declspec_52:
    jmp .L_parse_declspec_done
.Lparse_declspec_3:
.Lparse_declspec_2:
    jmp .Lparse_declspec_0
.Lparse_declspec_1:
.L_parse_declspec_done:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_111
    pushl -152(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_113
    call _type_llong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_114
.Lparse_declspec_113:
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_115
    call _type_long
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_116
.Lparse_declspec_115:
    pushl -160(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_117
    call _type_uint
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_118
.Lparse_declspec_117:
    pushl -136(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_119
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_120
.Lparse_declspec_119:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_declspec_120:
.Lparse_declspec_118:
.Lparse_declspec_116:
.Lparse_declspec_114:
    pushl -160(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_121
    pushl -144(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_124
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_125
    pushl -64(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_126
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_127
    pushl -64(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_128
    jmp .Lparse_declspec_129
.Lparse_declspec_124:
    call _type_uchar
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_123
.Lparse_declspec_125:
    call _type_ushort
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_123
.Lparse_declspec_126:
    call _type_uint
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_123
.Lparse_declspec_127:
    call _type_ulong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_123
.Lparse_declspec_128:
    call _type_ullong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_123
.Lparse_declspec_129:
    jmp .Lparse_declspec_123
.Lparse_declspec_123:
    jmp .Lparse_declspec_122
.Lparse_declspec_121:
.Lparse_declspec_122:
    jmp .Lparse_declspec_112
.Lparse_declspec_111:
    pushl -152(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_132
    pushl -144(%ebp)
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
    pushl $3
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
    jmp .Lparse_declspec_133
.Lparse_declspec_132:
    pushl $0
.Lparse_declspec_133:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_130
    call _type_llong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_131
.Lparse_declspec_130:
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_136
    pushl -144(%ebp)
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
    pushl $3
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
    jmp .Lparse_declspec_137
.Lparse_declspec_136:
    pushl $0
.Lparse_declspec_137:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_134
    call _type_long
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_135
.Lparse_declspec_134:
.Lparse_declspec_135:
.Lparse_declspec_131:
    pushl -160(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_138
    pushl -144(%ebp)
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
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_141
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_142
    pushl -64(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_143
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_144
    pushl -64(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_145
    jmp .Lparse_declspec_146
.Lparse_declspec_141:
    call _type_uchar
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_140
.Lparse_declspec_142:
    call _type_ushort
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_140
.Lparse_declspec_143:
    call _type_uint
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_140
.Lparse_declspec_144:
    call _type_ulong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_140
.Lparse_declspec_145:
    call _type_ullong
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_140
.Lparse_declspec_146:
    jmp .Lparse_declspec_140
.Lparse_declspec_140:
    jmp .Lparse_declspec_139
.Lparse_declspec_138:
.Lparse_declspec_139:
.Lparse_declspec_112:
    pushl -192(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_147
    pushl -192(%ebp)
    pushl -176(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_declspec_148
.Lparse_declspec_147:
.Lparse_declspec_148:
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_149
    pushl -184(%ebp)
    pushl -168(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_declspec_150
.Lparse_declspec_149:
.Lparse_declspec_150:
    pushl -128(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_153
    movl $_g_config, %eax
    pushl %eax
    pushl $4
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_154
.Lparse_declspec_153:
    pushl $0
.Lparse_declspec_154:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_151
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_157
    pushl -144(%ebp)
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
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_159
    pushl -144(%ebp)
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
    pushl $8
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
    jmp .Lparse_declspec_160
.Lparse_declspec_159:
    pushl $0
.Lparse_declspec_160:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_158
.Lparse_declspec_157:
    pushl $1
.Lparse_declspec_158:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_155
    call _type_double
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_156
.Lparse_declspec_155:
.Lparse_declspec_156:
    pushl -144(%ebp)
    call _type_complex
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_152
.Lparse_declspec_151:
.Lparse_declspec_152:
    movl _g_decl_is_volatile, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_declspec_163
    movl _g_decl_is_const, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declspec_164
.Lparse_declspec_163:
    pushl $1
.Lparse_declspec_164:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declspec_161
    movl _g_decl_is_const, %eax
    pushl %eax
    movl _g_decl_is_volatile, %eax
    pushl %eax
    pushl -144(%ebp)
    call _type_qualified
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_declspec_162
.Lparse_declspec_161:
.Lparse_declspec_162:
    pushl -144(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_struct_or_union:
    pushl %ebp
    movl %esp, %ebp
    subl $416, %esp
    movl 8(%ebp), %eax
    movl %eax, -168(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -72(%ebp)
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_struct_or_union_0:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_1
    pushl -136(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_2
    pushl -160(%ebp)
    pushl $0
    call _type_struct
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_struct_or_union_3
.Lparse_struct_or_union_2:
.Lparse_struct_or_union_3:
    pushl -136(%ebp)
    pushl -168(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lparse_struct_or_union_0
.Lparse_struct_or_union_1:
    leal -120(%ebp), %eax
    pushl %eax
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -120(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    addl $4, %esp
    leal -120(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_4
    leal -120(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    call _sym_find_tag
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_6
    pushl -64(%ebp)
    pushl $8
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
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_struct_or_union_7
.Lparse_struct_or_union_6:
.Lparse_struct_or_union_7:
    jmp .Lparse_struct_or_union_5
.Lparse_struct_or_union_4:
.Lparse_struct_or_union_5:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_8
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_10
    pushl -160(%ebp)
    pushl -152(%ebp)
    call _type_struct
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_12
    pushl $0
    pushl -144(%ebp)
    pushl -152(%ebp)
    pushl -160(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_14
    pushl $7
    jmp .Lparse_struct_or_union_15
.Lparse_struct_or_union_14:
    pushl $6
.Lparse_struct_or_union_15:
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .Lparse_struct_or_union_13
.Lparse_struct_or_union_12:
.Lparse_struct_or_union_13:
    jmp .Lparse_struct_or_union_11
.Lparse_struct_or_union_10:
.Lparse_struct_or_union_11:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_18
    pushl -136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_struct_or_union_19
.Lparse_struct_or_union_18:
    pushl $0
.Lparse_struct_or_union_19:
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_16
    pushl -136(%ebp)
    pushl $36
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
    je .Lparse_struct_or_union_20
    pushl -144(%ebp)
    pushl $36
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
    jmp .Lparse_struct_or_union_21
.Lparse_struct_or_union_20:
.Lparse_struct_or_union_21:
    pushl -136(%ebp)
    pushl $40
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
    je .Lparse_struct_or_union_22
    pushl -144(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $40
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
    jmp .Lparse_struct_or_union_23
.Lparse_struct_or_union_22:
.Lparse_struct_or_union_23:
    jmp .Lparse_struct_or_union_17
.Lparse_struct_or_union_16:
.Lparse_struct_or_union_17:
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_struct_or_union_24:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_26
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_struct_or_union_27
.Lparse_struct_or_union_26:
    pushl $0
.Lparse_struct_or_union_27:
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_25
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    leal -56(%ebp), %eax
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
    pushl -168(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_28
    leal ark_str_80, %eax
    pushl %eax
    pushl -168(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_24
.Lparse_struct_or_union_28:
.Lparse_struct_or_union_29:
.Lparse_struct_or_union_30:
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    leal -40(%ebp), %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -168(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_33
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_35
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_36
.Lparse_struct_or_union_35:
.Lparse_struct_or_union_36:
    jmp .Lparse_struct_or_union_34
.Lparse_struct_or_union_33:
.Lparse_struct_or_union_34:
.Lparse_struct_or_union_37:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_38
    pushl -144(%ebp)
    pushl -168(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_37
.Lparse_struct_or_union_38:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_39
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_41
    pushl -40(%ebp)
    jmp .Lparse_struct_or_union_42
.Lparse_struct_or_union_41:
    leal ark_str_81, %eax
    pushl %eax
.Lparse_struct_or_union_42:
    pushl -144(%ebp)
    call _type_struct_add_bitfield
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_40
.Lparse_struct_or_union_39:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_43
    pushl -32(%ebp)
    pushl -40(%ebp)
    pushl -144(%ebp)
    call _type_struct_add_field
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_44
.Lparse_struct_or_union_43:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_47
    pushl -32(%ebp)
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
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_struct_or_union_49
    pushl -32(%ebp)
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
    pushl $12
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
    jmp .Lparse_struct_or_union_50
.Lparse_struct_or_union_49:
    pushl $1
.Lparse_struct_or_union_50:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_struct_or_union_48
.Lparse_struct_or_union_47:
    pushl $0
.Lparse_struct_or_union_48:
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_45
    pushl -32(%ebp)
    pushl -144(%ebp)
    call _type_struct_add_anonymous
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_46
.Lparse_struct_or_union_45:
.Lparse_struct_or_union_46:
.Lparse_struct_or_union_44:
.Lparse_struct_or_union_40:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_51
    pushl -168(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_32
.Lparse_struct_or_union_51:
.Lparse_struct_or_union_52:
    jmp .Lparse_struct_or_union_31
.Lparse_struct_or_union_32:
    jmp .Lparse_struct_or_union_30
.Lparse_struct_or_union_31:
    pushl $54
    pushl -168(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_24
.Lparse_struct_or_union_25:
    pushl $51
    pushl -168(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lparse_struct_or_union_53:
    pushl -168(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_54
    pushl -144(%ebp)
    pushl -168(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_53
.Lparse_struct_or_union_54:
    jmp .Lparse_struct_or_union_9
.Lparse_struct_or_union_8:
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_55
    pushl -160(%ebp)
    pushl -152(%ebp)
    call _type_struct
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_59
    pushl -136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_struct_or_union_60
.Lparse_struct_or_union_59:
    pushl $0
.Lparse_struct_or_union_60:
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_57
    pushl -136(%ebp)
    pushl $36
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
    je .Lparse_struct_or_union_61
    pushl -144(%ebp)
    pushl $36
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
    jmp .Lparse_struct_or_union_62
.Lparse_struct_or_union_61:
.Lparse_struct_or_union_62:
    pushl -136(%ebp)
    pushl $40
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
    je .Lparse_struct_or_union_63
    pushl -144(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $40
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
    jmp .Lparse_struct_or_union_64
.Lparse_struct_or_union_63:
.Lparse_struct_or_union_64:
    jmp .Lparse_struct_or_union_58
.Lparse_struct_or_union_57:
.Lparse_struct_or_union_58:
    pushl -152(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_65
    pushl $0
    pushl -144(%ebp)
    pushl -152(%ebp)
    pushl -160(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_67
    pushl $7
    jmp .Lparse_struct_or_union_68
.Lparse_struct_or_union_67:
    pushl $6
.Lparse_struct_or_union_68:
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_struct_or_union_66
.Lparse_struct_or_union_65:
.Lparse_struct_or_union_66:
    jmp .Lparse_struct_or_union_56
.Lparse_struct_or_union_55:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_71
    pushl -136(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_struct_or_union_72
.Lparse_struct_or_union_71:
    pushl $0
.Lparse_struct_or_union_72:
    popl %eax
    cmpl $0, %eax
    je .Lparse_struct_or_union_69
    pushl -136(%ebp)
    pushl $36
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
    je .Lparse_struct_or_union_73
    pushl -144(%ebp)
    pushl $36
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
    jmp .Lparse_struct_or_union_74
.Lparse_struct_or_union_73:
.Lparse_struct_or_union_74:
    pushl -136(%ebp)
    pushl $40
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
    je .Lparse_struct_or_union_75
    pushl -144(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    pushl $40
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
    jmp .Lparse_struct_or_union_76
.Lparse_struct_or_union_75:
.Lparse_struct_or_union_76:
    jmp .Lparse_struct_or_union_70
.Lparse_struct_or_union_69:
.Lparse_struct_or_union_70:
.Lparse_struct_or_union_56:
.Lparse_struct_or_union_9:
    pushl -72(%ebp)
    pushl $3
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_enum:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -88(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_0
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_enum_1
.Lparse_enum_0:
.Lparse_enum_1:
    pushl -112(%ebp)
    call _type_enum
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_2
    pushl $0
    pushl -104(%ebp)
    pushl -112(%ebp)
    pushl $8
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_enum_3
.Lparse_enum_2:
.Lparse_enum_3:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_4
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_enum_6:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_8
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_enum_9
.Lparse_enum_8:
    pushl $0
.Lparse_enum_9:
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_7
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -80(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_10
    leal ark_str_82, %eax
    pushl %eax
    pushl -120(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_enum_6
.Lparse_enum_10:
.Lparse_enum_11:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_12
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    call _parse_cond_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -24(%ebp)
    movl %edx, -20(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_16
    leal -24(%ebp), %eax
    pushl %eax
    pushl -32(%ebp)
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_enum_17
.Lparse_enum_16:
    pushl $0
.Lparse_enum_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_14
    pushl -24(%ebp)
    pushl -20(%ebp)
    addl $4, %esp
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Lparse_enum_15
.Lparse_enum_14:
    leal ark_str_83, %eax
    pushl %eax
    pushl -120(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lparse_enum_15:
    jmp .Lparse_enum_13
.Lparse_enum_12:
.Lparse_enum_13:
    pushl $0
    call _type_int
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    pushl $24
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
    pushl $5
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_enum_18
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_enum_19
.Lparse_enum_18:
.Lparse_enum_19:
    jmp .Lparse_enum_6
.Lparse_enum_7:
    pushl $51
    pushl -120(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_enum_5
.Lparse_enum_4:
.Lparse_enum_5:
    pushl -88(%ebp)
    pushl $3
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -80(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -80(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_declarator:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -104(%ebp)
    pushl -112(%ebp)
    popl %eax
    movl %eax, -96(%ebp)
.Lparse_declarator_0:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_1
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -80(%ebp), %eax
    pushl %eax
    leal -88(%ebp), %eax
    pushl %eax
    pushl -120(%ebp)
    call _skip_qualifiers
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_2
    pushl -96(%ebp)
    pushl $48
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
    jmp .Lparse_declarator_3
.Lparse_declarator_2:
.Lparse_declarator_3:
    pushl -80(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_4
    pushl -96(%ebp)
    pushl $52
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
    jmp .Lparse_declarator_5
.Lparse_declarator_4:
.Lparse_declarator_5:
    movl _g_decl_packed_ptr, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_6
    pushl -96(%ebp)
    pushl $36
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
    jmp .Lparse_declarator_7
.Lparse_declarator_6:
.Lparse_declarator_7:
    jmp .Lparse_declarator_0
.Lparse_declarator_1:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_10
    pushl -120(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
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
    pushl $17
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
    jmp .Lparse_declarator_11
.Lparse_declarator_10:
    pushl $0
.Lparse_declarator_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_8
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_declarator_12:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_13
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_12
.Lparse_declarator_13:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_14
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_16
    pushl -104(%ebp)
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_declarator_17
.Lparse_declarator_16:
.Lparse_declarator_17:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_15
.Lparse_declarator_14:
.Lparse_declarator_15:
    pushl $49
    pushl -120(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_18
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lparse_declarator_20:
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_22
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_declarator_23
.Lparse_declarator_22:
    pushl $0
.Lparse_declarator_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_21
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_24
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_25
.Lparse_declarator_24:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_26
    pushl -88(%ebp)
    pushl -88(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_27
.Lparse_declarator_26:
.Lparse_declarator_27:
.Lparse_declarator_25:
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_28
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_29
.Lparse_declarator_28:
.Lparse_declarator_29:
    jmp .Lparse_declarator_20
.Lparse_declarator_21:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_30
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_31
.Lparse_declarator_30:
.Lparse_declarator_31:
    jmp .Lparse_declarator_19
.Lparse_declarator_18:
.Lparse_declarator_19:
    pushl -96(%ebp)
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_declarator_8:
.Lparse_declarator_9:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_32
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_34
    pushl -104(%ebp)
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_declarator_35
.Lparse_declarator_34:
.Lparse_declarator_35:
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_33
.Lparse_declarator_32:
.Lparse_declarator_33:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_36
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_38
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_declarator_40:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_42
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_declarator_43
.Lparse_declarator_42:
    pushl $0
.Lparse_declarator_43:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_41
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_40
.Lparse_declarator_41:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_44
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_45
.Lparse_declarator_44:
.Lparse_declarator_45:
    jmp .Lparse_declarator_39
.Lparse_declarator_38:
.Lparse_declarator_39:
    jmp .Lparse_declarator_37
.Lparse_declarator_36:
.Lparse_declarator_37:
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_declarator_46:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_47
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_48
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_49
.Lparse_declarator_48:
.Lparse_declarator_49:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_50
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_51
.Lparse_declarator_50:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_52
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_53
.Lparse_declarator_52:
    pushl -120(%ebp)
    call _parse_cond_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -16(%ebp)
    movl %edx, -12(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_58
    leal -16(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declarator_59
.Lparse_declarator_58:
    pushl $0
.Lparse_declarator_59:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_56
    pushl -16(%ebp)
    pushl -12(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jg .L64t_parse_declarator_622
    jl .L64f_parse_declarator_622
    cmpl %eax, (%esp)
    jg .L64t_parse_declarator_622
.L64f_parse_declarator_622:
    addl $4, %esp
    pushl $0
    jmp .L64e_parse_declarator_622
.L64t_parse_declarator_622:
    addl $4, %esp
    pushl $1
.L64e_parse_declarator_622:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_declarator_57
.Lparse_declarator_56:
    pushl $0
.Lparse_declarator_57:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_54
    pushl -16(%ebp)
    pushl -12(%ebp)
    addl $4, %esp
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_55
.Lparse_declarator_54:
    movl $_g_config, %eax
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
    je .Lparse_declarator_66
    pushl -48(%ebp)
    pushl $0
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
    jmp .Lparse_declarator_67
.Lparse_declarator_66:
    pushl $0
.Lparse_declarator_67:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_64
    movl _g_vla_size_expr, %eax
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
    jmp .Lparse_declarator_65
.Lparse_declarator_64:
    pushl $0
.Lparse_declarator_65:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_62
    pushl -32(%ebp)
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
    jmp .Lparse_declarator_63
.Lparse_declarator_62:
    pushl $0
.Lparse_declarator_63:
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_60
    pushl -56(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_vla_size_expr
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_61
.Lparse_declarator_60:
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lparse_declarator_61:
.Lparse_declarator_55:
.Lparse_declarator_53:
.Lparse_declarator_51:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $53
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_68
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_declarator_69
.Lparse_declarator_68:
.Lparse_declarator_69:
    pushl -56(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_70
    leal -88(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_declarator_71
.Lparse_declarator_70:
.Lparse_declarator_71:
    jmp .Lparse_declarator_46
.Lparse_declarator_47:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_72
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lparse_declarator_74:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_75
    pushl -40(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_declarator_77
    pushl -96(%ebp)
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    pushl $44
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
    jmp .Lparse_declarator_78
.Lparse_declarator_77:
    leal -88(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
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
    pushl -96(%ebp)
    call _type_array
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lparse_declarator_78:
.Lparse_declarator_76:
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    addl $4, %esp
    jmp .Lparse_declarator_74
.Lparse_declarator_75:
    jmp .Lparse_declarator_73
.Lparse_declarator_72:
.Lparse_declarator_73:
    pushl -96(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_at_keyword:
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _lexer_peek
    addl $4, %esp
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
    pushl $96
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_at_keyword_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_at_keyword_0:
.Lparse_at_keyword_1:
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_at_keyword_2
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_at_keyword_4
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_at_addr
    addl $4, %esp
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_has_at
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_at_keyword_5
.Lparse_at_keyword_4:
.Lparse_at_keyword_5:
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_at_keyword_6
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_at_keyword_7
.Lparse_at_keyword_6:
.Lparse_at_keyword_7:
    jmp .Lparse_at_keyword_3
.Lparse_at_keyword_2:
.Lparse_at_keyword_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_global_reg:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $103
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_global_reg_0
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_global_reg_0:
.Lparse_global_reg_1:
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_global_reg_2
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_global_reg_4
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_global_reg_5
.Lparse_global_reg_4:
.Lparse_global_reg_5:
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_global_reg_6
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_global_reg_7
.Lparse_global_reg_6:
.Lparse_global_reg_7:
    jmp .Lparse_global_reg_3
.Lparse_global_reg_2:
.Lparse_global_reg_3:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_smc:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $106
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_smc_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_smc_0:
.Lparse_smc_1:
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_smc_2
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_smc_4
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_smc_5
.Lparse_smc_4:
.Lparse_smc_5:
    pushl -24(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_smc_6
    pushl -24(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_smc_7
.Lparse_smc_6:
.Lparse_smc_7:
    jmp .Lparse_smc_3
.Lparse_smc_2:
.Lparse_smc_3:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_top_decl:
    pushl %ebp
    movl %esp, %ebp
    subl $576, %esp
    movl 8(%ebp), %eax
    movl %eax, -328(%ebp)
    pushl $0
    popl %eax
    movl %eax, -320(%ebp)
    pushl $0
    popl %eax
    movl %eax, -312(%ebp)
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -296(%ebp)
    pushl $0
    popl %eax
    movl %eax, -288(%ebp)
    pushl $0
    popl %eax
    movl %eax, -280(%ebp)
    pushl $0
    popl %eax
    movl %eax, -272(%ebp)
    pushl $0
    popl %eax
    movl %eax, -264(%ebp)
    pushl $0
    popl %eax
    movl %eax, -256(%ebp)
    pushl $0
    popl %eax
    movl %eax, -248(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -240(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -232(%ebp)
    pushl $0
    popl %eax
    movl %eax, -224(%ebp)
    pushl $0
    popl %eax
    movl %eax, -216(%ebp)
    pushl $0
    popl %eax
    movl %eax, -208(%ebp)
    pushl $0
    popl %eax
    movl %eax, -200(%ebp)
    pushl $0
    popl %eax
    movl %eax, -192(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_weak
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_naked
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_irq
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_const
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_volatile
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_used
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_unused
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_alias_target
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_align_bytes
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_align_bytes
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_softfp
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_forceinline
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_has_at
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_at_addr
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_constructor
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_destructor
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_deprecated
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_packed_ptr
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_vla_size_expr
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_value_in_regs
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_pure
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_const_attr
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_interwork
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_func_is_deprecated_kw
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_0
    pushl -328(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
    pushl %eax
    leal -184(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -184(%ebp), %eax
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
    call _is_basic_type_token
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_4
    leal -184(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_6
    leal -184(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_7
.Lparse_top_decl_6:
    pushl $0
.Lparse_top_decl_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_5
.Lparse_top_decl_4:
    pushl $1
.Lparse_top_decl_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_2
    pushl $1
    popl %eax
    movl %eax, -264(%ebp)
    pushl -264(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_3
.Lparse_top_decl_2:
.Lparse_top_decl_3:
    jmp .Lparse_top_decl_1
.Lparse_top_decl_0:
.Lparse_top_decl_1:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $95
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_8
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_10
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_12
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -256(%ebp)
    pushl -256(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_13
.Lparse_top_decl_12:
.Lparse_top_decl_13:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_14
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_15
.Lparse_top_decl_14:
.Lparse_top_decl_15:
    jmp .Lparse_top_decl_11
.Lparse_top_decl_10:
.Lparse_top_decl_11:
    jmp .Lparse_top_decl_9
.Lparse_top_decl_8:
.Lparse_top_decl_9:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $96
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_16
    pushl -328(%ebp)
    call _parse_at_keyword
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_17
.Lparse_top_decl_16:
.Lparse_top_decl_17:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $103
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_18
    pushl -328(%ebp)
    call _parse_global_reg
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -232(%ebp)
    pushl -232(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_19
.Lparse_top_decl_18:
.Lparse_top_decl_19:
    pushl -288(%ebp)
    pushl -328(%ebp)
    call _parse_func_modifiers
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    leal -312(%ebp), %eax
    pushl %eax
    leal -320(%ebp), %eax
    pushl %eax
    pushl -328(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -304(%ebp)
    pushl -304(%ebp)
    addl $4, %esp
    pushl -288(%ebp)
    movl _g_func_mods_declspec, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
    movl _g_decl_is_asm_fn, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -264(%ebp)
    pushl -264(%ebp)
    addl $4, %esp
    movl _g_decl_is_const, %eax
    pushl %eax
    popl %eax
    movl %eax, -280(%ebp)
    pushl -280(%ebp)
    addl $4, %esp
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    movl %eax, -272(%ebp)
    pushl -272(%ebp)
    addl $4, %esp
    movl _g_attr_align_bytes, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_22
    pushl -256(%ebp)
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
    jmp .Lparse_top_decl_23
.Lparse_top_decl_22:
    pushl $0
.Lparse_top_decl_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_20
    movl _g_attr_align_bytes, %eax
    pushl %eax
    popl %eax
    movl %eax, -256(%ebp)
    pushl -256(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_21
.Lparse_top_decl_20:
.Lparse_top_decl_21:
    pushl -320(%ebp)
    pushl $65536
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_24
    pushl $1
    jmp .Lparse_top_decl_25
.Lparse_top_decl_24:
    pushl $0
.Lparse_top_decl_25:
    popl %eax
    movl %eax, -248(%ebp)
    pushl -248(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $103
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_28
    pushl -232(%ebp)
    pushl $0
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
    jmp .Lparse_top_decl_29
.Lparse_top_decl_28:
    pushl $0
.Lparse_top_decl_29:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_26
    pushl -328(%ebp)
    call _parse_global_reg
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -232(%ebp)
    pushl -232(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_27
.Lparse_top_decl_26:
.Lparse_top_decl_27:
    pushl -304(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_30
    leal ark_str_84, %eax
    pushl %eax
    pushl -328(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_30:
.Lparse_top_decl_31:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_32
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -296(%ebp)
    pushl $4
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_32:
.Lparse_top_decl_33:
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl $0
    popl %eax
    movl %eax, -176(%ebp)
    pushl -288(%ebp)
    pushl -328(%ebp)
    call _parse_func_modifiers
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $90
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_34
    pushl -328(%ebp)
    call _parse_svc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_35
.Lparse_top_decl_34:
.Lparse_top_decl_35:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $106
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_36
    pushl -328(%ebp)
    call _parse_smc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -240(%ebp)
    pushl -240(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_37
.Lparse_top_decl_36:
.Lparse_top_decl_37:
    pushl -288(%ebp)
    pushl -328(%ebp)
    call _parse_func_modifiers
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    movl _g_func_is_value_in_regs, %eax
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    pushl -224(%ebp)
    addl $4, %esp
    movl _g_func_is_pure, %eax
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    movl _g_func_is_const_attr, %eax
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    movl _g_func_is_interwork, %eax
    pushl %eax
    popl %eax
    movl %eax, -200(%ebp)
    pushl -200(%ebp)
    addl $4, %esp
    movl _g_func_is_deprecated_kw, %eax
    pushl %eax
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    leal -184(%ebp), %eax
    pushl %eax
    pushl -304(%ebp)
    pushl -328(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_38
    leal ark_str_85, %eax
    pushl %eax
    pushl -328(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_38:
.Lparse_top_decl_39:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_40
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl -168(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_44
    pushl -328(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
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
    pushl $49
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
    jmp .Lparse_top_decl_45
.Lparse_top_decl_44:
    pushl $0
.Lparse_top_decl_45:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_42
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_43
.Lparse_top_decl_42:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_46
.Lparse_top_decl_48:
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $86
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_51
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_49
.Lparse_top_decl_51:
.Lparse_top_decl_52:
    leal -104(%ebp), %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    pushl -328(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_53
    leal ark_str_86, %eax
    pushl %eax
    pushl -328(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_49
.Lparse_top_decl_53:
.Lparse_top_decl_54:
    leal -80(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -328(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_57
    pushl -88(%ebp)
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
    pushl $10
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
    jmp .Lparse_top_decl_58
.Lparse_top_decl_57:
    pushl $0
.Lparse_top_decl_58:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_55
    pushl -88(%ebp)
    pushl $4
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
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_56
.Lparse_top_decl_55:
.Lparse_top_decl_56:
    pushl -80(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_59
    leal ark_str_87, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_60
.Lparse_top_decl_59:
.Lparse_top_decl_60:
    pushl -296(%ebp)
    pushl $0
    pushl -88(%ebp)
    pushl -80(%ebp)
    call _ast_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -152(%ebp)
    pushl -144(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_61
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_63
    pushl -144(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lparse_top_decl_64
.Lparse_top_decl_63:
    pushl $4
.Lparse_top_decl_64:
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -160(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_62
.Lparse_top_decl_61:
.Lparse_top_decl_62:
    pushl -160(%ebp)
    pushl -152(%ebp)
    pushl -152(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_65
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_50
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
    pushl $49
    pushl -328(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lparse_top_decl_67:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_68
    pushl -128(%ebp)
    pushl -328(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_67
.Lparse_top_decl_68:
    pushl -288(%ebp)
    pushl -328(%ebp)
    call _parse_func_modifiers
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    movl _g_attr_is_irq, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_69
    pushl -288(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_70
.Lparse_top_decl_69:
.Lparse_top_decl_70:
    movl _g_attr_is_weak, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_71
    pushl -288(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_72
.Lparse_top_decl_71:
.Lparse_top_decl_72:
    movl _g_attr_is_naked, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_73
    pushl -288(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -288(%ebp)
    pushl -288(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_74
.Lparse_top_decl_73:
.Lparse_top_decl_74:
    movl _g_func_is_value_in_regs, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_75
    pushl $1
    popl %eax
    movl %eax, -224(%ebp)
    pushl -224(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_76
.Lparse_top_decl_75:
.Lparse_top_decl_76:
    movl _g_func_is_pure, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_77
    pushl $1
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_78
.Lparse_top_decl_77:
.Lparse_top_decl_78:
    movl _g_func_is_const_attr, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_79
    pushl $1
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_80
.Lparse_top_decl_79:
.Lparse_top_decl_80:
    movl _g_func_is_interwork, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_81
    pushl $1
    popl %eax
    movl %eax, -200(%ebp)
    pushl -200(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_82
.Lparse_top_decl_81:
.Lparse_top_decl_82:
    movl _g_func_is_deprecated_kw, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_83
    pushl $1
    popl %eax
    movl %eax, -192(%ebp)
    pushl -192(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_84
.Lparse_top_decl_83:
.Lparse_top_decl_84:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_85
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -296(%ebp)
    pushl $0
    pushl -152(%ebp)
    pushl -160(%ebp)
    pushl -128(%ebp)
    pushl -184(%ebp)
    call _ast_func_def
    addl $24, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $2
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_87
    pushl $1
    jmp .Lparse_top_decl_88
.Lparse_top_decl_87:
    pushl $0
.Lparse_top_decl_88:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_89
    pushl $1
    jmp .Lparse_top_decl_90
.Lparse_top_decl_89:
    pushl $0
.Lparse_top_decl_90:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_91
    pushl $1
    jmp .Lparse_top_decl_92
.Lparse_top_decl_91:
    pushl $0
.Lparse_top_decl_92:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_93
    pushl $1
    jmp .Lparse_top_decl_94
.Lparse_top_decl_93:
    pushl $0
.Lparse_top_decl_94:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_97
    movl _g_attr_is_softfp, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_98
.Lparse_top_decl_97:
    pushl $1
.Lparse_top_decl_98:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_95
    pushl $1
    jmp .Lparse_top_decl_96
.Lparse_top_decl_95:
    pushl $0
.Lparse_top_decl_96:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_101
    movl _g_attr_is_forceinline, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_102
.Lparse_top_decl_101:
    pushl $1
.Lparse_top_decl_102:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_99
    pushl $1
    jmp .Lparse_top_decl_100
.Lparse_top_decl_99:
    pushl $0
.Lparse_top_decl_100:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_used, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_unused, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_alias_target, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $72
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_constructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_destructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_deprecated, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -224(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -216(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -208(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -200(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -240(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -232(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
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
    pushl -192(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_85:
.Lparse_top_decl_86:
    pushl -264(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_103
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_105
    leal ark_str_88, %eax
    pushl %eax
    pushl -328(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_106
.Lparse_top_decl_105:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    pushl $32
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
    je .Lparse_top_decl_107
    leal -80(%ebp), %eax
    pushl %eax
    pushl $32
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
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    jmp .Lparse_top_decl_108
.Lparse_top_decl_107:
    pushl $0
.Lparse_top_decl_108:
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
.Lparse_top_decl_109:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_112
    jmp .Lparse_top_decl_110
.Lparse_top_decl_112:
.Lparse_top_decl_113:
    pushl -24(%ebp)
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_114
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_111
.Lparse_top_decl_114:
.Lparse_top_decl_115:
    pushl -24(%ebp)
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_116
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_118
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $32
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
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_110
.Lparse_top_decl_118:
.Lparse_top_decl_119:
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_111
.Lparse_top_decl_116:
.Lparse_top_decl_117:
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_top_decl_111:
    jmp .Lparse_top_decl_109
.Lparse_top_decl_110:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_124
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_125
.Lparse_top_decl_124:
    pushl $0
.Lparse_top_decl_125:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_122
    pushl -96(%ebp)
    pushl -104(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_123
.Lparse_top_decl_122:
    pushl $0
.Lparse_top_decl_123:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_120
    pushl -96(%ebp)
    pushl -104(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl -104(%ebp)
    call _mem_strndup
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_121
.Lparse_top_decl_120:
    leal ark_str_89, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lparse_top_decl_121:
.Lparse_top_decl_106:
    pushl -296(%ebp)
    pushl $0
    pushl -152(%ebp)
    pushl -160(%ebp)
    pushl -128(%ebp)
    pushl -184(%ebp)
    call _ast_func_def
    addl $24, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $36
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_126
    pushl $1
    jmp .Lparse_top_decl_127
.Lparse_top_decl_126:
    pushl $0
.Lparse_top_decl_127:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $60
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
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -88(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_used, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_unused, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_alias_target, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $72
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_constructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_destructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_deprecated, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -224(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -216(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -208(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -200(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -240(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -232(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
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
    pushl -192(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_103:
.Lparse_top_decl_104:
    pushl -184(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_current_func_name
    addl $4, %esp
    pushl -328(%ebp)
    call _parse_block
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    pushl -120(%ebp)
    pushl -152(%ebp)
    pushl -160(%ebp)
    pushl -128(%ebp)
    pushl -184(%ebp)
    call _ast_func_def
    addl $24, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_128
    pushl $1
    jmp .Lparse_top_decl_129
.Lparse_top_decl_128:
    pushl $0
.Lparse_top_decl_129:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_130
    pushl $1
    jmp .Lparse_top_decl_131
.Lparse_top_decl_130:
    pushl $0
.Lparse_top_decl_131:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_132
    pushl $1
    jmp .Lparse_top_decl_133
.Lparse_top_decl_132:
    pushl $0
.Lparse_top_decl_133:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_134
    pushl $1
    jmp .Lparse_top_decl_135
.Lparse_top_decl_134:
    pushl $0
.Lparse_top_decl_135:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $68
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_138
    movl _g_attr_is_softfp, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_139
.Lparse_top_decl_138:
    pushl $1
.Lparse_top_decl_139:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_136
    pushl $1
    jmp .Lparse_top_decl_137
.Lparse_top_decl_136:
    pushl $0
.Lparse_top_decl_137:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -288(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_142
    movl _g_attr_is_forceinline, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_top_decl_143
.Lparse_top_decl_142:
    pushl $1
.Lparse_top_decl_143:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_140
    pushl $1
    jmp .Lparse_top_decl_141
.Lparse_top_decl_140:
    pushl $0
.Lparse_top_decl_141:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_used, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_unused, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_alias_target, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $72
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_constructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $76
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_destructor, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_deprecated, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -224(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $96
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -216(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $100
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -208(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -200(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $108
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -240(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -232(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -112(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $80
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
    pushl -192(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_current_func_name
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_40:
.Lparse_top_decl_41:
    pushl -312(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_144
    pushl $0
    pushl -168(%ebp)
    pushl -184(%ebp)
    pushl $4
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lparse_top_decl_146:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_147
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -160(%ebp), %eax
    pushl %eax
    pushl -304(%ebp)
    pushl -328(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_148
    pushl $0
    pushl -168(%ebp)
    pushl -160(%ebp)
    pushl $4
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_149
.Lparse_top_decl_148:
.Lparse_top_decl_149:
    jmp .Lparse_top_decl_146
.Lparse_top_decl_147:
    pushl $54
    pushl -328(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -296(%ebp)
    pushl $31
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -160(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -160(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_top_decl_144:
.Lparse_top_decl_145:
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl -272(%ebp)
    popl %eax
    movl %eax, -152(%ebp)
    pushl -280(%ebp)
    popl %eax
    movl %eax, -144(%ebp)
.Lparse_top_decl_150:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_top_decl_152
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $96
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
    jmp .Lparse_top_decl_153
.Lparse_top_decl_152:
    pushl $1
.Lparse_top_decl_153:
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_151
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $96
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_154
    pushl -328(%ebp)
    call _parse_at_keyword
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_155
.Lparse_top_decl_154:
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    pushl -168(%ebp)
    pushl -328(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_156
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_157
.Lparse_top_decl_156:
.Lparse_top_decl_157:
.Lparse_top_decl_155:
    jmp .Lparse_top_decl_150
.Lparse_top_decl_151:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_158
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -328(%ebp)
    call _parse_initializer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_159
.Lparse_top_decl_158:
.Lparse_top_decl_159:
    pushl -160(%ebp)
    pushl -168(%ebp)
    call _infer_array_size_from_init
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    pushl -168(%ebp)
    pushl -184(%ebp)
    pushl $0
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -296(%ebp)
    pushl -160(%ebp)
    pushl -168(%ebp)
    pushl -184(%ebp)
    call _ast_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_160
    pushl $1
    jmp .Lparse_top_decl_161
.Lparse_top_decl_160:
    pushl $0
.Lparse_top_decl_161:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_162
    pushl $1
    jmp .Lparse_top_decl_163
.Lparse_top_decl_162:
    pushl $0
.Lparse_top_decl_163:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -152(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -256(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_164
    pushl -256(%ebp)
    jmp .Lparse_top_decl_165
.Lparse_top_decl_164:
    movl _g_attr_align_bytes, %eax
    pushl %eax
.Lparse_top_decl_165:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_used, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_unused, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_has_at, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_at_addr, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -248(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -232(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_top_decl_166:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_167
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -128(%ebp), %eax
    pushl %eax
    pushl -304(%ebp)
    pushl -328(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
.Lparse_top_decl_168:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_169
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    pushl -120(%ebp)
    pushl -328(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_170
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_171
.Lparse_top_decl_170:
.Lparse_top_decl_171:
    jmp .Lparse_top_decl_168
.Lparse_top_decl_169:
    pushl -328(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_172
    pushl -328(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -328(%ebp)
    call _parse_initializer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_173
.Lparse_top_decl_172:
.Lparse_top_decl_173:
    pushl -112(%ebp)
    pushl -120(%ebp)
    call _infer_array_size_from_init
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_174
    pushl $0
    pushl -120(%ebp)
    pushl -128(%ebp)
    pushl $0
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_top_decl_175
.Lparse_top_decl_174:
.Lparse_top_decl_175:
    pushl -128(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_176
    pushl -296(%ebp)
    pushl -112(%ebp)
    pushl -120(%ebp)
    pushl -128(%ebp)
    call _ast_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -96(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_178
    pushl $1
    jmp .Lparse_top_decl_179
.Lparse_top_decl_178:
    pushl $0
.Lparse_top_decl_179:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -96(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -320(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_180
    pushl $1
    jmp .Lparse_top_decl_181
.Lparse_top_decl_180:
    pushl $0
.Lparse_top_decl_181:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -96(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -96(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
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
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_top_decl_182
    pushl -296(%ebp)
    call _ast_block
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -136(%ebp)
    pushl -88(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    pushl -88(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_top_decl_183
.Lparse_top_decl_182:
    pushl -96(%ebp)
    pushl -136(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lparse_top_decl_183:
    jmp .Lparse_top_decl_177
.Lparse_top_decl_176:
.Lparse_top_decl_177:
    jmp .Lparse_top_decl_166
.Lparse_top_decl_167:
    pushl $54
    pushl -328(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_block:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl $50
    pushl -40(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    call _sym_enter_scope
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    call _ast_block
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_block_0:
    pushl -40(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $51
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_block_2
    pushl -40(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    jmp .Lparse_block_3
.Lparse_block_2:
    pushl $0
.Lparse_block_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_block_1
    pushl -40(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_block_4
    pushl -16(%ebp)
    pushl -24(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_block_5
.Lparse_block_4:
.Lparse_block_5:
    jmp .Lparse_block_0
.Lparse_block_1:
    call _sym_leave_scope
    pushl %eax
    addl $4, %esp
    pushl $51
    pushl -40(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_local_var_decl:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -112(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -104(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -96(%ebp)
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -88(%ebp)
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    movl _g_decl_is_const, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
.Lparse_local_var_decl_0:
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    leal -64(%ebp), %eax
    pushl %eax
    pushl -112(%ebp)
    pushl -120(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_3
    leal ark_str_90, %eax
    pushl %eax
    pushl -120(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_local_var_decl_1
.Lparse_local_var_decl_3:
.Lparse_local_var_decl_4:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_5
    pushl $0
    pushl -56(%ebp)
    pushl -64(%ebp)
    pushl $4
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_local_var_decl_6
.Lparse_local_var_decl_5:
.Lparse_local_var_decl_6:
.Lparse_local_var_decl_7:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $87
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_8
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    pushl -56(%ebp)
    pushl -120(%ebp)
    call _parse_attribute
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_9
    movl _g_attr_section, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_local_var_decl_10
.Lparse_local_var_decl_9:
.Lparse_local_var_decl_10:
    jmp .Lparse_local_var_decl_7
.Lparse_local_var_decl_8:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_11
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    call _parse_initializer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_local_var_decl_12
.Lparse_local_var_decl_11:
.Lparse_local_var_decl_12:
    pushl -48(%ebp)
    pushl -56(%ebp)
    call _infer_array_size_from_init
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl -48(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _ast_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_15
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_local_var_decl_16
.Lparse_local_var_decl_15:
    pushl $0
.Lparse_local_var_decl_16:
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_13
    pushl $0
    pushl -56(%ebp)
    pushl -64(%ebp)
    pushl $0
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_local_var_decl_14
.Lparse_local_var_decl_13:
.Lparse_local_var_decl_14:
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_17
    pushl $1
    jmp .Lparse_local_var_decl_18
.Lparse_local_var_decl_17:
    pushl $0
.Lparse_local_var_decl_18:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_19
    pushl $1
    jmp .Lparse_local_var_decl_20
.Lparse_local_var_decl_19:
    pushl $0
.Lparse_local_var_decl_20:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_align_bytes, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_used, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_attr_is_unused, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    pushl $65536
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_21
    pushl $1
    jmp .Lparse_local_var_decl_22
.Lparse_local_var_decl_21:
    pushl $0
.Lparse_local_var_decl_22:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_vla_size_expr, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_25
    movl $_g_config, %eax
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_local_var_decl_26
.Lparse_local_var_decl_25:
    pushl $0
.Lparse_local_var_decl_26:
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_23
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $52
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
    pushl -32(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_vla_size_expr, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_vla_size_expr
    addl $4, %esp
    jmp .Lparse_local_var_decl_24
.Lparse_local_var_decl_23:
.Lparse_local_var_decl_24:
    pushl -80(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_27
    pushl -32(%ebp)
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lparse_local_var_decl_28
.Lparse_local_var_decl_27:
    pushl -80(%ebp)
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
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_29
    pushl -88(%ebp)
    call _ast_block
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -80(%ebp)
    pushl -24(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lparse_local_var_decl_30
.Lparse_local_var_decl_29:
    pushl -32(%ebp)
    pushl -80(%ebp)
    call _block_add_stmt
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lparse_local_var_decl_30:
.Lparse_local_var_decl_28:
    pushl -120(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_local_var_decl_31
    pushl -120(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_local_var_decl_2
.Lparse_local_var_decl_31:
.Lparse_local_var_decl_32:
    jmp .Lparse_local_var_decl_1
.Lparse_local_var_decl_2:
    jmp .Lparse_local_var_decl_0
.Lparse_local_var_decl_1:
    pushl $54
    pushl -120(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_statement:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    pushl $28
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
    movl %eax, -80(%ebp)
    leal -128(%ebp), %eax
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
    pushl $88
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_0
    pushl -136(%ebp)
    call _parse_asm_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_0:
.Lparse_statement_1:
    pushl -136(%ebp)
    call _is_decl_start
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_4
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $95
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
    jmp .Lparse_statement_5
.Lparse_statement_4:
    pushl $1
.Lparse_statement_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_2
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_const
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_volatile
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_align_bytes
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_used
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_is_unused
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_packed_ptr
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $95
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_6
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_8
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_10
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    addl $4, %esp
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_statement_11
.Lparse_statement_10:
.Lparse_statement_11:
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_12
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_statement_13
.Lparse_statement_12:
.Lparse_statement_13:
    jmp .Lparse_statement_9
.Lparse_statement_8:
.Lparse_statement_9:
    jmp .Lparse_statement_7
.Lparse_statement_6:
.Lparse_statement_7:
    leal -64(%ebp), %eax
    pushl %eax
    leal -72(%ebp), %eax
    pushl %eax
    pushl -136(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_16
    movl _g_attr_align_bytes, %eax
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
    jmp .Lparse_statement_17
.Lparse_statement_16:
    pushl $0
.Lparse_statement_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_14
    pushl -48(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_align_bytes
    addl $4, %esp
    jmp .Lparse_statement_15
.Lparse_statement_14:
.Lparse_statement_15:
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_18
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $4
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_18:
.Lparse_statement_19:
    pushl -64(%ebp)
    pushl -72(%ebp)
    pushl -56(%ebp)
    pushl -136(%ebp)
    call _parse_local_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_2:
.Lparse_statement_3:
    leal -128(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_22
    pushl -136(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
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
    pushl $56
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
    jmp .Lparse_statement_23
.Lparse_statement_22:
    pushl $0
.Lparse_statement_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_20
    leal -128(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -80(%ebp)
    pushl $29
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_20:
.Lparse_statement_21:
    leal -128(%ebp), %eax
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
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_25
    pushl -72(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_26
    pushl -72(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_27
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_28
    pushl -72(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_29
    pushl -72(%ebp)
    pushl $79
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_30
    pushl -72(%ebp)
    pushl $80
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_31
    pushl -72(%ebp)
    pushl $81
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_32
    pushl -72(%ebp)
    pushl $82
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_33
    pushl -72(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_34
    pushl -72(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_35
    pushl -72(%ebp)
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_36
    pushl -72(%ebp)
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_statement_37
    jmp .Lparse_statement_38
.Lparse_statement_25:
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_39
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .Lparse_statement_40
.Lparse_statement_39:
.Lparse_statement_40:
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $5
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_26:
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $48
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_41
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_statement_42
.Lparse_statement_41:
.Lparse_statement_42:
    pushl -80(%ebp)
    pushl -48(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _ast_if
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_27:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $48
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -80(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _ast_while
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_28:
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $48
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    call _sym_enter_scope
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_43
    pushl -136(%ebp)
    call _is_decl_start
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_45
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_const
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_decl_is_volatile
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_attr_section
    addl $4, %esp
    leal -24(%ebp), %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -136(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl -16(%ebp)
    pushl -136(%ebp)
    call _parse_local_var_decl
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .L_parse_statement_for_have_init_semi
.Lparse_statement_45:
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
.Lparse_statement_46:
    jmp .Lparse_statement_44
.Lparse_statement_43:
.Lparse_statement_44:
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.L_parse_statement_for_have_init_semi:
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $54
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_47
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lparse_statement_48
.Lparse_statement_47:
.Lparse_statement_48:
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_49
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_statement_50
.Lparse_statement_49:
.Lparse_statement_50:
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    call _sym_leave_scope
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -40(%ebp)
    pushl -48(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _ast_for
    addl $20, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_29:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $7
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $48
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $9
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_30:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $48
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -80(%ebp)
    pushl $25
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_31:
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_cond_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_53
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_statement_54
.Lparse_statement_53:
    pushl $0
.Lparse_statement_54:
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_51
    pushl -48(%ebp)
    pushl -44(%ebp)
    addl $4, %esp
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_statement_52
.Lparse_statement_51:
.Lparse_statement_52:
    pushl $56
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $26
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_32:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $56
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $27
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    call _parse_statement
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_33:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -56(%ebp), %eax
    pushl %eax
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    addl $4, %esp
    leal -56(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_55
    leal ark_str_91, %eax
    pushl %eax
    pushl -136(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lparse_statement_56
.Lparse_statement_55:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lparse_statement_56:
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $28
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -56(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_statement_57
    leal -56(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    jmp .Lparse_statement_58
.Lparse_statement_57:
    leal ark_str_92, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
.Lparse_statement_58:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_34:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $10
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_35:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $11
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_36:
    pushl -136(%ebp)
    call _parse_block
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_37:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $4
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_38:
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl $54
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl $20
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_statement_24:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_assign_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_expr_0:
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_assign_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $30
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $55
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_expr_0
.Lparse_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_assign_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    call _parse_cond_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -88(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -72(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -72(%ebp), %eax
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
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_20
    leal -72(%ebp), %eax
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
    pushl $36
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
    jmp .Lparse_assign_expr_21
.Lparse_assign_expr_20:
    pushl $1
.Lparse_assign_expr_21:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_18
    leal -72(%ebp), %eax
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
    pushl $37
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
    jmp .Lparse_assign_expr_19
.Lparse_assign_expr_18:
    pushl $1
.Lparse_assign_expr_19:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_16
    leal -72(%ebp), %eax
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
    pushl $38
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
    jmp .Lparse_assign_expr_17
.Lparse_assign_expr_16:
    pushl $1
.Lparse_assign_expr_17:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_14
    leal -72(%ebp), %eax
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
    pushl $39
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
    jmp .Lparse_assign_expr_15
.Lparse_assign_expr_14:
    pushl $1
.Lparse_assign_expr_15:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_12
    leal -72(%ebp), %eax
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
    pushl $40
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
    jmp .Lparse_assign_expr_13
.Lparse_assign_expr_12:
    pushl $1
.Lparse_assign_expr_13:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_10
    leal -72(%ebp), %eax
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
    pushl $41
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
    jmp .Lparse_assign_expr_11
.Lparse_assign_expr_10:
    pushl $1
.Lparse_assign_expr_11:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_8
    leal -72(%ebp), %eax
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
    pushl $42
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
    jmp .Lparse_assign_expr_9
.Lparse_assign_expr_8:
    pushl $1
.Lparse_assign_expr_9:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_6
    leal -72(%ebp), %eax
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
    pushl $43
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
    jmp .Lparse_assign_expr_7
.Lparse_assign_expr_6:
    pushl $1
.Lparse_assign_expr_7:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_4
    leal -72(%ebp), %eax
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
    pushl $44
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
    jmp .Lparse_assign_expr_5
.Lparse_assign_expr_4:
    pushl $1
.Lparse_assign_expr_5:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_assign_expr_2
    leal -72(%ebp), %eax
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
    pushl $45
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
    jmp .Lparse_assign_expr_3
.Lparse_assign_expr_2:
    pushl $1
.Lparse_assign_expr_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_assign_expr_0
    leal -72(%ebp), %eax
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
    movl %eax, -24(%ebp)
    pushl -88(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    call _parse_assign_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    leal -72(%ebp), %eax
    pushl %eax
    pushl $28
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
    pushl -16(%ebp)
    pushl -80(%ebp)
    pushl -24(%ebp)
    call _ast_assign
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_assign_expr_0:
.Lparse_assign_expr_1:
    pushl -80(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_cond_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_or_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_cond_expr_0
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl $56
    pushl -56(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_cond_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $14
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8
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
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_cond_expr_0:
.Lparse_cond_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_or_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_and_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_or_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_or_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_or_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_and_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_or_expr_3
.Lparse_or_expr_2:
    jmp .Lparse_or_expr_1
.Lparse_or_expr_3:
    jmp .Lparse_or_expr_0
.Lparse_or_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_and_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_bitor_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_and_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_and_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_and_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_bitor_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_and_expr_3
.Lparse_and_expr_2:
    jmp .Lparse_and_expr_1
.Lparse_and_expr_3:
    jmp .Lparse_and_expr_0
.Lparse_and_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_bitor_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_bitxor_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_bitor_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitor_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitor_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_bitxor_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_bitor_expr_3
.Lparse_bitor_expr_2:
    jmp .Lparse_bitor_expr_1
.Lparse_bitor_expr_3:
    jmp .Lparse_bitor_expr_0
.Lparse_bitor_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_bitxor_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_bitand_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_bitxor_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitxor_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitxor_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_bitand_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_bitxor_expr_3
.Lparse_bitxor_expr_2:
    jmp .Lparse_bitxor_expr_1
.Lparse_bitxor_expr_3:
    jmp .Lparse_bitxor_expr_0
.Lparse_bitxor_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_bitand_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_eq_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_bitand_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitand_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bitand_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_eq_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_bitand_expr_3
.Lparse_bitand_expr_2:
    jmp .Lparse_bitand_expr_1
.Lparse_bitand_expr_3:
    jmp .Lparse_bitand_expr_0
.Lparse_bitand_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_eq_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_rel_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_eq_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_eq_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_eq_expr_4
    pushl -40(%ebp)
    pushl $22
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
    jmp .Lparse_eq_expr_5
.Lparse_eq_expr_4:
    pushl $1
.Lparse_eq_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_eq_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_rel_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_eq_expr_3
.Lparse_eq_expr_2:
    jmp .Lparse_eq_expr_1
.Lparse_eq_expr_3:
    jmp .Lparse_eq_expr_0
.Lparse_eq_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_rel_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_shift_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_rel_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_rel_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_rel_expr_8
    pushl -40(%ebp)
    pushl $24
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
    jmp .Lparse_rel_expr_9
.Lparse_rel_expr_8:
    pushl $1
.Lparse_rel_expr_9:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_rel_expr_6
    pushl -40(%ebp)
    pushl $25
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
    jmp .Lparse_rel_expr_7
.Lparse_rel_expr_6:
    pushl $1
.Lparse_rel_expr_7:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_rel_expr_4
    pushl -40(%ebp)
    pushl $26
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
    jmp .Lparse_rel_expr_5
.Lparse_rel_expr_4:
    pushl $1
.Lparse_rel_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_rel_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_shift_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_rel_expr_3
.Lparse_rel_expr_2:
    jmp .Lparse_rel_expr_1
.Lparse_rel_expr_3:
    jmp .Lparse_rel_expr_0
.Lparse_rel_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_shift_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_add_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_shift_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_shift_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_shift_expr_4
    pushl -40(%ebp)
    pushl $35
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
    jmp .Lparse_shift_expr_5
.Lparse_shift_expr_4:
    pushl $1
.Lparse_shift_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_shift_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_add_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_shift_expr_3
.Lparse_shift_expr_2:
    jmp .Lparse_shift_expr_1
.Lparse_shift_expr_3:
    jmp .Lparse_shift_expr_0
.Lparse_shift_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_add_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_mul_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_add_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_add_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_add_expr_4
    pushl -40(%ebp)
    pushl $16
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
    jmp .Lparse_add_expr_5
.Lparse_add_expr_4:
    pushl $1
.Lparse_add_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_add_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_mul_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_add_expr_3
.Lparse_add_expr_2:
    jmp .Lparse_add_expr_1
.Lparse_add_expr_3:
    jmp .Lparse_add_expr_0
.Lparse_add_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_mul_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
.Lparse_mul_expr_0:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Lparse_mul_expr_1
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_mul_expr_6
    pushl -40(%ebp)
    pushl $18
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
    jmp .Lparse_mul_expr_7
.Lparse_mul_expr_6:
    pushl $1
.Lparse_mul_expr_7:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_mul_expr_4
    pushl -40(%ebp)
    pushl $19
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
    jmp .Lparse_mul_expr_5
.Lparse_mul_expr_4:
    pushl $1
.Lparse_mul_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_mul_expr_2
    pushl -56(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    call _ast_binary
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_mul_expr_3
.Lparse_mul_expr_2:
    jmp .Lparse_mul_expr_1
.Lparse_mul_expr_3:
    jmp .Lparse_mul_expr_0
.Lparse_mul_expr_1:
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_type_size_of_token:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    leal -40(%ebp), %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_of_token_0
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_of_token_0:
.Ltype_size_of_token_1:
    leal -16(%ebp), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl -56(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_cast_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_cast_expr_0
    pushl -136(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -128(%ebp), %eax
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
    call _is_basic_type_token
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_cast_expr_4
    leal -128(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_cast_expr_6
    leal -128(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_cast_expr_7
.Lparse_cast_expr_6:
    pushl $0
.Lparse_cast_expr_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_cast_expr_5
.Lparse_cast_expr_4:
    pushl $1
.Lparse_cast_expr_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_cast_expr_2
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    pushl $28
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
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -72(%ebp), %eax
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    pushl -136(%ebp)
    call _parse_declspec
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    leal -40(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -136(%ebp)
    call _parse_declarator
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $50
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_cast_expr_8
    pushl -136(%ebp)
    call _parse_init_list
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -64(%ebp)
    pushl $35
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_cast_expr_8:
.Lparse_cast_expr_9:
    pushl -136(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl -32(%ebp)
    pushl -48(%ebp)
    call _ast_cast
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_cast_expr_2:
.Lparse_cast_expr_3:
    jmp .Lparse_cast_expr_1
.Lparse_cast_expr_0:
.Lparse_cast_expr_1:
    pushl -136(%ebp)
    call _parse_unary_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_unary_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -128(%ebp), %eax
    pushl %eax
    pushl $28
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
    movl %eax, -80(%ebp)
    leal -128(%ebp), %eax
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
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_1
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_2
    pushl -72(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_3
    pushl -72(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_4
    pushl -72(%ebp)
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_5
    pushl -72(%ebp)
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_6
    pushl -72(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_7
    pushl -72(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_8
    pushl -72(%ebp)
    pushl $78
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_9
    jmp .Lparse_unary_expr_10
.Lparse_unary_expr_1:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_2:
.Lparse_unary_expr_3:
.Lparse_unary_expr_4:
.Lparse_unary_expr_5:
.Lparse_unary_expr_6:
    leal -128(%ebp), %eax
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
    movl %eax, -64(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -136(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    pushl -64(%ebp)
    call _ast_unary
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_7:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -136(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    pushl $17
    call _ast_unary
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_8:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -136(%ebp)
    call _parse_cast_expr
    addl $4, %esp
    pushl %eax
    pushl $30
    call _ast_unary
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_9:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_11
    pushl -136(%ebp)
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
    call _lexer_peek2
    addl $4, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -56(%ebp), %eax
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
    call _is_basic_type_token
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_unary_expr_15
    leal -56(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_17
    leal -56(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_is_typedef
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_unary_expr_18
.Lparse_unary_expr_17:
    pushl $0
.Lparse_unary_expr_18:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_unary_expr_16
.Lparse_unary_expr_15:
    pushl $1
.Lparse_unary_expr_16:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_13
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _type_size_of_token
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
    pushl -64(%ebp)
    call _ast_sizeof_val
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_13:
.Lparse_unary_expr_14:
    jmp .Lparse_unary_expr_12
.Lparse_unary_expr_11:
.Lparse_unary_expr_12:
    pushl -136(%ebp)
    call _parse_unary_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $4
    popl %eax
    movl %eax, -48(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_21
    pushl -56(%ebp)
    pushl $4
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_unary_expr_22
.Lparse_unary_expr_21:
    pushl $0
.Lparse_unary_expr_22:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_19
    pushl -56(%ebp)
    pushl $4
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
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_unary_expr_20
.Lparse_unary_expr_19:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_25
    pushl -56(%ebp)
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
    pushl $17
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
    jmp .Lparse_unary_expr_26
.Lparse_unary_expr_25:
    pushl $0
.Lparse_unary_expr_26:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_23
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    call _sym_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_29
    pushl -40(%ebp)
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_unary_expr_30
.Lparse_unary_expr_29:
    pushl $0
.Lparse_unary_expr_30:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_27
    pushl -40(%ebp)
    pushl $8
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
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_unary_expr_28
.Lparse_unary_expr_27:
.Lparse_unary_expr_28:
    jmp .Lparse_unary_expr_24
.Lparse_unary_expr_23:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_33
    pushl -56(%ebp)
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
    pushl $18
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
    jmp .Lparse_unary_expr_34
.Lparse_unary_expr_33:
    pushl $0
.Lparse_unary_expr_34:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_31
    pushl -56(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_37
    pushl -40(%ebp)
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
    pushl $17
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
    jmp .Lparse_unary_expr_38
.Lparse_unary_expr_37:
    pushl $0
.Lparse_unary_expr_38:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_35
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    call _sym_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_43
    pushl -32(%ebp)
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_unary_expr_44
.Lparse_unary_expr_43:
    pushl $0
.Lparse_unary_expr_44:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_41
    pushl -32(%ebp)
    pushl $8
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
    pushl $10
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
    jmp .Lparse_unary_expr_42
.Lparse_unary_expr_41:
    pushl $0
.Lparse_unary_expr_42:
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_39
    pushl -32(%ebp)
    pushl $8
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
    pushl $4
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
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
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
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_unary_expr_45
    pushl $4
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_unary_expr_46
.Lparse_unary_expr_45:
.Lparse_unary_expr_46:
    pushl -80(%ebp)
    pushl -48(%ebp)
    call _ast_sizeof_val
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_10:
    pushl -136(%ebp)
    call _parse_postfix_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_unary_expr_0:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_postfix_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    call _parse_primary_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
.Lparse_postfix_expr_0:
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -120(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -120(%ebp), %eax
    pushl %eax
    pushl $28
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
    movl %eax, -72(%ebp)
    leal -120(%ebp), %eax
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
    pushl $52
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_3
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $53
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl -64(%ebp)
    pushl -128(%ebp)
    call _ast_array_access
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lparse_postfix_expr_4
.Lparse_postfix_expr_3:
    leal -120(%ebp), %eax
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_5
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_7
.Lparse_postfix_expr_9:
    pushl -136(%ebp)
    call _parse_assign_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_12
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_14
    pushl -48(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lparse_postfix_expr_15
.Lparse_postfix_expr_14:
    pushl $4
.Lparse_postfix_expr_15:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lparse_postfix_expr_13
.Lparse_postfix_expr_12:
.Lparse_postfix_expr_13:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
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
    pushl $55
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_16
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
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
    pushl $49
    pushl -136(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
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
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_18
    pushl -128(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    leal ark_str_93, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -72(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    pushl -40(%ebp)
    call _ast_func_call
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_postfix_expr_19
.Lparse_postfix_expr_18:
    pushl -128(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -72(%ebp)
    pushl -56(%ebp)
    pushl -64(%ebp)
    pushl -40(%ebp)
    call _ast_func_call
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
.Lparse_postfix_expr_19:
    jmp .Lparse_postfix_expr_6
.Lparse_postfix_expr_5:
    leal -120(%ebp), %eax
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
    pushl $84
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_postfix_expr_22
    leal -120(%ebp), %eax
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
    pushl $85
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
    jmp .Lparse_postfix_expr_23
.Lparse_postfix_expr_22:
    pushl $1
.Lparse_postfix_expr_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_20
    leal -120(%ebp), %eax
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
    pushl $85
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -56(%ebp), %eax
    pushl %eax
    pushl -136(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    addl $4, %esp
    leal -56(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_24
    leal ark_str_94, %eax
    pushl %eax
    pushl -136(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -128(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_postfix_expr_24:
.Lparse_postfix_expr_25:
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl -64(%ebp)
    leal -56(%ebp), %eax
    pushl %eax
    pushl $24
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
    pushl -128(%ebp)
    call _ast_member
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
    jmp .Lparse_postfix_expr_21
.Lparse_postfix_expr_20:
    leal -120(%ebp), %eax
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_postfix_expr_28
    leal -120(%ebp), %eax
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
    pushl $47
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
    jmp .Lparse_postfix_expr_29
.Lparse_postfix_expr_28:
    pushl $1
.Lparse_postfix_expr_29:
    popl %eax
    cmpl $0, %eax
    je .Lparse_postfix_expr_26
    pushl -136(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl -128(%ebp)
    leal -120(%ebp), %eax
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
    call _ast_unary
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    pushl -64(%ebp)
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
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
    pushl -128(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_primary_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $464, %esp
    movl 8(%ebp), %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $28
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
    movl %eax, -160(%ebp)
    leal -208(%ebp), %eax
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
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_0
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $16
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -152(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fistpl (%esp)
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl -152(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -208(%ebp), %eax
    pushl %eax
    pushl $36
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
    je .Lparse_primary_expr_2
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_double
    pushl %eax
    call _type_complex
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -152(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    jmp .Lparse_primary_expr_3
.Lparse_primary_expr_2:
    leal -208(%ebp), %eax
    pushl %eax
    pushl $40
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
    je .Lparse_primary_expr_4
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_float
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_primary_expr_5
.Lparse_primary_expr_4:
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_double
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_primary_expr_5:
.Lparse_primary_expr_3:
    pushl -152(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_0:
.Lparse_primary_expr_1:
    leal -208(%ebp), %eax
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_6
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    leal -208(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    call _ast_num
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_6:
.Lparse_primary_expr_7:
    leal -208(%ebp), %eax
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_8
    leal -208(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_parse_primary_expr_162
    cmpl %eax, (%esp)
    jne .L64f_parse_primary_expr_162
    addl $4, %esp
    pushl $1
    jmp .L64e_parse_primary_expr_162
.L64f_parse_primary_expr_162:
    addl $4, %esp
    pushl $0
.L64e_parse_primary_expr_162:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_10
    movl $_g_config, %eax
    pushl %eax
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_expr_11
.Lparse_primary_expr_10:
    pushl $0
.Lparse_primary_expr_11:
    popl %eax
    movl %eax, -144(%ebp)
    pushl $64
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl $1
    popl %eax
    movl %eax, -112(%ebp)
.Lparse_primary_expr_12:
    pushl -216(%ebp)
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
    call _lexer_peek
    addl $4, %esp
    pushl %eax
    leal -104(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    movl 0(%eax), %edx
    movl %edx, 0(%ecx)
    movl 4(%eax), %edx
    movl %edx, 4(%ecx)
    movl 8(%eax), %edx
    movl %edx, 8(%ecx)
    movl 12(%eax), %edx
    movl %edx, 12(%ecx)
    movl 16(%eax), %edx
    movl %edx, 16(%ecx)
    movl 20(%eax), %edx
    movl %edx, 20(%ecx)
    movl 24(%eax), %edx
    movl %edx, 24(%ecx)
    movl 28(%eax), %edx
    movl %edx, 28(%ecx)
    movl 32(%eax), %edx
    movl %edx, 32(%ecx)
    movl 36(%eax), %edx
    movl %edx, 36(%ecx)
    movl 40(%eax), %edx
    movl %edx, 40(%ecx)
    movl 44(%eax), %edx
    movl %edx, 44(%ecx)
    pushl %eax
    leal -104(%ebp), %eax
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_15
    jmp .Lparse_primary_expr_13
.Lparse_primary_expr_15:
.Lparse_primary_expr_16:
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal -104(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $8, %ecx
    addl %ecx, %eax
    movl (%eax), %ecx
    movl 4(%eax), %edx
    pushl %ecx
    pushl %edx
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    negl %eax
    pushl %eax
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_parse_primary_expr_221
    cmpl %eax, (%esp)
    jne .L64f_parse_primary_expr_221
    addl $4, %esp
    pushl $1
    jmp .L64e_parse_primary_expr_221
.L64f_parse_primary_expr_221:
    addl $4, %esp
    pushl $0
.L64e_parse_primary_expr_221:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_19
    movl $_g_config, %eax
    pushl %eax
    pushl $8
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_expr_20
.Lparse_primary_expr_19:
    pushl $0
.Lparse_primary_expr_20:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_17
    pushl $1
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    jmp .Lparse_primary_expr_18
.Lparse_primary_expr_17:
.Lparse_primary_expr_18:
    leal -104(%ebp), %eax
    pushl %eax
    pushl $24
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
    je .Lparse_primary_expr_21
    leal -104(%ebp), %eax
    pushl %eax
    pushl $24
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
    jmp .Lparse_primary_expr_22
.Lparse_primary_expr_21:
    leal ark_str_95, %eax
    pushl %eax
.Lparse_primary_expr_22:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_23
    pushl -136(%ebp)
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    jmp .Lparse_primary_expr_24
.Lparse_primary_expr_23:
.Lparse_primary_expr_24:
.Lparse_primary_expr_25:
    pushl -128(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_26
    pushl -136(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_primary_expr_27:
    pushl -24(%ebp)
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_28
    pushl -32(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    pushl -24(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_primary_expr_29:
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    addl $4, %esp
    jmp .Lparse_primary_expr_27
.Lparse_primary_expr_28:
    pushl -32(%ebp)
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Lparse_primary_expr_25
.Lparse_primary_expr_26:
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lparse_primary_expr_30:
    pushl -40(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_31
    pushl -120(%ebp)
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -40(%ebp)
    pushl $1
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
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_primary_expr_32:
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    addl $4, %esp
    jmp .Lparse_primary_expr_30
.Lparse_primary_expr_31:
.Lparse_primary_expr_14:
    jmp .Lparse_primary_expr_12
.Lparse_primary_expr_13:
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_33
    pushl $1
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_primary_expr_34
.Lparse_primary_expr_33:
.Lparse_primary_expr_34:
    pushl -120(%ebp)
    pushl -128(%ebp)
    pushl $1
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
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -160(%ebp)
    pushl -120(%ebp)
    call _ast_str
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_35
    pushl -152(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_wchar
    pushl %eax
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_primary_expr_36
.Lparse_primary_expr_35:
.Lparse_primary_expr_36:
    pushl -152(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_8:
.Lparse_primary_expr_9:
    leal -208(%ebp), %eax
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
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_37
    leal ark_str_96, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_primary_expr_43
    leal ark_str_97, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_expr_44
.Lparse_primary_expr_43:
    pushl $1
.Lparse_primary_expr_44:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_primary_expr_41
    leal ark_str_98, %eax
    pushl %eax
    leal -208(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_expr_42
.Lparse_primary_expr_41:
    pushl $1
.Lparse_primary_expr_42:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_39
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    movl _g_current_func_name, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_45
    movl _g_current_func_name, %eax
    pushl %eax
    jmp .Lparse_primary_expr_46
.Lparse_primary_expr_45:
    leal ark_str_99, %eax
    pushl %eax
.Lparse_primary_expr_46:
    call _ast_str
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_39:
.Lparse_primary_expr_40:
    leal -208(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _sym_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_49
    pushl -152(%ebp)
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
    pushl $5
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
    jmp .Lparse_primary_expr_50
.Lparse_primary_expr_49:
    pushl $0
.Lparse_primary_expr_50:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_47
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl -152(%ebp)
    pushl $44
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
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    call _ast_num
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_47:
.Lparse_primary_expr_48:
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    leal -208(%ebp), %eax
    pushl %eax
    pushl $24
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
    call _ast_var
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_37:
.Lparse_primary_expr_38:
    leal -208(%ebp), %eax
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_expr_51
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -216(%ebp)
    call _parse_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl $49
    pushl -216(%ebp)
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
    call _lexer_expect
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -152(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_expr_51:
.Lparse_primary_expr_52:
    leal ark_str_100, %eax
    pushl %eax
    pushl -216(%ebp)
    call _perror_at
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -216(%ebp)
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
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    call _ast_num
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

