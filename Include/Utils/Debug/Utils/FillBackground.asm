
                ifndef _DEBUG_UTILS_FILL_BACKGROUND_COLOR_
                define _DEBUG_UTILS_FILL_BACKGROUND_COLOR_
; -----------------------------------------
;
; In:
;   A  - new backgound color
;   DE - size (D - X, E - Y)
;   BC - the location of the displayed disassembled code (B - X, C - Y)
; Out:
;   HL - character address in screen coordinates
; Corrupt:
;
; -----------------------------------------
FillBackground: EX AF, AF'
                CALL Debug.Utils.GetAdrScreen
                INC L
                EX AF, AF'
                AND #F0
                LD C, A
.LoopY          PUSH HL
                LD B, D
.LoopX          LD A, #0F
                AND (HL)
                OR C
                LD (HL),A
                INC L
                INC L
                DJNZ .LoopX
                POP HL
                INC H
                DEC E
                JR NZ, .LoopY
                RET

                endif ; ~_DEBUG_UTILS_FILL_BACKGROUND_COLOR_
