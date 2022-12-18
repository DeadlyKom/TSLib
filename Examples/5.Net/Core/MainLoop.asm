
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                FT_ClearColorRGB 0, 0, 0
                FT_ClearAll

                ; some draw code
                ; ....

                CALL Console.Draw

                ; LD HL, .Flags
                ; BIT 7, (HL)
                ; CALL NZ, Debug.Draw.TextVGA

                FT_Display
                FT_CMD_Swap
                FT_CMD_Write
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                ; LD HL, .Flags
                ; BIT 7, (HL)
                ; CALL NZ, Debug.Draw.Screen
                ; LD HL, .Flags
                ; BIT 6, (HL)
                ; JP Z, .Loop
                ; LD HL, .Counter
                ; DEC (HL)
                ; HALT
                ; JP NZ, .Loop
                ; LD HL, .Flags
                ; SET 7, (HL)
                ; RES 6, (HL)

                JP .Loop

.Flags          DB #00
.Counter        DB #00

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
