                
                include "Const.inc"
                include "Macro.inc"
                
                ifdef FMUL_FDIV
                include "MUL_TAB.inc"
                endif

                module Math

                include "WLD.asm"
                include "WST.asm"
                include "ROUND.asm"

                ifdef FADD_FSUB
                include "ADD.asm"
                include "SUB.asm"
                endif

                ifdef FMUL_FDIV
                include "MUL.asm"
                endif

                endmodule