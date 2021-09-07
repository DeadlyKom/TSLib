
                            ifndef _INPUT_MOUSE_UPDATE_STATES_
                            define _INPUT_MOUSE_UPDATE_STATES_
; -----------------------------------------
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
                            JR Z, .SkipChangeX                      ; дельта равна 0
                            JP P, .PositiveX

.NegativeX                  LD HL, (PositionX)
                            NEG
                            LD E, A
                            OR A
                            SBC HL, DE

                            JR NC, .SetMouseLocationX               ; проверка на переполнение
                            ; курсор достиг левого края экрана
                            LD HL, #0000                            ; фиксируем значение
                            JR .SetMouseLocationX

.PositiveX                  LD HL, (PositionX)
                            ; LD D, #00
                            LD E, A
                            ADD HL, DE

                            LD DE, (ResolutionWidthPtr)
                            LD B, D
                            LD C, E
                            EX DE, HL
                            SBC HL, DE
                            EX DE, HL
                            JR NC, .SetMouseLocationX               ; проверка на переполнение
                            ; курсор достих правого края экрана
                            LD H, B
                            LD L, C

.SetMouseLocationX          LD (PositionX), HL
                            LD D, #00

.SkipChangeX                CALL GetMouseY
                            LD E, A
                            LD HL, LastValueFromMousePortY
                            SUB (HL)
                            LD (HL), E

                            RET Z                                   ; дельта равна 0
                            NEG                                     ; инвертнём значение оси Y
                            JP P, .PositiveY

.NegativeY                  LD HL, (PositionY)
                            ; LD D, #FF
                            NEG
                            LD E, A
                            OR A
                            SBC HL, DE
                            JR NC, .SetMouseLocationY               ; проверка на переполнение
                            ; курсор достиг верхнего края экрана
                            LD HL, #0000                            ; фиксируем значение
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
                            JR NC, .SetMouseLocationY               ; проверка на переполнение
                            ; курсор достих нижнего края экрана
                            LD H, B
                            LD L, C

.SetMouseLocationY          LD (PositionY), HL

                            RET
LastValueFromMousePortX:    DB #00
LastValueFromMousePortY:    DB #00

                            endif ; ~_INPUT_MOUSE_UPDATE_STATES_
