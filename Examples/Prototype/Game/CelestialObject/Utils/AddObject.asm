
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_ADD_OBJECT_
                define _GAME_CELESTIAL_OBJECT_UTILS_ADD_OBJECT_
; -----------------------------------------
; добовление объекта в космос
; In:
;   A  - классификация объекта
;   A' - тип объекта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AddObject:      PUSH AF

                ; проверка переполнения массива
                LD A, (Game.CelestialObject.Array.Size)
                CP MAX_OBJECT
                RET NC                                                          ; выход, т.к. массив переполнен
                
                ; поиск свободного элемента
                CALL FindFree
                CCF
                RET NC                                                          ; выход, не удалось найти свободный элемент

                POP AF

                ; ---------------------------------------------
.Init           ; инициализация объекта
                ; ---------------------------------------------

                PUSH HL
                POP IX

                ; увеличение счётчика элементов в массиве
                LD HL, Game.CelestialObject.Array.Size
                INC (HL)

.Classification ; ---------------------------------------------

                ; установка типа объекта
                LD (IX + FCelestialNode.Classification), A

.Location       ; ---------------------------------------------

                ; установка позиции объекта
                INC IX
                BIT NO_LOCATION_BIT, A                                          ; проверка на наличие у данного типа позиции
                JR Z, .SkipZeroLoc

                ; обнулени значение осей X, Y, Z
                XOR A
                LD H, A
                LD L, A
                LD D, A
                LD E, A
                LD B, A
                LD C, A

.SkipZeroLoc    CALL SetLocation

.MatrixRot      ; ---------------------------------------------

                ; смещение IX до поля MatrixRot
                LD BC, FVector
                ADD IX, BC
                CALL SetMatrix.Identity

.Rotation       ; ---------------------------------------------

                ; смещение IX до поля FMatrix
                LD BC, FMatrix
                ADD IX, BC
                CALL SetRotator.Zero

.Velocity       ; ---------------------------------------------

                ; смещение IX до поля FRotator
                LD BC, FRotator
                ADD IX, BC
                CALL SetVelocity.Zero

.Acceleration   ; ---------------------------------------------

                ; смещение IX до поля FWord
                LD BC, FWord
                ADD IX, BC
                CALL SetAcceleration.Zero

.Flags          ; ---------------------------------------------

                ; смещение IX до поля FWord
                LD BC, FWord
                ADD IX, BC
                CALL SetFlags.Zero

.MeshInfo       ; ---------------------------------------------

                ; смещение IX до поля FWord
                LD BC, FWord
                ADD IX, BC
                EX AF, AF'
                CALL SetMeshInfo

                RET
; -----------------------------------------
; установка объекта в космосе в указанную ячейку
; In:
;   A  - классификация объекта
;   A' - тип объекта
;   B  - индекс элемента но не более MAX_OBJECT
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetObject:      ; инициализация
                LD HL, Game.CelestialObject.Array
                
                ; проверка что индекс не нулевой
                INC B
                DEC B
                JR Z, AddObject.Init
                
                LD DE, FCelestialNode

.Loop           ADD HL, DE
                DJNZ .Loop

                JR AddObject.Init

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_ADD_OBJECT_
