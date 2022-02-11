
                ifndef _STRUCTURE_COLOR_INCLUDE_
                define _STRUCTURE_COLOR_INCLUDE_

                define COLOR_WHITE  { 0, 0, 0, 0 }
                define COLOR_RED    { 1, 0, 0, 0 }
                define COLOR_GREEN  { 0, 1, 0, 0 }
                define COLOR_BLUE   { 0, 0, 1, 0 }
                define COLOR_BLACK  { 1, 1, 1, 0 }

                struct FColor
Red             DB #00
Green           DB #00
Blue            DB #00
Alpha           DB #00

                ends

                endif ; ~_STRUCTURE_COLOR_INCLUDE_
