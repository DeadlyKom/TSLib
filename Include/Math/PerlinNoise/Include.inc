

                ifndef _MATH_PERLIN_NOISE_INCLUDE_
                define _MATH_PERLIN_NOISE_INCLUDE_

                ; defining internal structures
                struct FPNInt32
.Low            DW #0000
.High           DW #0000
                ends

                struct FPNLocation
.X              FPNInt32 0x0000, 0x0000
.Y              FPNInt32 0x0000, 0x0000
                ends

                struct FPNMultiply40
.Byte           DB #00
.Int            FPNInt32
                ends

                struct FNoise2D
.Frequency      DB #00
.Location       FPNLocation 0x0000, 0x0000
                ends

                module Math

                ; if there is this definition you need to include the files
                ifndef PERLIN_NOISE_INCLUDE
                include "../Mul/Int32x8_40.asm"
                include "../Lerp.asm"
                endif

                ; default table of 256 values, if necessary, 
                ; you can determine the address aligned 256 bytes 
                ; and independently generate values from -128 to 127
                ifndef PERLIN_NOISE_TAB_INCLUDE
                include "PRNG_Tab.inc"
                else
                ifndef ADR_PRNG_TAB
                error "PerlinNoise table address not specified"
                endif
                endif

                include "IntNoise.asm"
                include "LerpNoise.asm"
                include "PerlinNoise.asm"
Noise2D:        FNoise2D 0x18
LocationX:      FPNMultiply40
LocationY:      FPNMultiply40
IntNoiseData:   FPNLocation

                endmodule

                endif ; ~_MATH_PERLIN_NOISE_INCLUDE_
