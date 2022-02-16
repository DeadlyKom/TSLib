
                ifndef _CORE_LOOP_MAIN_
                define _CORE_LOOP_MAIN_

Main:           ;
.Loop           ;
                CALL Game.CelestialObject.UpdateSolSys
                CALL Draw

                JP .Loop

                endif ; ~_CORE_LOOP_MAIN_
