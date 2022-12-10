                ifndef _FIXED_2_14_INCLUDE_
                define _FIXED_2_14_INCLUDE_

                ; Fixed point 2:14
                ;   .                  hight byte                   .   .                   low byte                    .
                ;   +-----+-----+-----+-----+-----+-----+-----+-----+   +-----+-----+-----+-----+-----+-----+-----+-----+
                ;   | 15  | 14  | 13  | 12  | 11  | 10  |  9  |  8  |   |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
                ;   +-----+-----+-----+-----+-----+-----+-----+-----+   +-----+-----+-----+-----+-----+-----+-----+-----+
                ;   |  S  |  I  | F0  | F1  | F2  | F3  | F4  | F5  |   | F6  | F7  | F8  | F9  | F10 | F11 | F12 | F13 |
                ;   +-----+-----+-----+-----+-----+-----+-----+-----+   +-----+-----+-----+-----+-----+-----+-----+-----+
                ;
                ;   S - sign number
                ;   I - integer part
                ;   F - fractional part

                module Fixed_214

                include "ADD.asm"
                include "SUB.asm"
                include "MUL.asm"
                include "SL.asm"
                include "Overflow.asm"

                endmodule

                endif ; ~_FIXED_2_14_INCLUDE_
