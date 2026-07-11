# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_errors
_g_errors:
    .zero 4
    .section .rdata,"dr"
ark_str_0:
    .asciz "[sema] line %d: %s\n"
ark_str_1:
    .asciz "printf"
ark_str_2:
    .asciz "putchar"
ark_str_3:
    .asciz "puts"
ark_str_4:
    .asciz "strlen"
ark_str_5:
    .asciz "strcmp"
ark_str_6:
    .asciz "strcpy"
ark_str_7:
    .asciz "memset"
ark_str_8:
    .asciz "memcpy"
ark_str_9:
    .asciz "abort"
ark_str_10:
    .asciz "malloc"
ark_str_11:
    .asciz "free"
ark_str_12:
    .asciz "redefinition of identifier as function"
ark_str_13:
    .asciz "function redefinition"
ark_str_14:
    .asciz "duplicate parameter"
ark_str_15:
    .asciz "redeclaration of global variable"
ark_str_16:
    .asciz "redeclaration of local variable"
ark_str_17:
    .asciz "undeclared identifier"
ark_str_18:
    .asciz "[sema] line %d: warning: argument count mismatch for '%s'\n"
    .text
_err:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lerr_0
    pushl -24(%ebp)
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
    jmp .Lerr_1
.Lerr_0:
    pushl $0
.Lerr_1:
    leal ark_str_0, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    movl _g_errors, %eax
    pushl %eax
    movl _g_errors, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, _g_errors
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

_promote_integer:
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
    je .Lpromote_integer_0
    call _type_int
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lpromote_integer_0:
.Lpromote_integer_1:
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
    jne .Lpromote_integer_3
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
    jne .Lpromote_integer_4
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
    jne .Lpromote_integer_5
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
    jne .Lpromote_integer_6
    jmp .Lpromote_integer_7
.Lpromote_integer_3:
.Lpromote_integer_4:
.Lpromote_integer_5:
.Lpromote_integer_6:
    call _type_int
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lpromote_integer_7:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lpromote_integer_2:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_type_rank:
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
    je .Ltype_rank_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_rank_0:
.Ltype_rank_1:
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
    popl %eax
    movl %eax, -16(%ebp)
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
    jne .Ltype_rank_3
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
    jne .Ltype_rank_4
    jmp .Ltype_rank_5
.Ltype_rank_3:
    pushl $3
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_rank_4:
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_rank_5:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_rank_2:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _usual_arith_conv
_usual_arith_conv:
    pushl %ebp
    movl %esp, %ebp
    subl $352, %esp
    movl 8(%ebp), %eax
    movl %eax, -104(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -96(%ebp)
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_2
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_3
.Lusual_arith_conv_2:
    pushl $0
.Lusual_arith_conv_3:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_0
    call _type_double
    pushl %eax
    call _type_complex
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_0:
.Lusual_arith_conv_1:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_6
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_7
.Lusual_arith_conv_6:
    pushl $0
.Lusual_arith_conv_7:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_4
    call _type_double
    pushl %eax
    call _type_complex
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_4:
.Lusual_arith_conv_5:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_10
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_11
.Lusual_arith_conv_10:
    pushl $0
.Lusual_arith_conv_11:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_8
    call _type_double
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_8:
.Lusual_arith_conv_9:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_14
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_15
.Lusual_arith_conv_14:
    pushl $0
.Lusual_arith_conv_15:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_12
    call _type_double
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_12:
.Lusual_arith_conv_13:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_18
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_19
.Lusual_arith_conv_18:
    pushl $0
.Lusual_arith_conv_19:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_16
    call _type_float
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_16:
.Lusual_arith_conv_17:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_22
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_23
.Lusual_arith_conv_22:
    pushl $0
.Lusual_arith_conv_23:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_20
    call _type_float
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_20:
.Lusual_arith_conv_21:
    pushl -104(%ebp)
    call _promote_integer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    call _promote_integer
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_24
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_26
    pushl -96(%ebp)
    jmp .Lusual_arith_conv_27
.Lusual_arith_conv_26:
    call _type_int
    pushl %eax
.Lusual_arith_conv_27:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_24:
.Lusual_arith_conv_25:
    pushl -96(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_28
    pushl -104(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_28:
.Lusual_arith_conv_29:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_32
    pushl -104(%ebp)
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
    pushl -96(%ebp)
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
    jmp .Lusual_arith_conv_33
.Lusual_arith_conv_32:
    pushl $0
.Lusual_arith_conv_33:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_30
    pushl -104(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_30:
.Lusual_arith_conv_31:
    pushl -104(%ebp)
    call _type_rank
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -96(%ebp)
    call _type_rank
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -88(%ebp)
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_34
    pushl -104(%ebp)
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .Lusual_arith_conv_35
.Lusual_arith_conv_34:
    pushl -96(%ebp)
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
.Lusual_arith_conv_35:
    pushl -72(%ebp)
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
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -88(%ebp)
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_36
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_38
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lusual_arith_conv_39
.Lusual_arith_conv_38:
    pushl $1
.Lusual_arith_conv_39:
    popl %eax
    movl %eax, -40(%ebp)
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_41
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_42
    jmp .Lusual_arith_conv_43
.Lusual_arith_conv_41:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_44
    call _type_ullong
    pushl %eax
    jmp .Lusual_arith_conv_45
.Lusual_arith_conv_44:
    call _type_llong
    pushl %eax
.Lusual_arith_conv_45:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_42:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_46
    call _type_ulong
    pushl %eax
    jmp .Lusual_arith_conv_47
.Lusual_arith_conv_46:
    call _type_long
    pushl %eax
.Lusual_arith_conv_47:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_43:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_48
    call _type_uint
    pushl %eax
    jmp .Lusual_arith_conv_49
.Lusual_arith_conv_48:
    call _type_int
    pushl %eax
.Lusual_arith_conv_49:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_40:
    jmp .Lusual_arith_conv_37
.Lusual_arith_conv_36:
.Lusual_arith_conv_37:
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_52
    pushl -48(%ebp)
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
    jmp .Lusual_arith_conv_53
.Lusual_arith_conv_52:
    pushl $1
.Lusual_arith_conv_53:
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_50
    pushl -72(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_50:
.Lusual_arith_conv_51:
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
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_54
    pushl $8
    jmp .Lusual_arith_conv_55
.Lusual_arith_conv_54:
    pushl $4
.Lusual_arith_conv_55:
    popl %eax
    movl %eax, -40(%ebp)
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_56
    pushl $8
    jmp .Lusual_arith_conv_57
.Lusual_arith_conv_56:
    pushl $4
.Lusual_arith_conv_57:
    popl %eax
    movl %eax, -32(%ebp)
    pushl -40(%ebp)
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lusual_arith_conv_58
    pushl -72(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_58:
.Lusual_arith_conv_59:
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_61
    pushl -24(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lusual_arith_conv_62
    jmp .Lusual_arith_conv_63
.Lusual_arith_conv_61:
    call _type_ullong
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_62:
    call _type_ulong
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_63:
    call _type_uint
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lusual_arith_conv_60:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_cast_changes_repr:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcast_changes_repr_2
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
    jmp .Lcast_changes_repr_3
.Lcast_changes_repr_2:
    pushl $1
.Lcast_changes_repr_3:
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcast_changes_repr_0:
.Lcast_changes_repr_1:
    pushl -40(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcast_changes_repr_6
    pushl -32(%ebp)
    call _type_is_arith
    addl $4, %esp
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
    jmp .Lcast_changes_repr_7
.Lcast_changes_repr_6:
    pushl $1
.Lcast_changes_repr_7:
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcast_changes_repr_4:
.Lcast_changes_repr_5:
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
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcast_changes_repr_8
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
    jmp .Lcast_changes_repr_9
.Lcast_changes_repr_8:
    pushl $1
.Lcast_changes_repr_9:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
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
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lcast_changes_repr_10
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
    jmp .Lcast_changes_repr_11
.Lcast_changes_repr_10:
    pushl $1
.Lcast_changes_repr_11:
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_14
    pushl -16(%ebp)
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
    jmp .Lcast_changes_repr_15
.Lcast_changes_repr_14:
    pushl $0
.Lcast_changes_repr_15:
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_12
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcast_changes_repr_12:
.Lcast_changes_repr_13:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_18
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcast_changes_repr_19
.Lcast_changes_repr_18:
    pushl $0
.Lcast_changes_repr_19:
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_16
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcast_changes_repr_16:
.Lcast_changes_repr_17:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_22
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lcast_changes_repr_23
.Lcast_changes_repr_22:
    pushl $0
.Lcast_changes_repr_23:
    popl %eax
    cmpl $0, %eax
    je .Lcast_changes_repr_20
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcast_changes_repr_20:
.Lcast_changes_repr_21:
    pushl -40(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    pushl -32(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sema_implicit_cast:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_implicit_cast_2
    pushl -16(%ebp)
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
    jmp .Lsema_implicit_cast_3
.Lsema_implicit_cast_2:
    pushl $1
.Lsema_implicit_cast_3:
    popl %eax
    cmpl $0, %eax
    je .Lsema_implicit_cast_0
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_implicit_cast_0:
.Lsema_implicit_cast_1:
    pushl -24(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_implicit_cast_4
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_implicit_cast_4:
.Lsema_implicit_cast_5:
    pushl -16(%ebp)
    pushl -24(%ebp)
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
    call _cast_changes_repr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_implicit_cast_6
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_implicit_cast_6:
.Lsema_implicit_cast_7:
    pushl -24(%ebp)
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
    pushl -24(%ebp)
    pushl -16(%ebp)
    call _ast_cast
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

    .globl _eval_const_expr
_eval_const_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_2
    pushl -64(%ebp)
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
    jmp .Leval_const_expr_3
.Leval_const_expr_2:
    pushl $1
.Leval_const_expr_3:
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_0:
.Leval_const_expr_1:
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
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_5
    pushl -40(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_6
    pushl -40(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_7
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
    jne .Leval_const_expr_8
    pushl -40(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_9
    pushl -40(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_10
    pushl -40(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_11
    jmp .Leval_const_expr_12
.Leval_const_expr_5:
    pushl -72(%ebp)
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
    je .Leval_const_expr_15
    pushl -72(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_17
    pushl -72(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Leval_const_expr_18
.Leval_const_expr_17:
    pushl $1
.Leval_const_expr_18:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Leval_const_expr_16
.Leval_const_expr_15:
    pushl $0
.Leval_const_expr_16:
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_13
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_13:
.Leval_const_expr_14:
    pushl -64(%ebp)
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_6:
    pushl -64(%ebp)
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_7:
    pushl -64(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_8:
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
    je .Leval_const_expr_21
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
    jmp .Leval_const_expr_22
.Leval_const_expr_21:
    pushl $0
.Leval_const_expr_22:
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_19
    pushl -64(%ebp)
    pushl -32(%ebp)
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_19:
.Leval_const_expr_20:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_9:
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_23
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_23:
.Leval_const_expr_24:
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
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_26
    pushl -32(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_27
    pushl -32(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_28
    pushl -32(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_29
    jmp .Leval_const_expr_30
.Leval_const_expr_26:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %edx
    popl %eax
    negl %eax
    adcl $0, %edx
    negl %edx
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_27:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_28:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %edx
    popl %eax
    notl %eax
    notl %edx
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_29:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %edx
    popl %eax
    orl %edx, %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_30:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_25:
.Leval_const_expr_10:
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_31
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_31:
.Leval_const_expr_32:
    leal -48(%ebp), %eax
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_33
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_33:
.Leval_const_expr_34:
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
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_36
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_37
    pushl -24(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_38
    pushl -24(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_39
    pushl -24(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_40
    pushl -24(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_41
    pushl -24(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_42
    pushl -24(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_43
    pushl -24(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_44
    pushl -24(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_45
    pushl -24(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_46
    pushl -24(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_47
    pushl -24(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_48
    pushl -24(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_49
    pushl -24(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_50
    pushl -24(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_51
    pushl -24(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_52
    pushl -24(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_53
    jmp .Leval_const_expr_54
.Leval_const_expr_36:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_37:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_38:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_39:
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    jne .L64f_eval_const_expr_415
    cmpl %eax, (%esp)
    jne .L64f_eval_const_expr_415
    addl $4, %esp
    pushl $1
    jmp .L64e_eval_const_expr_415
.L64f_eval_const_expr_415:
    addl $4, %esp
    pushl $0
.L64e_eval_const_expr_415:
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_55
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_55:
.Leval_const_expr_56:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_40:
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    jne .L64f_eval_const_expr_436
    cmpl %eax, (%esp)
    jne .L64f_eval_const_expr_436
    addl $4, %esp
    pushl $1
    jmp .L64e_eval_const_expr_436
.L64f_eval_const_expr_436:
    addl $4, %esp
    pushl $0
.L64e_eval_const_expr_436:
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_57
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_57:
.Leval_const_expr_58:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_41:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_42:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_43:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_44:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    shll %cl, %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_45:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_46:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64f_eval_const_expr_499
    cmpl %eax, (%esp)
    jne .L64f_eval_const_expr_499
    addl $4, %esp
    pushl $1
    jmp .L64e_eval_const_expr_499
.L64f_eval_const_expr_499:
    addl $4, %esp
    pushl $0
.L64e_eval_const_expr_499:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_47:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jne .L64t_eval_const_expr_512
    cmpl %eax, (%esp)
    jne .L64t_eval_const_expr_512
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_const_expr_512
.L64t_eval_const_expr_512:
    addl $4, %esp
    pushl $1
.L64e_eval_const_expr_512:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_48:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jl .L64t_eval_const_expr_525
    jg .L64f_eval_const_expr_525
    cmpl %eax, (%esp)
    jl .L64t_eval_const_expr_525
.L64f_eval_const_expr_525:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_const_expr_525
.L64t_eval_const_expr_525:
    addl $4, %esp
    pushl $1
.L64e_eval_const_expr_525:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_49:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jg .L64t_eval_const_expr_538
    jl .L64f_eval_const_expr_538
    cmpl %eax, (%esp)
    jg .L64t_eval_const_expr_538
.L64f_eval_const_expr_538:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_const_expr_538
.L64t_eval_const_expr_538:
    addl $4, %esp
    pushl $1
.L64e_eval_const_expr_538:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_50:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jl .L64t_eval_const_expr_551
    jg .L64f_eval_const_expr_551
    cmpl %eax, (%esp)
    jle .L64t_eval_const_expr_551
    je .L64t_eval_const_expr_551
.L64f_eval_const_expr_551:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_const_expr_551
.L64t_eval_const_expr_551:
    addl $4, %esp
    pushl $1
.L64e_eval_const_expr_551:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_51:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    pushl -48(%ebp)
    pushl -44(%ebp)
    popl %ecx
    popl %eax
    popl %edx
    cmpl %ecx, %edx
    jg .L64t_eval_const_expr_564
    jl .L64f_eval_const_expr_564
    cmpl %eax, (%esp)
    jge .L64t_eval_const_expr_564
    je .L64t_eval_const_expr_564
.L64f_eval_const_expr_564:
    addl $4, %esp
    pushl $0
    jmp .L64e_eval_const_expr_564
.L64t_eval_const_expr_564:
    addl $4, %esp
    pushl $1
.L64e_eval_const_expr_564:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_52:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_59
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    jmp .Leval_const_expr_60
.Leval_const_expr_59:
    pushl $0
.Leval_const_expr_60:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_53:
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl -52(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Leval_const_expr_61
    pushl -48(%ebp)
    pushl -44(%ebp)
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
    jmp .Leval_const_expr_62
.Leval_const_expr_61:
    pushl $1
.Leval_const_expr_62:
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
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_54:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_35:
.Leval_const_expr_11:
    leal -16(%ebp), %eax
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_63
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_63:
.Leval_const_expr_64:
    pushl -16(%ebp)
    pushl -12(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Leval_const_expr_65
    pushl -64(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_65:
    pushl -64(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _eval_const_expr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_66:
.Leval_const_expr_12:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Leval_const_expr_4:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _sema_check
_sema_check:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    pushl $0
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_errors
    addl $4, %esp
    call _sym_init
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_check_2
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
    jmp .Lsema_check_3
.Lsema_check_2:
    pushl $1
.Lsema_check_3:
    popl %eax
    cmpl $0, %eax
    je .Lsema_check_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_check_0:
.Lsema_check_1:
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -68(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -60(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -52(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -44(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -36(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -28(%ebp)
    leal ark_str_1, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    leal ark_str_2, %eax
    pushl %eax
    popl %eax
    movl %eax, -68(%ebp)
    leal ark_str_3, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    leal ark_str_4, %eax
    pushl %eax
    popl %eax
    movl %eax, -60(%ebp)
    leal ark_str_5, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    leal ark_str_6, %eax
    pushl %eax
    popl %eax
    movl %eax, -52(%ebp)
    leal ark_str_7, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    leal ark_str_8, %eax
    pushl %eax
    popl %eax
    movl %eax, -44(%ebp)
    leal ark_str_9, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    leal ark_str_10, %eax
    pushl %eax
    popl %eax
    movl %eax, -36(%ebp)
    leal ark_str_11, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -28(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lsema_check_4:
    leal -72(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_check_5
    pushl $0
    call _type_int
    pushl %eax
    leal -72(%ebp), %eax
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
    pushl $1
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
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
.Lsema_check_6:
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
    jmp .Lsema_check_4
.Lsema_check_5:
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Lsema_check_7:
    pushl -80(%ebp)
    pushl -88(%ebp)
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
    je .Lsema_check_8
    pushl -88(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_decl
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_check_9:
    pushl -80(%ebp)
    pushl -80(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    addl $4, %esp
    jmp .Lsema_check_7
.Lsema_check_8:
    movl _g_errors, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sema_func:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
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
    call _sym_find_current
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_0
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
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_2
    leal ark_str_12, %eax
    pushl %eax
    pushl -72(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_func_2:
.Lsema_func_3:
    pushl -56(%ebp)
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
    cmpl $0, %eax
    je .Lsema_func_6
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
    jmp .Lsema_func_7
.Lsema_func_6:
    pushl $0
.Lsema_func_7:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_4
    pushl -56(%ebp)
    pushl $60
    popl %ecx
    popl %eax
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
    je .Lsema_func_10
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_func_11
.Lsema_func_10:
    pushl $0
.Lsema_func_11:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_8
    leal ark_str_13, %eax
    pushl %eax
    pushl -72(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_func_8:
.Lsema_func_9:
    pushl -56(%ebp)
    pushl $60
    popl %ecx
    popl %eax
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
    je .Lsema_func_14
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_func_15
.Lsema_func_14:
    pushl $0
.Lsema_func_15:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_12
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_func_12:
.Lsema_func_13:
    pushl -56(%ebp)
    pushl $60
    popl %ecx
    popl %eax
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
    je .Lsema_func_18
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_func_19
.Lsema_func_18:
    pushl $0
.Lsema_func_19:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_16
    pushl -56(%ebp)
    pushl $20
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
    jmp .Lsema_func_17
.Lsema_func_16:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_func_17:
    jmp .Lsema_func_5
.Lsema_func_4:
.Lsema_func_5:
    pushl -56(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lsema_func_1
.Lsema_func_0:
    pushl $0
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64(%ebp)
    pushl $1
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lsema_func_1:
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl $28
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    je .Lsema_func_22
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
    jmp .Lsema_func_23
.Lsema_func_22:
    pushl $0
.Lsema_func_23:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_20
    pushl -48(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lsema_func_24:
    pushl -40(%ebp)
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
    je .Lsema_func_25
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
    movl %eax, -32(%ebp)
    pushl -48(%ebp)
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
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_29
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
    jmp .Lsema_func_30
.Lsema_func_29:
    pushl $0
.Lsema_func_30:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_27
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
    jmp .Lsema_func_28
.Lsema_func_27:
    pushl $0
.Lsema_func_28:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_func_26:
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
    jmp .Lsema_func_24
.Lsema_func_25:
    jmp .Lsema_func_21
.Lsema_func_20:
.Lsema_func_21:
    pushl -48(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    je .Lsema_func_31
    pushl -48(%ebp)
    pushl $56
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
    jmp .Lsema_func_32
.Lsema_func_31:
.Lsema_func_32:
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
    je .Lsema_func_33
    pushl -48(%ebp)
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
    jmp .Lsema_func_34
.Lsema_func_33:
.Lsema_func_34:
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
    cmpl $0, %eax
    je .Lsema_func_35
    pushl -48(%ebp)
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
    jmp .Lsema_func_36
.Lsema_func_35:
.Lsema_func_36:
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_37
    pushl -48(%ebp)
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
    jmp .Lsema_func_38
.Lsema_func_37:
.Lsema_func_38:
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
    je .Lsema_func_39
    pushl -48(%ebp)
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
    jmp .Lsema_func_40
.Lsema_func_39:
.Lsema_func_40:
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
    pushl $60
    popl %ecx
    popl %eax
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
    je .Lsema_func_41
    pushl -48(%ebp)
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
    jmp .Lsema_func_42
.Lsema_func_41:
.Lsema_func_42:
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
    pushl $64
    popl %ecx
    popl %eax
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
    je .Lsema_func_43
    pushl -48(%ebp)
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
    jmp .Lsema_func_44
.Lsema_func_43:
.Lsema_func_44:
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_45
    pushl -48(%ebp)
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_func_46
.Lsema_func_45:
.Lsema_func_46:
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
    pushl $36
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
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
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $60
    popl %ecx
    popl %eax
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
    pushl $44
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $64
    popl %ecx
    popl %eax
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
    pushl $52
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $68
    popl %ecx
    popl %eax
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
    pushl $56
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $72
    popl %ecx
    popl %eax
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
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $80
    popl %ecx
    popl %eax
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
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_47
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
    pushl $84
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_func_48
.Lsema_func_47:
.Lsema_func_48:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_func_53
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
    pushl $60
    popl %ecx
    popl %eax
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
    jmp .Lsema_func_54
.Lsema_func_53:
    pushl $1
.Lsema_func_54:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_func_51
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_func_52
.Lsema_func_51:
    pushl $1
.Lsema_func_52:
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_49
    pushl -48(%ebp)
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
    jmp .Lsema_func_50
.Lsema_func_49:
.Lsema_func_50:
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
    pushl $60
    popl %ecx
    popl %eax
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
    je .Lsema_func_55
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_func_55:
.Lsema_func_56:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_57
    call _sym_enter_scope
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lsema_func_59:
    pushl -40(%ebp)
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
    je .Lsema_func_60
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
    movl %eax, -32(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sym_find_current
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_func_62
    leal ark_str_14, %eax
    pushl %eax
    pushl -32(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_func_63
.Lsema_func_62:
    pushl $0
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
    pushl $0
    popl %ecx
    popl %eax
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
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lsema_func_63:
.Lsema_func_61:
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
    jmp .Lsema_func_59
.Lsema_func_60:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    call _sym_leave_scope
    pushl %eax
    addl $4, %esp
    jmp .Lsema_func_58
.Lsema_func_57:
.Lsema_func_58:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sema_decl:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_decl_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_decl_0:
.Lsema_decl_1:
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
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_3
    pushl -48(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_4
    pushl -48(%ebp)
    pushl $36
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_5
    pushl -48(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_6
    pushl -48(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_7
    pushl -48(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_decl_8
    jmp .Lsema_decl_9
.Lsema_decl_3:
.Lsema_decl_4:
.Lsema_decl_5:
    pushl -56(%ebp)
    call _sema_func
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_decl_2
.Lsema_decl_6:
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_decl_10
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_decl_10:
.Lsema_decl_11:
    pushl -40(%ebp)
    call _sym_find_current
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_decl_12
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_decl_14
    pushl -32(%ebp)
    pushl $0
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
    pushl -32(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    je .Lsema_decl_16
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_decl_17
.Lsema_decl_16:
.Lsema_decl_17:
    jmp .Lsema_decl_2
.Lsema_decl_14:
.Lsema_decl_15:
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
    cmpl $0, %eax
    je .Lsema_decl_18
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_decl_18:
.Lsema_decl_19:
    pushl -32(%ebp)
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
    je .Lsema_decl_20
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_decl_20:
.Lsema_decl_21:
    leal ark_str_15, %eax
    pushl %eax
    pushl -56(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_decl_12:
.Lsema_decl_13:
    pushl $0
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $3
    call _sym_add
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    je .Lsema_decl_22
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_decl_23
.Lsema_decl_22:
.Lsema_decl_23:
    jmp .Lsema_decl_2
.Lsema_decl_7:
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
    cmpl $0, %eax
    je .Lsema_decl_24
    pushl $0
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
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
    pushl $4
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_decl_25
.Lsema_decl_24:
.Lsema_decl_25:
    jmp .Lsema_decl_2
.Lsema_decl_8:
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lsema_decl_26:
    pushl -40(%ebp)
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
    je .Lsema_decl_27
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
    call _sema_decl
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_decl_28:
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
    jmp .Lsema_decl_26
.Lsema_decl_27:
    jmp .Lsema_decl_2
.Lsema_decl_9:
    jmp .Lsema_decl_2
.Lsema_decl_2:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sema_stmt:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_stmt_0:
.Lsema_stmt_1:
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_3
    pushl -32(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_4
    pushl -32(%ebp)
    pushl $31
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_5
    pushl -32(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_6
    pushl -32(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_7
    pushl -32(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_8
    pushl -32(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_9
    pushl -32(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_10
    pushl -32(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_11
    pushl -32(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_12
    pushl -32(%ebp)
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_13
    pushl -32(%ebp)
    pushl $28
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_14
    pushl -32(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_15
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_16
    pushl -32(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_17
    pushl -32(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_18
    pushl -32(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_stmt_19
    jmp .Lsema_stmt_20
.Lsema_stmt_3:
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_21
    call _sym_enter_scope
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_22
.Lsema_stmt_21:
.Lsema_stmt_22:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lsema_stmt_23:
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
    je .Lsema_stmt_24
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_stmt_25:
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
    jmp .Lsema_stmt_23
.Lsema_stmt_24:
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_26
    call _sym_leave_scope
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_27
.Lsema_stmt_26:
.Lsema_stmt_27:
    jmp .Lsema_stmt_2
.Lsema_stmt_4:
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_28
    jmp .Lsema_stmt_2
.Lsema_stmt_28:
.Lsema_stmt_29:
    pushl -24(%ebp)
    call _sym_find_current
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_30
    leal ark_str_16, %eax
    pushl %eax
    pushl -40(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_31
.Lsema_stmt_30:
    pushl $0
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
    pushl -24(%ebp)
    pushl $0
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lsema_stmt_31:
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
    je .Lsema_stmt_32
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_33
.Lsema_stmt_32:
.Lsema_stmt_33:
    jmp .Lsema_stmt_2
.Lsema_stmt_5:
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_34
    pushl $0
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
    pushl $4
    call _sym_add
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_35
.Lsema_stmt_34:
.Lsema_stmt_35:
    jmp .Lsema_stmt_2
.Lsema_stmt_6:
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_stmt
    addl $4, %esp
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_36
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_37
.Lsema_stmt_36:
.Lsema_stmt_37:
    jmp .Lsema_stmt_2
.Lsema_stmt_7:
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_8:
    call _sym_enter_scope
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_38
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
    pushl $0
    popl %ecx
    popl %eax
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
    jne .Lsema_stmt_42
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
    pushl $0
    popl %ecx
    popl %eax
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_stmt_43
.Lsema_stmt_42:
    pushl $1
.Lsema_stmt_43:
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_40
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_41
.Lsema_stmt_40:
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_stmt_41:
    jmp .Lsema_stmt_39
.Lsema_stmt_38:
.Lsema_stmt_39:
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
    cmpl $0, %eax
    je .Lsema_stmt_44
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_45
.Lsema_stmt_44:
.Lsema_stmt_45:
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
    je .Lsema_stmt_46
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_47
.Lsema_stmt_46:
.Lsema_stmt_47:
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    call _sym_leave_scope
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_9:
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_10:
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_11:
.Lsema_stmt_12:
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_13:
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
    call _sema_stmt
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_14:
    jmp .Lsema_stmt_2
.Lsema_stmt_15:
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_48
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_49
.Lsema_stmt_48:
.Lsema_stmt_49:
    jmp .Lsema_stmt_2
.Lsema_stmt_16:
.Lsema_stmt_17:
    jmp .Lsema_stmt_2
.Lsema_stmt_18:
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_stmt_50
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_51
.Lsema_stmt_50:
.Lsema_stmt_51:
    jmp .Lsema_stmt_2
.Lsema_stmt_19:
    jmp .Lsema_stmt_2
.Lsema_stmt_20:
    pushl -40(%ebp)
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_stmt_2
.Lsema_stmt_2:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_sema_expr:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_0
    call _type_int
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_0:
.Lsema_expr_1:
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
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_3
    pushl -64(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_4
    pushl -64(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_5
    pushl -64(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_6
    pushl -64(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_7
    pushl -64(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_8
    pushl -64(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_9
    pushl -64(%ebp)
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_10
    pushl -64(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_11
    pushl -64(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_12
    pushl -64(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_13
    pushl -64(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_14
    pushl -64(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_15
    pushl -64(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_16
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
    jne .Lsema_expr_17
    jmp .Lsema_expr_18
.Lsema_expr_3:
    pushl -72(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_19
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_20
.Lsema_expr_19:
.Lsema_expr_20:
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_4:
    pushl -72(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_21
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_char
    pushl %eax
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_22
.Lsema_expr_21:
.Lsema_expr_22:
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_5:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_6:
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
.Lsema_expr_23:
    pushl -56(%ebp)
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
    je .Lsema_expr_24
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -56(%ebp)
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_28
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
    jmp .Lsema_expr_29
.Lsema_expr_28:
    pushl $0
.Lsema_expr_29:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_26
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
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_expr_27
.Lsema_expr_26:
.Lsema_expr_27:
.Lsema_expr_25:
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
    jmp .Lsema_expr_23
.Lsema_expr_24:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_7:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_void
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_8:
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
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sym_find
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_30
    leal ark_str_17, %eax
    pushl %eax
    pushl -72(%ebp)
    call _err
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_30:
.Lsema_expr_31:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_9:
.Lsema_expr_10:
    call _type_int
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
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
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_32
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_34
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_36
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
    jmp .Lsema_expr_37
.Lsema_expr_36:
    call _type_int
    pushl %eax
.Lsema_expr_37:
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lsema_expr_35
.Lsema_expr_34:
.Lsema_expr_35:
    jmp .Lsema_expr_33
.Lsema_expr_32:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $21
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_50
    pushl -48(%ebp)
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
    jmp .Lsema_expr_51
.Lsema_expr_50:
    pushl $1
.Lsema_expr_51:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_48
    pushl -48(%ebp)
    pushl $23
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
    jmp .Lsema_expr_49
.Lsema_expr_48:
    pushl $1
.Lsema_expr_49:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_46
    pushl -48(%ebp)
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
    jmp .Lsema_expr_47
.Lsema_expr_46:
    pushl $1
.Lsema_expr_47:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_44
    pushl -48(%ebp)
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
    jmp .Lsema_expr_45
.Lsema_expr_44:
    pushl $1
.Lsema_expr_45:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_42
    pushl -48(%ebp)
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
    jmp .Lsema_expr_43
.Lsema_expr_42:
    pushl $1
.Lsema_expr_43:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_40
    pushl -48(%ebp)
    pushl $27
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
    jmp .Lsema_expr_41
.Lsema_expr_40:
    pushl $1
.Lsema_expr_41:
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_38
    pushl -48(%ebp)
    pushl $28
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
    jmp .Lsema_expr_39
.Lsema_expr_38:
    pushl $1
.Lsema_expr_39:
    popl %eax
    movl %eax, -40(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_52
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
    jmp .Lsema_expr_53
.Lsema_expr_52:
    pushl $0
.Lsema_expr_53:
    popl %eax
    movl %eax, -32(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_54
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
    jmp .Lsema_expr_55
.Lsema_expr_54:
    pushl $0
.Lsema_expr_55:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl -32(%ebp)
    call _usual_arith_conv
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_56
    pushl -16(%ebp)
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lsema_expr_57
.Lsema_expr_56:
.Lsema_expr_57:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_66
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_67
.Lsema_expr_66:
    pushl $0
.Lsema_expr_67:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_64
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_65
.Lsema_expr_64:
    pushl $0
.Lsema_expr_65:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_62
    pushl -32(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_63
.Lsema_expr_62:
    pushl $0
.Lsema_expr_63:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_60
    pushl -24(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_61
.Lsema_expr_60:
    pushl $0
.Lsema_expr_61:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_58
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
    pushl -16(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_implicit_cast
    addl $8, %esp
    pushl %eax
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
    pushl -16(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_implicit_cast
    addl $8, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_59
.Lsema_expr_58:
.Lsema_expr_59:
.Lsema_expr_33:
    pushl -72(%ebp)
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
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_11:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl $30
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_68
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    call _type_pointer
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_69
.Lsema_expr_68:
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
    je .Lsema_expr_70
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_74
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
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_76
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_77
.Lsema_expr_76:
    pushl $1
.Lsema_expr_77:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_75
.Lsema_expr_74:
    pushl $0
.Lsema_expr_75:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_72
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_73
.Lsema_expr_72:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_expr_73:
    jmp .Lsema_expr_71
.Lsema_expr_70:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_78
    pushl -56(%ebp)
    jmp .Lsema_expr_79
.Lsema_expr_78:
    call _type_int
    pushl %eax
.Lsema_expr_79:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_expr_71:
.Lsema_expr_69:
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_12:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_13:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_82
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
    jmp .Lsema_expr_83
.Lsema_expr_82:
    pushl $0
.Lsema_expr_83:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_80
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
    popl %eax
    movl %eax, -56(%ebp)
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
    pushl -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_implicit_cast
    addl $8, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_81
.Lsema_expr_80:
.Lsema_expr_81:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_14:
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
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_86
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
    pushl $1
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
    jmp .Lsema_expr_87
.Lsema_expr_86:
    pushl $1
.Lsema_expr_87:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_84
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_88
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_96
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
    jmp .Lsema_expr_97
.Lsema_expr_96:
    pushl $0
.Lsema_expr_97:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_94
    pushl -40(%ebp)
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
    jmp .Lsema_expr_95
.Lsema_expr_94:
    pushl $0
.Lsema_expr_95:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_92
    pushl -40(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_93
.Lsema_expr_92:
    pushl $0
.Lsema_expr_93:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_90
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_91
.Lsema_expr_90:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_expr_91:
    jmp .Lsema_expr_89
.Lsema_expr_88:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_expr_89:
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lsema_expr_98:
    pushl -48(%ebp)
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
    je .Lsema_expr_99
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_expr_100:
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
    jmp .Lsema_expr_98
.Lsema_expr_99:
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_84:
.Lsema_expr_85:
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lsema_expr_101:
    pushl -48(%ebp)
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
    je .Lsema_expr_102
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
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
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lsema_expr_103:
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
    jmp .Lsema_expr_101
.Lsema_expr_102:
    pushl -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_108
    pushl -56(%ebp)
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
    jmp .Lsema_expr_109
.Lsema_expr_108:
    pushl $0
.Lsema_expr_109:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_106
    pushl -56(%ebp)
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
    jmp .Lsema_expr_107
.Lsema_expr_106:
    pushl $0
.Lsema_expr_107:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_104
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -72(%ebp)
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
    leal ark_str_18, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lsema_expr_105
.Lsema_expr_104:
.Lsema_expr_105:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_15:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lsema_expr_112
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
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_114
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
    pushl $9
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
    jmp .Lsema_expr_115
.Lsema_expr_114:
    pushl $0
.Lsema_expr_115:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_113
.Lsema_expr_112:
    pushl $1
.Lsema_expr_113:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_110
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_110:
.Lsema_expr_111:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_16:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    popl %eax
    movl %eax, -48(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_120
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_121
.Lsema_expr_120:
    pushl $0
.Lsema_expr_121:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_118
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
    jmp .Lsema_expr_119
.Lsema_expr_118:
    pushl $0
.Lsema_expr_119:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_116
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Lsema_expr_117
.Lsema_expr_116:
.Lsema_expr_117:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -48(%ebp)
    call _type_find_field
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_122
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lsema_expr_123
.Lsema_expr_122:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lsema_expr_123:
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_17:
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_expr
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    pushl -56(%ebp)
    call _usual_arith_conv
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_132
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_133
.Lsema_expr_132:
    pushl $0
.Lsema_expr_133:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_130
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_131
.Lsema_expr_130:
    pushl $0
.Lsema_expr_131:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_128
    pushl -56(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_129
.Lsema_expr_128:
    pushl $0
.Lsema_expr_129:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_126
    pushl -48(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lsema_expr_127
.Lsema_expr_126:
    pushl $0
.Lsema_expr_127:
    popl %eax
    cmpl $0, %eax
    je .Lsema_expr_124
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_implicit_cast
    addl $8, %esp
    pushl %eax
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
    pushl -40(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _sema_implicit_cast
    addl $8, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Lsema_expr_125
.Lsema_expr_124:
.Lsema_expr_125:
    pushl -72(%ebp)
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
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_18:
    pushl -72(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _type_int
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lsema_expr_2:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

