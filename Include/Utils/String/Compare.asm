
                ifndef _STRING_COMPARE_
                define _STRING_COMPARE_
; -----------------------------------------
; compare string
; In:
;   HL - pointer to first string
;   DE - pointer to second string
; Out:
;   if the C flag is reset, two string is equals
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   length second string < length first string
; -----------------------------------------
Compare:        ; check length string more zero
                LD A, (DE)
                OR A
                SCF
                RET Z                                                           ; exit, if null-terminated (the C flag is set)

                ; compare string
.Loop           LD A, (DE)
                OR A
                RET Z                                                           ; exit, if null-terminated (the C flag is reset)
                CPI
                INC DE
                JR Z, .Loop

                SCF
                RET

                endif ; ~_STRING_COMPARE_
