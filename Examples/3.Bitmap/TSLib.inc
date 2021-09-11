
                ifndef _EXAMPLE_TSLIB_INCLUDE_
                define _EXAMPLE_TSLIB_INCLUDE_
                
                ORG TSLib

TSLIB_Start:
                include "../../Include/TSLib.inc"
TSLIB_End:
TSLIB_Size:     EQU TSLIB_End - TSLIB_Start

                display "TS-Conf lib: \t\t", /A, TSLIB_Start, " = busy [ ", /D, TSLIB_Size, " bytes ]"

                savebin "Examples/3.Bitmap/Files/TSLib.bin", TSLIB_Start, TSLIB_Size

                endif ; ~_EXAMPLE_TSLIB_INCLUDE_
