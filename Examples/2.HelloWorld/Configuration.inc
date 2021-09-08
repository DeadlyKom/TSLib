
                ifndef _EXAMPLE_CONFIGURATION_
                define _EXAMPLE_CONFIGURATION_

                DEVICE ZXSPECTRUM4096

                define KEYBOARD_PS2                                 ; обработка клавиатуры
                define MAPPING_REGISTERS                            ; включить мапинг портов
                define DEBUG_EVE                                    ; включить отладочную информацию FT812

                include "Include.inc"

                display "-------------------------------------------------------------------------------------------------------------------------------"
                display "Building a \'", FILENAME_PROJECT, "\' example ..."
                display "-------------------------------------------------------------------------------------------------------------------------------"
                include "TSLib.inc"
                include "Core/Example.inc"
                display "-------------------------------------------------------------------------------------------------------------------------------"

                endif ; ~_EXAMPLE_CONFIGURATION_
