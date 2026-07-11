# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .globl _g_keywords
_g_keywords:
    .long ark_str_8
    .long 1
    .long ark_str_9
    .long 2
    .long ark_str_10
    .long 3
    .long ark_str_11
    .long 4
    .long ark_str_12
    .long 5
    .long ark_str_13
    .long 6
    .long ark_str_14
    .long 7
    .long ark_str_15
    .long 8
    .long ark_str_16
    .long 9
    .long ark_str_17
    .long 10
    .long ark_str_18
    .long 11
    .long ark_str_19
    .long 59
    .long ark_str_20
    .long 60
    .long ark_str_21
    .long 61
    .long ark_str_22
    .long 62
    .long ark_str_23
    .long 63
    .long ark_str_24
    .long 64
    .long ark_str_25
    .long 65
    .long ark_str_26
    .long 66
    .long ark_str_27
    .long 67
    .long ark_str_28
    .long 68
    .long ark_str_29
    .long 69
    .long ark_str_30
    .long 70
    .long ark_str_31
    .long 71
    .long ark_str_32
    .long 72
    .long ark_str_33
    .long 73
    .long ark_str_34
    .long 74
    .long ark_str_35
    .long 75
    .long ark_str_36
    .long 76
    .long ark_str_37
    .long 77
    .long ark_str_38
    .long 78
    .long ark_str_39
    .long 79
    .long ark_str_40
    .long 80
    .long ark_str_41
    .long 81
    .long ark_str_42
    .long 82
    .long ark_str_43
    .long 87
    .long ark_str_44
    .long 88
    .long ark_str_45
    .long 88
    .long ark_str_46
    .long 88
    .long ark_str_47
    .long 69
    .long ark_str_48
    .long 69
    .long ark_str_49
    .long 67
    .long ark_str_50
    .long 66
    .long ark_str_51
    .long 68
    .long ark_str_52
    .long 90
    .long ark_str_53
    .long 91
    .long ark_str_54
    .long 92
    .long ark_str_55
    .long 93
    .long ark_str_56
    .long 94
    .long ark_str_57
    .long 95
    .long ark_str_58
    .long 96
    .long ark_str_59
    .long 97
    .long ark_str_60
    .long 98
    .long ark_str_61
    .long 100
    .long ark_str_62
    .long 100
    .long 0
    .long 0
    .section .rdata,"dr"
ark_str_0:
    .asciz "[lexer] line %d: unknown char '%c' (0x%02X)\n"
ark_str_1:
    .asciz "[parser] line %d: expected token kind %d but got %d\n"
ark_str_2:
    .asciz "EOF"
ark_str_3:
    .asciz "ident"
ark_str_4:
    .asciz "num"
ark_str_5:
    .asciz "str"
ark_str_6:
    .asciz "fconst"
ark_str_7:
    .asciz "tok"
ark_str_8:
    .asciz "int"
ark_str_9:
    .asciz "char"
ark_str_10:
    .asciz "void"
ark_str_11:
    .asciz "return"
ark_str_12:
    .asciz "if"
ark_str_13:
    .asciz "else"
ark_str_14:
    .asciz "while"
ark_str_15:
    .asciz "for"
ark_str_16:
    .asciz "break"
ark_str_17:
    .asciz "continue"
ark_str_18:
    .asciz "do"
ark_str_19:
    .asciz "short"
ark_str_20:
    .asciz "long"
ark_str_21:
    .asciz "signed"
ark_str_22:
    .asciz "unsigned"
ark_str_23:
    .asciz "float"
ark_str_24:
    .asciz "double"
ark_str_25:
    .asciz "_Bool"
ark_str_26:
    .asciz "const"
ark_str_27:
    .asciz "volatile"
ark_str_28:
    .asciz "restrict"
ark_str_29:
    .asciz "inline"
ark_str_30:
    .asciz "static"
ark_str_31:
    .asciz "extern"
ark_str_32:
    .asciz "auto"
ark_str_33:
    .asciz "register"
ark_str_34:
    .asciz "struct"
ark_str_35:
    .asciz "union"
ark_str_36:
    .asciz "enum"
ark_str_37:
    .asciz "typedef"
ark_str_38:
    .asciz "sizeof"
ark_str_39:
    .asciz "switch"
ark_str_40:
    .asciz "case"
ark_str_41:
    .asciz "default"
ark_str_42:
    .asciz "goto"
ark_str_43:
    .asciz "__attribute__"
ark_str_44:
    .asciz "asm"
ark_str_45:
    .asciz "__asm"
ark_str_46:
    .asciz "__asm__"
ark_str_47:
    .asciz "__inline"
ark_str_48:
    .asciz "__inline__"
ark_str_49:
    .asciz "__volatile__"
ark_str_50:
    .asciz "__const"
ark_str_51:
    .asciz "__restrict"
ark_str_52:
    .asciz "__svc"
ark_str_53:
    .asciz "__irq"
ark_str_54:
    .asciz "__weak"
ark_str_55:
    .asciz "__naked"
ark_str_56:
    .asciz "__packed"
ark_str_57:
    .asciz "__align"
ark_str_58:
    .asciz "__at"
ark_str_59:
    .asciz "__softfp"
ark_str_60:
    .asciz "__forceinline"
ark_str_61:
    .asciz "_Complex"
ark_str_62:
    .asciz "__complex__"
    .text
_utf8_encode:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    pushl $128
    popl %eax
    cmpl $0, %eax
    je .Lutf8_encode_0
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lutf8_encode_0:
    pushl -24(%ebp)
    pushl $2048
    popl %eax
    cmpl $0, %eax
    je .Lutf8_encode_2
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $192
    pushl -24(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $2
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lutf8_encode_2:
    pushl -24(%ebp)
    pushl $65536
    popl %eax
    cmpl $0, %eax
    je .Lutf8_encode_4
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $224
    pushl -24(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $6
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $3
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lutf8_encode_4:
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $240
    pushl -24(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $12
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $6
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -16(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -24(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $4
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lutf8_encode_5:
.Lutf8_encode_3:
.Lutf8_encode_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_lexer_read_token_with_pos:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
.Llexer_read_token_with_pos_0:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_1
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_with_pos_6
    movzbl -24(%ebp), %eax
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
    jmp .Llexer_read_token_with_pos_7
.Llexer_read_token_with_pos_6:
    pushl $1
.Llexer_read_token_with_pos_7:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_with_pos_4
    movzbl -24(%ebp), %eax
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
    jmp .Llexer_read_token_with_pos_5
.Llexer_read_token_with_pos_4:
    pushl $1
.Llexer_read_token_with_pos_5:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_2
    pushl -88(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_3
.Llexer_read_token_with_pos_2:
    movzbl -24(%ebp), %eax
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
    je .Llexer_read_token_with_pos_8
    pushl -88(%ebp)
    pushl $8
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
    addl $4, %esp
    pushl -88(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_9
.Llexer_read_token_with_pos_8:
    movzbl -24(%ebp), %eax
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
    je .Llexer_read_token_with_pos_12
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
    jmp .Llexer_read_token_with_pos_13
.Llexer_read_token_with_pos_12:
    pushl $0
.Llexer_read_token_with_pos_13:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_10
.Llexer_read_token_with_pos_14:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_16
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
    jmp .Llexer_read_token_with_pos_17
.Llexer_read_token_with_pos_16:
    pushl $0
.Llexer_read_token_with_pos_17:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_15
    pushl -88(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_14
.Llexer_read_token_with_pos_15:
    jmp .Llexer_read_token_with_pos_11
.Llexer_read_token_with_pos_10:
    movzbl -24(%ebp), %eax
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
    je .Llexer_read_token_with_pos_20
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
    jmp .Llexer_read_token_with_pos_21
.Llexer_read_token_with_pos_20:
    pushl $0
.Llexer_read_token_with_pos_21:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_18
    pushl -88(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Llexer_read_token_with_pos_22:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_24
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
    je .Llexer_read_token_with_pos_26
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
    jmp .Llexer_read_token_with_pos_27
.Llexer_read_token_with_pos_26:
    pushl $0
.Llexer_read_token_with_pos_27:
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
    jmp .Llexer_read_token_with_pos_25
.Llexer_read_token_with_pos_24:
    pushl $0
.Llexer_read_token_with_pos_25:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_23
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
    je .Llexer_read_token_with_pos_28
    pushl -88(%ebp)
    pushl $8
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
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_29
.Llexer_read_token_with_pos_28:
.Llexer_read_token_with_pos_29:
    pushl -88(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_22
.Llexer_read_token_with_pos_23:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_30
    pushl -88(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_31
.Llexer_read_token_with_pos_30:
.Llexer_read_token_with_pos_31:
    jmp .Llexer_read_token_with_pos_19
.Llexer_read_token_with_pos_18:
    jmp .Llexer_read_token_with_pos_1
.Llexer_read_token_with_pos_19:
.Llexer_read_token_with_pos_11:
.Llexer_read_token_with_pos_9:
.Llexer_read_token_with_pos_3:
    jmp .Llexer_read_token_with_pos_0
.Llexer_read_token_with_pos_1:
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
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
    leal -72(%ebp), %eax
    pushl %eax
    pushl -88(%ebp)
    call _lexer_read_token
    addl $4, %esp
    pushl %eax
    leal -72(%ebp), %eax
    pushl %eax
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
    pushl %eax
    addl $4, %esp
    leal -72(%ebp), %eax
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
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_with_pos_32
    leal -72(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_with_pos_33
.Llexer_read_token_with_pos_32:
.Llexer_read_token_with_pos_33:
    leal -72(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alpha:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lis_alpha_4
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $122
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
    jmp .Lis_alpha_5
.Lis_alpha_4:
    pushl $0
.Lis_alpha_5:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_2
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
    je .Lis_alpha_6
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
    jmp .Lis_alpha_7
.Lis_alpha_6:
    pushl $0
.Lis_alpha_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alpha_3
.Lis_alpha_2:
    pushl $1
.Lis_alpha_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_alpha_0
    movzbl -24(%ebp), %eax
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
    jmp .Lis_alpha_1
.Lis_alpha_0:
    pushl $1
.Lis_alpha_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_digit:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lis_digit_0
    movzbl -24(%ebp), %eax
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
    jmp .Lis_digit_1
.Lis_digit_0:
    pushl $0
.Lis_digit_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_alnum:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_alnum_0
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_alnum_1
.Lis_alnum_0:
    pushl $1
.Lis_alnum_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_hex:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lis_hex_2
    movzbl -24(%ebp), %eax
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
    je .Lis_hex_4
    movzbl -24(%ebp), %eax
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
    jmp .Lis_hex_5
.Lis_hex_4:
    pushl $0
.Lis_hex_5:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_hex_3
.Lis_hex_2:
    pushl $1
.Lis_hex_3:
    popl %eax
    cmpl $0, %eax
    jne .Lis_hex_0
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
    je .Lis_hex_6
    movzbl -24(%ebp), %eax
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
    jmp .Lis_hex_7
.Lis_hex_6:
    pushl $0
.Lis_hex_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lis_hex_1
.Lis_hex_0:
    pushl $1
.Lis_hex_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_oct:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lis_oct_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $55
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
    jmp .Lis_oct_1
.Lis_oct_0:
    pushl $0
.Lis_oct_1:
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_is_ident_start:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_alpha
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_ident_start_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_ident_start_0:
.Lis_ident_start_1:
    movzbl -24(%ebp), %eax
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

_is_ident_char:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
    pushl %eax
    call _is_alnum
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lis_ident_char_0
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lis_ident_char_0:
.Lis_ident_char_1:
    movzbl -24(%ebp), %eax
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

_hex_val:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movzbl -24(%ebp), %eax
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
    je .Lhex_val_2
    movzbl -24(%ebp), %eax
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
    jmp .Lhex_val_3
.Lhex_val_2:
    pushl $0
.Lhex_val_3:
    popl %eax
    cmpl $0, %eax
    je .Lhex_val_0
    movzbl -24(%ebp), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhex_val_0:
.Lhex_val_1:
    movzbl -24(%ebp), %eax
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
    je .Lhex_val_6
    movzbl -24(%ebp), %eax
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
    jmp .Lhex_val_7
.Lhex_val_6:
    pushl $0
.Lhex_val_7:
    popl %eax
    cmpl $0, %eax
    je .Lhex_val_4
    movzbl -24(%ebp), %eax
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lhex_val_4:
.Lhex_val_5:
    movzbl -24(%ebp), %eax
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
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_make_token:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -64(%ebp)
    leal -56(%ebp), %eax
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
    leal -56(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -56(%ebp), %eax
    pushl %eax
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
    leal -56(%ebp), %eax
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
    leal -56(%ebp), %eax
    pushl %eax
    pushl $28
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
    leal -56(%ebp), %eax
    pushl %eax
    pushl $32
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
    leal -56(%ebp), %eax
    pushl %eax
    pushl $36
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
    leal -56(%ebp), %eax
    pushl %eax
    pushl $40
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
    leal -56(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_make_number:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -68(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    pushl $12
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -56(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl -68(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -56(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_make_ident:
    pushl %ebp
    movl %esp, %ebp
    subl $336, %esp
    movl 8(%ebp), %eax
    movl %eax, -88(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -80(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $14
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -80(%ebp)
    pushl -88(%ebp)
    call _mem_strndup
    addl $8, %esp
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -64(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_kw_eq:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -32(%ebp)
    movl 16(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    addl $4, %esp
.Lkw_eq_0:
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
    je .Lkw_eq_1
    pushl -40(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lkw_eq_3
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lkw_eq_3:
.Lkw_eq_4:
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
    je .Lkw_eq_5
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lkw_eq_5:
.Lkw_eq_6:
.Lkw_eq_2:
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
    jmp .Lkw_eq_0
.Lkw_eq_1:
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
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_check_keyword:
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
    pushl -24(%ebp)
    addl $4, %esp
.Lcheck_keyword_0:
    movl $_g_keywords, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
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
    popl %eax
    cmpl $0, %eax
    je .Lcheck_keyword_1
    movl $_g_keywords, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
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
    pushl -32(%ebp)
    pushl -40(%ebp)
    call _kw_eq
    addl $12, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lcheck_keyword_3
    movl $_g_keywords, %eax
    pushl %eax
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
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
    movl %ebp, %esp
    popl %ebp
    ret
.Lcheck_keyword_3:
.Lcheck_keyword_4:
.Lcheck_keyword_2:
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
    jmp .Lcheck_keyword_0
.Lcheck_keyword_1:
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_skip_ws_and_comments:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
.Lskip_ws_and_comments_0:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_1
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -16(%ebp)
    movzbl -16(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lskip_ws_and_comments_6
    movzbl -16(%ebp), %eax
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
    jmp .Lskip_ws_and_comments_7
.Lskip_ws_and_comments_6:
    pushl $1
.Lskip_ws_and_comments_7:
    popl %eax
    cmpl $0, %eax
    jne .Lskip_ws_and_comments_4
    movzbl -16(%ebp), %eax
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
    jmp .Lskip_ws_and_comments_5
.Lskip_ws_and_comments_4:
    pushl $1
.Lskip_ws_and_comments_5:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_2
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
    addl $4, %esp
    jmp .Lskip_ws_and_comments_3
.Lskip_ws_and_comments_2:
    movzbl -16(%ebp), %eax
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
    je .Lskip_ws_and_comments_8
    pushl -24(%ebp)
    pushl $8
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
    addl $4, %esp
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
    addl $4, %esp
    jmp .Lskip_ws_and_comments_9
.Lskip_ws_and_comments_8:
    movzbl -16(%ebp), %eax
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
    je .Lskip_ws_and_comments_12
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
    jmp .Lskip_ws_and_comments_13
.Lskip_ws_and_comments_12:
    pushl $0
.Lskip_ws_and_comments_13:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_10
.Lskip_ws_and_comments_14:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_16
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
    jmp .Lskip_ws_and_comments_17
.Lskip_ws_and_comments_16:
    pushl $0
.Lskip_ws_and_comments_17:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_15
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
    addl $4, %esp
    jmp .Lskip_ws_and_comments_14
.Lskip_ws_and_comments_15:
    jmp .Lskip_ws_and_comments_11
.Lskip_ws_and_comments_10:
    movzbl -16(%ebp), %eax
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
    je .Lskip_ws_and_comments_20
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
    jmp .Lskip_ws_and_comments_21
.Lskip_ws_and_comments_20:
    pushl $0
.Lskip_ws_and_comments_21:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_18
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Lskip_ws_and_comments_22:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_24
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
    je .Lskip_ws_and_comments_26
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
    jmp .Lskip_ws_and_comments_27
.Lskip_ws_and_comments_26:
    pushl $0
.Lskip_ws_and_comments_27:
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
    jmp .Lskip_ws_and_comments_25
.Lskip_ws_and_comments_24:
    pushl $0
.Lskip_ws_and_comments_25:
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_23
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
    je .Lskip_ws_and_comments_28
    pushl -24(%ebp)
    pushl $8
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
    addl $4, %esp
    jmp .Lskip_ws_and_comments_29
.Lskip_ws_and_comments_28:
.Lskip_ws_and_comments_29:
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
    addl $4, %esp
    jmp .Lskip_ws_and_comments_22
.Lskip_ws_and_comments_23:
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
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lskip_ws_and_comments_30
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Lskip_ws_and_comments_31
.Lskip_ws_and_comments_30:
.Lskip_ws_and_comments_31:
    jmp .Lskip_ws_and_comments_19
.Lskip_ws_and_comments_18:
    jmp .Lskip_ws_and_comments_1
.Lskip_ws_and_comments_19:
.Lskip_ws_and_comments_11:
.Lskip_ws_and_comments_9:
.Lskip_ws_and_comments_3:
    jmp .Lskip_ws_and_comments_0
.Lskip_ws_and_comments_1:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_read_escape:
    pushl %ebp
    movl %esp, %ebp
    subl $288, %esp
    movl 8(%ebp), %eax
    movl %eax, -40(%ebp)
    pushl -40(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -32(%ebp)
    movzbl -32(%ebp), %eax
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
    je .Lread_escape_0
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
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lread_escape_2:
    pushl -40(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_escape_3
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _hex_val
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
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
    addl $4, %esp
    jmp .Lread_escape_2
.Lread_escape_3:
    pushl -24(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_0:
.Lread_escape_1:
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
    je .Lread_escape_6
    movzbl -32(%ebp), %eax
    pushl %eax
    pushl $55
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
    jmp .Lread_escape_7
.Lread_escape_6:
    pushl $0
.Lread_escape_7:
    popl %eax
    cmpl $0, %eax
    je .Lread_escape_4
    pushl $0
    popl %eax
    movl %eax, -16(%ebp)
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
.Lread_escape_8:
    pushl -16(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lread_escape_10
    pushl -40(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_oct
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Lread_escape_11
.Lread_escape_10:
    pushl $0
.Lread_escape_11:
    popl %eax
    cmpl $0, %eax
    je .Lread_escape_9
    pushl -24(%ebp)
    pushl $8
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -40(%ebp)
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
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
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
    addl $4, %esp
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
    jmp .Lread_escape_8
.Lread_escape_9:
    pushl -24(%ebp)
    pushl $255
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_4:
.Lread_escape_5:
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
    addl $4, %esp
    movzbl -32(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $110
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_13
    pushl -16(%ebp)
    pushl $116
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_14
    pushl -16(%ebp)
    pushl $114
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_15
    pushl -16(%ebp)
    pushl $92
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_16
    pushl -16(%ebp)
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_17
    pushl -16(%ebp)
    pushl $34
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_18
    pushl -16(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_19
    pushl -16(%ebp)
    pushl $97
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_20
    pushl -16(%ebp)
    pushl $98
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_21
    pushl -16(%ebp)
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_22
    pushl -16(%ebp)
    pushl $118
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_23
    pushl -16(%ebp)
    pushl $48
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lread_escape_24
    jmp .Lread_escape_25
.Lread_escape_13:
    pushl $10
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_14:
    pushl $9
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_15:
    pushl $13
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_16:
    pushl $92
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_17:
    pushl $39
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_18:
    pushl $34
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_19:
    pushl $63
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_20:
    pushl $7
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_21:
    pushl $8
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_22:
    pushl $12
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_23:
    pushl $11
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_24:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_25:
    movzbl -32(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lread_escape_12:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

_lexer_read_token:
    pushl %ebp
    movl %esp, %ebp
    subl $512, %esp
    movl 8(%ebp), %eax
    movl %eax, -264(%ebp)
    pushl -264(%ebp)
    call _skip_ws_and_comments
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -264(%ebp)
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
    movl %eax, -256(%ebp)
    pushl -256(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    movl %eax, -248(%ebp)
    pushl -248(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -240(%ebp)
    pushl -240(%ebp)
    addl $4, %esp
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_0
    leal -232(%ebp), %eax
    pushl %eax
    pushl -248(%ebp)
    pushl $0
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -232(%ebp), %eax
    pushl %eax
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
    pushl %eax
    addl $4, %esp
    leal -232(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -256(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -232(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_0:
.Llexer_read_token_1:
    movzbl -240(%ebp), %eax
    pushl %eax
    call _is_ident_start
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_4
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_6
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_8
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_9
.Llexer_read_token_8:
    pushl $1
.Llexer_read_token_9:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_7
.Llexer_read_token_6:
    pushl $0
.Llexer_read_token_7:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_5
.Llexer_read_token_4:
    pushl $1
.Llexer_read_token_5:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_2
    pushl $32
    popl %eax
    movl %eax, -176(%ebp)
    pushl $0
    popl %eax
    movl %eax, -168(%ebp)
    pushl -176(%ebp)
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_10
    jmp .Llexer_read_token_11
.Llexer_read_token_10:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movzbl -240(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_11:
.Llexer_read_token_12:
    pushl $1
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_13
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -152(%ebp)
    movzbl -152(%ebp), %eax
    pushl %eax
    call _is_ident_char
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_14
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_16
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -144(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_17
.Llexer_read_token_16:
.Llexer_read_token_17:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movzbl -152(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_15
.Llexer_read_token_14:
    movzbl -152(%ebp), %eax
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
    je .Llexer_read_token_20
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_22
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_23
.Llexer_read_token_22:
    pushl $1
.Llexer_read_token_23:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_21
.Llexer_read_token_20:
    pushl $0
.Llexer_read_token_21:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_18
    pushl $0
    popl %eax
    movl %eax, -144(%ebp)
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -120(%ebp)
    pushl -264(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movzbl -120(%ebp), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_24
    pushl $4
    jmp .Llexer_read_token_25
.Llexer_read_token_24:
    pushl $8
.Llexer_read_token_25:
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -128(%ebp)
    addl $4, %esp
.Llexer_read_token_26:
    pushl -128(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_27
    pushl -264(%ebp)
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
    pushl -128(%ebp)
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
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_29
    jmp .Llexer_read_token_27
.Llexer_read_token_29:
.Llexer_read_token_30:
    pushl -144(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -264(%ebp)
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
    pushl -128(%ebp)
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
    call _hex_val
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -144(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
.Llexer_read_token_28:
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_26
.Llexer_read_token_27:
    pushl -128(%ebp)
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_31
    pushl -264(%ebp)
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
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -144(%ebp)
    pushl $128
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_33
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_35
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_36
.Llexer_read_token_35:
.Llexer_read_token_36:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -144(%ebp)
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_34
.Llexer_read_token_33:
    pushl -144(%ebp)
    pushl $2048
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_37
    pushl -168(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_39
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_40
.Llexer_read_token_39:
.Llexer_read_token_40:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $192
    pushl -144(%ebp)
    pushl $6
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_38
.Llexer_read_token_37:
    pushl -144(%ebp)
    pushl $65536
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_41
    pushl -168(%ebp)
    pushl $3
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_43
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_44
.Llexer_read_token_43:
.Llexer_read_token_44:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $224
    pushl -144(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $6
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_42
.Llexer_read_token_41:
    pushl -168(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_45
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_46
.Llexer_read_token_45:
.Llexer_read_token_46:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $240
    pushl -144(%ebp)
    pushl $18
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $12
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $6
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $128
    pushl -144(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    andl %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    orl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Llexer_read_token_42:
.Llexer_read_token_38:
.Llexer_read_token_34:
    jmp .Llexer_read_token_32
.Llexer_read_token_31:
    pushl -168(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -176(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_47
    pushl -176(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    pushl -176(%ebp)
    pushl -184(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    movl %eax, -176(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_48
.Llexer_read_token_47:
.Llexer_read_token_48:
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $92
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    movzbl -120(%ebp), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
.Llexer_read_token_49:
    pushl -112(%ebp)
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_50
    pushl -184(%ebp)
    pushl -168(%ebp)
    pushl -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -168(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -264(%ebp)
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
    pushl -112(%ebp)
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
.Llexer_read_token_51:
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_49
.Llexer_read_token_50:
    pushl -264(%ebp)
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
    pushl -128(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Llexer_read_token_32:
    jmp .Llexer_read_token_19
.Llexer_read_token_18:
    jmp .Llexer_read_token_13
.Llexer_read_token_19:
.Llexer_read_token_15:
    jmp .Llexer_read_token_12
.Llexer_read_token_13:
    pushl -184(%ebp)
    pushl -168(%ebp)
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
    pushl -168(%ebp)
    pushl -184(%ebp)
    call _check_keyword
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    pushl -160(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_52
    pushl -248(%ebp)
    pushl -160(%ebp)
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -256(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -152(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_52:
.Llexer_read_token_53:
    pushl -248(%ebp)
    pushl $14
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -152(%ebp), %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -184(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -152(%ebp), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -256(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -152(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_2:
.Llexer_read_token_3:
    movzbl -240(%ebp), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_56
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_58
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_59
.Llexer_read_token_58:
    pushl $0
.Llexer_read_token_59:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_57
.Llexer_read_token_56:
    pushl $1
.Llexer_read_token_57:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_54
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
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
    popl %edx
    popl %eax
    movl %eax, -176(%ebp)
    movl %edx, -172(%ebp)
    movl .L_dbl_1, %eax
    pushl %eax
    movl .L_dbl_1+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -168(%ebp)
    movl %edx, -164(%ebp)
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_62
    pushl -264(%ebp)
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
    jne .Llexer_read_token_64
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_65
.Llexer_read_token_64:
    pushl $1
.Llexer_read_token_65:
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_63
.Llexer_read_token_62:
    pushl $0
.Llexer_read_token_63:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_60
    pushl $0
    popl %eax
    movl %eax, -152(%ebp)
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
    popl %edx
    popl %eax
    movl %eax, -144(%ebp)
    movl %edx, -140(%ebp)
    movl .L_dbl_2, %eax
    pushl %eax
    movl .L_dbl_2+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -136(%ebp)
    movl %edx, -132(%ebp)
    movl .L_dbl_3, %eax
    pushl %eax
    movl .L_dbl_3+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -128(%ebp)
    movl %edx, -124(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -264(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
.Llexer_read_token_66:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_67
    pushl -144(%ebp)
    pushl -140(%ebp)
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
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _hex_val
    addl $4, %esp
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
    movl %eax, -144(%ebp)
    movl %edx, -140(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_66
.Llexer_read_token_67:
    pushl -264(%ebp)
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
    je .Llexer_read_token_68
    pushl $1
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_70:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_71
    pushl -136(%ebp)
    pushl -132(%ebp)
    movl .L_dbl_4, %eax
    pushl %eax
    movl .L_dbl_4+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _hex_val
    addl $4, %esp
    pushl %eax
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    # FADD (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -136(%ebp)
    movl %edx, -132(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl -124(%ebp)
    movl .L_dbl_5, %eax
    pushl %eax
    movl .L_dbl_5+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -128(%ebp)
    movl %edx, -124(%ebp)
    pushl -128(%ebp)
    pushl -124(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_70
.Llexer_read_token_71:
    jmp .Llexer_read_token_69
.Llexer_read_token_68:
.Llexer_read_token_69:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $112
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_74
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_75
.Llexer_read_token_74:
    pushl $1
.Llexer_read_token_75:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_72
    pushl $1
    popl %eax
    movl %eax, -152(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_76
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_77
.Llexer_read_token_76:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_78
    pushl $1
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_79
.Llexer_read_token_78:
.Llexer_read_token_79:
.Llexer_read_token_77:
.Llexer_read_token_80:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_81
    pushl -112(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -264(%ebp)
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
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_80
.Llexer_read_token_81:
    pushl $1
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_73
.Llexer_read_token_72:
.Llexer_read_token_73:
    pushl -152(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_82
    movl .L_dbl_6, %eax
    pushl %eax
    movl .L_dbl_6+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -88(%ebp)
    movl %edx, -84(%ebp)
    pushl -144(%ebp)
    pushl -140(%ebp)
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    pushl -136(%ebp)
    pushl -132(%ebp)
    pushl -128(%ebp)
    pushl -124(%ebp)
    # FDIV (soft-float placeholder)
    # FADD (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -96(%ebp)
    movl %edx, -92(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -80(%ebp)
    pushl -80(%ebp)
    addl $4, %esp
.Llexer_read_token_84:
    pushl -80(%ebp)
    pushl -112(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_85
    pushl -88(%ebp)
    pushl -84(%ebp)
    movl .L_dbl_7, %eax
    pushl %eax
    movl .L_dbl_7+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -88(%ebp)
    movl %edx, -84(%ebp)
    pushl -88(%ebp)
    pushl -84(%ebp)
    addl $4, %esp
.Llexer_read_token_86:
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
    jmp .Llexer_read_token_84
.Llexer_read_token_85:
    pushl -104(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_87
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_89
    pushl -96(%ebp)
    pushl -92(%ebp)
    pushl -88(%ebp)
    pushl -84(%ebp)
    # FDIV (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -96(%ebp)
    movl %edx, -92(%ebp)
    pushl -96(%ebp)
    pushl -92(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_90
.Llexer_read_token_89:
    pushl -96(%ebp)
    pushl -92(%ebp)
    pushl -88(%ebp)
    pushl -84(%ebp)
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -96(%ebp)
    movl %edx, -92(%ebp)
    pushl -96(%ebp)
    pushl -92(%ebp)
    addl $4, %esp
.Llexer_read_token_90:
    jmp .Llexer_read_token_88
.Llexer_read_token_87:
.Llexer_read_token_88:
    pushl $0
    popl %eax
    movl %eax, -72(%ebp)
.Llexer_read_token_91:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_97
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_98
.Llexer_read_token_97:
    pushl $1
.Llexer_read_token_98:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_95
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
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
    jmp .Llexer_read_token_96
.Llexer_read_token_95:
    pushl $1
.Llexer_read_token_96:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_93
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
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
    jmp .Llexer_read_token_94
.Llexer_read_token_93:
    pushl $1
.Llexer_read_token_94:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_92
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_101
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_102
.Llexer_read_token_101:
    pushl $1
.Llexer_read_token_102:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_99
    pushl $1
    popl %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_100
.Llexer_read_token_99:
.Llexer_read_token_100:
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_91
.Llexer_read_token_92:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_109
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $73
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
    jmp .Llexer_read_token_110
.Llexer_read_token_109:
    pushl $1
.Llexer_read_token_110:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_107
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $106
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
    jmp .Llexer_read_token_108
.Llexer_read_token_107:
    pushl $1
.Llexer_read_token_108:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_105
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_106
.Llexer_read_token_105:
    pushl $1
.Llexer_read_token_106:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_103
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $83
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -92(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -64(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -92(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fistpl (%esp)
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
    leal -64(%ebp), %eax
    pushl %eax
    pushl $36
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
    leal -64(%ebp), %eax
    pushl %eax
    pushl $40
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
    leal -64(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_103:
.Llexer_read_token_104:
    pushl -248(%ebp)
    pushl $83
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -92(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -64(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -96(%ebp)
    pushl -92(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fistpl (%esp)
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
    leal -64(%ebp), %eax
    pushl %eax
    pushl $40
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
    leal -64(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_82:
.Llexer_read_token_83:
    pushl -144(%ebp)
    pushl -140(%ebp)
    popl %edx
    popl %eax
    movl %eax, -176(%ebp)
    movl %edx, -172(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
.Llexer_read_token_111:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_117
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_118
.Llexer_read_token_117:
    pushl $1
.Llexer_read_token_118:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_115
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
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
    jmp .Llexer_read_token_116
.Llexer_read_token_115:
    pushl $1
.Llexer_read_token_116:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_113
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
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
    jmp .Llexer_read_token_114
.Llexer_read_token_113:
    pushl $1
.Llexer_read_token_114:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_112
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_111
.Llexer_read_token_112:
    pushl -248(%ebp)
    pushl -176(%ebp)
    pushl -172(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    call _make_number
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_60:
.Llexer_read_token_61:
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_121
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_oct
    addl $4, %esp
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_122
.Llexer_read_token_121:
    pushl $0
.Llexer_read_token_122:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_119
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_123:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_oct
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_124
    pushl -176(%ebp)
    pushl -172(%ebp)
    pushl $8
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
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    movl %eax, -176(%ebp)
    movl %edx, -172(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_123
.Llexer_read_token_124:
.Llexer_read_token_125:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_131
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_132
.Llexer_read_token_131:
    pushl $1
.Llexer_read_token_132:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_129
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
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
    jmp .Llexer_read_token_130
.Llexer_read_token_129:
    pushl $1
.Llexer_read_token_130:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_127
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
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
    jmp .Llexer_read_token_128
.Llexer_read_token_127:
    pushl $1
.Llexer_read_token_128:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_126
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_125
.Llexer_read_token_126:
    pushl -248(%ebp)
    pushl -176(%ebp)
    pushl -172(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    call _make_number
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_119:
.Llexer_read_token_120:
.Llexer_read_token_133:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_134
    pushl -176(%ebp)
    pushl -172(%ebp)
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
    call ___muldi3
    addl $16, %esp
    pushl %eax
    pushl %edx
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $48
    popl %ecx
    popl %eax
    subl %ecx, %eax
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
    movl %eax, -176(%ebp)
    movl %edx, -172(%ebp)
    pushl -176(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_133
.Llexer_read_token_134:
    pushl -264(%ebp)
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
    je .Llexer_read_token_135
    pushl $1
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_137:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_138
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_137
.Llexer_read_token_138:
    jmp .Llexer_read_token_136
.Llexer_read_token_135:
.Llexer_read_token_136:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_141
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $69
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
    jmp .Llexer_read_token_142
.Llexer_read_token_141:
    pushl $1
.Llexer_read_token_142:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_139
    pushl $1
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_145
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
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
    jmp .Llexer_read_token_146
.Llexer_read_token_145:
    pushl $1
.Llexer_read_token_146:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_143
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_144
.Llexer_read_token_143:
.Llexer_read_token_144:
.Llexer_read_token_147:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_148
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_147
.Llexer_read_token_148:
    jmp .Llexer_read_token_140
.Llexer_read_token_139:
.Llexer_read_token_140:
    pushl -184(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_149
    pushl -256(%ebp)
    popl %eax
    movl %eax, -160(%ebp)
    movl .L_dbl_8, %eax
    pushl %eax
    movl .L_dbl_8+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -152(%ebp)
    movl %edx, -148(%ebp)
    movl .L_dbl_9, %eax
    pushl %eax
    movl .L_dbl_9+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -144(%ebp)
    movl %edx, -140(%ebp)
    movl .L_dbl_10, %eax
    pushl %eax
    movl .L_dbl_10+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -136(%ebp)
    movl %edx, -132(%ebp)
    movl .L_dbl_11, %eax
    pushl %eax
    movl .L_dbl_11+4, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %eax, -128(%ebp)
    movl %edx, -124(%ebp)
    pushl $0
    popl %eax
    movl %eax, -120(%ebp)
    pushl $0
    popl %eax
    movl %eax, -112(%ebp)
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_151
    movl .L_dbl_12, %eax
    pushl %eax
    movl .L_dbl_12+4, %eax
    pushl %eax
    flds (%esp)
    fchs
    fstps (%esp)
    popl %edx
    popl %eax
    movl %eax, -152(%ebp)
    movl %edx, -148(%ebp)
    pushl -152(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_152
.Llexer_read_token_151:
.Llexer_read_token_152:
.Llexer_read_token_153:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_154
    pushl -144(%ebp)
    pushl -140(%ebp)
    movl .L_dbl_13, %eax
    pushl %eax
    movl .L_dbl_13+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    pushl -160(%ebp)
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
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    # FADD (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -144(%ebp)
    movl %edx, -140(%ebp)
    pushl -144(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_153
.Llexer_read_token_154:
    pushl -160(%ebp)
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
    je .Llexer_read_token_155
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
.Llexer_read_token_157:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_158
    pushl -136(%ebp)
    pushl -132(%ebp)
    movl .L_dbl_14, %eax
    pushl %eax
    movl .L_dbl_14+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    pushl -160(%ebp)
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
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    # FADD (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -136(%ebp)
    movl %edx, -132(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl -124(%ebp)
    movl .L_dbl_15, %eax
    pushl %eax
    movl .L_dbl_15+4, %eax
    pushl %eax
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -128(%ebp)
    movl %edx, -124(%ebp)
    pushl -128(%ebp)
    pushl -124(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_157
.Llexer_read_token_158:
    jmp .Llexer_read_token_156
.Llexer_read_token_155:
.Llexer_read_token_156:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $101
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_161
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $69
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
    jmp .Llexer_read_token_162
.Llexer_read_token_161:
    pushl $1
.Llexer_read_token_162:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_159
    pushl $1
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_163
    pushl $1
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_164
.Llexer_read_token_163:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_165
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_166
.Llexer_read_token_165:
.Llexer_read_token_166:
.Llexer_read_token_164:
.Llexer_read_token_167:
    pushl -160(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_digit
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_168
    pushl -104(%ebp)
    pushl $10
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -160(%ebp)
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
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
    pushl -160(%ebp)
    pushl -160(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -160(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_167
.Llexer_read_token_168:
    jmp .Llexer_read_token_160
.Llexer_read_token_159:
.Llexer_read_token_160:
    pushl -152(%ebp)
    pushl -148(%ebp)
    pushl -144(%ebp)
    pushl -140(%ebp)
    pushl -136(%ebp)
    pushl -132(%ebp)
    pushl -128(%ebp)
    pushl -124(%ebp)
    # FDIV (soft-float placeholder)
    # FADD (soft-float placeholder)
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -168(%ebp)
    movl %edx, -164(%ebp)
    pushl -168(%ebp)
    addl $4, %esp
    pushl -120(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_169
    pushl $0
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    addl $4, %esp
    pushl $0
    addl $4, %esp
    pushl -112(%ebp)
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_171
    pushl -104(%ebp)
    popl %eax
    negl %eax
    pushl %eax
    jmp .Llexer_read_token_172
.Llexer_read_token_171:
    pushl -104(%ebp)
.Llexer_read_token_172:
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    movl .L_dbl_16, %eax
    pushl %eax
    movl .L_dbl_16+4, %eax
    pushl %eax
    call _pow
    addl $8, %esp
    pushl %eax
    popl %eax
    subl $8, %esp
    movl %eax, (%esp)
    fildl (%esp)
    fstpl (%esp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    popl %edx
    popl %eax
    movl %eax, -88(%ebp)
    movl %edx, -84(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    pushl -168(%ebp)
    pushl -164(%ebp)
    pushl -88(%ebp)
    pushl -84(%ebp)
    # FMUL (soft-float placeholder)
    popl %edx
    popl %eax
    movl %eax, -168(%ebp)
    movl %edx, -164(%ebp)
    pushl -168(%ebp)
    pushl -164(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_170
.Llexer_read_token_169:
.Llexer_read_token_170:
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
.Llexer_read_token_173:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_179
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_180
.Llexer_read_token_179:
    pushl $1
.Llexer_read_token_180:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_177
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
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
    jmp .Llexer_read_token_178
.Llexer_read_token_177:
    pushl $1
.Llexer_read_token_178:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_175
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
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
    jmp .Llexer_read_token_176
.Llexer_read_token_175:
    pushl $1
.Llexer_read_token_176:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_174
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $102
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_183
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_184
.Llexer_read_token_183:
    pushl $1
.Llexer_read_token_184:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_181
    pushl $1
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_182
.Llexer_read_token_181:
.Llexer_read_token_182:
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_173
.Llexer_read_token_174:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $105
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_191
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $73
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
    jmp .Llexer_read_token_192
.Llexer_read_token_191:
    pushl $1
.Llexer_read_token_192:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_189
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $106
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
    jmp .Llexer_read_token_190
.Llexer_read_token_189:
    pushl $1
.Llexer_read_token_190:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_187
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_188
.Llexer_read_token_187:
    pushl $1
.Llexer_read_token_188:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_185
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $83
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl -164(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -80(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl -164(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fistpl (%esp)
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
    leal -80(%ebp), %eax
    pushl %eax
    pushl $36
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
    leal -80(%ebp), %eax
    pushl %eax
    pushl $40
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
    leal -80(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_185:
.Llexer_read_token_186:
    pushl -248(%ebp)
    pushl $83
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
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
    pushl %eax
    leal -80(%ebp), %eax
    pushl %eax
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl -164(%ebp)
    popl %edx
    popl %eax
    popl %ecx
    movl %eax, (%ecx)
    movl %edx, 4(%ecx)
    pushl %eax
    pushl %edx
    addl $4, %esp
    leal -80(%ebp), %eax
    pushl %eax
    pushl $8
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -168(%ebp)
    pushl -164(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    fldl (%esp)
    addl $8, %esp
    subl $4, %esp
    fistpl (%esp)
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
    leal -80(%ebp), %eax
    pushl %eax
    pushl $40
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
    leal -80(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_149:
.Llexer_read_token_150:
.Llexer_read_token_193:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_199
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_200
.Llexer_read_token_199:
    pushl $1
.Llexer_read_token_200:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_197
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $108
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
    jmp .Llexer_read_token_198
.Llexer_read_token_197:
    pushl $1
.Llexer_read_token_198:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_195
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $76
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
    jmp .Llexer_read_token_196
.Llexer_read_token_195:
    pushl $1
.Llexer_read_token_196:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_194
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_193
.Llexer_read_token_194:
    pushl -248(%ebp)
    pushl -176(%ebp)
    pushl -172(%ebp)
    popl %eax
    popl %ecx
    pushl %eax
    pushl %ecx
    call _make_number
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_54:
.Llexer_read_token_55:
    movzbl -240(%ebp), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_201
    pushl $0
    popl %eax
    movl %eax, -184(%ebp)
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
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
    je .Llexer_read_token_203
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _read_escape
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_204
.Llexer_read_token_203:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_205
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_206
.Llexer_read_token_205:
.Llexer_read_token_206:
.Llexer_read_token_204:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $39
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_207
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_208
.Llexer_read_token_207:
.Llexer_read_token_208:
    pushl -248(%ebp)
    pushl -184(%ebp)
    popl %eax
    movl %eax, %edx
    sarl $31, %edx
    pushl %edx
    pushl %eax
    call _make_number
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_201:
.Llexer_read_token_202:
    movzbl -240(%ebp), %eax
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
    je .Llexer_read_token_209
    pushl -248(%ebp)
    pushl $13
    call _make_token
    addl $8, %esp
    pushl %eax
    leal -184(%ebp), %eax
    pushl %eax
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
    pushl %eax
    pushl $32
    popl %eax
    movl %eax, -136(%ebp)
    pushl $0
    popl %eax
    movl %eax, -128(%ebp)
    pushl -136(%ebp)
    call _mem_pool_alloc
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
.Llexer_read_token_211:
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_214:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_216
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $34
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
    jmp .Llexer_read_token_217
.Llexer_read_token_216:
    pushl $0
.Llexer_read_token_217:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_215
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
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
    je .Llexer_read_token_220
    pushl -264(%ebp)
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
    jmp .Llexer_read_token_221
.Llexer_read_token_220:
    pushl $0
.Llexer_read_token_221:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_218
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_224
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $85
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
    jmp .Llexer_read_token_225
.Llexer_read_token_224:
    pushl $1
.Llexer_read_token_225:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_222
    pushl $0
    popl %eax
    movl %eax, -104(%ebp)
    pushl -264(%ebp)
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
    addl %ecx, %eax
    pushl %eax
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movb %al, -80(%ebp)
    pushl -264(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    movzbl -80(%ebp), %eax
    pushl %eax
    pushl $117
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_226
    pushl $4
    jmp .Llexer_read_token_227
.Llexer_read_token_226:
    pushl $8
.Llexer_read_token_227:
    popl %eax
    movl %eax, -96(%ebp)
    pushl -96(%ebp)
    addl $4, %esp
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Llexer_read_token_228:
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_229
    pushl -264(%ebp)
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _is_hex
    addl $4, %esp
    pushl %eax
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_231
    jmp .Llexer_read_token_229
.Llexer_read_token_231:
.Llexer_read_token_232:
    pushl -104(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    pushl -264(%ebp)
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    call _hex_val
    addl $4, %esp
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    addl $4, %esp
.Llexer_read_token_230:
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
    jmp .Llexer_read_token_228
.Llexer_read_token_229:
    pushl -88(%ebp)
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_233
    pushl -264(%ebp)
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
    pushl -96(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -72(%ebp), %eax
    pushl %eax
    pushl -104(%ebp)
    call _utf8_encode
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -64(%ebp)
    pushl -64(%ebp)
    addl $4, %esp
    pushl -128(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_235
    pushl -136(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
.Llexer_read_token_237:
    pushl -128(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -56(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_238
    pushl -56(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -56(%ebp)
    pushl -56(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_237
.Llexer_read_token_238:
    pushl -56(%ebp)
    pushl -136(%ebp)
    pushl -120(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -56(%ebp)
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_236
.Llexer_read_token_235:
.Llexer_read_token_236:
    pushl $0
    popl %eax
    movl %eax, -88(%ebp)
    pushl -88(%ebp)
    addl $4, %esp
.Llexer_read_token_239:
    pushl -88(%ebp)
    pushl -64(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setl %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_240
    pushl -120(%ebp)
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -72(%ebp), %eax
    pushl %eax
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
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
.Llexer_read_token_241:
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
    jmp .Llexer_read_token_239
.Llexer_read_token_240:
    jmp .Llexer_read_token_214
.Llexer_read_token_233:
.Llexer_read_token_234:
    movzbl -80(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_223
.Llexer_read_token_222:
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    call _read_escape
    addl $4, %esp
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
.Llexer_read_token_223:
    jmp .Llexer_read_token_219
.Llexer_read_token_218:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    pushl -112(%ebp)
    addl $4, %esp
    pushl -264(%ebp)
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
    addl $4, %esp
.Llexer_read_token_219:
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -136(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setge %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_242
    pushl -136(%ebp)
    pushl $2
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -104(%ebp)
    pushl -104(%ebp)
    pushl -136(%ebp)
    pushl -120(%ebp)
    call _mem_realloc
    addl $12, %esp
    pushl %eax
    popl %eax
    movl %eax, -120(%ebp)
    pushl -120(%ebp)
    addl $4, %esp
    pushl -104(%ebp)
    popl %eax
    movl %eax, -136(%ebp)
    pushl -136(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_243
.Llexer_read_token_242:
.Llexer_read_token_243:
    pushl -120(%ebp)
    pushl -128(%ebp)
    pushl -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -128(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    imull %ecx, %eax
    pushl %eax
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %edx
    popl %eax
    movb %dl, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_214
.Llexer_read_token_215:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
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
    je .Llexer_read_token_244
    pushl -264(%ebp)
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
    addl $4, %esp
    jmp .Llexer_read_token_245
.Llexer_read_token_244:
.Llexer_read_token_245:
    pushl -264(%ebp)
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
    movl %eax, -112(%ebp)
.Llexer_read_token_246:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
    pushl %eax
    pushl $32
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_252
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    jmp .Llexer_read_token_253
.Llexer_read_token_252:
    pushl $1
.Llexer_read_token_253:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_250
    pushl -112(%ebp)
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
    jmp .Llexer_read_token_251
.Llexer_read_token_250:
    pushl $1
.Llexer_read_token_251:
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_248
    pushl -112(%ebp)
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
    jmp .Llexer_read_token_249
.Llexer_read_token_248:
    pushl $1
.Llexer_read_token_249:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_247
    pushl -112(%ebp)
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
    je .Llexer_read_token_254
    pushl -264(%ebp)
    pushl $8
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
    addl $4, %esp
    jmp .Llexer_read_token_255
.Llexer_read_token_254:
.Llexer_read_token_255:
    pushl -112(%ebp)
    pushl -112(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %eax, -112(%ebp)
    addl $4, %esp
    jmp .Llexer_read_token_246
.Llexer_read_token_247:
    pushl -112(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    movsbl (%eax), %eax
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
    je .Llexer_read_token_256
    pushl -264(%ebp)
    pushl $4
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -112(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    jmp .Llexer_read_token_213
.Llexer_read_token_256:
.Llexer_read_token_257:
    jmp .Llexer_read_token_212
.Llexer_read_token_213:
    jmp .Llexer_read_token_211
.Llexer_read_token_212:
    pushl -120(%ebp)
    pushl -128(%ebp)
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
    leal -184(%ebp), %eax
    pushl %eax
    pushl $24
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -120(%ebp)
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    leal -184(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_209:
.Llexer_read_token_210:
    pushl -264(%ebp)
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
    addl $4, %esp
    movzbl -240(%ebp), %eax
    pushl %eax
    popl %eax
    movl %eax, -184(%ebp)
    pushl -184(%ebp)
    pushl $40
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_259
    pushl -184(%ebp)
    pushl $41
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_260
    pushl -184(%ebp)
    pushl $123
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_261
    pushl -184(%ebp)
    pushl $125
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_262
    pushl -184(%ebp)
    pushl $91
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_263
    pushl -184(%ebp)
    pushl $93
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_264
    pushl -184(%ebp)
    pushl $59
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_265
    pushl -184(%ebp)
    pushl $44
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_266
    pushl -184(%ebp)
    pushl $63
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_267
    pushl -184(%ebp)
    pushl $58
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_268
    pushl -184(%ebp)
    pushl $35
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_269
    pushl -184(%ebp)
    pushl $126
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_270
    pushl -184(%ebp)
    pushl $46
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_271
    pushl -184(%ebp)
    pushl $94
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_272
    pushl -184(%ebp)
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_273
    pushl -184(%ebp)
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_274
    pushl -184(%ebp)
    pushl $42
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_275
    pushl -184(%ebp)
    pushl $47
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_276
    pushl -184(%ebp)
    pushl $37
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_277
    pushl -184(%ebp)
    pushl $61
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_278
    pushl -184(%ebp)
    pushl $33
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_279
    pushl -184(%ebp)
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_280
    pushl -184(%ebp)
    pushl $62
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_281
    pushl -184(%ebp)
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_282
    pushl -184(%ebp)
    pushl $124
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Llexer_read_token_283
    jmp .Llexer_read_token_284
.Llexer_read_token_259:
    pushl -248(%ebp)
    pushl $48
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_260:
    pushl -248(%ebp)
    pushl $49
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_261:
    pushl -248(%ebp)
    pushl $50
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_262:
    pushl -248(%ebp)
    pushl $51
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_263:
    pushl -248(%ebp)
    pushl $52
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_264:
    pushl -248(%ebp)
    pushl $53
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_265:
    pushl -248(%ebp)
    pushl $54
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_266:
    pushl -248(%ebp)
    pushl $55
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_267:
    pushl -248(%ebp)
    pushl $57
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_268:
    pushl -248(%ebp)
    pushl $56
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_269:
    pushl -248(%ebp)
    pushl $58
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_270:
    pushl -248(%ebp)
    pushl $33
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_271:
    pushl -264(%ebp)
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
    je .Llexer_read_token_287
    pushl -264(%ebp)
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
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    jmp .Llexer_read_token_288
.Llexer_read_token_287:
    pushl $0
.Llexer_read_token_288:
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_285
    pushl -264(%ebp)
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
    pushl $2
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %edx
    popl %eax
    movl %edx, (%eax)
    pushl %edx
    addl $4, %esp
    pushl -248(%ebp)
    pushl $86
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_285:
.Llexer_read_token_286:
    pushl -248(%ebp)
    pushl $84
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_272:
    pushl -264(%ebp)
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
    je .Llexer_read_token_289
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $43
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_289:
.Llexer_read_token_290:
    pushl -248(%ebp)
    pushl $32
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_273:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $43
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_291
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $46
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_291:
.Llexer_read_token_292:
    pushl -264(%ebp)
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
    je .Llexer_read_token_293
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $36
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_293:
.Llexer_read_token_294:
    pushl -248(%ebp)
    pushl $15
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_274:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_295
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $47
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_295:
.Llexer_read_token_296:
    pushl -264(%ebp)
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
    je .Llexer_read_token_297
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $37
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_297:
.Llexer_read_token_298:
    pushl -264(%ebp)
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
    je .Llexer_read_token_299
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $85
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_299:
.Llexer_read_token_300:
    pushl -248(%ebp)
    pushl $16
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_275:
    pushl -264(%ebp)
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
    je .Llexer_read_token_301
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $38
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_301:
.Llexer_read_token_302:
    pushl -248(%ebp)
    pushl $17
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_276:
    pushl -264(%ebp)
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
    je .Llexer_read_token_303
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $39
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_303:
.Llexer_read_token_304:
    pushl -248(%ebp)
    pushl $18
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_277:
    pushl -264(%ebp)
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
    je .Llexer_read_token_305
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $40
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_305:
.Llexer_read_token_306:
    pushl -248(%ebp)
    pushl $19
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_278:
    pushl -264(%ebp)
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
    je .Llexer_read_token_307
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $21
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_307:
.Llexer_read_token_308:
    pushl -248(%ebp)
    pushl $20
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_279:
    pushl -264(%ebp)
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
    je .Llexer_read_token_309
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $22
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_309:
.Llexer_read_token_310:
    pushl -248(%ebp)
    pushl $29
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_280:
    pushl -264(%ebp)
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
    je .Llexer_read_token_311
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $25
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_311:
.Llexer_read_token_312:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $60
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_313
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
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
    je .Llexer_read_token_315
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $44
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_315:
.Llexer_read_token_316:
    pushl -248(%ebp)
    pushl $34
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_313:
.Llexer_read_token_314:
    pushl -248(%ebp)
    pushl $23
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_281:
    pushl -264(%ebp)
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
    je .Llexer_read_token_317
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $26
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_317:
.Llexer_read_token_318:
    pushl -264(%ebp)
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
    je .Llexer_read_token_319
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -264(%ebp)
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
    je .Llexer_read_token_321
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $45
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_321:
.Llexer_read_token_322:
    pushl -248(%ebp)
    pushl $35
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_319:
.Llexer_read_token_320:
    pushl -248(%ebp)
    pushl $24
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_282:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $38
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_323
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $27
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_323:
.Llexer_read_token_324:
    pushl -264(%ebp)
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
    je .Llexer_read_token_325
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $41
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_325:
.Llexer_read_token_326:
    pushl -248(%ebp)
    pushl $30
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_283:
    pushl -264(%ebp)
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
    movsbl (%eax), %eax
    pushl %eax
    pushl $124
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_read_token_327
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $28
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_327:
.Llexer_read_token_328:
    pushl -264(%ebp)
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
    je .Llexer_read_token_329
    pushl -264(%ebp)
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
    addl $4, %esp
    pushl -248(%ebp)
    pushl $42
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_329:
.Llexer_read_token_330:
    pushl -248(%ebp)
    pushl $31
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_284:
    movzbl -240(%ebp), %eax
    pushl %eax
    movzbl -240(%ebp), %eax
    pushl %eax
    pushl -248(%ebp)
    leal ark_str_0, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl -248(%ebp)
    pushl $0
    call _make_token
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_read_token_258:
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _lexer_init
_lexer_init:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
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
    pushl -24(%ebp)
    pushl $4
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
    pushl -24(%ebp)
    pushl $8
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
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _lexer_read_token_with_pos
    addl $4, %esp
    pushl %eax
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl %eax
    addl $4, %esp
    pushl -24(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -24(%ebp)
    call _lexer_read_token_with_pos
    addl $4, %esp
    pushl %eax
    pushl -24(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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

    .globl _lexer_peek
_lexer_peek:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _lexer_peek2
_lexer_peek2:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _lexer_next
_lexer_next:
    pushl %ebp
    movl %esp, %ebp
    subl $320, %esp
    movl 8(%ebp), %eax
    movl %eax, -72(%ebp)
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    leal -64(%ebp), %eax
    pushl %eax
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
    pushl %eax
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    pushl $16
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl %eax
    addl $4, %esp
    pushl -72(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
    pushl -72(%ebp)
    call _lexer_read_token_with_pos
    addl $4, %esp
    pushl %eax
    pushl -72(%ebp)
    pushl $64
    popl %ecx
    popl %eax
    addl %ecx, %eax
    pushl %eax
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
    pushl %eax
    addl $4, %esp
    leal -64(%ebp), %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _lexer_advance
_lexer_advance:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    call _lexer_next
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

    .globl _lexer_expect
_lexer_expect:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    movl 12(%ebp), %eax
    movl %eax, -16(%ebp)
    pushl -24(%ebp)
    pushl $16
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
    pushl -16(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Llexer_expect_0
    pushl -24(%ebp)
    pushl $16
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
    pushl -16(%ebp)
    pushl -24(%ebp)
    pushl $16
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
    leal ark_str_1, %eax
    pushl %eax
    call _ark_log
    addl $16, %esp
    pushl %eax
    addl $4, %esp
    pushl $0
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Llexer_expect_0:
.Llexer_expect_1:
    pushl -24(%ebp)
    call _lexer_advance
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl $1
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _token_kind_name
_token_kind_name:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    movl 8(%ebp), %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    movl %eax, -16(%ebp)
    pushl -16(%ebp)
    pushl $0
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltoken_kind_name_1
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
    jne .Ltoken_kind_name_2
    pushl -16(%ebp)
    pushl $12
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltoken_kind_name_3
    pushl -16(%ebp)
    pushl $13
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltoken_kind_name_4
    pushl -16(%ebp)
    pushl $83
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Ltoken_kind_name_5
    jmp .Ltoken_kind_name_6
.Ltoken_kind_name_1:
    leal ark_str_2, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_2:
    leal ark_str_3, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_3:
    leal ark_str_4, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_4:
    leal ark_str_5, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_5:
    leal ark_str_6, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_6:
    leal ark_str_7, %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Ltoken_kind_name_0:
    pushl $0
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
    .long 0x44444440
.L_dbl_0:
    .long 0x44444440
    .long 0x44444440
.L_flt_1:
    .long 0x44444440
.L_dbl_1:
    .long 0x44444440
    .long 0x44444440
.L_flt_2:
    .long 0x44444440
.L_dbl_2:
    .long 0x44444440
    .long 0x44444440
.L_flt_3:
    .long 0x44444440
.L_dbl_3:
    .long 0x44444440
    .long 0x44444440
.L_flt_4:
    .long 0x44444440
.L_dbl_4:
    .long 0x44444440
    .long 0x44444440
.L_flt_5:
    .long 0x44444440
.L_dbl_5:
    .long 0x44444440
    .long 0x44444440
.L_flt_6:
    .long 0x44444440
.L_dbl_6:
    .long 0x44444440
    .long 0x44444440
.L_flt_7:
    .long 0x44444440
.L_dbl_7:
    .long 0x44444440
    .long 0x44444440
.L_flt_8:
    .long 0x44444440
.L_dbl_8:
    .long 0x44444440
    .long 0x44444440
.L_flt_9:
    .long 0x44444440
.L_dbl_9:
    .long 0x44444440
    .long 0x44444440
.L_flt_10:
    .long 0x44444440
.L_dbl_10:
    .long 0x44444440
    .long 0x44444440
.L_flt_11:
    .long 0x44444440
.L_dbl_11:
    .long 0x44444440
    .long 0x44444440
.L_flt_12:
    .long 0x44444440
.L_dbl_12:
    .long 0x44444440
    .long 0x44444440
.L_flt_13:
    .long 0x44444440
.L_dbl_13:
    .long 0x44444440
    .long 0x44444440
.L_flt_14:
    .long 0x44444440
.L_dbl_14:
    .long 0x44444440
    .long 0x44444440
.L_flt_15:
    .long 0x44444440
.L_dbl_15:
    .long 0x44444440
    .long 0x44444440
.L_flt_16:
    .long 0x44444440
.L_dbl_16:
    .long 0x44444440
    .long 0x44444440
    .text
