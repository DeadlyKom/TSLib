
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
                define _GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
; -----------------------------------------
; обработка прямоугольника
; In :
;   BC   - указывает на FMesh.IndexBuffer
;   A'   - значение FSpaceObject.Classification
;   SP-2 - матрица вращение
;   SP-4 - положение объекта
; Out :
; Corrupt :
; Note:
; -----------------------------------------
Quad:           ; чтение FFace
                CALL Utils.Mesh.ReadFace

                ; чтение индексы вершин
                LD A, (BC)
                INC BC

                ; расчёт адреса 
                CALL Utils.Mesh.GetVertex

                ; 
                PUSH HL
                EXX
                POP IY

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
                LD B, A
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.X.L), DE
                LD (Utils.Mesh.Primitive.Location.X.H), HL

                ; значение Y
                LD B, C
                POP HL                                                          ; востановление значения Y fixed-point 2.14
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.Y.L), DE
                LD (Utils.Mesh.Primitive.Location.Y.H), HL

                ; значение Z
                LD B, C
                POP HL                                                          ; востановление значения Z fixed-point 2.14
                CALL Math.Fixed_214.SL
                LD (Utils.Mesh.Primitive.Location.Z.L), DE
                LD (Utils.Mesh.Primitive.Location.Z.H), HL

                ; ---------------------------------------------
.Offset         ; смещение вершины
                ; ---------------------------------------------

                ; проверкак добавления смещения
                LD A, (Utils.Mesh.Primitive.Flags)
                BIT NO_LOCATION_BIT, A
                JR Z, .SkipLocation

                ; востановление значения адреса положения объекта
                LD IX, (Utils.Mesh.Primitive.LocationPtr)

.SkipLocation   ; метка пропуска смещения

                ; ---------------------------------------------
                ; 
                ; ---------------------------------------------

                CALL Math.PerspectiveProj

                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
