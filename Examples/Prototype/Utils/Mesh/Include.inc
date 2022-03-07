
                ifndef _UTILS_MESH_INCLUDE_
                define _UTILS_MESH_INCLUDE_

                module Mesh

                include "ReadFace.asm"
                include "NextFace.asm"
                include "GetVertexAddress.asm"
Primitive:
.MatrixPtr      DW #0000
.LocationPtr    DW #0000
.Location       FVector
.Scale          DB #00
; .CountPolygon   DB #00
; .PolygonFlags   DB #00
.Flags          DB #00
.Queue          DB #00
.Normal         DB #00
; .Color          FColor
.VertexA        FVector2D
.VertexB        FVector2D
.VertexC        FVector2D
.VertexD        FVector2D
; .VertexE        FVector2D
.Tmp            DB #00

                endmodule

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_MESH_INCLUDE_
