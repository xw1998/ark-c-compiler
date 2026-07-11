# Ark C Compiler - generated x86 (32-bit cdecl) assembly
    .data
    .section .rdata,"dr"
ark_str_0:
    .asciz "rb"
ark_str_1:
    .asciz "wb"
ark_str_2:
    .asciz "[flash_fs] fs_list_files: not implemented on host\r\n"
    .text
    .globl _fs_read_file
_fs_read_file:
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
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lfs_read_file_4
    pushl -48(%ebp)
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
    jmp .Lfs_read_file_5
.Lfs_read_file_4:
    pushl $1
.Lfs_read_file_5:
    popl %eax
    cmpl $0, %eax
    jne .Lfs_read_file_2
    pushl -40(%ebp)
    pushl $0
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
    jmp .Lfs_read_file_3
.Lfs_read_file_2:
    pushl $1
.Lfs_read_file_3:
    popl %eax
    cmpl $0, %eax
    je .Lfs_read_file_0
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_read_file_0:
.Lfs_read_file_1:
    leal ark_str_0, %eax
    pushl %eax
    pushl -56(%ebp)
    call _fopen
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfs_read_file_6
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_read_file_6:
.Lfs_read_file_7:
    pushl -32(%ebp)
    pushl -40(%ebp)
    pushl $1
    popl %ecx
    popl %eax
    subl %ecx, %eax
    pushl %eax
    pushl $1
    pushl -48(%ebp)
    call _fread
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    pushl -32(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
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
    je .Lfs_read_file_8
    pushl $0
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    addl $4, %esp
    jmp .Lfs_read_file_9
.Lfs_read_file_8:
.Lfs_read_file_9:
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
    pushl $0
    popl %edx
    popl %eax
    movb %dl, (%eax)
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

    .globl _fs_write_file
_fs_write_file:
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
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    jne .Lfs_write_file_4
    pushl -48(%ebp)
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
    jmp .Lfs_write_file_5
.Lfs_write_file_4:
    pushl $1
.Lfs_write_file_5:
    popl %eax
    cmpl $0, %eax
    jne .Lfs_write_file_2
    pushl -40(%ebp)
    pushl $0
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
    jmp .Lfs_write_file_3
.Lfs_write_file_2:
    pushl $1
.Lfs_write_file_3:
    popl %eax
    cmpl $0, %eax
    je .Lfs_write_file_0
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_write_file_0:
.Lfs_write_file_1:
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
    pushl $45
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfs_write_file_8
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
    jmp .Lfs_write_file_9
.Lfs_write_file_8:
    pushl $0
.Lfs_write_file_9:
    popl %eax
    cmpl $0, %eax
    je .Lfs_write_file_6
    movl _stdout, %eax
    pushl %eax
    pushl -40(%ebp)
    pushl $1
    pushl -48(%ebp)
    call _fwrite
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    movl _stdout, %eax
    pushl %eax
    call _fflush
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_write_file_6:
.Lfs_write_file_7:
    leal ark_str_1, %eax
    pushl %eax
    pushl -56(%ebp)
    call _fopen
    addl $8, %esp
    pushl %eax
    popl %eax
    movl %eax, -24(%ebp)
    pushl -24(%ebp)
    popl %eax
    cmpl $0, %eax
    sete %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfs_write_file_10
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_write_file_10:
.Lfs_write_file_11:
    pushl -24(%ebp)
    pushl -40(%ebp)
    pushl $1
    pushl -48(%ebp)
    call _fwrite
    addl $16, %esp
    pushl %eax
    popl %eax
    movl %eax, -32(%ebp)
    pushl -32(%ebp)
    addl $4, %esp
    pushl -24(%ebp)
    call _fclose
    addl $4, %esp
    pushl %eax
    addl $4, %esp
    pushl -32(%ebp)
    pushl -40(%ebp)
    popl %ecx
    popl %eax
    cmpl %ecx, %eax
    setne %al
    movzbl %al, %eax
    pushl %eax
    popl %eax
    cmpl $0, %eax
    je .Lfs_write_file_12
    pushl $1
    popl %eax
    negl %eax
    pushl %eax
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
.Lfs_write_file_12:
.Lfs_write_file_13:
    pushl -32(%ebp)
    popl %eax
    movl %ebp, %esp
    popl %ebp
    ret
    xorl %eax, %eax
    movl %ebp, %esp
    popl %ebp
    ret

    .globl _fs_list_files
_fs_list_files:
    pushl %ebp
    movl %esp, %ebp
    subl $272, %esp
    leal ark_str_2, %eax
    pushl %eax
    call _ark_log
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

