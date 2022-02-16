
                ifndef _STRUCTURE_COLOR_INCLUDE_
                define _STRUCTURE_COLOR_INCLUDE_

                define COLOR_WHITE {   0,   0,   0,   0 }
                define COLOR_RED   { 255,   0,   0,   0 }
                define COLOR_GREEN {   0, 255,   0,   0 }
                define COLOR_BLUE  {   0,   0, 255,   0 }
                define COLOR_BLACK { 255, 255, 255,   0 }

                struct FColor
Red             DB #00
Green           DB #00
Blue            DB #00
Alpha           DB #00

                ends

COLOR_XRGB      macro Red?, Green?, Blue?
                FColor Red?, Green?, Blue?, 0
                endm

                endif ; ~_STRUCTURE_COLOR_INCLUDE_
