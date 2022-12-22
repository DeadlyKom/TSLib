
                ifndef _STRING_GET_LENGTH_
                define _STRING_GET_LENGTH_
; -----------------------------------------
; get length of a null-terminated string
; In:
;   HL - pointer to string
; Out:
;   BC - length
; Corrupt:
;   HL, BC, AF
; Note:
; -----------------------------------------
Length:         XOR A
                LD B, A
                LD C, A

                CPIR

                ; NEG BC
                XOR A
                SUB C
                LD C, A
                SBC A, A
                SUB B
                LD B, A

                RET

                endif ; ~_STRING_GET_LENGTH_
