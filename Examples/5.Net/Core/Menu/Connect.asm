
                ifndef _MENU_OPTIONS_CONNECT_
                define _MENU_OPTIONS_CONNECT_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ScrConnect:     CALL Net.ZiFi.Response

                ; set font
                FT_BitmapHandle Font_12.Handle
                FT_BitmapSource Font_12.FTRAM_Adr + 148 - Font_12.Stride * Font_12.Height * Font_12.FirstChar
                FT_BitmapLayout FT_L1, Font_12.Stride, Font_12.Height
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Font_12.Width, Font_12.Height
                FT_SetFont Font_12.Handle, Font_12.FTRAM_Adr

                FT_ColorRGB 64, 64, 64

                ; -----------------------------------------
                LD A, (SDKVer.NumLines)
                OR A
                JR Z, .NotSDKVer

                LD HL, SDKVer

.SDKLoop        PUSH AF
                PUSH HL

                ; draw text
                LD HL, FONT_12_PADDING                                          ; offset y 
                LD DE, FONT_12_HEIGHT
                LD B, A
.HeightSDKLoop  ADD HL, DE
                DJNZ .HeightSDKLoop
                
                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                EX DE, HL

                LD HL, FONT_12_PADDING                                          ; offset x
                LD A, ANCHOR_LEFT | ANCHOR_DOWN
                CALL AnchorText
                LD A, Font_12.Handle                                            ; size font
                LD BC, FT_OPT_NONE
                CALL FT.Coprocessor.Text

                POP HL
                PUSH HL
                CALL String.Length
                POP DE
                PUSH HL
                EX DE, HL
                CALL FT.Coprocessor.Copy
                POP HL

                POP AF
                DEC A
                JR NZ, .SDKLoop
.NotSDKVer      ; -----------------------------------------

                LD A, (AccessPoints.Num)
                OR A
                JP Z, .NotAP

                LD HL, AccessPoints

.APLoop         PUSH AF
                PUSH HL

                LD B, A
                LD A, (AccessPoints.Num)
                SUB B

                CALL Con.SetColor
                
                ; draw text AP
                LD HL, FONT_12_PADDING                                          ; offset y 
                LD DE, FONT_12_HEIGHT

                LD B, A
                OR A
                JR Z, .SkipHeightAP

.HeightAPLoop   ADD HL, DE
                DJNZ .HeightAPLoop
.SkipHeightAP   EX DE, HL

                LD HL, FONT_12_PADDING * 2                                      ; offset x
                LD A, ANCHOR_H_CENTER | ANCHOR_UP
                CALL AnchorText
                LD A, Font_12.Handle                                            ; size font
                LD BC, FT_OPT_CENTERY

                LD (.PositionX), HL
                LD (.PositionY), DE

                CALL FT.Coprocessor.Text

                POP HL
                PUSH HL
                INC HL
                INC HL
                PUSH HL
                CALL String.Length
                POP HL
                CALL FT.Coprocessor.Copy

                POP HL
                PUSH HL
                INC HL
                LD A, (HL)
                ADD A, 100
                PUSH AF
                CALL ColorSignal

                FT_Begin(FT_POINTS)
                POP AF
                LD D, #00
                ADD A, A
                RL D
                LD E, A
                CALL FT.Coprocessor.PointSize

.PositionY      EQU $+1
                LD HL, #0000
                LD BC, 3
                ADD HL, BC
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                EX DE, HL

.PositionX      EQU $+1
                LD HL, #0000
                LD BC, -20
                ADD HL, BC
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD B, H
                LD C, L
                CALL FT.Coprocessor.Vertex2f
                FT_End

                POP HL
                LD DE, FAccessPoint
                ADD HL, DE

                POP AF
                DEC A
                JP NZ, .APLoop

.NotAP          ; -----------------------------------------
                LD A, (ZiFi.CMD)
                INC A
                JR Z, .SkipStartAnim
                
                ; start an animated spinner
                FT_ColorRGB 48, 32, 128
                LD HL, -FONT_12_PADDING * 3                                     ; offset x
                LD DE, -FONT_12_HEIGHT * 2                                      ; offset y
                LD A, ANCHOR_RIGHT | ANCHOR_DOWN
                CALL AnchorText
                LD A, 3                                                         ; style
                LD BC, 0                                                        ; scale
                CALL FT.Coprocessor.Spinner
.SkipStartAnim  ;
.TickCounter    EQU $+1
                LD A, #20
                DEC A
                JR NZ, .Tick
                LD A, (ZiFi.CMD)
                INC A
                CALL Z, ZiFi.Init
                LD A, #20
.Tick           LD (.TickCounter), A

                RET

Con.SetColor:   LD HL, Con.Counter
                JP ColorSelected

; -----------------------------------------
; обработчик клавиш опций
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ConnectInput:   JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Con.ArrowUP
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Con.ArrowDOWN
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Con.Selected
                CP KEY_ID_BACK_ESC                                              ; клавиша "отмена/назад"
                JP Z, Con.Back
                CP KEY_ID_BACKSPACE                                             ; клавиша "отмена/назад"
                JP Z, Con.Back

.NotProcessing  SCF
                RET

.Processed      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Con.ArrowUP:    LD A, (Con.Counter)
                DEC A
                RET M
                LD (Con.Counter), A
                RET
Con.ArrowDOWN:  LD A, (AccessPoints.Num)
                LD C, A
                LD A, (Con.Counter)
                INC A
                CP C
                RET NC
                LD (Con.Counter), A
                RET
Con.Selected:   LD A, (Con.Counter)
                CP #00                                                          ; resolution
                JR Z, Con.Resolution
                RET                                                             ; connect
Con.Resolution: RET
Con.Back:       LD A, MENU_OPTIONS
                LD (Flags.Menu), A
                LD A, #00
                LD (AccessPoints.Num), A
                RET
                ; JP ZiFi.Sutdown

Con.Counter:    DB #00
SDKVer:         DS 128, 0
.NumLines:      DB #00
AccessPoints:   FAccessPoint = $
                DS FAccessPoint * NUMBER_AP, 0
.Num:           DB #00

                endif ; ~_MENU_OPTIONS_CONNECT_
