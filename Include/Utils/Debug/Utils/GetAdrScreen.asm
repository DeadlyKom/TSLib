
                ifndef _DEBUG_UTILS_GET_ADDRESS_SCREEN_
                define _DEBUG_UTILS_GET_ADDRESS_SCREEN_
; -----------------------------------------
; In:
;   BC - the location of the displayed disassembled code (B - X, C - Y)
; Out:
;   HL - character address in screen coordinates
; Corrupt:
;   HL, B, AF
; -----------------------------------------
GetAdrScreen:   ; calculate X
                LD HL, #FFFE
                PUSH DE
                LD DE, #0002
                INC B

.LoopMultX      ADD HL, DE
                DJNZ .LoopMultX
                PUSH HL

                ; calculate Y
                LD HL, (-(Debug.SCREEN.WIDTH << 1)) & 0xFFFF
                LD DE, Debug.SCREEN.WIDTH << 1
                LD B, C
                INC B

.LoopMultY      ADD HL, DE
                DJNZ .LoopMultY

                POP DE
                ADD HL, DE
                LD DE, Debug.TEXT_VGA.ADR
                ADD HL, DE
                POP DE

                RET

                endif ; ~_DEBUG_UTILS_GET_ADDRESS_SCREEN_
