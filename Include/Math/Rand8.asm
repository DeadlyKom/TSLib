
                ifndef _MATH_RAND_8
                define _MATH_RAND_8

                module Math
; -----------------------------------------
; 8-bit random number generator
; In :
; Out :
;   A - random number
; Corrupt :
;   HL, DE, BC, AF
; Note:
;   https://gist.github.com/raxoft/2275716fea577b48f7f0
; -----------------------------------------
Rand8:          LD HL, .Table

                LD A, (HL)          ; i = (i & 7) + 1
                AND #07
                INC A
                LD (HL), A

                INC L               ; hl = &cy

                LD D, H             ; de = &q[i]
                ADD A, L
                LD E, A

                LD A, (DE)          ; y = q[i]
                LD B, A
                LD C, A
                LD A, (HL)          ; ba = 256 * y + cy

                SBC C               ; ba = 255 * y + cy
                JR NC,$+3
                DEC B

                SUB C               ; ba = 254 * y + cy
                JR NC,$+3
                DEC B

                SUB C               ; ba = 253 * y + cy
                JR NC,$+3
                DEC B

                LD (HL), B          ; cy = ba >> 8, x = ba & 255
                CPL                 ; x = (b-1) - x = -x - 1 = ~x + 1 - 1 = ~x
                LD (DE), A          ; q[i] = x

                RET

.Table          DB #00, #00, #52, #61, #78, #6F, #66, #74, #14, #0F

                if (Rand8.Table / 256) - ((Rand8.Table + 9) / 256)
                error "whole table must be within single 256 byte block"
                endif

                endmodule

                endif ; ~_MATH_RAND_8
