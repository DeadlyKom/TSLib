
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_ROTATOR_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_ROTATOR_
; -----------------------------------------
; установка матрицы
; In:
;   IX - указывает на структуру FRotator
;   HL - Roll,  вращение вокруг forward оси (ось Z)
;   DE - Pitch, вращение вокруг right оси (ось X)
;   BC - Yaw,   вращение вокруг up оси (ось Y)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetRotator:     LD (IX + FRotator.Roll.L), L
                LD (IX + FRotator.Roll.H), H
                LD (IX + FRotator.Pitch.L), E
                LD (IX + FRotator.Pitch.H), D
                LD (IX + FRotator.Yaw.L), C
                LD (IX + FRotator.Yaw.H), B
                RET

; -----------------------------------------
; установка нулевого ротатора
; In:
;   IX - указывает на структуру FRotator
; Out:
; Corrupt:
; Note:
; -----------------------------------------
.Zero           ; установка строки M2
                LD HL, #0000
                LD DE, #0000
                LD BC, #0000
                JR SetRotator

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_ROTATOR_
