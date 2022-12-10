                ifndef _FIXED_18_14_MUL_ 
                define _FIXED_18_14_MUL_
; -----------------------------------------
; multiply two fixed-point numbers 18:14 (long)
; In:
;   HLHL' - fixed-point numbers 18:14
;   DEDE' - fixed-point numbers 18:14
; Out:
;   HLHL' = HLHL' * DEDE', if define OVERFLOW set carry
; Corrupt:
; Note:
;                       [not working!]
;       HL  * DE  =            HL DE
;                       +
;       HL' * DE  =               HL'DE
;                       +
;       HL  * DE' =                  HL DE
;                       +
;       HL' * DE' =                     HL'DE
;                       ---------------------
;                              xx XX yy YY zz   = xxXX -> yyYYzz (discard)
;
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
; -----------------------------------------
MULL:           ; determining the resulting sign
                LD A, H
                XOR D
                EX AF, AF'                                                      ; save result sign

                ; reset signs of two numbers
                RES 7, H
                RES 7, D

                ; multiply the value of high word BC by DE
                EX DE, HL
                LD B, H
                LD C, L
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE
                PUSH HL                                                         ; save low value
                EX DE, HL                                                       ; change to HL - high value

                EXX                                                             ; calculate low value

                ; multiply the value of low word BC by DE
                EX DE, HL
                LD B, H
                LD C, L
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE

                ; addition of two results with shift
                ;   DE : HL
                ; +
                ;        DE : HL -> (discard)
                ; ------------
                ;   HL : DE

                POP HL                                                          ; restore low value
                ADD HL, DE

                EXX                                                             ; calculate high value

                ; was there an overflow 
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

; -----------------------------------------
; multiply two fixed-point number 18:14 and 2:14 (short)
; In:
;   HLHL' - fixed-point numbers 18:14
;   DE    - fixed-point numbers 2:14
; Out:
;   HLHL' = HLHL' * DE, if define OVERFLOW set carry
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;       HL  * DE  =            HL DE
;                       +
;       HL' * DE  =               HL'DE
;                       ---------------------
;                              xx XX yy  = xxXX -> yy (discard)
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
; -----------------------------------------
MULS:           ; determining the resulting sign
                LD A, H
                XOR D
                EX AF, AF'                                                      ; save result sign

                ; reset signs of two numbers
                RES 7, H
                RES 7, D

                PUSH DE                                                         ; save fixed-point numbers 2:14 (unsigned)

                ; multiply the value of high word BC by DE
                EX DE, HL
                LD B, H
                LD C, L
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE
                EX (SP), HL                                                     ; swap save fixed-point numbers 2:14 (unsigned) and low value
                PUSH HL                                                         ; save fixed-point numbers 2:14 (unsigned)
                EX DE, HL                                                       ; change to HL - high value

                EXX                                                             ; calculate low value

                ; multiply the value of low word BC by DE
                EX DE, HL
                POP BC                                                          ; restore fixed-point numbers 2:14 (unsigned)
                CALL Math.Mul_16x16                                             ; DEHL = BC * DE

                ; addition of two results with shift
                ;   DE : HL
                ; +
                ;        DE : HL -> (discard)
                ; ------------
                ;   HL : DE

                POP HL                                                          ; restore low value
                ADD HL, DE

                EXX                                                             ; adjustment high value

                ; was there an overflow 
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
