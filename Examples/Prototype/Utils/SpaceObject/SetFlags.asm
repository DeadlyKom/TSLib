
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_FLAGS_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_FLAGS_
; -----------------------------------------
; установка флагов объекта
; In:
;   IX - указывает на структуру FWord
;   HL - флаги
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetFlags:       ; установка значений
                LD (IX + FWord.L), L
                LD (IX + FWord.H), H
                RET

.Zero           LD HL, #0000
                JR SetFlags

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_FLAGS_
