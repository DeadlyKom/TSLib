
                module F16

; Add two floating-point numbers
;  In: HL, DE numbers to add, no restrictions
; Out: HL = HL + DE
; Pollutes: AF, B, DE
ADD:            LD A, H                 ;  1:4
                XOR D                   ;  1:4
                JP M, SUBP              ;  3:10

; Add two floating point numbers with the same sign
;  In: HL, DE numbers to add, no restrictions
; Out: HL = HL + DE,  if ( carry_flow_warning && overflow ) set carry
; Pollutes: AF, B, DE
; -------------- HL + DE ---------------
; HL = (+HL) + (+DE)
; HL = (-HL) + (-DE)
ADDP:           LD A, H                 ;  1:4
                SUB D                   ;  1:4
                JR NC, .HL_GR           ;  2:7/12   
                EX DE, HL               ;  1:4      
                NEG                     ;  2:8
.HL_GR          AND EXP_MASK            ;  2:7
                JR Z, .EQ_EXP           ;  2:12/7   neresime zaokrouhlovani
                CP 2 + MANT_BITS        ;  2:7      pri posunu o NEUKLADANY_BIT+BITS_MANTIS uz mantisy nemaji prekryt, ale jeste se muze zaokrouhlovat 
                RET NC                  ;  1:11/5   HL + DE = HL, RET with reset carry
                                        ;           Out: A = --( E | 1 0000 0000 ) >> A        
                LD B, A                 ;  1:4
                LD A, E                 ;  1:4
                DEC A                   ;  1:4
                CP #FF                  ;  2:7
                DB #1E                  ;  2:7      LD E, #B7
.LOOP           OR A                    ;  1:4
                RRA                     ;  1:4
                DJNZ .LOOP              ;  2:13/8
                JR C, ._1               ;  2:12/7

                ADD A, L                ;  1:4      soucet mantis
                JR NC, ._0_SAME_EXP     ;  2:12/7
.EXP_PLUS                               ;           A = 10 mmmm mmmr, r = rounding bit                                    
                ADC A, B                ;  1:4      rounding
                RRA                     ;  1:4      A = 01 cmmm mmmm
                LD L, A                 ;  1:4
                LD A, H                 ;  1:4        
                INC H                   ;  1:4
                XOR H                   ;  1:4      RET with reset carry
                RET P                   ;  1:11/5        
                JR .OVERFLOW            ;  2:12
._0_SAME_EXP                            ;           A = 01 mmmm mmmm 0
                LD L, A                 ;  1:4
                RET                     ;  1:10

._1             ADD A, L                ;  1:4      soucet mantis
                JR C, .EXP_PLUS         ;  2:12/7
._1_SAME_EXP                            ;           A = 01 mmmm mmmm 1, reset carry
            if 1
                LD L, A                 ;  1:4
                INC L                   ;  1:4
                RET NZ                  ;  1:11/5
        
                LD A, H                 ;  1:4        
                INC H                   ;  1:4
                XOR H                   ;  1:4      RET with reset carry
                RET P                   ;  1:11/5
            else
                LD L, A                 ;  1:4
                LD A, H                 ;  1:4        
                INC HL                  ;  1:6
                XOR H                   ;  1:4      RET with reset carry
                RET P                   ;  1:11/5
            endif
                JR .OVERFLOW            ;  2:12
.EQ_EXP                                 ;           HL exp = DE exp
                LD A, L                 ;  1:4       1 mmmm mmmm
                ADD A, E                ;  1:4      +1 mmmm mmmm
                                        ;           1m mmmm mmmm
                RRA                     ;  1:4      sign in && shift       
                LD L, A                 ;  1:4
                LD A, H                 ;  1:4        
                INC H                   ;  1:4
                XOR H                   ;  1:4      RET with reset carry
                RET P                   ;  1:11/5
.OVERFLOW       DEC H                   ;  1:4      
                LD L, #FF               ;  2:7
            ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING   ;  3:17
            endif
            ifdef CARRY_FLOW_WARNING
                SCF                     ;  1:4      carry = error
            endif
                RET                     ;  1:10

                endmodule
