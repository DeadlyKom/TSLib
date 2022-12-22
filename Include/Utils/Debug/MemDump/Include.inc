
                ifndef _DEBUG_MEMORY_DUMP_INCLUDE_
                define _DEBUG_MEMORY_DUMP_INCLUDE_

                module MemDump

NUM_ROWS        EQU #09

                include "Draw.asm"

Page:           DB #00
Address:        DW #0000
Location:       DW #0000

                endmodule

                endif ; ~_DEBUG_MEMORY_DUMP_INCLUDE_
