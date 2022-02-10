
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint
Start:
                include "Core/Include.inc"
                include "Game/Include.inc"
End:
Size:           EQU End - Start

                display "Example:  \t\t", /A, Start, " = busy [ ", /D, Size, " bytes ]"
                savebin "Examples/Prototype/Files/Core.bin", Start, Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
