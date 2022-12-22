
            ifndef _INPUT_KEYBOARD_PS2_INCLUDE_
            define _INPUT_KEYBOARD_PS2_INCLUDE_

            include "VirtualKeys.inc"

            module PS2

            include "Access.asm"
            include "DefaultValues.asm"
            include "Initialize.asm"
            include "KeyState.asm"
            include "Reset.asm"
            include "Release.asm"
            include "UpdateStates.asm"
KeyStates   DS 32, 0
AnyKeys     DB #00
            endmodule

            endif ; ~_INPUT_KEYBOARD_PS2_INCLUDE_
