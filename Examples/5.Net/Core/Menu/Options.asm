
                ifndef _MENU_OPTIONS_
                define _MENU_OPTIONS_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ScrOptions:      ; set font
                FT_BitmapHandle Font_30.Handle
                FT_BitmapSource Font_30.FTRAM_Adr + 148 - Font_30.Stride * Font_30.Height * Font_30.FirstChar
                FT_BitmapLayout FT_L1, Font_30.Stride, Font_30.Height
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Font_30.Width, Font_30.Height
                FT_SetFont Font_30.Handle, Font_30.FTRAM_Adr

                ; draw text
                XOR A
                CALL Op.SetColor
                LD HL, #0000                                                    ; offset x
                LD DE, FONT_30_HEIGHT * 0                                        ; offset y
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL Menu.Text
                FT_String Resolution, Resolution.Size

                ; draw text
                LD A, #01
                CALL Op.SetColor
                LD HL, #0000                                                    ; offset x
                LD DE, FONT_30_HEIGHT * 1                                        ; offset y
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL Menu.Text
                FT_String Connect, Connect.Size

                RET

Op.SetColor:    LD HL, Op.Counter
                JP ColorSelected

; -----------------------------------------
; обработчик клавиш опций
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
OptionsInput:   JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Op.ArrowUP
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Op.ArrowDOWN
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Op.Selected
                CP KEY_ID_BACK_ESC                                              ; клавиша "отмена/назад"
                JP Z, Op.Back
                CP KEY_ID_BACKSPACE                                             ; клавиша "отмена/назад"
                JP Z, Op.Back

.NotProcessing  SCF
                RET

.Processed      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Op.ArrowUP:     LD A, (Op.Counter)
                DEC A
                RET M
                LD (Op.Counter), A
                RET
Op.ArrowDOWN:   LD A, (Op.Counter)
                INC A
                CP #02
                RET NC
                LD (Op.Counter), A
                RET
Op.Selected:    LD A, (Op.Counter)
                CP #00                                                          ; resolution
                JR Z, Op.Resolution
                ; connect
                LD A, MENU_CONNECT
                LD (Flags.Menu), A
                JP ZiFi.Init
Op.Resolution:  LD A, MENU_RESOLUTION
                LD (Flags.Menu), A
                RET
Op.Back:        LD A, MENU_START_GAME
                LD (Flags.Menu), A
                RET

Op.Counter:     DB #00
Resolution:     BYTE "RESOLUTION\0"
.Size           EQU $-Resolution
Connect:        BYTE "CONNECT\0"
.Size           EQU $-Connect

                endif ; ~_MENU_OPTIONS_
