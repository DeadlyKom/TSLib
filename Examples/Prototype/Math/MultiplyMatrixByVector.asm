
                ifndef _GAME_MATH_MULTIPLY_MATRIX_BY_VECTOR_
                define _GAME_MATH_MULTIPLY_MATRIX_BY_VECTOR_
; -----------------------------------------
; умножение матрицы на вектор поворота после транспонирования
; In :
;   IX - указатель на матрицу FMatrix
;   IY - указатель на вектор FVectorHalf
; Out :
;   HL - X
;   DE - Y
;   BC - Z
; Corrupt :
; Note:
;   умножение применяется с транспонированием матрицы
; | A B C |     | A D G |       |  right.x   right.y   right.z  |       | right.x  up.x  forward.x |
; | D E F | = > | B E H |  i.e. |    up.x     up.y      up.z    |   =>  | right.y  up.y  forward.y |
; | G H I |     | C F I |       | forward.x forward.y forward.z |       | right.z  up.z  forward.z |
;
;   multiply matrix by vector:
;       X = (V.x * MV[0].x) + (V.y * MV[0].y) + (V.z * MV[0].z)
;       Y = (V.x * MV[1].x) + (V.y * MV[1].y) + (V.z * MV[1].z)
;       Z = (V.x * MV[2].x) + (V.y * MV[2].y) + (V.z * MV[2].z)
;
;   multiply matrix by vector after transpose:
;       X = (V.x * MV[0].x) + (V.y * MV[1].x) + (V.z * MV[2].x)
;       Y = (V.x * MV[0].y) + (V.y * MV[1].y) + (V.z * MV[2].y)
;       Z = (V.x * MV[0].z) + (V.y * MV[1].z) + (V.z * MV[2].z)
; -----------------------------------------
MatrixByVectorT:

                ; ---------------------------------------------
.Column_MV_0    ; MV[0]
                ; ---------------------------------------------

                ; V.x * MV[0].x
                LD C, (IX + FMatrix.MV0.X.L)
                LD B, (IX + FMatrix.MV0.X.H)
                LD E, (IY + FVectorHalf.X.L)
                LD D, (IY + FVectorHalf.X.H)
                PUSH DE                                                         ; сохранение V.x
                CALL Math.Fixed_214.MULS
                LD (.Vx_MV_0x), HL                                              ; сохранение V.x * MV[0].x

                ; V.x * MV[0].y
                LD C, (IX + FMatrix.MV0.Y.L)
                LD B, (IX + FMatrix.MV0.Y.H)
                POP DE                                                          ; востановление V.x
                PUSH DE                                                         ; сохранение V.x
                CALL Math.Fixed_214.MULS
                LD (.Vx_MV_0y), HL                                              ; сохранение V.x * MV[0].y

                ; V.x * MV[0].z
                LD C, (IX + FMatrix.MV0.Z.L)
                LD B, (IX + FMatrix.MV0.Z.H)
                POP DE                                                          ; востановление V.x
                CALL Math.Fixed_214.MULS
                LD (.Vx_MV_0z), HL                                              ; сохранение V.x * MV[0].z

                ; ---------------------------------------------
.Column_MV_1    ; MV[1]
                ; ---------------------------------------------

                ; V.y * MV[1].x
                LD C, (IX + FMatrix.MV1.X.L)
                LD B, (IX + FMatrix.MV1.X.H)
                LD E, (IY + FVectorHalf.Y.L)
                LD D, (IY + FVectorHalf.Y.H)
                PUSH DE                                                         ; сохранение V.y
                CALL Math.Fixed_214.MULS
                LD (.Vy_MV_1x), HL                                              ; сохранение V.y * MV[1].x

                ; V.y * MV[1].y
                LD C, (IX + FMatrix.MV1.Y.L)
                LD B, (IX + FMatrix.MV1.Y.H)
                POP DE                                                          ; востановление V.y
                PUSH DE                                                         ; сохранение V.y
                CALL Math.Fixed_214.MULS
                LD (.Vy_MV_1y), HL                                              ; сохранение V.y * MV[1].y

                ; V.y * MV[1].z
                LD C, (IX + FMatrix.MV1.Z.L)
                LD B, (IX + FMatrix.MV1.Z.H)
                POP DE                                                          ; востановление V.y
                CALL Math.Fixed_214.MULS
                LD (.Vy_MV_1z), HL                                              ; сохранение V.y * MV[1].z

                ; ---------------------------------------------
.Column_MV_2    ; MV[2]
                ; ---------------------------------------------

                ; V.z * MV[2].x
                LD C, (IX + FMatrix.MV2.X.L)
                LD B, (IX + FMatrix.MV2.X.H)
                LD E, (IY + FVectorHalf.Z.L)
                LD D, (IY + FVectorHalf.Z.H)
                PUSH DE                                                         ; сохранение V.z
                CALL Math.Fixed_214.MULS
                LD (.Vz_MV2_2x), HL                                             ; сохранение V.z * MV[2].x

                ; V.z * MV[2].y
                LD C, (IX + FMatrix.MV2.Y.L)
                LD B, (IX + FMatrix.MV2.Y.H)
                POP DE                                                          ; востановление V.z
                PUSH DE                                                         ; сохранение V.z
                CALL Math.Fixed_214.MULS
                LD (.Vz_MV2_2y), HL                                             ; сохранение V.z * MV[2].y

                ; V.z * MV[2].z
                LD C, (IX + FMatrix.MV2.Z.L)
                LD B, (IX + FMatrix.MV2.Z.H)
                POP DE                                                          ; востановление V.z
                CALL Math.Fixed_214.MULS
                ; LD (.Vz_MV_2z), HL                                              ; сохранение V.z * MV[2].z

                ; ---------------------------------------------
.Z              ; Z = (V.x * MV[0].z) + (V.y * MV[1].z) + (V.z * MV[2].z)
                ; ---------------------------------------------
.Vy_MV_1z       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
.Vx_MV_0z       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
                LD B, H
                LD C, L

                ; ---------------------------------------------
.Y              ; Y = (V.x * MV[0].y) + (V.y * MV[1].y) + (V.z * MV[2].y)
                ; ---------------------------------------------
.Vz_MV2_2y      EQU $+1
                LD DE, #0000
.Vy_MV_1y       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
.Vx_MV_0y       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
                PUSH HL

                ; ---------------------------------------------
.X              ; X = (V.x * MV[0].x) + (V.y * MV[1].x) + (V.z * MV[2].x)
                ; ---------------------------------------------
.Vz_MV2_2x      EQU $+1
                LD DE, #0000
.Vy_MV_1x       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
.Vx_MV_0x       EQU $+1
                LD DE, #0000
                CALL Math.Fixed_214.ADD
                POP DE

                RET        

                endif ; ~_GAME_MATH_MULTIPLY_MATRIX_BY_VECTOR_
