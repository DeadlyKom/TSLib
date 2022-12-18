
                ifndef _STRING_BYTE_TO_STRING_
                define _STRING_BYTE_TO_STRING_
; -----------------------------------------
; convert unsigned char to string
; In:
;   A  - byte value
;   HL - pointer to string buffer
; Out:
;   A  - string length (1-4 bytes witch null-terminated)
;   HL - pointer to null-terminate in string
; Corrupt:
; Note:
; -----------------------------------------
ByteToString:   PUSH HL
                CALL Conver.D8
                POP DE
                LD A, C
                INC C
                LDIR
                EX DE, HL
                DEC HL
                RET

                endif ; ~_STRING_BYTE_TO_STRING_
