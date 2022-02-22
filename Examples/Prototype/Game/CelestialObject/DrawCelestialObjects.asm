
                ifndef _GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECTS_
                define _GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECTS_
; -----------------------------------------
; отображение объектов в мире
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; инициализация
                LD DE, Array
                LD A, (Array.Size)
                LD (.Count), A

                ; сохраним номер страницы
                CALL Memory.GetPage3
                LD (.Page3), A

.Loop           EX DE, HL                                                       ; востановление адреса FSpaceObject

                ; проверим тип объекта
                LD A, (HL)                                                      ; HL = FSpaceObject.Classification
                OR A
                JR Z, .Next

                ; сохранение флагов
                AND FLAGS_MASK
                LD (Utils.Mesh.Primitive.Flags), A

                ; сохранение текущего адреса структуры
                PUSH HL

                ; сохранеие адреса возврата
                LD DE, .RET
                PUSH DE

                ; установка адреса полощения объекта
                INC HL
                LD (Utils.Mesh.Primitive.LocationPtr), HL                       ; HL = FSpaceObject.Location

                ; установка адреса матрицы вращения
                LD BC, FSpaceObject.Location
                ADD HL, BC
                LD (Utils.Mesh.Primitive.MatrixPtr), HL                         ; HL = FSpaceObject.MatrixRot

                ; установка страницы данных меша
                LD BC, FSpaceObject.MeshInfo - FSpaceObject.MatrixRot
                ADD HL, BC                                                      ; HL = FSpaceObject.MatrixRot
                LD A, (HL)                                                      ; FSpaceObject.MeshInfo.Address.P
                INC HL
                CALL Memory.SetPage3

                ; адрес данных о меше (старшие 2 бита должны быть установлены #C000)
                LD A, (HL)                                                      ; FSpaceObject.MeshInfo.Address.Offset.L
                LD IYL, A
                INC HL
                LD A, (HL)                                                      ; FSpaceObject.MeshInfo.Address.Offset.H
                LD IYH, A

                ; рисование объекта
                JP Draw.Mesh

.RET            ; точка возврата
                POP HL

.Next           ; переход к следующему элементу массива
                LD BC, FSpaceObject
                ADD HL, BC
                EX DE, HL                                                       ; сохранение адрес следующего элемента FSpaceObject

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

                endif ; ~_GAME_CELESTIAL_OBJECT_DRAW_CELESTIAL_OBJECTS_
