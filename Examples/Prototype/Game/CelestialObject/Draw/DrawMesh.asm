
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_PRIMITIVE_
                define _GAME_CELESTIAL_OBJECT_DRAW_PRIMITIVE_
; -----------------------------------------
; рисование примитива
; In :
;   IX - указатель FMatrix
;   IY - указатель FCelestialData
;   A' - значение FSpaceObject.Classification
; Out :
; Corrupt :
; Note:
; -----------------------------------------
Mesh:           
                ; инициализация адреса вершин меша
                LD HL, (IY + FCelestialData.Mesh.VertexBuffer)
                LD (Utils.Mesh.GetVertex.Buffer), HL

                ;
                LD BC, (IY + FCelestialData.Mesh.IndexBuffer)

                ; инициализация маштаба
                LD A, (IY + FCelestialData.Mesh.Scale)
                LD (Utils.Mesh.Primitive.Scale), A

.Loop           ;
                LD A, (BC)

                ; адрес обработки следующего примитива
                LD HL, .Next
                PUSH HL

                ; переход к обработчу примитива
                LD HL, .JumpTable
                ADD A, A
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL
                JP (HL)

.Next           ;
                JR .Loop

.RET            POP HL
                RET

.JumpTable      DW #0000                                                        ; PRIM_POINTS
                DW #0000                                                        ; PRIM_LINES
                DW #0000                                                        ; PRIM_TIANGLES
                DW Quad                                                         ; PRIM_QUADS
                DW #0000                                                        ; PRIM_POLYGON
                DW .RET                                                         ; PRIM_END

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_PRIMITIVE_
