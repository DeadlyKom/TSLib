
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint

                include "Tileset.inc"

                module Core
Start:
                include "EntryPoint.asm"
                include "Initialize.asm"
                include "MainLoop.asm"
End:
Size:           EQU End - Start

                endmodule

                display "Example:  \t\t", /A, Core.Start, " = busy [ ", /D, Core.Size, " bytes ]"

                savebin "Examples/Game/Files/Core.bin", Core.Start, Core.Size


                ORG DL_Point

                module Tilemap
Start:
                include "Tilemap_DL.asm"
End:
Size:           EQU End - Start

                endmodule

                display "Tilemap:  \t\t", /A, Tilemap.Start, " = busy [ ", /D, Tilemap.Size, " bytes ]"

                savebin "Examples/Game/Files/DL.bin", Tilemap.Start, Tilemap.Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
