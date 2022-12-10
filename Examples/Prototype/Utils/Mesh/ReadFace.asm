
                ifndef _UTILS_MESH_READ_FACE_
                define _UTILS_MESH_READ_FACE_
; -----------------------------------------
; чтение данных примитива
; In :
;   BC - указывает на FMesh.IndexBuffer
; Out :
;   BC - указывает на индексы вершин примитива
; Corrupt :
; Note:
; -----------------------------------------
ReadFace:       ; чтение FFace.Queue
                INC BC
                LD A, (BC)
                LD (Primitive.Queue), A

                ; чтение FFace.Normal
                INC BC
                LD A, (BC)
                LD (Primitive.Normal), A

                INC BC

                RET

                endif ; ~_UTILS_MESH_READ_FACE_
