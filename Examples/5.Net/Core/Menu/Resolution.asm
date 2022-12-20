
                ifndef _MENU_OPTIONS_RESOLUTION_
                define _MENU_OPTIONS_RESOLUTION_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ScrResolution:  ; set font
                FT_BitmapHandle Font_30.Handle
                FT_BitmapSource Font_30.FTRAM_Adr + 148 - Font_30.Stride * Font_30.Height * Font_30.FirstChar
                FT_BitmapLayout FT_L1, Font_30.Stride, Font_30.Height
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Font_30.Width, Font_30.Height
                FT_SetFont Font_30.Handle, Font_30.FTRAM_Adr

                LD B, #09
                EXX
                LD HL, SetResolution.AvailableRes + 2
                EXX
                
.Loop           PUSH BC
                ; set color text
                LD A, #09
                SUB B
                LD C, A
                EX AF, AF'
                LD A, C
                CALL Res.SetColor

                ; calculate position text
                LD DE, FONT_30_HEIGHT * 8                                        ; offset y
                CALL AdjustHeight
                EX AF, AF'
                JR Z, .IsFirstRow
                LD DE, FONT_30_HEIGHT
                LD B, A
.HeightLoop     ADD HL, DE
                DJNZ .HeightLoop
.IsFirstRow     LD DE, #0000                                                    ; offset x
                CALL AdjustWidth
                EX DE, HL
                CALL Menu.Text.Aligned

                ; printf "%ix%i %iHz\0"
                LD HL, VideoMode
                
                CALL .GetResValue
                CALL String.WordToString
                LD (HL), "x"
                INC HL
                CALL .GetResValue
                CALL String.WordToString
                LD (HL), " "
                INC HL
                CALL .GetResValue
                CALL String.WordToString
                LD (HL), "H"
                INC HL
                LD (HL), "z"
                INC HL
                LD (HL), #00
                INC HL

                ; add text
                LD DE, VideoMode
                OR A
                SBC HL, DE
                LD B, H
                LD C, L
                EX DE, HL
                CALL FT.Coprocessor.Copy

                ; skip const value
                EXX
                INC HL
                INC HL
                EXX
                ; -----------------

                POP BC
                DJNZ .Loop

                RET
.GetResValue    EXX
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                PUSH BC
                EXX
                POP DE
                RET

Res.SetColor:   LD HL, Res.Counter
                JP ColorSelected
; -----------------------------------------
; обработчик клавиш разрешения
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ResolutionInput JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Res.ArrowUP
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Res.ArrowDOWN
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Res.Selected
                CP KEY_ID_BACK_ESC                                              ; клавиша "отмена/назад"
                JP Z, Res.Back
                CP KEY_ID_BACKSPACE                                             ; клавиша "отмена/назад"
                JP Z, Res.Back

.NotProcessing  SCF
                RET

.Processed      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Res.ArrowUP:    LD A, (Res.Counter)
                DEC A
                RET M
                LD (Res.Counter), A
                RET
Res.ArrowDOWN:  LD A, (Res.Counter)
                INC A
                CP #09
                RET NC
                LD (Res.Counter), A
                RET
Res.Selected:   FT_CMD_RESET
                LD A, (Res.Counter)
                CALL SetResolution
                RET
                ; ToDo проверка поддерживаемого разрешения
Res.Back:       LD A, MENU_OPTIONS
                LD (Flags.Menu), A
                RET

Res.Counter:    DB #00
VideoMode:      DS 16, 0 

                endif ; ~_MENU_OPTIONS_RESOLUTION_
