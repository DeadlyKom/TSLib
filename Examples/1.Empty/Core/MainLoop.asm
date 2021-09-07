
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_
MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                ; some draw code
                ; ....

                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                JP .Loop

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
