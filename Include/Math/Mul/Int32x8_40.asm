
                ifndef _MATH_MULTIPLY_INTEGER_32x8_40
                define _MATH_MULTIPLY_INTEGER_32x8_40

                module Math
; -----------------------------------------
; integer multiplies DEHL by A
; In :
;   DEHL  - multiplicand
;   A     - multiplier
; Out :
;   AHLDE - product DEHL * A
; Corrupt :
;   HL, DE, B, AF
; Note:
;   http://z80-heaven.wikidot.com/math#toc8
; -----------------------------------------
MulInt32x8_40:  ; TODO optimize
                EXX
                PUSH HL
                PUSH DE
                EXX

                PUSH HL
                LD HL, #0000        ; hi
                EXX
                LD HL, #0000        ; low
                POP DE

                LD B, #08
.L1             ADD HL, HL          ; low
                EXX
                ADC HL, HL          ; hi
                EXX
                
                ADC A, A
                JR NC, $+9
                ADD HL, DE          ; low
                EXX
                ADC HL, DE          ; hi
                EXX
                ADC A, #00
                DJNZ .L1

                PUSH HL
                EXX
                POP DE

                EXX
                POP DE
                POP HL
                EXX

                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_INTEGER_32x8_40