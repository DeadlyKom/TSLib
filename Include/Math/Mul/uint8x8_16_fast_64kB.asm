
                ifndef _MATH_MULTIPLY_UINTEGER_8x8_16_FAST_64KB_
                define _MATH_MULTIPLY_UINTEGER_8x8_16_FAST_64KB_

                ifndef PAGE_MUL_8x8_FAST_64KB_
                define PAGE_MUL_8x8_FAST_64KB_ PAGE3
                endif

                module Math
; -----------------------------------------
; unsigned integer multiplies L by C
; In :
;   L - multiplicand
;   C  - multiplier
; Out :
;   DE - product L * C
; Corrupt :
; Node:
;   fastest, with 64 KB tables + 512 byte
; -----------------------------------------
MulUint8x8_16:  LD H, HIGH Table
                LD A, (HL)

                ifndef MAPPING_REGISTERS
                LD (FMADDR_REGS + HIGH PAGE_MUL_8x8_FAST_64KB_), A
                else
                lua pass1
                sj.error("MulUint8x8_16: no port mapping mode supported");
                endlua
                endif
                
                INC H
                LD H, (HL)
                LD L, C
                LD E, (HL)
                INC H
                LD D, (HL)
                RET

                endmodule

                endif ; ~_MATH_MULTIPLY_UINTEGER_8x8_16_FAST_64KB_
