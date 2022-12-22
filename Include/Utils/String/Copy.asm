
                ifndef _STRING_COPY_
                define _STRING_COPY_
; -----------------------------------------
; copy string
; In:
;   HL - pointer to string
;   DE - destenation buffer
;   BC - buffer size
; Out:
;   BC - remaining free buffer size
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   not copy null-terminate
; -----------------------------------------
Copy:           XOR A
.Loop           CP (HL)
                RET Z                                                           ; exit, if null-terminated
                LDI
                JP PE, .Loop

                RET

                endif ; ~_STRING_COPY_
