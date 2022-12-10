
                ifndef _CORE_INITIALIZE_VIDEO_
                define _CORE_INITIALIZE_VIDEO_
Video:          ; reset coprocessor
                FT_CMD_RESET

                ; select video resolution
                FT_RESOLUTION VM_1024_768_59Hz, ResolutionWidthPtr

                ; enable interrupt on display list swap occurred
                FT_WR_REG8 FT_REG_INT_MASK, FT_INT_SWAP
                FT_WR_REG8 FT_REG_INT_EN, 1

                ; switch the screen to FT mode and disable the display of the Spectrum screen
                Video_Setting VID_FT812 | VID_NOGFX

                RET

                endif ; ~_CORE_INITIALIZE_VIDEO_
