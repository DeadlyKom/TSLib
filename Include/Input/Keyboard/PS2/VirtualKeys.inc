
                    ifndef _INPUT_KEYBOARD_PS2_VIRTUAL_KEYS_
                    define _INPUT_KEYBOARD_PS2_VIRTUAL_KEYS_

VK_EXTEN            EQU #80

VK_0                EQU #45
VK_1                EQU #16
VK_2                EQU #1E
VK_3                EQU #26
VK_4                EQU #25
VK_5                EQU #2E
VK_6                EQU #36
VK_7                EQU #3D
VK_8                EQU #3E
VK_9                EQU #46

VK_A                EQU #1C
VK_B                EQU #32
VK_C                EQU #21
VK_D                EQU #23
VK_E                EQU #24
VK_F                EQU #2B
VK_G                EQU #34
VK_H                EQU #33
VK_I                EQU #43
VK_J                EQU #3B
VK_K                EQU #42
VK_L                EQU #4B
VK_M                EQU #3A
VK_N                EQU #31
VK_O                EQU #44
VK_P                EQU #4D
VK_Q                EQU #15
VK_R                EQU #2D
VK_S                EQU #1B
VK_T                EQU #2C
VK_U                EQU #3C
VK_V                EQU #2A
VK_W                EQU #1D
VK_X                EQU #22
VK_Y                EQU #35
VK_Z                EQU #1A

VK_OEM_1            EQU #4C     ; ';:'
VK_OEM_2            EQU #4A     ; '/?'
VK_OEM_3            EQU #0E     ; '`~'
VK_OEM_4            EQU #54     ; '[{'
VK_OEM_5            EQU #5D     ; '\|'
VK_OEM_6            EQU #5B     ;']}'
VK_OEM_7            EQU #52     ; 'single-quote/double-quote'
VK_OEM_PLUS         EQU #55     ; '+='
VK_OEM_MINUS        EQU #4E     ; '-_'
VK_OEM_COMMA        EQU #41     ; ',<'
VK_OEM_PERIOD       EQU #49     ; '.>'

VK_ESC              EQU #76
VK_BACK             EQU #66
VK_TAB              EQU #0D
VK_ENTER            EQU #5A
VK_ENTER_EX         EQU VK_EXTEN | VK_ENTER
VK_LSHIFT           EQU #12
VK_RSHIFT           EQU #59
VK_LCONTROL         EQU #14
VK_RCONTROL         EQU VK_EXTEN | VK_LCONTROL
VK_LALT             EQU #11
VK_RALT             EQU VK_EXTEN | VK_LALT
VK_CAPS             EQU #58
VK_SPACE            EQU #29

VK_PAGE_UP          EQU VK_EXTEN | #7D
VK_PAGE_DN          EQU VK_EXTEN | #7A
VK_HOME             EQU VK_EXTEN | #6C
VK_END              EQU VK_EXTEN | #69
VK_INSERT           EQU VK_EXTEN | #70
VK_DELETE           EQU VK_EXTEN | #71

VK_LEFT             EQU VK_EXTEN | #6B
VK_RIGHT            EQU VK_EXTEN | #74
VK_UP               EQU VK_EXTEN | #75
VK_DOWN             EQU VK_EXTEN | #72

VK_F1               EQU #05
VK_F2               EQU #06
VK_F3               EQU #04
VK_F4               EQU #0C
VK_F5               EQU #03
VK_F6               EQU #0B
VK_F7               EQU #83
VK_F8               EQU #0A
VK_F9               EQU #01
VK_F10              EQU #09
VK_F11              EQU #78
VK_F12              EQU #07

VK_NUM              EQU #77
VK_NUMPAD0          EQU #70
VK_NUMPAD1          EQU #69
VK_NUMPAD2          EQU #72
VK_NUMPAD3          EQU #7A
VK_NUMPAD4          EQU #6B
VK_NUMPAD5          EQU #73
VK_NUMPAD6          EQU #74
VK_NUMPAD7          EQU #6C
VK_NUMPAD8          EQU #75
VK_NUMPAD9          EQU #7D

VK_MULTIPLY         EQU #7C
VK_DIVIDE           EQU VK_EXTEN | #4A
VK_ADD              EQU #79
VK_SUBTRACT         EQU #7B
VK_DOT              EQU #71

                    endif ; ~_INPUT_KEYBOARD_PS2_VIRTUAL_KEYS_
