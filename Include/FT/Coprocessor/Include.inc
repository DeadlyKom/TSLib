
            ifndef _COPROCESSOR_INCLUDE_
            define _COPROCESSOR_INCLUDE_

            module Coprocessor

            include "Macro.inc"
            include "Cmd.asm"

            include "Buffer.asm"
            include "BufferMacro.inc"

            include "IsFault.asm"
            include "WaitFlush.asm"
            include "Inflate.asm"
            include "GetPtr.asm"

            endmodule

            endif ; ~_COPROCESSOR_INCLUDE_
