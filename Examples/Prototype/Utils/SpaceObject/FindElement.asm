
                ifndef _GAME_CELESTIAL_OBJECT_UTILS_FIND_INCLUDE_
                define _GAME_CELESTIAL_OBJECT_UTILS_FIND_INCLUDE_
; -----------------------------------------
; поиск свободного элемента в массиве объектов
; In:
; Out:
;   HL - адрес свободного элемента
;   флаг переполнения установлен, если поиск прошёл неудачно
; Corrupt:
; Note:
; -----------------------------------------
FindFree:       LD HL, Game.CelestialObject.Array
                LD DE, FSpaceObject
                LD B, MAX_OBJECT

.Loop           LD A, (HL)
                OR A
                RET Z
                ADD HL, DE
                DJNZ .Loop

                SCF
                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_UTILS_FIND_INCLUDE_
