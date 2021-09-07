
                ifndef _CACHE_MACRO_
                define _CACHE_MACRO_
; -----------------------------------------
; RAM caching setup macro
; In :
;   Value? - one or more (EN_0000/EN_4000/EN_8000/EN_C000)
; Out :
; Corrupt :
;  HL / (BC, A)
; Note:
; -----------------------------------------
Cache_Setting   macro Value?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH CACHECONFIG
                LD (HL), Value? & 0xFF
                else
                LD A, Value? & 0xFF
                LD BC, CACHECONFIG
                OUT (C), A
                endif
                endm

                endif ; ~_CACHE_MACRO_
