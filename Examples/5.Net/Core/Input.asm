
                ifndef _EXAMPLE_CORE_INPUT_
                define _EXAMPLE_CORE_INPUT_
NUMBER_KEYS_ID      EQU 0x06
KEY_ID_UP           EQU 0x00                                                    ; клавиша "вверх"
KEY_ID_DOWN         EQU 0x01                                                    ; клавиша "вниз"
KEY_ID_SELECT       EQU 0x04                                                    ; клавиша "выбор"
KEY_ID_BACK_ESC     EQU 0x05                                                    ; клавиша "отмена/назад" ESC
KEY_ID_BACKSPACE    EQU 0x06                                                    ; клавиша "отмена/назад" Back
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
JumpHandlerKey:     CALL CheckKeyState
                    LD A, (HL)
                    JR NZ, .IsReleased
                    OR A
                    JR NZ, .NotProcessed
                    INC (HL)
                    EX DE, HL
                    JP (HL)                                                     ; переход, при нажатии на клавиши
.IsReleased         OR A
                    JR Z, .NotProcessed
                    DEC (HL)
                    EX DE, HL
                    JP (HL)                                                     ; переход, при отжатии на клавиши
.NotProcessed       SCF
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
Input:          ; опрос виртуальных клавиш
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

                endif ; ~_EXAMPLE_CORE_INPUT_
