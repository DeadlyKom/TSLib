
                ifndef _INT_MACRO_
                define _INT_MACRO_
; -----------------------------------------
; interrupt type setting macro
; In :
;   Value? - one or more (INT_MSK_FRAME/INT_MSK_LINE/INT_MSK_DMA/INT_MSK_NET)
; Out :
; Corrupt :
;  HL / (BC, A)
; Note:
; -----------------------------------------
INT_Setting     macro Value?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH INTMASK
                LD (HL), Value? & 0xFF
                else
                LD A, Value? & 0xFF
                LD BC, INTMASK
                OUT (C), A
                endif
                endm

                endif ; ~_INT_MACRO_
