# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _ty_void
_ty_void:
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_char
_ty_char:
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_short
_ty_short:
    .long 2
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_int
_ty_int:
    .long 3
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_long
_ty_long:
    .long 4
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_llong
_ty_llong:
    .long 5
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_bool
_ty_bool:
    .long 6
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_float
_ty_float:
    .long 7
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_double
_ty_double:
    .long 8
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_uchar
_ty_uchar:
    .long 1
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_ushort
_ty_ushort:
    .long 2
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_uint
_ty_uint:
    .long 3
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_ulong
_ty_ulong:
    .long 4
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_ullong
_ty_ullong:
    .long 5
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _ty_wchar
_ty_wchar:
    .long 15
    .long 0
    .long 0
    .long 1
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .globl _g_pack_align
_g_pack_align:
    .long 0
    .globl _g_ptr_size
_g_ptr_size:
    .long 4
    .section .rdata,"dr"
ark_str_0:
    .asciz ""
ark_str_1:
    .asciz ""
    .text
    .globl _type_void
_type_void:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_void, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_char
_type_char:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_char, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_short
_type_short:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_short, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_int
_type_int:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_int, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_long
_type_long:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_long, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_llong
_type_llong:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_llong, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_bool
_type_bool:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_bool, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_float
_type_float:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_float, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_double
_type_double:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_double, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_uchar
_type_uchar:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_uchar, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_ushort
_type_ushort:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_ushort, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_uint
_type_uint:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_uint, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_ulong
_type_ulong:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_ulong, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_ullong
_type_ullong:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_ullong, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_pointer
_type_pointer:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $56
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
    pushl $9
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

    .globl _type_qualified
_type_qualified:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_qualified_0
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_qualified_0:
.Ltype_qualified_1:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_qualified_4
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
    jmp .Ltype_qualified_5
.Ltype_qualified_4:
    pushl $0
.Ltype_qualified_5:
    popl %eax
    cmpl $0, %eax
    je .Ltype_qualified_2
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_qualified_2:
.Ltype_qualified_3:
    pushl $56
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    pushl -40(%ebp)
    pushl -16(%ebp)
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
    movl 48(%eax), %edx
    movl %edx, 48(%ecx)
    movl 52(%eax), %edx
    movl %edx, 52(%ecx)
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
    pushl $48
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
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_array
_type_array:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $56
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
    pushl $10
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
    pushl -40(%ebp)
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_struct
_type_struct:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $56
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
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_0
    pushl $12
    jmp .Ltype_struct_1
.Ltype_struct_0:
    pushl $11
.Ltype_struct_1:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_2
    pushl -24(%ebp)
    pushl $20
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
    jmp .Ltype_struct_3
.Ltype_struct_2:
.Ltype_struct_3:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_enum
_type_enum:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $56
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
    pushl $14
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_enum_0
    pushl -16(%ebp)
    pushl $20
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
    jmp .Ltype_enum_1
.Ltype_enum_0:
.Ltype_enum_1:
    pushl -16(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_func
_type_func:
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
    pushl $56
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
    pushl $13
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
    pushl -56(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $28
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
    pushl $32
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
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_wchar
_type_wchar:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_ty_wchar, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_complex
_type_complex:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $56
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
    pushl $16
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

    .globl _type_set_pack
_type_set_pack:
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
    movl %eax, _g_pack_align
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

    .globl _type_get_pack
_type_get_pack:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl _g_pack_align, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_struct_add_field
_type_struct_add_field:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -80(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl $24
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -72(%ebp)
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -72(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -88(%ebp)
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
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_0
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_1
.Ltype_struct_add_field_0:
.Ltype_struct_add_field_1:
    movl _g_pack_align, %eax
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
    je .Ltype_struct_add_field_2
    movl _g_pack_align, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_3
.Ltype_struct_add_field_2:
.Ltype_struct_add_field_3:
    pushl -88(%ebp)
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
    je .Ltype_struct_add_field_4
    pushl $1
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_5
.Ltype_struct_add_field_4:
.Ltype_struct_add_field_5:
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
    je .Ltype_struct_add_field_8
    pushl -56(%ebp)
    pushl -32(%ebp)
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
    jmp .Ltype_struct_add_field_9
.Ltype_struct_add_field_8:
    pushl $0
.Ltype_struct_add_field_9:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_6
    pushl -32(%ebp)
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_7
.Ltype_struct_add_field_6:
.Ltype_struct_add_field_7:
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_10
    pushl $1
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_11
.Ltype_struct_add_field_10:
.Ltype_struct_add_field_11:
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_16
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
    jmp .Ltype_struct_add_field_17
.Ltype_struct_add_field_16:
    pushl $0
.Ltype_struct_add_field_17:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_14
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
    jmp .Ltype_struct_add_field_15
.Ltype_struct_add_field_14:
    pushl $0
.Ltype_struct_add_field_15:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_12
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_field_13
.Ltype_struct_add_field_12:
.Ltype_struct_add_field_13:
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
    je .Ltype_struct_add_field_20
    pushl -88(%ebp)
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
    jmp .Ltype_struct_add_field_21
.Ltype_struct_add_field_20:
    pushl $0
.Ltype_struct_add_field_21:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_18
    pushl -88(%ebp)
    pushl $40
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
    jmp .Ltype_struct_add_field_19
.Ltype_struct_add_field_18:
.Ltype_struct_add_field_19:
    pushl -40(%ebp)
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_22
    pushl -80(%ebp)
    jmp .Ltype_struct_add_field_23
.Ltype_struct_add_field_22:
    leal ark_str_0, %eax
    pushl %eax
.Ltype_struct_add_field_23:
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64(%ebp)
    pushl $4
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
    pushl -64(%ebp)
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
    pushl -64(%ebp)
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
    pushl -64(%ebp)
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
    pushl -64(%ebp)
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
    pushl -88(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_24
    pushl -88(%ebp)
    pushl $24
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
    jmp .Ltype_struct_add_field_25
.Ltype_struct_add_field_24:
    pushl -88(%ebp)
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
.Ltype_struct_add_field_26:
    pushl -16(%ebp)
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
    je .Ltype_struct_add_field_27
    pushl -16(%ebp)
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
    jmp .Ltype_struct_add_field_26
.Ltype_struct_add_field_27:
    pushl -16(%ebp)
    pushl $20
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
.Ltype_struct_add_field_25:
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_28
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_32
    pushl -48(%ebp)
    pushl -88(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Ltype_struct_add_field_33
.Ltype_struct_add_field_32:
    pushl $0
.Ltype_struct_add_field_33:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_30
    pushl -88(%ebp)
    pushl $8
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
    jmp .Ltype_struct_add_field_31
.Ltype_struct_add_field_30:
.Ltype_struct_add_field_31:
    jmp .Ltype_struct_add_field_29
.Ltype_struct_add_field_28:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_field_34
    pushl -88(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Ltype_struct_add_field_35
.Ltype_struct_add_field_34:
.Ltype_struct_add_field_35:
.Ltype_struct_add_field_29:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_struct_add_bitfield
_type_struct_add_bitfield:
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
    pushl -104(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -80(%ebp)
    pushl -104(%ebp)
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    movl _g_pack_align, %eax
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
    je .Ltype_struct_add_bitfield_0
    movl _g_pack_align, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_1
.Ltype_struct_add_bitfield_0:
.Ltype_struct_add_bitfield_1:
    pushl -120(%ebp)
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
    je .Ltype_struct_add_bitfield_2
    pushl $1
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_3
.Ltype_struct_add_bitfield_2:
.Ltype_struct_add_bitfield_3:
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_6
    pushl -72(%ebp)
    pushl -64(%ebp)
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
    jmp .Ltype_struct_add_bitfield_7
.Ltype_struct_add_bitfield_6:
    pushl $0
.Ltype_struct_add_bitfield_7:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_4
    pushl -64(%ebp)
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_5
.Ltype_struct_add_bitfield_4:
.Ltype_struct_add_bitfield_5:
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_10
    pushl -120(%ebp)
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
    jmp .Ltype_struct_add_bitfield_11
.Ltype_struct_add_bitfield_10:
    pushl $0
.Ltype_struct_add_bitfield_11:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_8
    pushl -120(%ebp)
    pushl $40
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
    jmp .Ltype_struct_add_bitfield_9
.Ltype_struct_add_bitfield_8:
.Ltype_struct_add_bitfield_9:
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_12
    pushl $1
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_13
.Ltype_struct_add_bitfield_12:
.Ltype_struct_add_bitfield_13:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_14
    pushl -104(%ebp)
    pushl -112(%ebp)
    pushl -120(%ebp)
    call _type_struct_add_field
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_struct_add_bitfield_14:
.Ltype_struct_add_bitfield_15:
    pushl -96(%ebp)
    pushl -80(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_16
    pushl -80(%ebp)
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_17
.Ltype_struct_add_bitfield_16:
.Ltype_struct_add_bitfield_17:
    pushl -120(%ebp)
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
    je .Ltype_struct_add_bitfield_18
    pushl -120(%ebp)
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
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Ltype_struct_add_bitfield_20:
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
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_21
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
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_20
.Ltype_struct_add_bitfield_21:
    jmp .Ltype_struct_add_bitfield_19
.Ltype_struct_add_bitfield_18:
.Ltype_struct_add_bitfield_19:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_28
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
    jmp .Ltype_struct_add_bitfield_29
.Ltype_struct_add_bitfield_28:
    pushl $0
.Ltype_struct_add_bitfield_29:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_26
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
    pushl -104(%ebp)
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
    jmp .Ltype_struct_add_bitfield_27
.Ltype_struct_add_bitfield_26:
    pushl $0
.Ltype_struct_add_bitfield_27:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_24
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
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
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
    jmp .Ltype_struct_add_bitfield_25
.Ltype_struct_add_bitfield_24:
    pushl $0
.Ltype_struct_add_bitfield_25:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_22
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
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_23
.Ltype_struct_add_bitfield_22:
    pushl -120(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl -72(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_30
    pushl -88(%ebp)
    pushl -120(%ebp)
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
    je .Ltype_struct_add_bitfield_32
    pushl -120(%ebp)
    pushl $8
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
    jmp .Ltype_struct_add_bitfield_33
.Ltype_struct_add_bitfield_32:
.Ltype_struct_add_bitfield_33:
    jmp .Ltype_struct_add_bitfield_31
.Ltype_struct_add_bitfield_30:
    pushl -120(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Ltype_struct_add_bitfield_31:
.Ltype_struct_add_bitfield_23:
    pushl $24
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_34
    pushl -112(%ebp)
    jmp .Ltype_struct_add_bitfield_35
.Ltype_struct_add_bitfield_34:
    leal ark_str_1, %eax
    pushl %eax
.Ltype_struct_add_bitfield_35:
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
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
    pushl -56(%ebp)
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
    pushl -56(%ebp)
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
    pushl -56(%ebp)
    pushl $16
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
    pushl -120(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_bitfield_36
    pushl -120(%ebp)
    pushl $24
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
    jmp .Ltype_struct_add_bitfield_37
.Ltype_struct_add_bitfield_36:
    pushl -120(%ebp)
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
.Ltype_struct_add_bitfield_38:
    pushl -24(%ebp)
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
    je .Ltype_struct_add_bitfield_39
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_bitfield_38
.Ltype_struct_add_bitfield_39:
    pushl -24(%ebp)
    pushl $20
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
.Ltype_struct_add_bitfield_37:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_struct_add_anonymous
_type_struct_add_anonymous:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -72(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_struct_add_anonymous_2
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
    jmp .Ltype_struct_add_anonymous_3
.Ltype_struct_add_anonymous_2:
    pushl $1
.Ltype_struct_add_anonymous_3:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_struct_add_anonymous_0:
.Ltype_struct_add_anonymous_1:
    pushl -64(%ebp)
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_4
    pushl $1
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_anonymous_5
.Ltype_struct_add_anonymous_4:
.Ltype_struct_add_anonymous_5:
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_6
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_anonymous_7
.Ltype_struct_add_anonymous_6:
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
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -48(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
.Ltype_struct_add_anonymous_7:
    pushl -64(%ebp)
    call _type_size
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
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
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Ltype_struct_add_anonymous_8:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_9
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
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_struct_add_anonymous_13
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
    jmp .Ltype_struct_add_anonymous_14
.Ltype_struct_add_anonymous_13:
    pushl $1
.Ltype_struct_add_anonymous_14:
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_11
    jmp .Ltype_struct_add_anonymous_10
.Ltype_struct_add_anonymous_11:
.Ltype_struct_add_anonymous_12:
    pushl $24
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
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -24(%ebp)
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
    pushl -72(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_15
    pushl -72(%ebp)
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
    jmp .Ltype_struct_add_anonymous_16
.Ltype_struct_add_anonymous_15:
    pushl -72(%ebp)
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
.Ltype_struct_add_anonymous_17:
    pushl -16(%ebp)
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
    je .Ltype_struct_add_anonymous_18
    pushl -16(%ebp)
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
    jmp .Ltype_struct_add_anonymous_17
.Ltype_struct_add_anonymous_18:
    pushl -16(%ebp)
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
.Ltype_struct_add_anonymous_16:
.Ltype_struct_add_anonymous_10:
    pushl -32(%ebp)
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Ltype_struct_add_anonymous_8
.Ltype_struct_add_anonymous_9:
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
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_19
    pushl -40(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_struct_add_anonymous_21
    pushl -72(%ebp)
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
    jmp .Ltype_struct_add_anonymous_22
.Ltype_struct_add_anonymous_21:
.Ltype_struct_add_anonymous_22:
    jmp .Ltype_struct_add_anonymous_20
.Ltype_struct_add_anonymous_19:
    pushl -72(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Ltype_struct_add_anonymous_20:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_set_ptr_size
_type_set_ptr_size:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
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
    jne .Ltype_set_ptr_size_2
    pushl -24(%ebp)
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
    jmp .Ltype_set_ptr_size_3
.Ltype_set_ptr_size_2:
    pushl $1
.Ltype_set_ptr_size_3:
    popl %eax
    cmpl $0, %eax
    je .Ltype_set_ptr_size_0
    pushl -24(%ebp)
    popl %eax
    pushl %eax
    pushl %eax
    popl %eax
    movl %eax, _g_ptr_size
    addl $4, %esp
    jmp .Ltype_set_ptr_size_1
.Ltype_set_ptr_size_0:
.Ltype_set_ptr_size_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_size
_type_size:
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
    je .Ltype_size_0
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_0:
.Ltype_size_1:
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_3
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
    jne .Ltype_size_4
    pushl -48(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_5
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
    jne .Ltype_size_6
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
    jne .Ltype_size_7
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
    jne .Ltype_size_8
    pushl -48(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_9
    pushl -48(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_10
    pushl -48(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_11
    pushl -48(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_12
    pushl -48(%ebp)
    pushl $15
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_13
    pushl -48(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_14
    pushl -48(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_15
    pushl -48(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_16
    pushl -48(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_17
    pushl -48(%ebp)
    pushl $14
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_18
    pushl -48(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_size_19
    jmp .Ltype_size_2
.Ltype_size_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_4:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_5:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_6:
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_7:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_8:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_9:
    pushl $8
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_10:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_11:
    pushl $8
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_12:
    movl _g_ptr_size, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_13:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_14:
    pushl $2
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
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_15:
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
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_20
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
    jmp .Ltype_size_21
.Ltype_size_20:
    pushl $1
.Ltype_size_21:
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_16:
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
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
    movl %eax, -32(%ebp)
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Ltype_size_22:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_23
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
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_25
    pushl -16(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Ltype_size_26
.Ltype_size_25:
.Ltype_size_26:
.Ltype_size_24:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Ltype_size_22
.Ltype_size_23:
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_27
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Ltype_size_28
.Ltype_size_27:
.Ltype_size_28:
    pushl -56(%ebp)
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
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_31
    pushl -56(%ebp)
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
    pushl -40(%ebp)
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
    jmp .Ltype_size_32
.Ltype_size_31:
    pushl $0
.Ltype_size_32:
    popl %eax
    cmpl $0, %eax
    je .Ltype_size_29
    pushl -56(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Ltype_size_30
.Ltype_size_29:
.Ltype_size_30:
    pushl -32(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_17:
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
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_18:
    movl $_g_config, %eax
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
    addl $4, %esp
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_19:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_size_2:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_align
_type_align:
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
    je .Ltype_align_0
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_0:
.Ltype_align_1:
    pushl -56(%ebp)
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
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_align_2
    pushl -56(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_2:
.Ltype_align_3:
    pushl -56(%ebp)
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
    je .Ltype_align_4
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_4:
.Ltype_align_5:
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
    jne .Ltype_align_7
    pushl -48(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_8
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
    jne .Ltype_align_9
    pushl -48(%ebp)
    pushl $5
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_10
    pushl -48(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_11
    pushl -48(%ebp)
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_12
    pushl -48(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_13
    pushl -48(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_14
    pushl -48(%ebp)
    pushl $11
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_15
    pushl -48(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_align_16
    jmp .Ltype_align_17
.Ltype_align_7:
.Ltype_align_8:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_9:
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_10:
.Ltype_align_11:
    pushl $8
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_12:
    movl _g_ptr_size, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_13:
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
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_14:
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
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_15:
.Ltype_align_16:
    pushl $1
    popl %eax
    movl %eax, -40(%ebp)
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Ltype_align_18:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_align_19
    pushl -32(%ebp)
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
    call _type_align
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_align_21
    pushl -24(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Ltype_align_22
.Ltype_align_21:
.Ltype_align_22:
.Ltype_align_20:
    pushl -32(%ebp)
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Ltype_align_18
.Ltype_align_19:
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_17:
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_align_6:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_equal
_type_equal:
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
    jne .Ltype_equal_2
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
    jmp .Ltype_equal_3
.Ltype_equal_2:
    pushl $1
.Ltype_equal_3:
    popl %eax
    cmpl $0, %eax
    je .Ltype_equal_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_equal_0:
.Ltype_equal_1:
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_equal_4
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_equal_4:
.Ltype_equal_5:
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
    pushl $9
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_equal_8
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
    jmp .Ltype_equal_9
.Ltype_equal_8:
    pushl $1
.Ltype_equal_9:
    popl %eax
    cmpl $0, %eax
    je .Ltype_equal_6
    pushl -16(%ebp)
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
    call _type_equal
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_equal_6:
.Ltype_equal_7:
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
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_equal_10
    pushl -16(%ebp)
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
    call _type_equal
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_equal_10:
.Ltype_equal_11:
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_is_integer
_type_is_integer:
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
    je .Ltype_is_integer_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_is_integer_0:
.Ltype_is_integer_1:
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
    pushl $1
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_14
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
    jmp .Ltype_is_integer_15
.Ltype_is_integer_14:
    pushl $1
.Ltype_is_integer_15:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_12
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
    jmp .Ltype_is_integer_13
.Ltype_is_integer_12:
    pushl $1
.Ltype_is_integer_13:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_10
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
    jmp .Ltype_is_integer_11
.Ltype_is_integer_10:
    pushl $1
.Ltype_is_integer_11:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_8
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
    jmp .Ltype_is_integer_9
.Ltype_is_integer_8:
    pushl $1
.Ltype_is_integer_9:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_6
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
    pushl $6
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
    jmp .Ltype_is_integer_7
.Ltype_is_integer_6:
    pushl $1
.Ltype_is_integer_7:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_4
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
    jmp .Ltype_is_integer_5
.Ltype_is_integer_4:
    pushl $1
.Ltype_is_integer_5:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_integer_2
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
    pushl $15
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
    jmp .Ltype_is_integer_3
.Ltype_is_integer_2:
    pushl $1
.Ltype_is_integer_3:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_is_arith
_type_is_arith:
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
    je .Ltype_is_arith_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_is_arith_0:
.Ltype_is_arith_1:
    pushl -24(%ebp)
    call _type_is_integer
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_arith_4
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
    jmp .Ltype_is_arith_5
.Ltype_is_arith_4:
    pushl $1
.Ltype_is_arith_5:
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_arith_2
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
    jmp .Ltype_is_arith_3
.Ltype_is_arith_2:
    pushl $1
.Ltype_is_arith_3:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_is_scalar
_type_is_scalar:
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
    je .Ltype_is_scalar_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_is_scalar_0:
.Ltype_is_scalar_1:
    pushl -24(%ebp)
    call _type_is_arith
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltype_is_scalar_2
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
    jmp .Ltype_is_scalar_3
.Ltype_is_scalar_2:
    pushl $1
.Ltype_is_scalar_3:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _type_find_field
_type_find_field:
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
    jne .Ltype_find_field_2
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
    jmp .Ltype_find_field_3
.Ltype_find_field_2:
    pushl $1
.Ltype_find_field_3:
    popl %eax
    cmpl $0, %eax
    je .Ltype_find_field_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_find_field_0:
.Ltype_find_field_1:
    pushl -40(%ebp)
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
.Ltype_find_field_4:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Ltype_find_field_5
    pushl -32(%ebp)
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Ltype_find_field_7
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltype_find_field_7:
.Ltype_find_field_8:
.Ltype_find_field_6:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Ltype_find_field_4
.Ltype_find_field_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

