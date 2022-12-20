
                ifndef _MENU_NOT_ZIFI_
                define _MENU_NOT_ZIFI_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ScrNotZiFi:     ; flip flop red color
                LD DE, #1010
.Red            EQU $+1
                LD A, #FF
.Operation      EQU $
                DEC A
                JR NZ, .NotFlip
                LD A, (.Operation)
                XOR #01
                LD (.Operation), A
                RRA
                SBC A, A
.NotFlip        LD (.Red), A
                LD C, A
                CALL FT.Coprocessor.ColorRGB

                ; set font
                FT_BitmapHandle Font_12.Handle
                FT_BitmapSource Font_12.FTRAM_Adr + 148 - Font_12.Stride * Font_12.Height * Font_12.FirstChar
                FT_BitmapLayout FT_L1, Font_12.Stride, Font_12.Height
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Font_12.Width, Font_12.Height
                FT_SetFont Font_12.Handle, Font_12.FTRAM_Adr

                ; draw text
                FT_Text 40, 430, Font_12.Handle, FT_OPT_FILL
                FT_String .Faile, .Size

                ; draw spinner
                FT_ColorRGB 32, 64, 128
                FT_Spinner 560, 430, 3, 0

                ; reinitialize ZiFi
                JP Init_ZIFI

.Faile          BYTE "Sorry, no ZiFi device.\0"
.Size           EQU $-.Faile

                endif ; ~_MENU_NOT_ZIFI_
