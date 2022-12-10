
                ifndef _MATH_DIVISION_8_8
                define _MATH_DIVISION_8_8

                module Math
; -----------------------------------------
; unsigned integer 32-bit divides HLDE by BC
; In :
;   HLDE - dividend
;   BC - divider
; Out :
;   HLDE - division result
;   BC - remainder
; Corrupt :
;   HL, DE, BC, A
; Note:
;   https://www.smspower.org/Development/DivMod#Unsigned32161616Bit
; -----------------------------------------
Div_32x16:      PUSH IX

                PUSH HL
                PUSH DE
                POP IX
                POP DE

                ; Negate BC to allow add instead of sbc                   
                XOR A
                ; Need to set HL to 0 anyways, so save 2cc and a byte
                LD H, A
                LD L, A
                SBC C
                LD C, A
                SBC A, A
                SUB B
                LD B, A

                LD A, D
                CALL .Div32x16Sub8
                RLA
                LD D, A

                LD A, E
                CALL .Div32x16Sub8
                RLA
                LD E, A

                LD A, XH
                CALL .Div32x16Sub8
                RLA
                LD XH, A

                LD A, XL
                CALL .Div32x16Sub8
                RLA
                LD XL, A

                EX DE, HL

                PUSH DE
                PUSH IX
                POP DE
                POP BC

                POP IX

                RET

.Div32x16Sub8   CALL .A
.A              CALL .B
.B              CALL .Div32x16Sub
.Div32x16Sub    RLA
                ADC HL, HL
                JR C, .C
                ADD HL, BC
                RET C
                SBC HL, BC
                RET

.C              ADD HL, BC
                SCF
                RET

                RLA
                ADC HL, HL
                JR C, .C
                ADD HL, BC
                RET C
                SBC HL, BC
                RET

                endmodule

                endif ; ~_MATH_DIVISION_8_8
