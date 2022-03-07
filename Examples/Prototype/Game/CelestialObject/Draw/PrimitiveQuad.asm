
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
                define _GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
; -----------------------------------------
; обработка прямоугольника
; In :
;   BC   - указывает на FMesh.IndexBuffer
;   A'   - значение FSpaceObject.Classification
; Out :
; Corrupt :
; Note:
; -----------------------------------------
Quad:           ; чтение FFace
                CALL Utils.Mesh.ReadFace

                ; ---------------------------------------------
.Transform_A    ; реобразование вершины A
                ; ---------------------------------------------

                ; чтение индексы вершин
                LD A, (BC)
                INC BC

                ; расчёт адреса 
                CALL Utils.Mesh.GetVertex

                ; применение
                PUSH HL
                EXX
                POP IY
                CALL Math.TransformVertex
                LD (Utils.Mesh.Primitive.VertexA.X), HL                         ; HL - A.x
                LD (Utils.Mesh.Primitive.VertexA.Y), DE                         ; DE - A.y
                EXX

                ; ---------------------------------------------
.Transform_B    ; реобразование вершины B
                ; ---------------------------------------------

                ; чтение индексы вершин
                LD A, (BC)
                INC BC

                ; расчёт адреса 
                CALL Utils.Mesh.GetVertex

                ; применение
                PUSH HL
                EXX
                POP IY
                CALL Math.TransformVertex
                LD (Utils.Mesh.Primitive.VertexB.X), HL                         ; HL - B.x
                LD (Utils.Mesh.Primitive.VertexB.Y), DE                         ; DE - B.y
                EXX

                ; ---------------------------------------------
.Transform_C    ; реобразование вершины C
                ; ---------------------------------------------

                ; чтение индексы вершин
                LD A, (BC)
                INC BC

                ; расчёт адреса 
                CALL Utils.Mesh.GetVertex

                ; применение
                PUSH HL
                EXX
                POP IY
                CALL Math.TransformVertex
                LD (Utils.Mesh.Primitive.VertexC.X), HL                         ; HL - C.x
                LD (Utils.Mesh.Primitive.VertexC.Y), DE                         ; DE - C.y

                ; ---------------------------------------------
.CrossProduct   ; проверка видимости полигона
                ; ---------------------------------------------

                CALL Math.CrossProduct2D
                EXX
                ; JP M, Utils.Mesh.NextFace                                       ; результат отрицательный (примитив не видим)
                INC BC

                ; ---------------------------------------------
.Transform_D    ; реобразование вершины D
                ; ---------------------------------------------

                ; чтение индексы вершин
                LD A, (BC)
                INC BC

                ; расчёт адреса 
                CALL Utils.Mesh.GetVertex

                ; применение
                PUSH HL
                EXX
                POP IY
                CALL Math.TransformVertex
                LD (Utils.Mesh.Primitive.VertexD.X), HL                         ; HL - D.x
                LD (Utils.Mesh.Primitive.VertexD.Y), DE                         ; DE - D.y

                CALL AddPolygonToDL

                EXX
                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_MESH_PRIMITIVE_QUAD_
