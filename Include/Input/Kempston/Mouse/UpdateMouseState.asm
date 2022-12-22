
                            ifndef _INPUT_MOUSE_UPDATE_STATES_
                            define _INPUT_MOUSE_UPDATE_STATES_
; -----------------------------------------
; update the cursor position on the screen
; In :
; Out :
; Corrupt :
;   HL, E, BC, AF
; -----------------------------------------
UpdateMouseState:           CALL GetMouseX

                            LD E, A
                            LD HL, LastValueFromMousePortX
                            SUB (HL)
                            LD (HL), E
                            LD D, #00
                            JR Z, .SkipChangeX                                  ; delta is zero
                            JP P, .PositiveX

.NegativeX                  LD HL, (PositionX)
                            NEG
                            LD E, A
                            OR A
                            SBC HL, DE
                            JR NC, .SetMouseLocationX                           ; overflow check

                            ; cursor has reached the left edge of the screen
                            LD HL, #0000                                        ; clamp the value
                            JR .SetMouseLocationX

.PositiveX                  LD HL, (PositionX)

                            LD E, A
                            ADD HL, DE

                            LD DE, (ResolutionWidthPtr)
                            LD B, D
                            LD C, E
                            EX DE, HL
                            SBC HL, DE
                            EX DE, HL
                            JR NC, .SetMouseLocationX                           ; overflow check

                            ; cursor reaches the right edge of the screen
                            LD H, B
                            LD L, C

.SetMouseLocationX          LD (PositionX), HL
                            LD D, #00

.SkipChangeX                CALL GetMouseY

                            LD E, A
                            LD HL, LastValueFromMousePortY
                            SUB (HL)
                            LD (HL), E

                            RET Z                                               ; delta is zero
                            NEG                                                 ; invert the Y-axis value
                            JP P, .PositiveY

.NegativeY                  LD HL, (PositionY)
                            NEG
                            LD E, A
                            OR A
                            SBC HL, DE
                            JR NC, .SetMouseLocationY                           ; overflow check

                            ; cursor has reached the top of the screen
                            LD HL, #0000                                        ; clamp the value
                            JR .SetMouseLocationY

.PositiveY                  LD HL, (PositionY)
                            LD D, #00
                            LD E, A
                            ADD HL, DE

                            LD DE, (ResolutionHeightPtr)
                            LD B, D
                            LD C, E
                            EX DE, HL
                            SBC HL, DE
                            EX DE, HL
                            JR NC, .SetMouseLocationY                           ; overflow check

                            ; cursor reaches the bottom of the screen
                            LD H, B
                            LD L, C

.SetMouseLocationY          LD (PositionY), HL

                            RET
LastValueFromMousePortX:    DB #00
LastValueFromMousePortY:    DB #00

                            endif ; ~_INPUT_MOUSE_UPDATE_STATES_
