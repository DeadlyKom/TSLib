                ifndef _FIXED_2_14_MUL_ 
                define _FIXED_2_14_MUL_
; -----------------------------------------
; multiply two fixed-point numbers 2:14 (long)
; In:
;    DE, BC multiplicands
; Out:
;   result fixed-point number 18:14
;   HLHL' = BC * DE
; Corrupt:
;   HL, DE, AF, HL', AF'
; Note:
; -----------------------------------------
MULL:           ; determining the resulting sign
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

; -----------------------------------------
; multiply two fixed-point numbers 2:14 (short)
; In:
;    DE - multiplicand  ( -1.0 <= DE <= 1.0)
;    BC - multiplier    ( -1.0 <= BC <= 1.0)
; Out:
;   result fixed-point number 2:14
;   HL = BC * DE
; Corrupt:
;   HL, DE, AF, HL', AF'
; Note:
;   fixed-point number values must be between -1.0 and 1.0
;   define FIXED_CHECK_OVERFLOW_VALUE - check for overflow of available values
;   define CARRY_FLOW_WARNING         - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW                   - reflect overflow result in carry flag
;
; -----------------------------------------
MULS:           ; determining the resulting sign
                LD A, D
                XOR B
                EX AF, AF'                                                      ; save result sign

                ; reset signs of two numbers
                RES 7, D
                RES 7, B

                ; multiply value BC by DE
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE

                ; HL = DEHL << 2 (HL -> discard, DE - result)
                LD A, H
                EX DE, HL
                ADD A, A
                ADC HL, HL
                ADD A, A
                ADC HL, HL

                ; round fractional part
                OR E
                JR Z, $+3
                INC HL

                ifdef FIXED_CHECK_OVERFLOW_VALUE
                ; check for overflow of available values
                LD A, #40
                SUB H
                JR C, OverflowValue
                JR NZ, .ValidValue
                LD A, L
                OR A
                JR NZ, OverflowValue
.ValidValue     ; lable skip 
                endif

                ; set the resulting sign and high byte set zero
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_2_14_MUL_
