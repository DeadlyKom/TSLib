
                ifndef _STRUCTURE_ADDRESS_INCLUDE_
                define _STRUCTURE_ADDRESS_INCLUDE_

                struct FOffset
Offset          FWord 0, 0

                ends

                struct FLinearAddress
P               DB #00                                                          ; номер страницы
Offset          FWord 0, 0

                ends

                endif ; ~_STRUCTURE_ADDRESS_INCLUDE_
