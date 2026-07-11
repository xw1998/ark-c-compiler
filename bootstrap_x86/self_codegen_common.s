# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .section .rdata,"dr"
    .text
    .globl _asmbuf_init
_asmbuf_init:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $4096
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
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_asmbuf_grow:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
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
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_grow_0
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
    popl %eax
    movl %eax, -24(%ebp)
.Lasmbuf_grow_2:
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
    pushl -32(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
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
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_grow_3
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lasmbuf_grow_2
.Lasmbuf_grow_3:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
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
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
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
    jmp .Lasmbuf_grow_1
.Lasmbuf_grow_0:
.Lasmbuf_grow_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _asmbuf_putc
_asmbuf_putc:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl $1
    pushl -24(%ebp)
    call _asmbuf_grow
    addl $8, %esp
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
    pushl -24(%ebp)
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

    .globl _asmbuf_puts
_asmbuf_puts:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl -40(%ebp)
    call _asmbuf_grow
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lasmbuf_puts_0:
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
    je .Lasmbuf_puts_1
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
    pushl -40(%ebp)
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
.Lasmbuf_puts_2:
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
    jmp .Lasmbuf_puts_0
.Lasmbuf_puts_1:
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

    .globl _asmbuf_int
_asmbuf_int:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -80(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -76(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -80(%ebp)
    pushl -76(%ebp)
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
    jl .L64t_asmbuf_int_13
    jg .L64f_asmbuf_int_13
    cmpl %eax, (%esp)
    jl .L64t_asmbuf_int_13
.L64f_asmbuf_int_13:
    addl $4, %esp
    pushl $0
    jmp .L64e_asmbuf_int_13
.L64t_asmbuf_int_13:
    addl $4, %esp
    pushl $1
.L64e_asmbuf_int_13:
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_int_0
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -80(%ebp)
    pushl -76(%ebp)
    popl %edx
    popl %eax
    negl %eax
    adcl $0, %edx
    negl %edx
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -24(%ebp)
    movl %edx, -20(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lasmbuf_int_1
.Lasmbuf_int_0:
    pushl -80(%ebp)
    pushl -76(%ebp)
    popl %edx
    popl %eax
    movl %eax, -24(%ebp)
    movl %edx, -20(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lasmbuf_int_1:
    pushl -24(%ebp)
    pushl -20(%ebp)
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
    jne .L64f_asmbuf_int_37
    cmpl %eax, (%esp)
    jne .L64f_asmbuf_int_37
    addl $4, %esp
    pushl $1
    jmp .L64e_asmbuf_int_37
.L64f_asmbuf_int_37:
    addl $4, %esp
    pushl $0
.L64e_asmbuf_int_37:
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_int_2
    leal -72(%ebp), %eax
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
    jmp .Lasmbuf_int_3
.Lasmbuf_int_2:
.Lasmbuf_int_3:
.Lasmbuf_int_4:
    pushl -24(%ebp)
    pushl -20(%ebp)
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_int_5
    leal -72(%ebp), %eax
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
    pushl -24(%ebp)
    pushl -20(%ebp)
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
    call ___umoddi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    addl $4, %esp
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl -20(%ebp)
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
    call ___udivdi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    popl %edx
    popl %eax
    movl %eax, -24(%ebp)
    movl %edx, -20(%ebp)
    pushl -24(%ebp)
    pushl -20(%ebp)
    addl $4, %esp
    jmp .Lasmbuf_int_4
.Lasmbuf_int_5:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_int_6
    pushl $45
    pushl -88(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lasmbuf_int_7
.Lasmbuf_int_6:
.Lasmbuf_int_7:
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
.Lasmbuf_int_8:
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
    je .Lasmbuf_int_9
    leal -72(%ebp), %eax
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
    pushl -88(%ebp)
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lasmbuf_int_10:
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
    jmp .Lasmbuf_int_8
.Lasmbuf_int_9:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _asmbuf_printf_int
_asmbuf_printf_int:
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
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_printf_int_0
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lasmbuf_printf_int_1
.Lasmbuf_printf_int_0:
.Lasmbuf_printf_int_1:
    pushl -24(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    pushl -40(%ebp)
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lasmbuf_printf_int_2
    pushl -16(%ebp)
    pushl -40(%ebp)
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lasmbuf_printf_int_3
.Lasmbuf_printf_int_2:
.Lasmbuf_printf_int_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

