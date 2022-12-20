
                ifndef _STRING_TO_BYTE_
                define _STRING_TO_BYTE_
; -----------------------------------------
; convert string to unsigned char
; In:
;   HL - pointer to string buffer
; Out:
;   A  - byte value
; Corrupt:
; Note:
; -----------------------------------------
ToByte:         LD A, (HL)
                CP "-"
                JR NZ, .Convert
.IsNegative     INC HL
                CALL .Convert
                EX AF, AF'
                NEG
                RET

.IsPositive     CALL .Convert
                EX AF, AF'
                RET

.Convert        XOR A
.Loop           ; check char to number ASCII
                EX AF, AF'
                LD A, (HL)
                CP '9' + 1
                RET NC
                CP '0'
                RET C
                EX AF, AF'

                ; multiply to 10
                LD C, A
                ADD A, A
                ADD A, A
                ADD A, C
                ADD A, A

                ADD A, (HL)
                SUB '0'
                INC HL
                JR .Loop

                endif ; ~_STRING_TO_BYTE_
