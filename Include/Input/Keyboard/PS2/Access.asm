
            ifndef _INPUT_KEYBOARD_PS2_ACCESS_
            define _INPUT_KEYBOARD_PS2_ACCESS_

Access:     LD DE, #F002 
            JP NVRAM.SetData

            endif ; ~_INPUT_KEYBOARD_PS2_ACCESS_
