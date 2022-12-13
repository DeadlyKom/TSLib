
                ifndef _NET_COMMAND_STARTUP_
                define _NET_COMMAND_STARTUP_

Startup:        WAIT_EMPTY_FIFO_OUTPUT

                RET

.Command        BYTE "AT\r\n\0"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_STARTUP_

