
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_MATRIX_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_MATRIX_
; -----------------------------------------
; установка матрицы
; In:
;   IX - указывает на структуру FMatrix
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetMatrix:      RET

; -----------------------------------------
; установка еденичной матрицы поворота
; In:
;   IX - указывает на структуру FMatrix
; Out:
; Corrupt:
; Note:
;   M0 - RightVector   FVector( 1,  0,  0)
;   M1 - UpVector      FVector( 0,  1,  0)
;   M2 - ForwardVector FVrctor(-0, -0, -1)
; -----------------------------------------
.Identity       ; установка строки M2
                LD HL, #8000
                LD DE, #8000
                LD BC, #C000
                CALL .SetRow_M2

                ; установка строки M1
                LD HL, #0000
                LD DE, #4000
                LD BC, #0000
                CALL .SetRow_M1

                ; установка строки M0
                LD HL, #4000
                LD DE, #0000
                LD BC, #0000

.SetRow_M0      LD (IX + FMatrix.M0.X.L), L
                LD (IX + FMatrix.M0.X.H), H
                LD (IX + FMatrix.M0.Y.L), E
                LD (IX + FMatrix.M0.Y.H), D
                LD (IX + FMatrix.M0.Z.L), C
                LD (IX + FMatrix.M0.Z.H), B
                RET

.SetRow_M1      LD (IX + FMatrix.M1.X.L), L
                LD (IX + FMatrix.M1.X.H), H
                LD (IX + FMatrix.M1.Y.L), E
                LD (IX + FMatrix.M1.Y.H), D
                LD (IX + FMatrix.M1.Z.L), C
                LD (IX + FMatrix.M1.Z.H), B
                RET

.SetRow_M2      LD (IX + FMatrix.M2.X.L), L
                LD (IX + FMatrix.M2.X.H), H
                LD (IX + FMatrix.M2.Y.L), E
                LD (IX + FMatrix.M2.Y.H), D
                LD (IX + FMatrix.M2.Z.L), C
                LD (IX + FMatrix.M2.Z.H), B
                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_MATRIX_
