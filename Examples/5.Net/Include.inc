
                    ifndef _EXAMPLE_INCLUDE_
                    define _EXAMPLE_INCLUDE_

                    define FILENAME_PROJECT "Net"                               ; имя проекта
EntryPoint          EQU #6000                                                   ; точка старта
StackTop            EQU #40DF                                                   ; расположение стека
Variables           EQU #40E0                                                   ; адрес переменных
VariablesSize       EQU ResolutionWidthPtr-Variables                            ; размер переменных
ResolutionWidthPtr  EQU #40EF                                                   ; указатель на адрес разрешения экрана по горизонтали
ResolutionHeightPtr EQU #40F1                                                   ; указатель на адрес разрешения экрана по вертикали
ResolutionFreqPtr   EQU #40F3                                                   ; указатель на адрес частота экрана
MemoryPages         EQU #40F5                                                   ; адрес хранения номеров установленых страниц

InterruptVA         EQU #4000                                                   ; адрес вектора прерывания
InterruptVA_Frame   EQU InterruptVA + INT_VEC_FRAME                             ; адрес кадрового вектора прерываний
InterruptVA_Line    EQU InterruptVA + INT_VEC_LINE                              ; адрес строчного вектора прерываний
InterruptVA_DMA     EQU InterruptVA + INT_VEC_DMA                               ; адрес DMA вектора прерываний
InterruptVA_NET     EQU InterruptVA + INT_VEC_NET                               ; адрес сетевого вектора прерываний

TSLib               EQU #1000                                                   ; адрес библиотеки TS-Conf
TSLibPage           EQU #00                                                     ; страница в которой хранятся библиотека TS-Conf

Flags:
.Menu               EQU Variables + 0                                           ; номер меню
.Hardware           EQU Variables + 1                                           ; флаги аппаратного обеспечения
.Input              EQU Variables + 2                                           ; флаги ввода
.InputCursor        EQU Variables + 3                                           ; положение курсора
.InputBufferSize    EQU Variables + 4                                           ; размер буфера ввода
.InputBuffer        EQU Variables + 5                                           ; адрес буфера ввода
.InputBack          EQU Variables + 7                                           ; адрес функции завершения/возврата режима ввода


                    endif ; ~_EXAMPLE_INCLUDE_
