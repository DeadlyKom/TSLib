    
                ifndef _INPUT_MOUSE_INCLUDE_
                define _INPUT_MOUSE_INCLUDE_

LEFT_EDGE       EQU 0x01
RIGHT_EDGE      EQU 0x02
TOP_EDGE        EQU 0x04
BOTTOM_EDGE     EQU 0x08

                module Mouse
SVK_LBUTTON     EQU %00000001
SVK_RBUTTON     EQU %00000010
SVK_MBUTTON     EQU %00000100

                include "Initialize.asm"
                include "KeyState.asm"
                include "MouseCursorPosition.asm"
                include "UpdateMouseState.asm"
Position:       EQU $
PositionX:      DW #0000
PositionY:      DW #0000

                endmodule

                endif ; ~_INPUT_MOUSE_INCLUDE_
