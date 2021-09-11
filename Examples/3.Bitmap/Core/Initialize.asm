
                ifndef _EXAMPLE_CORE_INITIALIZE_
                define _EXAMPLE_CORE_INITIALIZE_

Initialize:     CALL Init_Core
                CALL Init_Int
                CALL Init_Video
                CALL Init_Image
                CALL Init_Keyboard
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

                include "TexturesParallax.inc"
                include "TexturesCharacter.inc"
Init_Image:     ; transfer parallax textures to FT812
                FT_WR_INFLATE Parallax_FTRAM_A, Parallax_Page_A, Parallax_RAM_A, Parallax_Size_A
                FT_WR_INFLATE Parallax_FTRAM_9, Parallax_Page_9, Parallax_RAM_9, Parallax_Size_9
                FT_WR_INFLATE Parallax_FTRAM_8, Parallax_Page_8, Parallax_RAM_8, Parallax_Size_8
                FT_WR_INFLATE Parallax_FTRAM_7, Parallax_Page_7, Parallax_RAM_7, Parallax_Size_7
                FT_WR_INFLATE Parallax_FTRAM_6, Parallax_Page_6, Parallax_RAM_6, Parallax_Size_6
                FT_WR_INFLATE Parallax_FTRAM_5, Parallax_Page_5, Parallax_RAM_5, Parallax_Size_5
                FT_WR_INFLATE Parallax_FTRAM_4, Parallax_Page_4, Parallax_RAM_4, Parallax_Size_4
                FT_WR_INFLATE Parallax_FTRAM_3, Parallax_Page_3, Parallax_RAM_3, Parallax_Size_3
                FT_WR_INFLATE Parallax_FTRAM_2, Parallax_Page_2, Parallax_RAM_2, Parallax_Size_2
                FT_WR_INFLATE Parallax_FTRAM_1, Parallax_Page_1, Parallax_RAM_1, Parallax_Size_1

                ; transfer character textures to FT812
                FT_WR_INFLATE Character_FTRAM_1, Character_Page_1, Character_RAM_1, Character_Size_1
                FT_WR_INFLATE Character_FTRAM_2, Character_Page_2, Character_RAM_2, Character_Size_2
                FT_WR_INFLATE Character_FTRAM_3, Character_Page_3, Character_RAM_3, Character_Size_3
                FT_WR_INFLATE Character_FTRAM_4, Character_Page_4, Character_RAM_4, Character_Size_4
                FT_WR_INFLATE Character_FTRAM_5, Character_Page_5, Character_RAM_5, Character_Size_5
                FT_WR_INFLATE Character_FTRAM_6, Character_Page_6, Character_RAM_6, Character_Size_6
                FT_WR_INFLATE Character_FTRAM_7, Character_Page_7, Character_RAM_7, Character_Size_7
                FT_WR_INFLATE Character_FTRAM_8, Character_Page_8, Character_RAM_8, Character_Size_8

                RET

Init_Keyboard:  ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.Initialize
                endif
                CALL Input.Mouse.Initialize

                RET

                endif ; ~_EXAMPLE_CORE_INITIALIZE_
