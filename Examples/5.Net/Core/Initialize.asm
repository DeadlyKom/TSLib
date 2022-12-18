
                ifndef _EXAMPLE_CORE_INITIALIZE_
                define _EXAMPLE_CORE_INITIALIZE_

Initialize:     CALL Init_Core
                CALL Init_Int
                CALL Init_Video
                CALL Init_Console
                CALL Init_ZIFI

                ; command "get version"
                CALL Net.ZiFi.Setting
                RET

Init_Core:      FMapAddrInit
                System_Setting SYS_ZCLK14 | SYS_CACHEEN
                Cache_Setting EN_4000 | EN_8000

                ; set memory page, not initialize value mapping registers TS Conf
                SetPage1 5
                SetPage2 2
                SetPage3 8

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

INT_Handler:    EI
                RET

Init_Video:     ; reset coprocessor
                FT_CMD_RESET

                ; select video resolution
                FT_RESOLUTION VM_1024_768_59Hz, ResolutionWidthPtr

                ; enable interrupt on display list swap occurred
                FT_WR_REG8 FT_REG_INT_MASK, FT_INT_SWAP
                FT_WR_REG8 FT_REG_INT_EN, 1

                ; switch the screen to FT mode and disable the display of the Spectrum screen
                Video_Setting VID_FT812 | VID_NOGFX

                RET

Init_Console:   JP Console.Initialize

Init_ZIFI:      CALL Net.ZiFi.Initialize
                JR C, .Failed
                ; PUSH HL

                ; add message about successful initialization
                LD A, Console.Verbose
                LD HL, .ZIFI_OK
                JP Console.Add

                ; ;
                ; POP HL
                ; LD (Debug.MemDump.Address), HL
                ; PUSH HL
                ; LD HL, MainLoop.Flags
                ; SET 6, (HL)
                ; POP HL
                ; LD A, Console.Verbose
                ; JP Console.Add

.Failed         LD A, Console.Error
                LD HL, .ZIFI_FAILE
                JP Console.Add

.ZIFI_OK        BYTE "Initialization ZiFi is successful\0"
.ZIFI_FAILE     BYTE "Initialization ZiFi is failed\0"

                endif ; ~_EXAMPLE_CORE_INITIALIZE_
