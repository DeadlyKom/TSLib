
                ifndef _GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
                define _GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
; -----------------------------------------
; обновление объекта
; In:
;   HL - указывает на обрабатываемый элемент FCelestialNode массива
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UpdateObject:   ;
                INC HL
                LD DE, Game.Player.Ship.FlightRot
                CALL Math.RotateLocation

                RET

                endif ; ~_GAME_CELESTIAL_OBJECT_UPDATE_CELESTIAL_OBJECT_
