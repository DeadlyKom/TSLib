
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint
Start:
                module Core

                include "EntryPoint.asm"
                include "Initialize.asm"
                include "MainLoop.asm"

                endmodule

                define PRNG_SEQUENCE

                include "../../../Include/Math/PerlinNoise/Include.inc"
End:
Size:           EQU End - Start

                display "Example:  \t\t", /A, Start, " = busy [ ", /D, Size, " bytes ]"

                savebin "Examples/4.Noise/Files/Core.bin", Start, Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
