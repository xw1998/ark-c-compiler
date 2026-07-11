# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_cpu_table
_g_cpu_table:
    .long ark_str_33
    .long 6
    .long 0
    .long 0
    .long 0
    .long 0
    .long 1
    .long 0
    .long ark_str_34
    .long 6
    .long 0
    .long 0
    .long 0
    .long 0
    .long 1
    .long 0
    .long ark_str_35
    .long 6
    .long 0
    .long 0
    .long 0
    .long 0
    .long 1
    .long 0
    .long ark_str_36
    .long 7
    .long 0
    .long 0
    .long 0
    .long 0
    .long 1
    .long 0
    .long ark_str_37
    .long 7
    .long 1
    .long 1
    .long 1
    .long 0
    .long 1
    .long ark_str_38
    .long ark_str_39
    .long 7
    .long 1
    .long 1
    .long 1
    .long 1
    .long 1
    .long ark_str_40
    .long ark_str_41
    .long 8
    .long 0
    .long 0
    .long 0
    .long 0
    .long 1
    .long 0
    .long ark_str_42
    .long 8
    .long 1
    .long 1
    .long 1
    .long 0
    .long 1
    .long ark_str_43
    .section .rdata,"dr"
ark_str_0:
    .asciz "Cortex-"
ark_str_1:
    .asciz "__TARGET_ARCH_6_M"
ark_str_2:
    .asciz "__TARGET_ARCH_7_M"
ark_str_3:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_4:
    .asciz "__TARGET_ARCH_8_M"
ark_str_5:
    .asciz "__TARGET_ARCH_8_M_BASE"
ark_str_6:
    .asciz "__TARGET_ARCH_8_M_MAIN"
ark_str_7:
    .asciz "__TARGET_FEATURE_DSP"
ark_str_8:
    .asciz "__TARGET_FPU_VFP"
ark_str_9:
    .asciz "__TARGET_FPU_FPV5"
ark_str_10:
    .asciz "__TARGET_FPU_DP"
ark_str_11:
    .asciz "1"
ark_str_12:
    .asciz "__TARGET_ARCH_6_M"
ark_str_13:
    .asciz "1"
ark_str_14:
    .asciz "__TARGET_ARCH_7E_M"
ark_str_15:
    .asciz "1"
ark_str_16:
    .asciz "__TARGET_ARCH_7_M"
ark_str_17:
    .asciz "1"
ark_str_18:
    .asciz "__TARGET_ARCH_8_M_MAIN"
ark_str_19:
    .asciz "1"
ark_str_20:
    .asciz "__TARGET_ARCH_8_M_BASE"
ark_str_21:
    .asciz "1"
ark_str_22:
    .asciz "__TARGET_ARCH_8_M"
ark_str_23:
    .asciz "1"
ark_str_24:
    .asciz "__TARGET_FEATURE_DSP"
ark_str_25:
    .asciz "1"
ark_str_26:
    .asciz "__TARGET_FPU_VFP"
ark_str_27:
    .asciz "1"
ark_str_28:
    .asciz "__TARGET_FPU_FPV5"
ark_str_29:
    .asciz "1"
ark_str_30:
    .asciz "__TARGET_FPU_DP"
ark_str_31:
    .asciz "__TARGET_CPU_NAME"
ark_str_32:
    .asciz "__TARGET_ARCH_M"
ark_str_33:
    .asciz "Cortex-M0"
ark_str_34:
    .asciz "Cortex-M0+"
ark_str_35:
    .asciz "Cortex-M1"
ark_str_36:
    .asciz "Cortex-M3"
ark_str_37:
    .asciz "Cortex-M4"
ark_str_38:
    .asciz "VFPv4-SP"
ark_str_39:
    .asciz "Cortex-M7"
ark_str_40:
    .asciz "VFPv5-D16"
ark_str_41:
    .asciz "Cortex-M23"
ark_str_42:
    .asciz "Cortex-M33"
ark_str_43:
    .asciz "VFPv5-SP"
    .text
_cpu_strcaseeq:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
.Lcpu_strcaseeq_0:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_strcaseeq_2
    pushl -32(%ebp)
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
    jmp .Lcpu_strcaseeq_3
.Lcpu_strcaseeq_2:
    pushl $0
.Lcpu_strcaseeq_3:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_strcaseeq_1
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -24(%ebp)
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -16(%ebp)
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
    je .Lcpu_strcaseeq_6
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
    jmp .Lcpu_strcaseeq_7
.Lcpu_strcaseeq_6:
    pushl $0
.Lcpu_strcaseeq_7:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_strcaseeq_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movb %al, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lcpu_strcaseeq_5
.Lcpu_strcaseeq_4:
.Lcpu_strcaseeq_5:
    movzbl -16(%ebp), %eax
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
    je .Lcpu_strcaseeq_10
    movzbl -16(%ebp), %eax
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
    jmp .Lcpu_strcaseeq_11
.Lcpu_strcaseeq_10:
    pushl $0
.Lcpu_strcaseeq_11:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_strcaseeq_8
    movzbl -16(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movb %al, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lcpu_strcaseeq_9
.Lcpu_strcaseeq_8:
.Lcpu_strcaseeq_9:
    movzbl -24(%ebp), %eax
    pushl %eax
    movzbl -16(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_strcaseeq_12
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_strcaseeq_12:
.Lcpu_strcaseeq_13:
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
    jmp .Lcpu_strcaseeq_0
.Lcpu_strcaseeq_1:
    pushl -40(%ebp)
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
    je .Lcpu_strcaseeq_14
    pushl -32(%ebp)
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
    jmp .Lcpu_strcaseeq_15
.Lcpu_strcaseeq_14:
    pushl $0
.Lcpu_strcaseeq_15:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_cpu_name_matches:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    leal ark_str_0, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl $7
    popl %eax
    movl %eax, -48(%ebp)
    pushl -64(%ebp)
    pushl -72(%ebp)
    call _cpu_strcaseeq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_name_matches_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_name_matches_0:
.Lcpu_name_matches_1:
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lcpu_name_matches_2:
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
    je .Lcpu_name_matches_3
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
    popl %eax
    movb %al, -32(%ebp)
    pushl -64(%ebp)
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
    popl %eax
    movb %al, -24(%ebp)
    movzbl -32(%ebp), %eax
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
    je .Lcpu_name_matches_7
    movzbl -32(%ebp), %eax
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
    jmp .Lcpu_name_matches_8
.Lcpu_name_matches_7:
    pushl $0
.Lcpu_name_matches_8:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_name_matches_5
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movb %al, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lcpu_name_matches_6
.Lcpu_name_matches_5:
.Lcpu_name_matches_6:
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
    je .Lcpu_name_matches_11
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
    jmp .Lcpu_name_matches_12
.Lcpu_name_matches_11:
    pushl $0
.Lcpu_name_matches_12:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_name_matches_9
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $65
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $97
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movb %al, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lcpu_name_matches_10
.Lcpu_name_matches_9:
.Lcpu_name_matches_10:
    movzbl -32(%ebp), %eax
    pushl %eax
    movzbl -24(%ebp), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_name_matches_13
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_name_matches_13:
.Lcpu_name_matches_14:
.Lcpu_name_matches_4:
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
    jmp .Lcpu_name_matches_2
.Lcpu_name_matches_3:
    pushl -64(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    call _cpu_strcaseeq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_name_matches_15
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_name_matches_15:
.Lcpu_name_matches_16:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _cpu_lookup
_cpu_lookup:
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
    jne .Lcpu_lookup_2
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
    jmp .Lcpu_lookup_3
.Lcpu_lookup_2:
    pushl $1
.Lcpu_lookup_3:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_lookup_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_lookup_0:
.Lcpu_lookup_1:
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lcpu_lookup_4:
    pushl -16(%ebp)
    pushl $256
    pushl $32
    popl %ecx
    popl %eax
    cdq
    idivl %ecx
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_lookup_5
    movl $_g_cpu_table, %eax
    pushl %eax
    pushl -16(%ebp)
    pushl $32
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
    call _cpu_name_matches
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_lookup_7
    movl $_g_cpu_table, %eax
    pushl %eax
    pushl -16(%ebp)
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_lookup_7:
.Lcpu_lookup_8:
.Lcpu_lookup_6:
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
    jmp .Lcpu_lookup_4
.Lcpu_lookup_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_int_to_str:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl -72(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lint_to_str_0
    pushl -64(%ebp)
    pushl $0
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
    pushl -72(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lint_to_str_1
.Lint_to_str_0:
    pushl -72(%ebp)
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lint_to_str_1:
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
    je .Lint_to_str_2
    leal -48(%ebp), %eax
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
    pushl $48
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lint_to_str_3
.Lint_to_str_2:
.Lint_to_str_3:
.Lint_to_str_4:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lint_to_str_5
    leal -48(%ebp), %eax
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
    pushl $48
    pushl -24(%ebp)
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
    pushl -24(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    xorl %edx, %edx
    divl %ecx
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lint_to_str_4
.Lint_to_str_5:
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lint_to_str_6:
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
    je .Lint_to_str_7
    pushl -64(%ebp)
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -32(%ebp)
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
    leal -48(%ebp), %eax
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
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lint_to_str_8:
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
    jmp .Lint_to_str_6
.Lint_to_str_7:
    pushl -64(%ebp)
    pushl -56(%ebp)
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

    .globl _cpu_apply_predefines
_cpu_apply_predefines:
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
    je .Lcpu_apply_predefines_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcpu_apply_predefines_0:
.Lcpu_apply_predefines_1:
    leal ark_str_1, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_2, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_3, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_4, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_5, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_6, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_7, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_8, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_9, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_10, %eax
    pushl %eax
    call _preproc_undef
    addl $4, %esp
    pushl %eax
    addl $4, %esp
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
    popl %eax
    movl %eax, -16(%ebp)
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
    jne .Lcpu_apply_predefines_3
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
    jne .Lcpu_apply_predefines_4
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
    jne .Lcpu_apply_predefines_5
    jmp .Lcpu_apply_predefines_6
.Lcpu_apply_predefines_3:
    leal ark_str_11, %eax
    pushl %eax
    leal ark_str_12, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_4:
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
    cmpl $0, %eax
    je .Lcpu_apply_predefines_7
    leal ark_str_13, %eax
    pushl %eax
    leal ark_str_14, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_8
.Lcpu_apply_predefines_7:
    leal ark_str_15, %eax
    pushl %eax
    leal ark_str_16, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcpu_apply_predefines_8:
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_5:
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
    cmpl $0, %eax
    je .Lcpu_apply_predefines_9
    leal ark_str_17, %eax
    pushl %eax
    leal ark_str_18, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_10
.Lcpu_apply_predefines_9:
    leal ark_str_19, %eax
    pushl %eax
    leal ark_str_20, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
.Lcpu_apply_predefines_10:
    leal ark_str_21, %eax
    pushl %eax
    leal ark_str_22, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_6:
    jmp .Lcpu_apply_predefines_2
.Lcpu_apply_predefines_2:
    pushl -40(%ebp)
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
    je .Lcpu_apply_predefines_11
    leal ark_str_23, %eax
    pushl %eax
    leal ark_str_24, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_12
.Lcpu_apply_predefines_11:
.Lcpu_apply_predefines_12:
    pushl -40(%ebp)
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
    je .Lcpu_apply_predefines_13
    leal ark_str_25, %eax
    pushl %eax
    leal ark_str_26, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl -40(%ebp)
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
    je .Lcpu_apply_predefines_15
    pushl -40(%ebp)
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
    pushl $86
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcpu_apply_predefines_25
    pushl -40(%ebp)
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
    jmp .Lcpu_apply_predefines_26
.Lcpu_apply_predefines_25:
    pushl $0
.Lcpu_apply_predefines_26:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_apply_predefines_23
    pushl -40(%ebp)
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
    pushl $80
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
    jmp .Lcpu_apply_predefines_24
.Lcpu_apply_predefines_23:
    pushl $0
.Lcpu_apply_predefines_24:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_apply_predefines_21
    pushl -40(%ebp)
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
    pushl $118
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
    jmp .Lcpu_apply_predefines_22
.Lcpu_apply_predefines_21:
    pushl $0
.Lcpu_apply_predefines_22:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_apply_predefines_19
    pushl -40(%ebp)
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
    pushl $53
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
    jmp .Lcpu_apply_predefines_20
.Lcpu_apply_predefines_19:
    pushl $0
.Lcpu_apply_predefines_20:
    popl %eax
    cmpl $0, %eax
    je .Lcpu_apply_predefines_17
    leal ark_str_27, %eax
    pushl %eax
    leal ark_str_28, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_18
.Lcpu_apply_predefines_17:
.Lcpu_apply_predefines_18:
    jmp .Lcpu_apply_predefines_16
.Lcpu_apply_predefines_15:
.Lcpu_apply_predefines_16:
    pushl -40(%ebp)
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
    je .Lcpu_apply_predefines_27
    leal ark_str_29, %eax
    pushl %eax
    leal ark_str_30, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lcpu_apply_predefines_28
.Lcpu_apply_predefines_27:
.Lcpu_apply_predefines_28:
    jmp .Lcpu_apply_predefines_14
.Lcpu_apply_predefines_13:
.Lcpu_apply_predefines_14:
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
    leal ark_str_31, %eax
    pushl %eax
    call _preproc_define
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -32(%ebp), %eax
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
    call _int_to_str
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    leal -32(%ebp), %eax
    pushl %eax
    leal ark_str_32, %eax
    pushl %eax
    call _preproc_define
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

