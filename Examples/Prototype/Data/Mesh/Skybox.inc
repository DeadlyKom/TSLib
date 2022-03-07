
                ifndef _MESH_SKYBOX_
                define _MESH_SKYBOX_
MeshSkybox:
.Vertexes       EQU $                                   
                FVertex Fix.n8192_neg, Fix.n8192,     Fix.n8192,    COLOR_BLACK, ZERO_VECTOR    ; 0 (-1.0,  1.0,  1.0)
                FVertex Fix.n8192_neg, Fix.n8192,     Fix.n0,       COLOR_BLACK, ZERO_VECTOR    ; 1 (-1.0,  1.0, -1.0)
                FVertex Fix.n8192,     Fix.n8192,     Fix.n0,       COLOR_BLACK, ZERO_VECTOR    ; 2 ( 1.0,  1.0, -1.0)
                FVertex Fix.n8192,     Fix.n8192,     Fix.n8192,    COLOR_BLACK, ZERO_VECTOR    ; 3 ( 1.0,  1.0,  1.0)
                FVertex Fix.n8192_neg, Fix.n8192_neg, Fix.n8192,    COLOR_BLACK, ZERO_VECTOR    ; 4 (-1.0, -1.0,  1.0)
                FVertex Fix.n8192_neg, Fix.n8192_neg, Fix.n0,       COLOR_BLACK, ZERO_VECTOR    ; 5 (-1.0, -1.0, -1.0)
                FVertex Fix.n8192,     Fix.n8192_neg, Fix.n0,       COLOR_BLACK, ZERO_VECTOR    ; 6 ( 1.0, -1.0, -1.0)
                FVertex Fix.n8192,     Fix.n8192_neg, Fix.n8192,    COLOR_BLACK, ZERO_VECTOR    ; 7 ( 1.0, -1.0,  1.0)
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
                FFace { PRIM_QUADS, 1, 0 }  ; !
.Face1          FQuad 0, 3, 7, 2, 4

                FFace { PRIM_QUADS, 1, 1 }
.Face2          FQuad 3, 2, 6, 2, 7

                FFace { PRIM_QUADS, 1, 2 }
.Face3          FQuad 1, 0, 4, 2, 5

                FFace { PRIM_QUADS, 1, 3 }
.Face4          FQuad 0, 1, 2, 2, 3

                FFace { PRIM_QUADS, 1, 4 }
.Face5          FQuad 4, 7, 6, 2, 5

                FFace { PRIM_QUADS, 1, 5 }  ; !
.Face6          FQuad 1, 5, 6, 2, 2

                DB PRIM_END

.Scale          EQU #05
.Handle         EQU #01

                endif ; ~_MESH_SKYBOX_
