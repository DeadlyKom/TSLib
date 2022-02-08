                ifndef _FIXED_2_14_MUL_ 
                define _FIXED_2_14_MUL_
; -----------------------------------------
; multiply two fixed-point numbers 2:14
; In:
;    DE, BC multiplicands
; Out:
;   HLHL' = BC * DE
; Corrupt:
;   HL, DE, AF, HL', AF'
; Note:
; -----------------------------------------
MUL:            ; determining the resulting sign
                LD A, D
                XOR B
                EX AF, AF'                                                      ; save result sign

                ; reset signs of two numbers
                RES 7, D
                RES 7, B

                ; multiply value BC by DE
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE

                ; HLHL' = DEHL << 2
                LD A, H
                EX DE, HL
                ADD A, A
                ADC HL, HL
                ADD A, A
                ADC HL, HL
                EXX

                ; set the resulting sign and high byte set zero
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                LD A, #00
                LD L, A
                RRA
                LD H, A
                RET

                endif ; ~_FIXED_2_14_MUL_
