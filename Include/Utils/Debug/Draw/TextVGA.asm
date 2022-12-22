
                ifndef _DEBUG_DRAW_TEXT_VGA_
                define _DEBUG_DRAW_TEXT_VGA_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
TextVGA:        ; draw text VGA
                FT_BitmapHandle 0
                FT_BitmapSource FT_RAM_G + Debug.TEXT_VGA.RAM_G
                FT_BitmapLayout FT_TEXTVGA, 2 * Debug.SCREEN.WIDTH, Debug.SCREEN.HEIGHT
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, 8 * Debug.SCREEN.WIDTH, 16 * Debug.SCREEN.HEIGHT
                FT_BlendFunc FT_ONE, FT_ZERO
                FT_Begin FT_BITMAPS
                FT_Vertex2f 0, 0
                FT_End
                FT_BlendFunc FT_SRC_ALPHA, FT_ONE_MINUS_SRC_ALPHA

                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DispatchScreen: FT_WR_DMA Debug.TEXT_VGA.ADR, Debug.TEXT_VGA.PAGE, FT_RAM_G + Debug.TEXT_VGA.RAM_G, Debug.SCREEN.SIZE
                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Screen:         ; get page
                CALL Memory.GetPage2
                LD (.ComtainerPage), A
                
                ; set draw
                LD A, Debug.TEXT_VGA.PAGE
                CALL Memory.SetPage3
                
                CALL ClearScreen
                CALL DrawFrame
                CALL DispatchScreen

                ; set page
.ComtainerPage  EQU $+1
                LD A, #00
                CALL Memory.SetPage2
                RET

                endif ; ~_DEBUG_DRAW_TEXT_VGA_
