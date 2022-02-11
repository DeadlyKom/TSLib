
                ifndef _CORE_LOOP_DRAW_
                define _CORE_LOOP_DRAW_
Draw:           FT_CMD_Start
                FT_DL_Start

                CALL Game.CelestialObject.Draw
                
                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                RET

                endif ; ~_CORE_LOOP_DRAW_
