
                ifndef _CONST_CELESTIAL_OBJECT_CLASSIFICATION_INCLUDE_
                define _CONST_CELESTIAL_OBJECT_CLASSIFICATION_INCLUDE_

NO_LOCATION_BIT EQU 0x07                                                        ; объект не перемещается (находится всегда в 0 координатах)
PHYSICAL_BIT    EQU 0x06                                                        ; объект физический
NO_LOCATION     EQU 1 << NO_LOCATION_BIT
PHYSICAL        EQU 1 << PHYSICAL_BIT

                module Classification

; Examples of astronomical bodies include
None            EQU #00
Ship            EQU #01 | PHYSICAL
Comet           EQU #02 | PHYSICAL
Asteroid        EQU #03 | PHYSICAL
AsteroidBelt    EQU #04 | PHYSICAL
Satellite       EQU #05 | PHYSICAL
Planet          EQU #06 | PHYSICAL
Star            EQU #07 | PHYSICAL

; Examples of astronomical objects include
PlanetarySystem EQU #08
StarCluster     EQU #09
Nebula          EQU #0A
Galaxy          EQU #0B
BlackHole       EQU #0C
Universe        EQU #0D
Skybox          EQU #0E | NO_LOCATION

                endmodule

                endif ; ~_CONST_CELESTIAL_OBJECT_CLASSIFICATION_INCLUDE_
