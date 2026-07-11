# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _ark_sl_ark_get_date_time_mon_names
_ark_sl_ark_get_date_time_mon_names:
    .long ark_str_4
    .long ark_str_5
    .long ark_str_6
    .long ark_str_7
    .long ark_str_8
    .long ark_str_9
    .long ark_str_10
    .long ark_str_11
    .long ark_str_12
    .long ark_str_13
    .long ark_str_14
    .long ark_str_15
    .section .rdata,"dr"
ark_str_0:
    .asciz "Jan  1 1970"
ark_str_1:
    .asciz "00:00:00"
ark_str_2:
    .asciz ""
ark_str_3:
    .asciz "[arkcc] FATAL: %s\n"
ark_str_4:
    .asciz "Jan"
ark_str_5:
    .asciz "Feb"
ark_str_6:
    .asciz "Mar"
ark_str_7:
    .asciz "Apr"
ark_str_8:
    .asciz "May"
ark_str_9:
    .asciz "Jun"
ark_str_10:
    .asciz "Jul"
ark_str_11:
    .asciz "Aug"
ark_str_12:
    .asciz "Sep"
ark_str_13:
    .asciz "Oct"
ark_str_14:
    .asciz "Nov"
ark_str_15:
    .asciz "Dec"
    .text
    .globl _ark_get_date_time
_ark_get_date_time:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl $0
    call _time
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    leal -56(%ebp), %eax
    pushl %eax
    call _localtime
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lark_get_date_time_0
    pushl -48(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -48(%ebp)
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
    pushl $1900
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    movl $_ark_sl_ark_get_date_time_mon_names, %eax
    pushl %eax
    pushl -48(%ebp)
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
    pushl $12
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %edx
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
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $1
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
    pushl -72(%ebp)
    pushl $2
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $3
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
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_get_date_time_2
    pushl $32
    jmp .Lark_get_date_time_3
.Lark_get_date_time_2:
    pushl $48
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
.Lark_get_date_time_3:
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -72(%ebp)
    pushl $6
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
    pushl $7
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -32(%ebp)
    pushl $1000
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -32(%ebp)
    pushl $100
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -72(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -72(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -32(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -72(%ebp)
    pushl $11
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
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -48(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
    pushl -48(%ebp)
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -64(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $58
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -64(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $58
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $48
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
    pushl $10
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
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
    pushl -64(%ebp)
    pushl $8
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
    jmp .Lark_get_date_time_1
.Lark_get_date_time_0:
    leal ark_str_0, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    leal ark_str_1, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_get_date_time_4:
    pushl -24(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_get_date_time_5
    pushl -72(%ebp)
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
.Lark_get_date_time_6:
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
    jmp .Lark_get_date_time_4
.Lark_get_date_time_5:
    pushl -72(%ebp)
    pushl $11
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_get_date_time_7:
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_get_date_time_8
    pushl -64(%ebp)
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lark_get_date_time_9:
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
    jmp .Lark_get_date_time_7
.Lark_get_date_time_8:
    pushl -64(%ebp)
    pushl $8
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
.Lark_get_date_time_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ark_log
_ark_log:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    leal 12(%ebp), %eax
    movl %eax, __ark_va_ptr
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl __ark_va_ptr, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    pushl -24(%ebp)
    movl _stderr, %eax
    pushl %eax
    call _vfprintf
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
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

    .globl _ark_abort
_ark_abort:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lark_abort_0
    pushl -24(%ebp)
    jmp .Lark_abort_1
.Lark_abort_0:
    leal ark_str_2, %eax
    pushl %eax
.Lark_abort_1:
    leal ark_str_3, %eax
    pushl %eax
    movl _stderr, %eax
    pushl %eax
    call _fprintf
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    call _exit
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

