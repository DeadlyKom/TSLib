
                ifndef _STRING_
                define _STRING_

                module String

                include "Copy.asm"
                include "Filter.asm"
                include "Compare.asm"
                include "Contains.asm"
                include "GetLength.asm"
                include "StringToByte.asm"
                include "ByteToString.asm"
                include "WordToString.asm"
                include "NumberToString.asm"

                endmodule

                endif ; ~_STRING_
