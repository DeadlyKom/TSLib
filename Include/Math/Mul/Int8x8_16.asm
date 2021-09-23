
                ifndef _MATH_MULTIPLY_INTEGER_8x8_16
                define _MATH_MULTIPLY_INTEGER_8x8_16

                module Math
; -----------------------------------------
; integer multiplies DE by A
; In :
;   H - multiplicand
;   E  - multiplier
; Out :
;   HL - product H * E
; Corrupt :
;   HL, D, F
; Note:
;   http://z80-heaven.wikidot.com/math#toc1
; -----------------------------------------
MulInt8x8_16:   LD D, #00
                LD L, D

                ; unroll
                rept 8
                ADD HL, HL
                JR NC, $+3
                ADD HL, DE
                endr

                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_INTEGER_16x8_16
