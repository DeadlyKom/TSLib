
                ifndef _NET_COMMAND_RESTARTS_MODULE_
                define _NET_COMMAND_RESTARTS_MODULE_
; -----------------------------------------
; send command restart a module
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RestartModule:  ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+RST\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_RESTARTS_MODULE_

