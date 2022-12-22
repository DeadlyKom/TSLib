
                ifndef _STRING_CONTAINS_
                define _STRING_CONTAINS_
; -----------------------------------------
; checking if first string contained second string
; In:
;   HL - pointer to first string
;   DE - pointer to second string
;   B  - lenght first string
; Out:
;   if the C flag is reset, if first string contains second string
; Corrupt:
;   HL, DE, AF
; Note:
;   length second string < length first string
; -----------------------------------------
Contains:       ; check length string more zero
                LD A, (DE)
                OR A
                SCF
                RET Z                                                           ; exit, if null-terminated (the C flag is set)

                ; initialize
                LD A, B
                LD B, D
                LD C, E

.Loop           EX AF, AF'
.Compare        LD A, (DE)
                OR A
                RET Z                                                           ; exit, if null-terminated (the C flag is reset)

                CP (HL)
                INC HL
                JR NZ, .NextChar

                INC DE
                JR .Compare

.NextChar       LD A, (HL)
                OR A
                JR Z, .Fail

                EX DE, HL
                SBC HL, BC
                EX DE, HL
                SBC HL, DE

                LD D, B
                LD E, C

                EX AF, AF'
                DEC A
                JR NZ, .Loop

.Fail           SCF
                RET

                endif ; ~_STRING_CONTAINS_
