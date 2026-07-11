# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_config
_g_config:
    .zero 96
    .globl _ark_sl_config_load_file_cfg_buf
_ark_sl_config_load_file_cfg_buf:
    .zero 4096
    .section .rdata,"dr"
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
    .text
_parse_bool:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_2
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_bool_3
.Lparse_bool_2:
    pushl $1
.Lparse_bool_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_0:
.Lparse_bool_1:
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_6
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
    jmp .Lparse_bool_7
.Lparse_bool_6:
    pushl $0
.Lparse_bool_7:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_4:
.Lparse_bool_5:
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
    pushl $49
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_10
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
    jmp .Lparse_bool_11
.Lparse_bool_10:
    pushl $0
.Lparse_bool_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_8
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_8:
.Lparse_bool_9:
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
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_22
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
    pushl $84
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
    jmp .Lparse_bool_23
.Lparse_bool_22:
    pushl $1
.Lparse_bool_23:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_20
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
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_24
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
    pushl $82
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
    jmp .Lparse_bool_25
.Lparse_bool_24:
    pushl $1
.Lparse_bool_25:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_21
.Lparse_bool_20:
    pushl $0
.Lparse_bool_21:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_18
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
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_26
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
    jmp .Lparse_bool_27
.Lparse_bool_26:
    pushl $1
.Lparse_bool_27:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_19
.Lparse_bool_18:
    pushl $0
.Lparse_bool_19:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_16
    pushl -24(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_28
    pushl -24(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_bool_29
.Lparse_bool_28:
    pushl $1
.Lparse_bool_29:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_17
.Lparse_bool_16:
    pushl $0
.Lparse_bool_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_14
    pushl -24(%ebp)
    pushl $4
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
    jmp .Lparse_bool_15
.Lparse_bool_14:
    pushl $0
.Lparse_bool_15:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_12
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_12:
.Lparse_bool_13:
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
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_42
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
    pushl $70
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
    jmp .Lparse_bool_43
.Lparse_bool_42:
    pushl $1
.Lparse_bool_43:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_40
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
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_44
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
    pushl $65
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
    jmp .Lparse_bool_45
.Lparse_bool_44:
    pushl $1
.Lparse_bool_45:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_41
.Lparse_bool_40:
    pushl $0
.Lparse_bool_41:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_38
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
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_46
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
    pushl $76
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
    jmp .Lparse_bool_47
.Lparse_bool_46:
    pushl $1
.Lparse_bool_47:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_39
.Lparse_bool_38:
    pushl $0
.Lparse_bool_39:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_36
    pushl -24(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_48
    pushl -24(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $83
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
    jmp .Lparse_bool_49
.Lparse_bool_48:
    pushl $1
.Lparse_bool_49:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_37
.Lparse_bool_36:
    pushl $0
.Lparse_bool_37:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_34
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_bool_50
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_bool_51
.Lparse_bool_50:
    pushl $1
.Lparse_bool_51:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_bool_35
.Lparse_bool_34:
    pushl $0
.Lparse_bool_35:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_32
    pushl -24(%ebp)
    pushl $5
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
    jmp .Lparse_bool_33
.Lparse_bool_32:
    pushl $0
.Lparse_bool_33:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_30
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_30:
.Lparse_bool_31:
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
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_54
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
    jmp .Lparse_bool_55
.Lparse_bool_54:
    pushl $0
.Lparse_bool_55:
    popl %eax
    cmpl $0, %eax
    je .Lparse_bool_52
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_bool_52:
.Lparse_bool_53:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_int:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_int_2
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_int_3
.Lparse_int_2:
    pushl $1
.Lparse_int_3:
    popl %eax
    cmpl $0, %eax
    je .Lparse_int_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_int_0:
.Lparse_int_1:
    pushl -56(%ebp)
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
    je .Lparse_int_4
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    jmp .Lparse_int_5
.Lparse_int_4:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_int_6
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
    jmp .Lparse_int_7
.Lparse_int_6:
.Lparse_int_7:
.Lparse_int_5:
.Lparse_int_8:
    pushl -56(%ebp)
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
    je .Lparse_int_10
    pushl -56(%ebp)
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
    jmp .Lparse_int_11
.Lparse_int_10:
    pushl $0
.Lparse_int_11:
    popl %eax
    cmpl $0, %eax
    je .Lparse_int_9
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
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
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_int_8
.Lparse_int_9:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_int_12
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_int_12:
.Lparse_int_13:
    pushl -48(%ebp)
    pushl -40(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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

    .globl _config_init
_config_init:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_g_config, %eax
    pushl %eax
    pushl $0
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
    movl $_g_config, %eax
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
    movl $_g_config, %eax
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
    movl $_g_config, %eax
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
    movl $_g_config, %eax
    pushl %eax
    pushl $16
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
    movl $_g_config, %eax
    pushl %eax
    pushl $20
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
    movl $_g_config, %eax
    pushl %eax
    pushl $24
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
    movl $_g_config, %eax
    pushl %eax
    pushl $28
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
    movl $_g_config, %eax
    pushl %eax
    pushl $32
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
    movl $_g_config, %eax
    pushl %eax
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
    movl $_g_config, %eax
    pushl %eax
    pushl $40
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
    movl $_g_config, %eax
    pushl %eax
    pushl $44
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
    movl $_g_config, %eax
    pushl %eax
    pushl $48
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
    movl $_g_config, %eax
    pushl %eax
    pushl $52
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
    movl $_g_config, %eax
    pushl %eax
    pushl $56
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
    movl $_g_config, %eax
    pushl %eax
    pushl $60
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
    movl $_g_config, %eax
    pushl %eax
    pushl $64
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
    movl $_g_config, %eax
    pushl %eax
    pushl $68
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
    movl $_g_config, %eax
    pushl %eax
    pushl $72
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
    movl $_g_config, %eax
    pushl %eax
    pushl $76
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
    movl $_g_config, %eax
    pushl %eax
    pushl $80
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
    movl $_g_config, %eax
    pushl %eax
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
    movl $_g_config, %eax
    pushl %eax
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
    movl $_g_config, %eax
    pushl %eax
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
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_apply_kv:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_kv_2
    pushl -24(%ebp)
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
    jmp .Lapply_kv_3
.Lapply_kv_2:
    pushl $1
.Lapply_kv_3:
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lapply_kv_0:
.Lapply_kv_1:
    leal ark_str_0, %eax
    pushl %eax
    pushl -40(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_4
    leal ark_str_1, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_6
    movl $_g_config, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_7
.Lapply_kv_6:
    leal ark_str_2, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_8
    movl $_g_config, %eax
    pushl %eax
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_9
.Lapply_kv_8:
    leal ark_str_3, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_10
    movl $_g_config, %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_11
.Lapply_kv_10:
    leal ark_str_4, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_12
    movl $_g_config, %eax
    pushl %eax
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_13
.Lapply_kv_12:
    leal ark_str_5, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_14
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_15
.Lapply_kv_14:
    leal ark_str_6, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_16
    movl $_g_config, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_17
.Lapply_kv_16:
    leal ark_str_7, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_18
    movl $_g_config, %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_19
.Lapply_kv_18:
    leal ark_str_8, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_20
    movl $_g_config, %eax
    pushl %eax
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_21
.Lapply_kv_20:
    leal ark_str_9, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_22
    movl $_g_config, %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_23
.Lapply_kv_22:
    leal ark_str_10, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_24
    movl $_g_config, %eax
    pushl %eax
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_25
.Lapply_kv_24:
    leal ark_str_11, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_26
    movl $_g_config, %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
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
    leal ark_str_12, %eax
    pushl %eax
    pushl -40(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_28
    leal ark_str_13, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_30
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    leal -16(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_int
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_32
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_34
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lapply_kv_35
.Lapply_kv_34:
.Lapply_kv_35:
    pushl -16(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_36
    pushl $2
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lapply_kv_37
.Lapply_kv_36:
.Lapply_kv_37:
    movl $_g_config, %eax
    pushl %eax
    pushl $44
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
    jmp .Lapply_kv_33
.Lapply_kv_32:
.Lapply_kv_33:
    jmp .Lapply_kv_31
.Lapply_kv_30:
    leal ark_str_14, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_38
    movl $_g_config, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_40
    pushl $1
    jmp .Lapply_kv_41
.Lapply_kv_40:
    pushl $0
.Lapply_kv_41:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_39
.Lapply_kv_38:
    leal ark_str_15, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_kv_44
    leal ark_str_16, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lapply_kv_45
.Lapply_kv_44:
    pushl $1
.Lapply_kv_45:
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_42
    movl $_g_config, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _parse_bool
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_kv_46
    pushl $1
    jmp .Lapply_kv_47
.Lapply_kv_46:
    pushl $0
.Lapply_kv_47:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lapply_kv_43
.Lapply_kv_42:
.Lapply_kv_43:
.Lapply_kv_39:
.Lapply_kv_31:
    jmp .Lapply_kv_29
.Lapply_kv_28:
.Lapply_kv_29:
.Lapply_kv_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _config_load_file
_config_load_file:
    pushl %ebp
    movl %esp, %ebp
    subl $416, %esp
    movl 8(%ebp), %eax
    movl %eax, -168(%ebp)
    pushl $0
    popl %eax
    movl %eax, -160(%ebp)
    pushl $0
    popl %eax
    movl %eax, -156(%ebp)
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
    pushl $0
    popl %eax
    movl %eax, -148(%ebp)
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl $0
    popl %eax
    movl %eax, -140(%ebp)
    pushl $0
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -132(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl $0
    popl %eax
    movl %eax, -124(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    movl %eax, -116(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -108(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl $0
    popl %eax
    movl %eax, -100(%ebp)
    pushl $1
    leal ark_str_17, %eax
    pushl %eax
    leal -160(%ebp), %eax
    pushl %eax
    call _memcpy
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -168(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lconfig_load_file_0:
.Lconfig_load_file_1:
    pushl $4095
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -168(%ebp)
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_2
    pushl -168(%ebp)
    leal ark_str_18, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lconfig_load_file_2:
.Lconfig_load_file_3:
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -96(%ebp)
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
    movl $_g_config, %eax
    pushl %eax
    pushl $56
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
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lconfig_load_file_4:
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_5
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_load_file_9
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    jmp .Lconfig_load_file_10
.Lconfig_load_file_9:
    pushl $1
.Lconfig_load_file_10:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_7
    pushl -80(%ebp)
    popl %eax
    movl %eax, -72(%ebp)
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_11
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    jmp .Lconfig_load_file_12
.Lconfig_load_file_11:
.Lconfig_load_file_12:
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
.Lconfig_load_file_13:
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
    je .Lconfig_load_file_15
    pushl -72(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $13
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
    jmp .Lconfig_load_file_16
.Lconfig_load_file_15:
    pushl $0
.Lconfig_load_file_16:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_14
    pushl -72(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    jmp .Lconfig_load_file_13
.Lconfig_load_file_14:
.Lconfig_load_file_17:
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jne .Lconfig_load_file_19
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
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
    jmp .Lconfig_load_file_20
.Lconfig_load_file_19:
    pushl $1
.Lconfig_load_file_20:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_18
    pushl -72(%ebp)
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    addl $4, %esp
    jmp .Lconfig_load_file_17
.Lconfig_load_file_18:
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jne .Lconfig_load_file_25
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
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
    jmp .Lconfig_load_file_26
.Lconfig_load_file_25:
    pushl $1
.Lconfig_load_file_26:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_load_file_23
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
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
    jmp .Lconfig_load_file_24
.Lconfig_load_file_23:
    pushl $1
.Lconfig_load_file_24:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_21
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lconfig_load_file_6
.Lconfig_load_file_21:
.Lconfig_load_file_22:
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_27
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    movl %eax, -24(%ebp)
.Lconfig_load_file_29:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_31
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $93
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
    jmp .Lconfig_load_file_32
.Lconfig_load_file_31:
    pushl $0
.Lconfig_load_file_32:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_30
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
    jmp .Lconfig_load_file_29
.Lconfig_load_file_30:
    pushl -24(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
.Lconfig_load_file_33:
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_35
    pushl -16(%ebp)
    pushl $63
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
    jmp .Lconfig_load_file_36
.Lconfig_load_file_35:
    pushl $0
.Lconfig_load_file_36:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_34
    leal -160(%ebp), %eax
    pushl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
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
    jmp .Lconfig_load_file_33
.Lconfig_load_file_34:
    leal -160(%ebp), %eax
    pushl %eax
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
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lconfig_load_file_6
.Lconfig_load_file_27:
.Lconfig_load_file_28:
    pushl -72(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lconfig_load_file_37:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_39
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
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
    jmp .Lconfig_load_file_40
.Lconfig_load_file_39:
    pushl $0
.Lconfig_load_file_40:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_38
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
    jmp .Lconfig_load_file_37
.Lconfig_load_file_38:
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_41
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lconfig_load_file_6
.Lconfig_load_file_41:
.Lconfig_load_file_42:
    pushl -48(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lconfig_load_file_43:
    pushl -40(%ebp)
    pushl -72(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_45
    pushl -40(%ebp)
    pushl $1
    popl %eax
    negl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jne .Lconfig_load_file_47
    pushl -40(%ebp)
    pushl $1
    popl %eax
    negl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
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
    jmp .Lconfig_load_file_48
.Lconfig_load_file_47:
    pushl $1
.Lconfig_load_file_48:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lconfig_load_file_46
.Lconfig_load_file_45:
    pushl $0
.Lconfig_load_file_46:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_44
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
    pushl -40(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lconfig_load_file_43
.Lconfig_load_file_44:
    pushl -72(%ebp)
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
.Lconfig_load_file_49:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jne .Lconfig_load_file_51
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
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
    jmp .Lconfig_load_file_52
.Lconfig_load_file_51:
    pushl $1
.Lconfig_load_file_52:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_50
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
    jmp .Lconfig_load_file_49
.Lconfig_load_file_50:
    pushl -56(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
.Lconfig_load_file_53:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_54
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
    jmp .Lconfig_load_file_53
.Lconfig_load_file_54:
.Lconfig_load_file_55:
    pushl -32(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_57
    pushl -32(%ebp)
    pushl $1
    popl %eax
    negl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jne .Lconfig_load_file_59
    pushl -32(%ebp)
    pushl $1
    popl %eax
    negl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $9
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
    jmp .Lconfig_load_file_60
.Lconfig_load_file_59:
    pushl $1
.Lconfig_load_file_60:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lconfig_load_file_58
.Lconfig_load_file_57:
    pushl $0
.Lconfig_load_file_58:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_load_file_56
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lconfig_load_file_55
.Lconfig_load_file_56:
    pushl -56(%ebp)
    pushl -64(%ebp)
    leal -160(%ebp), %eax
    pushl %eax
    call _apply_kv
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    movl $_ark_sl_config_load_file_cfg_buf, %eax
    pushl %eax
    pushl -88(%ebp)
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
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    jmp .Lconfig_load_file_8
.Lconfig_load_file_7:
.Lconfig_load_file_8:
.Lconfig_load_file_6:
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
    jmp .Lconfig_load_file_4
.Lconfig_load_file_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _config_apply_args
_config_apply_args:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lconfig_apply_args_0:
.Lconfig_apply_args_1:
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lconfig_apply_args_2:
    pushl -40(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_3
    pushl -48(%ebp)
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_7
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_8
.Lconfig_apply_args_7:
    pushl $1
.Lconfig_apply_args_8:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_5
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_5:
.Lconfig_apply_args_6:
    pushl -32(%ebp)
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
    je .Lconfig_apply_args_17
    pushl -32(%ebp)
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
    pushl $79
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
    jmp .Lconfig_apply_args_18
.Lconfig_apply_args_17:
    pushl $0
.Lconfig_apply_args_18:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_15
    pushl -32(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lconfig_apply_args_16
.Lconfig_apply_args_15:
    pushl $0
.Lconfig_apply_args_16:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_13
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_14
.Lconfig_apply_args_13:
    pushl $0
.Lconfig_apply_args_14:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_11
    pushl -32(%ebp)
    pushl $3
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
    jmp .Lconfig_apply_args_12
.Lconfig_apply_args_11:
    pushl $0
.Lconfig_apply_args_12:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_9
    movl $_g_config, %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_g_config, %eax
    pushl %eax
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
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_19
    movl $_g_config, %eax
    pushl %eax
    pushl $44
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
    jmp .Lconfig_apply_args_20
.Lconfig_apply_args_19:
.Lconfig_apply_args_20:
    movl $_g_config, %eax
    pushl %eax
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
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_21
    movl $_g_config, %eax
    pushl %eax
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
    movl $_g_config, %eax
    pushl %eax
    pushl $40
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
    jmp .Lconfig_apply_args_22
.Lconfig_apply_args_21:
.Lconfig_apply_args_22:
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_9:
.Lconfig_apply_args_10:
    leal ark_str_19, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_23
    movl $_g_config, %eax
    pushl %eax
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_23:
.Lconfig_apply_args_24:
    leal ark_str_20, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_27
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    jmp .Lconfig_apply_args_28
.Lconfig_apply_args_27:
    pushl $0
.Lconfig_apply_args_28:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_25
    movl $_g_config, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -40(%ebp)
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_25:
.Lconfig_apply_args_26:
    leal ark_str_21, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_29
    leal ark_str_22, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_29:
.Lconfig_apply_args_30:
    leal ark_str_23, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_33
    leal ark_str_24, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_34
.Lconfig_apply_args_33:
    pushl $1
.Lconfig_apply_args_34:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_31
    movl $_g_config, %eax
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_31:
.Lconfig_apply_args_32:
    leal ark_str_25, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_35
    movl $_g_config, %eax
    pushl %eax
    pushl $64
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_35:
.Lconfig_apply_args_36:
    leal ark_str_26, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_37
    movl $_g_config, %eax
    pushl %eax
    pushl $68
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
    movl $_g_config, %eax
    pushl %eax
    pushl $72
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_37:
.Lconfig_apply_args_38:
    leal ark_str_27, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_39
    movl $_g_config, %eax
    pushl %eax
    pushl $72
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
    movl $_g_config, %eax
    pushl %eax
    pushl $68
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_39:
.Lconfig_apply_args_40:
    leal ark_str_28, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_41
    movl $_g_config, %eax
    pushl %eax
    pushl $76
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
    movl $_g_config, %eax
    pushl %eax
    pushl $80
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_41:
.Lconfig_apply_args_42:
    leal ark_str_29, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_43
    movl $_g_config, %eax
    pushl %eax
    pushl $80
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
    movl $_g_config, %eax
    pushl %eax
    pushl $76
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_43:
.Lconfig_apply_args_44:
    leal ark_str_30, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_45
    movl $_g_config, %eax
    pushl %eax
    pushl $84
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_45:
.Lconfig_apply_args_46:
    leal ark_str_31, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_47
    movl $_g_config, %eax
    pushl %eax
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $3
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_47:
.Lconfig_apply_args_48:
    leal ark_str_32, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_51
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    jmp .Lconfig_apply_args_52
.Lconfig_apply_args_51:
    pushl $0
.Lconfig_apply_args_52:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_49
    movl $_g_config, %eax
    pushl %eax
    pushl $88
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl -40(%ebp)
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_49:
.Lconfig_apply_args_50:
    leal ark_str_33, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_55
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    jmp .Lconfig_apply_args_56
.Lconfig_apply_args_55:
    pushl $0
.Lconfig_apply_args_56:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_53
    pushl -48(%ebp)
    pushl -40(%ebp)
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
    movl %eax, -24(%ebp)
    movl $_g_config, %eax
    pushl %eax
    pushl $92
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
    leal ark_str_34, %eax
    pushl %eax
    pushl -24(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_57
    movl $_g_config, %eax
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
    jmp .Lconfig_apply_args_58
.Lconfig_apply_args_57:
    movl $_g_config, %eax
    pushl %eax
    pushl $16
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
.Lconfig_apply_args_58:
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_53:
.Lconfig_apply_args_54:
    leal ark_str_35, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_75
    leal ark_str_36, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_76
.Lconfig_apply_args_75:
    pushl $1
.Lconfig_apply_args_76:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_73
    leal ark_str_37, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_74
.Lconfig_apply_args_73:
    pushl $1
.Lconfig_apply_args_74:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_71
    leal ark_str_38, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_72
.Lconfig_apply_args_71:
    pushl $1
.Lconfig_apply_args_72:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_69
    leal ark_str_39, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_70
.Lconfig_apply_args_69:
    pushl $1
.Lconfig_apply_args_70:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_67
    leal ark_str_40, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_68
.Lconfig_apply_args_67:
    pushl $1
.Lconfig_apply_args_68:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_65
    leal ark_str_41, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_66
.Lconfig_apply_args_65:
    pushl $1
.Lconfig_apply_args_66:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_63
    leal ark_str_42, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_64
.Lconfig_apply_args_63:
    pushl $1
.Lconfig_apply_args_64:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_61
    leal ark_str_43, %eax
    pushl %eax
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_62
.Lconfig_apply_args_61:
    pushl $1
.Lconfig_apply_args_62:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_59
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_59:
.Lconfig_apply_args_60:
    leal ark_str_44, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_77
    movl $_g_config, %eax
    pushl %eax
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_77:
.Lconfig_apply_args_78:
    leal ark_str_45, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_79
    movl $_g_config, %eax
    pushl %eax
    pushl $36
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_79:
.Lconfig_apply_args_80:
    leal ark_str_46, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_81
    movl $_g_config, %eax
    pushl %eax
    pushl $40
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_81:
.Lconfig_apply_args_82:
    leal ark_str_47, %eax
    pushl %eax
    pushl -32(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_83
    movl $_g_config, %eax
    pushl %eax
    pushl $40
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
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_83:
.Lconfig_apply_args_84:
    pushl -32(%ebp)
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
    je .Lconfig_apply_args_87
    pushl -32(%ebp)
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
    jmp .Lconfig_apply_args_88
.Lconfig_apply_args_87:
    pushl $0
.Lconfig_apply_args_88:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_85
    pushl -32(%ebp)
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
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_93
    pushl -32(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $111
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
    jmp .Lconfig_apply_args_94
.Lconfig_apply_args_93:
    pushl $0
.Lconfig_apply_args_94:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_91
    pushl -32(%ebp)
    pushl $4
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lconfig_apply_args_92
.Lconfig_apply_args_91:
    pushl $0
.Lconfig_apply_args_92:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_89
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lconfig_apply_args_90
.Lconfig_apply_args_89:
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lconfig_apply_args_90:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_95
    jmp .Lconfig_apply_args_4
.Lconfig_apply_args_95:
.Lconfig_apply_args_96:
    leal ark_str_48, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_97
    movl $_g_config, %eax
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
    jmp .Lconfig_apply_args_98
.Lconfig_apply_args_97:
    leal ark_str_49, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_99
    movl $_g_config, %eax
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
    jmp .Lconfig_apply_args_100
.Lconfig_apply_args_99:
    leal ark_str_50, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_101
    movl $_g_config, %eax
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
    jmp .Lconfig_apply_args_102
.Lconfig_apply_args_101:
    leal ark_str_51, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_103
    movl $_g_config, %eax
    pushl %eax
    pushl $12
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
    jmp .Lconfig_apply_args_104
.Lconfig_apply_args_103:
    leal ark_str_52, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_109
    leal ark_str_53, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_110
.Lconfig_apply_args_109:
    pushl $1
.Lconfig_apply_args_110:
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_107
    leal ark_str_54, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_108
.Lconfig_apply_args_107:
    pushl $1
.Lconfig_apply_args_108:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_105
    movl $_g_config, %eax
    pushl %eax
    pushl $16
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
    jmp .Lconfig_apply_args_106
.Lconfig_apply_args_105:
    leal ark_str_55, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_111
    movl $_g_config, %eax
    pushl %eax
    pushl $20
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
    jmp .Lconfig_apply_args_112
.Lconfig_apply_args_111:
    leal ark_str_56, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_115
    leal ark_str_57, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_116
.Lconfig_apply_args_115:
    pushl $1
.Lconfig_apply_args_116:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_113
    movl $_g_config, %eax
    pushl %eax
    pushl $24
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
    jmp .Lconfig_apply_args_114
.Lconfig_apply_args_113:
    leal ark_str_58, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_119
    leal ark_str_59, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_120
.Lconfig_apply_args_119:
    pushl $1
.Lconfig_apply_args_120:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_117
    movl $_g_config, %eax
    pushl %eax
    pushl $28
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
    jmp .Lconfig_apply_args_118
.Lconfig_apply_args_117:
    leal ark_str_60, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_123
    leal ark_str_61, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_124
.Lconfig_apply_args_123:
    pushl $1
.Lconfig_apply_args_124:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_121
    movl $_g_config, %eax
    pushl %eax
    pushl $32
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
    jmp .Lconfig_apply_args_122
.Lconfig_apply_args_121:
    leal ark_str_62, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_127
    leal ark_str_63, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_128
.Lconfig_apply_args_127:
    pushl $1
.Lconfig_apply_args_128:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_125
    movl $_g_config, %eax
    pushl %eax
    pushl $36
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
    jmp .Lconfig_apply_args_126
.Lconfig_apply_args_125:
    leal ark_str_64, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_131
    leal ark_str_65, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_132
.Lconfig_apply_args_131:
    pushl $1
.Lconfig_apply_args_132:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_129
    movl $_g_config, %eax
    pushl %eax
    pushl $40
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
    jmp .Lconfig_apply_args_130
.Lconfig_apply_args_129:
    leal ark_str_66, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lconfig_apply_args_135
    leal ark_str_67, %eax
    pushl %eax
    pushl -16(%ebp)
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
    jmp .Lconfig_apply_args_136
.Lconfig_apply_args_135:
    pushl $1
.Lconfig_apply_args_136:
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_133
    movl $_g_config, %eax
    pushl %eax
    pushl $52
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
    jmp .Lconfig_apply_args_134
.Lconfig_apply_args_133:
    leal ark_str_68, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_137
    movl $_g_config, %eax
    pushl %eax
    pushl $60
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
    jmp .Lconfig_apply_args_138
.Lconfig_apply_args_137:
    leal ark_str_69, %eax
    pushl %eax
    pushl -16(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lconfig_apply_args_139
    movl $_g_config, %eax
    pushl %eax
    pushl $64
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
    jmp .Lconfig_apply_args_2
.Lconfig_apply_args_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _config_print
_config_print:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    leal ark_str_70, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
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
    leal ark_str_71, %eax
    pushl %eax
    call _ark_log
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
    pushl %eax
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    movl $_g_config, %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_72, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
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
    movl $_g_config, %eax
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
    movl $_g_config, %eax
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
    leal ark_str_73, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
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
    movl $_g_config, %eax
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
    leal ark_str_74, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
    pushl %eax
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    movl $_g_config, %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    movl $_g_config, %eax
    pushl %eax
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
    leal ark_str_75, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_config, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
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
    je .Lconfig_print_0
    movl $_g_config, %eax
    pushl %eax
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    jmp .Lconfig_print_1
.Lconfig_print_0:
    leal ark_str_76, %eax
    pushl %eax
.Lconfig_print_1:
    leal ark_str_77, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
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

