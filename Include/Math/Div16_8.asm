
                ifndef _MATH_DIVISION_16_8
                define _MATH_DIVISION_16_8

                module Math
; -----------------------------------------
; integer 16-bit divides HL by C
; In :
;   HL - dividend
;   C  - divider
; Out :
;   HL - division result
;   A  - remainder
; Corrupt :
;   B, F
; Note:
;   https://www.smspower.org/Development/DivMod
; -----------------------------------------
Div16_8:        XOR A
                LD B, #10
.Loop           ADD HL, HL
                RLA
                CP C
                JR C, .Less
                SUB C
                INC L
.Less           DJNZ .Loop

                RET

                endmodule

                endif ; ~_MATH_DIVISION_16_8
