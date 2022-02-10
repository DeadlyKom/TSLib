
                ifndef _STRUCTURE_CELESTIAL_OBJECT_INCLUDE_
                define _STRUCTURE_CELESTIAL_OBJECT_INCLUDE_

                struct FCelestialNode
Classification  DB #00                                                          ; тип объекта
Location        FVector                                                         ; расположение объекта в пространстве 18:14
MatrixRot       FMatrix                                                         ; матрица вращения объекта
Rotation        FVectorHalf                                                     ; вращение объекта
Velocity        DW #0000                                                        ; скорость объекта
Acceleration	DW #0000                                                        ; ускорение объекта
Flags			DW #0000                                                        ;
Data            FCelestialData                                                  ;

                ends

                endif ; ~_STRUCTURE_CELESTIAL_OBJECT_INCLUDE_
