
            ifndef _TSLIB_INCLUDE_
            define _TSLIB_INCLUDE_

            include "TSConf.inc"
            include "Memory/Include.inc"
            include "Cache/Macro.inc"
            include "DMA/Macro.inc"
            include "FT/Include.inc"
            include "INT/Macro.inc"
            include "Input/Include.inc"

            
            ; define _UART - included UART files
            ; define _WIFI - included WIFI files
            include "NET/Include.inc"
            
            include "NVRAM/Include.inc"
            include "Video/Macro.inc"
            include "System/Macro.inc"

            include "ZX/Color.inc"

            endif ; ~_TSLIB_INCLUDE_
