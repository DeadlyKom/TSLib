
            ifndef _INPUT_KEYBOARD_PS2_INITIALIZE_
            define _INPUT_KEYBOARD_PS2_INITIALIZE_

Initialize: CALL NVRAM.OpenAccess
            CALL SetDefault
            CALL Access
            JP Reset

            endif ; ~_INPUT_KEYBOARD_PS2_INITIALIZE_
