
                        ifndef _INPUT_KEYBOARD_PS2_UPDATE_STATES_
                        define _INPUT_KEYBOARD_PS2_UPDATE_STATES_

StateUpdates:           LD HL, KeyStates
                        LD D, #00

.LastExtendedOffset     EQU $+1
                        LD E, #00
                        
                        ; getting the current scan code
.ScanCode               LD A, #F0
                        CALL NVRAM.GetData
                        ; no scan code
                        RET Z
                        ; check extension scan code 
                        CP #E0
                        JR Z, .IsExtendedKeys
                        ; check key release scan code
                        CP #F0
                        JR Z, .ResetStateKey
                        ; check for overflows
                        CP #FF
                        JR Z, .OverflowedStackSCodes

.CalculateKeyState      ADD A, E
                        LD E, A
                        AND #07
                        RLCA
                        RLCA
                        RLCA

.StateOperationMask     EQU $+1
                        OR #00
                        LD (.SetKeyState), A

                        LD A, E
                        AND %11111000
                        RRCA
                        RRCA
                        RRCA
                        LD E, A
                        ADD HL, DE
.SetKeyState            EQU $+1
                        DB #CB, #00                         ; RES/SET N,(HL)
                        SBC HL, DE

                        ; set default values
                        XOR A
                        LD E, A
                        LD (.LastExtendedOffset), A
                        LD A, %11000110                     ; SET 0, (HL)
                        LD (.StateOperationMask), A
                        JR .ScanCode

.IsExtendedKeys         LD A, #80
                        LD E, A
                        LD (.LastExtendedOffset), A
                        JR .ScanCode

.ResetStateKey          LD A, %10000110                     ; RES 0, (HL)
                        LD (.StateOperationMask), A
                        JR .ScanCode

.OverflowedStackSCodes  CALL Release

                        ; set default values
                        JP SetDefault

                        endif ; ~_INPUT_KEYBOARD_PS2_UPDATE_STATES_
