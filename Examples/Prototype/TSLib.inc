
                ifndef _EXAMPLE_TSLIB_INCLUDE_
                define _EXAMPLE_TSLIB_INCLUDE_
                
                ORG TSLib
TSLIB_Start:
                include "../../Include/TSLib.inc"
                include "../../Include/Math/Fixed/Include.inc"
                include "../../Include/Math/Mul/uint16x16_32.asm"
TSLIB_End:
TSLIB_Size:     EQU TSLIB_End - TSLIB_Start

                display "TS-Conf lib: \t\t", /A, TSLIB_Start, " = busy [ ", /D, TSLIB_Size, " bytes ]"

                savebin "Examples/Prototype/Files/TSLib.bin", TSLIB_Start, TSLIB_Size

                endif ; ~_EXAMPLE_TSLIB_INCLUDE_
