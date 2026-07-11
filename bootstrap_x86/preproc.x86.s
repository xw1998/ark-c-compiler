# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_macros
_g_macros:
    .zero 4
    .globl _g_inc_depth
_g_inc_depth:
    .zero 4
    .globl _g_inc_bufs
_g_inc_bufs:
    .zero 33554432
    .globl _g_inc_dirs
_g_inc_dirs:
    .zero 64
    .globl _g_inc_dir_count
_g_inc_dir_count:
    .zero 4
    .globl _g_main_file
_g_main_file:
    .zero 256
    .globl _g_inc_files
_g_inc_files:
    .zero 256
    .globl _g_inc_file_count
_g_inc_file_count:
    .zero 4
    .globl _g_pack_stack
_g_pack_stack:
    .zero 128
    .globl _g_pack_top
_g_pack_top:
    .zero 4
    .globl _g_macro_depth
_g_macro_depth:
    .zero 4
    .globl _g_blue_stack
_g_blue_stack:
    .zero 256
    .globl _g_blue_top
_g_blue_top:
    .zero 4
    .globl _expr_p
_expr_p:
    .zero 4
    .globl _g_cur_line
_g_cur_line:
    .zero 4
    .globl _g_macro_expand
_g_macro_expand:
    .zero 4
    .globl _g_build_date
_g_build_date:
    .zero 12
    .globl _g_build_time
_g_build_time:
    .zero 9
    .globl _ark_sl_preproc_process_out_buf
_ark_sl_preproc_process_out_buf:
    .zero 4194304
    .section .rdata,"dr"
ark_str_0:
    .asciz ""
ark_str_1:
    .asciz ""
ark_str_2:
    .asciz "defined"
ark_str_3:
    .asciz "__VA_ARGS__"
ark_str_4:
    .asciz ", "
ark_str_5:
    .asciz "define"
ark_str_6:
    .asciz "undef"
ark_str_7:
    .asciz "include"
ark_str_8:
    .asciz "[preproc] include too deeply nested: '%s'\n"
ark_str_9:
    .asciz "[preproc] cannot include '%s'\n"
ark_str_10:
    .asciz "if"
ark_str_11:
    .asciz "ifdef"
ark_str_12:
    .asciz "ifndef"
ark_str_13:
    .asciz "ifndef"
ark_str_14:
    .asciz "elif"
ark_str_15:
    .asciz "else"
ark_str_16:
    .asciz "endif"
ark_str_17:
    .asciz "error"
ark_str_18:
    .asciz "[preproc] error: %s\n"
ark_str_19:
    .asciz "warning"
ark_str_20:
    .asciz "[preproc] warning: %s\n"
ark_str_21:
    .asciz "pragma"
ark_str_22:
    .asciz "__at("
ark_str_23:
    .asciz ") "
ark_str_24:
    .asciz "arm"
ark_str_25:
    .asciz "thumb"
ark_str_26:
    .asciz "push"
ark_str_27:
    .asciz "pop"
ark_str_28:
    .asciz "line"
ark_str_29:
    .asciz "_Pragma"
ark_str_30:
    .asciz "__asm"
ark_str_31:
    .asciz "__LINE__"
ark_str_32:
    .asciz "__FILE__"
ark_str_33:
    .asciz "__STDC__"
ark_str_34:
    .asciz "__ARK_CC__"
ark_str_35:
    .asciz "__DATE__"
ark_str_36:
    .asciz "__TIME__"
ark_str_37:
    .asciz "__arm__"
ark_str_38:
    .asciz "1"
ark_str_39:
    .asciz "__arm__"
ark_str_40:
    .asciz "__thumb__"
ark_str_41:
    .asciz "2"
ark_str_42:
    .asciz "__thumb__"
ark_str_43:
    .asciz "__arm"
ark_str_44:
    .asciz "1"
ark_str_45:
    .asciz "__arm"
ark_str_46:
    .asciz "__thumb"
ark_str_47:
    .asciz "2"
ark_str_48:
    .asciz "__thumb"
ark_str_49:
    .asciz "__ARMCC_VERSION"
ark_str_50:
    .asciz "5060750"
ark_str_51:
    .asciz "__ARMCC_VERSION"
ark_str_52:
    .asciz "__CC_ARM"
ark_str_53:
    .asciz "1"
ark_str_54:
    .asciz "__CC_ARM"
ark_str_55:
    .asciz "__TARGET_ARCH_7_M"
ark_str_56:
    .asciz "1"
ark_str_57:
    .asciz "__TARGET_ARCH_7_M"
ark_str_58:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_59:
    .asciz "1"
ark_str_60:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_61:
    .asciz "__TARGET_FPU_VFP"
ark_str_62:
    .asciz "1"
ark_str_63:
    .asciz "__TARGET_FPU_VFP"
ark_str_64:
    .asciz "__BIG_ENDIAN"
ark_str_65:
    .asciz "0"
ark_str_66:
    .asciz "__BIG_ENDIAN"
ark_str_67:
    .asciz "__LITTLE_ENDIAN__"
ark_str_68:
    .asciz "1"
ark_str_69:
    .asciz "__LITTLE_ENDIAN__"
ark_str_70:
    .asciz "__sizeof_int"
ark_str_71:
    .asciz "4"
ark_str_72:
    .asciz "__sizeof_int"
ark_str_73:
    .asciz "__sizeof_ptr"
ark_str_74:
    .asciz "4"
ark_str_75:
    .asciz "__sizeof_ptr"
ark_str_76:
    .asciz "__STDC_VERSION__"
ark_str_77:
    .asciz "199901L"
ark_str_78:
    .asciz "__STDC_VERSION__"
ark_str_79:
    .asciz "__STDC_HOSTED__"
ark_str_80:
    .asciz "0"
ark_str_81:
    .asciz "__STDC_HOSTED__"
ark_str_82:
    .asciz "__SIZE_TYPE__"
ark_str_83:
    .asciz "unsigned int"
ark_str_84:
    .asciz "__SIZE_TYPE__"
ark_str_85:
    .asciz "__PTRDIFF_TYPE__"
ark_str_86:
    .asciz "int"
ark_str_87:
    .asciz "__PTRDIFF_TYPE__"
ark_str_88:
    .asciz "__WCHAR_TYPE__"
ark_str_89:
    .asciz "unsigned int"
ark_str_90:
    .asciz "__WCHAR_TYPE__"
ark_str_91:
    .asciz "__EDG__"
ark_str_92:
    .asciz "1"
ark_str_93:
    .asciz "__EDG__"
ark_str_94:
    .asciz "__APCS_INTERWORK"
ark_str_95:
    .asciz "1"
ark_str_96:
    .asciz "__APCS_INTERWORK"
    .text
_apply_trigraphs:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -56(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
.Lapply_trigraphs_0:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_trigraphs_1
    pushl -40(%ebp)
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
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_trigraphs_4
    pushl -40(%ebp)
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
    pushl $63
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
    jmp .Lapply_trigraphs_5
.Lapply_trigraphs_4:
    pushl $0
.Lapply_trigraphs_5:
    popl %eax
    cmpl $0, %eax
    je .Lapply_trigraphs_2
    pushl $0
    popl %eax
    movb %al, -32(%ebp)
    pushl -40(%ebp)
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_7
    pushl -24(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_8
    pushl -24(%ebp)
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_9
    pushl -24(%ebp)
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_10
    pushl -24(%ebp)
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_11
    pushl -24(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_12
    pushl -24(%ebp)
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_13
    pushl -24(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_14
    pushl -24(%ebp)
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lapply_trigraphs_15
    jmp .Lapply_trigraphs_16
.Lapply_trigraphs_7:
    pushl $35
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_8:
    pushl $91
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_9:
    pushl $92
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_10:
    pushl $93
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_11:
    pushl $94
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_12:
    pushl $123
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_13:
    pushl $125
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_14:
    pushl $124
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_15:
    pushl $126
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_16:
    pushl $0
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_6
.Lapply_trigraphs_6:
    movzbl -32(%ebp), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lapply_trigraphs_17
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    movzbl -32(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lapply_trigraphs_0
.Lapply_trigraphs_17:
.Lapply_trigraphs_18:
    jmp .Lapply_trigraphs_3
.Lapply_trigraphs_2:
.Lapply_trigraphs_3:
    pushl -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -40(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
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
    jmp .Lapply_trigraphs_0
.Lapply_trigraphs_1:
    pushl -48(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -48(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_blue_painted:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lis_blue_painted_0:
    pushl -16(%ebp)
    movl _g_blue_top, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_blue_painted_1
    pushl -24(%ebp)
    movl $_g_blue_stack, %eax
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
    je .Lis_blue_painted_3
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_blue_painted_3:
.Lis_blue_painted_4:
.Lis_blue_painted_2:
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
    jmp .Lis_blue_painted_0
.Lis_blue_painted_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alpha:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_alpha_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $122
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
    jmp .Lis_alpha_5
.Lis_alpha_4:
    pushl $0
.Lis_alpha_5:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_2
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_alpha_6
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $90
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
    jmp .Lis_alpha_7
.Lis_alpha_6:
    pushl $0
.Lis_alpha_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_3
.Lis_alpha_2:
    pushl $1
.Lis_alpha_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_0
    movzbl -24(%ebp), %eax
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
    jmp .Lis_alpha_1
.Lis_alpha_0:
    pushl $1
.Lis_alpha_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_digit:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lis_digit_0
    movzbl -24(%ebp), %eax
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
    jmp .Lis_digit_1
.Lis_digit_0:
    pushl $0
.Lis_digit_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alnum:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_alnum_0
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alnum_1
.Lis_alnum_0:
    pushl $1
.Lis_alnum_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_hex:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_hex_2
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_hex_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $102
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
    jmp .Lis_hex_5
.Lis_hex_4:
    pushl $0
.Lis_hex_5:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_hex_3
.Lis_hex_2:
    pushl $1
.Lis_hex_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_hex_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_hex_6
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $70
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
    jmp .Lis_hex_7
.Lis_hex_6:
    pushl $0
.Lis_hex_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_hex_1
.Lis_hex_0:
    pushl $1
.Lis_hex_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_hex_val:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lhex_val_2
    movzbl -24(%ebp), %eax
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
    jmp .Lhex_val_3
.Lhex_val_2:
    pushl $0
.Lhex_val_3:
    popl %eax
    cmpl $0, %eax
    je .Lhex_val_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhex_val_0:
.Lhex_val_1:
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhex_val_6
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $102
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
    jmp .Lhex_val_7
.Lhex_val_6:
    pushl $0
.Lhex_val_7:
    popl %eax
    cmpl $0, %eax
    je .Lhex_val_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhex_val_4:
.Lhex_val_5:
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_find_macro:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl _g_macros, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lfind_macro_0:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lfind_macro_1
    pushl -24(%ebp)
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfind_macro_3
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfind_macro_3:
.Lfind_macro_4:
.Lfind_macro_2:
    pushl -16(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lfind_macro_0
.Lfind_macro_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_remove_macro:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl $_g_macros, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
.Lremove_macro_0:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lremove_macro_1
    pushl -24(%ebp)
    pushl -16(%ebp)
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lremove_macro_2
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
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
.Lremove_macro_2:
.Lremove_macro_3:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lremove_macro_0
.Lremove_macro_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_add_object_macro:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $28
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
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
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ladd_object_macro_0
    pushl -32(%ebp)
    jmp .Ladd_object_macro_1
.Ladd_object_macro_0:
    leal ark_str_0, %eax
    pushl %eax
.Ladd_object_macro_1:
    call _mem_strdup
    addl $4, %esp
    pushl %eax
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
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_macros, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macros
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

_add_func_macro:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 24(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $28
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ladd_func_macro_0
    pushl -24(%ebp)
    jmp .Ladd_func_macro_1
.Ladd_func_macro_0:
    leal ark_str_1, %eax
    pushl %eax
.Ladd_func_macro_1:
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
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
    pushl -16(%ebp)
    pushl $12
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
    pushl $16
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
    pushl $20
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
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _g_macros, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macros
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

_buf_putc:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -32(%ebp)
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
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lbuf_putc_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lbuf_putc_0:
.Lbuf_putc_1:
    pushl -40(%ebp)
    pushl -32(%ebp)
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
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movzbl -16(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
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

_buf_puts:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -16(%ebp)
.Lbuf_puts_0:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lbuf_puts_1
    pushl -16(%ebp)
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lbuf_puts_0
.Lbuf_puts_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_emit_int:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -80(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
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
    je .Lemit_int_0
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lemit_int_1
.Lemit_int_0:
    pushl -64(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lemit_int_1:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_int_2
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl $48
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lemit_int_3
.Lemit_int_2:
.Lemit_int_3:
.Lemit_int_4:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_int_5
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl $48
    pushl -16(%ebp)
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
    pushl -16(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    xorl %edx, %edx
    divl %ecx
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lemit_int_4
.Lemit_int_5:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lemit_int_6
    pushl $45
    pushl -72(%ebp)
    pushl -80(%ebp)
    pushl -88(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lemit_int_7
.Lemit_int_6:
.Lemit_int_7:
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lemit_int_8:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lemit_int_9
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl -72(%ebp)
    pushl -80(%ebp)
    pushl -88(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lemit_int_10:
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
    jmp .Lemit_int_8
.Lemit_int_9:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _preproc_reset
_preproc_reset:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macros
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_depth
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_dir_count
    addl $4, %esp
    movl $_g_main_file, %eax
    pushl %eax
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
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_file_count
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_pack_top
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_depth
    addl $4, %esp
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_blue_top
    addl $4, %esp
    pushl $0
    call _type_set_pack
    addl $4, %esp
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

    .globl _preproc_define
_preproc_define:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    call _remove_macro
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl -24(%ebp)
    call _add_object_macro
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

    .globl _preproc_undef
_preproc_undef:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    call _remove_macro
    addl $4, %esp
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

    .globl _preproc_add_include_dir
_preproc_add_include_dir:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl _g_inc_dir_count, %eax
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
    je .Lpreproc_add_include_dir_0
    movl $_g_inc_dirs, %eax
    pushl %eax
    movl _g_inc_dir_count, %eax
    pushl %eax
    movl _g_inc_dir_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_dir_count
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lpreproc_add_include_dir_1
.Lpreproc_add_include_dir_0:
.Lpreproc_add_include_dir_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _preproc_set_main_file
_preproc_set_main_file:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_set_main_file_0
    pushl $255
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lpreproc_set_main_file_1
.Lpreproc_set_main_file_0:
.Lpreproc_set_main_file_1:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lpreproc_set_main_file_2:
    pushl -24(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_set_main_file_3
    movl $_g_main_file, %eax
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
    pushl -40(%ebp)
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
.Lpreproc_set_main_file_4:
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
    jmp .Lpreproc_set_main_file_2
.Lpreproc_set_main_file_3:
    movl $_g_main_file, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
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

_read_include:
    pushl %ebp
    movl %esp, %ebp
    subl $832, %esp
    movl 8(%ebp), %eax
    movl %eax, -584(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -576(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -568(%ebp)
    pushl -568(%ebp)
    pushl -576(%ebp)
    pushl -584(%ebp)
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -560(%ebp)
    pushl -560(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_0
    pushl -560(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_include_0:
.Lread_include_1:
    pushl $0
    popl %eax
    movl %eax, -552(%ebp)
    pushl -552(%ebp)
    addl $4, %esp
.Lread_include_2:
    pushl -552(%ebp)
    movl _g_inc_dir_count, %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_3
    movl $_g_inc_dirs, %eax
    pushl %eax
    pushl -552(%ebp)
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
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -584(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $512
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_5
    jmp .Lread_include_4
.Lread_include_5:
.Lread_include_6:
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lread_include_7:
    pushl -16(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_8
    leal -544(%ebp), %eax
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
    movl $_g_inc_dirs, %eax
    pushl %eax
    pushl -552(%ebp)
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
.Lread_include_9:
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
    jmp .Lread_include_7
.Lread_include_8:
    leal -544(%ebp), %eax
    pushl %eax
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
    pushl $47
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lread_include_10:
    pushl -16(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_11
    leal -544(%ebp), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16(%ebp)
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
    pushl -584(%ebp)
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
.Lread_include_12:
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
    jmp .Lread_include_10
.Lread_include_11:
    leal -544(%ebp), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
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
    pushl -568(%ebp)
    pushl -576(%ebp)
    leal -544(%ebp), %eax
    pushl %eax
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -560(%ebp)
    pushl -560(%ebp)
    addl $4, %esp
    pushl -560(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_include_13
    pushl -560(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_include_13:
.Lread_include_14:
.Lread_include_4:
    pushl -552(%ebp)
    pushl -552(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -552(%ebp)
    addl $4, %esp
    jmp .Lread_include_2
.Lread_include_3:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_ws_p:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
.Lskip_ws_p_0:
    movl _expr_p, %eax
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
    jne .Lskip_ws_p_2
    movl _expr_p, %eax
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
    jmp .Lskip_ws_p_3
.Lskip_ws_p_2:
    pushl $1
.Lskip_ws_p_3:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_p_1
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lskip_ws_p_0
.Lskip_ws_p_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_primary:
    pushl %ebp
    movl %esp, %ebp
    subl $432, %esp
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
    movl %eax, -184(%ebp)
    movl %edx, -180(%ebp)
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_0
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    pushl $0
    call _eval_expr
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -184(%ebp)
    movl %edx, -180(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_2
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_3
.Lparse_primary_2:
.Lparse_primary_3:
    pushl -184(%ebp)
    pushl -180(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_0:
.Lparse_primary_1:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_4
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    call _parse_primary
    pushl %eax
    popl %edx
    popl %eax
    orl %edx, %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_4:
.Lparse_primary_5:
    movl _expr_p, %eax
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
    je .Lparse_primary_6
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    call _parse_primary
    pushl %eax
    popl %edx
    popl %eax
    negl %eax
    adcl $0, %edx
    negl %edx
    pushl %eax
    pushl %edx
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_6:
.Lparse_primary_7:
    movl _expr_p, %eax
    pushl %eax
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
    je .Lparse_primary_8
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    call _parse_primary
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_8:
.Lparse_primary_9:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $126
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_10
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    call _parse_primary
    pushl %eax
    popl %edx
    popl %eax
    notl %eax
    notl %edx
    pushl %eax
    pushl %edx
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_10:
.Lparse_primary_11:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_12
    movl _expr_p, %eax
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
    je .Lparse_primary_16
    movl _expr_p, %eax
    pushl %eax
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
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_primary_18
    movl _expr_p, %eax
    pushl %eax
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
    pushl $88
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
    jmp .Lparse_primary_19
.Lparse_primary_18:
    pushl $1
.Lparse_primary_19:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_17
.Lparse_primary_16:
    pushl $0
.Lparse_primary_17:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_14
    movl _expr_p, %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
.Lparse_primary_20:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_21
    pushl -184(%ebp)
    pushl -180(%ebp)
    pushl $16
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
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _hex_val
    addl $4, %esp
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
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -184(%ebp)
    movl %edx, -180(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_20
.Lparse_primary_21:
    jmp .Lparse_primary_15
.Lparse_primary_14:
    movl _expr_p, %eax
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
    je .Lparse_primary_26
    movl _expr_p, %eax
    pushl %eax
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
    jmp .Lparse_primary_27
.Lparse_primary_26:
    pushl $0
.Lparse_primary_27:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_24
    movl _expr_p, %eax
    pushl %eax
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
    pushl $55
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
    jmp .Lparse_primary_25
.Lparse_primary_24:
    pushl $0
.Lparse_primary_25:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_22
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
.Lparse_primary_28:
    movl _expr_p, %eax
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
    je .Lparse_primary_30
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $55
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
    jmp .Lparse_primary_31
.Lparse_primary_30:
    pushl $0
.Lparse_primary_31:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_29
    pushl -184(%ebp)
    pushl -180(%ebp)
    pushl $8
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
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    movl _expr_p, %eax
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
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -184(%ebp)
    movl %edx, -180(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_28
.Lparse_primary_29:
    jmp .Lparse_primary_23
.Lparse_primary_22:
.Lparse_primary_32:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_33
    pushl -184(%ebp)
    pushl -180(%ebp)
    pushl $10
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
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    movl _expr_p, %eax
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
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -184(%ebp)
    movl %edx, -180(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_32
.Lparse_primary_33:
.Lparse_primary_23:
.Lparse_primary_15:
.Lparse_primary_34:
    movl _expr_p, %eax
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
    jne .Lparse_primary_40
    movl _expr_p, %eax
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
    jmp .Lparse_primary_41
.Lparse_primary_40:
    pushl $1
.Lparse_primary_41:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_primary_38
    movl _expr_p, %eax
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_primary_39
.Lparse_primary_38:
    pushl $1
.Lparse_primary_39:
    popl %eax
    cmpl $0, %eax
    jne .Lparse_primary_36
    movl _expr_p, %eax
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
    jmp .Lparse_primary_37
.Lparse_primary_36:
    pushl $1
.Lparse_primary_37:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_35
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_34
.Lparse_primary_35:
    pushl -184(%ebp)
    pushl -180(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_12:
.Lparse_primary_13:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_42
    movl _expr_p, %eax
    pushl %eax
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
.Lparse_primary_44:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_45
    pushl -104(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_46
    leal -168(%ebp), %eax
    pushl %eax
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _expr_p, %eax
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
    jmp .Lparse_primary_47
.Lparse_primary_46:
.Lparse_primary_47:
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_44
.Lparse_primary_45:
    leal -168(%ebp), %eax
    pushl %eax
    pushl -104(%ebp)
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
    leal ark_str_2, %eax
    pushl %eax
    leal -168(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_48
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_50
    pushl $1
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    jmp .Lparse_primary_51
.Lparse_primary_50:
.Lparse_primary_51:
.Lparse_primary_52:
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_54
    pushl -24(%ebp)
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
    jmp .Lparse_primary_55
.Lparse_primary_54:
    pushl $0
.Lparse_primary_55:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_53
    leal -88(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
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
    jmp .Lparse_primary_52
.Lparse_primary_53:
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_58
    movl _expr_p, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_primary_59
.Lparse_primary_58:
    pushl $0
.Lparse_primary_59:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_56
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Lparse_primary_57
.Lparse_primary_56:
.Lparse_primary_57:
    leal -88(%ebp), %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_60
    pushl $1
    jmp .Lparse_primary_61
.Lparse_primary_60:
    pushl $0
.Lparse_primary_61:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_48:
.Lparse_primary_49:
    leal -168(%ebp), %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_64
    pushl -96(%ebp)
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
    jmp .Lparse_primary_65
.Lparse_primary_64:
    pushl $0
.Lparse_primary_65:
    popl %eax
    cmpl $0, %eax
    je .Lparse_primary_62
    movl _expr_p, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
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
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    pushl $0
    call _eval_expr
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -80(%ebp)
    movl %edx, -76(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    pushl -80(%ebp)
    pushl -76(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_62:
.Lparse_primary_63:
    pushl -176(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_primary_42:
.Lparse_primary_43:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_eval_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    call _parse_primary
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
.Leval_expr_0:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    call _skip_ws_p
    pushl %eax
    addl $4, %esp
    movl _expr_p, %eax
    pushl %eax
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
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_5
    movl _expr_p, %eax
    pushl %eax
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
    jmp .Leval_expr_6
.Leval_expr_5:
    pushl $0
.Leval_expr_6:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_3
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_4
.Leval_expr_3:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $124
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_9
    movl _expr_p, %eax
    pushl %eax
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
    pushl $124
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
    jmp .Leval_expr_10
.Leval_expr_9:
    pushl $0
.Leval_expr_10:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_7
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $2
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_8
.Leval_expr_7:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_13
    movl _expr_p, %eax
    pushl %eax
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
    pushl $61
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
    jmp .Leval_expr_14
.Leval_expr_13:
    pushl $0
.Leval_expr_14:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_11
    pushl $2
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $3
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_12
.Leval_expr_11:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_17
    movl _expr_p, %eax
    pushl %eax
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
    pushl $61
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
    jmp .Leval_expr_18
.Leval_expr_17:
    pushl $0
.Leval_expr_18:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_15
    pushl $2
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $4
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_16
.Leval_expr_15:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_21
    movl _expr_p, %eax
    pushl %eax
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
    pushl $61
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
    jmp .Leval_expr_22
.Leval_expr_21:
    pushl $0
.Leval_expr_22:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_19
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $7
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_20
.Leval_expr_19:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_25
    movl _expr_p, %eax
    pushl %eax
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
    pushl $61
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
    jmp .Leval_expr_26
.Leval_expr_25:
    pushl $0
.Leval_expr_26:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_23
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $8
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_24
.Leval_expr_23:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_29
    movl _expr_p, %eax
    pushl %eax
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
    pushl $60
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
    jmp .Leval_expr_30
.Leval_expr_29:
    pushl $0
.Leval_expr_30:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_27
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $13
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_28
.Leval_expr_27:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_33
    movl _expr_p, %eax
    pushl %eax
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
    pushl $62
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
    jmp .Leval_expr_34
.Leval_expr_33:
    pushl $0
.Leval_expr_34:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_31
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $14
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_32
.Leval_expr_31:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_35
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $15
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_36
.Leval_expr_35:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $124
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_37
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $16
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_38
.Leval_expr_37:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $94
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_39
    pushl $2
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $17
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_40
.Leval_expr_39:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_41
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $5
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_42
.Leval_expr_41:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_43
    pushl $3
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $6
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_44
.Leval_expr_43:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_45
    pushl $4
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $9
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_46
.Leval_expr_45:
    movl _expr_p, %eax
    pushl %eax
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
    je .Leval_expr_47
    pushl $4
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $10
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_48
.Leval_expr_47:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_49
    pushl $5
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $11
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_50
.Leval_expr_49:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_51
    pushl $5
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $12
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_52
.Leval_expr_51:
    movl _expr_p, %eax
    pushl %eax
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
    pushl $37
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_53
    pushl $5
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $18
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Leval_expr_54
.Leval_expr_53:
.Leval_expr_54:
.Leval_expr_52:
.Leval_expr_50:
.Leval_expr_48:
.Leval_expr_46:
.Leval_expr_44:
.Leval_expr_42:
.Leval_expr_40:
.Leval_expr_38:
.Leval_expr_36:
.Leval_expr_32:
.Leval_expr_28:
.Leval_expr_24:
.Leval_expr_20:
.Leval_expr_16:
.Leval_expr_12:
.Leval_expr_8:
.Leval_expr_4:
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
    je .Leval_expr_55
    jmp .Leval_expr_1
.Leval_expr_55:
.Leval_expr_56:
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_71
    pushl -32(%ebp)
    pushl $2
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
    jmp .Leval_expr_72
.Leval_expr_71:
    pushl $1
.Leval_expr_72:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_69
    pushl -32(%ebp)
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
    jmp .Leval_expr_70
.Leval_expr_69:
    pushl $1
.Leval_expr_70:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_67
    pushl -32(%ebp)
    pushl $4
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
    jmp .Leval_expr_68
.Leval_expr_67:
    pushl $1
.Leval_expr_68:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_65
    pushl -32(%ebp)
    pushl $7
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
    jmp .Leval_expr_66
.Leval_expr_65:
    pushl $1
.Leval_expr_66:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_63
    pushl -32(%ebp)
    pushl $8
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
    jmp .Leval_expr_64
.Leval_expr_63:
    pushl $1
.Leval_expr_64:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_61
    pushl -32(%ebp)
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
    jmp .Leval_expr_62
.Leval_expr_61:
    pushl $1
.Leval_expr_62:
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_59
    pushl -32(%ebp)
    pushl $14
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
    jmp .Leval_expr_60
.Leval_expr_59:
    pushl $1
.Leval_expr_60:
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_57
    movl _expr_p, %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    jmp .Leval_expr_58
.Leval_expr_57:
    movl _expr_p, %eax
    pushl %eax
    movl _expr_p, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
.Leval_expr_58:
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _eval_expr
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -24(%ebp)
    movl %edx, -20(%ebp)
    pushl -32(%ebp)
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
    jne .Leval_expr_74
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
    jne .Leval_expr_75
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
    jne .Leval_expr_76
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_77
    pushl -16(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_78
    pushl -16(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_79
    pushl -16(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_80
    pushl -16(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_81
    pushl -16(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_82
    pushl -16(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_83
    pushl -16(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_84
    pushl -16(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_85
    pushl -16(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_86
    pushl -16(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_87
    pushl -16(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_88
    pushl -16(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_89
    pushl -16(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_90
    pushl -16(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_91
    jmp .Leval_expr_92
.Leval_expr_74:
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_93
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Leval_expr_94
.Leval_expr_93:
    pushl $0
.Leval_expr_94:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_75:
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_expr_95
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Leval_expr_96
.Leval_expr_95:
    pushl $1
.Leval_expr_96:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_76:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_eval_expr_685
    cmpl %eax, (%esp)
    jne .L64f_eval_expr_685
    addl $4, %esp
    pushl $1
    jmp .L64e_eval_expr_685
.L64f_eval_expr_685:
    addl $4, %esp
    pushl $0
.L64e_eval_expr_685:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_77:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64t_eval_expr_697
    cmpl %eax, (%esp)
    jne .L64t_eval_expr_697
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_expr_697
.L64t_eval_expr_697:
    addl $4, %esp
    pushl $1
.L64e_eval_expr_697:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_78:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jl .L64t_eval_expr_709
    jg .L64f_eval_expr_709
    cmpl %eax, (%esp)
    jl .L64t_eval_expr_709
.L64f_eval_expr_709:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_expr_709
.L64t_eval_expr_709:
    addl $4, %esp
    pushl $1
.L64e_eval_expr_709:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_79:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jg .L64t_eval_expr_721
    jl .L64f_eval_expr_721
    cmpl %eax, (%esp)
    jg .L64t_eval_expr_721
.L64f_eval_expr_721:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_expr_721
.L64t_eval_expr_721:
    addl $4, %esp
    pushl $1
.L64e_eval_expr_721:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_80:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jl .L64t_eval_expr_733
    jg .L64f_eval_expr_733
    cmpl %eax, (%esp)
    jle .L64t_eval_expr_733
    je .L64t_eval_expr_733
.L64f_eval_expr_733:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_expr_733
.L64t_eval_expr_733:
    addl $4, %esp
    pushl $1
.L64e_eval_expr_733:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_81:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jg .L64t_eval_expr_745
    jl .L64f_eval_expr_745
    cmpl %eax, (%esp)
    jge .L64t_eval_expr_745
    je .L64t_eval_expr_745
.L64f_eval_expr_745:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_expr_745
.L64t_eval_expr_745:
    addl $4, %esp
    pushl $1
.L64e_eval_expr_745:
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
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_82:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_83:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    subl %eax, 4(%esp)
    sbbl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_84:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_85:
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_97
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___divdi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    jmp .Leval_expr_98
.Leval_expr_97:
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
.Leval_expr_98:
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_86:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_87:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_88:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    andl %eax, 4(%esp)
    andl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_89:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %eax, 4(%esp)
    orl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_90:
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    xorl %eax, 4(%esp)
    xorl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_91:
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_expr_99
    pushl -48(%ebp)
    pushl -44(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    movl 0(%esp), %eax
    movl 12(%esp), %edx
    movl %edx, 0(%esp)
    movl %eax, 12(%esp)
    movl 4(%esp), %eax
    movl 8(%esp), %edx
    movl %edx, 4(%esp)
    movl %eax, 8(%esp)
    call ___moddi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    jmp .Leval_expr_100
.Leval_expr_99:
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
.Leval_expr_100:
    popl %edx
    popl %eax
    movl %eax, -48(%ebp)
    movl %edx, -44(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Leval_expr_73
.Leval_expr_92:
    jmp .Leval_expr_73
.Leval_expr_73:
.Leval_expr_2:
    jmp .Leval_expr_0
.Leval_expr_1:
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_eval_pp_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _expr_p
    addl $4, %esp
    pushl $0
    call _eval_expr
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_pp_expr_0
    pushl $1
    jmp .Leval_pp_expr_1
.Leval_pp_expr_0:
    pushl $0
.Leval_pp_expr_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_macro_args:
    pushl %ebp
    movl %esp, %ebp
    subl $1344, %esp
    movl 8(%ebp), %eax
    movl %eax, -1096(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -1088(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -1080(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -1072(%ebp)
    pushl $1
    popl %eax
    movl %eax, -1064(%ebp)
    pushl $0
    popl %eax
    movl %eax, -1056(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_0
    pushl -1080(%ebp)
    pushl $0
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -1096(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_macro_args_0:
.Lparse_macro_args_1:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
.Lparse_macro_args_2:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_4
    pushl -1064(%ebp)
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
    jmp .Lparse_macro_args_5
.Lparse_macro_args_4:
    pushl $0
.Lparse_macro_args_5:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_3
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_6
    pushl -1064(%ebp)
    pushl -1064(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1064(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_8
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_9
.Lparse_macro_args_8:
.Lparse_macro_args_9:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_2
.Lparse_macro_args_6:
.Lparse_macro_args_7:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_10
    pushl -1064(%ebp)
    pushl -1064(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1064(%ebp)
    addl $4, %esp
    pushl -1064(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_12
    leal -1048(%ebp), %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -1056(%ebp)
    pushl -1072(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_14
    pushl -1088(%ebp)
    pushl -1056(%ebp)
    pushl -1056(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1056(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -1048(%ebp), %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_macro_args_15
.Lparse_macro_args_14:
.Lparse_macro_args_15:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_3
.Lparse_macro_args_12:
.Lparse_macro_args_13:
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_16
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_17
.Lparse_macro_args_16:
.Lparse_macro_args_17:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_2
.Lparse_macro_args_10:
.Lparse_macro_args_11:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_20
    pushl -1064(%ebp)
    pushl $1
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
    jmp .Lparse_macro_args_21
.Lparse_macro_args_20:
    pushl $0
.Lparse_macro_args_21:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_18
    leal -1048(%ebp), %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -1056(%ebp)
    pushl -1072(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_22
    pushl -1088(%ebp)
    pushl -1056(%ebp)
    pushl -1056(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1056(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -1048(%ebp), %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_macro_args_23
.Lparse_macro_args_22:
.Lparse_macro_args_23:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
.Lparse_macro_args_24:
    pushl -1096(%ebp)
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
    jne .Lparse_macro_args_26
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_27
.Lparse_macro_args_26:
    pushl $1
.Lparse_macro_args_27:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_25
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_24
.Lparse_macro_args_25:
    jmp .Lparse_macro_args_2
.Lparse_macro_args_18:
.Lparse_macro_args_19:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lparse_macro_args_30
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lparse_macro_args_31
.Lparse_macro_args_30:
    pushl $1
.Lparse_macro_args_31:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_28
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -16(%ebp)
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_32
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_33
.Lparse_macro_args_32:
.Lparse_macro_args_33:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
.Lparse_macro_args_34:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_36
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    movzbl -16(%ebp), %eax
    pushl %eax
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
    jmp .Lparse_macro_args_37
.Lparse_macro_args_36:
    pushl $0
.Lparse_macro_args_37:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_35
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_40
    pushl -1096(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_macro_args_41
.Lparse_macro_args_40:
    pushl $0
.Lparse_macro_args_41:
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_38
    pushl -24(%ebp)
    pushl $1022
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_42
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lparse_macro_args_43
.Lparse_macro_args_42:
.Lparse_macro_args_43:
    pushl -1096(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    pushl -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_34
.Lparse_macro_args_38:
.Lparse_macro_args_39:
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_44
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_45
.Lparse_macro_args_44:
.Lparse_macro_args_45:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_34
.Lparse_macro_args_35:
    pushl -1096(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_46
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_48
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_49
.Lparse_macro_args_48:
.Lparse_macro_args_49:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_47
.Lparse_macro_args_46:
.Lparse_macro_args_47:
    jmp .Lparse_macro_args_2
.Lparse_macro_args_28:
.Lparse_macro_args_29:
    pushl -24(%ebp)
    pushl $1023
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_macro_args_50
    leal -1048(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -1096(%ebp)
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
    jmp .Lparse_macro_args_51
.Lparse_macro_args_50:
.Lparse_macro_args_51:
    pushl -1096(%ebp)
    pushl -1096(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -1096(%ebp)
    addl $4, %esp
    jmp .Lparse_macro_args_2
.Lparse_macro_args_3:
    pushl -1080(%ebp)
    pushl -1056(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -1096(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_expand_func_macro:
    pushl %ebp
    movl %esp, %ebp
    subl $416, %esp
    movl 8(%ebp), %eax
    movl %eax, -168(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -160(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -152(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -144(%ebp)
    movl 24(%ebp), %eax
    movl %eax, -136(%ebp)
    movl 28(%ebp), %eax
    movl %eax, -128(%ebp)
    pushl -168(%ebp)
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
    movl %eax, -120(%ebp)
.Lexpand_func_macro_0:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_1
    pushl -120(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_4
    pushl -120(%ebp)
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
    jmp .Lexpand_func_macro_5
.Lexpand_func_macro_4:
    pushl $0
.Lexpand_func_macro_5:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_2
    pushl -120(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
.Lexpand_func_macro_6:
    pushl -136(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_8
    pushl -144(%ebp)
    pushl -136(%ebp)
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
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lexpand_func_macro_10
    pushl -144(%ebp)
    pushl -136(%ebp)
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
    jmp .Lexpand_func_macro_11
.Lexpand_func_macro_10:
    pushl $1
.Lexpand_func_macro_11:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lexpand_func_macro_9
.Lexpand_func_macro_8:
    pushl $0
.Lexpand_func_macro_9:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_7
    pushl -136(%ebp)
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
    pushl $-1
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
    jmp .Lexpand_func_macro_6
.Lexpand_func_macro_7:
.Lexpand_func_macro_12:
    pushl -120(%ebp)
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
    jne .Lexpand_func_macro_14
    pushl -120(%ebp)
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
    jmp .Lexpand_func_macro_15
.Lexpand_func_macro_14:
    pushl $1
.Lexpand_func_macro_15:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_13
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    addl $4, %esp
    jmp .Lexpand_func_macro_12
.Lexpand_func_macro_13:
    pushl -120(%ebp)
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
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
    je .Lexpand_func_macro_38
    pushl -112(%ebp)
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
    jmp .Lexpand_func_macro_39
.Lexpand_func_macro_38:
    pushl $0
.Lexpand_func_macro_39:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_36
    pushl -112(%ebp)
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
    jmp .Lexpand_func_macro_37
.Lexpand_func_macro_36:
    pushl $0
.Lexpand_func_macro_37:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_34
    pushl -112(%ebp)
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
    pushl $86
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
    jmp .Lexpand_func_macro_35
.Lexpand_func_macro_34:
    pushl $0
.Lexpand_func_macro_35:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_32
    pushl -112(%ebp)
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
    jmp .Lexpand_func_macro_33
.Lexpand_func_macro_32:
    pushl $0
.Lexpand_func_macro_33:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_30
    pushl -112(%ebp)
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
    jmp .Lexpand_func_macro_31
.Lexpand_func_macro_30:
    pushl $0
.Lexpand_func_macro_31:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_28
    pushl -112(%ebp)
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
    jmp .Lexpand_func_macro_29
.Lexpand_func_macro_28:
    pushl $0
.Lexpand_func_macro_29:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_26
    pushl -112(%ebp)
    pushl $6
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
    jmp .Lexpand_func_macro_27
.Lexpand_func_macro_26:
    pushl $0
.Lexpand_func_macro_27:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_24
    pushl -112(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $71
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
    jmp .Lexpand_func_macro_25
.Lexpand_func_macro_24:
    pushl $0
.Lexpand_func_macro_25:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_22
    pushl -112(%ebp)
    pushl $8
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
    jmp .Lexpand_func_macro_23
.Lexpand_func_macro_22:
    pushl $0
.Lexpand_func_macro_23:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_20
    pushl -112(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lexpand_func_macro_21
.Lexpand_func_macro_20:
    pushl $0
.Lexpand_func_macro_21:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_18
    pushl -112(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lexpand_func_macro_19
.Lexpand_func_macro_18:
    pushl $0
.Lexpand_func_macro_19:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_16
    pushl -152(%ebp)
    pushl -168(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_40
.Lexpand_func_macro_42:
    pushl -136(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_44
    pushl -144(%ebp)
    pushl -136(%ebp)
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
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lexpand_func_macro_46
    pushl -144(%ebp)
    pushl -136(%ebp)
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
    jmp .Lexpand_func_macro_47
.Lexpand_func_macro_46:
    pushl $1
.Lexpand_func_macro_47:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lexpand_func_macro_45
.Lexpand_func_macro_44:
    pushl $0
.Lexpand_func_macro_45:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_43
    pushl -136(%ebp)
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
    pushl $-1
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
    jmp .Lexpand_func_macro_42
.Lexpand_func_macro_43:
    pushl -136(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_50
    pushl -144(%ebp)
    pushl -136(%ebp)
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
    jmp .Lexpand_func_macro_51
.Lexpand_func_macro_50:
    pushl $0
.Lexpand_func_macro_51:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_48
    pushl -136(%ebp)
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
    pushl $-1
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
    jmp .Lexpand_func_macro_49
.Lexpand_func_macro_48:
.Lexpand_func_macro_49:
    pushl -120(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_40:
.Lexpand_func_macro_41:
    jmp .Lexpand_func_macro_17
.Lexpand_func_macro_16:
.Lexpand_func_macro_17:
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_2:
.Lexpand_func_macro_3:
    pushl -120(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_54
    pushl -120(%ebp)
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
    call _is_alpha
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lexpand_func_macro_55
.Lexpand_func_macro_54:
    pushl $0
.Lexpand_func_macro_55:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_52
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
.Lexpand_func_macro_56:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_58
    pushl -40(%ebp)
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
    jmp .Lexpand_func_macro_59
.Lexpand_func_macro_58:
    pushl $0
.Lexpand_func_macro_59:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_57
    leal -104(%ebp), %eax
    pushl %eax
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
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
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
    jmp .Lexpand_func_macro_56
.Lexpand_func_macro_57:
    leal -104(%ebp), %eax
    pushl %eax
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
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lexpand_func_macro_60:
    pushl -32(%ebp)
    pushl -168(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_61
    leal -104(%ebp), %eax
    pushl %eax
    pushl -168(%ebp)
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
    je .Lexpand_func_macro_63
    pushl -32(%ebp)
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lexpand_func_macro_61
.Lexpand_func_macro_63:
.Lexpand_func_macro_64:
.Lexpand_func_macro_62:
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
    jmp .Lexpand_func_macro_60
.Lexpand_func_macro_61:
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
    je .Lexpand_func_macro_67
    pushl -24(%ebp)
    pushl -152(%ebp)
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
    jmp .Lexpand_func_macro_68
.Lexpand_func_macro_67:
    pushl $0
.Lexpand_func_macro_68:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_65
    pushl -160(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl $34
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lexpand_func_macro_69:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_70
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lexpand_func_macro_73
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
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
    jmp .Lexpand_func_macro_74
.Lexpand_func_macro_73:
    pushl $1
.Lexpand_func_macro_74:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_71
    pushl $92
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_72
.Lexpand_func_macro_71:
.Lexpand_func_macro_72:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
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
    jmp .Lexpand_func_macro_69
.Lexpand_func_macro_70:
    pushl $34
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_65:
.Lexpand_func_macro_66:
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_52:
.Lexpand_func_macro_53:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_75
    pushl -120(%ebp)
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
.Lexpand_func_macro_77:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_79
    pushl -40(%ebp)
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
    jmp .Lexpand_func_macro_80
.Lexpand_func_macro_79:
    pushl $0
.Lexpand_func_macro_80:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_78
    leal -104(%ebp), %eax
    pushl %eax
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
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
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
    jmp .Lexpand_func_macro_77
.Lexpand_func_macro_78:
    leal -104(%ebp), %eax
    pushl %eax
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
    pushl -168(%ebp)
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
    je .Lexpand_func_macro_83
    leal ark_str_3, %eax
    pushl %eax
    leal -104(%ebp), %eax
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
    jmp .Lexpand_func_macro_84
.Lexpand_func_macro_83:
    pushl $0
.Lexpand_func_macro_84:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_81
    pushl -168(%ebp)
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
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lexpand_func_macro_85:
    pushl -16(%ebp)
    pushl -152(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_86
    pushl -16(%ebp)
    pushl -168(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_88
    leal ark_str_4, %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_89
.Lexpand_func_macro_88:
.Lexpand_func_macro_89:
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    pushl -160(%ebp)
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lexpand_func_macro_87:
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
    jmp .Lexpand_func_macro_85
.Lexpand_func_macro_86:
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_81:
.Lexpand_func_macro_82:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lexpand_func_macro_90:
    pushl -24(%ebp)
    pushl -168(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_91
    leal -104(%ebp), %eax
    pushl %eax
    pushl -168(%ebp)
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
    je .Lexpand_func_macro_93
    pushl -24(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lexpand_func_macro_91
.Lexpand_func_macro_93:
.Lexpand_func_macro_94:
.Lexpand_func_macro_92:
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
    jmp .Lexpand_func_macro_90
.Lexpand_func_macro_91:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_97
    pushl -32(%ebp)
    pushl -152(%ebp)
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
    jmp .Lexpand_func_macro_98
.Lexpand_func_macro_97:
    pushl $0
.Lexpand_func_macro_98:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_95
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    pushl -160(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_96
.Lexpand_func_macro_95:
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lexpand_func_macro_99:
    pushl -16(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_100
    pushl -112(%ebp)
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
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lexpand_func_macro_101:
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
    jmp .Lexpand_func_macro_99
.Lexpand_func_macro_100:
.Lexpand_func_macro_96:
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_75:
.Lexpand_func_macro_76:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lexpand_func_macro_104
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lexpand_func_macro_105
.Lexpand_func_macro_104:
    pushl $1
.Lexpand_func_macro_105:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_102
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -112(%ebp)
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lexpand_func_macro_106:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_108
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    movzbl -112(%ebp), %eax
    pushl %eax
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
    jmp .Lexpand_func_macro_109
.Lexpand_func_macro_108:
    pushl $0
.Lexpand_func_macro_109:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_107
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_112
    pushl -120(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lexpand_func_macro_113
.Lexpand_func_macro_112:
    pushl $0
.Lexpand_func_macro_113:
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_110
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_111
.Lexpand_func_macro_110:
.Lexpand_func_macro_111:
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_106
.Lexpand_func_macro_107:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lexpand_func_macro_114
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_115
.Lexpand_func_macro_114:
.Lexpand_func_macro_115:
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_102:
.Lexpand_func_macro_103:
    pushl -120(%ebp)
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -128(%ebp)
    pushl -136(%ebp)
    pushl -144(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lexpand_func_macro_0
.Lexpand_func_macro_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_handle_if:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    call _eval_pp_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_if_0
    pushl $1
    jmp .Lhandle_if_1
.Lhandle_if_0:
    pushl $0
.Lhandle_if_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_handle_pragma_pack:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
.Lhandle_pragma_pack_0:
    pushl -40(%ebp)
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
    jne .Lhandle_pragma_pack_2
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_3
.Lhandle_pragma_pack_2:
    pushl $1
.Lhandle_pragma_pack_3:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_1
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
    jmp .Lhandle_pragma_pack_0
.Lhandle_pragma_pack_1:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_4:
.Lhandle_pragma_pack_5:
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
.Lhandle_pragma_pack_6:
    pushl -40(%ebp)
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
    jne .Lhandle_pragma_pack_8
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_9
.Lhandle_pragma_pack_8:
    pushl $1
.Lhandle_pragma_pack_9:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_7
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
    jmp .Lhandle_pragma_pack_6
.Lhandle_pragma_pack_7:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_10
    pushl $0
    call _type_set_pack
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_10:
.Lhandle_pragma_pack_11:
    pushl -40(%ebp)
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
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_18
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_19
.Lhandle_pragma_pack_18:
    pushl $0
.Lhandle_pragma_pack_19:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_16
    pushl -40(%ebp)
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
    pushl $115
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
    jmp .Lhandle_pragma_pack_17
.Lhandle_pragma_pack_16:
    pushl $0
.Lhandle_pragma_pack_17:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_14
    pushl -40(%ebp)
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
    pushl $104
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
    jmp .Lhandle_pragma_pack_15
.Lhandle_pragma_pack_14:
    pushl $0
.Lhandle_pragma_pack_15:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_12
    call _type_get_pack
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -40(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lhandle_pragma_pack_20:
    pushl -40(%ebp)
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
    jne .Lhandle_pragma_pack_22
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_23
.Lhandle_pragma_pack_22:
    pushl $1
.Lhandle_pragma_pack_23:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_21
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
    jmp .Lhandle_pragma_pack_20
.Lhandle_pragma_pack_21:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_24
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
.Lhandle_pragma_pack_26:
    pushl -40(%ebp)
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
    jne .Lhandle_pragma_pack_28
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_29
.Lhandle_pragma_pack_28:
    pushl $1
.Lhandle_pragma_pack_29:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_27
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
    jmp .Lhandle_pragma_pack_26
.Lhandle_pragma_pack_27:
    pushl -40(%ebp)
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
    je .Lhandle_pragma_pack_32
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_33
.Lhandle_pragma_pack_32:
    pushl $0
.Lhandle_pragma_pack_33:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_30
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
.Lhandle_pragma_pack_34:
    pushl -40(%ebp)
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
    je .Lhandle_pragma_pack_36
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_37
.Lhandle_pragma_pack_36:
    pushl $0
.Lhandle_pragma_pack_37:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_35
    pushl -24(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
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
    jmp .Lhandle_pragma_pack_34
.Lhandle_pragma_pack_35:
    movl _g_pack_top, %eax
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
    je .Lhandle_pragma_pack_38
    movl $_g_pack_stack, %eax
    pushl %eax
    movl _g_pack_top, %eax
    pushl %eax
    movl _g_pack_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_pack_top
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
    jmp .Lhandle_pragma_pack_39
.Lhandle_pragma_pack_38:
.Lhandle_pragma_pack_39:
    pushl -24(%ebp)
    call _type_set_pack
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_30:
.Lhandle_pragma_pack_31:
    jmp .Lhandle_pragma_pack_25
.Lhandle_pragma_pack_24:
.Lhandle_pragma_pack_25:
    movl _g_pack_top, %eax
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
    je .Lhandle_pragma_pack_40
    movl $_g_pack_stack, %eax
    pushl %eax
    movl _g_pack_top, %eax
    pushl %eax
    movl _g_pack_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_pack_top
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
    jmp .Lhandle_pragma_pack_41
.Lhandle_pragma_pack_40:
.Lhandle_pragma_pack_41:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_12:
.Lhandle_pragma_pack_13:
    pushl -40(%ebp)
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
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_46
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_47
.Lhandle_pragma_pack_46:
    pushl $0
.Lhandle_pragma_pack_47:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_44
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_45
.Lhandle_pragma_pack_44:
    pushl $0
.Lhandle_pragma_pack_45:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_42
    movl _g_pack_top, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_48
    movl $_g_pack_stack, %eax
    pushl %eax
    movl _g_pack_top, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_pack_top
    movl _g_pack_top, %eax
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    call _type_set_pack
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lhandle_pragma_pack_49
.Lhandle_pragma_pack_48:
.Lhandle_pragma_pack_49:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_42:
.Lhandle_pragma_pack_43:
    pushl -40(%ebp)
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
    je .Lhandle_pragma_pack_52
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_53
.Lhandle_pragma_pack_52:
    pushl $0
.Lhandle_pragma_pack_53:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_50
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
.Lhandle_pragma_pack_54:
    pushl -40(%ebp)
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
    je .Lhandle_pragma_pack_56
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_57
.Lhandle_pragma_pack_56:
    pushl $0
.Lhandle_pragma_pack_57:
    popl %eax
    cmpl $0, %eax
    je .Lhandle_pragma_pack_55
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    jmp .Lhandle_pragma_pack_54
.Lhandle_pragma_pack_55:
    pushl -32(%ebp)
    call _type_set_pack
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhandle_pragma_pack_50:
.Lhandle_pragma_pack_51:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_process:
    pushl %ebp
    movl %esp, %ebp
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $832, %esp
    movl 8(%ebp), %eax
    movl %eax, -16968(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16960(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -16952(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -16944(%ebp)
    pushl -16968(%ebp)
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
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
    pushl $239
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_4
    pushl -16936(%ebp)
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
    pushl $187
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
    jmp .Lprocess_5
.Lprocess_4:
    pushl $0
.Lprocess_5:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_2
    pushl -16936(%ebp)
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
    pushl $191
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
    jmp .Lprocess_3
.Lprocess_2:
    pushl $0
.Lprocess_3:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_0
    pushl -16936(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_1
.Lprocess_0:
.Lprocess_1:
    pushl $0
    popl %eax
    movl %eax, -16672(%ebp)
    pushl $1
    popl %eax
    movl %eax, -16664(%ebp)
    movl _g_cur_line, %eax
    pushl %eax
    popl %eax
    movl %eax, -16656(%ebp)
    pushl $1
    popl %eax
    movl %eax, -16648(%ebp)
.Lprocess_6:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_7
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_10
    pushl -16936(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_12
    pushl -16936(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_14
    pushl -16936(%ebp)
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
    jmp .Lprocess_15
.Lprocess_14:
    pushl $0
.Lprocess_15:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_13
.Lprocess_12:
    pushl $1
.Lprocess_13:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_11
.Lprocess_10:
    pushl $0
.Lprocess_11:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_8
    pushl -16936(%ebp)
    pushl -16936(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_16
    pushl $3
    jmp .Lprocess_17
.Lprocess_16:
    pushl $2
.Lprocess_17:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_18
    pushl $32
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_19
.Lprocess_18:
.Lprocess_19:
    jmp .Lprocess_6
.Lprocess_8:
.Lprocess_9:
    pushl -16936(%ebp)
    popl %eax
    movl %eax, -16640(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16624(%ebp)
.Lprocess_20:
    pushl -16936(%ebp)
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
    jne .Lprocess_22
    pushl -16936(%ebp)
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
    jmp .Lprocess_23
.Lprocess_22:
    pushl $1
.Lprocess_23:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_21
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_20
.Lprocess_21:
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_24
    pushl $1
    popl %eax
    movl %eax, -16624(%ebp)
    pushl -16624(%ebp)
    addl $4, %esp
    jmp .Lprocess_25
.Lprocess_24:
    pushl -16640(%ebp)
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
.Lprocess_25:
    pushl -16624(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_26
    pushl $0
    popl %eax
    movl %eax, -16600(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
.Lprocess_28:
    pushl -16632(%ebp)
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
    jne .Lprocess_30
    pushl -16632(%ebp)
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
    jmp .Lprocess_31
.Lprocess_30:
    pushl $1
.Lprocess_31:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_29
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_28
.Lprocess_29:
.Lprocess_32:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_36
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_37
.Lprocess_36:
    pushl $0
.Lprocess_37:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_34
    pushl -16600(%ebp)
    pushl $15
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
    jmp .Lprocess_35
.Lprocess_34:
    pushl $0
.Lprocess_35:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_33
    leal -16616(%ebp), %eax
    pushl %eax
    pushl -16600(%ebp)
    pushl -16600(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16600(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_32
.Lprocess_33:
    leal -16616(%ebp), %eax
    pushl %eax
    pushl -16600(%ebp)
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
.Lprocess_38:
    pushl -16632(%ebp)
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
    jne .Lprocess_40
    pushl -16632(%ebp)
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
    jmp .Lprocess_41
.Lprocess_40:
    pushl $1
.Lprocess_41:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_39
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_38
.Lprocess_39:
    leal ark_str_5, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_44
    pushl -16664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_45
.Lprocess_44:
    pushl $0
.Lprocess_45:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_42
    pushl $0
    popl %eax
    movl %eax, -16528(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16520(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16512(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16504(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16496(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16488(%ebp)
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
.Lprocess_46:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_50
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_51
.Lprocess_50:
    pushl $0
.Lprocess_51:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_48
    pushl -16528(%ebp)
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
    jmp .Lprocess_49
.Lprocess_48:
    pushl $0
.Lprocess_49:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_47
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_46
.Lprocess_47:
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16528(%ebp)
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
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_52
    pushl $1
    popl %eax
    movl %eax, -16520(%ebp)
    pushl -16520(%ebp)
    addl $4, %esp
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
.Lprocess_54:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
.Lprocess_57:
    pushl -16632(%ebp)
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
    jne .Lprocess_59
    pushl -16632(%ebp)
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
    jmp .Lprocess_60
.Lprocess_59:
    pushl $1
.Lprocess_60:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_58
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_57
.Lprocess_58:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_61
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_55
.Lprocess_61:
.Lprocess_62:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    je .Lprocess_67
    pushl -16632(%ebp)
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
    pushl $46
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
    jmp .Lprocess_68
.Lprocess_67:
    pushl $0
.Lprocess_68:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_65
    pushl -16632(%ebp)
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
    pushl $46
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
    jmp .Lprocess_66
.Lprocess_65:
    pushl $0
.Lprocess_66:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_63
    pushl -16632(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -16512(%ebp)
    pushl -16512(%ebp)
    addl $4, %esp
.Lprocess_69:
    pushl -16632(%ebp)
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
    jne .Lprocess_71
    pushl -16632(%ebp)
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
    jmp .Lprocess_72
.Lprocess_71:
    pushl $1
.Lprocess_72:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_70
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_69
.Lprocess_70:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_73
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_74
.Lprocess_73:
.Lprocess_74:
    jmp .Lprocess_55
.Lprocess_63:
.Lprocess_64:
.Lprocess_75:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_79
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_80
.Lprocess_79:
    pushl $0
.Lprocess_80:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_77
    pushl -24(%ebp)
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
    jmp .Lprocess_78
.Lprocess_77:
    pushl $0
.Lprocess_78:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_76
    leal -88(%ebp), %eax
    pushl %eax
    pushl -24(%ebp)
    pushl -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_75
.Lprocess_76:
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_81
    pushl -16496(%ebp)
    pushl -16488(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_83
    pushl -16488(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_85
    pushl -16488(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    jmp .Lprocess_86
.Lprocess_85:
    pushl $4
.Lprocess_86:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -16488(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -16504(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -16504(%ebp)
    pushl -16504(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    movl %eax, -16488(%ebp)
    pushl -16488(%ebp)
    addl $4, %esp
    jmp .Lprocess_84
.Lprocess_83:
.Lprocess_84:
    pushl -16504(%ebp)
    pushl -16496(%ebp)
    pushl -16496(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16496(%ebp)
    pushl $4
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
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lprocess_82
.Lprocess_81:
.Lprocess_82:
.Lprocess_87:
    pushl -16632(%ebp)
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
    jne .Lprocess_89
    pushl -16632(%ebp)
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
    jmp .Lprocess_90
.Lprocess_89:
    pushl $1
.Lprocess_90:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_88
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_87
.Lprocess_88:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_91
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_56
.Lprocess_91:
.Lprocess_92:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_93
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_55
.Lprocess_93:
.Lprocess_94:
    jmp .Lprocess_55
.Lprocess_56:
    jmp .Lprocess_54
.Lprocess_55:
    jmp .Lprocess_53
.Lprocess_52:
.Lprocess_53:
.Lprocess_95:
    pushl -16632(%ebp)
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
    jne .Lprocess_97
    pushl -16632(%ebp)
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
    jmp .Lprocess_98
.Lprocess_97:
    pushl $1
.Lprocess_98:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_96
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_95
.Lprocess_96:
.Lprocess_99:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_103
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_104
.Lprocess_103:
    pushl $0
.Lprocess_104:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_101
    pushl -96(%ebp)
    pushl $16383
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
    jmp .Lprocess_102
.Lprocess_101:
    pushl $0
.Lprocess_102:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_100
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_107
    pushl -16632(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_109
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_111
    pushl -16632(%ebp)
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
    jmp .Lprocess_112
.Lprocess_111:
    pushl $0
.Lprocess_112:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_110
.Lprocess_109:
    pushl $1
.Lprocess_110:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_108
.Lprocess_107:
    pushl $0
.Lprocess_108:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_105
    pushl -16632(%ebp)
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_113
    pushl $3
    jmp .Lprocess_114
.Lprocess_113:
    pushl $2
.Lprocess_114:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
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
    jmp .Lprocess_99
.Lprocess_105:
.Lprocess_106:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_117
    pushl -16632(%ebp)
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
    jmp .Lprocess_118
.Lprocess_117:
    pushl $0
.Lprocess_118:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_115
    pushl -16632(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
.Lprocess_119:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_121
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_123
    pushl -16632(%ebp)
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
    jmp .Lprocess_124
.Lprocess_123:
    pushl $0
.Lprocess_124:
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
    jmp .Lprocess_122
.Lprocess_121:
    pushl $0
.Lprocess_122:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_120
    pushl -16632(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_125
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_126
.Lprocess_125:
.Lprocess_126:
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_119
.Lprocess_120:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_129
    pushl -16632(%ebp)
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
    jmp .Lprocess_130
.Lprocess_129:
    pushl $0
.Lprocess_130:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_127
    pushl -16632(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_128
.Lprocess_127:
.Lprocess_128:
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
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
    jmp .Lprocess_99
.Lprocess_115:
.Lprocess_116:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_133
    pushl -16632(%ebp)
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
    jmp .Lprocess_134
.Lprocess_133:
    pushl $0
.Lprocess_134:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_131
    jmp .Lprocess_100
.Lprocess_131:
.Lprocess_132:
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_99
.Lprocess_100:
.Lprocess_135:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_136
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_139
    pushl -16632(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_141
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_143
    pushl -16632(%ebp)
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
    jmp .Lprocess_144
.Lprocess_143:
    pushl $0
.Lprocess_144:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_142
.Lprocess_141:
    pushl $1
.Lprocess_142:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_140
.Lprocess_139:
    pushl $0
.Lprocess_140:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_137
    pushl -16632(%ebp)
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_145
    pushl $3
    jmp .Lprocess_146
.Lprocess_145:
    pushl $2
.Lprocess_146:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_135
.Lprocess_137:
.Lprocess_138:
    pushl -16632(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_147
    jmp .Lprocess_136
.Lprocess_147:
.Lprocess_148:
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_135
.Lprocess_136:
.Lprocess_149:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_151
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
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
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_155
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
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
    jmp .Lprocess_156
.Lprocess_155:
    pushl $1
.Lprocess_156:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_153
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
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
    jmp .Lprocess_154
.Lprocess_153:
    pushl $1
.Lprocess_154:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_152
.Lprocess_151:
    pushl $0
.Lprocess_152:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_150
    pushl -96(%ebp)
    pushl -96(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    addl $4, %esp
    jmp .Lprocess_149
.Lprocess_150:
    leal -16480(%ebp), %eax
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
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_157
    pushl -16520(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_159
    leal -16480(%ebp), %eax
    pushl %eax
    pushl -16512(%ebp)
    pushl -16496(%ebp)
    pushl -16504(%ebp)
    leal -16592(%ebp), %eax
    pushl %eax
    call _add_func_macro
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_160
.Lprocess_159:
    leal -16480(%ebp), %eax
    pushl %eax
    leal -16592(%ebp), %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_160:
    jmp .Lprocess_158
.Lprocess_157:
.Lprocess_158:
    jmp .Lprocess_43
.Lprocess_42:
    leal ark_str_6, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_163
    pushl -16664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_164
.Lprocess_163:
    pushl $0
.Lprocess_164:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_161
    pushl $0
    popl %eax
    movl %eax, -16528(%ebp)
.Lprocess_165:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_169
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_170
.Lprocess_169:
    pushl $0
.Lprocess_170:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_167
    pushl -16528(%ebp)
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
    jmp .Lprocess_168
.Lprocess_167:
    pushl $0
.Lprocess_168:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_166
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_165
.Lprocess_166:
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16528(%ebp)
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
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_171
    leal -16592(%ebp), %eax
    pushl %eax
    call _remove_macro
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_172
.Lprocess_171:
.Lprocess_172:
    jmp .Lprocess_162
.Lprocess_161:
    leal ark_str_7, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_175
    pushl -16664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_176
.Lprocess_175:
    pushl $0
.Lprocess_176:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_173
    pushl $0
    popl %eax
    movl %eax, -16336(%ebp)
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_179
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $60
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
    jmp .Lprocess_180
.Lprocess_179:
    pushl $0
.Lprocess_180:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_177
    jmp .Lprocess_178
.Lprocess_177:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_181
    pushl $62
    jmp .Lprocess_182
.Lprocess_181:
    pushl $34
.Lprocess_182:
    popl %eax
    movb %al, -16328(%ebp)
    pushl -16328(%ebp)
    addl $4, %esp
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
.Lprocess_183:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_187
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    movzbl -16328(%ebp), %eax
    pushl %eax
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
    jmp .Lprocess_188
.Lprocess_187:
    pushl $0
.Lprocess_188:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_185
    pushl -16336(%ebp)
    pushl $255
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
    jmp .Lprocess_186
.Lprocess_185:
    pushl $0
.Lprocess_186:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_184
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
    pushl -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_183
.Lprocess_184:
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
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
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    movzbl -16328(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_189
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_190
.Lprocess_189:
.Lprocess_190:
    movl _g_inc_depth, %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_191
    leal -16592(%ebp), %eax
    pushl %eax
    leal ark_str_8, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_192
.Lprocess_191:
    movl $_g_inc_bufs, %eax
    pushl %eax
    movl _g_inc_depth, %eax
    pushl %eax
    pushl $1048576
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16320(%ebp)
    pushl $1048576
    pushl -16320(%ebp)
    leal -16592(%ebp), %eax
    pushl %eax
    call _read_include
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -16312(%ebp)
    pushl -16312(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_193
    leal -16592(%ebp), %eax
    pushl %eax
    leal ark_str_9, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_194
.Lprocess_193:
    movl _g_inc_file_count, %eax
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
    je .Lprocess_195
    movl $_g_inc_files, %eax
    pushl %eax
    movl _g_inc_file_count, %eax
    pushl %eax
    movl _g_inc_file_count, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_file_count
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -16592(%ebp), %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lprocess_196
.Lprocess_195:
.Lprocess_196:
    movl _g_inc_depth, %eax
    pushl %eax
    movl _g_inc_depth, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_depth
    addl $4, %esp
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    pushl -16320(%ebp)
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl _g_inc_depth, %eax
    pushl %eax
    movl _g_inc_depth, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_inc_depth
    addl $4, %esp
.Lprocess_194:
.Lprocess_192:
.Lprocess_178:
    jmp .Lprocess_174
.Lprocess_173:
    leal ark_str_10, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_197
    pushl $0
    popl %eax
    movl %eax, -16592(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16072(%ebp)
.Lprocess_199:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_203
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_204
.Lprocess_203:
    pushl $0
.Lprocess_204:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_201
    pushl -16072(%ebp)
    pushl $511
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
    jmp .Lprocess_202
.Lprocess_201:
    pushl $0
.Lprocess_202:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_200
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_207
    pushl -16632(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_209
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_211
    pushl -16632(%ebp)
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
    jmp .Lprocess_212
.Lprocess_211:
    pushl $0
.Lprocess_212:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_210
.Lprocess_209:
    pushl $1
.Lprocess_210:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_208
.Lprocess_207:
    pushl $0
.Lprocess_208:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_205
    pushl -16632(%ebp)
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_213
    pushl $3
    jmp .Lprocess_214
.Lprocess_213:
    pushl $2
.Lprocess_214:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
    pushl -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16072(%ebp)
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
    jmp .Lprocess_199
.Lprocess_205:
.Lprocess_206:
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
    pushl -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_199
.Lprocess_200:
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
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
    pushl -16672(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_215
    leal -16928(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16664(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_217
    leal -16584(%ebp), %eax
    pushl %eax
    call _handle_if
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16592(%ebp)
    pushl -16592(%ebp)
    addl $4, %esp
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16592(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16592(%ebp)
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_218
.Lprocess_217:
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
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
.Lprocess_218:
    pushl -16672(%ebp)
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16672(%ebp)
    addl $4, %esp
    jmp .Lprocess_216
.Lprocess_215:
.Lprocess_216:
    jmp .Lprocess_198
.Lprocess_197:
    leal ark_str_11, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_221
    leal ark_str_12, %eax
    pushl %eax
    leal -16616(%ebp), %eax
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
    jmp .Lprocess_222
.Lprocess_221:
    pushl $1
.Lprocess_222:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_219
    leal ark_str_13, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16592(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16520(%ebp)
.Lprocess_223:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_227
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_228
.Lprocess_227:
    pushl $0
.Lprocess_228:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_225
    pushl -16520(%ebp)
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
    jmp .Lprocess_226
.Lprocess_225:
    pushl $0
.Lprocess_226:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_224
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16520(%ebp)
    pushl -16520(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16520(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_223
.Lprocess_224:
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16520(%ebp)
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
    pushl -16672(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_229
    leal -16928(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16664(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_231
    leal -16584(%ebp), %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_233
    pushl $1
    jmp .Lprocess_234
.Lprocess_233:
    pushl $0
.Lprocess_234:
    popl %eax
    movl %eax, -16512(%ebp)
    pushl -16592(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_235
    pushl -16512(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_236
.Lprocess_235:
    pushl -16512(%ebp)
.Lprocess_236:
    popl %eax
    movl %eax, -16504(%ebp)
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16504(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16504(%ebp)
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_232
.Lprocess_231:
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
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
.Lprocess_232:
    pushl -16672(%ebp)
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16672(%ebp)
    addl $4, %esp
    jmp .Lprocess_230
.Lprocess_229:
.Lprocess_230:
    jmp .Lprocess_220
.Lprocess_219:
    leal ark_str_14, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_237
    pushl -16672(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_239
    leal -16928(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    movl %eax, -16592(%ebp)
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    cmpl $0, %eax
    je .Lprocess_241
    pushl $0
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_242
.Lprocess_241:
    pushl -16592(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_243
    pushl $0
    popl %eax
    movl %eax, -16072(%ebp)
.Lprocess_245:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_249
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_250
.Lprocess_249:
    pushl $0
.Lprocess_250:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_247
    pushl -16072(%ebp)
    pushl $511
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
    jmp .Lprocess_248
.Lprocess_247:
    pushl $0
.Lprocess_248:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_246
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_253
    pushl -16632(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_255
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_257
    pushl -16632(%ebp)
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
    jmp .Lprocess_258
.Lprocess_257:
    pushl $0
.Lprocess_258:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_256
.Lprocess_255:
    pushl $1
.Lprocess_256:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_254
.Lprocess_253:
    pushl $0
.Lprocess_254:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_251
    pushl -16632(%ebp)
    pushl -16632(%ebp)
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
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_259
    pushl $3
    jmp .Lprocess_260
.Lprocess_259:
    pushl $2
.Lprocess_260:
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
    pushl -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16072(%ebp)
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
    jmp .Lprocess_245
.Lprocess_251:
.Lprocess_252:
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
    pushl -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_245
.Lprocess_246:
    leal -16584(%ebp), %eax
    pushl %eax
    pushl -16072(%ebp)
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
    leal -16584(%ebp), %eax
    pushl %eax
    call _handle_if
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16064(%ebp)
    pushl -16064(%ebp)
    addl $4, %esp
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    pushl -16064(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16064(%ebp)
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_244
.Lprocess_243:
    pushl $0
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
.Lprocess_244:
.Lprocess_242:
    jmp .Lprocess_240
.Lprocess_239:
.Lprocess_240:
    jmp .Lprocess_238
.Lprocess_237:
    leal ark_str_15, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_261
    pushl -16672(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_263
    leal -16928(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    movl %eax, -16592(%ebp)
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    cmpl $0, %eax
    je .Lprocess_265
    pushl $0
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_266
.Lprocess_265:
    pushl -16592(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_267
    leal -16800(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    pushl $1
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_268
.Lprocess_267:
    pushl $0
    popl %eax
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
.Lprocess_268:
.Lprocess_266:
    jmp .Lprocess_264
.Lprocess_263:
.Lprocess_264:
    jmp .Lprocess_262
.Lprocess_261:
    leal ark_str_16, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_269
    pushl -16672(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_271
    pushl -16672(%ebp)
    pushl -16672(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16672(%ebp)
    addl $4, %esp
    leal -16928(%ebp), %eax
    pushl %eax
    pushl -16672(%ebp)
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
    movl %eax, -16664(%ebp)
    pushl -16664(%ebp)
    addl $4, %esp
    jmp .Lprocess_272
.Lprocess_271:
.Lprocess_272:
    jmp .Lprocess_270
.Lprocess_269:
    leal ark_str_17, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_275
    pushl -16664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_276
.Lprocess_275:
    pushl $0
.Lprocess_276:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_273
    pushl $0
    popl %eax
    movl %eax, -16336(%ebp)
.Lprocess_277:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_281
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_282
.Lprocess_281:
    pushl $0
.Lprocess_282:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_279
    pushl -16336(%ebp)
    pushl $255
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
    jmp .Lprocess_280
.Lprocess_279:
    pushl $0
.Lprocess_280:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_278
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
    pushl -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_277
.Lprocess_278:
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
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
    leal -16592(%ebp), %eax
    pushl %eax
    leal ark_str_18, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_274
.Lprocess_273:
    leal ark_str_19, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_285
    pushl -16664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_286
.Lprocess_285:
    pushl $0
.Lprocess_286:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_283
    pushl $0
    popl %eax
    movl %eax, -16336(%ebp)
.Lprocess_287:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_291
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_292
.Lprocess_291:
    pushl $0
.Lprocess_292:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_289
    pushl -16336(%ebp)
    pushl $255
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
    jmp .Lprocess_290
.Lprocess_289:
    pushl $0
.Lprocess_290:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_288
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
    pushl -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16336(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
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
    jmp .Lprocess_287
.Lprocess_288:
    leal -16592(%ebp), %eax
    pushl %eax
    pushl -16336(%ebp)
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
    leal -16592(%ebp), %eax
    pushl %eax
    leal ark_str_20, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_284
.Lprocess_283:
    leal ark_str_21, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_293
    pushl -16632(%ebp)
    popl %eax
    movl %eax, -16592(%ebp)
    pushl -16592(%ebp)
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
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_303
    pushl -16592(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_304
.Lprocess_303:
    pushl $0
.Lprocess_304:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_301
    pushl -16592(%ebp)
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
    pushl $99
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
    jmp .Lprocess_302
.Lprocess_301:
    pushl $0
.Lprocess_302:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_299
    pushl -16592(%ebp)
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
    pushl $107
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
    jmp .Lprocess_300
.Lprocess_299:
    pushl $0
.Lprocess_300:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_297
    pushl -16592(%ebp)
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
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_307
    pushl -16592(%ebp)
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
    pushl $32
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
    jmp .Lprocess_308
.Lprocess_307:
    pushl $1
.Lprocess_308:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_305
    pushl -16592(%ebp)
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
    jmp .Lprocess_306
.Lprocess_305:
    pushl $1
.Lprocess_306:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_298
.Lprocess_297:
    pushl $0
.Lprocess_298:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_295
    pushl -16592(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _handle_pragma_pack
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_296
.Lprocess_295:
    pushl -16592(%ebp)
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
    pushl $108
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_323
    pushl -16592(%ebp)
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
    jmp .Lprocess_324
.Lprocess_323:
    pushl $0
.Lprocess_324:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_321
    pushl -16592(%ebp)
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
    pushl $99
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
    jmp .Lprocess_322
.Lprocess_321:
    pushl $0
.Lprocess_322:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_319
    pushl -16592(%ebp)
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
    pushl $97
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
    jmp .Lprocess_320
.Lprocess_319:
    pushl $0
.Lprocess_320:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_317
    pushl -16592(%ebp)
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
    pushl $116
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
    jmp .Lprocess_318
.Lprocess_317:
    pushl $0
.Lprocess_318:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_315
    pushl -16592(%ebp)
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
    pushl $105
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
    jmp .Lprocess_316
.Lprocess_315:
    pushl $0
.Lprocess_316:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_313
    pushl -16592(%ebp)
    pushl $6
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
    jmp .Lprocess_314
.Lprocess_313:
    pushl $0
.Lprocess_314:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_311
    pushl -16592(%ebp)
    pushl $7
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_312
.Lprocess_311:
    pushl $0
.Lprocess_312:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_309
    pushl -16592(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16584(%ebp)
.Lprocess_325:
    pushl -16584(%ebp)
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
    jne .Lprocess_329
    pushl -16584(%ebp)
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
    jmp .Lprocess_330
.Lprocess_329:
    pushl $1
.Lprocess_330:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_327
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $61
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
    jmp .Lprocess_328
.Lprocess_327:
    pushl $1
.Lprocess_328:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_326
    pushl -16584(%ebp)
    pushl -16584(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16584(%ebp)
    addl $4, %esp
    jmp .Lprocess_325
.Lprocess_326:
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_331
    pushl $0
    popl %eax
    movl %eax, -16576(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16568(%ebp)
    pushl -16584(%ebp)
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
    je .Lprocess_335
    pushl -16584(%ebp)
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
    pushl $120
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_337
    pushl -16584(%ebp)
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
    pushl $88
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
    jmp .Lprocess_338
.Lprocess_337:
    pushl $1
.Lprocess_338:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_336
.Lprocess_335:
    pushl $0
.Lprocess_336:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_333
    pushl -16584(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16584(%ebp)
    pushl -16584(%ebp)
    addl $4, %esp
.Lprocess_339:
    pushl -16584(%ebp)
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
    je .Lprocess_345
    pushl -16584(%ebp)
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
    jmp .Lprocess_346
.Lprocess_345:
    pushl $0
.Lprocess_346:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_343
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_347
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
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
    jmp .Lprocess_348
.Lprocess_347:
    pushl $0
.Lprocess_348:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_344
.Lprocess_343:
    pushl $1
.Lprocess_344:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_341
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_349
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
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
    jmp .Lprocess_350
.Lprocess_349:
    pushl $0
.Lprocess_350:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_342
.Lprocess_341:
    pushl $1
.Lprocess_342:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_340
    pushl -16584(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_351
    pushl -16584(%ebp)
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
    popl %eax
    movl %eax, -16560(%ebp)
    pushl -16560(%ebp)
    addl $4, %esp
    jmp .Lprocess_352
.Lprocess_351:
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $70
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_353
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16560(%ebp)
    pushl -16560(%ebp)
    addl $4, %esp
    jmp .Lprocess_354
.Lprocess_353:
    pushl -16584(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16560(%ebp)
    pushl -16560(%ebp)
    addl $4, %esp
.Lprocess_354:
.Lprocess_352:
    pushl -16576(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -16560(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16576(%ebp)
    pushl -16576(%ebp)
    addl $4, %esp
    pushl -16584(%ebp)
    pushl -16584(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16584(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -16568(%ebp)
    pushl -16568(%ebp)
    addl $4, %esp
    jmp .Lprocess_339
.Lprocess_340:
    jmp .Lprocess_334
.Lprocess_333:
.Lprocess_355:
    pushl -16584(%ebp)
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
    je .Lprocess_357
    pushl -16584(%ebp)
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
    jmp .Lprocess_358
.Lprocess_357:
    pushl $0
.Lprocess_358:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_356
    pushl -16576(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -16584(%ebp)
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
    movl %eax, -16576(%ebp)
    pushl -16576(%ebp)
    addl $4, %esp
    pushl -16584(%ebp)
    pushl -16584(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16584(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -16568(%ebp)
    pushl -16568(%ebp)
    addl $4, %esp
    jmp .Lprocess_355
.Lprocess_356:
.Lprocess_334:
    pushl -16568(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_359
    leal ark_str_22, %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16576(%ebp)
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _emit_int
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_23, %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_360
.Lprocess_359:
.Lprocess_360:
    jmp .Lprocess_332
.Lprocess_331:
.Lprocess_332:
    jmp .Lprocess_310
.Lprocess_309:
    pushl -16592(%ebp)
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
    pushl $100
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_369
    pushl -16592(%ebp)
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
    pushl $105
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
    jmp .Lprocess_370
.Lprocess_369:
    pushl $0
.Lprocess_370:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_367
    pushl -16592(%ebp)
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
    pushl $97
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
    jmp .Lprocess_368
.Lprocess_367:
    pushl $0
.Lprocess_368:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_365
    pushl -16592(%ebp)
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
    pushl $103
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
    jmp .Lprocess_366
.Lprocess_365:
    pushl $0
.Lprocess_366:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_363
    pushl -16592(%ebp)
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
    jmp .Lprocess_364
.Lprocess_363:
    pushl $0
.Lprocess_364:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_361
    jmp .Lprocess_362
.Lprocess_361:
    leal ark_str_24, %eax
    pushl %eax
    pushl -16592(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_373
    leal ark_str_25, %eax
    pushl %eax
    pushl -16592(%ebp)
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
    jmp .Lprocess_374
.Lprocess_373:
    pushl $1
.Lprocess_374:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_371
    jmp .Lprocess_372
.Lprocess_371:
    pushl -16592(%ebp)
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
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_385
    pushl -16592(%ebp)
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
    pushl $109
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
    jmp .Lprocess_386
.Lprocess_385:
    pushl $0
.Lprocess_386:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_383
    pushl -16592(%ebp)
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
    jmp .Lprocess_384
.Lprocess_383:
    pushl $0
.Lprocess_384:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_381
    pushl -16592(%ebp)
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
    jmp .Lprocess_382
.Lprocess_381:
    pushl $0
.Lprocess_382:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_379
    pushl -16592(%ebp)
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
    jmp .Lprocess_380
.Lprocess_379:
    pushl $0
.Lprocess_380:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_377
    pushl -16592(%ebp)
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
    pushl $116
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
    jmp .Lprocess_378
.Lprocess_377:
    pushl $0
.Lprocess_378:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_375
    jmp .Lprocess_376
.Lprocess_375:
    leal ark_str_26, %eax
    pushl %eax
    pushl -16592(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_389
    leal ark_str_27, %eax
    pushl %eax
    pushl -16592(%ebp)
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
    jmp .Lprocess_390
.Lprocess_389:
    pushl $1
.Lprocess_390:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_387
    jmp .Lprocess_388
.Lprocess_387:
    pushl -16592(%ebp)
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
    pushl $79
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_397
    pushl -16592(%ebp)
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
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_401
    pushl -16592(%ebp)
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
    pushl $32
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
    jmp .Lprocess_402
.Lprocess_401:
    pushl $1
.Lprocess_402:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_399
    pushl -16592(%ebp)
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
    jmp .Lprocess_400
.Lprocess_399:
    pushl $1
.Lprocess_400:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_398
.Lprocess_397:
    pushl $0
.Lprocess_398:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_395
    pushl -16592(%ebp)
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
    pushl $79
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_403
    pushl -16592(%ebp)
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
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_405
    pushl -16592(%ebp)
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
    pushl $116
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
    jmp .Lprocess_406
.Lprocess_405:
    pushl $1
.Lprocess_406:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_404
.Lprocess_403:
    pushl $0
.Lprocess_404:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_396
.Lprocess_395:
    pushl $1
.Lprocess_396:
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_393
    pushl -16592(%ebp)
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
    pushl $111
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_419
    pushl -16592(%ebp)
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
    jmp .Lprocess_420
.Lprocess_419:
    pushl $0
.Lprocess_420:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_417
    pushl -16592(%ebp)
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
    pushl $116
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
    jmp .Lprocess_418
.Lprocess_417:
    pushl $0
.Lprocess_418:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_415
    pushl -16592(%ebp)
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
    pushl $105
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
    jmp .Lprocess_416
.Lprocess_415:
    pushl $0
.Lprocess_416:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_413
    pushl -16592(%ebp)
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
    pushl $109
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
    jmp .Lprocess_414
.Lprocess_413:
    pushl $0
.Lprocess_414:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_411
    pushl -16592(%ebp)
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
    pushl $105
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
    jmp .Lprocess_412
.Lprocess_411:
    pushl $0
.Lprocess_412:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_409
    pushl -16592(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $122
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
    jmp .Lprocess_410
.Lprocess_409:
    pushl $0
.Lprocess_410:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_407
    pushl -16592(%ebp)
    pushl $7
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_408
.Lprocess_407:
    pushl $0
.Lprocess_408:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_394
.Lprocess_393:
    pushl $1
.Lprocess_394:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_391
    jmp .Lprocess_392
.Lprocess_391:
.Lprocess_392:
.Lprocess_388:
.Lprocess_376:
.Lprocess_372:
.Lprocess_362:
.Lprocess_310:
.Lprocess_296:
    jmp .Lprocess_294
.Lprocess_293:
    leal ark_str_28, %eax
    pushl %eax
    leal -16616(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_421
    jmp .Lprocess_422
.Lprocess_421:
.Lprocess_422:
.Lprocess_294:
.Lprocess_284:
.Lprocess_274:
.Lprocess_270:
.Lprocess_262:
.Lprocess_238:
.Lprocess_220:
.Lprocess_198:
.Lprocess_174:
.Lprocess_162:
.Lprocess_43:
.Lprocess_423:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_424
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_427
    pushl -16632(%ebp)
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
    jmp .Lprocess_428
.Lprocess_427:
    pushl $0
.Lprocess_428:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_425
    pushl -16632(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
.Lprocess_429:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_431
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_433
    pushl -16632(%ebp)
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
    jmp .Lprocess_434
.Lprocess_433:
    pushl $0
.Lprocess_434:
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
    jmp .Lprocess_432
.Lprocess_431:
    pushl $0
.Lprocess_432:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_430
    pushl -16632(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_435
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_436
.Lprocess_435:
.Lprocess_436:
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_429
.Lprocess_430:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_437
    pushl -16632(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    pushl -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_438
.Lprocess_437:
.Lprocess_438:
    jmp .Lprocess_426
.Lprocess_425:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_441
    pushl -16632(%ebp)
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
    jmp .Lprocess_442
.Lprocess_441:
    pushl $0
.Lprocess_442:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_439
.Lprocess_443:
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_445
    pushl -16632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_446
.Lprocess_445:
    pushl $0
.Lprocess_446:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_444
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    jmp .Lprocess_443
.Lprocess_444:
    jmp .Lprocess_424
.Lprocess_439:
    pushl -16632(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_447
    jmp .Lprocess_424
.Lprocess_447:
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
.Lprocess_448:
.Lprocess_440:
.Lprocess_426:
    jmp .Lprocess_423
.Lprocess_424:
    pushl -16632(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_449
    pushl -16632(%ebp)
    pushl -16632(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16632(%ebp)
    addl $4, %esp
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_450
.Lprocess_449:
.Lprocess_450:
    pushl -16632(%ebp)
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    pushl $10
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_26:
.Lprocess_27:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lprocess_453
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_454
.Lprocess_453:
    pushl $1
.Lprocess_454:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_451
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -16616(%ebp)
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_455
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_456
.Lprocess_455:
.Lprocess_456:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
.Lprocess_457:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_459
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    movzbl -16616(%ebp), %eax
    pushl %eax
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
    jmp .Lprocess_460
.Lprocess_459:
    pushl $0
.Lprocess_460:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_458
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_463
    pushl -16936(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_464
.Lprocess_463:
    pushl $0
.Lprocess_464:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_461
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_465
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_466
.Lprocess_465:
.Lprocess_466:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_462
.Lprocess_461:
.Lprocess_462:
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_467
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_468
.Lprocess_467:
.Lprocess_468:
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_469
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_470
.Lprocess_469:
.Lprocess_470:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_457
.Lprocess_458:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_471
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_473
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_474
.Lprocess_473:
.Lprocess_474:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_472
.Lprocess_471:
.Lprocess_472:
    jmp .Lprocess_6
.Lprocess_451:
.Lprocess_452:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_477
    pushl -16936(%ebp)
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
    jmp .Lprocess_478
.Lprocess_477:
    pushl $0
.Lprocess_478:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_475
.Lprocess_479:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_481
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Lprocess_482
.Lprocess_481:
    pushl $0
.Lprocess_482:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_480
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_483
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_484
.Lprocess_483:
.Lprocess_484:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_479
.Lprocess_480:
    jmp .Lprocess_6
.Lprocess_475:
.Lprocess_476:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_487
    pushl -16936(%ebp)
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
    jmp .Lprocess_488
.Lprocess_487:
    pushl $0
.Lprocess_488:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_485
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_489
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_490
.Lprocess_489:
.Lprocess_490:
    pushl -16936(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
.Lprocess_491:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_493
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_495
    pushl -16936(%ebp)
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
    jmp .Lprocess_496
.Lprocess_495:
    pushl $0
.Lprocess_496:
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
    jmp .Lprocess_494
.Lprocess_493:
    pushl $0
.Lprocess_494:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_492
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_497
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_498
.Lprocess_497:
.Lprocess_498:
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_499
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_500
.Lprocess_499:
.Lprocess_500:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_491
.Lprocess_492:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_501
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_503
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_504
.Lprocess_503:
.Lprocess_504:
    pushl -16936(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_502
.Lprocess_501:
.Lprocess_502:
    jmp .Lprocess_6
.Lprocess_485:
.Lprocess_486:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_505
    pushl -16936(%ebp)
    popl %eax
    movl %eax, -16616(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16544(%ebp)
.Lprocess_507:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_509
    pushl -16544(%ebp)
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
    jmp .Lprocess_510
.Lprocess_509:
    pushl $0
.Lprocess_510:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_508
    leal -16608(%ebp), %eax
    pushl %eax
    pushl -16544(%ebp)
    pushl -16544(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16544(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
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
    jmp .Lprocess_507
.Lprocess_508:
    leal -16608(%ebp), %eax
    pushl %eax
    pushl -16544(%ebp)
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
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_511
    jmp .Lprocess_6
.Lprocess_511:
.Lprocess_512:
    leal ark_str_29, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_513
    pushl -16936(%ebp)
    popl %eax
    movl %eax, -16528(%ebp)
.Lprocess_515:
    pushl -16528(%ebp)
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
    jne .Lprocess_517
    pushl -16528(%ebp)
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
    jmp .Lprocess_518
.Lprocess_517:
    pushl $1
.Lprocess_518:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_516
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_515
.Lprocess_516:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_519
    pushl $1
    popl %eax
    movl %eax, -16520(%ebp)
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
.Lprocess_521:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_523
    pushl -16520(%ebp)
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
    jmp .Lprocess_524
.Lprocess_523:
    pushl $0
.Lprocess_524:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_522
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_525
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
.Lprocess_527:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_529
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
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
    jmp .Lprocess_530
.Lprocess_529:
    pushl $0
.Lprocess_530:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_528
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_533
    pushl -16528(%ebp)
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
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_534
.Lprocess_533:
    pushl $0
.Lprocess_534:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_531
    pushl -16528(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    pushl -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_532
.Lprocess_531:
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
.Lprocess_532:
    jmp .Lprocess_527
.Lprocess_528:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_535
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_536
.Lprocess_535:
.Lprocess_536:
    jmp .Lprocess_526
.Lprocess_525:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_537
    pushl -16520(%ebp)
    pushl -16520(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16520(%ebp)
    addl $4, %esp
    jmp .Lprocess_538
.Lprocess_537:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_539
    pushl -16520(%ebp)
    pushl -16520(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16520(%ebp)
    addl $4, %esp
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_541
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_522
.Lprocess_541:
.Lprocess_542:
    jmp .Lprocess_540
.Lprocess_539:
.Lprocess_540:
.Lprocess_538:
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_543
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_544
.Lprocess_543:
.Lprocess_544:
.Lprocess_526:
    jmp .Lprocess_521
.Lprocess_522:
    pushl -16528(%ebp)
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_520
.Lprocess_519:
.Lprocess_520:
    jmp .Lprocess_6
.Lprocess_513:
.Lprocess_514:
    leal ark_str_30, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_545
    pushl $0
    popl %eax
    movl %eax, -16528(%ebp)
    pushl -16528(%ebp)
    addl $4, %esp
.Lprocess_547:
    pushl -16528(%ebp)
    pushl -16544(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_548
    pushl -16616(%ebp)
    pushl -16528(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_549:
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_547
.Lprocess_548:
    pushl -16936(%ebp)
    popl %eax
    movl %eax, -16520(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16512(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16504(%ebp)
.Lprocess_550:
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_558
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
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
    jmp .Lprocess_559
.Lprocess_558:
    pushl $0
.Lprocess_559:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_556
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
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
    jmp .Lprocess_557
.Lprocess_556:
    pushl $0
.Lprocess_557:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_554
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
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
    jmp .Lprocess_555
.Lprocess_554:
    pushl $0
.Lprocess_555:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_552
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
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
    jmp .Lprocess_553
.Lprocess_552:
    pushl $0
.Lprocess_553:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_551
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_560
    pushl $1
    popl %eax
    movl %eax, -16512(%ebp)
    pushl -16512(%ebp)
    addl $4, %esp
    jmp .Lprocess_561
.Lprocess_560:
.Lprocess_561:
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_562
    pushl $1
    popl %eax
    movl %eax, -16504(%ebp)
    pushl -16504(%ebp)
    addl $4, %esp
    jmp .Lprocess_563
.Lprocess_562:
.Lprocess_563:
    pushl -16520(%ebp)
    pushl -16520(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16520(%ebp)
    addl $4, %esp
    jmp .Lprocess_550
.Lprocess_551:
    pushl -16520(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_568
    pushl -16512(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_569
.Lprocess_568:
    pushl $0
.Lprocess_569:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_566
    pushl -16504(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_567
.Lprocess_566:
    pushl $0
.Lprocess_567:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_564
.Lprocess_570:
    pushl -16936(%ebp)
    pushl -16520(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_571
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_572
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_573
.Lprocess_572:
.Lprocess_573:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_570
.Lprocess_571:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -16496(%ebp)
.Lprocess_574:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_576
    pushl -16496(%ebp)
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
    jmp .Lprocess_577
.Lprocess_576:
    pushl $0
.Lprocess_577:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_575
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_578
    pushl -16496(%ebp)
    pushl -16496(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16496(%ebp)
    addl $4, %esp
    jmp .Lprocess_579
.Lprocess_578:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_580
    pushl -16496(%ebp)
    pushl -16496(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16496(%ebp)
    addl $4, %esp
    pushl -16496(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_582
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_575
.Lprocess_582:
.Lprocess_583:
    jmp .Lprocess_581
.Lprocess_580:
.Lprocess_581:
.Lprocess_579:
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_584
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_585
.Lprocess_584:
.Lprocess_585:
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_574
.Lprocess_575:
    jmp .Lprocess_6
.Lprocess_564:
.Lprocess_565:
    jmp .Lprocess_6
.Lprocess_545:
.Lprocess_546:
    leal ark_str_31, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_586
    pushl -16648(%ebp)
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _emit_int
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_586:
.Lprocess_587:
    leal ark_str_32, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_588
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_main_file, %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_588:
.Lprocess_589:
    leal ark_str_33, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_590
    pushl $49
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_590:
.Lprocess_591:
    leal ark_str_34, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_592
    pushl $49
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_592:
.Lprocess_593:
    leal ark_str_35, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_594
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_build_date, %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_594:
.Lprocess_595:
    leal ark_str_36, %eax
    pushl %eax
    leal -16608(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_596
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl $_g_build_time, %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $34
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_596:
.Lprocess_597:
    leal -16608(%ebp), %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16536(%ebp)
    pushl -16536(%ebp)
    addl $4, %esp
    pushl -16536(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_600
    leal -16608(%ebp), %eax
    pushl %eax
    call _is_blue_painted
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lprocess_601
.Lprocess_600:
    pushl $0
.Lprocess_601:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_598
    pushl $0
    popl %eax
    movl %eax, -16536(%ebp)
    pushl -16536(%ebp)
    addl $4, %esp
    jmp .Lprocess_599
.Lprocess_598:
.Lprocess_599:
    pushl -16536(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_602
    pushl -16536(%ebp)
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
    je .Lprocess_604
    pushl -16936(%ebp)
    popl %eax
    movl %eax, -16528(%ebp)
.Lprocess_606:
    pushl -16528(%ebp)
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
    jne .Lprocess_608
    pushl -16528(%ebp)
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
    jmp .Lprocess_609
.Lprocess_608:
    pushl $1
.Lprocess_609:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_607
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_606
.Lprocess_607:
    pushl -16528(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_610
    pushl $0
    popl %eax
    movl %eax, -16520(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16516(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16512(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16508(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16504(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16500(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16496(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16492(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16488(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16484(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16480(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16476(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16472(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16468(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16464(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16460(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16520(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16456(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $16
    leal -16456(%ebp), %eax
    pushl %eax
    leal -16520(%ebp), %eax
    pushl %eax
    pushl -16528(%ebp)
    call _parse_macro_args
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    pushl -16528(%ebp)
    addl $4, %esp
    pushl $16383
    leal -64(%ebp), %eax
    pushl %eax
    leal -16448(%ebp), %eax
    pushl %eax
    pushl -16456(%ebp)
    leal -16520(%ebp), %eax
    pushl %eax
    pushl -16536(%ebp)
    call _expand_func_macro
    addl $24, %esp
    pushl %eax
    addl $4, %esp
    leal -16448(%ebp), %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl _g_macro_depth, %eax
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
    je .Lprocess_612
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    movl _g_blue_top, %eax
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
    je .Lprocess_614
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
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
    pushl -16536(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
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
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    movl _g_blue_top, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_blue_top
    addl $4, %esp
    jmp .Lprocess_615
.Lprocess_614:
.Lprocess_615:
    movl _g_macro_depth, %eax
    pushl %eax
    movl _g_macro_depth, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_depth
    addl $4, %esp
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    leal -16448(%ebp), %eax
    pushl %eax
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl _g_macro_depth, %eax
    pushl %eax
    movl _g_macro_depth, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_depth
    addl $4, %esp
    movl _g_blue_top, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_618
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    pushl -56(%ebp)
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
    jmp .Lprocess_619
.Lprocess_618:
    pushl $0
.Lprocess_619:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_616
    movl _g_blue_top, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_blue_top
    addl $4, %esp
    jmp .Lprocess_617
.Lprocess_616:
.Lprocess_617:
    jmp .Lprocess_613
.Lprocess_612:
    leal -16448(%ebp), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_613:
    pushl -16528(%ebp)
    popl %eax
    movl %eax, -16936(%ebp)
    pushl -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_610:
    pushl $0
    popl %eax
    movl %eax, -16520(%ebp)
    pushl -16520(%ebp)
    addl $4, %esp
.Lprocess_620:
    pushl -16520(%ebp)
    pushl -16544(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_621
    pushl -16616(%ebp)
    pushl -16520(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_622:
    pushl -16520(%ebp)
    pushl -16520(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16520(%ebp)
    addl $4, %esp
    jmp .Lprocess_620
.Lprocess_621:
    jmp .Lprocess_6
.Lprocess_611:
    jmp .Lprocess_605
.Lprocess_604:
.Lprocess_605:
    movl _g_macro_depth, %eax
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
    je .Lprocess_623
    pushl $0
    popl %eax
    movl %eax, -16528(%ebp)
    movl _g_blue_top, %eax
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
    je .Lprocess_625
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
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
    pushl -16536(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
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
    movl %eax, -16528(%ebp)
    pushl -16528(%ebp)
    addl $4, %esp
    movl _g_blue_top, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_blue_top
    addl $4, %esp
    jmp .Lprocess_626
.Lprocess_625:
.Lprocess_626:
    movl _g_macro_depth, %eax
    pushl %eax
    movl _g_macro_depth, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_depth
    addl $4, %esp
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    pushl -16536(%ebp)
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
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    movl _g_macro_depth, %eax
    pushl %eax
    movl _g_macro_depth, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_depth
    addl $4, %esp
    movl _g_blue_top, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_629
    movl $_g_blue_stack, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    pushl -16528(%ebp)
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
    jmp .Lprocess_630
.Lprocess_629:
    pushl $0
.Lprocess_630:
    popl %eax
    cmpl $0, %eax
    je .Lprocess_627
    movl _g_blue_top, %eax
    pushl %eax
    movl _g_blue_top, %eax
    pushl %eax
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_blue_top
    addl $4, %esp
    jmp .Lprocess_628
.Lprocess_627:
.Lprocess_628:
    jmp .Lprocess_624
.Lprocess_623:
    pushl -16536(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_puts
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_624:
    jmp .Lprocess_6
.Lprocess_602:
.Lprocess_603:
    pushl $0
    popl %eax
    movl %eax, -16528(%ebp)
    pushl -16528(%ebp)
    addl $4, %esp
.Lprocess_631:
    pushl -16528(%ebp)
    pushl -16544(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lprocess_632
    pushl -16616(%ebp)
    pushl -16528(%ebp)
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
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lprocess_633:
    pushl -16528(%ebp)
    pushl -16528(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16528(%ebp)
    addl $4, %esp
    jmp .Lprocess_631
.Lprocess_632:
    jmp .Lprocess_6
.Lprocess_505:
.Lprocess_506:
    pushl -16936(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lprocess_634
    pushl -16648(%ebp)
    pushl -16648(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16648(%ebp)
    addl $4, %esp
    jmp .Lprocess_635
.Lprocess_634:
.Lprocess_635:
    pushl -16664(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lprocess_636
    pushl -16936(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl -16944(%ebp)
    pushl -16952(%ebp)
    pushl -16960(%ebp)
    call _buf_putc
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lprocess_637
.Lprocess_636:
.Lprocess_637:
    pushl -16936(%ebp)
    pushl -16936(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16936(%ebp)
    addl $4, %esp
    jmp .Lprocess_6
.Lprocess_7:
    pushl -16656(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_cur_line
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

    .globl _preproc_process
_preproc_process:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl $_ark_sl_preproc_process_out_buf, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_0
    pushl -40(%ebp)
    call _apply_trigraphs
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lpreproc_process_1
.Lpreproc_process_0:
.Lpreproc_process_1:
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_cur_line
    addl $4, %esp
    pushl $1
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_macro_expand
    addl $4, %esp
    movl $_g_build_time, %eax
    pushl %eax
    movl $_g_build_date, %eax
    pushl %eax
    call _ark_get_date_time
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_37, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_2
    leal ark_str_38, %eax
    pushl %eax
    leal ark_str_39, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_3
.Lpreproc_process_2:
.Lpreproc_process_3:
    leal ark_str_40, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_4
    leal ark_str_41, %eax
    pushl %eax
    leal ark_str_42, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_5
.Lpreproc_process_4:
.Lpreproc_process_5:
    leal ark_str_43, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_6
    leal ark_str_44, %eax
    pushl %eax
    leal ark_str_45, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_7
.Lpreproc_process_6:
.Lpreproc_process_7:
    leal ark_str_46, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_8
    leal ark_str_47, %eax
    pushl %eax
    leal ark_str_48, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_9
.Lpreproc_process_8:
.Lpreproc_process_9:
    leal ark_str_49, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_10
    leal ark_str_50, %eax
    pushl %eax
    leal ark_str_51, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_11
.Lpreproc_process_10:
.Lpreproc_process_11:
    leal ark_str_52, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_12
    leal ark_str_53, %eax
    pushl %eax
    leal ark_str_54, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_13
.Lpreproc_process_12:
.Lpreproc_process_13:
    leal ark_str_55, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_14
    leal ark_str_56, %eax
    pushl %eax
    leal ark_str_57, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_15
.Lpreproc_process_14:
.Lpreproc_process_15:
    leal ark_str_58, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_16
    leal ark_str_59, %eax
    pushl %eax
    leal ark_str_60, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_17
.Lpreproc_process_16:
.Lpreproc_process_17:
    leal ark_str_61, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_18
    leal ark_str_62, %eax
    pushl %eax
    leal ark_str_63, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_19
.Lpreproc_process_18:
.Lpreproc_process_19:
    leal ark_str_64, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_20
    leal ark_str_65, %eax
    pushl %eax
    leal ark_str_66, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_21
.Lpreproc_process_20:
.Lpreproc_process_21:
    leal ark_str_67, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_22
    leal ark_str_68, %eax
    pushl %eax
    leal ark_str_69, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_23
.Lpreproc_process_22:
.Lpreproc_process_23:
    leal ark_str_70, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_24
    leal ark_str_71, %eax
    pushl %eax
    leal ark_str_72, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_25
.Lpreproc_process_24:
.Lpreproc_process_25:
    leal ark_str_73, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_26
    leal ark_str_74, %eax
    pushl %eax
    leal ark_str_75, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_27
.Lpreproc_process_26:
.Lpreproc_process_27:
    leal ark_str_76, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_28
    leal ark_str_77, %eax
    pushl %eax
    leal ark_str_78, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_29
.Lpreproc_process_28:
.Lpreproc_process_29:
    leal ark_str_79, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_30
    leal ark_str_80, %eax
    pushl %eax
    leal ark_str_81, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_31
.Lpreproc_process_30:
.Lpreproc_process_31:
    leal ark_str_82, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_32
    leal ark_str_83, %eax
    pushl %eax
    leal ark_str_84, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_33
.Lpreproc_process_32:
.Lpreproc_process_33:
    leal ark_str_85, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_34
    leal ark_str_86, %eax
    pushl %eax
    leal ark_str_87, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_35
.Lpreproc_process_34:
.Lpreproc_process_35:
    leal ark_str_88, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_36
    leal ark_str_89, %eax
    pushl %eax
    leal ark_str_90, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_37
.Lpreproc_process_36:
.Lpreproc_process_37:
    leal ark_str_91, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_38
    leal ark_str_92, %eax
    pushl %eax
    leal ark_str_93, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_39
.Lpreproc_process_38:
.Lpreproc_process_39:
    leal ark_str_94, %eax
    pushl %eax
    call _find_macro
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_process_40
    leal ark_str_95, %eax
    pushl %eax
    leal ark_str_96, %eax
    pushl %eax
    call _add_object_macro
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lpreproc_process_41
.Lpreproc_process_40:
.Lpreproc_process_41:
    pushl $4194303
    leal -24(%ebp), %eax
    pushl %eax
    pushl -32(%ebp)
    pushl -16(%ebp)
    call _process
    addl $16, %esp
    pushl %eax
    addl $4, %esp
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
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _preproc_get_included_files
_preproc_get_included_files:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl _g_inc_file_count, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_get_included_files_0
    pushl -32(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lpreproc_get_included_files_1
.Lpreproc_get_included_files_0:
.Lpreproc_get_included_files_1:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lpreproc_get_included_files_2:
    pushl -24(%ebp)
    pushl -16(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lpreproc_get_included_files_3
    pushl -40(%ebp)
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
    movl $_g_inc_files, %eax
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
.Lpreproc_get_included_files_4:
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
    jmp .Lpreproc_get_included_files_2
.Lpreproc_get_included_files_3:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

