# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .section .rdata,"dr"
ark_str_0:
    .asciz "rb"
ark_str_1:
    .asciz "[scatter] cannot open %s\n"
ark_str_2:
    .asciz "LR_"
ark_str_3:
    .asciz "ER_"
ark_str_4:
    .asciz "RW_"
ark_str_5:
    .asciz "ZI_"
ark_str_6:
    .asciz "[scatter] parsed %s\n"
ark_str_7:
    .asciz "LR %s @0x%08X\n"
ark_str_8:
    .asciz "  ER %s @0x%08X\n"
ark_str_9:
    .asciz "    selectors: %s\n"
ark_str_10:
    .asciz "LR_DEFAULT"
ark_str_11:
    .asciz "AT"
ark_str_12:
    .asciz ""
ark_str_13:
    .asciz "rb"
ark_str_14:
    .asciz "[ld] cannot open %s\n"
ark_str_15:
    .asciz "MEMORY"
ark_str_16:
    .asciz "SECTIONS"
ark_str_17:
    .asciz "[ld] parsed %s\n"
ark_str_18:
    .asciz ".rodata"
ark_str_19:
    .asciz ".rodata"
ark_str_20:
    .asciz ".bss"
ark_str_21:
    .asciz ".bss"
ark_str_22:
    .asciz ".data"
ark_str_23:
    .asciz ".data"
ark_str_24:
    .asciz ".text"
ark_str_25:
    .asciz ".text"
ark_str_26:
    .asciz "+ZI"
ark_str_27:
    .asciz ".bss"
ark_str_28:
    .asciz "+RW"
ark_str_29:
    .asciz ".data"
ark_str_30:
    .asciz "+RO"
ark_str_31:
    .asciz "+XO"
ark_str_32:
    .asciz ".text"
ark_str_33:
    .asciz ".text"
ark_str_34:
    .asciz "MEMORY {\n"
ark_str_35:
    .asciz "  %s (rx) : ORIGIN = 0x%X, LENGTH = 0x%X\n"
ark_str_36:
    .asciz "  %s (rwx) : ORIGIN = 0x%X, LENGTH = 0x%X\n"
ark_str_37:
    .asciz "}\n"
ark_str_38:
    .asciz "SECTIONS {\n"
ark_str_39:
    .asciz ""
ark_str_40:
    .asciz "  %s 0x%X : { %s } > %s"
ark_str_41:
    .asciz ".data"
ark_str_42:
    .asciz " AT > %s"
ark_str_43:
    .asciz "\n"
ark_str_44:
    .asciz "}\n"
ark_str_45:
    .asciz "%s 0x%X 0x%X {\n"
ark_str_46:
    .asciz "    %s 0x%X 0x%X {\n"
ark_str_47:
    .asciz "        %s\n"
ark_str_48:
    .asciz "    }\n"
ark_str_49:
    .asciz "}\n"
    .text
_skip_ws:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_ws_0:
.Lskip_ws_3:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_5
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isspace
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lskip_ws_6
.Lskip_ws_5:
    pushl $0
.Lskip_ws_6:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_4
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
    jmp .Lskip_ws_3
.Lskip_ws_4:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_7
.Lskip_ws_9:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_11
    pushl -24(%ebp)
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
    jmp .Lskip_ws_12
.Lskip_ws_11:
    pushl $0
.Lskip_ws_12:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_10
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
    jmp .Lskip_ws_9
.Lskip_ws_10:
    jmp .Lskip_ws_2
.Lskip_ws_7:
.Lskip_ws_8:
    jmp .Lskip_ws_1
.Lskip_ws_2:
    jmp .Lskip_ws_0
.Lskip_ws_1:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_ident:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
.Lread_ident_0:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_ident_2
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isalnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_ident_6
    pushl -40(%ebp)
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
    jmp .Lread_ident_7
.Lread_ident_6:
    pushl $1
.Lread_ident_7:
    popl %eax
    cmpl $0, %eax
    jne .Lread_ident_4
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $36
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
    jmp .Lread_ident_5
.Lread_ident_4:
    pushl $1
.Lread_ident_5:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_ident_3
.Lread_ident_2:
    pushl $0
.Lread_ident_3:
    popl %eax
    cmpl $0, %eax
    je .Lread_ident_1
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_ident_8
    pushl -32(%ebp)
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
    pushl -40(%ebp)
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
    jmp .Lread_ident_9
.Lread_ident_8:
.Lread_ident_9:
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
    jmp .Lread_ident_0
.Lread_ident_1:
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
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_addr:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl -56(%ebp)
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
    je .Lread_addr_2
    pushl -56(%ebp)
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
    jne .Lread_addr_4
    pushl -56(%ebp)
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
    jmp .Lread_addr_5
.Lread_addr_4:
    pushl $1
.Lread_addr_5:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_addr_3
.Lread_addr_2:
    pushl $0
.Lread_addr_3:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_0
    pushl -56(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
.Lread_addr_6:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_8
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isxdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_addr_9
.Lread_addr_8:
    pushl $0
.Lread_addr_9:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_7
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -32(%ebp)
    movzbl -32(%ebp), %eax
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
    je .Lread_addr_12
    movzbl -32(%ebp), %eax
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
    jmp .Lread_addr_13
.Lread_addr_12:
    pushl $0
.Lread_addr_13:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_10
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    jmp .Lread_addr_11
.Lread_addr_10:
    movzbl -32(%ebp), %eax
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
    je .Lread_addr_16
    movzbl -32(%ebp), %eax
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
    jmp .Lread_addr_17
.Lread_addr_16:
    pushl $0
.Lread_addr_17:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_14
    movzbl -32(%ebp), %eax
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
    jmp .Lread_addr_15
.Lread_addr_14:
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
    je .Lread_addr_20
    movzbl -32(%ebp), %eax
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
    jmp .Lread_addr_21
.Lread_addr_20:
    pushl $0
.Lread_addr_21:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_18
    movzbl -32(%ebp), %eax
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
    jmp .Lread_addr_19
.Lread_addr_18:
    pushl $0
.Lread_addr_19:
.Lread_addr_15:
.Lread_addr_11:
    popl %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    jmp .Lread_addr_6
.Lread_addr_7:
    jmp .Lread_addr_1
.Lread_addr_0:
.Lread_addr_22:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_24
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_addr_25
.Lread_addr_24:
    pushl $0
.Lread_addr_25:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_23
    pushl -40(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    jmp .Lread_addr_22
.Lread_addr_23:
.Lread_addr_1:
    pushl -56(%ebp)
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
    popl %eax
    cmpl $0, %eax
    jne .Lread_addr_28
    pushl -56(%ebp)
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
    jmp .Lread_addr_29
.Lread_addr_28:
    pushl $1
.Lread_addr_29:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_26
    pushl -40(%ebp)
    pushl $1024
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    jmp .Lread_addr_27
.Lread_addr_26:
    pushl -56(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $77
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_addr_32
    pushl -56(%ebp)
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
    jmp .Lread_addr_33
.Lread_addr_32:
    pushl $1
.Lread_addr_33:
    popl %eax
    cmpl $0, %eax
    je .Lread_addr_30
    pushl -40(%ebp)
    pushl $1048576
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
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
    jmp .Lread_addr_31
.Lread_addr_30:
.Lread_addr_31:
.Lread_addr_27:
    pushl -48(%ebp)
    pushl -40(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_collect_braces:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -80(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl -88(%ebp)
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    call _skip_ws
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcollect_braces_0
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lcollect_braces_0:
.Lcollect_braces_1:
    pushl -56(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
.Lcollect_braces_2:
    pushl -56(%ebp)
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
    je .Lcollect_braces_5
    jmp .Lcollect_braces_3
.Lcollect_braces_5:
.Lcollect_braces_6:
    pushl -56(%ebp)
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
    je .Lcollect_braces_7
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
    jmp .Lcollect_braces_8
.Lcollect_braces_7:
    pushl -56(%ebp)
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
    je .Lcollect_braces_9
    pushl -64(%ebp)
    pushl -64(%ebp)
    pushl $-1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    addl $4, %esp
    pushl -64(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcollect_braces_11
    jmp .Lcollect_braces_3
.Lcollect_braces_11:
.Lcollect_braces_12:
    jmp .Lcollect_braces_10
.Lcollect_braces_9:
.Lcollect_braces_10:
.Lcollect_braces_8:
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
.Lcollect_braces_4:
    jmp .Lcollect_braces_2
.Lcollect_braces_3:
    pushl -56(%ebp)
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
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
    je .Lcollect_braces_13
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
    jmp .Lcollect_braces_14
.Lcollect_braces_13:
.Lcollect_braces_14:
    pushl -40(%ebp)
    pushl -48(%ebp)
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lcollect_braces_15:
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
    je .Lcollect_braces_16
    pushl -24(%ebp)
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
    pushl -48(%ebp)
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
.Lcollect_braces_17:
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
    jmp .Lcollect_braces_15
.Lcollect_braces_16:
    pushl -24(%ebp)
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
    pushl -80(%ebp)
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -72(%ebp)
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _scatter_parse_file
_scatter_parse_file:
    pushl %ebp
    movl %esp, %ebp
    subl $496, %esp
    movl 8(%ebp), %eax
    movl %eax, -248(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -240(%ebp)
    pushl -248(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lscatter_parse_file_2
    pushl -240(%ebp)
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
    jmp .Lscatter_parse_file_3
.Lscatter_parse_file_2:
    pushl $1
.Lscatter_parse_file_3:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_parse_file_0:
.Lscatter_parse_file_1:
    leal ark_str_0, %eax
    pushl %eax
    pushl -248(%ebp)
    call _fopen
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -232(%ebp)
    pushl -232(%ebp)
    addl $4, %esp
    pushl -232(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_4
    pushl -248(%ebp)
    leal ark_str_1, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_parse_file_4:
.Lscatter_parse_file_5:
    pushl $2
    pushl $0
    pushl -232(%ebp)
    call _fseek
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -232(%ebp)
    call _ftell
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -224(%ebp)
    pushl -224(%ebp)
    addl $4, %esp
    pushl $0
    pushl $0
    pushl -232(%ebp)
    call _fseek
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -224(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_6
    pushl -232(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_parse_file_6:
.Lscatter_parse_file_7:
    pushl -224(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -216(%ebp)
    pushl -216(%ebp)
    addl $4, %esp
    pushl -232(%ebp)
    pushl -224(%ebp)
    pushl $1
    pushl -216(%ebp)
    call _fread
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -200(%ebp)
    pushl -200(%ebp)
    addl $4, %esp
    pushl -232(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -200(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_8
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_parse_file_8:
.Lscatter_parse_file_9:
    pushl -216(%ebp)
    pushl -200(%ebp)
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
    pushl -216(%ebp)
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
.Lscatter_parse_file_10:
    pushl -208(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_11
    pushl -208(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    pushl -208(%ebp)
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
    je .Lscatter_parse_file_12
    jmp .Lscatter_parse_file_11
.Lscatter_parse_file_12:
.Lscatter_parse_file_13:
    leal -192(%ebp), %eax
    pushl %eax
    pushl -208(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    leal -192(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_14
    pushl -208(%ebp)
    pushl -208(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_10
.Lscatter_parse_file_14:
.Lscatter_parse_file_15:
    pushl $3
    leal ark_str_2, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _strncmp
    addl $12, %esp
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
    je .Lscatter_parse_file_16
.Lscatter_parse_file_18:
    pushl -208(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_20
    pushl -208(%ebp)
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
    jmp .Lscatter_parse_file_21
.Lscatter_parse_file_20:
    pushl $0
.Lscatter_parse_file_21:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_19
    pushl -208(%ebp)
    pushl -208(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_18
.Lscatter_parse_file_19:
    jmp .Lscatter_parse_file_10
.Lscatter_parse_file_16:
.Lscatter_parse_file_17:
    pushl $20
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -192(%ebp), %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -128(%ebp)
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
    pushl -128(%ebp)
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
    pushl -128(%ebp)
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
    pushl -128(%ebp)
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
    pushl -208(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    pushl -208(%ebp)
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
    jne .Lscatter_parse_file_24
    pushl -208(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lscatter_parse_file_25
.Lscatter_parse_file_24:
    pushl $1
.Lscatter_parse_file_25:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_22
    pushl -128(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -208(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_23
.Lscatter_parse_file_22:
.Lscatter_parse_file_23:
    pushl -208(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    pushl -208(%ebp)
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
    jne .Lscatter_parse_file_28
    pushl -208(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lscatter_parse_file_29
.Lscatter_parse_file_28:
    pushl $1
.Lscatter_parse_file_29:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_26
    pushl -128(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -208(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_27
.Lscatter_parse_file_26:
.Lscatter_parse_file_27:
    pushl -208(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
.Lscatter_parse_file_30:
    pushl -208(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_34
    pushl -208(%ebp)
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
    jmp .Lscatter_parse_file_35
.Lscatter_parse_file_34:
    pushl $0
.Lscatter_parse_file_35:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_32
    pushl -208(%ebp)
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
    jmp .Lscatter_parse_file_33
.Lscatter_parse_file_32:
    pushl $0
.Lscatter_parse_file_33:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_31
    pushl -208(%ebp)
    pushl -208(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_30
.Lscatter_parse_file_31:
    pushl -208(%ebp)
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
    je .Lscatter_parse_file_36
    leal -112(%ebp), %eax
    pushl %eax
    leal -120(%ebp), %eax
    pushl %eax
    pushl -208(%ebp)
    call _collect_braces
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -208(%ebp)
    pushl -208(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lscatter_parse_file_38:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_39
    pushl -104(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
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
    je .Lscatter_parse_file_40
    jmp .Lscatter_parse_file_39
.Lscatter_parse_file_40:
.Lscatter_parse_file_41:
    leal -96(%ebp), %eax
    pushl %eax
    pushl -104(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    leal -96(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_42
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_38
.Lscatter_parse_file_42:
.Lscatter_parse_file_43:
    pushl $3
    leal ark_str_3, %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    call _strncmp
    addl $12, %esp
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
    jne .Lscatter_parse_file_48
    pushl $3
    leal ark_str_4, %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    call _strncmp
    addl $12, %esp
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
    jmp .Lscatter_parse_file_49
.Lscatter_parse_file_48:
    pushl $1
.Lscatter_parse_file_49:
    popl %eax
    cmpl $0, %eax
    jne .Lscatter_parse_file_46
    pushl $3
    leal ark_str_5, %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    call _strncmp
    addl $12, %esp
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
    jmp .Lscatter_parse_file_47
.Lscatter_parse_file_46:
    pushl $1
.Lscatter_parse_file_47:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_44
    pushl $20
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -96(%ebp), %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
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
    pushl -32(%ebp)
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
    pushl -32(%ebp)
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
    pushl -32(%ebp)
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
    pushl -104(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
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
    jne .Lscatter_parse_file_52
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lscatter_parse_file_53
.Lscatter_parse_file_52:
    pushl $1
.Lscatter_parse_file_53:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_50
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_51
.Lscatter_parse_file_50:
.Lscatter_parse_file_51:
    pushl -104(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
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
    jne .Lscatter_parse_file_56
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lscatter_parse_file_57
.Lscatter_parse_file_56:
    pushl $1
.Lscatter_parse_file_57:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_54
    pushl -32(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -104(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_55
.Lscatter_parse_file_54:
.Lscatter_parse_file_55:
    pushl -104(%ebp)
    call _skip_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Lscatter_parse_file_58:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_62
    pushl -104(%ebp)
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
    jmp .Lscatter_parse_file_63
.Lscatter_parse_file_62:
    pushl $0
.Lscatter_parse_file_63:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_60
    pushl -104(%ebp)
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
    jmp .Lscatter_parse_file_61
.Lscatter_parse_file_60:
    pushl $0
.Lscatter_parse_file_61:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_59
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_58
.Lscatter_parse_file_59:
    pushl -104(%ebp)
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
    je .Lscatter_parse_file_64
    leal -16(%ebp), %eax
    pushl %eax
    leal -24(%ebp), %eax
    pushl %eax
    pushl -104(%ebp)
    call _collect_braces
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl $12
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
    jmp .Lscatter_parse_file_65
.Lscatter_parse_file_64:
.Lscatter_parse_file_65:
    pushl -128(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
.Lscatter_parse_file_66:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_67
    pushl -24(%ebp)
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_66
.Lscatter_parse_file_67:
    pushl -24(%ebp)
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lscatter_parse_file_45
.Lscatter_parse_file_44:
.Lscatter_parse_file_68:
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_70
    pushl -104(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isspace
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
    jmp .Lscatter_parse_file_71
.Lscatter_parse_file_70:
    pushl $0
.Lscatter_parse_file_71:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_69
    pushl -104(%ebp)
    pushl -104(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_68
.Lscatter_parse_file_69:
.Lscatter_parse_file_45:
    jmp .Lscatter_parse_file_38
.Lscatter_parse_file_39:
    jmp .Lscatter_parse_file_37
.Lscatter_parse_file_36:
.Lscatter_parse_file_37:
    pushl -240(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
.Lscatter_parse_file_72:
    pushl -120(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_parse_file_73
    pushl -120(%ebp)
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
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    jmp .Lscatter_parse_file_72
.Lscatter_parse_file_73:
    pushl -120(%ebp)
    pushl -128(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lscatter_parse_file_10
.Lscatter_parse_file_11:
    pushl -248(%ebp)
    leal ark_str_6, %eax
    pushl %eax
    call _ark_log
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

    .globl _scatter_free
_scatter_free:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_free_0
    pushl -24(%ebp)
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
    jmp .Lscatter_free_1
.Lscatter_free_0:
.Lscatter_free_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _scatter_dump
_scatter_dump:
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
    je .Lscatter_dump_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_dump_0:
.Lscatter_dump_1:
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
    addl $4, %esp
.Lscatter_dump_2:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_dump_3
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
    leal ark_str_7, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lscatter_dump_5:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_dump_6
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
    leal ark_str_8, %eax
    pushl %eax
    call _ark_log
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    je .Lscatter_dump_8
    pushl -24(%ebp)
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
    leal ark_str_9, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lscatter_dump_9
.Lscatter_dump_8:
.Lscatter_dump_9:
.Lscatter_dump_7:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lscatter_dump_5
.Lscatter_dump_6:
.Lscatter_dump_4:
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lscatter_dump_2
.Lscatter_dump_3:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_ld_ws:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_ld_ws_0:
.Lskip_ld_ws_3:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_5
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isspace
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lskip_ld_ws_6
.Lskip_ld_ws_5:
    pushl $0
.Lskip_ld_ws_6:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_4
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
    jmp .Lskip_ld_ws_3
.Lskip_ld_ws_4:
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_9
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
    jmp .Lskip_ld_ws_10
.Lskip_ld_ws_9:
    pushl $0
.Lskip_ld_ws_10:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_7
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lskip_ld_ws_11:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_13
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
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_15
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
    jmp .Lskip_ld_ws_16
.Lskip_ld_ws_15:
    pushl $0
.Lskip_ld_ws_16:
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
    jmp .Lskip_ld_ws_14
.Lskip_ld_ws_13:
    pushl $0
.Lskip_ld_ws_14:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_12
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
    jmp .Lskip_ld_ws_11
.Lskip_ld_ws_12:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_17
    pushl -24(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lskip_ld_ws_18
.Lskip_ld_ws_17:
.Lskip_ld_ws_18:
    jmp .Lskip_ld_ws_2
.Lskip_ld_ws_7:
.Lskip_ld_ws_8:
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
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_21
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
    jmp .Lskip_ld_ws_22
.Lskip_ld_ws_21:
    pushl $0
.Lskip_ld_ws_22:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_19
.Lskip_ld_ws_23:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_25
    pushl -24(%ebp)
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
    jmp .Lskip_ld_ws_26
.Lskip_ld_ws_25:
    pushl $0
.Lskip_ld_ws_26:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ld_ws_24
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
    jmp .Lskip_ld_ws_23
.Lskip_ld_ws_24:
    jmp .Lskip_ld_ws_2
.Lskip_ld_ws_19:
.Lskip_ld_ws_20:
    jmp .Lskip_ld_ws_1
.Lskip_ld_ws_2:
    jmp .Lskip_ld_ws_0
.Lskip_ld_ws_1:
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_section_name:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -40(%ebp)
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
    je .Lread_section_name_0
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_section_name_2
    pushl -32(%ebp)
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
    pushl -40(%ebp)
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
    jmp .Lread_section_name_3
.Lread_section_name_2:
.Lread_section_name_3:
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
    jmp .Lread_section_name_1
.Lread_section_name_0:
.Lread_section_name_1:
.Lread_section_name_4:
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_section_name_6
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isalnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_section_name_10
    pushl -40(%ebp)
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
    jmp .Lread_section_name_11
.Lread_section_name_10:
    pushl $1
.Lread_section_name_11:
    popl %eax
    cmpl $0, %eax
    jne .Lread_section_name_8
    pushl -40(%ebp)
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
    jmp .Lread_section_name_9
.Lread_section_name_8:
    pushl $1
.Lread_section_name_9:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_section_name_7
.Lread_section_name_6:
    pushl $0
.Lread_section_name_7:
    popl %eax
    cmpl $0, %eax
    je .Lread_section_name_5
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_section_name_12
    pushl -32(%ebp)
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
    pushl -40(%ebp)
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
    jmp .Lread_section_name_13
.Lread_section_name_12:
.Lread_section_name_13:
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
    jmp .Lread_section_name_4
.Lread_section_name_5:
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
    pushl -40(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_find_load_region:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lfind_load_region_2
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
    jmp .Lfind_load_region_3
.Lfind_load_region_2:
    pushl $1
.Lfind_load_region_3:
    popl %eax
    cmpl $0, %eax
    je .Lfind_load_region_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfind_load_region_0:
.Lfind_load_region_1:
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lfind_load_region_4:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lfind_load_region_5
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
    je .Lfind_load_region_7
    pushl -24(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfind_load_region_7:
.Lfind_load_region_8:
.Lfind_load_region_6:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lfind_load_region_4
.Lfind_load_region_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_first_or_default_load_region:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
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
    cmpl $0, %eax
    je .Lfirst_or_default_load_region_0
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lfirst_or_default_load_region_0:
.Lfirst_or_default_load_region_1:
    pushl $20
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal ark_str_10, %eax
    pushl %eax
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
    pushl $0
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
    pushl $0
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
    pushl $0
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
    pushl -16(%ebp)
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

_make_er_name:
    pushl %ebp
    movl %esp, %ebp
    subl $368, %esp
    movl 8(%ebp), %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    leal -112(%ebp), %eax
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
    pushl $69
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -112(%ebp), %eax
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
    pushl $82
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    leal -112(%ebp), %eax
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
    pushl $95
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lmake_er_name_0:
    pushl -120(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lmake_er_name_2
    pushl -24(%ebp)
    pushl $76
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
    jmp .Lmake_er_name_3
.Lmake_er_name_2:
    pushl $0
.Lmake_er_name_3:
    popl %eax
    cmpl $0, %eax
    je .Lmake_er_name_1
    pushl -120(%ebp)
    pushl -32(%ebp)
    pushl -32(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
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
    movb %al, -16(%ebp)
    movzbl -16(%ebp), %eax
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
    je .Lmake_er_name_4
    jmp .Lmake_er_name_0
.Lmake_er_name_4:
.Lmake_er_name_5:
    movzbl -16(%ebp), %eax
    pushl %eax
    call _isalnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lmake_er_name_8
    movzbl -16(%ebp), %eax
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
    jmp .Lmake_er_name_9
.Lmake_er_name_8:
    pushl $1
.Lmake_er_name_9:
    popl %eax
    cmpl $0, %eax
    je .Lmake_er_name_6
    leal -112(%ebp), %eax
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
    movzbl -16(%ebp), %eax
    pushl %eax
    call _toupper
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lmake_er_name_7
.Lmake_er_name_6:
    leal -112(%ebp), %eax
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
    pushl $95
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Lmake_er_name_7:
    jmp .Lmake_er_name_0
.Lmake_er_name_1:
    leal -112(%ebp), %eax
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
    leal -112(%ebp), %eax
    pushl %eax
    call _mem_strdup
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

_parse_ld_memory:
    pushl %ebp
    movl %esp, %ebp
    subl $432, %esp
    movl 8(%ebp), %eax
    movl %eax, -184(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_memory_0
    pushl -184(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_ld_memory_0:
.Lparse_ld_memory_1:
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    pushl -176(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lparse_ld_memory_2:
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
    je .Lparse_ld_memory_3
    pushl -16(%ebp)
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
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_2
.Lparse_ld_memory_3:
.Lparse_ld_memory_4:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_7
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_5
.Lparse_ld_memory_7:
.Lparse_ld_memory_8:
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_9
    jmp .Lparse_ld_memory_5
.Lparse_ld_memory_9:
.Lparse_ld_memory_10:
    leal -168(%ebp), %eax
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
    leal -104(%ebp), %eax
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    leal -168(%ebp), %eax
    pushl %eax
    pushl -184(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -168(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_memory_11
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_6
.Lparse_ld_memory_11:
.Lparse_ld_memory_12:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_13
.Lparse_ld_memory_15:
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_memory_17
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $41
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
    jmp .Lparse_ld_memory_18
.Lparse_ld_memory_17:
    pushl $0
.Lparse_ld_memory_18:
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_memory_16
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_15
.Lparse_ld_memory_16:
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_19
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_20
.Lparse_ld_memory_19:
.Lparse_ld_memory_20:
    jmp .Lparse_ld_memory_14
.Lparse_ld_memory_13:
.Lparse_ld_memory_14:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_memory_21
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_22
.Lparse_ld_memory_21:
.Lparse_ld_memory_22:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -104(%ebp), %eax
    pushl %eax
    pushl -184(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_23
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_24
.Lparse_ld_memory_23:
.Lparse_ld_memory_24:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -40(%ebp), %eax
    pushl %eax
    pushl -184(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_25
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_26
.Lparse_ld_memory_25:
.Lparse_ld_memory_26:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -104(%ebp), %eax
    pushl %eax
    pushl -184(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -184(%ebp)
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
    je .Lparse_ld_memory_27
    pushl -184(%ebp)
    pushl -184(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_memory_28
.Lparse_ld_memory_27:
.Lparse_ld_memory_28:
    pushl -184(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    leal -32(%ebp), %eax
    pushl %eax
    pushl -184(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl $20
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -168(%ebp), %eax
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
    pushl -16(%ebp)
    pushl -24(%ebp)
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
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lparse_ld_memory_6:
    jmp .Lparse_ld_memory_4
.Lparse_ld_memory_5:
    pushl -184(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_parse_ld_sections:
    pushl %ebp
    movl %esp, %ebp
    subl $544, %esp
    movl 8(%ebp), %eax
    movl %eax, -296(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -288(%ebp)
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_0
    pushl -296(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lparse_ld_sections_0:
.Lparse_ld_sections_1:
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
.Lparse_ld_sections_2:
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    je .Lparse_ld_sections_5
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_3
.Lparse_ld_sections_5:
.Lparse_ld_sections_6:
    pushl -296(%ebp)
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
    je .Lparse_ld_sections_7
    jmp .Lparse_ld_sections_3
.Lparse_ld_sections_7:
.Lparse_ld_sections_8:
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_9
.Lparse_ld_sections_11:
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_15
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isspace
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
    jmp .Lparse_ld_sections_16
.Lparse_ld_sections_15:
    pushl $0
.Lparse_ld_sections_16:
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_13
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $125
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
    jmp .Lparse_ld_sections_14
.Lparse_ld_sections_13:
    pushl $0
.Lparse_ld_sections_14:
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_12
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_11
.Lparse_ld_sections_12:
    jmp .Lparse_ld_sections_4
.Lparse_ld_sections_9:
.Lparse_ld_sections_10:
    leal -280(%ebp), %eax
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
    leal -216(%ebp), %eax
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
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -48(%ebp)
    pushl -48(%ebp)
    addl $4, %esp
    leal -280(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _read_section_name
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    leal -280(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_17
    jmp .Lparse_ld_sections_4
.Lparse_ld_sections_17:
.Lparse_ld_sections_18:
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    jne .Lparse_ld_sections_21
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _isdigit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lparse_ld_sections_22
.Lparse_ld_sections_21:
    pushl $1
.Lparse_ld_sections_22:
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_19
    leal -72(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _read_addr
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl $1
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_20
.Lparse_ld_sections_19:
.Lparse_ld_sections_20:
    pushl -296(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_23
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_24
.Lparse_ld_sections_23:
.Lparse_ld_sections_24:
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    je .Lparse_ld_sections_25
    leal -48(%ebp), %eax
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _collect_braces
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_26
.Lparse_ld_sections_25:
.Lparse_ld_sections_26:
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    je .Lparse_ld_sections_27
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    leal -216(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    leal -152(%ebp), %eax
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
    leal -152(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    leal ark_str_11, %eax
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_29
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
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
    je .Lparse_ld_sections_31
    pushl -296(%ebp)
    pushl -296(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    leal -136(%ebp), %eax
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
    leal -136(%ebp), %eax
    pushl %eax
    pushl -296(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    pushl -296(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_32
.Lparse_ld_sections_31:
.Lparse_ld_sections_32:
    jmp .Lparse_ld_sections_30
.Lparse_ld_sections_29:
    pushl -16(%ebp)
    popl %eax
    movl %eax, -296(%ebp)
    pushl -296(%ebp)
    addl $4, %esp
.Lparse_ld_sections_30:
    jmp .Lparse_ld_sections_28
.Lparse_ld_sections_27:
.Lparse_ld_sections_28:
    leal -216(%ebp), %eax
    pushl %eax
    pushl -288(%ebp)
    call _find_load_region
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_33
    pushl -288(%ebp)
    call _first_or_default_load_region
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_34
.Lparse_ld_sections_33:
.Lparse_ld_sections_34:
    pushl $20
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -280(%ebp), %eax
    pushl %eax
    call _make_er_name
    addl $4, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_35
    pushl -72(%ebp)
    jmp .Lparse_ld_sections_36
.Lparse_ld_sections_35:
    pushl $0
.Lparse_ld_sections_36:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
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
    pushl -32(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_37
    pushl -56(%ebp)
    jmp .Lparse_ld_sections_38
.Lparse_ld_sections_37:
    leal ark_str_12, %eax
    pushl %eax
    call _mem_strdup
    addl $4, %esp
    pushl %eax
.Lparse_ld_sections_38:
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -32(%ebp)
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
    pushl -40(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lparse_ld_sections_39:
    pushl -24(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lparse_ld_sections_40
    pushl -24(%ebp)
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
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lparse_ld_sections_39
.Lparse_ld_sections_40:
    pushl -24(%ebp)
    pushl -32(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lparse_ld_sections_4:
    jmp .Lparse_ld_sections_2
.Lparse_ld_sections_3:
    pushl -296(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _linker_script_parse_file
_linker_script_parse_file:
    pushl %ebp
    movl %esp, %ebp
    subl $384, %esp
    movl 8(%ebp), %eax
    movl %eax, -136(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -128(%ebp)
    pushl -136(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llinker_script_parse_file_2
    pushl -128(%ebp)
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
    jmp .Llinker_script_parse_file_3
.Llinker_script_parse_file_2:
    pushl $1
.Llinker_script_parse_file_3:
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llinker_script_parse_file_0:
.Llinker_script_parse_file_1:
    leal ark_str_13, %eax
    pushl %eax
    pushl -136(%ebp)
    call _fopen
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_4
    pushl -136(%ebp)
    leal ark_str_14, %eax
    pushl %eax
    call _ark_log
    addl $8, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llinker_script_parse_file_4:
.Llinker_script_parse_file_5:
    pushl $2
    pushl $0
    pushl -120(%ebp)
    call _fseek
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -120(%ebp)
    call _ftell
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl $0
    pushl $0
    pushl -120(%ebp)
    call _fseek
    addl $12, %esp
    pushl %eax
    addl $4, %esp
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_6
    pushl -120(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llinker_script_parse_file_6:
.Llinker_script_parse_file_7:
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    pushl -112(%ebp)
    pushl $1
    pushl -104(%ebp)
    call _fread
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -88(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setle %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_8
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llinker_script_parse_file_8:
.Llinker_script_parse_file_9:
    pushl -104(%ebp)
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
    pushl -104(%ebp)
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
.Llinker_script_parse_file_10:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_11
    pushl -96(%ebp)
    call _skip_ld_ws
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl -96(%ebp)
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
    je .Llinker_script_parse_file_12
    jmp .Llinker_script_parse_file_11
.Llinker_script_parse_file_12:
.Llinker_script_parse_file_13:
    leal -80(%ebp), %eax
    pushl %eax
    pushl -96(%ebp)
    call _read_ident
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    leal -80(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_14
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
    jmp .Llinker_script_parse_file_10
.Llinker_script_parse_file_14:
.Llinker_script_parse_file_15:
    leal ark_str_15, %eax
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_16
    pushl -128(%ebp)
    pushl -96(%ebp)
    call _parse_ld_memory
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Llinker_script_parse_file_17
.Llinker_script_parse_file_16:
    leal ark_str_16, %eax
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_18
    pushl -128(%ebp)
    pushl -96(%ebp)
    call _parse_ld_sections
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    jmp .Llinker_script_parse_file_19
.Llinker_script_parse_file_18:
.Llinker_script_parse_file_20:
    pushl -96(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_22
    pushl -96(%ebp)
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
    jmp .Llinker_script_parse_file_23
.Llinker_script_parse_file_22:
    pushl $0
.Llinker_script_parse_file_23:
    popl %eax
    cmpl $0, %eax
    je .Llinker_script_parse_file_21
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
    jmp .Llinker_script_parse_file_20
.Llinker_script_parse_file_21:
.Llinker_script_parse_file_19:
.Llinker_script_parse_file_17:
    jmp .Llinker_script_parse_file_10
.Llinker_script_parse_file_11:
    pushl -136(%ebp)
    leal ark_str_17, %eax
    pushl %eax
    call _ark_log
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

    .globl _scatter_lookup_addr
_scatter_lookup_addr:
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
    jne .Lscatter_lookup_addr_2
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
    jmp .Lscatter_lookup_addr_3
.Lscatter_lookup_addr_2:
    pushl $1
.Lscatter_lookup_addr_3:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_lookup_addr_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_lookup_addr_0:
.Lscatter_lookup_addr_1:
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lscatter_lookup_addr_4:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_lookup_addr_5
    pushl -24(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lscatter_lookup_addr_7:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_lookup_addr_8
    pushl -16(%ebp)
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
    je .Lscatter_lookup_addr_12
    pushl -32(%ebp)
    pushl -16(%ebp)
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
    call _strstr
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lscatter_lookup_addr_13
.Lscatter_lookup_addr_12:
    pushl $0
.Lscatter_lookup_addr_13:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_lookup_addr_10
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_lookup_addr_10:
.Lscatter_lookup_addr_11:
.Lscatter_lookup_addr_9:
    pushl -16(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lscatter_lookup_addr_7
.Lscatter_lookup_addr_8:
.Lscatter_lookup_addr_6:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lscatter_lookup_addr_4
.Lscatter_lookup_addr_5:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_put_fmt:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    leal 24(%ebp), %eax
    movl %eax, __ark_va_ptr
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 20(%ebp), %eax
    movl %eax, -32(%ebp)
    movl __ark_va_ptr, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lput_fmt_2
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    pushl -48(%ebp)
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
    jmp .Lput_fmt_3
.Lput_fmt_2:
    pushl $0
.Lput_fmt_3:
    popl %eax
    cmpl $0, %eax
    je .Lput_fmt_0
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl -48(%ebp)
    pushl -40(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -40(%ebp)
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
    call _vsnprintf
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lput_fmt_1
.Lput_fmt_0:
    pushl -24(%ebp)
    pushl -32(%ebp)
    pushl $0
    pushl $0
    call _vsnprintf
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lput_fmt_1:
    pushl $0
    addl $4, %esp
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lput_fmt_4
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lput_fmt_4:
.Lput_fmt_5:
    pushl -40(%ebp)
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
    pushl -16(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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

_derive_section_name:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_0
    leal ark_str_18, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_2
    leal ark_str_19, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_2:
.Lderive_section_name_3:
    leal ark_str_20, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_4
    leal ark_str_21, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_4:
.Lderive_section_name_5:
    leal ark_str_22, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_6
    leal ark_str_23, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_6:
.Lderive_section_name_7:
    leal ark_str_24, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_8
    leal ark_str_25, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_8:
.Lderive_section_name_9:
    leal ark_str_26, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_10
    leal ark_str_27, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_10:
.Lderive_section_name_11:
    leal ark_str_28, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_12
    leal ark_str_29, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_12:
.Lderive_section_name_13:
    leal ark_str_30, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lderive_section_name_16
    leal ark_str_31, %eax
    pushl %eax
    pushl -24(%ebp)
    call _strstr
    addl $8, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lderive_section_name_17
.Lderive_section_name_16:
    pushl $1
.Lderive_section_name_17:
    popl %eax
    cmpl $0, %eax
    je .Lderive_section_name_14
    leal ark_str_32, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lderive_section_name_14:
.Lderive_section_name_15:
    jmp .Lderive_section_name_1
.Lderive_section_name_0:
.Lderive_section_name_1:
    leal ark_str_33, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _scatter_to_ld_script
_scatter_to_ld_script:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -56(%ebp)
    pushl $0
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
    je .Lscatter_to_ld_script_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_to_ld_script_0:
.Lscatter_to_ld_script_1:
    pushl -64(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_4
    pushl -56(%ebp)
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
    jmp .Lscatter_to_ld_script_5
.Lscatter_to_ld_script_4:
    pushl $0
.Lscatter_to_ld_script_5:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_2
    pushl -64(%ebp)
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
    jmp .Lscatter_to_ld_script_3
.Lscatter_to_ld_script_2:
.Lscatter_to_ld_script_3:
    leal ark_str_34, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $16, %esp
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
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lscatter_to_ld_script_6:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_7
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
    leal ark_str_35, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $28, %esp
    pushl %eax
    addl $4, %esp
.Lscatter_to_ld_script_8:
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_6
.Lscatter_to_ld_script_7:
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
    addl $4, %esp
.Lscatter_to_ld_script_9:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_10
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lscatter_to_ld_script_12:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_13
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lscatter_to_ld_script_15:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_16
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
    je .Lscatter_to_ld_script_18
    pushl $1
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_16
.Lscatter_to_ld_script_18:
.Lscatter_to_ld_script_19:
.Lscatter_to_ld_script_17:
    pushl -16(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_15
.Lscatter_to_ld_script_16:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_20
    jmp .Lscatter_to_ld_script_14
.Lscatter_to_ld_script_20:
.Lscatter_to_ld_script_21:
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
    leal ark_str_36, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $28, %esp
    pushl %eax
    addl $4, %esp
.Lscatter_to_ld_script_14:
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_12
.Lscatter_to_ld_script_13:
.Lscatter_to_ld_script_11:
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_9
.Lscatter_to_ld_script_10:
    leal ark_str_37, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_38, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $16, %esp
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
    popl %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
.Lscatter_to_ld_script_22:
    pushl -40(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_23
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
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
.Lscatter_to_ld_script_25:
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_26
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
    call _derive_section_name
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
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
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_28
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
    jmp .Lscatter_to_ld_script_29
.Lscatter_to_ld_script_28:
    leal ark_str_39, %eax
    pushl %eax
.Lscatter_to_ld_script_29:
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
    pushl -24(%ebp)
    leal ark_str_40, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $32, %esp
    pushl %eax
    addl $4, %esp
    leal ark_str_41, %eax
    pushl %eax
    pushl -24(%ebp)
    call _ark_streq
    addl $8, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_ld_script_30
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
    leal ark_str_42, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lscatter_to_ld_script_31
.Lscatter_to_ld_script_30:
.Lscatter_to_ld_script_31:
    leal ark_str_43, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lscatter_to_ld_script_27:
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
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_25
.Lscatter_to_ld_script_26:
.Lscatter_to_ld_script_24:
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
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_ld_script_22
.Lscatter_to_ld_script_23:
    leal ark_str_44, %eax
    pushl %eax
    leal -48(%ebp), %eax
    pushl %eax
    pushl -56(%ebp)
    pushl -64(%ebp)
    call _put_fmt
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -48(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _scatter_to_sct_file
_scatter_to_sct_file:
    pushl %ebp
    movl %esp, %ebp
    subl $304, %esp
    movl 8(%ebp), %eax
    movl %eax, -56(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -48(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl $0
    popl %eax
    movl %eax, -32(%ebp)
    pushl -56(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_0
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lscatter_to_sct_file_0:
.Lscatter_to_sct_file_1:
    pushl -48(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_4
    pushl -40(%ebp)
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
    jmp .Lscatter_to_sct_file_5
.Lscatter_to_sct_file_4:
    pushl $0
.Lscatter_to_sct_file_5:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_2
    pushl -48(%ebp)
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
    jmp .Lscatter_to_sct_file_3
.Lscatter_to_sct_file_2:
.Lscatter_to_sct_file_3:
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lscatter_to_sct_file_6:
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_7
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
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    imull $4, %ecx
    addl %ecx, %eax
    movl (%eax), %eax
    pushl %eax
    leal ark_str_45, %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    call _put_fmt
    addl $28, %esp
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lscatter_to_sct_file_9:
    pushl -16(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_10
    pushl -16(%ebp)
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
    leal ark_str_46, %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    call _put_fmt
    addl $28, %esp
    pushl %eax
    addl $4, %esp
    pushl -16(%ebp)
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
    je .Lscatter_to_sct_file_14
    pushl -16(%ebp)
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
    jmp .Lscatter_to_sct_file_15
.Lscatter_to_sct_file_14:
    pushl $0
.Lscatter_to_sct_file_15:
    popl %eax
    cmpl $0, %eax
    je .Lscatter_to_sct_file_12
    pushl -16(%ebp)
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
    leal ark_str_47, %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    call _put_fmt
    addl $20, %esp
    pushl %eax
    addl $4, %esp
    jmp .Lscatter_to_sct_file_13
.Lscatter_to_sct_file_12:
.Lscatter_to_sct_file_13:
    leal ark_str_48, %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    call _put_fmt
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lscatter_to_sct_file_11:
    pushl -16(%ebp)
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
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_sct_file_9
.Lscatter_to_sct_file_10:
    leal ark_str_49, %eax
    pushl %eax
    leal -32(%ebp), %eax
    pushl %eax
    pushl -40(%ebp)
    pushl -48(%ebp)
    call _put_fmt
    addl $16, %esp
    pushl %eax
    addl $4, %esp
.Lscatter_to_sct_file_8:
    pushl -24(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lscatter_to_sct_file_6
.Lscatter_to_sct_file_7:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

