
                ifndef _GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
                define _GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
; -----------------------------------------
; обновление объекта
; In:
;   IX - указывает на обрабатываемый элемент FSpaceObject массива
;   A  - содержит тип объекта
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UpdateObject:   ; инициализация
                LD IY, Game.Init.Player.Ship.FlightRot

                ; проверка на объекты в центре
                BIT NO_LOCATION_BIT, A
                CALL Z, Math.RotateLocation

                ; вращение right вектора
                LD BC, FVector
                ADD IX, BC
                CALL Math.RotateRoll
                CALL Math.RotatePitch

                ; вращение up вектора
                LD BC, FVectorHalf
                ADD IX, BC
                CALL Math.RotateRoll
                CALL Math.RotatePitch

                ; вращение forward вектора
                LD BC, FVectorHalf
                ADD IX, BC
                CALL Math.RotateRoll
                CALL Math.RotatePitch

                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
