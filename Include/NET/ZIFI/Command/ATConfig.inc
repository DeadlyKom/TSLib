
                ifndef _NET_AT_COMMAND_CONF_
                define _NET_AT_COMMAND_CONF_

DISABLE         EQU 0x00
ENABLE          EQU 0x01

SINGLE          EQU 0x00
MULTIPLE        EQU 0x01

WIFI_MODE_NONE  EQU 0x00 << 2                                                   ; null mode WiFi RF will be disabled
WIFI_MODE_ST    EQU 0x01 << 2                                                   ; station mode
WIFI_MODE_AP    EQU 0x02 << 2                                                   ; soft access point mode

OLD_SDK_BIT     EQU 0x00                                                        ; old SDK (without postfixes)
OLD_SDK         EQU 1 << OLD_SDK_BIT

SAVE_FLASH_BIT  EQU 0x01                                                        ; the configuration changes will be saved in the system parameter area in the flash
NOT_SAVE_FLASH  EQU 0 << SAVE_FLASH_BIT                                         ; the configuration changes will be saved in the system parameter area in the flash
SAVE_FLASH      EQU 1 << SAVE_FLASH_BIT                                         ; the configuration changes will be saved in the system parameter area in the flash

RESPONSE:
.OK             BYTE "OK\0"
.ERROR          BYTE "ERROR\0"
.FAIL           BYTE "FAIL\0"
.BUSY           BYTE "busy p...\0"

                endif ; ~_NET_AT_COMMAND_CONF_
