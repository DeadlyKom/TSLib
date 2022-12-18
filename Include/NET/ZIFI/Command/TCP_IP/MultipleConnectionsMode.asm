
                ifndef _NET_COMMAND_MULT_CONNECT_MODE_
                define _NET_COMMAND_MULT_CONNECT_MODE_
; -----------------------------------------
; send command set multiple connections mode
; In:
;   A - flags switch (SINGLE/MULTIPLE)
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
SetMultConnect: ; set mode
                ADD A, '0'
                LD (.Mode), A

                ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+CIPMUX"
                BYTE "="
.Mode           DB #00
                BYTE "\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_MULT_CONNECT_MODE_

