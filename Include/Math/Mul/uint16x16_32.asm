
                ifndef _MATH_MULTIPLY_UINTEGER_16x16_32_
                define _MATH_MULTIPLY_UINTEGER_16x16_32_

                module Math
; -----------------------------------------
; unsigned integer multiplies BC by DE
; In :
;   DE, BC
; Out :
;   DEHL - product BC * DE
; Corrupt :
;   HL, DE, BC, A
; -----------------------------------------
Mul_16x16:      LD A, D
                LD D, #00
                LD H, B
                LD L, C
                ADD A, A
                JR C, .Mul_Bit14
                ADD A, A
                JR C, .Mul_Bit13
                ADD A, A
                JR C, .Mul_Bit12
                ADD A, A
                JR C, .Mul_Bit11
                ADD A, A
                JR C, .Mul_Bit10
                ADD A, A
                JR C, .Mul_Bit9
                ADD A, A
                JR C, .Mul_Bit8
                ADD A, A
                JR C, .Mul_Bit7
                LD A, E
                AND %11111110
                ADD A, A
                JR C, .Mul_Bit6
                ADD A, A
                JR C, .Mul_Bit5
                ADD A, A
                JR C, .Mul_Bit4
                ADD A, A
                JR C, .Mul_Bit3
                ADD A, A
                JR C, .Mul_Bit2
                ADD A, A
                JR C, .Mul_Bit1
                ADD A, A
                JR C, .Mul_Bit0
                RR E
                RET C
                LD H, D
                LD L, E
                RET

.Mul_Bit14      ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit13
                ADD HL, BC
                ADC A, D
.Mul_Bit13      ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit12
                ADD HL, BC
                ADC A, D
.Mul_Bit12      ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit11
                ADD HL, BC
                ADC A, D
.Mul_Bit11      ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit10
                ADD HL, BC
                ADC A, D
.Mul_Bit10      ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit9
                ADD HL, BC
                ADC A, D
.Mul_Bit9       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit8
                ADD HL, BC
                ADC A, D
.Mul_Bit8       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit7
                ADD HL, BC
                ADC A, D
.Mul_Bit7       LD D, A
                LD A, E
                AND %11111110
                ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit6
                ADD HL, BC
                ADC A, #00
.Mul_Bit6       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit5
                ADD HL, BC
                ADC A, #00
.Mul_Bit5       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit4
                ADD HL, BC
                ADC A, #00
.Mul_Bit4       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit3
                ADD HL, BC
                ADC A, #00
.Mul_Bit3       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit2
                ADD HL, BC
                ADC A, #00
.Mul_Bit2       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit1
                ADD HL, BC
                ADC A, #00
.Mul_Bit1       ADD HL, HL
                ADC A, A
                JR NC, .Mul_Bit0
                ADD HL, BC
                ADC A, #00
.Mul_Bit0       ADD HL, HL
                ADC A, A
                JR C, .FunkyCarry
                RR E
                LD E, A
                RET NC
                ADD HL, BC
                RET NC
                INC E
                RET NZ
                INC D
                RET

.FunkyCarry     INC D
                RR E
                LD E, A
                RET NC 
                ADD HL, BC
                RET NC
                INC E
                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_UINTEGER_16x16_32_
