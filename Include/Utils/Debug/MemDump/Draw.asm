
                ifndef _DEBUG_MEMORY_DUMP_DRAW_
                define _DEBUG_MEMORY_DUMP_DRAW_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; get page
                CALL Memory.GetPage2
                EX AF, AF'

                ; address alignment
                LD HL, (Address)
                LD A, L
                AND #F0
                LD L, A
                LD DE, #FFC0
                ADD HL, DE
                LD (.Address), HL
                PUSH HL

                ; draw label address
                LD BC, (Location)
                CALL Debug.Utils.GetAdrScreen
                LD DE, .StringLabel
                LD C, Debug.COLOR.DUMP_LABLE
                CALL Debug.Utils.DrawString

                ; initialize
                LD A, NUM_ROWS
                LD (.CountLine), A

                ; calculate screen address
                LD BC, (Location)
                CALL Debug.Utils.GetAdrScreen
                INC H

                ; main loop
.Loop           PUSH HL

                ; calculate number blank
                PUSH HL
                LD HL, (.Address)
                LD A, H
                RLCA
                RLCA
                AND #03

                ifdef MAPPING_REGISTERS
                LD HL, FMADDR_REGS + HIGH PAGE0
                else
                LD HL, MemoryPages
                endif
                
                LD C, A
                LD B, #00
                ADD HL, BC
                LD A, (HL)
                POP HL

                ; set page
                CALL Memory.SetPage2
                LD B, A

                ; draw memory page
                LD C, Debug.COLOR.DUMP_ADR
                CALL Debug.Utils.DrawByte

                ; next column
                INC L
                INC L

                ; draw memory address
                LD DE, (.Address)
                LD C, Debug.COLOR.DUMP_ADR
                CALL Debug.Utils.DrawWord

                ; next column
                INC L
                INC L

                ; draw memory dump
                LD DE, (.Address)

                ; limit address
                LD A, D
                AND #3F
                OR #80
                LD D, A
                PUSH DE
                LD C, Debug.COLOR.DUMP_DATA
                CALL Debug.Utils.DrawMemoryDump
                
                ; draw memory dump text
                POP DE
                LD C, Debug.COLOR.DUMP_TEXT
                CALL Debug.Utils.DrawDumpText

                ; next address dump
                LD DE, #0010
                LD HL, (.Address)
                ADD HL, DE
                LD (.Address), HL

                ; 
                POP HL
                INC H

                ;
.CountLine      EQU $+1
                LD A, #00
                DEC A
                LD (.CountLine), A
                JR NZ, .Loop

                ; fill the dump drawing area
                LD A, Debug.COLOR.DUMP_TEXT
                LD DE, #4A00 | NUM_ROWS
                LD BC, (Location)
                INC C
                CALL Debug.Utils.FillBackground

                ;
                POP HL
                LD (.Address), HL

                ; set page
                EX AF, AF'
                CALL Memory.SetPage2

                ; exit
                RET

.Address        DW #0000
.StringLabel    BYTE "Address:   0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F ______Chars_____\0"

; -----------------------------------------
; In:
;   HL - address
;   A  - color
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawLabel:      LD DE, NUM_ROWS << 4
                LD BC, (Draw.Address)
                OR A
                SBC HL, BC
                OR A
                SBC HL, DE
                RET NC

                ;
                ADD HL, DE
                LD BC, (Location)
                EX AF, AF'
                ;
                LD A, #0F
                AND L
                LD E, A
                ADD A, A
                ADD A, E
                ADD A, B
                ADD A, #0A
                LD B, A
                LD A, #F0
                AND L
                RRA
                RRA
                RRA
                RRA
                ADD A, C
                INC A
                LD C, A

                ;
                CALL Debug.Utils.GetAdrScreen
                INC L
                EX AF, AF'
                LD (HL), A
                INC L
                INC L
                LD (HL), A

                RET

                endif ; ~_DEBUG_MEMORY_DUMP_DRAW_
