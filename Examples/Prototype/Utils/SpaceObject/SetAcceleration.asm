
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_ACCELERATION_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_ACCELERATION_
; -----------------------------------------
; установка ускорения объекта
; In:
;   IX - указывает на структуру FWord
;   HL - ускорение
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetAcceleration: ; установка значений
                LD (IX + FWord.L), L
                LD (IX + FWord.H), H
                RET

.Zero           LD HL, #0000
                JR SetAcceleration

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_ACCELERATION_
