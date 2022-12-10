
                ifndef _MATH_MULTIPLY_UINTEGER_16x16_32_FAST_
                define _MATH_MULTIPLY_UINTEGER_16x16_32_FAST_

                include "uint8x8_16_fast_16kB_macro.inc"

                ifndef PAGE_MUL_8x8_FAST_64KB_
                define PAGE_MUL_8x8_FAST_64KB_ PAGE0
                endif

                module Math
; -----------------------------------------
; unsigned integer multiplies BC by DE
; In :
;   DE - multiplicand
;   BC - multiplier
; Out :
;   DEHL - product BC * DE
; Corrupt :
; Node:
;   z0  = rE * rC
;   z2  = rD * rB
;   z1  = z0 + z2 - (rD - rE) * (rB - rC)
;   res = z0 + z1 * 8 + z2 * 16
; -----------------------------------------
Mul_16x16:      ; swap rE <=> rB
                LD A, E
                LD E, B
                LD B, A

                PUSH DE ;   z2  = rD * rE
                PUSH BC ;   z0  = rB * rC

                ; L = (rD - rB)
                LD A, D
                SUB B
                LD L, A

                ; C = (rE - rC)
                LD A, E
                SUB C
                LD C, A

                ; DE = (rD - rB) * (rE - rC)
                LD H, HIGH Table
                LD A, (HL)
                LD (FMADDR_REGS + HIGH PAGE_MUL_8x8_FAST_64KB_), A
                INC H
                LD H, (HL)
                LD L, C
                LD A, (HL)
                EX AF, AF'
                INC H
                LD B, (HL)
                ;

                
                POP HL  ; z0  = rB * rC
                ; DE = z0 = rB * rC
                LD C, H
                LD H, HIGH Table
                LD A, (HL)
                LD (FMADDR_REGS + HIGH PAGE_MUL_8x8_FAST_64KB_), A
                INC H
                LD H, (HL)
                LD L, C
                LD E, (HL)
                INC H
                LD D, (HL)
                ;

                POP HL  ; z2  = rD * rE
                PUSH DE
                ; DE = z2 = rD * rE
                LD C, H
                LD H, HIGH Table
                LD A, (HL)
                LD (FMADDR_REGS + HIGH PAGE_MUL_8x8_FAST_64KB_), A
                INC H
                LD H, (HL)
                LD L, C
                LD E, (HL)
                INC H
                LD D, (HL)

                ; z1 = z0 + z2 - (rD - rE) * (rB - rC)
                POP HL
                PUSH HL
                ADD HL, DE
                EX AF, AF'
                LD C, A
                SBC HL, BC


                ; res = z0 + z1 * 8 + z2 * 16
                
                ; HL = z1
                ; DE = z2 * 16
                LD A, L
                LD H, L
                LD L, #00
                ADD HL, DE
                EX DE, HL

                POP BC
                ADD HL, BC
                EX DE, HL
                ADC HL, DE
                EX DE, HL

                RET
            
                endmodule

                endif ; ~_MATH_MULTIPLY_UINTEGER_16x16_32_FAST_
