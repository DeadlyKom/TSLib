
                ifndef _GAME_CELESTIAL_OBJECT_INCLUDE_
                define _GAME_CELESTIAL_OBJECT_INCLUDE_

                module CelestialObject

                include "Draw/Include.inc"
                include "UpdateSolarSystem.asm"
                include "UpdateCelestialObject.asm"
                include "DrawCelestialObjects.asm"

                ; массив обрабатываемых объектов в космосе
Array:          FSpaceObject = $
                DS FSpaceObject * MAX_OBJECT
.Size           DB #00                                                          ; размер массива

                endmodule

                endif ; ~_GAME_CELESTIAL_OBJECT_INCLUDE_
