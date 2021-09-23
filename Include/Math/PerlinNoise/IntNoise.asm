

                ifndef _MATH_PERLIN_NOISE_INT_NOISE_FUNC_
                define _MATH_PERLIN_NOISE_INT_NOISE_FUNC_
; -----------------------------------------
; an integer-noise function outputs a pseudorandom value 
; given an n-dimensional input value
; In :
;   LocationX - 32-bit X-axis offset (IntNoiseData + 0)
;   LocationY - 32-bit Y-axis offset (IntNoiseData + 4)
; Out :
;   HL - PRNG range [-128 .. 127]
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
IntegerNoise:   ifndef PERLIN_NOISE_TAB_INCLUDE
                LD B, HIGH PRNG_TAB
                else
                LD B, HIGH ADR_PRNG_TAB
                endif
                LD HL, IntNoiseData
                LD C, (HL)

                rept 8 
                LD A, (BC)
                INC HL
                ADD A, (HL)
                LD C, A
                endr

                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                
                RET

                endif ; ~_MATH_PERLIN_NOISE_INT_NOISE_FUNC_
