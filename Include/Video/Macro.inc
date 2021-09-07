
                ifndef _VIDEO_MACRO_
                define _VIDEO_MACRO_
; -----------------------------------------
; video setting macro
; In :
;   Value? - one or more (VID_)
; Out :
; Corrupt :
;  HL / (BC, A)
; Note:
; -----------------------------------------
Video_Setting   macro Value?
                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH VCONFIG
                LD (HL), Value? & 0xFF
                else
                LD A, Value? & 0xFF
                LD BC, VCONFIG
                OUT (C), A
                endif
                endm

                endif ; ~_VIDEO_MACRO_
