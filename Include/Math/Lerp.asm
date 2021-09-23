

                ifndef _MATH_LERP_
                define _MATH_LERP_

                module Math

                ifndef LERP_INCLUDE
                include "Mul/Int16x8_16.asm"
                endif

; -----------------------------------------
; interpolation between two 8-bit values (A, B) for the parameter (Alpha)
; result in the range [-128 .. 127]
; In :
;   BC - high byte is zero, low byte signed A [-128 .. 127]
;   HL - high byte is zero, low byte signed B [-128 .. 127]
;   A  - alpha values interval from 0 to 1 [0 .. 255]
; Out :
;   HLA - product (HL - integer number, A - fractional number)
; Corrupt :
;   HL, DE, AF
; Note:
;   A + Alpha * (B - A)
;   when defining MATH_INTEGER_LERP, the accumulator does not store the fractional
; -----------------------------------------
Lerp:           ; B - A
                OR A
                SBC HL, BC
                
                ; Alpha * (B - A)
                EX DE, HL
                CALL Math.MulInt16x8_16

                ; save fractional
                ifndef MATH_INTEGER_LERP
                LD E, L
                endif

                ; HLA = HL >> 8
                LD L, H
                LD A, H
                ADD A, A
                SBC A, A
                LD H, A

                ; restore fractional
                ifndef MATH_INTEGER_LERP
                LD A, E
                endif

                ; A + Alpha * (B - A)
                ADD HL, BC

                RET

                endmodule

                endif ; ~_MATH_LERP_
