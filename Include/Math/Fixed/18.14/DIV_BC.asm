                ifndef _FIXED_18_14_DIVISION_BC_
                define _FIXED_18_14_DIVISION_BC_
; -----------------------------------------
; divides fixed-point numbers 18:14 by BC
; In:
;   HLDE - fixed-point numbers 18:14
;   FBC  - divider [16..0] (flag Carry 17 bit)
;   F'   - flag Carry sign
; Out:
;   HLDE = HLDE / BC
; Corrupt:
; Note:
; -----------------------------------------
DIV_FBC:        ; determining the resulting sign
                PUSH AF
                EX AF, AF'
                RRA
                XOR H
                EX AF, AF'                                                      ; save result sign

                ; reset signs of number
                RES 7, H

                ; checking if values need to be reduced (loss of precision)
                POP AF
                JR NC, .Division

                ; HLDE / 2
                SRL H
                RR L
                RR D
                RR E

                ; BC / 2
                SRL B
                RR C

.Division       ; check division by zero
                LD A, B
                OR C
                JR NZ, $+3
                INC C

                CALL Math.Div_32x16

.SetSign        ; set the resulting sign
                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_18_14_DIVISION_BC_
