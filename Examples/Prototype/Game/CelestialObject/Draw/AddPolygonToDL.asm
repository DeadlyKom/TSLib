
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_MESH_ADD_POLYGON_TO_DL_
                define _GAME_CELESTIAL_OBJECT_DRAW_MESH_ADD_POLYGON_TO_DL_
; -----------------------------------------
; добавление полигона в список DL
; In :
; Out :
; Corrupt :
; Note:
; -----------------------------------------
AddPolygonToDL: 

                FT_VertexFormat 0

                FT_Begin FT_LINE_STRIP
                
                LD BC, (Utils.Mesh.Primitive.VertexA.X)
                PUSH BC
                LD DE, (Utils.Mesh.Primitive.VertexA.Y)
                PUSH DE
                CALL FT.Coprocessor.Vertex2f

                LD BC, (Utils.Mesh.Primitive.VertexB.X)
                LD DE, (Utils.Mesh.Primitive.VertexB.Y)
                CALL FT.Coprocessor.Vertex2f

                LD BC, (Utils.Mesh.Primitive.VertexC.X)
                LD DE, (Utils.Mesh.Primitive.VertexC.Y)
                CALL FT.Coprocessor.Vertex2f

                LD BC, (Utils.Mesh.Primitive.VertexD.X)
                LD DE, (Utils.Mesh.Primitive.VertexD.Y)
                CALL FT.Coprocessor.Vertex2f

                POP DE
                POP BC
                CALL FT.Coprocessor.Vertex2f

                FT_End

                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_MESH_ADD_POLYGON_TO_DL_
