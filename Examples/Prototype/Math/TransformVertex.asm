
                ifndef _GAME_MATH_CALCULATE_VERTEX_
                define _GAME_MATH_CALCULATE_VERTEX_
; -----------------------------------------
; преобразование вершины
; In :
;   IY - адрес вершины FVertex
; Out :
;   HL - X в экранных координатах
;   DE - Y в экранных координатах
; Corrupt :
; Note:
; -----------------------------------------
TransformVertex:
                ; ---------------------------------------------
.Rotate         ; вращение вершины
                ; ---------------------------------------------

                ; востановление значения адреса матрицы вращения
                LD IX, (Utils.Mesh.Primitive.MatrixPtr)
                CALL Math.MatrixByVectorT

                ; ---------------------------------------------
.Scale          ; применение маштабирования
                ; ---------------------------------------------

                PUSH BC                                                         ; сохранение значения Z fixed-point 2.14
                PUSH DE                                                         ; сохранение значения Y fixed-point 2.14

                LD A, (Utils.Mesh.Primitive.Scale)
                LD C, A

                ; значение X
                ADD A, #03
                LD B, A
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.X.L), DE
                LD (Utils.Mesh.Primitive.Location.X.H), HL

                ; значение Y
                LD A, C
                ADD A, #03
                LD B, A
                POP HL                                                          ; востановление значения Y fixed-point 2.14
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.Y.L), DE
                LD (Utils.Mesh.Primitive.Location.Y.H), HL

                ; значение Z
                LD B, #02
                POP HL                                                          ; востановление значения Z fixed-point 2.14
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.Z.L), DE
                LD (Utils.Mesh.Primitive.Location.Z.H), HL

                ; ---------------------------------------------
.Offset         ; смещение вершин
                ; ---------------------------------------------

                ; проверкак добавления смещения
                LD A, (Utils.Mesh.Primitive.Flags)
                BIT NO_LOCATION_BIT, A
                JR NZ, .SkipLocation

                ; востановление значения адреса положения объекта
                LD IX, (Utils.Mesh.Primitive.LocationPtr)

.SkipLocation   ; метка пропуска смещения

                ; ---------------------------------------------
                ; преобразование 3D в 2D (перспектива)
                ; ---------------------------------------------

                JP Math.PerspectiveProj

                endif ; ~_GAME_MATH_CALCULATE_VERTEX_
