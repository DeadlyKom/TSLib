
                ifndef _DEBUG_DRAW_DRAW_FRAME_
                define _DEBUG_DRAW_DRAW_FRAME_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawFrame:      ifdef _MEM_DUMP
                CALL Debug.MemDump.Draw
                LD HL, (Debug.MemDump.Address)
                LD A, Debug.COLOR.ADR
                CALL Debug.MemDump.DrawLabel
                endif

                RET

                endif ; ~_DEBUG_DRAW_DRAW_FRAME_
