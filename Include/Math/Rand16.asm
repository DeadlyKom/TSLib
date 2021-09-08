
                ifndef _MATH_RAND_16
                define _MATH_RAND_16

                module Math

; -----------------------------------------
; 16-bit random number generator
; In :
; Out :
;   HL - random number
; Corrupt :
;   HL, DE, BC, AF
; Note:
;   https://wikiti.brandonw.net/index.php?title=Z80_Routines:Math:Random
; -----------------------------------------
Rand16:         ;
.Seed_FL        EQU $+1
                LD HL, 12345
.Seed_FH        EQU $+1
                LD DE, 6789
                LD B, H
                LD C, L

                rept 2
                ADD HL, HL
                RL E
                RL D
                endr

                INC L
                ADD HL, BC

                LD (.Seed_FL), HL
                LD HL, (.Seed_FH)
                ADD HL, DE
                LD (.Seed_FH), HL
                EX DE, HL

.Seed_SL        EQU $+1
                LD HL, 9876
.Seed_SH        EQU $+1
                LD BC, 54321

                ADD HL, HL
                RL C
                RL B

                LD (.Seed_SH), BC
                SBC A, A
                AND %11000101
                XOR L
                LD L, A
                LD (.Seed_SL), HL
                EX DE, HL
                ADD HL, BC

                RET

                endmodule

                endif ; ~_MATH_RAND_16
