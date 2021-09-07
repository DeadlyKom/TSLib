    
            ifndef _INPUT_KEYBOARD_INCLUDE_
            define _INPUT_KEYBOARD_INCLUDE_

            module Keyboard

            ifdef KEYBOARD_PS2
            include "PS2/Include.inc"
            else
            include "Spectrum/Include.inc"
            endif
            
            endmodule

            endif ; ~_INPUT_KEYBOARD_INCLUDE_
