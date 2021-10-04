
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MainLoop:       ; maybe some code
                ; ...

.Loop           ; FT_CMD_Start
                ; FT_DL_Start
                
                ; ; some draw code
                ; ; ....

                ; FT_ClearColorRGB 0, 0, 0
                ; FT_Clear 1, 1, 1

                ; FT_BitmapHandle 0
                ; FT_BitmapSource Tileset_RAM_G
                ; FT_BitmapLayout Tileset_Format, Tileset_Stride, Tileset_Height
                ; FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, Tileset_Width * Scale, Tileset_Height * Scale

                ; FT_LoadIdentity
                ; FT_Scale Scale << 16, Scale << 16
                ; FT_SetMatrix

                ; FT_Begin FT_BITMAPS
                ; FT_Vertex2ii Tileset_Width * Scale * 0, 0, 0, 0
                ; FT_Vertex2ii Tileset_Width * Scale * 1, 0, 0, 0
                ; FT_Vertex2ii Tileset_Width * Scale * 2, 0, 0, 0
                ; FT_End


                ; FT_Display
                ; FT_CMD_Write

                ; JR $

                FT_WR_DL DL_Point, #0000, Tilemap.Size

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                JP .Loop

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
