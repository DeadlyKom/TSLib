
                ifndef _UTILS_MESH_NEXT_FACE_
                define _UTILS_MESH_NEXT_FACE_
; -----------------------------------------
; переход к следующему приметиву
; In :
;   BC - указывает на смещение
; Out :
;   BC - указывает на слудующий примитив
; Corrupt :
; Note:
; -----------------------------------------
NextFace:       ; добавление смещения
                LD A, (BC)
                ADD A, C
                LD C, A
                RET NC
                INC B
                RET

                endif ; ~_UTILS_MESH_NEXT_FACE_
