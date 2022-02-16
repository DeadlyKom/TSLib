                ifndef _FIXED_18_14_ADD_
                define _FIXED_18_14_ADD_
; -----------------------------------------
; add two fixed-point numbers 18:14
; In:
;   HLHL' - fixed-point numbers 18:14
;   DEDE' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' + DEDE', if define OVERFLOW set carry
; Corrupt:
;   HL, DE, AF, HL', AF'
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
; -----------------------------------------
ADD:            ; definition of subtraction/addition operation
                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                LD A, H
                XOR D

                ; reset signs of two numbers
                RES 7, H                                                        ; reset sign lvalue
                RES 7, D                                                        ; reset sign rvalue
                JP M, SUBP                                                      ; jump if sign flag is set, it's subtraction operation

; -----------------------------------------
; add two fixed-point numbers 18:14 with the same sign
; In:
;   HLHL' - fixed-point numbers 18:14
;   DEDE' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' + DEDE', if define OVERFLOW set carry
; Corrupt:
;   HL, DE, AF, HL', AF'
; Note:
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
;
;   HLBC = (+HLHL') + (+DEDE')
;   HLBC = (-HLHL') + (-DEDE')
; -----------------------------------------
ADDP:           ; addition operation
                EXX
                ADD HL, DE
                PUSH HL
                EXX
                ADC HL, DE
                POP DE

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

                endif ; ~_FIXED_18_14_ADD_
