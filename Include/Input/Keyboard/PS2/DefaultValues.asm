
                ifndef _KEYBOARD_PS2_DEFAULT_
                define _KEYBOARD_PS2_DEFAULT_

SetDefault:     XOR A
                LD (StateUpdates.LastExtendedOffset), A
                LD A, %11000110                             ; SET 0, (HL)
                LD (StateUpdates.StateOperationMask), A
                RET

                endif ; ~_KEYBOARD_PS2_DEFAULT_
