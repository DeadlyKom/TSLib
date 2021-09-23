
                ifndef _MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
                define _MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
; -----------------------------------------
; linear interpolation of noise between adjacent noise values
; In :
;   LocationX - 32-bit X-axis offset
;   LocationX - lower 8-bit X-axis fractional (alpha)
;   LocationY - 32-bit Y-axis offset
;   LocationX - lower 8-bit Y-axis fractional (alpha)
; Out :
;   HL - linear noise interpolation range [-128 .. 127]
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
LerpNoise:      ; v1 = (x, y)
                LD HL, (LocationX + FPNMultiply40.Int.Low)
                LD (IntNoiseData + FPNLocation.X.Low), HL
                LD HL, (LocationX + FPNMultiply40.Int.High)
                LD (IntNoiseData + FPNLocation.X.High), HL

                LD HL, (LocationY + FPNMultiply40.Int.Low)
                LD (IntNoiseData + FPNLocation.Y.Low), HL
                LD HL, (LocationY + FPNMultiply40.Int.High)
                LD (IntNoiseData + FPNLocation.Y.High), HL

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v2 = (x + 1, y)
                LD HL, IntNoiseData + FPNLocation.X.Low
                INC (HL)
                JR NZ, $+12
                INC HL
                INC (HL)
                JR NZ, $+8
                INC HL
                INC (HL)
                JR NZ, $+4
                INC HL
                INC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v4 = (x + 1, y + 1)
                LD HL, IntNoiseData + FPNLocation.Y.Low
                INC (HL)
                JR NZ, $+12
                INC HL
                INC (HL)
                JR NZ, $+8
                INC HL
                INC (HL)
                JR NZ, $+4
                INC HL
                INC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; v3 = (x, y + 1)
                LD HL, IntNoiseData + FPNLocation.X.Low
                DEC (HL)
                JR NZ, $+12
                INC HL
                DEC (HL)
                JR NZ, $+8
                INC HL
                DEC (HL)
                JR NZ, $+4
                INC HL
                DEC (HL)

                CALL IntegerNoise
                SRA H
                RR L
                PUSH HL

                ; i2 = Lerp(v3, v4, FractionalX)
                LD A, (LocationX + FPNMultiply40.Byte)  ; FractionalX
                POP BC              ; A = v3
                POP HL              ; B = v4
                CALL Math.Lerp
                LD (.Int2), HL

                ; i1 = Lerp(v1, v2, FractionalX)
                LD A, (LocationX + FPNMultiply40.Byte)  ; FractionalX
                POP HL              ; B = v2
                POP BC              ; A = v1
                CALL Math.Lerp

                ; HL = Lerp(i1, i2, FractionalY)
                LD A, (LocationY + FPNMultiply40.Byte)  ; FractionalY
                LD B, H : LD C, L   ; A = i1
.Int2           EQU $+1
                LD HL, #0000        ; B = i2
                CALL Math.Lerp

                RET

                endif ; ~_MATH_PERLIN_NOISE_LERP_NOISE_FUNC_
