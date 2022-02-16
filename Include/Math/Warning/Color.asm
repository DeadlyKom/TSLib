                ifndef _MATH_WARNING_COLOR_
                define _MATH_WARNING_COLOR_

OverflowColor:  LD A, RED
                OUT (#FE), A
                XOR A
.Loop           DEC A
                JR NZ, .Loop
                OUT (#FE), A
                RET

                endif ; ~_MATH_WARNING_COLOR_
