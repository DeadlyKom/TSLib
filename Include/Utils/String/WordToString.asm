
                ifndef _STRING_WORD_TO_STRING_
                define _STRING_WORD_TO_STRING_
; -----------------------------------------
; convert unsigned word to string
; In:
;   HL - pointer to string buffer
;   DE - word value
; Out:
;   A  - string length (1-4 bytes witch null-terminated)
;   HL - pointer to null-terminate in string
; Corrupt:
; Note:
; -----------------------------------------
WordToString:   PUSH HL
                EX DE, HL
                CALL Conver.D16
                POP DE
                LD A, C
                INC C
                LDIR
                EX DE, HL
                DEC HL
                RET

                endif ; ~_STRING_WORD_TO_STRING_
