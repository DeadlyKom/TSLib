                ifndef _FIXED_18_14_SUB_
                define _FIXED_18_14_SUB_
; -----------------------------------------
; subtract two fixed-point numbers 18:14
; In:
;   HLHL' - fixed-point numbers 18:14
;   BCBC' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' - BCBC', if define OVERFLOW set carry
; Corrupt:
;   HL, DE, BC, AF, HL', AF'
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
; -----------------------------------------
SUB:            ; definition of subtraction/addition operation
                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                LD A, H
                XOR B

                ; reset signs of two numbers
                RES 7, H                                                        ; reset sign lvalue
                RES 7, B                                                        ; reset sign rvalue
                JP P, ADDP                                                      ; jump if sign flag is reset, it's addition operation

; -----------------------------------------
; subtraction two fixed-point numbers 18:14 with the same signs
; In:
;   HLHL' - fixed-point numbers 18:14
;   BCBC' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' - BCBC', if define OVERFLOW set carry
; Corrupt:
;   HL, DE, BC, AF, HL', AF'
; Note:
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
;
;   HLBC = (+HLHL') - (+BCBC') = (+HLHL') + (-BCBC')
;   HLBC = (-HLHL') - (-BCBC') = (-HLHL') + (+BCBC')
; -----------------------------------------
SUBP            ; subtraction operation
                EXX
                OR A                                                            ; needed if direct calls to this function are used
                SBC HL, BC
                PUSH HL
                EXX
                SBC HL, BC
                POP BC

                ; check for overflow
                JR NC, .SetSign

                EX DE, HL                                                       ; save result high value
  
                ; negate low value
                LD A, C
                CPL
                LD L, A
                LD A, B
                CPL
                LD H, A
                LD BC, #00001
                ADD HL, BC

                EX DE, HL                                                       ; restore result high value

                ; negate high value
                LD A, L
                CPL
                LD L, A
                LD A, H
                CPL
                LD H, A
                DEC C
                ADC HL, BC

                ifdef FIXED_CHECK_OVERFLOW
                ; check for overflow
                BIT 7, H
                JR NZ, MinOverflow
                endif

                ; set low value
                LD B, D
                LD C, E

                ; change sign to opposite
                EX AF, AF'
                RLA
                RET C
                SET 7, H
                RET

.SetSign        ; set the resulting sign
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_18_14_SUB_
