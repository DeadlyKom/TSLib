
                ifndef _MENU_COLOR_
                define _MENU_COLOR_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ColorSelected:  CP (HL)
                JR Z, .Selected
                FT_ColorRGB 64, 64, 128
                RET
.Selected       FT_ColorRGB 64, 255, 128
                RET
; -----------------------------------------
; In:
;   A - signal strength
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ColorSignal:    LD B, A

                ; blue = 0
                LD E, #00

                ; green = min(255, (100-A)*2)
                LD A, B
                ADD A, A
                ADD A, A
                JR NC, $+3
                SBC A, A
                LD D, A

                ; red min(255, A*2)
                LD A, 100
                SUB B
                ADD A, A
                JR NC, $+3
                SBC A, A
                LD C, A

                CALL FT.Coprocessor.ColorRGB
                RET

                endif ; ~_MENU_COLOR_
