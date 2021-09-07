
            ifndef _INPUT_KEYBOARD_CHECK_KEY_STATE_
            define _INPUT_KEYBOARD_CHECK_KEY_STATE_
; -----------------------------------------
; check the state of the keyboard virtual key
; In :
;   A  - virtual code
; Out :
;   if the Z flag is set, if the button is pressed
; Corrupt :
;   AF
; -----------------------------------------
KeyState:   PUSH HL
            
            LD HL, VirtualKeysTable
            ADD A, A
            ADD A, L
            LD L, A
            JR NC, $+3
            INC H

            LD A, (HL)
            IN A, (#FE)
            CPL
            INC HL
            AND (HL)

            POP HL
            RET

            endif ; ~_INPUT_KEYBOARD_CHECK_KEY_STATE_
