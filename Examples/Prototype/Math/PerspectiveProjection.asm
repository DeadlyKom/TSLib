
                ifndef _GAME_MATH_PERSPECTIVE_PROJECTION_
                define _GAME_MATH_PERSPECTIVE_PROJECTION_
; -----------------------------------------
; преобразование 3D в 2D (перспектива)
; In :
;   значения берутся из Utils.Mesh.Primitive.Location
; Out :
;   HL - X в экранных координатах
;   DE - Y в экранных координатах
; Corrupt :
; Note:
; -----------------------------------------
PerspectiveProj:

                ; ---------------------------------------------
                ; X = X/Z
                ; ---------------------------------------------

                ; 
                LD HL, (Utils.Mesh.Primitive.Location.X.H)
                LD DE, (Utils.Mesh.Primitive.Location.X.L)

                ; преобразование fixed-point numbers 18:14 в BC, 
                ; знак и старший 17 бит в регистре A
                LD BC, (Utils.Mesh.Primitive.Location.Z.H)
                LD A, (Utils.Mesh.Primitive.Location.Z.L + 1)

                RLA
                RL C
                RL B

                PUSH AF
                OR A
                EX AF, AF'                                                      ; сохранение знака (флаг Carry)
                POP AF

                RLA
                RL C
                RL B                                                            ; флаг Carry хранит 17 бит значения

                CALL Math.Fixed_1814.DIV_FBC
                PUSH DE ; X.L
                PUSH HL ; X.H
                
                ; ---------------------------------------------
                ; Y = Y/Z
                ; ---------------------------------------------

                ; 
                LD HL, (Utils.Mesh.Primitive.Location.Y.H)
                LD DE, (Utils.Mesh.Primitive.Location.Y.L)

                ; преобразование fixed-point numbers 18:14 в BC, 
                ; знак и старший 17 бит в регистре A
                LD BC, (Utils.Mesh.Primitive.Location.Z.H)
                LD A, (Utils.Mesh.Primitive.Location.Z.L + 1)

                RLA
                RL C
                RL B

                PUSH AF
                OR A
                EX AF, AF'                                                      ; сохранение знака (флаг Carry)
                POP AF

                RLA
                RL C
                RL B                                                            ; флаг Carry хранит 17 бит значения

                CALL Math.Fixed_1814.DIV_FBC

                ; HLB = HLDE (E -> discard) [Y]
                LD B, D

                ; DEC = HLDE (E -> discard) [X]
                POP DE
                POP AF
                LD C, A
                
                ; ---------------------------------------------
                ; нормализация значений X и Y в пределах -16384 до 16384
                ; ---------------------------------------------
                
                ; HLB - Y
                ; DEC - X

                ; сохранение знаков
                PUSH HL
                PUSH DE

                ; сброс знаков
                RES 7, H
                RES 7, D

.CheckRShift    ; если 6 бит равен 1 сдвиг вправа X и Y
                LD A, H
                OR D
                BIT 6, A
                JR Z, .CheckLShift1

                ; сдвиг вправо DEC
                SRL D
                RR E
                RR C

                ; сдвиг вправо HLB
                SRL H
                RR L
                RR B

.Convert        ; приведение DEC к значениям 
                POP AF

                RLA
                JR NC, .Y
                
                ; NEG DE
                XOR A
                SUB E
                LD E, A
                SBC A, A
                SUB D
                LD D, A

.Y              ; приведение HLB к значениям 
                POP AF
                RLA
                CCF                                                             ; смена знака на противоположный
                JR NC, .R

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A

.R              ; sy += 96 * 4;
                ; LD BC, (ResolutionHeightPtr)
                LD BC, 384
                ADD HL, BC

                ; sx += 128 * 4;
                EX DE, HL
                ; LD BC, (ResolutionWidthPtr)
                LD BC, 512
                ADD HL, BC
                
                RET

.CheckLShift1   ; если 5 бит равен 0 сдвиг влево X и Y
                BIT 5, A
                JR NZ, .Convert

                ; сдвиг влево HLB
                RL B
                ADC HL, HL
                EX DE, HL

                ; сдвиг влево DEC
                RL C
                ADC HL, HL
                EX DE, HL

.CheckLShift2   ; если 5 бит равен 0 сдвиг влево X и Y
                BIT 5, A
                JR NZ, .Convert

                ; сдвиг влево HLB
                RL B
                ADC HL, HL
                EX DE, HL

                ; сдвиг влево DEC
                RL C
                ADC HL, HL
                EX DE, HL

                JR .Convert

                endif ; ~_GAME_MATH_PERSPECTIVE_PROJECTION_
