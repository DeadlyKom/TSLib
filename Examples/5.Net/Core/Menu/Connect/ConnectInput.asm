
                ifndef _MENU_OPTIONS_CONNECT_INPUT_
                define _MENU_OPTIONS_CONNECT_INPUT_
; -----------------------------------------
; обработчик клавиш опций
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ConnectInput:   JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши
                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JP Z, Con.ArrowUP
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JP Z, Con.ArrowDOWN
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Con.Selected
                CP KEY_ID_BACK_ESC                                              ; клавиша "отмена/назад"
                JP Z, Con.Back
                CP KEY_ID_BACKSPACE                                             ; клавиша "отмена/назад"
                JP Z, Con.Back

.NotProcessing  SCF
                RET

.Processed      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Con.ArrowUP:    LD A, (Con.Counter)
                DEC A
                JP M, .Offset
                LD (Con.Counter), A
                RET
.Offset         LD A, (Con.Counter.Offset)
                DEC A
                RET M
                LD (Con.Counter.Offset), A
                RET

Con.ArrowDOWN:  LD A, (AccessPoints.MaxVisible)
                LD C, A
                LD A, (Con.Counter)
                INC A
                CP C
                JR NC, .Offset
                LD (Con.Counter), A
                RET

.Offset         LD A, (AccessPoints.Num)
                DEC A
                LD C, A
                LD HL, Con.Counter
                LD A, (HL)
                INC HL
                ADD A, (HL)
                CP C
                RET NC
                INC (HL)
                RET

Con.Selected:   LD A, (AccessPoints.Num)
                OR A
                JR Z, ConnectInput.NotProcessing

                LD A, (ZiFi.Req_CMD)
                CP ZIFI_CWJAP
                JR Z, ConnectInput.NotProcessing
                
                LD A, #FF
                LD (Password.Flag), A
                LD (Flags.Input), A

                LD HL, .Back
                LD (Flags.InputBack), HL

                LD HL, PASSWORD
                LD DE, Password
                LD BC, PASSWORD.Size
                LDIR
                EX DE, HL
                LD (HL), #00

                LD HL, Password
                LD (Flags.InputBuffer), HL
                LD A, 16
                LD (Flags.InputBufferSize), A
                JP InputMode.Init

.Back           LD HL, #0000
                LD (Flags.InputBack), HL
                XOR A
                LD (Password.Flag), A
                LD A, (Flags.InputBufferSize)
                OR A
                RET NZ

                LD A, ZIFI_CWJAP
                LD (ZiFi.Req_CMD), A
                RET

Con.Back:       LD A, MENU_OPTIONS
                LD (Flags.Menu), A
                LD A, #00
                LD (AccessPoints.Num), A
                LD A, ZIFI_UNKNOW
                LD (ZiFi.Req_CMD), A
                RET

PASSWORD        BYTE "f493606304f"
.Size           EQU $-PASSWORD

                endif ; ~_MENU_OPTIONS_CONNECT_INPUT_
