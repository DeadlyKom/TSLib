
                ifndef _NET_COMMAND_AT_COMMANDS_ECHOING_
                define _NET_COMMAND_AT_COMMANDS_ECHOING_
; -----------------------------------------
; send command set configure AT commands echoing
; In:
;   A - flags switch (ENABLE/DISABLE)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EnableEcho:     ;set switch
                ADD A, '0'
                LD (.Switch), A

                ; send command
                LD HL, .Command
                LD E, .Size
                JP Net.ZiFi.SendATCommand

.Command        BYTE "ATE"
.Switch         DB #00
                BYTE "\r\n"
.Size           EQU $-.Command

                endif ; ~_NET_COMMAND_AT_COMMANDS_ECHOING_

