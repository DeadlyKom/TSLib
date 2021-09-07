
                ifndef _INPUT_MOUSE_INITIALIZE_
                define _INPUT_MOUSE_INITIALIZE_
; -----------------------------------------
; kempston mouse initialization
; In :
; Out :
;   if the C flag is reset, the initialization was successful
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
Initialize:     ; set default value cursor position
                LD HL, (ResolutionWidthPtr)
                RR H
                RR L
                LD (PositionX), HL

                LD HL, (ResolutionHeightPtr)
                RR H
                RR L
                LD (PositionY), HL

                ; detected kempston mouse
                CALL GetMouseXY
                INC E
                JR Z, .Error
                INC D
                JR Z, .Error

                CALL GetMouseXY
                LD HL, LastValueFromMousePortX
                LD (HL), E
                INC HL
                LD (HL), D

                OR A
                RET

.Error          SCF
                RET
                    
                endif ; ~_INPUT_MOUSE_INITIALIZE_
