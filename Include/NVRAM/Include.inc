
                    ifndef _NVRAM_INCLUDE_
                    define _NVRAM_INCLUDE_

PORT_RESMGR         EQU #EFF7
PORT_NVCELLADR      EQU #DFF7
PORT_NVCELLRW       EQU #BFF7

FLAG_NONE_NVRAM     EQU 0x00
FLAG_ACCESS_NVRAM   EQU 0x80


                    module NVRAM

                    include "CloseAccess.asm"
                    include "GetData.asm"
                    include "OpenAccess.asm"
                    include "SetData.asm"

                    endmodule

                    endif ; ~_NVRAM_INCLUDE_
