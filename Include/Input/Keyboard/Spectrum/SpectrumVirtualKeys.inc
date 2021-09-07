
                    ifndef _INPUT_KEYBOARD_SPECTRUM_VIRTUAL_KEYS_
                    define _INPUT_KEYBOARD_SPECTRUM_VIRTUAL_KEYS_

HalfRow_CS_V        EQU #FE
HalfRow_A_G         EQU #FD
HalfRow_Q_T         EQU #FB
HalfRow_1_5         EQU #F7
HalfRow_6_0         EQU #EF
HalfRow_Y_P         EQU #DF
HalfRow_H_ENT       EQU #BF
HalfRow_B_SPC       EQU #7F

; bit flags
SVK_0               EQU 1                   ; HalfRow_6_0
SVK_1               EQU 1                   ; HalfRow_1_5
SVK_2               EQU 2                   ; HalfRow_1_5
SVK_3               EQU 4                   ; HalfRow_1_5
SVK_4               EQU 8                   ; HalfRow_1_5
SVK_5               EQU 16                  ; HalfRow_1_5
SVK_6               EQU 16                  ; HalfRow_6_0
SVK_7               EQU 8                   ; HalfRow_6_0
SVK_8               EQU 4                   ; HalfRow_6_0
SVK_9               EQU 2                   ; HalfRow_6_0

SVK_A               EQU 1                   ; HalfRow_A_G
SVK_B               EQU 16                  ; HalfRow_B_SPC
SVK_C               EQU 8                   ; HalfRow_CS_V
SVK_D               EQU 4                   ; HalfRow_A_G
SVK_E               EQU 4                   ; HalfRow_Q_T
SVK_F               EQU 8                   ; HalfRow_A_G
SVK_G               EQU 16                  ; HalfRow_A_G
SVK_H               EQU 16                  ; HalfRow_H_ENT
SVK_I               EQU 4                   ; HalfRow_Y_P
SVK_J               EQU 8                   ; HalfRow_H_ENT
SVK_K               EQU 4                   ; HalfRow_H_ENT
SVK_L               EQU 2                   ; HalfRow_H_ENT
SVK_M               EQU 4                   ; HalfRow_B_SPC
SVK_N               EQU 8                   ; HalfRow_B_SPC
SVK_O               EQU 2                   ; HalfRow_Y_P
SVK_P               EQU 1                   ; HalfRow_Y_P
SVK_Q               EQU 1                   ; HalfRow_Q_T
SVK_R               EQU 8                   ; HalfRow_Q_T
SVK_S               EQU 2                   ; HalfRow_A_G
SVK_T               EQU 16                  ; HalfRow_Q_T
SVK_U               EQU 8                   ; HalfRow_Y_P
SVK_V               EQU 16                  ; HalfRow_CS_V
SVK_W               EQU 2                   ; HalfRow_Q_T
SVK_X               EQU 4                   ; HalfRow_CS_V
SVK_Y               EQU 16                  ; HalfRow_Y_P
SVK_Z               EQU 2                   ; HalfRow_CS_V

SVK_ENTER           EQU 1                   ; HalfRow_H_ENT
SVK_SYMBOL_SHIFT    EQU 2                   ; HalfRow_B_SPC
SVK_CAPS_SHIFT      EQU 1                   ; HalfRow_CS_V
SVK_SPACE           EQU 1                   ; HalfRow_B_SPC

                    endif ; ~_INPUT_KEYBOARD_SPECTRUM_VIRTUAL_KEYS_
