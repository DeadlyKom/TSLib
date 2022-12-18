
                ifndef _NET_COMMAND_CHECK_VERSION_INFO_
                define _NET_COMMAND_CHECK_VERSION_INFO_
; -----------------------------------------
; send command check version information
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
CheckVersion:   ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+GMR\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_CHECK_VERSION_INFO_

