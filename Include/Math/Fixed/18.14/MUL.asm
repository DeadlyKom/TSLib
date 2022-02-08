                ifndef _FIXED_18_14_MUL_ 
                define _FIXED_18_14_MUL_
; -----------------------------------------
; multiply two fixed-point numbers 18:14
; In:
;   HLHL' - fixed-point numbers 18:14
;   BCBC' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' * BCBC', if define OVERFLOW set carry
; Corrupt:
;   HL, DE, BC, AF, HL', DE', AF'
; Note:
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
; -----------------------------------------
MUL:            ; determining the resulting sign
                LD A, H
                XOR B
                EX AF, AF'                                                      ; save result sign

                ; reset signs of two numbers
                RES 7, H
                RES 7, B

                EXX

                ; multiply the value of low word BC by DE
                EX DE, HL
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE
                PUSH DE
                EXX

                ; multiply the value of high word BC by DE
                EX DE, HL
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE

                ; addition of two results with shift
                ;   DE : HL
                ; +
                ;        DE : HL -> X (discard)
                ; ------------
                ;   HL : BC
                POP BC
                ADD HL, BC
                EX DE, HL
                LD B, D
                LD C, E

                ; was there an overflow -> ADD HL, BC
                JR NC, $+3
                INC HL                                                          ; increase result of high word

                ifdef FIXED_CHECK_OVERFLOW
                ; check for overflow
                BIT 7, H
                JR NZ, MaxOverflow
                endif
                
                ; set the resulting sign
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_18_14_MUL_
