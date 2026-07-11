# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_rv_backend
_g_rv_backend:
    .long ark_str_99
    .long ark_str_100
    .long 4
    .long _rv_emit
    .long _rv_assemble
    .long _rv_link
    .globl _ark_sl_arg_reg_r_r
_ark_sl_arg_reg_r_r:
    .long ark_str_101
    .long ark_str_102
    .long ark_str_103
    .long ark_str_104
    .long ark_str_105
    .long ark_str_106
    .long ark_str_107
    .long ark_str_108
    .section .rdata,"dr"
ark_str_0:
    .asciz "a0"
ark_str_1:
    .asciz "# Ark C Compiler - generated RV32I assembly\n"
ark_str_2:
    .asciz "    .option nopic\n    .text\n"
ark_str_3:
    .asciz "    .section .rodata\n"
ark_str_4:
    .asciz "ark_str_"
ark_str_5:
    .asciz ":\n    .asciz \""
ark_str_6:
    .asciz "\\n"
ark_str_7:
    .asciz "\\t"
ark_str_8:
    .asciz "\\\\"
ark_str_9:
    .asciz "\\\""
ark_str_10:
    .asciz "\"\n"
ark_str_11:
    .asciz "    .text\n"
ark_str_12:
    .asciz "    .data\n"
ark_str_13:
    .asciz "    .globl "
ark_str_14:
    .asciz ":\n    .word "
ark_str_15:
    .asciz "    .text\n"
ark_str_16:
    .asciz "    .globl "
ark_str_17:
    .asciz ":\n"
ark_str_18:
    .asciz "    addi sp, sp, -"
ark_str_19:
    .asciz "\n    sw ra, "
ark_str_20:
    .asciz "(sp)\n    sw s0, "
ark_str_21:
    .asciz "(sp)\n    addi s0, sp, "
ark_str_22:
    .asciz "    sw "
ark_str_23:
    .asciz ", -"
ark_str_24:
    .asciz "(s0)\n"
ark_str_25:
    .asciz "    li t0, "
ark_str_26:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_27:
    .asciz "    la t0, ark_str_"
ark_str_28:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_29:
    .asciz "    lw t0, -"
ark_str_30:
    .asciz "(s0)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_31:
    .asciz "    addi t0, s0, -"
ark_str_32:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_33:
    .asciz "    la t1, "
ark_str_34:
    .asciz "\n    lw t0, 0(t1)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_35:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    la t1, "
ark_str_36:
    .asciz "\n    sw t0, 0(t1)\n"
ark_str_37:
    .asciz "    addi sp, sp, 4\n"
ark_str_38:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_39:
    .asciz "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    sw t1, 0(sp)\n    sw t0, 4(sp)\n"
ark_str_40:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    sw t0, -"
ark_str_41:
    .asciz "(s0)\n"
ark_str_42:
    .asciz "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 8\n"
ark_str_43:
    .asciz "    add t0, t0, t1\n    lb t0, 0(t0)\n"
ark_str_44:
    .asciz "    li t2, "
ark_str_45:
    .asciz "\n    mul t1, t1, t2\n    add t0, t0, t1\n    lw t0, 0(t0)\n"
ark_str_46:
    .asciz "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_47:
    .asciz "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n"
ark_str_48:
    .asciz "    sb t0, 0(t1)\n"
ark_str_49:
    .asciz "    sw t0, 0(t1)\n"
ark_str_50:
    .asciz "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_51:
    .asciz "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n"
ark_str_52:
    .asciz "    add t0, t0, t1\n"
ark_str_53:
    .asciz "    sub t0, t0, t1\n"
ark_str_54:
    .asciz "    mul t0, t0, t1\n"
ark_str_55:
    .asciz "    div t0, t0, t1\n"
ark_str_56:
    .asciz "    rem t0, t0, t1\n"
ark_str_57:
    .asciz "    and t0, t0, t1\n"
ark_str_58:
    .asciz "    or t0, t0, t1\n"
ark_str_59:
    .asciz "    xor t0, t0, t1\n"
ark_str_60:
    .asciz "    sll t0, t0, t1\n"
ark_str_61:
    .asciz "    sra t0, t0, t1\n"
ark_str_62:
    .asciz "    sub t0, t0, t1\n    seqz t0, t0\n"
ark_str_63:
    .asciz "    sub t0, t0, t1\n    snez t0, t0\n"
ark_str_64:
    .asciz "    slt  t0, t0, t1\n"
ark_str_65:
    .asciz "    slt  t0, t1, t0\n"
ark_str_66:
    .asciz "    slt  t0, t1, t0\n    xori t0, t0, 1\n"
ark_str_67:
    .asciz "    slt  t0, t0, t1\n    xori t0, t0, 1\n"
ark_str_68:
    .asciz "    sw t0, 0(sp)\n"
ark_str_69:
    .asciz "    lw t0, 0(sp)\n"
ark_str_70:
    .asciz "    neg t0, t0\n"
ark_str_71:
    .asciz "    not t0, t0\n"
ark_str_72:
    .asciz "    seqz t0, t0\n"
ark_str_73:
    .asciz "    sw t0, 0(sp)\n"
ark_str_74:
    .asciz ".L_"
ark_str_75:
    .asciz ":\n"
ark_str_76:
    .asciz ".LN_"
ark_str_77:
    .asciz ":\n"
ark_str_78:
    .asciz "    j .L_"
ark_str_79:
    .asciz "    j .LN_"
ark_str_80:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    beq t0, x0, .L_"
ark_str_81:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    bne t0, x0, .L_"
ark_str_82:
    .asciz "    lw t0, 0(sp)\n    li t1, "
ark_str_83:
    .asciz "\n    bne t0, t1, 1f\n    addi sp, sp, 4\n    j .L_"
ark_str_84:
    .asciz "\n1:\n"
ark_str_85:
    .asciz "    lw "
ark_str_86:
    .asciz ", 0(sp)\n    addi sp, sp, 4\n"
ark_str_87:
    .asciz "    call "
ark_str_88:
    .asciz "\n    addi sp, sp, -4\n    sw a0, 0(sp)\n"
ark_str_89:
    .asciz "    lw a0, 0(sp)\n    addi sp, sp, 4\n"
ark_str_90:
    .asciz "    lw s0, "
ark_str_91:
    .asciz "(sp)\n    lw ra, "
ark_str_92:
    .asciz "(sp)\n    addi sp, sp, "
ark_str_93:
    .asciz "\n    ret\n"
ark_str_94:
    .asciz "    # unknown\n"
ark_str_95:
    .asciz "    li a0, 0\n    lw s0, "
ark_str_96:
    .asciz "(sp)\n    lw ra, "
ark_str_97:
    .asciz "(sp)\n    addi sp, sp, "
ark_str_98:
    .asciz "\n    ret\n\n"
ark_str_99:
    .asciz "riscv32"
ark_str_100:
    .asciz "riscv32-unknown-elf"
ark_str_101:
    .asciz "a0"
ark_str_102:
    .asciz "a1"
ark_str_103:
    .asciz "a2"
ark_str_104:
    .asciz "a3"
ark_str_105:
    .asciz "a4"
ark_str_106:
    .asciz "a5"
ark_str_107:
    .asciz "a6"
ark_str_108:
    .asciz "a7"
    .text
_arg_reg_r:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Larg_reg_r_2
    pushl -24(%ebp)
    pushl $8
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
    jmp .Larg_reg_r_3
.Larg_reg_r_2:
    pushl $1
.Larg_reg_r_3:
    popl %eax
    cmpl $0, %eax
    je .Larg_reg_r_0
    leal ark_str_0, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Larg_reg_r_0:
.Larg_reg_r_1:
    movl $_ark_sl_arg_reg_r_r, %eax
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
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_rv_emit:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -128(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -120(%ebp)
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_init
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_1, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_2, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -136(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_0
    leal ark_str_3, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lrv_emit_2:
    pushl -88(%ebp)
    pushl -136(%ebp)
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
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_3
    pushl -136(%ebp)
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
    pushl -88(%ebp)
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
    movl %eax, -80(%ebp)
    leal ark_str_4, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_5, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
.Lrv_emit_5:
    pushl -72(%ebp)
    pushl -80(%ebp)
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
    je .Lrv_emit_6
    pushl -80(%ebp)
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
    pushl -72(%ebp)
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
    movb %al, -64(%ebp)
    movzbl -64(%ebp), %eax
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
    je .Lrv_emit_8
    leal ark_str_6, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_9
.Lrv_emit_8:
    movzbl -64(%ebp), %eax
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
    je .Lrv_emit_10
    leal ark_str_7, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_11
.Lrv_emit_10:
    movzbl -64(%ebp), %eax
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
    je .Lrv_emit_12
    leal ark_str_8, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_13
.Lrv_emit_12:
    movzbl -64(%ebp), %eax
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
    je .Lrv_emit_14
    leal ark_str_9, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_15
.Lrv_emit_14:
    movzbl -64(%ebp), %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_15:
.Lrv_emit_13:
.Lrv_emit_11:
.Lrv_emit_9:
.Lrv_emit_7:
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
    jmp .Lrv_emit_5
.Lrv_emit_6:
    leal ark_str_10, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_4:
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
    jmp .Lrv_emit_2
.Lrv_emit_3:
    leal ark_str_11, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_1
.Lrv_emit_0:
.Lrv_emit_1:
    pushl -136(%ebp)
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
    je .Lrv_emit_16
    leal ark_str_12, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_17
.Lrv_emit_16:
.Lrv_emit_17:
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Lrv_emit_18:
    pushl -88(%ebp)
    pushl -136(%ebp)
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
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_19
    pushl -136(%ebp)
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
    pushl -88(%ebp)
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
    movl %eax, -80(%ebp)
    leal ark_str_13, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_14, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -80(%ebp)
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
    je .Lrv_emit_21
    pushl -80(%ebp)
    pushl $24
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
    jmp .Lrv_emit_22
.Lrv_emit_21:
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
.Lrv_emit_22:
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_20:
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
    jmp .Lrv_emit_18
.Lrv_emit_19:
    pushl -136(%ebp)
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
    je .Lrv_emit_23
    leal ark_str_15, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_24
.Lrv_emit_23:
.Lrv_emit_24:
    pushl $0
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Lrv_emit_25:
    pushl -96(%ebp)
    pushl -136(%ebp)
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
    je .Lrv_emit_26
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
    pushl -96(%ebp)
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
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
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
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $15
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $15
    popl %eax
    notl %eax
    pushl %eax
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $256
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    leal ark_str_16, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_17, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_18, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_19, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_20, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_21, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Lrv_emit_28:
    pushl -80(%ebp)
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
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_29
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
    pushl -80(%ebp)
    pushl $32
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
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
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_32
    pushl -48(%ebp)
    pushl $17
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_33
    pushl -48(%ebp)
    pushl $20
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_34
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
    jne .Lrv_emit_35
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
    jne .Lrv_emit_36
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
    jne .Lrv_emit_37
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
    jne .Lrv_emit_38
    pushl -48(%ebp)
    pushl $22
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_39
    pushl -48(%ebp)
    pushl $23
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_40
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
    jne .Lrv_emit_41
    pushl -48(%ebp)
    pushl $24
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_42
    pushl -48(%ebp)
    pushl $56
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_43
    pushl -48(%ebp)
    pushl $57
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_44
    pushl -48(%ebp)
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_45
    pushl -48(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_46
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
    jne .Lrv_emit_47
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
    jne .Lrv_emit_48
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
    jne .Lrv_emit_49
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
    jne .Lrv_emit_50
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
    jne .Lrv_emit_51
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
    jne .Lrv_emit_52
    pushl -48(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_53
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
    jne .Lrv_emit_54
    pushl -48(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_55
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
    jne .Lrv_emit_56
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
    jne .Lrv_emit_57
    pushl -48(%ebp)
    pushl $27
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_58
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
    jne .Lrv_emit_59
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
    jne .Lrv_emit_60
    jmp .Lrv_emit_61
.Lrv_emit_32:
.Lrv_emit_33:
    jmp .Lrv_emit_31
.Lrv_emit_34:
    leal ark_str_22, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    call _arg_reg_r
    addl $4, %esp
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_23, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_24, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_35:
    leal ark_str_25, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_26, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_36:
    leal ark_str_27, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_28, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_37:
    leal ark_str_29, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_30, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_38:
    leal ark_str_31, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_32, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_39:
    leal ark_str_33, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_34, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_40:
    leal ark_str_35, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_36, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_41:
    leal ark_str_37, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_42:
    leal ark_str_38, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_43:
    leal ark_str_39, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_44:
.Lrv_emit_45:
.Lrv_emit_46:
    jmp .Lrv_emit_31
.Lrv_emit_47:
    leal ark_str_40, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    pushl -56(%ebp)
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
    popl %ecx
    popl %eax
    addl %eax, 4(%esp)
    adcl %ecx, (%esp)
    popl %edx
    popl %eax
    pushl %eax
    pushl %edx
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_41, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_48:
    leal ark_str_42, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    jne .L64f_rv_emit_773
    cmpl %eax, (%esp)
    jne .L64f_rv_emit_773
    addl $4, %esp
    pushl $1
    jmp .L64e_rv_emit_773
.L64f_rv_emit_773:
    addl $4, %esp
    pushl $0
.L64e_rv_emit_773:
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_62
    leal ark_str_43, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_63
.Lrv_emit_62:
    leal ark_str_44, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_45, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_63:
    leal ark_str_46, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_49:
    leal ark_str_47, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    jne .L64f_rv_emit_819
    cmpl %eax, (%esp)
    jne .L64f_rv_emit_819
    addl $4, %esp
    pushl $1
    jmp .L64e_rv_emit_819
.L64f_rv_emit_819:
    addl $4, %esp
    pushl $0
.L64e_rv_emit_819:
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_64
    leal ark_str_48, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_65
.Lrv_emit_64:
    leal ark_str_49, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_65:
    leal ark_str_50, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_50:
    leal ark_str_51, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    jne .Lrv_emit_67
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
    jne .Lrv_emit_68
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
    jne .Lrv_emit_69
    pushl -40(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_70
    pushl -40(%ebp)
    pushl $19
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_71
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
    jne .Lrv_emit_72
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
    jne .Lrv_emit_73
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
    jne .Lrv_emit_74
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
    jne .Lrv_emit_75
    pushl -40(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_76
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
    jne .Lrv_emit_77
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
    jne .Lrv_emit_78
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
    jne .Lrv_emit_79
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
    jne .Lrv_emit_80
    pushl -40(%ebp)
    pushl $25
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_81
    pushl -40(%ebp)
    pushl $26
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lrv_emit_82
    jmp .Lrv_emit_83
.Lrv_emit_67:
    leal ark_str_52, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_68:
    leal ark_str_53, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_69:
    leal ark_str_54, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_70:
    leal ark_str_55, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_71:
    leal ark_str_56, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_72:
    leal ark_str_57, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_73:
    leal ark_str_58, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_74:
    leal ark_str_59, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_75:
    leal ark_str_60, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_76:
    leal ark_str_61, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_77:
    leal ark_str_62, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_78:
    leal ark_str_63, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_79:
    leal ark_str_64, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_80:
    leal ark_str_65, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_81:
    leal ark_str_66, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_82:
    leal ark_str_67, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_66
.Lrv_emit_83:
    jmp .Lrv_emit_66
.Lrv_emit_66:
    leal ark_str_68, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_51:
    leal ark_str_69, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    pushl $16
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_84
    leal ark_str_70, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_85
.Lrv_emit_84:
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
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_86
    leal ark_str_71, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_87
.Lrv_emit_86:
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
    pushl $29
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_88
    leal ark_str_72, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_89
.Lrv_emit_88:
.Lrv_emit_89:
.Lrv_emit_87:
.Lrv_emit_85:
    leal ark_str_73, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_52:
    leal ark_str_74, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_75, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_53:
    leal ark_str_76, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_77, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_54:
    leal ark_str_78, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_55:
    leal ark_str_79, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_56:
    leal ark_str_80, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_57:
    leal ark_str_81, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl $10
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_58:
    leal ark_str_82, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_83, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $95
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_putc
    addl $8, %esp
    pushl %eax
    addl $4, %esp
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
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_84, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_59:
    pushl -56(%ebp)
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
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lrv_emit_90:
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
    je .Lrv_emit_93
    pushl -24(%ebp)
    pushl $8
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
    jmp .Lrv_emit_94
.Lrv_emit_93:
    pushl $0
.Lrv_emit_94:
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_91
    leal ark_str_85, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    call _arg_reg_r
    addl $4, %esp
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_86, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_92:
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
    jmp .Lrv_emit_90
.Lrv_emit_91:
    leal ark_str_87, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -56(%ebp)
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
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_88, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_60:
    leal ark_str_89, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_90, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_91, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_92, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_93, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_61:
    leal ark_str_94, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lrv_emit_31
.Lrv_emit_31:
.Lrv_emit_30:
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
    jmp .Lrv_emit_28
.Lrv_emit_29:
    leal ark_str_95, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_96, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_97, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -64(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_int
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_98, %eax
    pushl %eax
    leal -112(%ebp), %eax
    pushl %eax
    call _asmbuf_puts
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lrv_emit_27:
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
    jmp .Lrv_emit_25
.Lrv_emit_26:
    leal -112(%ebp), %eax
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
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_95
    pushl -120(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Lrv_emit_96
.Lrv_emit_95:
.Lrv_emit_96:
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Lrv_emit_97:
    pushl -80(%ebp)
    pushl -88(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_emit_98
    pushl -128(%ebp)
    pushl -80(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl -80(%ebp)
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
.Lrv_emit_99:
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
    jmp .Lrv_emit_97
.Lrv_emit_98:
    pushl -128(%ebp)
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
    pushl -88(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_rv_assemble:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
    call _ark_strlen
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setg %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lrv_assemble_0
    pushl -40(%ebp)
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lrv_assemble_1
.Lrv_assemble_0:
.Lrv_assemble_1:
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lrv_assemble_2:
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
    je .Lrv_assemble_3
    pushl -48(%ebp)
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
    pushl -56(%ebp)
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
.Lrv_assemble_4:
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
    jmp .Lrv_assemble_2
.Lrv_assemble_3:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_rv_link:
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
    addl $4, %esp
    pushl -32(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
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

    .globl _ark_backend_riscv32
_ark_backend_riscv32:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl $_g_rv_backend, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

