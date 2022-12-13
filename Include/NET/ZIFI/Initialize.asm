
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
                LD DE, (ZIFI.VER << 8) | ZIFI.API_MODE_1
                OUT (C), E                                                      ; set API mode 1
                OUT (C), D                                                      ; get version

                GET_RESULT
                CP #FF
                JP Z, .Error                                                    ; ZiFi is not found (no API available)

                ; clear input/output FIFO
                CALL ClearInput
                CALL ClearOutput

                ; ; command "disable echo"
                ; LD HL, AT.DISABLE_ECHO
                ; CALL SetCommand
                ; JR C, .Error

                ; command "get version"
                LD HL, AT.VERSION_INFO
                CALL SetCommand
                JR C, .Error

                ; command "Wi-Fi default mode"
                LD HL, AT.SET_DEFAULT
                CALL SetCommand
                JR C, .Error

                ; command "auto-connects to the AP"
                LD HL, AT.AUTO_CONNECT_AP
                CALL SetCommand
                JR C, .Error

                ; command "disable multiple connections"
                LD HL, AT.MULT_CONNECT
                CALL SetCommand
                JR C, .Error

                ; ; command "list access points"
                ; LD HL, AT.ACCESS_POINS
                ; CALL SetCommand
                ; JR C, .Error

                ; command "connect to access point"
                LD HL, AT.CONNECT_AP
                CALL SetCommand
                JR C, .Error

                ; successful initialization
                OR A
                RET

.Error          ; unsuccessful initialization
                SCF
                RET

SetCommand:     ; send command
                LD DE, .AnswerBuffer
                CALL SendATCommand
                
.L1             ; check response
                LD HL, .AnswerBuffer
                LD DE, AT.RESPONSE.OK
                CALL String.Contains
                EX AF, AF'

                ; filter and add response message
                LD HL, .Predicate
                LD DE, .AnswerBuffer
                EXX
                LD HL, .AnswerBuffer
                EXX
                CALL String.Filter

                EX AF, AF'
                RET NC

                OR A
.L2             EQU $+1
                LD A, #80
                DEC A
                LD (.L2), A
                RET Z

                HALT
                LD HL, .AnswerBuffer
                SYNC_INPUT_DATA ZIFI.FIFO_SIZE, #00
                JR .L1

.Predicate      CP "\r"
                JR Z, .Remove
                CP "\n"
                JR Z, .Set

                OR A
                RET

.Set            XOR A
                LD (DE), A
                PUSH DE
                EXX
                LD A, Console.Verbose
                CALL Console.Add
                POP HL
                INC HL
                EXX

                OR A
                RET

.Remove         SCF
                RET

.AnswerBuffer   DS ZIFI.FIFO_SIZE, 0

                endif ; ~_NET_WIFI_INITIALIZE_
