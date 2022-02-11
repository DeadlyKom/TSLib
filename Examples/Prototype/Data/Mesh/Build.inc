
                ifndef _DATA_BUILD_
                define _DATA_BUILD_

                MMU 3, BUILD_MeshPage
                ORG BUILD_Mesh
BUILD_Start:
.Skybox         EQU $
                FCelestialData {
                {"SkyBox\0"},                                                   ; имя
                Skybox.Vertexes,                                                ; вершины
                Skybox.Normals,                                                 ; нормали
                Skybox.Faces }                                                  ; обход вершин
                include "Skybox.inc"                                            ; данные
BUILD_End:
.SkyboxSize     EQU ($-BUILD_Start.Skybox)
BUILD_Size:     EQU .SkyboxSize

                display "Mesh Data:  \t\t", /A, BUILD_Start, " = busy [ ", /D, BUILD_Size, " bytes ]"
                savebin "Examples/Prototype/Files/MeshData.bin", BUILD_Start, BUILD_Size

                endif ; ~_DATA_BUILD_
