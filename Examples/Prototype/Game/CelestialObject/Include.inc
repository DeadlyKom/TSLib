
                ifndef _GAME_CELESTIAL_OBJECT_INCLUDE_
                define _GAME_CELESTIAL_OBJECT_INCLUDE_

                module CelestialObject

                include "Math/Include.inc"
                include "UpdateSolarSystem.asm"
                include "UpdateCelestialObject.asm"
                include "DrawCelestialObject.asm"

                ; массив обрабатываемых объектов на сцене
Array:          FCelestialNode = $
                DS FCelestialNode * MAX_OBJECT
.Size           DB #00                                                          ; размер массива

                endmodule

                endif ; ~_GAME_CELESTIAL_OBJECT_INCLUDE_
