                ifndef _MESH_TABLE_
                define _MESH_TABLE_
MeshData:       FMeshInfo { {
                    BUILD_Start.SkyboxPage,
                    (BUILD_Start.SkyboxOffset >> 0) & 0xFF,
                    (BUILD_Start.SkyboxOffset >> 8) & 0xFF }
                }

                endif ; ~_MESH_TABLE_
