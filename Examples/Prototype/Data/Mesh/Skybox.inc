
                ifndef _MESH_SKYBOX_
                define _MESH_SKYBOX_
MeshSkybox:
.Vertexes       EQU $                                   
                FVertex Fix.n16384_neg, Fix.n16384,     Fix.n16384,     COLOR_BLACK, ZERO_VECTOR    ; 0 (-1.0,  1.0,  1.0)
                FVertex Fix.n16384_neg, Fix.n16384,     Fix.n16384_neg, COLOR_BLACK, ZERO_VECTOR    ; 1 (-1.0,  1.0, -1.0)
                FVertex Fix.n16384,     Fix.n16384,     Fix.n16384_neg, COLOR_BLACK, ZERO_VECTOR    ; 2 ( 1.0,  1.0, -1.0)
                FVertex Fix.n16384,     Fix.n16384,     Fix.n16384,     COLOR_BLACK, ZERO_VECTOR    ; 3 ( 1.0,  1.0,  1.0)
                FVertex Fix.n16384_neg, Fix.n16384_neg, Fix.n16384,     COLOR_BLACK, ZERO_VECTOR    ; 4 (-1.0, -1.0,  1.0)
                FVertex Fix.n16384_neg, Fix.n16384_neg, Fix.n16384_neg, COLOR_BLACK, ZERO_VECTOR    ; 5 (-1.0, -1.0, -1.0)
                FVertex Fix.n16384,     Fix.n16384_neg, Fix.n16384_neg, COLOR_BLACK, ZERO_VECTOR    ; 6 ( 1.0, -1.0, -1.0)
                FVertex Fix.n16384,     Fix.n16384_neg, Fix.n16384,     COLOR_BLACK, ZERO_VECTOR    ; 7 ( 1.0, -1.0,  1.0)
.VertexNum      EQU ($-.Vertexes) / 6

.Normals:       EQU $
                FNormal Fix.n0,         Fix.n0,         Fix.n16384_neg          ; 0 ( 0,  0, -1)
                FNormal Fix.n0,         Fix.n16384_neg, Fix.n0                  ; 1 ( 0, -1,  0)
                FNormal Fix.n16384,     Fix.n0,         Fix.n0                  ; 2 ( 1,  0,  0)
                FNormal Fix.n0,         Fix.n16384,     Fix.n0                  ; 3 ( 0,  1,  0)
                FNormal Fix.n16384_neg, Fix.n0,         Fix.n0                  ; 4 (-1,  0,  0)
                FNormal Fix.n0,         Fix.n0,         Fix.n16384              ; 5 ( 0,  0,  1)
.NormalNum      EQU ($-.Normals) / 6

.Faces          EQU $
                FFace {
                    PRIM_QUADS,                                                 ; тип примитива - прямоугольник
                    1,
                    0                                                           ; индекс нормали
                }
.Face1          FPolygon 0, 1, 2, .FaceOffset2, 3
.FaceOffset2    EQU ($-.Face1-4)
                FFace PRIM_QUADS, 1, 1
.Face2          FPolygon 3, 2, 6, .FaceOffset3, 7
.FaceOffset3    EQU ($-.Face2-4)
                FFace PRIM_QUADS, 1, 2
.Face3          FPolygon 0, 3, 7, .FaceOffset4, 4
.FaceOffset4    EQU ($-.Face3-4)
                FFace PRIM_QUADS, 1, 3
.Face4          FPolygon 0, 4, 5, .FaceOffset5, 1
.FaceOffset5    EQU ($-.Face4-4)
                FFace PRIM_QUADS, 1, 4
.Face5          FPolygon 1, 5, 6, .FaceOffset6, 2
.FaceOffset6    EQU ($-.Face5-4)
                FFace PRIM_QUADS, 1, 5
.Face6          FPolygon 4, 7, 6, #FF, 5
                DB PRIM_END

.Scale          EQU #01
.Handle         EQU #01

                endif ; ~_MESH_SKYBOX_
