
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

                ; -----------------------------------------
                LD A, (ZiFi.CMD)
                CP ZIFI_CONNECTED
                JP Z, ZiFi.DrawCon
                CALL ZiFi.DrawSDK
                CALL ZiFi.DrawAP
                LD A, (Password.Flag)
                RRA
                CALL C, ZiFi.DrawPass
                CALL ZiFi.DrawSpin
                ; -----------------------------------------

                RET

Con.SetColor:   LD HL, Con.Counter
                JP ColorSelected

Con.AdrAP:      LD DE, AccessPoints
                ADD A, A
                ADD A, A
                ADD A, A
                LD H, #00
                LD L, A
                ADD HL, HL
                ADD HL, HL
                ADD HL, DE
                RET

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawSDK:   FT_ColorRGB 64, 64, 64
                
                LD A, (SDKVer.NumLines)
                OR A
                RET Z

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

                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawAP     ; clamp
                LD A, (AccessPoints.MaxVisible)
                LD C, A
                LD A, (AccessPoints.Num)
                OR A
                RET Z

                CP C
                JR C, .NotOverflow
                LD A, C
.NotOverflow    PUSH AF

                LD A, (AccessPoints.Num)
                CP NUMBER_VIS_AP
                CALL NC, ZiFi.DrawScroll
                
                ; clamp
                LD A, (Con.Counter.Offset)
                CALL Con.AdrAP
                POP AF
                JP ZiFi.DrawList
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawScroll FT_FGColor 0x00404080
                FT_BGColor 0x00080808

                ; SP+14 - maximum value
                ADD A, 9
                LD L, A
                LD H, #00
                PUSH HL

                ; SP+12 - size
                LD L, 10
                PUSH HL

                ; SP+10 - displayed value of scroll bar, between 0 and range inclusive
                LD A, (Con.Counter)
                LD L, A
                LD A, (Con.Counter.Offset)
                ADD A, L
                LD L, A
                PUSH HL

                ; SP+8  - by default the scroll bar is drawn with a 3D effect and the value of options is zero. 
                ;         options OPT_FLAT remove the 3D effect and its value is 256
                LD HL, FT_OPT_FLAT
                PUSH HL

                ; SP+6  - height of scroll bar, in pixels. 
                ;         if height is greater than width, the scroll bar is drawn vertically
                LD A, (AccessPoints.MaxVisible)
                LD B, A
                LD HL, #0000
                LD DE, FONT_12_HEIGHT
.CalcMaxHeight  ADD HL, DE
                DJNZ .CalcMaxHeight
                PUSH HL

                ; SP+4  - width of scroll bar, in pixels. 
                ;         if width is greater than height, the scroll bar is drawn horizontally
                LD HL, 16
                PUSH HL

                ; SP+2  - y-coordinate of scroll bar top-left, in pixels
                LD HL, 10
                PUSH HL

                ; SP+0  - x-coordinate of scroll bar top-left, in pixels
                LD HL, (ResolutionWidthPtr)
                LD DE, -FONT_12_HEIGHT
                ADD HL, DE
                PUSH HL
                CALL FT.Coprocessor.ScrollBar

                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawList   
.Loop           PUSH AF
                PUSH HL

                LD B, A
                LD A, (AccessPoints.MaxVisible)
                SUB B
                EX AF, AF'
                
                ;
                LD A, (AccessPoints.Num)
                CP NUMBER_VIS_AP
                JR NC, .More
                SUB B
                JR .SetColor
.More           EX AF, AF'
                LD C, A
                EX AF, AF'
                LD A, C
.SetColor       CALL Con.SetColor
                
                ; draw text AP
                LD HL, FONT_12_PADDING                                          ; offset y 
                LD DE, FONT_12_HEIGHT

                EX AF, AF'
                JR Z, .SkipHeightAP
                LD B, A

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
                JP NZ, .Loop
                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawSpin   LD A, (Password.Flag)
                RRA
                RET C
                
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
                CP ZIFI_UNKNOW
                JR Z, .Refresh
.Continue       LD A, #20
.Tick           LD (.TickCounter), A
                RET
.Refresh        LD A, (ZiFi.Req_CMD)
                CP ZIFI_CWJAP
                JR Z, .Connect
                CALL ZiFi.Init
                JR .Continue
.Connect        ; calculate string address selected AP
                LD A, (Con.Counter)
                LD L, A
                LD A, (Con.Counter.Offset)
                ADD A, L
                CALL Con.AdrAP
                INC HL
                INC HL
                LD DE, Password
                CALL ZiFi.Connect
                JR .Continue
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.DrawPass   FT_ColorRGB 64, 64, 64
                
                ; draw text
                LD HL, FONT_12_PADDING * 3                                      ; offset x
                LD DE, FONT_12_PADDING * 4                                      ; offset y 
                LD A, ANCHOR_LEFT | ANCHOR_UP
                CALL AnchorText
                LD A, Font_12.Handle                                            ; size font
                LD BC, FT_OPT_CENTERY
                PUSH HL ; x
                PUSH DE ; y
                CALL FT.Coprocessor.Text

                LD HL, Password
                CALL String.Length
                LD HL, Password
                CALL FT.Coprocessor.Copy

                POP HL
                LD DE, -6
                ADD HL, DE
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD (.CursorY), HL

                LD DE, #0000
                LD A, (Flags.InputCursor)
                OR A
                JR Z, .SkipOffset
                LD B, A
                LD HL, Password
.NextChar       LD A, (HL)
                EXX
                CALL GetCharWidth
                EXX
                ADD A, E
                LD E, A
                ADC A, D
                SUB E
                LD D, A
                INC HL
                DJNZ .NextChar
.SkipOffset
                POP HL
                ADD HL, DE
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD (.CursorX), HL

                ; draw cursor
                LD A, (TickCounterRef)
                AND #20
                RET Z
                FT_ColorRGB 255, 255, 255
                FT_LineWidth 1 << 4
                FT_Begin FT_LINES
.CursorY        EQU $+1
                LD DE, #0000
                PUSH DE
.CursorX        EQU $+1
                LD BC, #0000
                PUSH BC
                CALL FT.Coprocessor.Vertex2f
                POP BC
                POP DE
                LD HL, (FONT_12_HEIGHT - 4) << 4
                ADD HL, DE
                EX DE, HL
                CALL FT.Coprocessor.Vertex2f
                FT_End
                RET

ZiFi.DrawCon    FT_ColorRGB 0, 255, 0

                ; draw text
                LD HL, 0                                                        ; offset x
                LD DE, 0                                                        ; offset y 
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL AnchorText
                LD A, Font_12.Handle                                            ; size font
                LD BC, FT_OPT_CENTER
                CALL FT.Coprocessor.Text

                LD A, (ZiWi.CWJAP.ErrorCode)
                CP 0
                JR Z, .MessageOK
                CP 1
                JP Z, .MessageErr1
                CP 2
                JP Z, .MessageErr2
                CP 3
                JP Z, .MessageErr3
                CP 4
                JP Z, .MessageErr4

                ;
                LD A, ZIFI_UNKNOW
                LD (ZiFi.Req_CMD), A
                RET

.MessageOK      LD HL, .ConOK
                CALL String.Length
                LD HL, .ConOK
                CALL FT.Coprocessor.Copy
                CALL .WaitAnyKeys
                RET NC
                JP Con.Back

.ConOK          BYTE "Connected to ZiFi\0"

.MessageFAIL    LD HL, .ConFAIL
                CALL String.Length
                LD HL, .ConFAIL
                CALL FT.Coprocessor.Copy

                FT_ColorRGB 255, 0, 0

                ; draw text
                LD HL, 0                                                        ; offset x
                LD DE, FONT_12_HEIGHT                                           ; offset y 
                LD A, ANCHOR_H_CENTER | ANCHOR_V_CENTER
                CALL AnchorText
                LD A, Font_12.Handle                                            ; size font
                LD BC, FT_OPT_CENTER
                JP FT.Coprocessor.Text
.ConFAIL        BYTE "ERROR.\0"

.MessageErr1    CALL .MessageFAIL
                LD HL, .Error_01
                CALL String.Length
                LD HL, .Error_01
                CALL FT.Coprocessor.Copy
                JP .WaitAnyKeys
.Error_01       BYTE "Connection timeout.\0"

.MessageErr2    CALL .MessageFAIL
                LD HL, .Error_02
                CALL String.Length
                LD HL, .Error_02
                CALL FT.Coprocessor.Copy
                JP .WaitAnyKeys
.Error_02       BYTE "Wrong password.\0"

.MessageErr3    CALL .MessageFAIL
                LD HL, .Error_03
                CALL String.Length
                LD HL, .Error_03
                CALL FT.Coprocessor.Copy
                JP .WaitAnyKeys
.Error_03       BYTE "Can't find the target AP.\0"

.MessageErr4    CALL .MessageFAIL
                LD HL, .Error_04
                CALL String.Length
                LD HL, .Error_04
                CALL FT.Coprocessor.Copy
                JP .WaitAnyKeys
.Error_04       BYTE "Connection failed.\0"

.WaitAnyKeys    LD A, (Input.Keyboard.PS2.AnyKeys)
                RRA
                RET NC
                LD A, ZIFI_UNKNOW
                LD (ZiFi.CMD), A
                LD (ZiFi.Req_CMD), A
                RET

Con.Counter:    DB #00
.Offset         DB #00
SDKVer:         DS 128, 0
.NumLines:      DB #00
AccessPoints:   FAccessPoint = $
                DS FAccessPoint * NUMBER_AP, 0
.Num:           DB #00
.MaxVisible     DB NUMBER_VIS_AP
Password:       DS 32, 0
.Flag           DB #00

                endif ; ~_MENU_OPTIONS_CONNECT_
