
                    ifndef _EXAMPLE_INCLUDE_
                    define _EXAMPLE_INCLUDE_

                    define FILENAME_PROJECT "Prototype"     ; имя проекта
EntryPoint          EQU #6000                               ; точка старта
StackTop            EQU #40F2                               ; расположение стека
ResolutionWidthPtr  EQU #40F3                               ; указатель на адрес разрешения экрана по горизонтали
ResolutionHeightPtr EQU #40F5                               ; указатель на адрес разрешения экрана по вертикали
MemoryPages         EQU #40F7                               ; адрес хранения номеров установленых страниц
InterruptVA         EQU #4000                               ; адрес вектора прерывания

InterruptVA_Frame   EQU InterruptVA + INT_VEC_FRAME         ; адрес кадрового вектора прерываний
InterruptVA_Line    EQU InterruptVA + INT_VEC_LINE          ; адрес строчного вектора прерываний
InterruptVA_DMA     EQU InterruptVA + INT_VEC_DMA           ; адрес DMA вектора прерываний

TSLib               EQU #1000                               ; адрес библиотеки TS-Conf
TSLibPage           EQU #00                                 ; страница в которой хранятся библиотека TS-Conf

                    endif ; ~_EXAMPLE_INCLUDE_
