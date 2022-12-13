
                ifndef _DEBUG_UTILS_DRAW_CHAR_
                define _DEBUG_UTILS_DRAW_CHAR_
; -----------------------------------------
;
; In:
;   A  - char
;   HL - character address in screen coordinates
;   C  - color
; Out:
; Corrupt:
;   HL, F
; -----------------------------------------
DrawChar:       LD (HL), A
                INC HL
                LD (HL), C
                INC HL
                RET
; -----------------------------------------
;
; In:
;   HL - character address in screen coordinates
;   DE - pointer to null-terminated text
;   C  - color
; Out:
; Corrupt:
;   HL, DE, AF
; -----------------------------------------
DrawString:     LD A, (DE)
                OR A
                RET Z
                INC DE
                CALL DrawChar
                JR DrawString
; -----------------------------------------
;
; In:
;   HL - character address in screen coordinates
;   B  - byte
;   C  - color
; Out:
; Corrupt:
;   HL, AF
; -----------------------------------------
DrawByte:       LD A, '#'
                CALL DrawChar
.NotHash        LD A, B
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, '0'
                CP #3A
                JR C, $+4
                ADD A, #07
                CALL DrawChar
                LD A, B
                AND #0F
                ADD A, '0'
                CP #3A
                JR C, $+4
                ADD A, #07
                CALL DrawChar
                RET
; -----------------------------------------
;
; In:
;   HL - character address in screen coordinates
;   DE - word
;   C  - color
; Out:
; Corrupt:
;   HL, B, AF
; -----------------------------------------
DrawWord:       LD A, '#'
                CALL DrawChar
.NotHash        LD B, D
                CALL DrawByte.NotHash
                LD B, E
                CALL DrawByte.NotHash
                RET
; -----------------------------------------
;
; In:
;   HL - character address in screen coordinates
;   DE - address
;   B  - number of bytes
;   C  - color
; Out:
; Corrupt:
;   
; -----------------------------------------
DrawMemoryDump: LD B, 16

.Loop           LD A, (DE)
                RRA
                RRA
                RRA
                RRA
                AND #0F
                ADD A, '0'
                CP #3A
                JR C, $+4
                ADD A, #07
                LD (HL), A
                INC HL
                LD (HL), C
                INC HL

                LD A, (DE)
                AND #0F
                ADD A, '0'
                CP #3A
                JR C, $+4
                ADD A, #07
                LD (HL), A
                INC HL
                LD (HL), C
                INC HL
 
                INC HL
                INC HL
                INC DE
                DJNZ .Loop

                RET
; -----------------------------------------
;
; In:
;   HL - character address in screen coordinates
;   DE - address
;   B  - number of bytes
;   C  - color
; Out:
; Corrupt:
;   
; -----------------------------------------
DrawDumpText:   LD B, 16
.Loop           LD A, (DE)
                CP ' '
                JR Z, .NotChar
                OR A
                JR NZ, .SetChar
.NotChar        LD A, '.'
.SetChar        LD (HL), A
                INC HL
                LD (HL), C
                INC HL
                INC DE
                DJNZ .Loop
                RET

                endif ; ~_DEBUG_UTILS_DRAW_CHAR_
