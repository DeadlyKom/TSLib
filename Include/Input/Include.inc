
                ifndef _INPUT_INCLUDE_
                define _INPUT_INCLUDE_

INSTRUCTION_BIT EQU #40 + 0x07

                module Input

                include "Keyboard/Include.inc"
                include "Kempston/Joystick/Include.inc"
                include "Kempston/Mouse/Include.inc"
                
                endmodule

                endif ; ~_INPUT_INCLUDE_
