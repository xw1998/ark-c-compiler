; Ark C Compiler - MDK STM32H743 - startup_stm32h743xx
; 最小化启动文件 (ARM 传统汇编, armclang asm)
; - 栈顶位于 DTCM 顶部 0x20020000 (DTCM = 128KB)
; - Reset_Handler: 清 BSS, 拷贝 .data, 调用 SystemInit, 跳转 __main

                PRESERVE8
                THUMB

; ===================== 中断向量表 =====================
                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors
                EXPORT  __Vectors_End
                EXPORT  __Vectors_Size

__Vectors       DCD     0x20020000             ; Top of DTCM (栈顶)
                DCD     Reset_Handler          ; Reset Handler
                DCD     NMI_Handler
                DCD     HardFault_Handler
                DCD     MemManage_Handler
                DCD     BusFault_Handler
                DCD     UsageFault_Handler
                DCD     0
                DCD     0
                DCD     0
                DCD     0
                DCD     SVC_Handler
                DCD     DebugMon_Handler
                DCD     0
                DCD     PendSV_Handler
                DCD     SysTick_Handler

__Vectors_End

__Vectors_Size  EQU     __Vectors_End - __Vectors

; ===================== 代码段 =====================
                AREA    |.text|, CODE, READONLY

; Reset_Handler
                EXPORT  Reset_Handler          [WEAK]
                IMPORT  SystemInit
                IMPORT  __main

Reset_Handler   PROC
                LDR     R0, =SystemInit
                BLX     R0
                LDR     R0, =__main
                BX      R0
                ENDP

; 默认中断处理：死循环
Default_Handler PROC
                EXPORT  NMI_Handler            [WEAK]
                EXPORT  HardFault_Handler      [WEAK]
                EXPORT  MemManage_Handler      [WEAK]
                EXPORT  BusFault_Handler       [WEAK]
                EXPORT  UsageFault_Handler     [WEAK]
                EXPORT  SVC_Handler            [WEAK]
                EXPORT  DebugMon_Handler       [WEAK]
                EXPORT  PendSV_Handler         [WEAK]
                EXPORT  SysTick_Handler        [WEAK]

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
                B       .
                ENDP

                ALIGN

; ===================== 堆/栈占位 =====================
; armclang 的 __main 会读取下列 weak 符号；MDK 默认通过 __user_initial_stackheap 或 scatter 提供。
; 这里不做 __user_initial_stackheap，由 scatter 内的 RW_IRAM1 段提供。

                END
