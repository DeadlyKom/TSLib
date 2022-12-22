
                ifndef _NET_WIFI_INITIALIZE_
                define _NET_WIFI_INITIALIZE_
; -----------------------------------------
; initialize WiFi
; In:
; Out:
; Corrupt:
;   if the C flag is reset, the initialization was successful
; Note:
; -----------------------------------------
Initialize:     ; detect ZiFi
                REG_CMD
                LD DE, (VER << 8) | API_MODE_1
                OUT (C), E                                                      ; set API mode 1
                OUT (C), D                                                      ; get version

                GET_RESULT
                CP #FF
                JP Z, .Error                                                    ; ZiFi is not found (no API available)

                ; clear input/output FIFO
                CALL ClearInput
                CALL ClearOutput

                ; successful initialization
                OR A
                RET

.Error          ; unsuccessful initialization
                SCF
                RET

                endif ; ~_NET_WIFI_INITIALIZE_
