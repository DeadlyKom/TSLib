
                ifndef _DEBUG_CONSOLE_DRAW_
                define _DEBUG_CONSOLE_DRAW_
; -----------------------------------------
; draw all message console
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; initialize
                XOR A
                LD (.Row), A
                LD HL, Buffer
                LD (.Offset), HL

                ; check count rows
                LD A, (Buffer.Counter)
                OR A
                RET Z

.Loop           EX AF, AF'                                                      ; save counter

                ; FT_ColorRGB
                LD HL, (.Offset)
                LD A, (HL)
                ADD A, A
                ADD A, A
                LD HL, .Colors
                LD D, #00
                LD E, A
                ADD HL, DE
                LD C, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD E, (HL)
                CALL FT.Coprocessor.ColorRGB

                ; FT_Text
                LD HL, #0000                                           
.Row            EQU $+1
                LD A, #00
                OR A
                JR Z, .IsFirstRow

                LD DE, HEIGHT_FONT
                LD B, A
.HeightLoop     ADD HL, DE
                DJNZ .HeightLoop

.IsFirstRow     LD DE, #0010
                EX DE, HL
                LD BC, FT_OPT_FILL
                LD A, 21                                                        ; size font
                CALL FT.Coprocessor.Text
                LD HL, (.Offset)
                INC HL
                CALL String.Length
                LD HL, (.Offset)
                INC HL
                PUSH HL
                ADD HL, BC
                EX (SP), HL
                CALL FT.Coprocessor.Copy

                ; next row
                POP HL
                LD (.Offset), HL
                LD HL, .Row
                INC (HL)

                ;
                ; FT_ScrollBar 1024-20, 10, 16, 768-20, FT_OPT_NONE, 0, 10, 256

                EX AF, AF'                                                      ; restore counter
                DEC A
                JR NZ, .Loop

                RET

.Offset         DW #0000
.Colors         DB #AA, #AA, #AA, #00                                           ; Verbose
                DB #FF, #FF, #00, #00                                           ; Warning
                DB #FF, #80, #00, #00                                           ; Error

                endif ; ~_DEBUG_CONSOLE_DRAW_
