
            ifndef _INPUT_JOYSTICK_KEY_STATE_
            define _INPUT_JOYSTICK_KEY_STATE_
; -----------------------------------------
; check the state of the Kemston virtual key
; In :
;   A  - virtual code
; Out :
;   if the Z flag is set, if the button is pressed
; Corrupt :
;   AF
; -----------------------------------------
KeyState:   RLA
            RLA
            RLA
            AND %00111000
            OR INSTRUCTION_BIT
            LD (.BIT), A
            IN A, (#1F)
            ; CPL
.BIT        EQU $+1                 ; BIT N, A
            DB #CB, #00
            RET

            endif ; ~_INPUT_JOYSTICK_KEY_STATE_
