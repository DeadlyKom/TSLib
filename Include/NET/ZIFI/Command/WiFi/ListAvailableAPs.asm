
                ifndef _NET_COMMAND_LIST_AVAILABLE_APS_
                define _NET_COMMAND_LIST_AVAILABLE_APS_
; -----------------------------------------
; send command list available APs
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GetListAPs:     ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+CWLAP\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_LIST_AVAILABLE_APS_

