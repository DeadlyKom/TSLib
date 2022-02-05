                ifndef _FIXED_18_14_ADD_
                define _FIXED_18_14_ADD_
; -----------------------------------------
; add two fixed-point numbers 18:14
; In:
;   HLHL' - fixed-point numbers 18:14
;   BCBC' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' + BCBC', if define OVERFLOW set carry
; Corrupt:
;   HL, BC, AF, HL', AF'
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
; -----------------------------------------
ADD:            ; definition of subtraction/addition operation
                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                LD A, H
                XOR B

                ; reset signs of two numbers
                RES 7, H                                                        ; reset sign lvalue
                RES 7, B                                                        ; reset sign rvalue
                JP M, SUBP                                                      ; jump if sign flag is set, it's subtraction operation

; -----------------------------------------
; add two fixed-point numbers 18:14 with the same sign
; In:
;   HLHL' - fixed-point numbers 18:14
;   BCBC' - fixed-point numbers 18:14
; Out:
;   HLBC = HLHL' + BCBC',  if define OVERFLOW set carry
; Corrupt:
;   HL, BC, AF, HL', AF'
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
;
;   HLBC = (+HLHL') + (+BCBC')
;   HLBC = (-HLHL') + (-BCBC')
; -----------------------------------------
ADDP:           ; addition operation
                EXX
                ADD HL, BC
                PUSH HL
                EXX
                ADC HL, BC
                POP BC

                ; check for overflow
                BIT 7, H
                JR NZ, .Overflow

                ; set the resulting sign
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

.Overflow       ; set maximum available value
                LD HL, (FIXED_1814_MAX_P >> 16) & 0xFFFF
                LD BC, (FIXED_1814_MAX_P >>  0) & 0xFFFF
                ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif ; ~_FIXED_18_14_ADD_