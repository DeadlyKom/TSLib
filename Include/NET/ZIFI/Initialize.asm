
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

Setting:        ; command "disable echo"
;                 LD A, DISABLE
;                 CALL Cmd.EnableEcho
;                 CALL WaitResponce

                ; ; command "get version"
                CALL Cmd.CheckVersion
                CALL WaitResponce

                ; command "Wi-Fi default mode"
                LD A, WIFI_MODE_ST | OLD_SDK
                CALL Cmd.SetMode
                CALL WaitResponce

                ; command "auto-connects to the AP"
                LD A, DISABLE
                CALL Cmd.SetAutoConnect
                CALL WaitResponce

                ; command "disable multiple connections"
                LD A, SINGLE
                CALL Cmd.SetMultConnect
                CALL WaitResponce

                ; command "list access points"
                CALL Cmd.GetListAPs
                CALL WaitResponce

                ; ; command "connect to access point"
                ; LD A, OLD_SDK
                ; LD HL, .SSID
                ; LD DE, .PASSWORD
                ; CALL Cmd.ConnectToAP
                ; CALL WaitResponce

                RET

                endif ; ~_NET_WIFI_INITIALIZE_
