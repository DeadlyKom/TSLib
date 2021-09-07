
                ifndef _SYSTEM_MACRO_
                define _SYSTEM_MACRO_
; -----------------------------------------
; system setting macro
; In :
;   Value? - one or more (SYS_CACHEEN/SYS_ZCLK3_5/SYS_ZCLK7/SYS_ZCLK14)
; Out :
; Corrupt :
;  HL / (BC, A)
; Note:
; -----------------------------------------
System_Setting  macro Value?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH SYSCONFIG
                LD (HL), Value? & 0xFF
                else
                LD A, Value? & 0xFF
                LD BC, SYSCONFIG
                OUT (C), A
                endif
                endm

                endif ; ~_SYSTEM_MACRO_
