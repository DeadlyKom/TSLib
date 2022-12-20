                ifndef _MACRO_FLAGS_
                define _MACRO_FLAGS_
; -----------------------------------------
; проверка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
CHECK_FLAG      macro FlagBit?
                BIT FlagBit?, (HL)
                endm
; -----------------------------------------
; проверка флага
; In:
;   A  - значения флагов
; Out:
; Corrupt:
; -----------------------------------------
CHECK_FLAG_A    macro FlagBit?
                BIT FlagBit?, A
                endm
; -----------------------------------------
; установка флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
SET_FLAG        macro FlagBit?
                SET FlagBit?, (HL)
                endm
; -----------------------------------------
; сброс флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
RES_FLAG        macro FlagBit?
                RES FlagBit?, (HL)
                endm
; -----------------------------------------
; изъятие флага
; In:
;   HL - адрес хранения флагов
; Out:
; Corrupt:
; -----------------------------------------
POP_FLAG        macro FlagBit?
                CHECK_FLAG FlagBit?
                JR Z, .Next
                RES_FLAG FlagBit?
.Next           ;
                endm

; -----------------------------------------
; установка HL на Render флаги
; In:
; Out:
; Corrupt:
; -----------------------------------------
HARDWARE_FLAGS  macro
                LD HL, Flags.Hardware
                endm
; -----------------------------------------
; проверка Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_HARDWARE_FLAG macro FlagBit?
                HARDWARE_FLAGS
                CHECK_FLAG FlagBit?
                endm
; -----------------------------------------
; установка Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_HARDWARE_FLAG macro FlagBit?
                HARDWARE_FLAGS
                SET_FLAG FlagBit?
                endm
; -----------------------------------------
; сброс Render флага
; In:
; Out:
; Corrupt:
; -----------------------------------------
RES_HARDWARE_FLAG macro FlagBit?
                HARDWARE_FLAGS
                RES_FLAG FlagBit?
                endm

                endif ; ~_MACRO_FLAGS_
