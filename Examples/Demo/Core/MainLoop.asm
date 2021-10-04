
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                ; some draw code
                ; ....

                FT_ClearColorRGB 0, 0, 0
                FT_Clear 1, 1, 1

                FT_BitmapHandle 0
                FT_BitmapSource ScreenRAM
                FT_BitmapLayout FT_ARGB1555, ScreenSizeX * 2, ScreenSizeY
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, ScreenSizeX, ScreenSizeY

.Step_A         EQU $
                SCF
                CALL C, FadeIn
                JR NC, $+12
                LD A, #B7
                LD (.Step_A), A
                LD A, #37
                LD (.Step_B), A

.Step_B         EQU $
                OR A
                CALL C, Glitch

                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                ; HALT

                JP .Loop

FadeIn:         LD A, (.Alpha)
                LD E, A
                CALL FT.Coprocessor.ColorA

                FT_Begin FT_BITMAPS
                FT_Vertex2f ((1024 - ScreenSizeX) >> 1) << 4, ((768 - ScreenSizeY) >> 1) << 4
                FT_End

                LD HL, .Alpha
                INC (HL)
                JR Z, .Complite
                OR A
                RET

.Complite       SCF
                RET               

.Alpha          DB #00

Glitch:         
                LD HL, .Next
                PUSH HL

.Effect         EQU $+1
                LD A, #00
                CP 1
                JP Z, .Left
                CP 2
                JP Z, .Right

.Normal         
                FT_LoadIdentity
                FT_SetMatrix

                FT_Begin FT_BITMAPS
                FT_ColorMask 1, 0, 0, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1)) << 4, ((768 - ScreenSizeY) >> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 1, 0, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1)) << 4, ((768 - ScreenSizeY) >> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 0, 10, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1)) << 4, ((768 - ScreenSizeY) >> 1) << 4
                FT_End

                RET

.Left           FT_Begin FT_BITMAPS
                FT_ColorMask 1, 0, 0, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) - 4) << 4, (((768 - ScreenSizeY) + 2) >> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 1, 0, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) + 4) << 4, (((768 - ScreenSizeY) - 1) >> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 0, 1, 0

                LD A, R
                RRA
                JR C, .Skip_Left

                FT_Scale 3 * 32768, 2 * 32768
                FT_SetMatrix
.Skip_Left
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) + 3) << 4, (((768 - ScreenSizeY) + 2) >> 1) << 4
                FT_End

                RET

.Right          FT_LoadIdentity
                FT_SetMatrix
                
                FT_Begin FT_BITMAPS
                FT_ColorMask 1, 0, 0, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) + 4) << 4, (((768 - ScreenSizeY) - 1)>> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 1, 0, 0

                LD A, R
                RRA
                JR C, .Skip_Right

                FT_Scale 2 * 32768, 3 * 32768
                FT_SetMatrix
.Skip_Right
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) - 4) << 4, (((768 - ScreenSizeY) + 1)>> 1) << 4
                FT_End

                FT_Begin FT_BITMAPS
                FT_ColorMask 0, 0, 1, 0
                FT_Vertex2f (((1024 - ScreenSizeX) >> 1) + 4) << 4, (((768 - ScreenSizeY) + 2) >> 1) << 4
                FT_End

                RET               

.Next           LD HL, .Delta
                DEC (HL)
                RET NZ

                CALL Math.Rand8
                AND %00000111
                ADD A, #01
                LD (.Delta), A

                LD C, A
                LD A, R
                XOR C
                AND 3
                LD (.Effect), A
                RET

.Delta          DB #10

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
