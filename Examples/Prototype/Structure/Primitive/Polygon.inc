
                ifndef _STRUCTURE_POLYGON_INCLUDE_
                define _STRUCTURE_POLYGON_INCLUDE_

                struct FPolygon
Index           DB #00                                                          ; индекс 1-ой вершины
                DB #00                                                          ; индекс 2-ой вершины
                DB #00                                                          ; индекс 3-ей вершины
                DB #00                                                          ; смещение к следующему приметиву
                DB #00                                                          ; индекс 5-ой вершины
                DB #00                                                          ; индекс 6-ой вершины

                ends

                endif ; ~_STRUCTURE_POLYGON_INCLUDE_
