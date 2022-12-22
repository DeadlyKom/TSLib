
                ifndef _EXAMPLE_TSLIB_INCLUDE_
                define _EXAMPLE_TSLIB_INCLUDE_
                
                ORG TSLib

                define _ZIFI                                                    ; turn on WIFI files
                define _MEM_DUMP                                                ; turn on memory dump

TSLIB_Start:
                include "../../Include/TSLib.inc"

                ; additional ulils
                include "Include/Utils/String/Include.inc"
                include "Include/Utils/Debug/Include.inc"
                include "Include/Utils/Console/Include.inc"
TSLIB_End:
TSLIB_Size:     EQU TSLIB_End - TSLIB_Start

                display "TS-Conf lib: \t\t", /A, TSLIB_Start, " = busy [ ", /D, TSLIB_Size, " bytes ]"

                savebin "Examples/5.Net/Files/TSLib.bin", TSLIB_Start, TSLIB_Size

                endif ; ~_EXAMPLE_TSLIB_INCLUDE_
