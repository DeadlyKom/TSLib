
                ifndef _STRUCTURE_PRIMITIVE_INCLUDE_
                define _STRUCTURE_PRIMITIVE_INCLUDE_
PRIMITIVE_BIT   EQU 0x07                                                        ; флаг пренодлежности примитива
PRIMITIVE       EQU 1 << PRIMITIVE_BIT
PRIM_POINTS     EQU #00 | PRIMITIVE
PRIM_LINES      EQU #01 | PRIMITIVE
PRIM_TIANGLES   EQU #02 | PRIMITIVE
PRIM_QUADS      EQU #03 | PRIMITIVE
PRIM_POLYGON    EQU #04 | PRIMITIVE
PRIM_END        EQU #FF

                include "Point.inc"
                include "Line.inc"
                include "Triangle.inc"
                include "Quad.inc"
                include "Polygon.inc"

                endif ; ~_STRUCTURE_PRIMITIVE_INCLUDE_
