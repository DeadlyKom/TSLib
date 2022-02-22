
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_LOCATION_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_LOCATION_
; -----------------------------------------
; установка позиции объекта
; In:
;   IX - указывает на структуру FVector
;   HL - знаковое значение оси X
;   DE - знаковое значение оси Y
;   BC - знаковое значение оси Z
; Out:
; Corrupt:
; Note:
;   младшее слово fixed-point 18:14 обнулено
; -----------------------------------------
SetLocation:    ; установка значений
                LD (IX + FVector.X.L.L), #00
                LD (IX + FVector.X.L.H), #00
                LD (IX + FVector.X.H.L), L
                LD (IX + FVector.X.H.H), H

                LD (IX + FVector.Y.L.L), #00
                LD (IX + FVector.Y.L.H), #00
                LD (IX + FVector.Y.H.L), E
                LD (IX + FVector.Y.H.H), D

                LD (IX + FVector.Z.L.L), #00
                LD (IX + FVector.Z.L.H), #00
                LD (IX + FVector.Z.H.L), C
                LD (IX + FVector.Z.H.H), B

                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_LOCATION_
