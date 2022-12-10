
                ifndef _EXAMPLE_CONFIGURATION_
                define _EXAMPLE_CONFIGURATION_

                DEVICE ZXSPECTRUM4096

                define KEYBOARD_PS2                                             ; обработка клавиатуры
                define MAPPING_REGISTERS                                        ; включить мапинг портов
                define DEBUG_EVE                                                ; включить отладочную информацию FT812

                define FIXED_CHECK_OVERFLOW
                define FIXED_CHECK_OVERFLOW_VALUE
                define COLOR_FLOW_WARNING

                include "Include.inc"

                define CMD_ADDRESS_PTR CmdAddress

                display "-------------------------------------------------------------------------------------------------------------------------------"
                display "Building a \'", FILENAME_PROJECT, "\' example ..."
                display "-------------------------------------------------------------------------------------------------------------------------------"
                include "TSLib.inc"
                include "Prototype.inc"
                include "Data/Include.inc"
                display "-------------------------------------------------------------------------------------------------------------------------------"

                endif ; ~_EXAMPLE_CONFIGURATION_
