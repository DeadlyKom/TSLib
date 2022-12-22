
                ifndef _DEBUG_INCLUDE_
                define _DEBUG_INCLUDE_

                module Debug

TEXT_VGA:
.PAGE           EQU #FF
.ADR            EQU #C000
.RAM_G          EQU 0x20000

SCREEN:
.WIDTH          EQU 128
.HEIGHT         EQU 96/2
.SIZE           EQU SCREEN.WIDTH * SCREEN.HEIGHT * 2

                include "Color.inc"
                include "Draw/Include.inc"
                include "Utils/Include.inc"

                ifdef _MEM_DUMP
                include "MemDump/Include.inc"
                endif

                endmodule

                endif ; ~_DEBUG_INCLUDE_
