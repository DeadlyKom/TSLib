
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_SET_MESH_INFO_
                define _GAME_CELESTIAL_OBJECT_UTILS_SET_MESH_INFO_
; -----------------------------------------
; установка флагов объекта
; In:
;   IX - указывает на структуру FMeshInfo
;   A  - тип объекта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetMeshInfo:    ; установка значений

                ; расчёт адреса информации о меше
                LD HL, MeshData
                LD B, #00
                LD C, A
                ADD A, A
                ADD A, C
                ADD HL, BC

                ; -----------------------------------------
                LD A, (HL)
                LD (IX + FMeshInfo.Address.P), A
                INC HL

                ; -----------------------------------------
                LD A, (HL)
                LD (IX + FMeshInfo.Address.Offset.L), A
                INC HL

                ; -----------------------------------------
                LD A, (HL)
                OR #C0
                LD (IX + FMeshInfo.Address.Offset.H), A

                RET

                include "../../../Data/Tables/Meshes.inc"

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_SET_MESH_INFO_
