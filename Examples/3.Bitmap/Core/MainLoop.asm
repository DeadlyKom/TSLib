
                ifndef _EXAMPLE_CORE_MAIN_LOOP_
                define _EXAMPLE_CORE_MAIN_LOOP_

MOVE_LEFT       EQU 0xFF
MOVE_STOP       EQU 0x00
MOVE_RIGHT      EQU 0x01
ANIMATION_IDLE  EQU 0x06
NUM_ANIMATION   EQU 0x08

RES_WIDTH       EQU 1024
CHAR_POS_Y      EQU 600

CHAR_WIDTH      EQU 64
CHAR_HEIGHT     EQU 64
CHAR_SCALE      EQU 2

CHAR_RAM_G      EQU Character_FTRAM_1
CHAR_STRIDE     EQU Character_Stride_1

MainLoop:       ; maybe some code
                ; ...

.Loop           FT_CMD_Start
                FT_DL_Start
                
                FT_ClearColorRGB 0, 255, 0
                FT_ClearAll

                CALL DrawParallax

                LD A, (Direction)
                OR A
                JR Z, .SkipMove
                CALL MoveParallax

.SkipMove       ; set default matrix
                FT_LoadIdentity
                FT_SetMatrix

                FT_Display
                FT_CMD_Write

                ; swap display list
                FT_WR_REG8 FT_REG_DLSWAP, FT_DLSWAP_FRAME
                
.WaitIntSwap    ; wait, swap display list
                FT_RD_REG8 FT_REG_INT_FLAGS
                AND FT_INT_SWAP
                JR Z, .WaitIntSwap

                CALL Input                          ; handler input

                FT_DELAY 2                          ; hard delay

                JP .Loop

Input:          ; update key states for PS2 keyboard
                ifdef KEYBOARD_PS2
                CALL Input.Keyboard.PS2.StateUpdates
                endif

                ; save last direction, unless it is STOP
                LD A, (Direction)
                CP MOVE_STOP
                JR Z, $+5
                LD (Direction.Last), A

                ; reset direction moving
                LD A, MOVE_STOP
                LD (Direction), A

                ; check key state MoveRight
                LD A, Input.Keyboard.VK_D
                CALL CheckKeyState
                CALL NZ, MoveRight

                ; check key state MoveLeft
                LD A, Input.Keyboard.VK_A
                CALL CheckKeyState
                CALL NZ, MoveLeft

                ; animate the character, unless it is STOP
                LD A, (Direction)
                CP MOVE_STOP
                JP NZ, NextAnimation

                ; the character has stopped, 
                ; but we will play the entire chain of animations up to IDLE
                LD A, (AnimatePlayer)
                CP ANIMATION_IDLE
                JR NZ, NextAnimation
                RET

PrevAnimation:  ; switch to previous animation
                LD A, (AnimatePlayer)
                DEC A
                AND NUM_ANIMATION - 1       ; clamp
                LD (AnimatePlayer), A
                RET
NextAnimation:  ; switch to next animation
                LD A, (AnimatePlayer)
                INC A
                AND NUM_ANIMATION - 1       ; clamp
                LD (AnimatePlayer), A
                RET
MoveLeft:       ; moving to the left
                LD A, MOVE_LEFT
                LD (Direction), A

                RET
MoveRight:      ; moving to the right
                LD A, MOVE_RIGHT
                LD (Direction), A
                
                RET
; -----------------------------------------
; check the state of the keyboard virtual key
; In :
;   A  - virtual code
; Out :
;   if the Z flag is set, if the button is pressed
; Corrupt :
;   AF
; -----------------------------------------
CheckKeyState:  ifdef KEYBOARD_PS2
                JP Input.Keyboard.PS2.KeyState
                else
                JP Input.Keyboard.Spectrum.KeyState
                endif
DrawPlayer:     ; set default matrix
                FT_LoadIdentity
                FT_SetMatrix

                ; mirrored the character sprite if it moves to the left
                LD A, (Direction)
                CP MOVE_STOP
                JR NZ, $+5
                LD A, (Direction.Last)
                CP MOVE_LEFT
                JR Z, .Mirror

                FT_Scale CHAR_SCALE << 16, CHAR_SCALE << 16             ; scale along the x- y- axes
                JP .Draw

.Mirror         FT_Translate CHAR_WIDTH << 4, 0 << 4
                FT_Scale -CHAR_SCALE << 16 , CHAR_SCALE << 16
                FT_Translate -CHAR_WIDTH << 4, 0 << 4
               
.Draw           FT_SetMatrix                                            ; apply transform
                FT_SaveContext
                
                ; seting character sprite
                FT_BitmapHandle 11
                FT_BitmapSource Character_FTRAM_1
                FT_BitmapLayout CHAR_RAM_G, CHAR_STRIDE, CHAR_HEIGHT
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, CHAR_WIDTH * CHAR_SCALE, CHAR_HEIGHT * CHAR_SCALE

                FT_Begin FT_BITMAPS
                ; select animation
                LD A, (AnimatePlayer)
                AND NUM_ANIMATION - 1
                CALL FT.Coprocessor.Cell
                FT_Vertex2f ((RES_WIDTH - CHAR_WIDTH * CHAR_SCALE) >> 1) << 4, CHAR_POS_Y << 4
                FT_End

                FT_RestoreContext

                ; set default matrix
                FT_LoadIdentity
                FT_SetMatrix

                RET

DrawParallax:   ; setting up a common transformation matrix for all layers
                FT_Scale 4 << 16, 4 << 16           ; scale x4 along the x- y- axes
                FT_SetMatrix
                
                ; --------------------------------------------------------------
                ; display bitmap size settings
                ; --------------------------------------------------------------
                ; FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ;
                ;   FT_NEAREST  - bitmap filtering mode
                ;   FT_REPEAT   - on the x-axis it is necessary to repeat the display
                ;   FT_BORDER   - on the y-axis we display the calmp
                ;   1024 * 2    - since repeat on the x-axis, our values are in the range from -1024 to 1024
                ;   768         - screen height
                ; --------------------------------------------------------------

                ; setting layer (10)
                FT_BitmapHandle 10
                FT_BitmapSource Parallax_FTRAM_A
                FT_BitmapLayout Parallax_Format_A, Parallax_Stride_A, Parallax_Height_A
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (10)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t0A)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (9)
                FT_BitmapHandle 9
                FT_BitmapSource Parallax_FTRAM_9
                FT_BitmapLayout Parallax_Format_9, Parallax_Stride_9, Parallax_Height_9
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (9)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t09)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (8)
                FT_BitmapHandle 8
                FT_BitmapSource Parallax_FTRAM_8
                FT_BitmapLayout Parallax_Format_8, Parallax_Stride_8, Parallax_Height_8
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (8)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t08)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (7)
                FT_BitmapHandle 7
                FT_BitmapSource Parallax_FTRAM_7
                FT_BitmapLayout Parallax_Format_7, Parallax_Stride_7, Parallax_Height_7
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (7)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t07)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (6)
                FT_BitmapHandle 6
                FT_BitmapSource Parallax_FTRAM_6
                FT_BitmapLayout Parallax_Format_6, Parallax_Stride_6, Parallax_Height_6
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (6)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t06)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (5)
                FT_BitmapHandle 5
                FT_BitmapSource Parallax_FTRAM_5
                FT_BitmapLayout Parallax_Format_5, Parallax_Stride_5, Parallax_Height_5
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (5)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t05)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (4)
                FT_BitmapHandle 4
                FT_BitmapSource Parallax_FTRAM_4
                FT_BitmapLayout Parallax_Format_4, Parallax_Stride_4, Parallax_Height_4
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (4)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t04)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; setting layer (3)
                FT_BitmapHandle 3
                FT_BitmapSource Parallax_FTRAM_3
                FT_BitmapLayout Parallax_Format_3, Parallax_Stride_3, Parallax_Height_3
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (3)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t03)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                CALL DrawPlayer

                ; setting up a common transformation matrix for all layers
                FT_Scale 4 << 16, 4 << 16           ; scale x4 along the x- y- axes
                FT_SetMatrix

                ; setting layer (2)
                FT_BitmapHandle 2
                FT_BitmapSource Parallax_FTRAM_2
                FT_BitmapLayout Parallax_Format_2, Parallax_Stride_2, Parallax_Height_2
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; draw layer (2)
                FT_Begin FT_BITMAPS
                LD DE, #0000
                LD BC, (Timeline.t02)
                CALL FT.Coprocessor.Vertex2f
                FT_End

                ; seting layer (1)
                FT_BitmapHandle 1
                FT_BitmapSource Parallax_FTRAM_1
                FT_BitmapLayout Parallax_Format_1, Parallax_Stride_1, Parallax_Height_1
                FT_BitmapSize FT_NEAREST, FT_REPEAT, FT_BORDER, 1024 * 2, 768
                ; this layer is very pixels (add alpha blend)
                FT_ColorA 16
                ; draw layer (1)
                FT_Begin FT_BITMAPS 
                LD DE, #0000
                LD BC, (Timeline.t01)
                CALL FT.Coprocessor.Vertex2f
                FT_End
                ; reset alpha
                FT_ColorA 255

                RET

ShiftLayer:     EXX
                ; read timeline value
                LD E, (HL)
                INC HL
                LD D, (HL)

                ; append value to timeline
                PUSH HL
                LD A, (Direction)
                CP MOVE_LEFT
                JR Z, .SkipNegative

                ; negative BC value
                LD HL, #0000
                SBC HL, BC
                LD B, H
                LD C, L
                
.SkipNegative   EX DE, HL
                ADD HL, BC
                EX DE, HL

                ; clamp values y-axis
                LD A, D
                OR #C0
                LD D, A
                POP HL
                
                ; write new timeline value
                LD (HL), D
                DEC HL
                LD (HL), E
                EXX

                RET
MoveParallax:   ; shift layer (1)
                EXX
                LD HL, Timeline.t01             ; pointer to timeline t01
                LD BC, 1024                     ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (2)
                EXX
                LD HL, Timeline.t02             ; pointer to timeline t02
                LD BC, 512                      ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (3)
                EXX
                LD HL, Timeline.t03             ; pointer to timeline t03
                LD BC, 256                      ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (4)
                EXX
                LD HL, Timeline.t04             ; pointer to timeline t04
                LD BC, 128                      ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (5)
                EXX
                LD HL, Timeline.t05             ; pointer to timeline t05
                LD BC, 64                       ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (6)
                EXX
                LD HL, Timeline.t06             ; pointer to timeline t06
                LD BC, 32                       ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (7)
                EXX
                LD HL, Timeline.t07             ; pointer to timeline t07
                LD BC, 16                       ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (8)
                EXX
                LD HL, Timeline.t08             ; pointer to timeline t08
                LD BC, 8                        ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (9)
                EXX
                LD HL, Timeline.t09             ; pointer to timeline t09
                LD BC, 4                        ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                ; shift layer (10)
                EXX
                LD HL, Timeline.t0A             ; pointer to timeline t0A
                LD BC, 2                        ; shift value of the current layer [-16384 .. 16384]
                EXX
                CALL ShiftLayer

                RET

; timeline value store
Timeline:
.t0A            DW 0000
.t09            DW 0000
.t08            DW 0000
.t07            DW 0000
.t06            DW 0000
.t05            DW 0000
.t04            DW 0000
.t03            DW 0000
.t02            DW 0000
.t01            DW 0000

Direction:      DB MOVE_STOP
.Last           DB MOVE_STOP
AnimatePlayer:  DB #06

                endif ; ~_EXAMPLE_CORE_MAIN_LOOP_
