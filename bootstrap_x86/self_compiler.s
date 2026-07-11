# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_src
_g_src:
    .zero 1048576
    .globl _g_asm
_g_asm:
    .zero 8388608
    .globl _g_code
_g_code:
    .zero 4194304
    .globl _ark_sl_ark_compile_out_buf
_ark_sl_ark_compile_out_buf:
    .zero 262144
    .globl _ark_sl_ark_compile_name_buf
_ark_sl_ark_compile_name_buf:
    .zero 256
    .globl _ark_sl_ark_compile_dep_buf
_ark_sl_ark_compile_dep_buf:
    .zero 8192
    .globl _ark_sl_ark_compile_obj_buf
_ark_sl_ark_compile_obj_buf:
    .zero 8388624
    .section .rdata,"dr"
ark_str_0:
    .asciz "[arkcc] cannot write output '%s'\n"
ark_str_1:
    .asciz "[arkcc] cannot write output '%s'\n"
ark_str_2:
    .asciz "a.out.c"
ark_str_3:
    .asciz "[arkcc] cannot read object '%s'\n"
ark_str_4:
    .asciz "[arkcc] link output too large\n"
ark_str_5:
    .asciz "[arkcc] cannot write link output '%s'\n"
ark_str_6:
    .asciz "[arkcc] linked %d objects -> %s\n"
ark_str_7:
    .asciz "(null)"
ark_str_8:
    .asciz "[arkcc] unknown target '%s'\n"
ark_str_9:
    .asciz "[arkcc] cannot read '%s'\n"
ark_str_10:
    .asciz "-"
ark_str_11:
    .asciz "nul"
ark_str_12:
    .asciz "NUL"
ark_str_13:
    .asciz "-"
ark_str_14:
    .asciz "-"
ark_str_15:
    .asciz "[arkcc] assembly of '%s' failed\n"
ark_str_16:
    .asciz "[arkcc] assembled .s: %d bytes\n"
ark_str_17:
    .asciz ".bin"
ark_str_18:
    .asciz "stdlib/include"
ark_str_19:
    .asciz "[arkcc] unknown CPU '%s' (supported: Cortex-M0/M0+/M1/M3/M4/M7/M23/M33)\n"
ark_str_20:
    .asciz "[arkcc] cpu=%s arch_m=%d dsp=%d fpu=%d\n"
ark_str_21:
    .asciz "1"
ark_str_22:
    .asciz "[arkcc] cannot read '%s'\n"
ark_str_23:
    .asciz "[arkcc] cannot write dependency file '%s'\n"
ark_str_24:
    .asciz "[arkcc] wrote dependency file '%s' (%d includes)\n"
ark_str_25:
    .asciz "-"
ark_str_26:
    .asciz "-"
ark_str_27:
    .asciz "-"
ark_str_28:
    .asciz "(null)"
ark_str_29:
    .asciz "[arkcc] unknown target '%s'\n"
ark_str_30:
    .asciz "[arkcc] target=%s, source=%d bytes\n"
ark_str_31:
    .asciz "[arkcc] parse failed\n"
ark_str_32:
    .asciz "[arkcc] %d semantic error(s)\n"
ark_str_33:
    .asciz "arm"
ark_str_34:
    .asciz "[arkcc] assembly failed\n"
ark_str_35:
    .asciz ".ark_obj"
ark_str_36:
    .asciz "ARKOBJ2\n"
ark_str_37:
    .asciz "[arkcc] object output too large for buffer\n"
ark_str_38:
    .asciz "arm"
ark_str_39:
    .asciz "arm"
ark_str_40:
    .asciz "arm"
ark_str_41:
    .asciz "arm"
ark_str_42:
    .asciz "arm"
ark_str_43:
    .asciz "[arkcc] wrote object '%s' (%d bytes code, %d syms, %d relocs)\n"
ark_str_44:
    .asciz "-"
ark_str_45:
    .asciz "nul"
ark_str_46:
    .asciz "NUL"
ark_str_47:
    .asciz "nul"
ark_str_48:
    .asciz "NUL"
ark_str_49:
    .asciz "-"
ark_str_50:
    .asciz "[arkcc] assembly failed\n"
ark_str_51:
    .asciz "[arkcc] assembled: %d bytes\n"
ark_str_52:
    .asciz ".bin"
ark_str_53:
    .asciz "c"
ark_str_54:
    .asciz ".gen.c"
ark_str_55:
    .asciz "[arkcc] failed to derive output name\n"
    .text
_derive_output:
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
    pushl -88(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -64(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lderive_output_2
    pushl -56(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
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
    jmp .Lderive_output_3
.Lderive_output_2:
    pushl $1
.Lderive_output_3:
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_0
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_output_0:
.Lderive_output_1:
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
.Lderive_output_4:
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
    je .Lderive_output_5
    pushl -88(%ebp)
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lderive_output_9
    pushl -88(%ebp)
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
    jmp .Lderive_output_10
.Lderive_output_9:
    pushl $1
.Lderive_output_10:
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_7
    jmp .Lderive_output_5
.Lderive_output_7:
.Lderive_output_8:
    pushl -88(%ebp)
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_11
    pushl -40(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lderive_output_5
.Lderive_output_11:
.Lderive_output_12:
.Lderive_output_6:
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
    jmp .Lderive_output_4
.Lderive_output_5:
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_13
    pushl -56(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lderive_output_14
.Lderive_output_13:
.Lderive_output_14:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lderive_output_15:
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
    je .Lderive_output_18
    pushl -24(%ebp)
    pushl -72(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
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
    jmp .Lderive_output_19
.Lderive_output_18:
    pushl $0
.Lderive_output_19:
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_16
    pushl -80(%ebp)
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
    pushl -88(%ebp)
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
.Lderive_output_17:
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
    jmp .Lderive_output_15
.Lderive_output_16:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lderive_output_20:
    pushl -24(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_23
    pushl -32(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
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
    jmp .Lderive_output_24
.Lderive_output_23:
    pushl $0
.Lderive_output_24:
    popl %eax
    cmpl $0, %eax
    je .Lderive_output_21
    pushl -80(%ebp)
    pushl -32(%ebp)
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
.Lderive_output_22:
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
    jmp .Lderive_output_20
.Lderive_output_21:
    pushl -80(%ebp)
    pushl -32(%ebp)
    pushl -48(%ebp)
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
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_write_binary:
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
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lwrite_binary_0
    pushl -40(%ebp)
    leal ark_str_0, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lwrite_binary_0:
.Lwrite_binary_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_write_text:
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
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lwrite_text_0
    pushl -40(%ebp)
    leal ark_str_1, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lwrite_text_0:
.Lwrite_text_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _ark_compile
_ark_compile:
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
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $4096, %esp
    movl $0, (%esp)
    subl $512, %esp
    movl 8(%ebp), %eax
    movl %eax, -65800(%ebp)
    pushl -65800(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_0
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_0:
.Lark_compile_1:
    pushl -65800(%ebp)
    pushl $88
    popl %ecx
    popl %eax
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
    je .Lark_compile_2
    call _ark_backend_list
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_2:
.Lark_compile_3:
    pushl -65800(%ebp)
    pushl $100
    popl %ecx
    popl %eax
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
    je .Lark_compile_4
    pushl -65800(%ebp)
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
    je .Lark_compile_6
    pushl -65800(%ebp)
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
    jmp .Lark_compile_7
.Lark_compile_6:
    leal ark_str_2, %eax
    pushl %eax
.Lark_compile_7:
    popl %eax
    movl %eax, -65608(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -65600(%ebp)
    pushl -65600(%ebp)
    addl $4, %esp
.Lark_compile_8:
    pushl -65600(%ebp)
    pushl -65800(%ebp)
    pushl $232
    popl %ecx
    popl %eax
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
    je .Lark_compile_9
    pushl $65536
    leal -65592(%ebp), %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65600(%ebp)
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
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_11
    pushl -65800(%ebp)
    pushl $104
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65600(%ebp)
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
    leal ark_str_3, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_11:
.Lark_compile_12:
    leal -65592(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_27
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
    jmp .Lark_compile_28
.Lark_compile_27:
    pushl $0
.Lark_compile_28:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_25
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
    jmp .Lark_compile_26
.Lark_compile_25:
    pushl $0
.Lark_compile_26:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_23
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
    pushl $75
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
    jmp .Lark_compile_24
.Lark_compile_23:
    pushl $0
.Lark_compile_24:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_21
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
    jmp .Lark_compile_22
.Lark_compile_21:
    pushl $0
.Lark_compile_22:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_19
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
    jmp .Lark_compile_20
.Lark_compile_19:
    pushl $0
.Lark_compile_20:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_17
    pushl -32(%ebp)
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
    pushl $74
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
    jmp .Lark_compile_18
.Lark_compile_17:
    pushl $0
.Lark_compile_18:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_15
    pushl -32(%ebp)
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
    jmp .Lark_compile_16
.Lark_compile_15:
    pushl $0
.Lark_compile_16:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_13
    pushl -32(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    pushl $7
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lark_compile_14
.Lark_compile_13:
.Lark_compile_14:
    pushl -65600(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_29
.Lark_compile_31:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_33
    pushl -32(%ebp)
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
    jne .Lark_compile_35
    pushl -32(%ebp)
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
    jmp .Lark_compile_36
.Lark_compile_35:
    pushl $1
.Lark_compile_36:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lark_compile_34
.Lark_compile_33:
    pushl $0
.Lark_compile_34:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_32
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
    jmp .Lark_compile_31
.Lark_compile_32:
    jmp .Lark_compile_30
.Lark_compile_29:
.Lark_compile_30:
    pushl -56(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $262144
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_37
    leal ark_str_4, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_37:
.Lark_compile_38:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_compile_39:
    pushl -24(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_40
    movl $_ark_sl_ark_compile_out_buf, %eax
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
.Lark_compile_41:
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
    jmp .Lark_compile_39
.Lark_compile_40:
    movl $_ark_sl_ark_compile_out_buf, %eax
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
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $10
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lark_compile_10:
    pushl -65600(%ebp)
    pushl -65600(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65600(%ebp)
    addl $4, %esp
    jmp .Lark_compile_8
.Lark_compile_9:
    pushl -56(%ebp)
    movl $_ark_sl_ark_compile_out_buf, %eax
    pushl %eax
    pushl -65608(%ebp)
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_42
    pushl -65608(%ebp)
    leal ark_str_5, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_42:
.Lark_compile_43:
    pushl -65800(%ebp)
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
    je .Lark_compile_44
    pushl -65608(%ebp)
    pushl -65800(%ebp)
    pushl $232
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_6, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_45
.Lark_compile_44:
.Lark_compile_45:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_4:
.Lark_compile_5:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_46
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_46:
.Lark_compile_47:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    movl %eax, -65608(%ebp)
    pushl -65608(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_50
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -65608(%ebp)
    pushl $2
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_52
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -65608(%ebp)
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
    pushl $115
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lark_compile_54
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -65608(%ebp)
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
    jmp .Lark_compile_55
.Lark_compile_54:
    pushl $1
.Lark_compile_55:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lark_compile_53
.Lark_compile_52:
    pushl $0
.Lark_compile_53:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lark_compile_51
.Lark_compile_50:
    pushl $0
.Lark_compile_51:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_48
    pushl -65800(%ebp)
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
    je .Lark_compile_56
    pushl -65800(%ebp)
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
    call _ark_backend_find
    addl $4, %esp
    pushl %eax
    jmp .Lark_compile_57
.Lark_compile_56:
    call _ark_backend_default
    pushl %eax
.Lark_compile_57:
    popl %eax
    movl %eax, -65584(%ebp)
    pushl -65584(%ebp)
    addl $4, %esp
    pushl -65584(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_58
    pushl -65800(%ebp)
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
    je .Lark_compile_60
    pushl -65800(%ebp)
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
    jmp .Lark_compile_61
.Lark_compile_60:
    leal ark_str_7, %eax
    pushl %eax
.Lark_compile_61:
    leal ark_str_8, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_58:
.Lark_compile_59:
    call _mem_pool_reset
    pushl %eax
    addl $4, %esp
    pushl $8388608
    movl $_g_asm, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65600(%ebp)
    pushl -65600(%ebp)
    addl $4, %esp
    pushl -65600(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_62
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_9, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_62:
.Lark_compile_63:
    movl $_g_asm, %eax
    pushl %eax
    pushl -65600(%ebp)
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
    movl $_g_asm, %eax
    pushl %eax
    popl %eax
    movl %eax, -65576(%ebp)
    pushl -65576(%ebp)
    addl $4, %esp
    pushl -65800(%ebp)
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
    je .Lark_compile_64
    pushl -65800(%ebp)
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
    je .Lark_compile_72
    leal ark_str_10, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_73
.Lark_compile_72:
    pushl $0
.Lark_compile_73:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_70
    leal ark_str_11, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_71
.Lark_compile_70:
    pushl $0
.Lark_compile_71:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_68
    leal ark_str_12, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_69
.Lark_compile_68:
    pushl $0
.Lark_compile_69:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_66
    pushl -65576(%ebp)
    pushl -65800(%ebp)
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
    call _write_text
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_66:
    pushl -65800(%ebp)
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
    jne .Lark_compile_76
    leal ark_str_13, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    jmp .Lark_compile_77
.Lark_compile_76:
    pushl $1
.Lark_compile_77:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_74
    pushl -65600(%ebp)
    pushl -65576(%ebp)
    leal ark_str_14, %eax
    pushl %eax
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -65600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_78
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_78:
.Lark_compile_79:
    jmp .Lark_compile_75
.Lark_compile_74:
.Lark_compile_75:
.Lark_compile_67:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_64:
.Lark_compile_65:
    pushl $4194304
    movl $_g_code, %eax
    pushl %eax
    pushl -65576(%ebp)
    pushl -65584(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65592(%ebp)
    pushl -65592(%ebp)
    addl $4, %esp
    pushl -65592(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_80
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_15, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $7
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_80:
.Lark_compile_81:
    pushl -65584(%ebp)
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
    je .Lark_compile_82
    pushl $0
    pushl -65592(%ebp)
    movl $_g_code, %eax
    pushl %eax
    pushl -65584(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65568(%ebp)
    pushl -65568(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_84
    pushl $8
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_84:
.Lark_compile_85:
    jmp .Lark_compile_83
.Lark_compile_82:
.Lark_compile_83:
    pushl -65800(%ebp)
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
    je .Lark_compile_86
    pushl -65592(%ebp)
    leal ark_str_16, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_87
.Lark_compile_86:
.Lark_compile_87:
    pushl -65800(%ebp)
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
    je .Lark_compile_88
    pushl -65800(%ebp)
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
    movl %eax, -65056(%ebp)
    pushl -65056(%ebp)
    addl $4, %esp
    jmp .Lark_compile_89
.Lark_compile_88:
    leal ark_str_17, %eax
    pushl %eax
    pushl $512
    leal -65568(%ebp), %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _derive_output
    addl $16, %esp
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
    je .Lark_compile_90
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_90:
.Lark_compile_91:
    leal -65568(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -65056(%ebp)
    pushl -65056(%ebp)
    addl $4, %esp
.Lark_compile_89:
    pushl -65592(%ebp)
    movl $_g_code, %eax
    pushl %eax
    pushl -65056(%ebp)
    call _write_binary
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_48:
.Lark_compile_49:
    call _mem_pool_reset
    pushl %eax
    addl $4, %esp
    call _preproc_reset
    pushl %eax
    addl $4, %esp
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _preproc_set_main_file
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -65616(%ebp)
    pushl -65616(%ebp)
    addl $4, %esp
.Lark_compile_92:
    pushl -65616(%ebp)
    pushl -65800(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_93
    pushl -65800(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65616(%ebp)
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
    call _preproc_add_include_dir
    addl $4, %esp
    pushl %eax
    addl $4, %esp
.Lark_compile_94:
    pushl -65616(%ebp)
    pushl -65616(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65616(%ebp)
    addl $4, %esp
    jmp .Lark_compile_92
.Lark_compile_93:
    leal ark_str_18, %eax
    pushl %eax
    call _preproc_add_include_dir
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -65800(%ebp)
    pushl $248
    popl %ecx
    popl %eax
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
    je .Lark_compile_95
    pushl -65800(%ebp)
    pushl $248
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _cpu_lookup
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65608(%ebp)
    pushl -65608(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_97
    pushl -65800(%ebp)
    pushl $248
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_19, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_97:
.Lark_compile_98:
    pushl -65608(%ebp)
    call _cpu_apply_predefines
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -65608(%ebp)
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
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_99
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
    jmp .Lark_compile_100
.Lark_compile_99:
.Lark_compile_100:
    pushl -65800(%ebp)
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
    je .Lark_compile_101
    pushl -65608(%ebp)
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
    pushl -65608(%ebp)
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
    pushl -65608(%ebp)
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
    pushl -65608(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_20, %eax
    pushl %eax
    call _ark_log
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_102
.Lark_compile_101:
.Lark_compile_102:
    jmp .Lark_compile_96
.Lark_compile_95:
.Lark_compile_96:
    pushl $0
    popl %eax
    movl %eax, -65616(%ebp)
    pushl -65616(%ebp)
    addl $4, %esp
.Lark_compile_103:
    pushl -65616(%ebp)
    pushl -65800(%ebp)
    pushl $528
    popl %ecx
    popl %eax
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
    je .Lark_compile_104
    pushl -65800(%ebp)
    pushl $272
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65616(%ebp)
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
    movl %eax, -65608(%ebp)
    pushl $0
    popl %eax
    movl %eax, -65600(%ebp)
    pushl $0
    popl %eax
    movl %eax, -65592(%ebp)
    pushl -65592(%ebp)
    addl $4, %esp
.Lark_compile_106:
    pushl -65608(%ebp)
    pushl -65592(%ebp)
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
    je .Lark_compile_107
    pushl -65608(%ebp)
    pushl -65592(%ebp)
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
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_109
    pushl -65608(%ebp)
    pushl -65592(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65600(%ebp)
    pushl -65600(%ebp)
    addl $4, %esp
    jmp .Lark_compile_107
.Lark_compile_109:
.Lark_compile_110:
.Lark_compile_108:
    pushl -65592(%ebp)
    pushl -65592(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65592(%ebp)
    addl $4, %esp
    jmp .Lark_compile_106
.Lark_compile_107:
    pushl -65600(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_111
    pushl -65600(%ebp)
    pushl -65608(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65584(%ebp)
    pushl -65584(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_113
    pushl $255
    popl %eax
    movl %eax, -65584(%ebp)
    pushl -65584(%ebp)
    addl $4, %esp
    jmp .Lark_compile_114
.Lark_compile_113:
.Lark_compile_114:
    pushl $0
    popl %eax
    movl %eax, -65576(%ebp)
    pushl -65576(%ebp)
    addl $4, %esp
.Lark_compile_115:
    pushl -65576(%ebp)
    pushl -65584(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_116
    movl $_ark_sl_ark_compile_name_buf, %eax
    pushl %eax
    pushl -65576(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65608(%ebp)
    pushl -65576(%ebp)
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
.Lark_compile_117:
    pushl -65576(%ebp)
    pushl -65576(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65576(%ebp)
    addl $4, %esp
    jmp .Lark_compile_115
.Lark_compile_116:
    movl $_ark_sl_ark_compile_name_buf, %eax
    pushl %eax
    pushl -65584(%ebp)
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
    pushl -65600(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movl $_ark_sl_ark_compile_name_buf, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_112
.Lark_compile_111:
    leal ark_str_21, %eax
    pushl %eax
    pushl -65608(%ebp)
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lark_compile_112:
.Lark_compile_105:
    pushl -65616(%ebp)
    pushl -65616(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65616(%ebp)
    addl $4, %esp
    jmp .Lark_compile_103
.Lark_compile_104:
    pushl -65800(%ebp)
    pushl $260
    popl %ecx
    popl %eax
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
    je .Lark_compile_118
    movl $_g_config, %eax
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
    jmp .Lark_compile_119
.Lark_compile_118:
.Lark_compile_119:
    pushl $1048576
    movl $_g_src, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _fs_read_file
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65792(%ebp)
    pushl -65792(%ebp)
    addl $4, %esp
    pushl -65792(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_120
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_22, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_120:
.Lark_compile_121:
    movl $_g_src, %eax
    pushl %eax
    call _preproc_process
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65648(%ebp)
    pushl -65648(%ebp)
    addl $4, %esp
    pushl -65800(%ebp)
    pushl $252
    popl %ecx
    popl %eax
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
    je .Lark_compile_122
    pushl $64
    leal -65608(%ebp), %eax
    pushl %eax
    call _preproc_get_included_files
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -65352(%ebp)
    pushl -65800(%ebp)
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
    je .Lark_compile_124
    pushl -65800(%ebp)
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
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_126:
    pushl -64296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_127
    pushl -65800(%ebp)
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
    pushl -64296(%ebp)
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lark_compile_131
    pushl -65800(%ebp)
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
    pushl -64296(%ebp)
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
    jmp .Lark_compile_132
.Lark_compile_131:
    pushl $1
.Lark_compile_132:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_129
    jmp .Lark_compile_127
.Lark_compile_129:
.Lark_compile_130:
    pushl -65800(%ebp)
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
    pushl -64296(%ebp)
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_133
    pushl -64296(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_127
.Lark_compile_133:
.Lark_compile_134:
.Lark_compile_128:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_126
.Lark_compile_127:
    pushl -64304(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_135
    pushl -64312(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_136
.Lark_compile_135:
.Lark_compile_136:
    pushl $0
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_137:
    pushl -64296(%ebp)
    pushl -64304(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_140
    pushl -64296(%ebp)
    pushl $509
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
    jmp .Lark_compile_141
.Lark_compile_140:
    pushl $0
.Lark_compile_141:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_138
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    pushl -64296(%ebp)
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
.Lark_compile_139:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_137
.Lark_compile_138:
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl -65800(%ebp)
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
    je .Lark_compile_142
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $46
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl $115
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $2
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
    jmp .Lark_compile_143
.Lark_compile_142:
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $46
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl $111
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $2
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
.Lark_compile_143:
    jmp .Lark_compile_125
.Lark_compile_124:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    movl %eax, -64312(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_144:
    pushl -64296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_145
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lark_compile_149
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    jmp .Lark_compile_150
.Lark_compile_149:
    pushl $1
.Lark_compile_150:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_147
    jmp .Lark_compile_145
.Lark_compile_147:
.Lark_compile_148:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_151
    pushl -64296(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_145
.Lark_compile_151:
.Lark_compile_152:
.Lark_compile_146:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_144
.Lark_compile_145:
    pushl -64304(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_153
    pushl -64312(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_154
.Lark_compile_153:
.Lark_compile_154:
    pushl $0
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_155:
    pushl -64296(%ebp)
    pushl -64304(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_158
    pushl -64296(%ebp)
    pushl $509
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
    jmp .Lark_compile_159
.Lark_compile_158:
    pushl $0
.Lark_compile_159:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_156
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
.Lark_compile_157:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_155
.Lark_compile_156:
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $46
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl $111
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $2
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
.Lark_compile_125:
    pushl -65800(%ebp)
    pushl $256
    popl %ecx
    popl %eax
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
    je .Lark_compile_160
    pushl -65800(%ebp)
    pushl $256
    popl %ecx
    popl %eax
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
    movl %eax, -64832(%ebp)
    pushl -64832(%ebp)
    addl $4, %esp
    jmp .Lark_compile_161
.Lark_compile_160:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    movl %eax, -64312(%ebp)
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_162:
    pushl -64296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_163
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lark_compile_167
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    jmp .Lark_compile_168
.Lark_compile_167:
    pushl $1
.Lark_compile_168:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_165
    jmp .Lark_compile_163
.Lark_compile_165:
.Lark_compile_166:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_169
    pushl -64296(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_163
.Lark_compile_169:
.Lark_compile_170:
.Lark_compile_164:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_162
.Lark_compile_163:
    pushl -64304(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_171
    pushl -64312(%ebp)
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_172
.Lark_compile_171:
.Lark_compile_172:
    pushl $0
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_173:
    pushl -64296(%ebp)
    pushl -64304(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_176
    pushl -64296(%ebp)
    pushl $509
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
    jmp .Lark_compile_177
.Lark_compile_176:
    pushl $0
.Lark_compile_177:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_174
    leal -65344(%ebp), %eax
    pushl %eax
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64296(%ebp)
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
.Lark_compile_175:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_173
.Lark_compile_174:
    leal -65344(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $46
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -65344(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl $100
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -65344(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
    pushl $2
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
    leal -65344(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -64832(%ebp)
    pushl -64832(%ebp)
    addl $4, %esp
.Lark_compile_161:
    pushl $0
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
.Lark_compile_178:
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    je .Lark_compile_181
    pushl -64312(%ebp)
    pushl $8191
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
    jmp .Lark_compile_182
.Lark_compile_181:
    pushl $0
.Lark_compile_182:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_179
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -64824(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
.Lark_compile_180:
    pushl -64304(%ebp)
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_178
.Lark_compile_179:
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
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
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
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
    pushl $0
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
.Lark_compile_183:
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    je .Lark_compile_186
    pushl -64312(%ebp)
    pushl $8191
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
    jmp .Lark_compile_187
.Lark_compile_186:
    pushl $0
.Lark_compile_187:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_184
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -64304(%ebp)
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
.Lark_compile_185:
    pushl -64304(%ebp)
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_183
.Lark_compile_184:
    pushl $0
    popl %eax
    movl %eax, -64304(%ebp)
    pushl -64304(%ebp)
    addl $4, %esp
.Lark_compile_188:
    pushl -64304(%ebp)
    pushl -65352(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_191
    pushl -64312(%ebp)
    pushl $8190
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
    jmp .Lark_compile_192
.Lark_compile_191:
    pushl $0
.Lark_compile_192:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_189
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
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
    pushl $0
    popl %eax
    movl %eax, -64296(%ebp)
    pushl -64296(%ebp)
    addl $4, %esp
.Lark_compile_193:
    leal -65608(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl -64296(%ebp)
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
    je .Lark_compile_196
    pushl -64312(%ebp)
    pushl $8191
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
    jmp .Lark_compile_197
.Lark_compile_196:
    pushl $0
.Lark_compile_197:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_194
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -65608(%ebp), %eax
    pushl %eax
    pushl -64304(%ebp)
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
    pushl -64296(%ebp)
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
.Lark_compile_195:
    pushl -64296(%ebp)
    pushl -64296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64296(%ebp)
    addl $4, %esp
    jmp .Lark_compile_193
.Lark_compile_194:
.Lark_compile_190:
    pushl -64304(%ebp)
    pushl -64304(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64304(%ebp)
    addl $4, %esp
    jmp .Lark_compile_188
.Lark_compile_189:
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64312(%ebp)
    pushl -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64312(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $10
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -64312(%ebp)
    movl $_ark_sl_ark_compile_dep_buf, %eax
    pushl %eax
    pushl -64832(%ebp)
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -64312(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_198
    pushl -64832(%ebp)
    leal ark_str_23, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_198:
.Lark_compile_199:
    pushl -65800(%ebp)
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
    je .Lark_compile_200
    pushl -65352(%ebp)
    pushl -64832(%ebp)
    leal ark_str_24, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_201
.Lark_compile_200:
.Lark_compile_201:
    jmp .Lark_compile_123
.Lark_compile_122:
.Lark_compile_123:
    pushl -65800(%ebp)
    pushl $96
    popl %ecx
    popl %eax
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
    je .Lark_compile_202
    pushl -65800(%ebp)
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
    je .Lark_compile_204
    pushl -65800(%ebp)
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
    jmp .Lark_compile_205
.Lark_compile_204:
    leal ark_str_25, %eax
    pushl %eax
.Lark_compile_205:
    popl %eax
    movl %eax, -65608(%ebp)
    pushl -65648(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65600(%ebp)
    leal ark_str_26, %eax
    pushl %eax
    pushl -65608(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_206
    pushl -65600(%ebp)
    pushl -65648(%ebp)
    leal ark_str_27, %eax
    pushl %eax
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -65600(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_208
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_208:
.Lark_compile_209:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_206:
.Lark_compile_207:
    pushl -65648(%ebp)
    pushl -65608(%ebp)
    call _write_text
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_202:
.Lark_compile_203:
    pushl -65800(%ebp)
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
    je .Lark_compile_210
    pushl -65800(%ebp)
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
    call _ark_backend_find
    addl $4, %esp
    pushl %eax
    jmp .Lark_compile_211
.Lark_compile_210:
    call _ark_backend_default
    pushl %eax
.Lark_compile_211:
    popl %eax
    movl %eax, -65640(%ebp)
    pushl -65640(%ebp)
    addl $4, %esp
    pushl -65640(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_212
    pushl -65800(%ebp)
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
    je .Lark_compile_214
    pushl -65800(%ebp)
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
    jmp .Lark_compile_215
.Lark_compile_214:
    leal ark_str_28, %eax
    pushl %eax
.Lark_compile_215:
    leal ark_str_29, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_212:
.Lark_compile_213:
    pushl -65800(%ebp)
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
    je .Lark_compile_216
    pushl -65792(%ebp)
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_30, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_217
.Lark_compile_216:
.Lark_compile_217:
    pushl -65640(%ebp)
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
    call _type_set_ptr_size
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -65648(%ebp)
    leal -65784(%ebp), %eax
    pushl %eax
    call _lexer_init
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -65784(%ebp), %eax
    pushl %eax
    call _parse_program
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65672(%ebp)
    pushl -65672(%ebp)
    addl $4, %esp
    pushl -65672(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_218
    leal ark_str_31, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $3
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_218:
.Lark_compile_219:
    pushl -65672(%ebp)
    call _sema_check
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65664(%ebp)
    pushl -65664(%ebp)
    addl $4, %esp
    pushl -65664(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_220
    pushl -65664(%ebp)
    leal ark_str_32, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $4
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_220:
.Lark_compile_221:
    pushl -65672(%ebp)
    call _irgen_program
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65656(%ebp)
    pushl -65656(%ebp)
    addl $4, %esp
    pushl -65656(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_222
    pushl $5
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_222:
.Lark_compile_223:
    pushl -65656(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    pushl $8388608
    movl $_g_asm, %eax
    pushl %eax
    pushl -65656(%ebp)
    pushl -65640(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65632(%ebp)
    pushl -65632(%ebp)
    addl $4, %esp
    pushl -65632(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_224
    pushl $6
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_224:
.Lark_compile_225:
    movl $_g_asm, %eax
    pushl %eax
    pushl -65632(%ebp)
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
    pushl -65800(%ebp)
    pushl $92
    popl %ecx
    popl %eax
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
    je .Lark_compile_226
    pushl $0
    popl %eax
    movl %eax, -65088(%ebp)
    pushl -65632(%ebp)
    popl %eax
    movl %eax, -65080(%ebp)
    leal ark_str_33, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_228
    pushl $4194304
    movl $_g_code, %eax
    pushl %eax
    movl $_g_asm, %eax
    pushl %eax
    pushl -65640(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65080(%ebp)
    pushl -65080(%ebp)
    addl $4, %esp
    pushl -65080(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_230
    leal ark_str_34, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $7
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_230:
.Lark_compile_231:
    jmp .Lark_compile_229
.Lark_compile_228:
.Lark_compile_229:
    pushl -65800(%ebp)
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
    je .Lark_compile_232
    pushl -65800(%ebp)
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
    movl %eax, -65096(%ebp)
    pushl -65096(%ebp)
    addl $4, %esp
    jmp .Lark_compile_233
.Lark_compile_232:
    leal ark_str_35, %eax
    pushl %eax
    pushl $512
    leal -65608(%ebp), %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _derive_output
    addl $16, %esp
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
    je .Lark_compile_234
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_234:
.Lark_compile_235:
    leal -65608(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -65096(%ebp)
    pushl -65096(%ebp)
    addl $4, %esp
.Lark_compile_233:
    leal ark_str_36, %eax
    pushl %eax
    popl %eax
    movl %eax, -65072(%ebp)
    pushl $0
    popl %eax
    movl %eax, -65064(%ebp)
    pushl -65064(%ebp)
    addl $4, %esp
.Lark_compile_236:
    pushl -65072(%ebp)
    pushl -65064(%ebp)
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
    je .Lark_compile_237
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl -65064(%ebp)
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
.Lark_compile_238:
    pushl -65064(%ebp)
    pushl -65064(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65064(%ebp)
    addl $4, %esp
    jmp .Lark_compile_236
.Lark_compile_237:
    pushl -65080(%ebp)
    popl %eax
    movl %eax, -65072(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -65080(%ebp)
    pushl -65088(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $8388624
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_239
    leal ark_str_37, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_239:
.Lark_compile_240:
    leal ark_str_38, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_241
    movl $_g_code, %eax
    pushl %eax
    jmp .Lark_compile_242
.Lark_compile_241:
    movl $_g_asm, %eax
    pushl %eax
.Lark_compile_242:
    popl %eax
    movl %eax, -65064(%ebp)
    pushl $0
    popl %eax
    movl %eax, -65072(%ebp)
    pushl -65072(%ebp)
    addl $4, %esp
.Lark_compile_243:
    pushl -65072(%ebp)
    pushl -65080(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_244
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65064(%ebp)
    pushl -65072(%ebp)
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
.Lark_compile_245:
    pushl -65072(%ebp)
    pushl -65072(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65072(%ebp)
    addl $4, %esp
    jmp .Lark_compile_243
.Lark_compile_244:
    leal ark_str_39, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_246
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    call _arm_get_symbol_count
    pushl %eax
    popl %eax
    movl %eax, -65072(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -65064(%ebp)
    pushl -65064(%ebp)
    addl $4, %esp
.Lark_compile_248:
    pushl -65064(%ebp)
    pushl -65072(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_249
    pushl -65064(%ebp)
    call _arm_get_symbol_name
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65056(%ebp)
    pushl -65056(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65048(%ebp)
    pushl -65064(%ebp)
    call _arm_get_symbol_offset
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65040(%ebp)
    pushl -65064(%ebp)
    call _arm_get_symbol_type
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65032(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -65024(%ebp)
    pushl -65024(%ebp)
    addl $4, %esp
.Lark_compile_251:
    pushl -65024(%ebp)
    pushl -65048(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_252
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65056(%ebp)
    pushl -65024(%ebp)
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
.Lark_compile_253:
    pushl -65024(%ebp)
    pushl -65024(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65024(%ebp)
    addl $4, %esp
    jmp .Lark_compile_251
.Lark_compile_252:
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65032(%ebp)
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lark_compile_250:
    pushl -65064(%ebp)
    pushl -65064(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65064(%ebp)
    addl $4, %esp
    jmp .Lark_compile_248
.Lark_compile_249:
    jmp .Lark_compile_247
.Lark_compile_246:
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
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
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
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
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
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
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
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
.Lark_compile_247:
    leal ark_str_40, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_254
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    call _arm_get_reloc_count
    pushl %eax
    popl %eax
    movl %eax, -65072(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65072(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -65064(%ebp)
    pushl -65064(%ebp)
    addl $4, %esp
.Lark_compile_256:
    pushl -65064(%ebp)
    pushl -65072(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_257
    pushl -65064(%ebp)
    call _arm_get_reloc_name
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65056(%ebp)
    pushl -65056(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65048(%ebp)
    pushl -65064(%ebp)
    call _arm_get_reloc_offset
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65040(%ebp)
    pushl -65064(%ebp)
    call _arm_get_reloc_type
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -65032(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65048(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -65024(%ebp)
    pushl -65024(%ebp)
    addl $4, %esp
.Lark_compile_259:
    pushl -65024(%ebp)
    pushl -65048(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_260
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65056(%ebp)
    pushl -65024(%ebp)
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
.Lark_compile_261:
    pushl -65024(%ebp)
    pushl -65024(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65024(%ebp)
    addl $4, %esp
    jmp .Lark_compile_259
.Lark_compile_260:
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65040(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    shrl %cl, %eax
    pushl %eax
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65088(%ebp)
    pushl -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -65032(%ebp)
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lark_compile_258:
    pushl -65064(%ebp)
    pushl -65064(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -65064(%ebp)
    addl $4, %esp
    jmp .Lark_compile_256
.Lark_compile_257:
    jmp .Lark_compile_255
.Lark_compile_254:
.Lark_compile_255:
    pushl -65088(%ebp)
    movl $_ark_sl_ark_compile_obj_buf, %eax
    pushl %eax
    pushl -65096(%ebp)
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -65088(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_262
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_262:
.Lark_compile_263:
    pushl $0
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl -65800(%ebp)
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
    je .Lark_compile_264
    leal ark_str_41, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_266
    call _arm_get_reloc_count
    pushl %eax
    jmp .Lark_compile_267
.Lark_compile_266:
    pushl $0
.Lark_compile_267:
    leal ark_str_42, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_268
    call _arm_get_symbol_count
    pushl %eax
    jmp .Lark_compile_269
.Lark_compile_268:
    pushl $0
.Lark_compile_269:
    pushl -65080(%ebp)
    pushl -65096(%ebp)
    leal ark_str_43, %eax
    pushl %eax
    call _ark_log
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_265
.Lark_compile_264:
.Lark_compile_265:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_226:
.Lark_compile_227:
    pushl -65800(%ebp)
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
    je .Lark_compile_270
    pushl -65800(%ebp)
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
    je .Lark_compile_278
    leal ark_str_44, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_279
.Lark_compile_278:
    pushl $0
.Lark_compile_279:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_276
    leal ark_str_45, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_277
.Lark_compile_276:
    pushl $0
.Lark_compile_277:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_274
    leal ark_str_46, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
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
    jmp .Lark_compile_275
.Lark_compile_274:
    pushl $0
.Lark_compile_275:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_272
    movl $_g_asm, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _write_text
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -65608(%ebp)
    pushl -65608(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_280
    pushl -65608(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_280:
.Lark_compile_281:
    jmp .Lark_compile_273
.Lark_compile_272:
    pushl -65800(%ebp)
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
    je .Lark_compile_284
    leal ark_str_47, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lark_compile_286
    leal ark_str_48, %eax
    pushl %eax
    pushl -65800(%ebp)
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
    jmp .Lark_compile_287
.Lark_compile_286:
    pushl $1
.Lark_compile_287:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lark_compile_285
.Lark_compile_284:
    pushl $0
.Lark_compile_285:
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_282
    jmp .Lark_compile_283
.Lark_compile_282:
    pushl -65632(%ebp)
    movl $_g_asm, %eax
    pushl %eax
    leal ark_str_49, %eax
    pushl %eax
    call _fs_write_file
    addl $12, %esp
    pushl %eax
    pushl -65632(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_288
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_288:
.Lark_compile_289:
.Lark_compile_283:
.Lark_compile_273:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_270:
.Lark_compile_271:
    pushl $4194304
    movl $_g_code, %eax
    pushl %eax
    movl $_g_asm, %eax
    pushl %eax
    pushl -65640(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65624(%ebp)
    pushl -65624(%ebp)
    addl $4, %esp
    pushl -65624(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_290
    leal ark_str_50, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $7
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_290:
.Lark_compile_291:
    pushl -65640(%ebp)
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
    je .Lark_compile_292
    pushl $0
    pushl -65624(%ebp)
    movl $_g_code, %eax
    pushl %eax
    pushl -65640(%ebp)
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
    call *%eax
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -65608(%ebp)
    pushl -65608(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_294
    pushl $8
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_294:
.Lark_compile_295:
    jmp .Lark_compile_293
.Lark_compile_292:
.Lark_compile_293:
    pushl -65800(%ebp)
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
    je .Lark_compile_296
    pushl -65624(%ebp)
    leal ark_str_51, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lark_compile_297
.Lark_compile_296:
.Lark_compile_297:
    pushl -65800(%ebp)
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
    je .Lark_compile_298
    pushl -65800(%ebp)
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
    movl %eax, -65096(%ebp)
    pushl -65096(%ebp)
    addl $4, %esp
    jmp .Lark_compile_299
.Lark_compile_298:
    leal ark_str_52, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    leal ark_str_53, %eax
    pushl %eax
    pushl -65640(%ebp)
    pushl $0
    popl %ecx
    popl %eax
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
    je .Lark_compile_300
    leal ark_str_54, %eax
    pushl %eax
    popl %eax
    movl %eax, -65088(%ebp)
    pushl -65088(%ebp)
    addl $4, %esp
    jmp .Lark_compile_301
.Lark_compile_300:
.Lark_compile_301:
    pushl -65088(%ebp)
    pushl $512
    leal -65608(%ebp), %eax
    pushl %eax
    pushl -65800(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    call _derive_output
    addl $16, %esp
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
    je .Lark_compile_302
    leal ark_str_55, %eax
    pushl %eax
    call _ark_log
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lark_compile_302:
.Lark_compile_303:
    leal -65608(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -65096(%ebp)
    pushl -65096(%ebp)
    addl $4, %esp
.Lark_compile_299:
    pushl -65624(%ebp)
    movl $_g_code, %eax
    pushl %eax
    pushl -65096(%ebp)
    call _write_binary
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

    .globl _ark_compile_and_run
_ark_compile_and_run:
    pushl %ebp
    movl %esp, %ebp
    subl $816, %esp
    movl 8(%ebp), %eax
    movl %eax, -568(%ebp)
    leal -560(%ebp), %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -568(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
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
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_compile_and_run_0:
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_and_run_1
    leal -560(%ebp), %eax
    pushl %eax
    pushl $20
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
.Lark_compile_and_run_2:
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
    jmp .Lark_compile_and_run_0
.Lark_compile_and_run_1:
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $96
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $100
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_compile_and_run_3:
    pushl -24(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_and_run_4
    leal -560(%ebp), %eax
    pushl %eax
    pushl $104
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
.Lark_compile_and_run_5:
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
    jmp .Lark_compile_and_run_3
.Lark_compile_and_run_4:
    leal -560(%ebp), %eax
    pushl %eax
    pushl $232
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $236
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $240
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $244
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $248
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $252
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $256
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $260
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $264
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
    leal -560(%ebp), %eax
    pushl %eax
    pushl $268
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lark_compile_and_run_6:
    pushl -24(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lark_compile_and_run_7
    leal -560(%ebp), %eax
    pushl %eax
    pushl $272
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
.Lark_compile_and_run_8:
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
    jmp .Lark_compile_and_run_6
.Lark_compile_and_run_7:
    leal -560(%ebp), %eax
    pushl %eax
    pushl $528
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
    leal -560(%ebp), %eax
    pushl %eax
    call _ark_compile
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

