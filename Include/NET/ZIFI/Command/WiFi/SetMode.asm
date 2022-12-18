
                ifndef _NET_COMMAND_SET_WIFI_MODE_
                define _NET_COMMAND_SET_WIFI_MODE_
; -----------------------------------------
; send command set the WiFi mode of ESP devices
; In:
;   A - flags and WiFi mode
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   WIFI_MODE_NONE  - null mode WiFi RF will be disabled
;   WIFI_MODE_ST    - station mode
;   WIFI_MODE_AP    - soft access point mode
;   SAVE_FLASH      - the configuration changes will be saved in the system parameter area in the flash
;   OLD_SDK_BIT     - old SDK (without postfixes)
; Example:
;   LD A, WIFI_MODE_ST | WIFI_MODE_AP | SAVE_FLASH ; set "soft access point mode + station mode" and saved parameter area in the flash
;   command equivalent "AT+CWMODE_DEF"
; -----------------------------------------
SetMode:        LD HL, .Custom

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
                JR .NotShift

.WithoutPostfix SRL A
.NotShift       LD (HL), "="
                INC HL

.SetMode        ; set mode
                ADD A, '0'
                LD (HL), A
                INC HL
                LD (HL), "\r"
                INC HL
                LD (HL), "\n"
                INC HL
                
                ; send command
                LD DE, .Command
                SBC HL, DE
                EX DE, HL
                JP Net.ZiFi.SendATCommand

.Command        BYTE "AT+CWMODE"
.Custom         DS 8, 0

                endif ; ~_NET_COMMAND_SET_WIFI_MODE_

