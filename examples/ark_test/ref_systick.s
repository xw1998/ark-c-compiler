; Minimal SysTick blink test in pure assembly - reference implementation
        AREA reset, CODE, READONLY
        THUMB

        EXPORT Reset_Handler
        EXPORT Default_Handler
        EXPORT SysTick_Handler
        EXPORT __Vectors

__Vectors
        DCD 0x20018000              ; 0: Initial SP
        DCD Reset_Handler           ; 1: Reset
        DCD Default_Handler         ; 2: NMI
        DCD Default_Handler         ; 3: HardFault
        DCD Default_Handler         ; 4: MemManage
        DCD Default_Handler         ; 5: BusFault
        DCD Default_Handler         ; 6: UsageFault
        DCD 0                       ; 7
        DCD 0                       ; 8
        DCD 0                       ; 9
        DCD 0                       ; 10
        DCD Default_Handler         ; 11: SVC
        DCD Default_Handler         ; 12: DebugMon
        DCD 0                       ; 13
        DCD Default_Handler         ; 14: PendSV
        DCD SysTick_Handler         ; 15: SysTick
        SPACE 372                   ; Pad to 109 entries (436 bytes)

RCC_AHB1ENR   EQU 0x40023830
GPIOC_MODER   EQU 0x40020800
GPIOC_BSRR    EQU 0x40020818
SYSTICK_CTRL  EQU 0xE000E010
SYSTICK_LOAD  EQU 0xE000E014
SYSTICK_VAL   EQU 0xE000E018

Reset_Handler PROC
        LDR     r0, =RCC_AHB1ENR
        LDR     r1, [r0]
        ORR     r1, r1, #(1:SHL:2)
        STR     r1, [r0]
        LDR     r0, =GPIOC_MODER
        LDR     r1, [r0]
        BIC     r1, r1, #(3:SHL:26)
        ORR     r1, r1, #(1:SHL:26)
        STR     r1, [r0]
        LDR     r0, =SYSTICK_LOAD
        LDR     r1, =15999
        STR     r1, [r0]
        LDR     r0, =SYSTICK_VAL
        MOV     r1, #0
        STR     r1, [r0]
        LDR     r0, =SYSTICK_CTRL
        MOV     r1, #7
        STR     r1, [r0]
        B       .
        ENDP

SysTick_Handler PROC
        PUSH    {r0-r3, lr}
        LDR     r0, =tick_count
        LDR     r1, [r0]
        ADD     r1, r1, #1
        STR     r1, [r0]
        CMP     r1, #500
        BLT     sys_tick_done
        MOV     r1, #0
        STR     r1, [r0]
        LDR     r0, =GPIOC_BSRR
        MOV     r1, #(1:SHL:13)
        STR     r1, [r0]
        MOV     r1, #(1:SHL:29)
        STR     r1, [r0]
sys_tick_done
        POP     {r0-r3, pc}
        ENDP

Default_Handler PROC
        B       .
        ENDP

        AREA tick_data, DATA, READWRITE
        EXPORT tick_count
tick_count
        DCD 0

        END
