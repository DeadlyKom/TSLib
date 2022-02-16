
                ifndef _GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
                define _GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
; -----------------------------------------
; вращение точки относительно центра системы координат
; In :
;   IX - указатель FVector
;   IY - указатель FRotator
; Out :
;   FVector хранит результат операции вращения
; Corrupt :
; Note:
;
;   A. K2 = y - roll * x
;   B. z = z + pitch * K2
;   C. y = K2 - pitch * z
;   D. x = x + roll * y
;
;   https://www.bbcelite.com/deep_dives/rotating_the_universe.html
; -----------------------------------------
RotateLocation: ; ---------------------------------------------
.A              ; K2 = y - roll * x
                ; ---------------------------------------------

                ; HLHL' = roll * x
                EXX
                LD L, (IX + FVector.X.L.L)
                LD H, (IX + FVector.X.L.H)
                EXX
                LD L, (IX + FVector.X.H.L)
                LD H, (IX + FVector.X.H.H)
                LD E, (IX + FRotator.Roll.L)
                LD D, (IX + FRotator.Roll.H)
                PUSH DE                                                         ; сохранение roll

                CALL Math.Fixed_1814.MULS

                ; HLHL' = y - roll * x
                EXX
                LD E, (IX + FVector.Y.L.L)
                LD D, (IX + FVector.Y.L.H)
                EX DE, HL
                EXX
                LD E, (IX + FVector.Y.H.L)
                LD D, (IX + FVector.Y.H.H)
                EX DE, HL
                CALL Math.Fixed_1814.SUB

                ; сохранение результата -> K2
                PUSH HL                                                         ; сохранение K2 старшее значение
                EXX
                PUSH HL                                                         ; сохранение K2 младшее значение
                EXX

                ; ---------------------------------------------
.B              ; z = z + pitch * K2
                ; ---------------------------------------------

                ; HLHL' = pitch * K2
                LD E, (IX + FRotator.Pitch.L)
                LD D, (IX + FRotator.Pitch.H)
                PUSH DE                                                         ; сохранение pitch
                CALL Math.Fixed_1814.MULS

                ; HLHL' = z + pitch * K2
                EXX
                LD E, (IX + FVector.Z.L.L)
                LD D, (IX + FVector.Z.L.H)
                EXX
                LD E, (IX + FVector.Z.H.L)
                LD D, (IX + FVector.Z.H.H)
                CALL Math.Fixed_1814.ADD

                ; сохранение результата -> z = z + pitch * K2
                LD (IX + FVector.Z.H.L), L
                LD (IX + FVector.Z.H.H), H
                EXX
                LD (IX + FVector.Z.L.L), L
                LD (IX + FVector.Z.L.H), H
                EXX

                ; ---------------------------------------------
.C              ; y = K2 - pitch * z
                ; ---------------------------------------------

                ; HLHL' = pitch * z
                POP DE                                                          ; востановление pitch
                CALL Math.Fixed_1814.MULS

                ; HLHL' = K2 - pitch * z
                EXX
                POP DE                                                          ; востановление K2 младшее значение
                EX DE, HL
                EXX
                POP DE                                                          ; востановление K2 старшее значение
                EX DE, HL
                CALL Math.Fixed_1814.SUB

                ; сохранение результата -> y = K2 - pitch * z
                LD (IX + FVector.Y.H.L), L
                LD (IX + FVector.Y.H.H), H
                EXX
                LD (IX + FVector.Y.L.L), L
                LD (IX + FVector.Y.L.H), H
                EXX

                ; ---------------------------------------------
.D              ; x = x + roll * y
                ; ---------------------------------------------

                ; HLHL' = roll * y
                POP DE                                                          ; востановление roll
                CALL Math.Fixed_1814.MULS

                ; HLHL' = x + roll * y
                EXX
                LD E, (IX + FVector.X.L.L)
                LD D, (IX + FVector.X.L.H)
                EXX
                LD E, (IX + FVector.X.H.L)
                LD D, (IX + FVector.X.H.H)
                CALL Math.Fixed_1814.ADD

                ; сохранение результата -> x = x + roll * y
                LD (IX + FVector.X.H.L), L
                LD (IX + FVector.X.H.H), H
                EXX
                LD (IX + FVector.X.L.L), L
                LD (IX + FVector.X.L.H), H
                EXX
.E              ; ---------------------------------------------
                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_MATH_ROTATE_LOCATION_
