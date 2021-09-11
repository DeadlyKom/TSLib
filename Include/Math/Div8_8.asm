
                ifndef _MATH_DIVISION_8_8
                define _MATH_DIVISION_8_8

                module Math
; -----------------------------------------
; integer 8-bit divides D by E
; In :
;   D - dividend
;   E - divider
; Out :
;   D - division result
;   A - remainder
; Corrupt :
;   B, F
; Note:
;   https://www.smspower.org/Development/DivMod
; -----------------------------------------
Div8_8:         XOR A
                LD B, #08
.Loop           SLA D
                RLA
                CP E
                JR C, .Less
                SUB E
                INC D
.Less           DJNZ .Loop

                RET

                endmodule

                endif ; ~_MATH_DIVISION_8_8
