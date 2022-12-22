
                ifndef _MENU_INCLUDE_
                define _MENU_INCLUDE_

MENU_NOT_ZIFI   EQU 0x00
MENU_START_GAME EQU 0x01
MENU_OPTIONS    EQU 0x02
MENU_RESOLUTION EQU 0x03
MENU_CONNECT    EQU 0x04

FONT_12_HEIGHT  EQU 20
FONT_12_PADDING EQU 20
FONT_30_HEIGHT  EQU 40

NUMBER_AP       EQU 32
NUMBER_VIS_AP   EQU 16

                include "Color.asm"
                include "Anchor.asm"
                include "NotZiFi.asm"
                include "Main.asm"
                include "Options.asm"
                include "Resolution.asm"
                include "Connect/ConnectZiWi.asm"
                include "Connect/ConnectListAP.asm"
                include "Connect/Connect.asm"
                include "Connect/ConnectInput.asm"
                include "ChangeResolution.asm"
                
                endif ; ~_MENU_INCLUDE_
