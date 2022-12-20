
                ifndef _MENU_MAIN_
                define _MENU_MAIN_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ScrMain:        ; set font
                FT_BitmapHandle Font_30.Handle
                FT_BitmapSource Font_30.FTRAM_Adr + 148 - Font_30.Stride * Font_30.Height * Font_30.FirstChar
                FT_BitmapLayout FT_L1, Font_30.Stride, Font_30.Height
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Font_30.Width, Font_30.Height
                FT_SetFont Font_30.Handle, Font_30.FTRAM_Adr

                ; draw text
                XOR A
                CALL Menu.SetColor
                LD HL, #0000                                                    ; offset x
                LD DE, FONT_30_HEIGHT * 0                                        ; offset y
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL Menu.Text
                FT_String StartGame, StartGame.Size

                ; draw text
                LD A, #01
                CALL Menu.SetColor
                LD HL, #0000                                                    ; offset x
                LD DE, FONT_30_HEIGHT * 1                                        ; offset y
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL Menu.Text
                FT_String Options, Options.Size

                ; draw text
                LD A, #02
                CALL Menu.SetColor
                LD HL, #0000                                                    ; offset x
                LD DE, FONT_30_HEIGHT * 2                                        ; offset y
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL Menu.Text
                FT_String Statistics, Statistics.Size

                RET

Menu.SetColor:  LD HL, Menu.Counter
                JP ColorSelected

Menu.Text       CALL AnchorText
.Aligned        LD A, Font_30.Handle                                            ; size font
                LD BC, FT_OPT_CENTER
                JP FT.Coprocessor.Text
; -----------------------------------------
; обработчик клавиш меню
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MenuInput:      JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Menu.ArrowUP
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Menu.ArrowDOWN
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Menu.Selected

.NotProcessing  SCF
                RET

.Processed      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Menu.ArrowUP:   LD A, (Menu.Counter)
                DEC A
                RET M
                LD (Menu.Counter), A
                RET
Menu.ArrowDOWN: LD A, (Menu.Counter)
                INC A
                CP #03
                RET NC
                LD (Menu.Counter), A
                RET

Menu.Selected:  LD A, (Menu.Counter)
                CP #00                                                          ; start game
                RET Z
                CP #01                                                          ; options
                JR Z, Menu.Options
                RET                                                             ; statistics

Menu.Options:   LD A, MENU_OPTIONS
                LD (Flags.Menu), A
                XOR A
                LD (Op.Counter), A
                RET

Menu.Counter:   DB #00

StartGame:      BYTE "START GAME\0"
.Size           EQU $-StartGame

Options:        BYTE "OPTIONS\0"
.Size           EQU $-Options

Statistics:     BYTE "STATISTICS\0"
.Size           EQU $-Statistics

                endif ; ~_MENU_MAIN_
