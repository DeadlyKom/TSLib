
                ifndef _MATH_MULTIPLY_INTEGER_16x8_16
                define _MATH_MULTIPLY_INTEGER_16x8_16

                module Math
; -----------------------------------------
; integer multiplies DE by A
; In :
;   DE - multiplicand
;   A  - multiplier
; Out :
;   HL - product DE * A
; Corrupt :
;   HL, F
; Note:
;   http://z80-heaven.wikidot.com/math#toc1
; -----------------------------------------
MulInt16x8_16:  LD HL, #0000

                ; unroll
                rept 8
                ADD HL, HL
                RLCA
                JR NC, $+3
                ADD HL, DE
                endr

                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_INTEGER_16x8_16
