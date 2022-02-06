
                ifndef _MATH_MULTIPLY_UINTEGER_8x8_16_FAST_16KB_MACRO_
                define _MATH_MULTIPLY_UINTEGER_8x8_16_FAST_16KB_MACRO_

; -----------------------------------------
; unsigned integer multiplies L by C
; In :
;   L - multiplicand
;   C  - multiplier
; Out :
;   DE - product L * C
; Corrupt :
;   HL, DE, B, AF
; Node:
;   fastest, with 16 KB tables
;   https://www.cpcwiki.eu/index.php/Programming:Integer_Multiplication#Fastest.2C_accurate_8bit_.2A_8bit_Unsigned_with_16_KB_tables
; -----------------------------------------
MUL_DE_LxC:     macro

                LD H, HIGH Table
                LD B, (HL)
                INC H
                LD H, (HL)
                LD L, C
                LD A, (BC)
                ADD A, (HL)
                LD E, A
                INC B
                INC H
                LD A, (BC)
                ADC A, (HL)
                LD D, A

                endm

                endif ; ~_MATH_MULTIPLY_UINTEGER_8x8_16_FAST_16KB_MACRO_
