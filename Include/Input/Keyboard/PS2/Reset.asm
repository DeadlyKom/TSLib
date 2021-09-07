
            ifndef _INPUT_KEYBOARD_PS2_RESET_
            define _INPUT_KEYBOARD_PS2_RESET_

Reset:      LD DE, #0C01
            JP NVRAM.SetData

            endif ; ~_INPUT_KEYBOARD_PS2_RESET_
