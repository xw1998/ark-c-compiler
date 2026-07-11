# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .section .rdata,"dr"
ark_str_0:
    .asciz ""
    .text
    .globl _ast_new
_ast_new:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $144
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
    pushl -32(%ebp)
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
    movl .L_dbl_0, %eax
    pushl %eax
    movl .L_dbl_0+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
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

    .globl _ast_num
_ast_num:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -36(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $16
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
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
    pushl -40(%ebp)
    pushl -36(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
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

    .globl _ast_str
_ast_str:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $21
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
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
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Last_str_0
    pushl -40(%ebp)
    jmp .Last_str_1
.Last_str_0:
    leal ark_str_0, %eax
    pushl %eax
.Last_str_1:
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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

    .globl _ast_var
_ast_var:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $17
    call _ast_new
    addl $8, %esp
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_binary
_ast_binary:
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
    pushl -32(%ebp)
    pushl $12
    call _ast_new
    addl $8, %esp
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
    pushl $8
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
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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

    .globl _ast_unary
_ast_unary:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $13
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    pushl $0
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
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_assign
_ast_assign:
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
    pushl -32(%ebp)
    pushl $15
    call _ast_new
    addl $8, %esp
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
    pushl $8
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
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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

    .globl _ast_if
_ast_if:
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
    pushl -32(%ebp)
    pushl $6
    call _ast_new
    addl $8, %esp
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
    pushl $8
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
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_while
_ast_while:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $7
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_for
_ast_for:
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
    pushl -24(%ebp)
    pushl $8
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    pushl -56(%ebp)
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
    pushl $8
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
    pushl -32(%ebp)
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
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_block
_ast_block:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $4
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    pushl $0
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
    pushl $0
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
    pushl $0
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
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _block_add_stmt
_block_add_stmt:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
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
    je .Lblock_add_stmt_0
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
    je .Lblock_add_stmt_2
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
    jmp .Lblock_add_stmt_3
.Lblock_add_stmt_2:
    pushl $8
.Lblock_add_stmt_3:
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
    jmp .Lblock_add_stmt_1
.Lblock_add_stmt_0:
.Lblock_add_stmt_1:
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
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_func_def
_ast_func_def:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 24(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 28(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    call _ast_new
    addl $8, %esp
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
    pushl -64(%ebp)
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
    pushl -56(%ebp)
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
    pushl $12
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
    pushl $16
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
    pushl $24
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
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

    .globl _ast_var_decl
_ast_var_decl:
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
    pushl -32(%ebp)
    pushl $3
    call _ast_new
    addl $8, %esp
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
    pushl $8
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
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_func_call
_ast_func_call:
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
    pushl -32(%ebp)
    pushl $19
    call _ast_new
    addl $8, %esp
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
    pushl $8
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
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_array_access
_ast_array_access:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $18
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_member
_ast_member:
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
    pushl -32(%ebp)
    pushl $23
    call _ast_new
    addl $8, %esp
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
    pushl -48(%ebp)
    call _mem_strdup
    addl $4, %esp
    pushl %eax
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
    pushl -40(%ebp)
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_cast
_ast_cast:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $22
    call _ast_new
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
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
    pushl -16(%ebp)
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
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ast_sizeof_val
_ast_sizeof_val:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $24
    call _ast_new
    addl $8, %esp
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
    pushl -40(%ebp)
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
    pushl -24(%ebp)
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
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .section .rdata,"dr"
.L_flt_0:
    .long 0x00000000
.L_dbl_0:
    .long 0x00000000
    .long 0x00000000
    .text
