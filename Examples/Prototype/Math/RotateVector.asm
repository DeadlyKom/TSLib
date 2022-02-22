
                ifndef _GAME_MATH_ROTATE_VECTOR_
                define _GAME_MATH_ROTATE_VECTOR_
; -----------------------------------------
; roll вращение вектора относительно центра системы координат
; In :
;   IX - указатель FVectorHalf
;   IY - указатель FRotator
; Out :
; Corrupt :
; Note:
;   roll calculations:
;       y = y - roll * x
;       x = x + roll * y
;
;   https://www.bbcelite.com/deep_dives/pitching_and_rolling.html
; -----------------------------------------
RotateRoll:     ; ---------------------------------------------
                ; y = y - alpha * x
                ; ---------------------------------------------

                ; HL = roll * x
                LD C, (IX + FVectorHalf.X.L)
                LD B, (IX + FVectorHalf.X.H)
                PUSH BC                                                         ; сохранение x
                LD E, (IY + FRotator.Roll.L)
                LD D, (IY + FRotator.Roll.H)
                PUSH DE                                                         ; сохранение roll
                CALL Math.Fixed_214.MULS

                ; HL = y - roll * x
                EX DE, HL
                LD L, (IX + FVectorHalf.Y.L)
                LD H, (IX + FVectorHalf.Y.H)
                CALL Math.Fixed_214.SUB

                ; сохранение результата -> y = y - roll * x
                LD (IX + FVectorHalf.Y.L), L
                LD (IX + FVectorHalf.Y.H), H

                ; ---------------------------------------------
                ; x = x + alpha * y
                ; ---------------------------------------------

                ; HL = roll * y
                POP BC                                                          ; востановление roll
                EX DE, HL
                CALL Math.Fixed_214.MULS

                ; HL = x + roll * y
                POP DE                                                          ; востановление x
                CALL Math.Fixed_214.ADD

                ; сохранение результата -> x = x + roll * y
                LD (IX + FVectorHalf.X.L), L
                LD (IX + FVectorHalf.X.H), H

                RET

; -----------------------------------------
; pitch вращение вектора относительно центра системы координат
; In :
;   IX - указатель FVectorHalf
;   IY - указатель FRotator
; Out :
; Corrupt :
; Note:
;   pitch calculations:
;       y = y - pitch * z
;       z = z + pitch * y
;
;   https://www.bbcelite.com/deep_dives/pitching_and_rolling.html
; -----------------------------------------
RotatePitch:    ; ---------------------------------------------
                ; y = y - pitch * z
                ; ---------------------------------------------

                ; HL = pitch * z
                LD C, (IX + FVectorHalf.Z.L)
                LD B, (IX + FVectorHalf.Z.H)
                PUSH BC                                                         ; сохранение z
                LD E, (IY + FRotator.Pitch.L)
                LD D, (IY + FRotator.Pitch.H)
                PUSH DE                                                         ; сохранение pitch
                CALL Math.Fixed_214.MULS

                ; HL = y - pitch * z
                EX DE, HL
                LD L, (IX + FVectorHalf.Y.L)
                LD H, (IX + FVectorHalf.Y.H)
                CALL Math.Fixed_214.SUB

                ; сохранение результата -> y = y - pitch * z
                LD (IX + FVectorHalf.Y.L), L
                LD (IX + FVectorHalf.Y.H), H

                ; ---------------------------------------------
                ; z = z + pitch * y
                ; ---------------------------------------------

                ; HL = pitch * y
                POP BC                                                          ; востановление pitch
                EX DE, HL
                CALL Math.Fixed_214.MULS

                ; HL = z + pitch * y
                POP DE                                                          ; востановление z
                CALL Math.Fixed_214.ADD

                ; сохранение результата -> z = z + pitch * y
                LD (IX + FVectorHalf.Z.L), L
                LD (IX + FVectorHalf.Z.H), H

                RET

                endif ; ~_GAME_MATH_ROTATE_VECTOR_
