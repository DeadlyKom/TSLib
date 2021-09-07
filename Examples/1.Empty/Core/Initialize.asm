
                ifndef _EXAMPLE_CORE_INITIALIZE_
                define _EXAMPLE_CORE_INITIALIZE_

Initialize:     CALL Init_Core
                CALL Init_Int
                CALL Init_Video
                RET

Init_Core:      FMapAddrInit
                System_Setting SYS_ZCLK14 | SYS_CACHEEN
                Cache_Setting EN_0000 | EN_4000 | EN_8000

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

                endif ; ~_EXAMPLE_CORE_INITIALIZE_
