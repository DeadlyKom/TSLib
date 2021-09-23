
                module F16

; Subtract two floating-point numbers
;  In: HL, DE numbers to subtract, no restrictions
; Out: HL = HL - DE
; Pollutes: AF, B, DE
SUB:            LD A, D                ;  1:4
                XOR SIGN_MASK          ;  2:7
                LD D, A                ;  1:4      DE = -DE

; Subtraction two floating-point numbers with the same signs
;  In: HL,DE numbers to add, no restrictions
; Out: HL = HL + DE, if ( carry_flow_warning && underflow ) set carry
; Pollutes: AF, BC, DE
; -------------- HL - DE ---------------
; HL = (+HL) - (+DE) = (+HL) + (-DE)
; HL = (-HL) - (-DE) = (-HL) + (+DE)
SUBP:           LD A, H                 ;  1:4
                SUB D                   ;  1:4
                JP M, .HL_GR            ;  3:10
                EX DE, HL               ;  1:4
                LD A, H                 ;  1:4
                SUB D                   ;  1:4
.HL_GR          AND EXP_MASK            ;  2:7
                JR Z, .EQ_EXP           ;  2:12/7

                CP 2 + MANT_BITS        ;  2:7      pri posunu vetsim nez o MANT_BITS + NEUKLADANY_BIT + ZAOKROUHLOVACI_BIT uz mantisy nemaji prekryt
                JR NC, .TOOBIG          ;  2:12/7   HL - DE = HL
                                        ;           Out: E = ( E | 1 0000 0000 ) >> A        
                LD B, A                 ;  1:4
                LD A, E                 ;  1:4
                RRA                     ;  1:4      1mmm mmmm m
                DEC B                   ;  1:4
                JR Z, .NOLOOP           ;  2:12/7
                DEC B                   ;  1:4
                JR Z, .LAST             ;  2:12/7
.LOOP           OR A                    ;  1:4
                RRA                     ;  1:4
                DJNZ .LOOP              ;  2:13/8
.LAST           RL B                    ;  2:8      B = rounding 0.25
                RRA                     ;  1:4        
.NOLOOP                                 ;           carry = rounding 0.5
                LD E, A                 ;  1:4
                LD A, L                 ;  1:4
                JR C, ._1               ;  2:12/7
                
                SUB E                   ;  1:4
                JR NC, ._0_SAME_EXP     ;  2:12/7
        
.NORM_RESET     OR A                    ;  1:4
.NORM                                   ;           normalizace cisla
                DEC H                   ;  1:4      exp--
                ADC A, A                ;  1:4
                JR NC, .NORM            ;  2:7/12
                
                SUB B                   ;  1:4
                LD L, A                 ;  1:4
                LD A, D                 ;  1:4
                XOR H                   ;  1:4
                RET M                   ;  1:11/5   RET with reset carry
                JR .UNDERFLOW           ;  2:12

._0_SAME_EXP                            ;           reset carry
                LD L, A                 ;  1:4      
                RET NZ                  ;  1:11/5

                SUB B                   ;  1:4      exp--? => rounding 0.25 => 0.5 
                RET Z                   ;  1:11/5

                DEC HL                  ;  1:6
                LD A, D                 ;  1:4
                XOR H                   ;  1:4
                RET M                   ;  1:11/5   RET with reset carry
                JR .UNDERFLOW           ;  2:12

._1             SBC A, E                ;  1:4      rounding half down
                JR C, .NORM             ;  2:12/7   carry => need half up
                LD L, A                 ;  1:4 
                RET                     ;  1:10
   
.EQ_EXP         LD A, L                 ;  1:4
                SUB E                   ;  1:4
                JR Z, .UNDERFLOW        ;  2:12/7   (HL_exp = DE_exp && HL_mant = DE_mant) => HL = -DE
                JR NC, .EQ_NORM         ;  2:12/7
                EX DE, HL               ;  1:4
                NEG                     ;  2:8

.EQ_NORM                                ;           normalizace cisla
                DEC H                   ;  1:4      exp--
                ADD A, A                ;  1:4      musime posouvat minimalne jednou, protoze NEUKLADANY_BIT byl vynulovan
                JR NC, .EQ_NORM         ;  2:7/12
                
                LD L, A                 ;  1:4        
                LD A, D                 ;  1:4
                XOR H                   ;  1:4 
                RET M                   ;  1:11/5
.UNDERFLOW      LD L, $00               ;  2:7      
                LD A, D                 ;  1:4
                CPL                     ;  1:4
                AND SIGN_MASK           ;  2:7
                LD H, A                 ;  1:4
            ifdef COLOR_FLOW_WARNING
                CALL UNDER_COL_WARNING  ;  3:17
            endif
            ifdef CARRY_FLOW_WARNING
                SCF                     ;  1:4      carry = error
            endif
                RET                     ;  1:10

.TOOBIG         RET NZ                  ;  1:11/5   HL_exp - DE_exp > 7+1+1 => HL - DE = HL

                LD A, L                 ;  1:4
                OR A                    ;  1:4
                RET NZ                  ;  1:11/5   HL_mant > 1.0           => HL - DE = HL

                DEC L                   ;  1:4
                DEC H                   ;  1:4      HL_exp = 8 + 1 + DE_exp  => HL_exp >= 9 => not underflow
                RET                     ;  1:10

                endmodule
