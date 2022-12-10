
                ifndef _UTILS_MESH_GET_ADDRESS_VERTEX_
                define _UTILS_MESH_GET_ADDRESS_VERTEX_
; -----------------------------------------
; расчёт адреса вершины
; In :
;   A  - индекс вершины
; Out :
;   HL - адрес вершины FVertex
; Corrupt :
;   HL, DE, AF
; Note:
; -----------------------------------------
GetVertex:      LD HL, Primitive.Tmp
                LD (HL), A
                XOR A
                RLD
                LD E, (HL)
                LD D, A
.Buffer         EQU $+1
                LD HL, #0000
                ADD HL, DE

                RET

                endif ; ~_UTILS_MESH_GET_ADDRESS_VERTEX_
