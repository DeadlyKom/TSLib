
                ifndef _NET_COMMAND_
                define _NET_COMMAND_

                module Cmd

                ; basic AT commands 
                include "Basic/TestATStartup.asm"
                include "Basic/RestartModule.asm"
                include "Basic/CheckVersionInfo.asm"
                include "Basic/EnterDeepSleepMode.asm"
                include "Basic/ATCommandsEchoing.asm"

                ; WiFi AT commands
                include "WIFI/SetMode.asm"
                include "WIFI/ConnectToAnAP.asm"
                include "WIFI/AutoConnectToAP.asm"
                include "WIFI/ListAvailableAPs.asm"
                
                ; TCP/IP AT commands
                include "TCP_IP/MultipleConnectionsMode.asm"

POSTFIX:
.CUR            BYTE "CUR"
.DEF            BYTE "DEF"

                endmodule

                endif ; ~_NET_COMMAND_

