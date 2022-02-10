
                ifndef _STRUCTURE_PRIMITIVE_INCLUDE_
                define _STRUCTURE_PRIMITIVE_INCLUDE_
PRIM_POINTS     EQU #01 | #80
PRIM_LINES      EQU #02 | #80
PRIM_TIANGLES   EQU #03 | #80
PRIM_QUADS      EQU #04 | #80
PRIM_POLYGON    EQU #05 | #80
PRIM_END        EQU #FF

                include "Point.inc"
                include "Line.inc"
                include "Triangle.inc"
                include "Quad.inc"
                include "Polygon.inc"

                endif ; ~_STRUCTURE_PRIMITIVE_INCLUDE_
