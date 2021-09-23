
                module F16

; Round towards zero
; In: HL any floating-point number
; Out: HL same number rounded towards zero
; Pollutes: AF,B
ROUND:          LD A, H                 ;
                SUB BIAS                ;
            ifdef FRAC_ZERO
                JR C, .FRAC_ZERO        ;  2:12/7   Completely fractional
            else
                JR C, .ZERO             ;  2:12/7   Completely fractional
            endif

.NEXT           SUB MANT_BITS
                RET NC                  ;           Already integer
                NEG                     ;  2:8

                LD B, A                 ;  1:4
                LD A, #FF               ;  2:7
.LOOP                                   ;           odmazani mantisy za plovouci radovou carkou
                ADD A, A                ;  1:4
                DJNZ .LOOP              ;  2:13/8
                AND L                   ;  1:4
                LD L, A                 ;  1:4
                RET

            ifndef FRAC_ZERO
.ZERO           LD HL, FPMIN            ; -0???
                RET
            endif

                endmodule
