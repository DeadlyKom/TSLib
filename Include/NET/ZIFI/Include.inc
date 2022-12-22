
                ifndef _NET_ZIFI_INCLUDE_
                define _NET_ZIFI_INCLUDE_

                module ZiFi

                include "ZiFiConfig.inc"
                include "Macro.inc"
                include "Command/Include.inc"
                include "Initialize.asm"
                include "FIFO.asm"
                include "Response.asm"

Handler:        DW #0000

                endmodule

                endif ; ~_NET_ZIFI_INCLUDE_

