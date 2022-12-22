
                ifndef _NET_COMMAND_CONNECT_TO_AN_AP_
                define _NET_COMMAND_CONNECT_TO_AN_AP_

BUFFER_SIZE     EQU 128
; -----------------------------------------
; send command connect to an AP
; In:
;   A  - flags (SAVE_FLASH/NOT_SAVE_FLASH on/off)
;   HL - pointer to string SSID
;   DE - pointer to string PASSWORD
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
ConnectToAP:    ; save pointers SSID and PASSWORD
                PUSH DE
                PUSH HL

                ; initialize
                LD HL, .Buffer

                ; check SDK version
                SRL A
                JR C, .WithoutPostfix

.WithPostfix    LD (HL), "_"
                INC HL
                EX DE, HL

                ; copy postfix
                SRL A
                LD HL, POSTFIX.CUR
                JR NC, $+5
                LD HL, POSTFIX.DEF
                rept 3
                LDI
                endr
                EX DE, HL
                LD BC, BUFFER_SIZE-6-6                                          ; 6 bytes ('\"' * 3 + ',' * 1 + and newline "\r\n")
                JR .NotShift

.WithoutPostfix SRL A
                LD BC, BUFFER_SIZE-2-6                                          ; 6 bytes ('\"' * 3 + ',' * 1 + and newline "\r\n")
.NotShift       LD (HL), "="
                INC HL
                LD (HL), "\""
                INC HL
                EX DE, HL
 
                ; copy SSID
                POP HL
                CALL String.Copy

                ; add middle string
                EX DE, HL
                LD (HL), "\""
                INC HL
                LD (HL), ','
                INC HL
                LD (HL), "\""
                INC HL
                EX DE, HL

                ; copy PASSWORD
                POP HL
                CALL String.Copy

                ; add end string
                EX DE, HL
                LD (HL), "\""
                INC HL
                LD (HL), "\r"
                INC HL
                LD (HL), "\n"
                INC HL

                ; calculate command string length
                LD DE, .Command
                SBC HL, DE
                EX DE, HL

                ; send command
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+CWJAP"
.Size           EQU $-.Command
.Buffer         DS BUFFER_SIZE, 0

                endif ; ~_NET_COMMAND_CONNECT_TO_AN_AP_

