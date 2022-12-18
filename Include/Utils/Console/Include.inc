
                ifndef _DEBUG_CONSOLE_
                define _DEBUG_CONSOLE_

                module Console

Verbose         EQU 0x00
Warning         EQU 0x01
Error           EQU 0x02

                define BUFFER_SIZE 2048
                define HEIGHT_FONT 14

                include "Initialize.asm"
                include "Draw.asm"
                include "Add.asm"

Buffer:         DS BUFFER_SIZE, 0
.Offset         DW #0000
.Free           DW #0000
.Counter        DB #00

                endmodule

                endif ; ~_DEBUG_CONSOLE_
