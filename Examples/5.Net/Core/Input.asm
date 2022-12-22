
                ifndef _EXAMPLE_CORE_INPUT_
                define _EXAMPLE_CORE_INPUT_
NUMBER_KEYS_ID      EQU 0x06
KEY_ID_UP           EQU 0x00                                                    ; клавиша "вверх"
KEY_ID_DOWN         EQU 0x01                                                    ; клавиша "вниз"
KEY_ID_SELECT       EQU 0x04                                                    ; клавиша "выбор"
KEY_ID_BACK_ESC     EQU 0x05                                                    ; клавиша "отмена/назад" ESC
KEY_ID_BACKSPACE    EQU 0x06                                                    ; клавиша "отмена/назад" Back
KEY_ID_LEFT         EQU 0x07                                                    ; клавиша "влево"
KEY_ID_RIGHT        EQU 0x08                                                    ; клавиша "вправо"
KEY_ID_SHIFT        EQU 0x09                                                    ; клавиша "SHIFT"
; -----------------------------------------
; 
; In:
;   A -
; Out:
; Corrupt:
; Note:
; -----------------------------------------
CheckKeyState:  ifdef KEYBOARD_PS2
                JP Input.Keyboard.PS2.KeyState
                else
                JP Input.Keyboard.Spectrum.KeyState
                endif
; -----------------------------------------
; проверка нажатия/отжатия виртуальной клавиши
; In :
;   A  - виртуальная клавиша
;   HL - адрес массива состояний виртуальных клавиш
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKey: CALL CheckKeyState
                LD A, (HL)
                JR Z, .IsReleased
                OR A
                JR NZ, .NotProcessed
                INC (HL)
                EX DE, HL
                JP (HL)                                                         ; переход, при нажатии на клавиши
.IsReleased     OR A
                JR Z, .NotProcessed
                DEC (HL)
                EX DE, HL
                JP (HL)                                                         ; переход, при отжатии на клавиши
.NotProcessed   SCF
                RET
; -----------------------------------------
; обработчик нажатия/отжатия виртуальной клавиши
; In :
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpKeys:       LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
; -----------------------------------------
; вызов обработчика виртуальных клавиш при нажатии/отжатии
; In :
;   HL  - адрес массива состояний виртуальных клавиш
;   DE' - адрес массива виртуальных клавиш
;   B'  - количество виртуальных клавиш в массиве
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
.Loop           LD A, (DE)
                INC DE
                EX AF, AF'
                LD A, (DE)
                INC DE
                EX AF, AF'
                PUSH DE                                                         ; сохранение, адрес массива виртуальных клавиш
                PUSH BC                                                         ; сохранение, количество опрашиваемых клавиш
                EXX
                PUSH HL                                                         ; сохранение, адрес массива состояний виртуальных клавиш
                PUSH DE                                                         ; сохранение, адрес обработчика виртуальных клавиш
                CALL JumpHandlerKey
                POP DE                                                          ; восстановление, адрес обработчика виртуальных клавиш
                POP HL                                                          ; восстановление, адрес массива состояний виртуальных клавиш
                INC HL
                EXX
                POP BC                                                          ; восстановление, количество опрашиваемых клавиш
                POP DE                                                          ; восстановление, адрес массива виртуальных клавиш
                RET NC                                                          ; выход, если обработчик не желает дальнеший опрос
                DJNZ .Loop
                RET

.KeyLastState   DS NUMBER_KEYS_ID, 0
.ArrayVKNum     DB Input.Keyboard.VK_DOWN,      KEY_ID_DOWN                     ; клавиша "вниз"
                DB Input.Keyboard.VK_UP,        KEY_ID_UP                       ; клавиша "вверх"
                DB Input.Keyboard.VK_ENTER,     KEY_ID_SELECT                   ; клавиша "выбор"
                DB Input.Keyboard.VK_ESC,       KEY_ID_BACK_ESC                 ; клавиша "отмена/назад" ESC
.LastKey        DB Input.Keyboard.VK_BACK,      KEY_ID_BACKSPACE                ; клавиша "отмена/назад" Backspace
.Num            EQU ($-.ArrayVKNum) / 2
; -----------------------------------------
; 
; In:
;   A -
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          LD A, (Flags.Input)
                INC A
                JR Z, InputMode
                
                ; опрос виртуальных клавиш
                LD A, (Flags.Menu)
                CP MENU_START_GAME
                LD DE, MenuInput
                JP Z, JumpKeys

                LD A, (Flags.Menu)
                CP MENU_OPTIONS
                LD DE, OptionsInput
                JP Z, JumpKeys

                LD A, (Flags.Menu)
                CP MENU_RESOLUTION
                LD DE, ResolutionInput
                JP Z, JumpKeys

                LD A, (Flags.Menu)
                CP MENU_CONNECT
                LD DE, ConnectInput
                JP Z, JumpKeys
                RET
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InputMode:      LD HL, (Flags.InputBuffer)
                LD DE, .Handler
; -----------------------------------------
; обработчик нажатия/отжатия виртуальной клавиши
; In :
;   DE - адрес обработчика виртуальных клавиш
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
.JumpKeys       LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
; -----------------------------------------
; вызов обработчика виртуальных клавиш при нажатии/отжатии
; In :
;   HL  - адрес массива состояний виртуальных клавиш
;   DE' - адрес массива виртуальных клавиш
;   B'  - количество виртуальных клавиш в массиве
; Out :
;   если указанная виртуальная клавиша нажата/отжатия то вызовется обрабочик
;   флаг Z соответствет 0/1 состоянию нажатия/отжатия соответственно
;   если обработчик обработал клавишу и не требуется дальнейший проод по виртуальным клавишам, флаг переполнения C должен быть сброшен
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
.Loop           LD A, (DE)
                INC DE
                EX AF, AF'
                LD A, (DE)
                INC DE
                EX AF, AF'
                PUSH DE                                                         ; сохранение, адрес массива виртуальных клавиш
                PUSH BC                                                         ; сохранение, количество опрашиваемых клавиш
                EXX
                PUSH HL                                                         ; сохранение, адрес массива состояний виртуальных клавиш
                PUSH DE                                                         ; сохранение, адрес обработчика виртуальных клавиш
                CALL JumpHandlerKey
                POP DE                                                          ; восстановление, адрес обработчика виртуальных клавиш
                POP HL                                                          ; восстановление, адрес массива состояний виртуальных клавиш
                INC HL
                EXX
                POP BC                                                          ; восстановление, количество опрашиваемых клавиш
                POP DE                                                          ; восстановление, адрес массива виртуальных клавиш
                RET NC                                                          ; выход, если обработчик не желает дальнеший опрос
                DJNZ .Loop
                RET

.KeyLastState   DS 46, 0
.ArrayVKNum     DB Input.Keyboard.VK_0,         "0"
                DB Input.Keyboard.VK_1,         "1"
                DB Input.Keyboard.VK_2,         "2"
                DB Input.Keyboard.VK_3,         "3"
                DB Input.Keyboard.VK_4,         "4"
                DB Input.Keyboard.VK_5,         "5"
                DB Input.Keyboard.VK_6,         "6"
                DB Input.Keyboard.VK_7,         "7"
                DB Input.Keyboard.VK_8,         "8"
                DB Input.Keyboard.VK_9,         "9"

                DB Input.Keyboard.VK_A,         "A"
                DB Input.Keyboard.VK_B,         "B"
                DB Input.Keyboard.VK_C,         "C"
                DB Input.Keyboard.VK_D,         "D"
                DB Input.Keyboard.VK_E,         "E"
                DB Input.Keyboard.VK_F,         "F"
                DB Input.Keyboard.VK_G,         "G"
                DB Input.Keyboard.VK_H,         "H"
                DB Input.Keyboard.VK_I,         "I"
                DB Input.Keyboard.VK_J,         "J"
                DB Input.Keyboard.VK_K,         "K"
                DB Input.Keyboard.VK_L,         "L"
                DB Input.Keyboard.VK_M,         "M"
                DB Input.Keyboard.VK_N,         "N"
                DB Input.Keyboard.VK_O,         "O"
                DB Input.Keyboard.VK_P,         "P"
                DB Input.Keyboard.VK_Q,         "Q"
                DB Input.Keyboard.VK_R,         "R"
                DB Input.Keyboard.VK_S,         "S"
                DB Input.Keyboard.VK_T,         "T"
                DB Input.Keyboard.VK_U,         "U"
                DB Input.Keyboard.VK_V,         "V"
                DB Input.Keyboard.VK_W,         "W"
                DB Input.Keyboard.VK_X,         "X"
                DB Input.Keyboard.VK_Y,         "Y"
                DB Input.Keyboard.VK_Z,         "Z"

                DB Input.Keyboard.VK_SPACE,     " "
                DB Input.Keyboard.VK_LSHIFT,    KEY_ID_SHIFT
                DB Input.Keyboard.VK_RSHIFT,    KEY_ID_SHIFT
                DB Input.Keyboard.VK_ENTER,     KEY_ID_SELECT
                DB Input.Keyboard.VK_BACK,      KEY_ID_BACKSPACE
                DB Input.Keyboard.VK_ESC,       KEY_ID_BACK_ESC
                DB Input.Keyboard.VK_LEFT,      KEY_ID_LEFT
                DB Input.Keyboard.VK_RIGHT,     KEY_ID_RIGHT
                DB Input.Keyboard.VK_UP,        KEY_ID_UP
                DB Input.Keyboard.VK_DOWN,      KEY_ID_DOWN

.Num            EQU ($-.ArrayVKNum) / 2

.Init           LD HL, Flags.InputCursor
                LD (HL), #00
                RET

.Handler        JR NZ, .Released                                                ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_SHIFT                                                 ; клавиша "SHIFT"
                JP Z, .ShiftOn
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, .Enter
                CP KEY_ID_BACKSPACE                                             ; клавиша "удалить"
                JP Z, .Delete
                CP KEY_ID_BACK_ESC                                              ; клавиша "отмена/назад"
                JP Z, .ESC
                CP KEY_ID_LEFT                                                  ; клавиша "влево"
                JP Z, .CurLeft
                CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                JP Z, .CurRight
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, .CurUp
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, .CurDown

                EX AF, AF'
                
                ; check next char
                LD HL, Flags.InputCursor
                LD A, (HL)
                INC HL
                CP (HL)
                DEC HL
                LD A, (HL)
                DEC A
                JR NC, $+4
                INC A
                INC (HL)
                
                ;
                LD HL, (Flags.InputBuffer)
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ;
                EX AF, AF'
                CP "A"
                JR C, .SkipShift
.Shift          EQU $+1
                ADD A, #20
.SkipShift      LD (HL), A

.Processed      SCF
                RET

.Released       EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_SHIFT                                                 ; клавиша "SHIFT"
                JP Z, .ShiftOff
                SCF
                RET

.NotProcessing  OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

.CurLeft        LD A, (Flags.InputCursor)
                DEC A
                RET M
                LD (Flags.InputCursor), A
                JR .Processed
.CurRight       LD HL, Flags.InputCursor
                LD A, (HL)
                INC HL
                INC A
                CP (HL)
                JR NC, .Processed
                LD (Flags.InputCursor), A
                JR .Processed
.ShiftOn        LD A, #20
                LD (.Shift), A
                JR .NotProcessing
.ShiftOff       LD A, #00
                LD (.Shift), A
                JR .NotProcessing
.Delete         LD HL, Flags.InputCursor
                LD A, (HL)
                OR A
                JR Z, .Processed
                DEC (HL)
                INC HL
                LD C, (HL)
                LD B, A
                LD HL, (Flags.InputBuffer)
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                LD D, H
                LD E, L
                DEC DE
                LD A, C
                SUB B
                LD C, A
                LD B, #00
                LDIR
                JR .Processed
.CurUp          LD HL, Flags.InputCursor
                LD (HL), #00
                JR .Processed
.CurDown        LD HL, (Flags.InputBuffer)
                LD D, H
                LD E, L
                LD BC, (Flags.InputBufferSize)
                XOR A
                CPIR
                JR NZ, .Processed
                OR A
                SBC HL, DE
                LD A, L
                DEC A
                LD (Flags.InputCursor), A
                JR .Processed

.Enter          LD A, #00
                LD (Flags.InputBufferSize), A
.ESC            XOR A
                LD (Flags.Input), A
                LD HL, (Flags.InputBack)
                LD A, H
                OR L
                RET Z
                PUSH HL
                RET

                endif ; ~_EXAMPLE_CORE_INPUT_
