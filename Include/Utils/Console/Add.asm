
                ifndef _DEBUG_CONSOLE_ADD_MESSAGE_
                define _DEBUG_CONSOLE_ADD_MESSAGE_
; -----------------------------------------
; add message to console
; In:
;   A  - type message
;   HL - pointer to message
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Add:            ;
                LD DE, (Buffer.Offset)
                LD (DE), A
                INC DE
                LD BC, (Buffer.Free)
                CALL String.Copy
                LD (Buffer.Offset), DE

                ; buffer
                LD HL, (Buffer.Free)
                SBC HL, BC
                LD (Buffer.Free), HL

                LD HL, Buffer.Counter
                INC (HL)
                
                RET

                endif ; ~_DEBUG_CONSOLE_ADD_MESSAGE_
