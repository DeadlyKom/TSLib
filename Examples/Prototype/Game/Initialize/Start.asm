
                ifndef _GAME_INITIALIZE_START_
                define _GAME_INITIALIZE_START_
; -----------------------------------------
; инициализация игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
StartGame:      
                


                ; добавление Skybox в список объектов
                LD A, Type.Skybox
                EX AF, AF'
                LD A, Classification.Skybox
                LD B, Index.Skybox
                CALL Utils.SetObject

                RET

                endif ; ~_GAME_INITIALIZE_START_
