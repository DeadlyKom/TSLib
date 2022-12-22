
                ifndef _MENU_OPTIONS_CONNECT_LIST_AP_
                define _MENU_OPTIONS_CONNECT_LIST_AP_

                struct FAccessPoint
.Enc            DB #00
.RRSI           DB #00
.SSID           DS 30, 0
                ends

; -----------------------------------------
; In:
;   HL - pointer to string
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RefreshAP:      ; get length string
                EX DE, HL
                PUSH HL
                CALL String.Length
                POP HL

                ; initialize
                EXX
                LD DE, .Buffer
                EXX

                ; find ':'
                LD A, ":"
                CPIR
                RET NZ                                                          ; not found ":"

                ; -----------------------------------------
                ; encryption method
                ; -----------------------------------------
                INC HL
                LD A, (HL)
                EXX
                LD (DE), A                                                      ; FAccessPoint.Enc
                INC DE
                INC DE
                EXX
                ; -----------------------------------------

                ; find ","
                LD A, ","
                CPIR
                RET NZ                                                          ; not found ","

                ; find "\""
                LD A, "\""
                CPIR
                RET NZ                                                          ; not found "\""

                ; find "\""
                PUSH HL
                PUSH BC
                CPIR
                DEC HL
                POP BC
                POP DE
                RET NZ                                                          ; not found "\""

                ; -----------------------------------------
                ; SSID
                ; -----------------------------------------
                OR A
                SBC HL, DE

                ; check SSID length
                LD A, L
                CP 29
                RET NC                                                          ; SSID length more 29 bytes

                PUSH BC
                LD B, H
                LD C, L
                EX DE, HL
                EXX
                PUSH DE
                EXX
                POP DE
                LDIR
                POP BC
                XOR A
                LD (DE), A                                                      ; null-terminate
                ; -----------------------------------------

                ; find ","
                LD A, ","
                CPIR
                RET NZ                                                          ; not found ","

                ; -----------------------------------------
                ; RSSI (signal strength)
                ; -----------------------------------------
                CALL String.ToByte
                LD DE, .Buffer + FAccessPoint.RRSI
                LD (DE), A

                ; -----------------------------------------
                ; search SSID
                ; -----------------------------------------

                ; initialize
                LD HL, AccessPoints

                LD A, (AccessPoints.Num)
                OR A
                JR Z, .AddAP

.SearchLoop     EX AF, AF'
                PUSH HL
                LD DE, .Buffer + FAccessPoint.SSID
                INC HL
                INC HL
                CALL String.Compare
                POP HL
                JR NC, .UpdateAP

                ; next access point
                LD DE, FAccessPoint
                ADD HL, DE
                EX AF, AF'
                DEC A
                JR NZ, .SearchLoop

                ; check buffer size
                LD A, (AccessPoints.Num)
                CP NUMBER_AP
                RET NC                                                          ; buffer is full

.AddAP          INC A
                LD (AccessPoints.Num), A

.UpdateAP       LD DE, .Buffer
                LD BC, FAccessPoint
                EX DE, HL
                LDIR
                RET

.Buffer         FAccessPoint

                endif ; ~_MENU_OPTIONS_CONNECT_LIST_AP_
