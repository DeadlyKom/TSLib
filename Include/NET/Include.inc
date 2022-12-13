
                ifndef _NET_INCLUDE_
                define _NET_INCLUDE_

                module Net

                ifdef _UART
                include "UART/Include.inc"
                endif

                ifdef _ZIFI
                include "ZIFI/Include.inc"
                endif

                endmodule

                endif ; ~_NET_INCLUDE_

