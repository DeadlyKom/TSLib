
                ifndef _EXAMPLE_CORE_INCLUDE_
                define _EXAMPLE_CORE_INCLUDE_

                ORG EntryPoint
PROTOTYPE_Start:
                
                include "Math/Include.inc"
                include "Utils/Include.inc"
                
                include "Core/Include.inc"
                include "Game/Include.inc"
PROTOTYPE_End:
PROTOTYPE_Size: EQU PROTOTYPE_End - PROTOTYPE_Start

                display "Prototype:  \t\t", /A, PROTOTYPE_Start, " = busy [ ", /D, PROTOTYPE_Size, " bytes ]"
                savebin "Examples/Prototype/Files/Core.bin", PROTOTYPE_Start, PROTOTYPE_Size

                endif ; ~_EXAMPLE_CORE_INCLUDE_
