
                ifndef _NET_COMMAND_AUTO_CONNECT_TO_AP_
                define _NET_COMMAND_AUTO_CONNECT_TO_AP_
; -----------------------------------------
; send command set automatically connect to an AP when powered on
; In:
;   A - flags switch (ENABLE/DISABLE)
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
SetAutoConnect: ; set mode
                ADD A, '0'
                LD (.Mode), A
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+CWAUTOCONN"
                BYTE "="
.Mode           DB #00
                BYTE "\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_AUTO_CONNECT_TO_AP_

