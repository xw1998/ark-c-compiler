# Ark C Compiler - generated x86 32-bit (cdecl) assembly
    .intel_syntax noprefix
    .section .rodata
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
    .asciz "    li t0, "
ark_str_28:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_29:
    .asciz "    li t0, "
ark_str_30:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_31:
    .asciz "    la t0, ark_str_"
ark_str_32:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_33:
    .asciz "    lw t0, -"
ark_str_34:
    .asciz "(s0)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_35:
    .asciz "    addi t0, s0, -"
ark_str_36:
    .asciz "\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_37:
    .asciz "    la t1, "
ark_str_38:
    .asciz "\n    lw t0, 0(t1)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_39:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    la t1, "
ark_str_40:
    .asciz "\n    sw t0, 0(t1)\n"
ark_str_41:
    .asciz "    addi sp, sp, 4\n"
ark_str_42:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_43:
    .asciz "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    sw t1, 0(sp)\n    sw t0, 4(sp)\n"
ark_str_44:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    sw t0, -"
ark_str_45:
    .asciz "(s0)\n"
ark_str_46:
    .asciz "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 8\n"
ark_str_47:
    .asciz "    add t0, t0, t1\n    lb t0, 0(t0)\n"
ark_str_48:
    .asciz "    li t2, "
ark_str_49:
    .asciz "\n    mul t1, t1, t2\n    add t0, t0, t1\n    lw t0, 0(t0)\n"
ark_str_50:
    .asciz "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_51:
    .asciz "    lw t0, 0(sp)\n    lw t1, 4(sp)\n    addi sp, sp, 8\n"
ark_str_52:
    .asciz "    sb t0, 0(t1)\n"
ark_str_53:
    .asciz "    sw t0, 0(t1)\n"
ark_str_54:
    .asciz "    addi sp, sp, -4\n    sw t0, 0(sp)\n"
ark_str_55:
    .asciz "    lw t1, 0(sp)\n    lw t0, 4(sp)\n    addi sp, sp, 4\n"
ark_str_56:
    .asciz "    add t0, t0, t1\n"
ark_str_57:
    .asciz "    sub t0, t0, t1\n"
ark_str_58:
    .asciz "    mul t0, t0, t1\n"
ark_str_59:
    .asciz "    div t0, t0, t1\n"
ark_str_60:
    .asciz "    rem t0, t0, t1\n"
ark_str_61:
    .asciz "    and t0, t0, t1\n"
ark_str_62:
    .asciz "    or t0, t0, t1\n"
ark_str_63:
    .asciz "    xor t0, t0, t1\n"
ark_str_64:
    .asciz "    sll t0, t0, t1\n"
ark_str_65:
    .asciz "    sra t0, t0, t1\n"
ark_str_66:
    .asciz "    sub t0, t0, t1\n    seqz t0, t0\n"
ark_str_67:
    .asciz "    sub t0, t0, t1\n    snez t0, t0\n"
ark_str_68:
    .asciz "    slt  t0, t0, t1\n"
ark_str_69:
    .asciz "    slt  t0, t1, t0\n"
ark_str_70:
    .asciz "    slt  t0, t1, t0\n    xori t0, t0, 1\n"
ark_str_71:
    .asciz "    slt  t0, t0, t1\n    xori t0, t0, 1\n"
ark_str_72:
    .asciz "    sw t0, 0(sp)\n"
ark_str_73:
    .asciz "    lw t0, 0(sp)\n"
ark_str_74:
    .asciz "    neg t0, t0\n"
ark_str_75:
    .asciz "    not t0, t0\n"
ark_str_76:
    .asciz "    seqz t0, t0\n"
ark_str_77:
    .asciz "    sw t0, 0(sp)\n"
ark_str_78:
    .asciz ".L_"
ark_str_79:
    .asciz ":\n"
ark_str_80:
    .asciz ".LN_"
ark_str_81:
    .asciz ":\n"
ark_str_82:
    .asciz "    j .L_"
ark_str_83:
    .asciz "    j .LN_"
ark_str_84:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    beq t0, x0, .L_"
ark_str_85:
    .asciz "    lw t0, 0(sp)\n    addi sp, sp, 4\n    bne t0, x0, .L_"
ark_str_86:
    .asciz "    lw t0, 0(sp)\n    li t1, "
ark_str_87:
    .asciz "\n    bne t0, t1, 1f\n    addi sp, sp, 4\n    j .L_"
ark_str_88:
    .asciz "\n1:\n"
ark_str_89:
    .asciz "    lw "
ark_str_90:
    .asciz ", 0(sp)\n    addi sp, sp, 4\n"
ark_str_91:
    .asciz "    call "
ark_str_92:
    .asciz "    addi sp, sp, -4\n    sw a0, 0(sp)\n"
ark_str_93:
    .asciz "    lw a0, 0(sp)\n    addi sp, sp, 4\n"
ark_str_94:
    .asciz "    lw s0, "
ark_str_95:
    .asciz "(sp)\n    lw ra, "
ark_str_96:
    .asciz "(sp)\n    addi sp, sp, "
ark_str_97:
    .asciz "\n    ret\n"
ark_str_98:
    .asciz "    # unknown\n"
ark_str_99:
    .asciz "    li a0, 0\n    lw s0, "
ark_str_100:
    .asciz "(sp)\n    lw ra, "
ark_str_101:
    .asciz "(sp)\n    addi sp, sp, "
ark_str_102:
    .asciz "\n    ret\n\n"
    .data
    .globl g_rv_backend
    .local g_rv_backend
g_rv_backend:
    .quad 7166187372092287346
    .quad 7956574615470342148
    .long ark_rv_assemble
    .long ark_rv_link
    .long 0
    .globl ark_sl_arg_reg_r_r
    .local ark_sl_arg_reg_r_r
ark_sl_arg_reg_r_r:
    .quad 54292681601121
    .quad 56491704857185
    .quad 58690728113249
    .quad 60889751369313
    .text
    .globl arg_reg_r
arg_reg_r:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    mov eax, [ebp+8]
    mov [ebp-48], eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Larg_reg_r_2
    push dword ptr [ebp-48]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setge al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Larg_reg_r_3
.Larg_reg_r_2:
    push 1
.Larg_reg_r_3:
    pop eax
    test eax, eax
    jz .Larg_reg_r_0
    lea eax, [ark_str_0]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    jmp .Larg_reg_r_1
.Larg_reg_r_0:
.Larg_reg_r_1:
    lea eax, [ark_sl_arg_reg_r_r]
    push eax
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl rv_emit
rv_emit:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 460
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_init
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_1]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_2]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_0
    lea eax, [ark_str_3]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lrv_emit_2:
    push dword ptr [ebp-96]
    push dword ptr [ebp-48]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_3
    push dword ptr [ebp-48]
    push 12
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-96]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    lea eax, [ark_str_4]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_5]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 0
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    add esp, 4
.Lrv_emit_5:
    push dword ptr [ebp-112]
    push dword ptr [ebp-104]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_6
    push dword ptr [ebp-104]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop eax
    mov [ebp-120], eax
    push dword ptr [ebp-120]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_8
    lea eax, [ark_str_6]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_9
.Lrv_emit_8:
    push dword ptr [ebp-120]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_10
    lea eax, [ark_str_7]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_11
.Lrv_emit_10:
    push dword ptr [ebp-120]
    push 92
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_12
    lea eax, [ark_str_8]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_13
.Lrv_emit_12:
    push dword ptr [ebp-120]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_14
    lea eax, [ark_str_9]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_15
.Lrv_emit_14:
    push dword ptr [ebp-120]
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
.Lrv_emit_15:
.Lrv_emit_13:
.Lrv_emit_11:
.Lrv_emit_9:
.Lrv_emit_7:
    push dword ptr [ebp-112]
    push dword ptr [ebp-112]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    add esp, 4
    jmp .Lrv_emit_5
.Lrv_emit_6:
    lea eax, [ark_str_10]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
.Lrv_emit_4:
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
    jmp .Lrv_emit_2
.Lrv_emit_3:
    lea eax, [ark_str_11]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_1
.Lrv_emit_0:
.Lrv_emit_1:
    push dword ptr [ebp-48]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_16
    lea eax, [ark_str_12]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_17
.Lrv_emit_16:
.Lrv_emit_17:
    push 0
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
.Lrv_emit_18:
    push dword ptr [ebp-96]
    push dword ptr [ebp-48]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_19
    push dword ptr [ebp-48]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-96]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-104], eax
    lea eax, [ark_str_13]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-104]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_14]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-104]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_21
    push dword ptr [ebp-104]
    push 24
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    jmp .Lrv_emit_22
.Lrv_emit_21:
    push 0
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
.Lrv_emit_22:
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
.Lrv_emit_20:
    push dword ptr [ebp-96]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    add esp, 4
    jmp .Lrv_emit_18
.Lrv_emit_19:
    push dword ptr [ebp-48]
    push 28
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_23
    lea eax, [ark_str_15]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_24
.Lrv_emit_23:
.Lrv_emit_24:
    push 0
    pop eax
    mov [ebp-88], eax
    push dword ptr [ebp-88]
    add esp, 4
.Lrv_emit_25:
    push dword ptr [ebp-88]
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_26
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-88]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 15
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 15
    pop eax
    not eax
    push eax
    pop ecx
    pop eax
    and eax, ecx
    push eax
    pop eax
    mov [ebp-112], eax
    push dword ptr [ebp-112]
    push 256
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-120], eax
    lea eax, [ark_str_16]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_17]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_18]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_19]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_20]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 8
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_21]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lrv_emit_28:
    push dword ptr [ebp-104]
    push dword ptr [ebp-96]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_29
    push dword ptr [ebp-96]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-104]
    push 32
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-128], eax
    push dword ptr [ebp-128]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-136], eax
    push dword ptr [ebp-136]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_32
    push dword ptr [ebp-136]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_33
    push dword ptr [ebp-136]
    push 20
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_34
    push dword ptr [ebp-136]
    push 1
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_35
    push dword ptr [ebp-136]
    push 42
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_36
    push dword ptr [ebp-136]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_37
    push dword ptr [ebp-136]
    push 2
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_38
    push dword ptr [ebp-136]
    push 3
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_39
    push dword ptr [ebp-136]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_40
    push dword ptr [ebp-136]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_41
    push dword ptr [ebp-136]
    push 4
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_42
    push dword ptr [ebp-136]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_43
    push dword ptr [ebp-136]
    push 56
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_44
    push dword ptr [ebp-136]
    push 57
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_45
    push dword ptr [ebp-136]
    push 58
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_46
    push dword ptr [ebp-136]
    push 59
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_47
    push dword ptr [ebp-136]
    push 5
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_48
    push dword ptr [ebp-136]
    push 7
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_49
    push dword ptr [ebp-136]
    push 6
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_50
    push dword ptr [ebp-136]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_51
    push dword ptr [ebp-136]
    push 9
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_52
    push dword ptr [ebp-136]
    push 12
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_53
    push dword ptr [ebp-136]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_54
    push dword ptr [ebp-136]
    push 13
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_55
    push dword ptr [ebp-136]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_56
    push dword ptr [ebp-136]
    push 14
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_57
    push dword ptr [ebp-136]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_58
    push dword ptr [ebp-136]
    push 27
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_59
    push dword ptr [ebp-136]
    push 10
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_60
    push dword ptr [ebp-136]
    push 11
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_61
    jmp .Lrv_emit_62
.Lrv_emit_32:
.Lrv_emit_33:
    jmp .Lrv_emit_31
.Lrv_emit_34:
    lea eax, [ark_str_22]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call arg_reg_r
    mov esp, [ebp-208]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_23]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 16
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_24]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_35:
    lea eax, [ark_str_25]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_26]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_36:
    lea eax, [ark_str_27]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_28]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_29]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_30]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_37:
    lea eax, [ark_str_31]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_32]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_38:
    lea eax, [ark_str_33]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 16
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_34]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_39:
    lea eax, [ark_str_35]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 16
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_36]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_40:
    lea eax, [ark_str_37]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_38]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_41:
    lea eax, [ark_str_39]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_40]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_42:
    lea eax, [ark_str_41]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_43:
    lea eax, [ark_str_42]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_44:
    lea eax, [ark_str_43]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_45:
.Lrv_emit_46:
.Lrv_emit_47:
    jmp .Lrv_emit_31
.Lrv_emit_48:
    lea eax, [ark_str_44]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 16
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    pop ecx
    pop ebx
    pop eax
    pop edx
    add eax, ecx
    add edx, ebx
    push edx
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_45]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_49:
    lea eax, [ark_str_46]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 1
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_63
    lea eax, [ark_str_47]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_64
.Lrv_emit_63:
    lea eax, [ark_str_48]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_49]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
.Lrv_emit_64:
    lea eax, [ark_str_50]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_50:
    lea eax, [ark_str_51]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    push 1
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    pop ecx
    add esp, 4
    pop eax
    add esp, 4
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_65
    lea eax, [ark_str_52]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_66
.Lrv_emit_65:
    lea eax, [ark_str_53]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
.Lrv_emit_66:
    lea eax, [ark_str_54]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_51:
    lea eax, [ark_str_55]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-144], eax
    push dword ptr [ebp-144]
    push 15
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_68
    push dword ptr [ebp-144]
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_69
    push dword ptr [ebp-144]
    push 17
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_70
    push dword ptr [ebp-144]
    push 18
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_71
    push dword ptr [ebp-144]
    push 19
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_72
    push dword ptr [ebp-144]
    push 30
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_73
    push dword ptr [ebp-144]
    push 31
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_74
    push dword ptr [ebp-144]
    push 32
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_75
    push dword ptr [ebp-144]
    push 34
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_76
    push dword ptr [ebp-144]
    push 35
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_77
    push dword ptr [ebp-144]
    push 21
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_78
    push dword ptr [ebp-144]
    push 22
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_79
    push dword ptr [ebp-144]
    push 23
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_80
    push dword ptr [ebp-144]
    push 24
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_81
    push dword ptr [ebp-144]
    push 25
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_82
    push dword ptr [ebp-144]
    push 26
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jnz .Lrv_emit_83
    jmp .Lrv_emit_84
.Lrv_emit_68:
    lea eax, [ark_str_56]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_69:
    lea eax, [ark_str_57]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_70:
    lea eax, [ark_str_58]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_71:
    lea eax, [ark_str_59]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_72:
    lea eax, [ark_str_60]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_73:
    lea eax, [ark_str_61]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_74:
    lea eax, [ark_str_62]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_75:
    lea eax, [ark_str_63]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_76:
    lea eax, [ark_str_64]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_77:
    lea eax, [ark_str_65]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_78:
    lea eax, [ark_str_66]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_79:
    lea eax, [ark_str_67]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_80:
    lea eax, [ark_str_68]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_81:
    lea eax, [ark_str_69]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_82:
    lea eax, [ark_str_70]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_83:
    lea eax, [ark_str_71]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_67
.Lrv_emit_84:
    jmp .Lrv_emit_67
.Lrv_emit_67:
    lea eax, [ark_str_72]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_52:
    lea eax, [ark_str_73]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 16
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_85
    lea eax, [ark_str_74]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_86
.Lrv_emit_85:
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 33
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_87
    lea eax, [ark_str_75]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_88
.Lrv_emit_87:
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 29
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_89
    lea eax, [ark_str_76]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_90
.Lrv_emit_89:
.Lrv_emit_90:
.Lrv_emit_88:
.Lrv_emit_86:
    lea eax, [ark_str_77]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_53:
    lea eax, [ark_str_78]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_79]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_54:
    lea eax, [ark_str_80]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_81]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_55:
    lea eax, [ark_str_82]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_56:
    lea eax, [ark_str_83]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_57:
    lea eax, [ark_str_84]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_58:
    lea eax, [ark_str_85]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_59:
    lea eax, [ark_str_86]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_87]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-96]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 95
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 20
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_88]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_60:
    push dword ptr [ebp-128]
    push 8
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 8
    add eax, ecx
    mov edx, dword ptr [eax+4]
    push edx
    mov eax, dword ptr [eax]
    push eax
    add esp, 4
    pop eax
    mov [ebp-152], eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_91
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    push 63
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lrv_emit_92
.Lrv_emit_91:
    push 0
.Lrv_emit_92:
    pop eax
    mov [ebp-168], eax
    push 0
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-168]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_93
    push 0
    pop eax
    mov [ebp-184], eax
    push dword ptr [ebp-184]
    add esp, 4
.Lrv_emit_95:
    push dword ptr [ebp-184]
    push dword ptr [ebp-48]
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_96
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-184]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call ark_streq
    mov esp, [ebp-208]
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_98
    push dword ptr [ebp-48]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-184]
    push 4
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 120
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-192], eax
    push dword ptr [ebp-192]
    pop eax
    test eax, eax
    jz .Lrv_emit_102
    push dword ptr [ebp-192]
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    sete al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lrv_emit_103
.Lrv_emit_102:
    push 0
.Lrv_emit_103:
    pop eax
    test eax, eax
    jz .Lrv_emit_100
    push 1
    pop eax
    mov [ebp-176], eax
    push dword ptr [ebp-176]
    add esp, 4
    jmp .Lrv_emit_101
.Lrv_emit_100:
.Lrv_emit_101:
    jmp .Lrv_emit_96
    jmp .Lrv_emit_99
.Lrv_emit_98:
.Lrv_emit_99:
.Lrv_emit_97:
    push dword ptr [ebp-184]
    push dword ptr [ebp-184]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-184], eax
    add esp, 4
    jmp .Lrv_emit_95
.Lrv_emit_96:
    jmp .Lrv_emit_94
.Lrv_emit_93:
.Lrv_emit_94:
    push 0
    pop eax
    mov [ebp-160], eax
    push dword ptr [ebp-160]
    add esp, 4
.Lrv_emit_104:
    push dword ptr [ebp-160]
    push dword ptr [ebp-152]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_107
    push dword ptr [ebp-160]
    push 8
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setne al
    movzx eax, al
    push eax
    jmp .Lrv_emit_108
.Lrv_emit_107:
    push 0
.Lrv_emit_108:
    pop eax
    test eax, eax
    jz .Lrv_emit_105
    lea eax, [ark_str_89]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-160]
    pop eax
    mov [ebp-224], eax
    mov [ebp-208], esp
    push dword ptr [ebp-224]
    and esp, -16
    call arg_reg_r
    mov esp, [ebp-208]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_90]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
.Lrv_emit_106:
    push dword ptr [ebp-160]
    push dword ptr [ebp-160]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-160], eax
    add esp, 4
    jmp .Lrv_emit_104
.Lrv_emit_105:
    lea eax, [ark_str_91]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-128]
    push 16
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push 10
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_putc
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-176]
    pop eax
    test eax, eax
    sete al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_109
    lea eax, [ark_str_92]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_110
.Lrv_emit_109:
.Lrv_emit_110:
    jmp .Lrv_emit_31
.Lrv_emit_61:
    lea eax, [ark_str_93]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_94]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 8
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_95]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_96]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_97]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_62:
    lea eax, [ark_str_98]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    jmp .Lrv_emit_31
.Lrv_emit_31:
.Lrv_emit_30:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lrv_emit_28
.Lrv_emit_29:
    lea eax, [ark_str_99]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 8
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_100]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    push 4
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_101]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
    push dword ptr [ebp-120]
    mov eax, [esp]
    push eax
    push 0
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    neg eax
    push eax
    # unknown IR op: CDECL64
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_int
    mov esp, [ebp-208]
    push eax
    lea eax, [ark_str_102]
    push eax
    lea eax, [ebp-72]
    push eax
    pop eax
    mov [ebp-224], eax
    pop eax
    mov [ebp-228], eax
    mov [ebp-208], esp
    push dword ptr [ebp-228]
    push dword ptr [ebp-224]
    and esp, -16
    call asmbuf_puts
    mov esp, [ebp-208]
    push eax
.Lrv_emit_27:
    push dword ptr [ebp-88]
    push dword ptr [ebp-88]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-88], eax
    add esp, 4
    jmp .Lrv_emit_25
.Lrv_emit_26:
    lea eax, [ebp-72]
    push eax
    push 4
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_111
    push dword ptr [ebp-64]
    push 1
    pop ecx
    pop eax
    sub eax, ecx
    push eax
    pop eax
    mov [ebp-96], eax
    push dword ptr [ebp-96]
    add esp, 4
    jmp .Lrv_emit_112
.Lrv_emit_111:
.Lrv_emit_112:
    push 0
    pop eax
    mov [ebp-104], eax
    push dword ptr [ebp-104]
    add esp, 4
.Lrv_emit_113:
    push dword ptr [ebp-104]
    push dword ptr [ebp-96]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_emit_114
    push dword ptr [ebp-56]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    lea eax, [ebp-72]
    push eax
    push 0
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    imul ecx, 4
    add eax, ecx
    movsx eax, dword ptr [eax]
    push eax
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lrv_emit_115:
    push dword ptr [ebp-104]
    push dword ptr [ebp-104]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-104], eax
    add esp, 4
    jmp .Lrv_emit_113
.Lrv_emit_114:
    push dword ptr [ebp-56]
    push dword ptr [ebp-96]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
    push dword ptr [ebp-96]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl rv_assemble
rv_assemble:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 348
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    pop eax
    mov [ebp-112], eax
    mov [ebp-96], esp
    push dword ptr [ebp-112]
    and esp, -16
    call ark_strlen
    mov esp, [ebp-96]
    push eax
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    push dword ptr [ebp-64]
    pop ecx
    pop eax
    cmp eax, ecx
    setg al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_assemble_0
    push dword ptr [ebp-64]
    pop eax
    mov [ebp-72], eax
    push dword ptr [ebp-72]
    add esp, 4
    jmp .Lrv_assemble_1
.Lrv_assemble_0:
.Lrv_assemble_1:
    push 0
    pop eax
    mov [ebp-80], eax
    push dword ptr [ebp-80]
    add esp, 4
.Lrv_assemble_2:
    push dword ptr [ebp-80]
    push dword ptr [ebp-72]
    pop ecx
    pop eax
    cmp eax, ecx
    setl al
    movzx eax, al
    push eax
    pop eax
    test eax, eax
    jz .Lrv_assemble_3
    push dword ptr [ebp-56]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push dword ptr [ebp-48]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    imul eax, ecx
    push eax
    pop ecx
    pop eax
    add eax, ecx
    push eax
    push 0
    pop ecx
    pop eax
    movsx eax, byte ptr [eax]
    push eax
    pop edx
    pop eax
    mov byte ptr [eax], dl
    push edx
    add esp, 4
.Lrv_assemble_4:
    push dword ptr [ebp-80]
    push dword ptr [ebp-80]
    push 1
    pop ecx
    pop eax
    add eax, ecx
    push eax
    pop eax
    mov [ebp-80], eax
    add esp, 4
    jmp .Lrv_assemble_2
.Lrv_assemble_3:
    push dword ptr [ebp-72]
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl rv_link
rv_link:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 332
    mov eax, [ebp+8]
    mov [ebp-48], eax
    mov eax, [ebp+12]
    mov [ebp-56], eax
    mov eax, [ebp+16]
    mov [ebp-64], eax
    push dword ptr [ebp-48]
    add esp, 4
    push dword ptr [ebp-56]
    add esp, 4
    push dword ptr [ebp-64]
    add esp, 4
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

    .globl ark_backend_riscv32
ark_backend_riscv32:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi
    sub esp, 316
    lea eax, [g_rv_backend]
    push eax
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    push 0
    pop eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret
    xor eax, eax
    lea esp, [ebp-12]
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

