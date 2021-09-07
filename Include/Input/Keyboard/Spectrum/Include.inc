        
                    ifndef _INPUT_KEYBOARD_SPECTRUM_INCLUDE_
                    define _INPUT_KEYBOARD_SPECTRUM_INCLUDE_

                    include "VirtualKeys.inc"

                    module Spectrum
            
                    include "SpectrumVirtualKeys.inc"
                    include "KeyState.asm"
VirtualKeysTable:   DB HalfRow_CS_V,    SVK_CAPS_SHIFT
                    DB HalfRow_CS_V,    SVK_Z
                    DB HalfRow_CS_V,    SVK_X
                    DB HalfRow_CS_V,    SVK_C
                    DB HalfRow_CS_V,    SVK_V

                    DB HalfRow_A_G,     SVK_A
                    DB HalfRow_A_G,     SVK_S
                    DB HalfRow_A_G,     SVK_D
                    DB HalfRow_A_G,     SVK_F
                    DB HalfRow_A_G,     SVK_G

                    DB HalfRow_Q_T,     SVK_Q
                    DB HalfRow_Q_T,     SVK_W
                    DB HalfRow_Q_T,     SVK_E
                    DB HalfRow_Q_T,     SVK_R
                    DB HalfRow_Q_T,     SVK_T

                    DB HalfRow_1_5,     SVK_1
                    DB HalfRow_1_5,     SVK_2
                    DB HalfRow_1_5,     SVK_3
                    DB HalfRow_1_5,     SVK_4
                    DB HalfRow_1_5,     SVK_5

                    DB HalfRow_6_0,     SVK_6
                    DB HalfRow_6_0,     SVK_7
                    DB HalfRow_6_0,     SVK_8
                    DB HalfRow_6_0,     SVK_9
                    DB HalfRow_6_0,     SVK_0

                    DB HalfRow_Y_P,     SVK_Y
                    DB HalfRow_Y_P,     SVK_U
                    DB HalfRow_Y_P,     SVK_I
                    DB HalfRow_Y_P,     SVK_O
                    DB HalfRow_Y_P,     SVK_P

                    DB HalfRow_H_ENT,   SVK_H
                    DB HalfRow_H_ENT,   SVK_J
                    DB HalfRow_H_ENT,   SVK_K
                    DB HalfRow_H_ENT,   SVK_L
                    DB HalfRow_H_ENT,   SVK_ENTER

                    DB HalfRow_B_SPC,   SVK_B
                    DB HalfRow_B_SPC,   SVK_N
                    DB HalfRow_B_SPC,   SVK_M
                    DB HalfRow_B_SPC,   SVK_SYMBOL_SHIFT
                    DB HalfRow_B_SPC,   SVK_SPACE

                    endmodule

                    endif ; ~_INPUT_KEYBOARD_SPECTRUM_INCLUDE_
