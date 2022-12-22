
                ifndef _DEBUG_DRAW_CLEAR_SCREEN_
                define _DEBUG_DRAW_CLEAR_SCREEN_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearScreen:    LD HL, Debug.TEXT_VGA.ADR
                LD DE, (Debug.COLOR.GROUND_SCR << 8) | ' '
                LD BC, Debug.SCREEN.SIZE >> 1

.Loop           LD (HL), E
                INC HL
                LD (HL), D
                INC HL
                DEC BC
                LD A, B
                OR C
                JR NZ, .Loop

                RET

                endif ; ~_DEBUG_DRAW_CLEAR_SCREEN_
