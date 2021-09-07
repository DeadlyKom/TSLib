                        
                ifndef _INPUT_MOUSE_KEY_STATE_
                define _INPUT_MOUSE_KEY_STATE_
; -----------------------------------------
; check the state of the mouse button
; In :
;   A - virtual code
; Out :
;   if the Z flag is reset, the mouse button is pressed
; Corrupt :
;   BC, AF
; -----------------------------------------
KeyState:       LD BC, #FADF
                IN C, (C)
                AND C
                RET

; -----------------------------------------
; get wheel counter value
; In :
; Out :
;   A - wheel counter
; Corrupt :
;   BC, AF
; -----------------------------------------
WheelCount:     LD BC, #FADF
                IN A, (C)
                AND #F0
                RRCA
                RRCA
                RRCA
                RRCA
                RET

                endif ; ~_INPUT_MOUSE_KEY_STATE_
