                ifndef _FIXED_18_14_CONVERT_2_14_TO_18_14_
                define _FIXED_18_14_CONVERT_2_14_TO_18_14_
; -----------------------------------------
; convert fixed-point numbers 2:14 to fixed-point numbers 18:14
; In:
;   HL   - fixed-point numbers 2:14
; Out:
;   HLDE - fixed-point numbers 18:14
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
CWD:            EX DE, HL
                LD A, D
                AND %10000000
                LD H, A
                LD L, #00
                RES 7, D

                RET

                endif ; ~_FIXED_18_14_CONVERT_2_14_TO_18_14_
