
                ifndef _STRUCTURE_CELESTIAL_OBJECT_INCLUDE_
                define _STRUCTURE_CELESTIAL_OBJECT_INCLUDE_

                struct FSpaceObject
Classification  DB #00                                                          ; тип объекта
Location        FVector                                                         ; расположение объекта в пространстве 18:14
MatrixRot       FMatrix                                                         ; матрица вращения объекта
Rotation        FRotator                                                        ; вращение объекта
Velocity        FWord                                                           ; скорость объекта
Acceleration	FWord                                                           ; ускорение объекта
Flags			FWord                                                           ;
MeshInfo        FMeshInfo                                                       ; информация о меше объекта

                ends

                endif ; ~_STRUCTURE_CELESTIAL_OBJECT_INCLUDE_
