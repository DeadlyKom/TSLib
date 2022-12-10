
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_VELOCITY_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_VELOCITY_
; -----------------------------------------
; установка скорость объекта
; In:
;   IX - указывает на структуру FWord
;   HL - скорость
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetVelocity:    ; установка значений
                LD (IX + FWord.L), L
                LD (IX + FWord.H), H
                RET

.Zero           LD HL, #0000
                JR SetVelocity

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_VELOCITY_
