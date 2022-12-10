
                ifndef _STRUCTURE_VERTEX_INCLUDE_
                define _STRUCTURE_VERTEX_INCLUDE_

                struct FVertex
Position        FPosition       ZERO_POSITION                                   ; 6 байт
Color           FColor          COLOR_BLACK                                     ; 4 байта
TexCoord        FWordVector2D   ZERO_VECTOR                                     ; 4 байта
Dummy           DW #0000                                                        ; 2 байта (выравнивание по 16 байтам на 1 вершину)

                ends

                endif ; ~_STRUCTURE_VERTEX_INCLUDE_
