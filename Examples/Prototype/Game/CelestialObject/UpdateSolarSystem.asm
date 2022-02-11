
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
                LD DE, Array
                LD A, (Array.Size)
                LD (.Count), A

.Loop           ; 
                EX DE, HL                                                       ; востановим адрес текущего обрабатываемого объекта
                PUSH HL

                ; проверим тип объекта
                LD A, (HL)                                                      ; HL = FCelestialNode.Classification
                OR A
                CALL NZ, UpdateObject                                           ; обновим объект, если тип известен

                ; переход к следующему элементу массива
                POP HL
                LD DE, FCelestialNode
                ADD HL, DE
                EX DE, HL                                                       ; сохраним адрес обрабатываемого объекта

.Next           ; уменьшит счёткик обрабатываемых объектов
                LD HL, .Count
                DEC (HL)
                JR NZ, .Loop

                RET

.Count          DB #00

                endif ; ~_GAME_CELESTIAL_OBJECT_UPDATE_SOLAR_SYSTEM_
