
                ifndef _GAME_CELESTIAL_OBJECT_UPDATE_SOLAR_SYSTEM_
                define _GAME_CELESTIAL_OBJECT_UPDATE_SOLAR_SYSTEM_
; -----------------------------------------
; обновление солнечной системы
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UpdateSolSys:   ; инициализация
                LD IX, Array
                LD A, (Array.Size)
                LD (.Count), A

.Loop           ; проверим тип объекта
                LD A, (IX + FSpaceObject.Classification)
                OR A
                CALL NZ, UpdateObject                                           ; обновим объект, если тип известен

.Next           ; переход к следующему элементу массива
                LD BC, FSpaceObject
                ADD IX, BC

                ; уменьшит счёткик обрабатываемых объектов
                LD HL, .Count
                DEC (HL)
                JR NZ, .Loop

                RET

.Count          DB #00

                endif ; ~_GAME_CELESTIAL_OBJECT_UPDATE_SOLAR_SYSTEM_
