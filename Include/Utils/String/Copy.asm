
                ifndef _STRING_COPY_
                define _STRING_COPY_
; -----------------------------------------
; copy string
; In:
;   HL - pointer to string
;   DE - destenation
;   BC - buffer size
; Out:
;   BC - length copy string
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
Copy:           XOR A
                PUSH BC

.Loop           CP (HL)
                LDI
                JR Z, .NullTerminated
                JP PE, .Loop

                ; unknow length string (BC = 0)
                LD B, A
                LD C, A
                POP AF
                RET

.NullTerminated POP HL
                SBC HL, BC
                LD B, H
                LD C, L

                RET

                endif ; ~_STRING_COPY_
