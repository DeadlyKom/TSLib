
                ifndef _WIFI_AT_COMMAND_
                define _WIFI_AT_COMMAND_

                module AT

; STARTUP         BYTE "AT\r\n\0"
VERSION_INFO    BYTE "AT+GMR\r\n\0"
DISABLE_ECHO    BYTE "ATE0\r\n\0"
ENABLE_ECHO     BYTE "ATE1\r\n\0"
SET_DEFAULT     BYTE "AT+CWMODE_DEF="
.MODE           BYTE "1"                                                        ; 1 - station mode
                                                                                ; 2 - softAP mode
                                                                                ; 3 - softAP | station mode
                BYTE "\r\n\0"
AUTO_CONNECT_AP BYTE "AT+CWAUTOCONN="
.SWITCH         BYTE "0"                                                        ; 0 - does NOT auto-connect to AP on power-up
                                                                                ; 1 - connects to AP automatically on power-up
                BYTE "\r\n\0"
MULT_CONNECT    BYTE "AT+CIPMUX="
.SWITCH         BYTE "0"                                                        ; 0 - single connection
                                                                                ; 1 - multiple connections
                BYTE "\r\n\0"
CONNECT_AP:     BYTE "AT+CWJAP_CUR="
                ; BYTE "\"TP-Link_ACD9\","
                ; BYTE "\"89152996210\","
                BYTE "\"POCO X4 Pro 5G\","
                BYTE "\"f493606304f\""
                BYTE "\r\n\0"
ACCESS_POINS    BYTE "AT+CWLAP\r\n\0"


RESPONSE:
.OK             BYTE "\r\nOK\r\n\0"
.ERROR          BYTE "\r\nERROR\r\n\0"

                endmodule

                endif ; ~_WIFI_AT_COMMAND_
