
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MainLoop:       
.Loop           FT_CMD_Start
                FT_DL_Start
                
                FT_ClearColorRGB 0, 0, 0
                FT_ClearAll

                ; render menu "not zifi"
                CHECK_HARDWARE_FLAG ZIFI_BIT
                CALL Z, ScrNotZiFi

                ; render menu
                LD A, (Flags.Menu)
                CP MENU_START_GAME
                CALL Z, ScrMain

                ; render options
                LD A, (Flags.Menu)
                CP MENU_OPTIONS
                CALL Z, ScrOptions

                ; render resolution
                LD A, (Flags.Menu)
                CP MENU_RESOLUTION
                CALL Z, ScrResolution

                ; render connect
                LD A, (Flags.Menu)
                CP MENU_CONNECT
                CALL Z, ScrConnect

                FT_Display
                FT_CMD_Swap
                FT_CMD_Write
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                CALL Input

                JP .Loop

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
