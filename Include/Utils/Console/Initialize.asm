
                ifndef _DEBUG_CONSOLE_INITIALIZE_
                define _DEBUG_CONSOLE_INITIALIZE_
; -----------------------------------------
; initialize console
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; reset offset buffer
                LD HL, Buffer
                LD (Buffer.Offset), HL
                LD HL, BUFFER_SIZE
                LD (Buffer.Free), HL
                
                RET

                endif ; ~_DEBUG_CONSOLE_INITIALIZE_
