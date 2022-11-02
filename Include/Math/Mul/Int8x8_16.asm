
                ifndef _MATH_MULTIPLY_INTEGER_8x8_16
                define _MATH_MULTIPLY_INTEGER_8x8_16

                module Math
; -----------------------------------------
; integer multiplies H by E
; In :
;   H - multiplicand
;   E  - multiplier
; Out :
;   HL - product H * E
; Corrupt :
;   HL, D, F
; Note:
;   http://map.grauw.nl/sources/external/z80bits.html#1.1
; -----------------------------------------
MulInt8x8_16:   LD D, #00
                LD L, D
                SLA H
                JR NC, $+3
                LD L, E

                ; unroll
                rept 7
                ADD HL, HL
                JR NC, $+3
                ADD HL, DE
                endr

                RET

                display " - Multiply 8x8 : \t\t\t", /A, Mul8x8_16, " = busy [ ", /D, $ - Mul8x8_16, " bytes  ]"

                endmodule

                endif ; ~_MATH_MULTIPLY_INTEGER_16x8_16
