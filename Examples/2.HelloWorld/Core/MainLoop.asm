
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                FT_ClearColorRGB32 0x000000
                FT_ClearAll

                CALL ShowText
                CALL Fizz

                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                FT_DELAY 2

                JP .Loop

ShowText:       FT_Text 512, 384, 31, FT_OPT_CENTER
                FT_String HelloWorld, HelloWorld.Size
                RET
Fizz:           LD A, 200

.Loop           EX AF, AF'

                FT_Begin FT_POINTS

                ; random size point
                CALL Math.Rand16
                LD D, #00
                ; DE *= 128
                ADD A, A        ; x2
                ADD A, A        ; x4
                ADD A, A        ; x8
                ADD A, A        ; x16
                ADD A, A        ; x32
                RL D
                ADD A, A        ; x64
                RL D
                ADD A, A        ; x128
                RL D
                CALL FT.Coprocessor.PointSize

                ; random red
                CALL Math.Rand8
                LD (.Rand_Red), A

                ; random green
                CALL Math.Rand8
                LD (.Rand_Green), A

                ; random blue
                CALL Math.Rand8
                LD (.Rand_Blue), A

.Rand_Red       EQU $+1
                LD C, #00
.Rand_Green     EQU $+1
.Rand_Blue      EQU $+2
                LD DE, #0000
                CALL FT.Coprocessor.ColorRGB

                ; random alpha
                CALL Math.Rand8
                LD E, A
                CALL FT.Coprocessor.ColorA

                ; random X
                CALL Math.Rand16
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD (.Rand_X), HL

                ; random Y
                CALL Math.Rand16
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                EX DE, HL

.Rand_X         EQU $+1
                LD BC, #0000
                CALL FT.Coprocessor.Vertex2f

                EX AF, AF'
                DEC A
                JR NZ, .Loop

                RET
HelloWorld:     BYTE "Hello world!\0"
.Size           EQU $ - HelloWorld

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
