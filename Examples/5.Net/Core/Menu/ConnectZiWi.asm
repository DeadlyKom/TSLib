
                ifndef _MENU_OPTIONS_CONNECT_ZI_FI_
                define _MENU_OPTIONS_CONNECT_ZI_FI_

ZIFI_UNKNOW     EQU 0xFF
ZIFI_ATE        EQU 0x00
ZIFI_GMR        EQU 0x01
ZIFI_CWMODE     EQU 0x02
ZIFI_CWAUTOCONN EQU 0x03
ZIFI_CIPMUX     EQU 0x04
ZIFI_CWLAP      EQU 0x05
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.Init:      LD HL, ZiFi.Callback
                LD (Net.ZiFi.Handler), HL

                ; wait, finish old command
                LD A, (ZiFi.CMD)
                INC A
                CALL NZ, Net.ZiFi.WaitResponce

; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.Reset:     ; command "disable echo"
                LD A, ZIFI_ATE
                LD (ZiFi.CMD), A
                LD A, DISABLE
                JP Net.ZiFi.Cmd.EnableEcho
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.Sutdown:   LD HL, #0000
                LD (Net.ZiFi.Handler), HL

                ; stop any spinner
                FT_Stop

                RET
; -----------------------------------------
; In:
;   DE - pointer to string
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ZiFi.Callback:  LD A, (ZiFi.CMD)
                LD HL, .Jump
                ADD A, A
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                JP (HL)

.Jump           DW ZiFi.ATE
                DW ZiFi.GMR
                DW ZiWi.CWMODE
                DW ZiWi.CWAUTOCONN
                DW ZiWi.CIPMUX
                DW ZiWi.CWLAP

ZiFi.ATE        ; -----------------------------------------
                CHECK_RESPONSE
                RET Z                                                           ; wait response
                
                ; command "get version"
                LD HL, SDKVer
                LD (HL), #00
                LD (ZiFi.GMR.Buffer), HL
                LD HL, SDKVer.NumLines
                LD (HL), #00
                LD A, ZIFI_GMR
                LD (ZiFi.CMD), A
                JP Net.ZiFi.Cmd.CheckVersion

ZiFi.GMR        ; -----------------------------------------
                CHECK_RESPONSE
                JR NZ, .Response
.Buffer         EQU $+1
                LD HL, #0000
                EX DE, HL
                CALL String.Copy
                XOR A
                LD (DE), A
                INC DE
                LD (ZiFi.GMR.Buffer), DE
                LD HL, SDKVer.NumLines
                INC (HL)
                RET

.Response       ; command "Wi-Fi default mode"
                LD A, ZIFI_CWMODE
                LD (ZiFi.CMD), A
                LD A, WIFI_MODE_ST | OLD_SDK
                JP Net.ZiFi.Cmd.SetMode

ZiWi.CWMODE     ; -----------------------------------------
                CHECK_RESPONSE
                RET Z                                                           ; wait response

                ;  command "auto-connects to the AP"
                LD A, ZIFI_CWAUTOCONN
                LD (ZiFi.CMD), A
                LD A, DISABLE
                JP Net.ZiFi.Cmd.CheckVersion

ZiWi.CWAUTOCONN ; -----------------------------------------
                CHECK_RESPONSE
                RET Z                                                           ; wait response

                ; command "disable multiple connections"
                LD A, ZIFI_CIPMUX
                LD (ZiFi.CMD), A
                LD A, SINGLE
                JP Net.ZiFi.Cmd.SetAutoConnect

ZiWi.CIPMUX     ; -----------------------------------------
                CHECK_RESPONSE
                RET Z                                                           ; wait response

.Loop           ; command "list access points"
                LD A, ZIFI_CWLAP
                LD (ZiFi.CMD), A
                LD A, SINGLE
                JP Net.ZiFi.Cmd.GetListAPs

ZiWi.CWLAP      ; -----------------------------------------
                CHECK_RESPONSE
                JP Z, RefreshAP

                LD A, ZIFI_UNKNOW
                LD (ZiFi.CMD), A
                JP ZiFi.Sutdown

ZiFi.CMD:       DB ZIFI_UNKNOW

                endif ; ~_MENU_OPTIONS_CONNECT_ZI_FI_
