
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECT_
                define _GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECT_
; -----------------------------------------
; отображение объектов в мире
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; инициализация
                LD IX, Array
                LD A, (Array.Size)
                LD (.Count), A

                ; сохраним номер страницы
                CALL Memory.GetPage3
                LD (.Page3), A

.Loop           ; проверим тип объекта
                LD A, (IX + FCelestialNode.Classification)
                OR A
                JR Z, .Next

                ; установка страницы данных меша
                LD A, (IX + FCelestialNode.MeshInfo.Address.P)
                CALL Memory.SetPage3

                ; адрес данных о меше (старшие 2 бита должны быть установлены #C000)
                LD L, (IX + FCelestialNode.MeshInfo.Address.Offset.L)
                LD H, (IX + FCelestialNode.MeshInfo.Address.Offset.H)

                ; рисование объекта

                


.Next           ; переход к следующему элементу массива
                LD BC, FCelestialNode
                ADD IX, BC

                ; уменьшит счёткик обрабатываемых объектов
                LD HL, .Count
                DEC (HL)
                JR NZ, .Loop

                ; востановление предыдущей страницы памяти
.Page3          EQU $+1
                LD A, #00
                CALL Memory.SetPage3
                RET

.Count          DB #00

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECT_
