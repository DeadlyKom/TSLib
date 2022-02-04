                ifndef _FIXED_2_14_SUB_
                define _FIXED_2_14_SUB_
; -----------------------------------------
; subtract two fixed-point numbers 2:14
; In:
;   HL, DE numbers to subtract
; Out:
;   HL = HL - DE,  if define OVERFLOW set carry
; Corrupt:
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
; -----------------------------------------
SUB:            ; definition of subtraction/addition operation
                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                LD A, H
                XOR D

                ; reset signs of two numbers
                RES 7, H
                RES 7, D
                JP P, ADDP                                                      ; jump if sign flag is reset, it's addition operation

; -----------------------------------------
; Subtraction two fixed-point numbers 2:14 with the same signs
; In:
;   HL, DE numbers to subtract
; Out:
;   HL = HL - DE,  if define OVERFLOW set carry
; Corrupt:
; Note:
;   define CARRY_FLOW_WARNING - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW           - reflect overflow result in carry flag
;
;   HL = (+HL) - (+DE) = (+HL) + (-DE)
;   HL = (-HL) - (-DE) = (-HL) + (+DE)
; -----------------------------------------
SUBP            ; subtraction operation
                OR A                                                            ; needed if direct calls to this function are used
                SBC HL, DE

                ; check for overflow
                JR NC, .SetSign

                ; negate value
                LD A, L
                CPL
                LD L, A
                LD A, H
                CPL
                LD H, A
                INC HL

                ; check for overflow
                BIT 7, H
                JR NZ, .Overflow

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

.Overflow       ; set the minimum negative value available
                LD HL, FIXED_214_MIN_N
                ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif ; ~_FIXED_2_14_SUB_
