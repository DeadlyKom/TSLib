
                ifndef _EXAMPLE_CORE_INITIALIZE_
                define _EXAMPLE_CORE_INITIALIZE_

Initialize:     CALL Init_Core
                CALL Init_Int
                CALL Init_Video
                CALL Init_Keyboard
                CALL Init_Image
                CALL Init_Console
                CALL Init_ZIFI

                RET

Init_Core:      FMapAddrInit
                System_Setting SYS_ZCLK14 | SYS_CACHEEN
                Cache_Setting EN_4000 | EN_8000

                ; set memory page, not initialize value mapping registers TS Conf
                SetPage1 5
                SetPage2 2
                SetPage3 8

                ; clear variables
                LD HL, Variables
                LD DE, Variables+1
                LD BC, VariablesSize
                LD (HL), #00
                LDIR

                RET

Init_Int:       LD HL, INT_Handler
                LD (InterruptVA_Frame), HL
                LD A, HIGH InterruptVA
                LD I, A
                IM 2

                ; enable interrupt frame
                INT_Setting INT_MSK_FRAME

                EI
                HALT
                RET

INT_Handler:    PUSH HL
                PUSH DE
                PUSH BC
                PUSH IX
                PUSH IY
                PUSH AF
                EX AF, AF'
                PUSH AF
                EXX
                PUSH HL
                PUSH DE
                PUSH BC

                ; update key states for PS2 keyboard
                ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.StateUpdates
                endif

                POP BC
                POP DE
                POP HL
                EXX
                POP AF
                EX AF, AF'
                POP AF
                POP IY
                POP IX
                POP BC
                POP DE
                POP HL

                EI
                RET

Init_Video:     ; reset coprocessor
                FT_CMD_RESET

                ; select video resolution
                XOR A
                CALL SetResolution

                ; enable interrupt on display list swap occurred
                FT_WR_REG8 FT_REG_INT_MASK, FT_INT_SWAP
                FT_WR_REG8 FT_REG_INT_EN, 1

                ; switch the screen to FT mode and disable the display of the Spectrum screen
                Video_Setting VID_FT812 | VID_NOGFX

                RET

Init_Console:   JP Console.Initialize

Init_ZIFI:      CALL Net.ZiFi.Initialize
                HARDWARE_FLAGS
                
                RES_FLAG ZIFI_BIT
                LD A, MENU_NOT_ZIFI
                JR C, .SetMenu

                LD A, MENU_START_GAME
                SET_FLAG ZIFI_BIT

.SetMenu        LD (Flags.Menu), A
                RET

                include "Examples/5.Net/Files/Fonts/L1/Fonts.inc"

Init_Image:     ; transfer daya to FT812
                FT_WR_DMA Font_12.RAM, Font_12.Page, Font_12.FTRAM_Adr, Font_12.Size
                FT_WR_DMA Font_30.RAM, Font_30.Page, Font_30.FTRAM_Adr, Font_30.Size
                RET

Init_Keyboard:  ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.Initialize
                endif
                JP Input.Mouse.Initialize

                endif ; ~_EXAMPLE_CORE_INITIALIZE_
