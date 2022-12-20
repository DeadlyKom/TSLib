
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint

                include "Flags.inc"
                include "HardwareFlags.inc"

                module Core
Start:
                include "EntryPoint.asm"
                include "Initialize.asm"
                include "MainLoop.asm"
                include "Input.asm"
                include "Menu/Include.inc"
End:
Size:           EQU End - Start

                endmodule

                display "Example:  \t\t", /A, Core.Start, " = busy [ ", /D, Core.Size, " bytes ]"

                savebin "Examples/5.Net/Files/Core.bin", Core.Start, Core.Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
