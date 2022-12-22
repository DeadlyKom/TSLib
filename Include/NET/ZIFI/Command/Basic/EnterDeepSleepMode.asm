
                ifndef _NET_COMMAND_ENTER_DEEP_SLEEP_MODE_
                define _NET_COMMAND_ENTER_DEEP_SLEEP_MODE_
; -----------------------------------------
; send command enter deep-sleep mode 
; In:
;   A - deep-sleep in milliseconds (ms)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DeepSleep:      ; set value to string
                LD HL, .Buffer
                CALL String.ByteToString
                LD (HL), "\r"
                INC HL
                LD (HL), "\n"

                ; send command
                LD HL, .Command
                ADD A, .Size + 2
                LD E, A
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+GSLP="
.Size           EQU $-.Command
.Buffer         DS 3/*...*/ + 2/*\r\n*/, 0

                endif ; ~_NET_COMMAND_ENTER_DEEP_SLEEP_MODE_

