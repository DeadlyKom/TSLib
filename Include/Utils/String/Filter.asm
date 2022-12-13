
                ifndef _STRING_FILTER_
                define _STRING_FILTER_
; -----------------------------------------
; filter string
; In:
;   HL - pointer to predicate
;   DE - pointer to string
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Filter:         ;
.Loop           LD A, (DE)
                OR A
                RET Z

                LD BC, .Callback
                PUSH BC
                JP (HL)

.Callback       INC DE
                JR NC, .Loop

                PUSH HL
                PUSH DE
                LD H, D
                LD L, E
                DEC DE
.Move           LDI
                LD A, (HL)
                OR A
                JR NZ, .Move
                LDI
                POP DE
                POP HL
                DEC DE
                JR .Loop

                endif ; ~_STRING_FILTER_
