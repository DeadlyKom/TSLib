
                ifndef _NET_INCLUDE_
                define _NET_INCLUDE_

                include "ZiFi/Command/ATConfig.inc"

                module Net

                ifdef _UART
                include "UART/Include.inc"
                endif

                ifdef _ZIFI
                include "ZiFi/Include.inc"
                endif

                endmodule

                endif ; ~_NET_INCLUDE_

