                ifndef _FIXED_2_14_ADD_
                define _FIXED_2_14_ADD_
; -----------------------------------------
; add two fixed-point numbers 2:14
; In:
;   HL, DE numbers to add
; Out:
;   HL = HL + DE,  if define OVERFLOW set carry
; Corrupt:
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
                RES 7, H
                RES 7, D
                JP M, SUBP                                                      ; jump if sign flag is set, it's subtraction operation

; -----------------------------------------
; add two fixed-point numbers 2:14 with the same sign
; In:
;   HL, DE numbers to add
; Out:
;   HL = HL + DE,  if define OVERFLOW set carry
; Corrupt:
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
;
;   HL = (+HL) + (+DE)
;   HL = (-HL) + (-DE)
; -----------------------------------------
ADDP:           ; addition operation
                ADD HL, DE

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
                LD HL, FIXED_214_MAX_P
                ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif ; ~_FIXED_2_14_ADD_
