
                ifndef _MATH_MULTIPLY_INTEGER_16x8_24
                define _MATH_MULTIPLY_INTEGER_16x8_24

                module Math
; -----------------------------------------
; integer multiplies DE by A
; In :
;   DE - multiplicand
;   A  - multiplier
; Out :
;   AHL - product DE * A
; Corrupt :
;   HL, F
; Note:
;   http://map.grauw.nl/sources/external/z80bits.html#1.2
; -----------------------------------------
MulInt16x8_24:  LD HL, #0000
                ADD A, A
                JR NC, $+4
                LD H, D
                LD L, E
                
                ; unroll
                rept 7
                ADD HL, HL
                ADC A, A
                JR NC, $+3
                ADD HL, DE
                endr
                
                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_INTEGER_16x8_24
