
                ifndef _MESH_DODEC_
                define _MESH_DODEC_
Skybox:
.Vertexes       EQU $
                FVectorHalf Fix.n0,         Fix.n9600,      Fix.n12544
                FVectorHalf Fix.n9152,      Fix.n2944,      Fix.n12544
                FVectorHalf Fix.n5632,      Fix.n7744_neg,  Fix.n12544
                FVectorHalf Fix.n5632_neg,  Fix.n7744_neg,  Fix.n12544
                FVectorHalf Fix.n9152_neg,  Fix.n2944,      Fix.n12544
                FVectorHalf Fix.n0,         Fix.n15552,     Fix.n2944
                FVectorHalf Fix.n14784,     Fix.n4800,      Fix.n2944
                FVectorHalf Fix.n9152,      Fix.n12544_neg, Fix.n2944
                FVectorHalf Fix.n9152_neg,  Fix.n12544_neg, Fix.n2944
                FVectorHalf Fix.n14784_neg, Fix.n4800,      Fix.n2944
                FVectorHalf Fix.n9152,      Fix.n12544,     Fix.n2944_neg
                FVectorHalf Fix.n14784,     Fix.n4800_neg,  Fix.n2944_neg
                FVectorHalf Fix.n0,         Fix.n15552_neg, Fix.n2944_neg
                FVectorHalf Fix.n14784_neg, Fix.n4800_neg,  Fix.n2944_neg
                FVectorHalf Fix.n9152_neg,  Fix.n12544,     Fix.n2944_neg
                FVectorHalf Fix.n5632,      Fix.n7744,      Fix.n12544_neg
                FVectorHalf Fix.n9152,      Fix.n2944_neg,  Fix.n12544_neg
                FVectorHalf Fix.n0,         Fix.n9600_neg,  Fix.n12544_neg
                FVectorHalf Fix.n9152_neg,  Fix.n2944_neg,  Fix.n12544_neg
                FVectorHalf Fix.n5632_neg,  Fix.n7744,      Fix.n12544_neg
                FVectorHalf Fix.n512_neg,   Fix.n2048,      Fix.n12544
                FVectorHalf Fix.n512_neg,   Fix.n2048_neg,  Fix.n12544
                FVectorHalf Fix.n512,       Fix.n2048,      Fix.n12544
                FVectorHalf Fix.n512,       Fix.n2048_neg,  Fix.n12544
.VertexNum      EQU ($-.Vertexes) / 6

.Normals:       EQU $
                FNormal     %0000000000000000, %0000000000000000, %0100000000000000 ; (0, 0, 1)
                FNormal     %0010000110010111, %0010111001001110, %0001110010110010 ; (0.524820745, 0.723539293, 0.448390573)
                FNormal     %0011011001101011, %1001000110110110, %0001110010101000 ; (0.850255966, -0.276710540, 0.447767943)
                FNormal     %0000000000000000, %1011100100111110, %0001110010011111 ; (0, -0.894427180, 0.447213590)
                FNormal     %1011011001101011, %1001000110110110, %0001110010101000 ; (-0.850255966, -0.276710540, 0.447767943)
                FNormal     %0010000110010111, %0010111001001110, %0001110010110010 ; (-0.524820745, 0.723539293, 0.448390573)
                FNormal     %0000000000000000, %0011100100111110, %1001110010011111 ; (0, 0.894427180, -0.447213590)
                FNormal     %0011011001101011, %0001000110110110, %1001110010101000 ; (0.850255966, 0.276710540, -0.447767943)
                FNormal     %0010000110010111, %1010111001001110, %1001110010110010 ; (0.524820745, -0.723539293, -0.448390573)
                FNormal     %1010000110010111, %1010111001001110, %1001110010110010 ; (-0.524820745, -0.723539293, -0.448390573)
                FNormal     %1011011001101011, %0001000110110110, %1001110010101000 ; (-0.850255966, 0.276710540, -0.447767943)
                FNormal     %0000000000000000, %0000000000000000, %1100000000000000 ; (0, 0, -1)
.NormalNum      EQU ($-.Normals) / 6

.Faces          EQU $
                FFace PRIM_POLYGON, 1, COLOR_BLACK
.Face1          FPolygon 0, 1, 2, .FaceOffset2, 3, 4
.FaceOffset2    EQU ($-.Face1-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face2          FPolygon 6, 1, 0, .FaceOffset3, 5, 10
.FaceOffset3    EQU ($-.Face2-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face3          FPolygon 7, 2, 1, .FaceOffset4, 6, 11
.FaceOffset4    EQU ($-.Face3-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face4          FPolygon 8, 3, 2, .FaceOffset5, 7, 12
.FaceOffset5    EQU ($-.Face4-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face5          FPolygon 9, 4, 3, .FaceOffset6, 8, 13
.FaceOffset6    EQU ($-.Face5-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face6          FPolygon 5, 0, 4, .FaceOffset7, 9, 14
.FaceOffset7    EQU ($-.Face6-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face7          FPolygon 19, 15, 10, .FaceOffset8, 5, 14
.FaceOffset8    EQU ($-.Face7-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face8          FPolygon 15, 16, 11, .FaceOffset9, 6, 10
.FaceOffset9    EQU ($-.Face8-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face9          FPolygon 16, 17, 12, .FaceOffset10, 7, 11
.FaceOffset10   EQU ($-.Face9-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face10         FPolygon 17, 18, 13, .FaceOffset11, 8, 12
.FaceOffset11   EQU ($-.Face10-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face11         FPolygon 18, 19, 14, .FaceOffset12, 9, 13
.FaceOffset12   EQU ($-.Face11-4)
                FFace PRIM_POLYGON, 1, #FF, #FF, #FF
.Face12         FPolygon 19, 18, 17, #FF, 16, 15
                DB PRIM_END

                endif ; ~_MESH_DODEC_
