
                ifndef _GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
                define _GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
; -----------------------------------------
; вращение точки относительно центра системы координат
; In :
;   HL - указатель FVector
;   DE - указатель FRotator
; Out :
;   FVector хранит результат операции вращения
; Corrupt :
; Note:
;
;   1. K2 = y - alpha * x
;   2. z = z + beta * K2
;   3. y = K2 - beta * z
;   4. x = x + alpha * y
;
;   alpha - roll
;   beta  - pitch
;
;   https://www.bbcelite.com/deep_dives/rotating_the_universe.html
; -----------------------------------------
RotateLocation: ;
                
                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
