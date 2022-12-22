
                ifndef _NET_COMMAND_STARTUP_
                define _NET_COMMAND_STARTUP_
; -----------------------------------------
; send command test AT startup
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Startup:        ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_STARTUP_
