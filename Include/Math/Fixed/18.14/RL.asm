                ifndef _FIXED_2_14_SHIFT_LEFT_
                define _FIXED_2_14_SHIFT_LEFT_
; -----------------------------------------
; shift right fixed-point numbers 18:14
; In:
;   HLDE - fixed-point numbers 18:14
;   B    - number of shifts
; Out:
;   HLDE = HLDE >> B
; Corrupt:
; Note:
; -----------------------------------------
SL:             ; check register B is not zero
                INC B
                DEC B
                RET Z

                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                RES 7, H

                ; shift
.Loop           OR A
                RR H
                RR L
                RR D
                RR E
                DJNZ .Loop

                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_2_14_SHIFT_LEFT_
