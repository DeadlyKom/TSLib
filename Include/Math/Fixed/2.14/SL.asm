                ifndef _FIXED_2_14_SHIFT_LEFT_
                define _FIXED_2_14_SHIFT_LEFT_
; -----------------------------------------
; shift left fixed-point numbers 2:14
; In:
;   HL - fixed-point numbers 2:14
;   B  - number of shifts
; Out:
;   HLDE = HL << B
; Corrupt:
;   HL, DE, B, AF, AF'
; Note:
;   define FIXED_CHECK_OVERFLOW - adds an overflow check
;   define CARRY_FLOW_WARNING   - calling the overflow error display function 'OVER_COL_WARNING'
;   define OVERFLOW             - reflect overflow result in carry flag
; -----------------------------------------
SL:             LD DE, #0000
                
                LD A, H
                EX AF, AF'                                                      ; save 7 bits for resulting sign
                RES 7, H                                                        ; reset sign of number

                ; check register B is not zero
                INC B
                DEC B
                JR Z, .Set
                
                ; shift
.Loop           ADD HL, HL
                EX DE, HL
                ADC HL, HL

                ifdef FIXED_CHECK_OVERFLOW
                ; check for overflow
                JR C, MaxOverflow
                endif

                EX DE, HL
.NextShift      DJNZ .Loop
.Set            EX DE, HL

                EX AF, AF'                                                      ; restore 7 bits for resulting sign
                RLA
                RET NC
                SET 7, H
                RET

                endif ; ~_FIXED_2_14_SHIFT_LEFT_
