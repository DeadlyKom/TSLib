                        
                ifndef _INPUT_KEYBOARD_PS2_GET_KEY_STATE_
                define _INPUT_KEYBOARD_PS2_GET_KEY_STATE_
; -----------------------------------------
; check the state of the keyboard virtual key
; In :
;   A  - virtual code
; Out :
;   if the Z flag is set, if the button is pressed
; Corrupt :
;   AF
; Note:
; -----------------------------------------
KeyState:       PUSH HL
                PUSH BC

                LD C, A
                AND #07
                RLCA
                RLCA
                RLCA
                OR %01000110                        ; BIT N, (HL)
                LD (.TestKeyState), A

                LD A, C
                AND %11111000
                RRCA
                RRCA
                RRCA
                LD C, A
                LD B, #00

                LD HL, KeyStates
                ADD HL, BC

.TestKeyState   EQU $+1
                DB #CB, #00                         ; BIT N, (HL)

                POP BC
                POP HL
                RET

                endif ; ~_INPUT_KEYBOARD_PS2_GET_KEY_STATE_
