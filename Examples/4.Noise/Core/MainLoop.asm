
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

OffsetX         EQU 65
OffsetY         EQU 165
SizeX           EQU 64
SizeY           EQU 48
Scale           EQU 16

MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                ; some draw code
                ; ....

                FT_ClearColorRGB 0, 0, 0
                FT_Clear 1, 1, 1


                FT_BitmapHandle 0
                FT_BitmapSource FT_RAM_G
                FT_BitmapLayout FT_L8, SizeX, SizeY
                FT_BitmapSize FT_NEAREST, FT_BORDER, FT_BORDER, SizeX * Scale, SizeY * Scale

                FT_LoadIdentity
                FT_SetMatrix

                FT_Begin FT_BITMAPS
                FT_Scale Scale << 16, Scale << 16
                FT_SetMatrix
                FT_Vertex2ii 0, 0, 0, 0
                FT_End

                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                LD HL, #E000
.L3             EQU $+1
                LD DE, #0000 + OffsetX
                LD BC, #0000 + OffsetY

.L1             LD (Math.Noise2D.Location.X.Low), DE
                LD (Math.Noise2D.Location.Y.Low), BC

                EXX
                CALL Math.PerlinNoise2D
                LD A, L
                EXX
                
                CP #10
                JR C, $+8
                AND %10100101
                RRCA
                XOR %10100101
                RLCA
                XOR %00101000
                LD (HL), A
                INC HL

                PUSH HL
                INC DE
.L4             EQU $+1
                LD HL, SizeX + OffsetX
                OR A
                SBC HL, DE
                POP HL
                JR NZ, .L1
.L5             EQU $+1
                LD DE, #0000 + OffsetX

                PUSH HL
                INC BC
                LD HL, SizeY + OffsetY
                OR A
                SBC HL, BC
                POP HL
                JR NZ, .L1

                LD HL, #E000
                LD A, (FT_RAM_G >> 16) & 0xFF
                LD DE, FT_RAM_G & 0xFFFF
                LD BC, SizeX * SizeY
                CALL FT.WriteMem

                LD HL, (.L3)
                INC HL
                LD (.L3), HL
                LD (.L5), HL
                LD DE, SizeX
                ADD HL, DE
                LD (.L4), HL

                CALL Input

                JP .Loop
CheckKeyState:  ifdef KEYBOARD_PS2
                JP Input.Keyboard.PS2.KeyState
                else
                JP Input.Keyboard.Spectrum.KeyState
                endif
Input:          ; update key states for PS2 keyboard
                ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.StateUpdates
                endif

                ; check key state MoveRight
                LD A, Input.Keyboard.VK_D
                CALL CheckKeyState
                CALL NZ, MoveRight

                ; check key state MoveLeft
                LD A, Input.Keyboard.VK_A
                CALL CheckKeyState
                CALL NZ, MoveLeft    
                RET
MoveRight:      
                LD HL, Math.Noise2D.Frequency
                DEC (HL)

                RET
MoveLeft:       
                LD HL, Math.Noise2D.Frequency
                INC (HL)
                RET

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
