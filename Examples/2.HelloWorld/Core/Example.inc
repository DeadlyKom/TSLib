
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint

                module Core
Start:
                include "EntryPoint.asm"
                include "Initialize.asm"
                include "MainLoop.asm"
                include "../../../Include/Math/Rand8.asm"
                include "../../../Include/Math/Rand16.asm"
End:
Size:           EQU End - Start

                endmodule

                display "Example:  \t\t", /A, Core.Start, " = busy [ ", /D, Core.Size, " bytes ]"

                savebin "Examples/2.HelloWorld/Files/Core.bin", Core.Start, Core.Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
