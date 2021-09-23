
                module F16

; Floating-point multiplication
;  In: DE, BC multiplicands
; Out: HL = BC * DE, if ( carry_flow_warning && (overflow || underflow )) set carry;
; Pollutes: AF, BC, DE

; SEEE EEEE MMMM MMMM
; Sign       0 .. 1           = 0??? ???? ???? ???? .. 1??? ???? ???? ???? 
; Exp      -64 .. 63          = ?000 0000 ???? ???? .. ?111 1111 ???? ????;   (Bias 64 = #40)
; Mantis   1.0 .. 1.99609375  = ???? ???? 0000 0000 .. ???? ???  1111 1111 = 1.0000 0000 .. 1.1111 1111
; use POW2TAB
MUL:            LD A, B                 ;  1:4
                ADD A, D                ;  1:4
                SUB BIAS                ;  2:7          HL_exp = (BC_exp-BIAS + DE_exp-BIAS) + BIAS = BC_exp + DE_exp - BIAS
                LD H, A                 ;  1:4          seee eeee
                
                XOR B                   ;  1:4
                XOR D                   ;  1:4
                JP M, .FLOW             ;  3:10
                LD B, H                 ;  1:4          seee eeee
.HOPE           LD A, C                 ;  1:4
                SUB E                   ;  1:4
                JR NC, .DIFF            ;  2:12/7
                LD A, E                 ;  1:4
                SUB C                   ;  1:4
.DIFF           LD L, A                 ;  1:4          L = a - b
                LD A, E                 ;  1:4
                LD H, HIGH TAB_AmB_lo   ;  2:7          
                LD E, (HL)              ;  1:7
                INC H                   ;  1:4        
                LD D, (HL)              ;  1:7
                ADD A, C                ;  1:4
                LD L, A                 ;  1:4          L = a + b
                
                SBC A, A                ;  1:4
                ADD A, A                ;  1:4
                ADD A, HIGH TAB_ApB_lo_0;  2:7
                LD H, A                 ;  1:4
                
                LD A, (HL)              ;  1:4
                ADD A, E                ;  1:4
                LD E, A                 ;  1:4          for rounding
                INC H                   ;  1:4
                LD A, (HL)              ;  1:4
                ADC A, D                ;  1:4  
                LD H, A                 ;  1:4
                LD L, E                 ;  1:4
                
                JP P, .NOADD            ;  3:10         (ApB)+(AmB) >= #4000 => pricti: #00
                                        ;               (ApB)+(AmB) >= #8000 => pricti: #20
                LD DE, #0020            ;  3:10
                ADD  HL, DE             ;  1:11
                ADD HL, HL              ;  1:11

                LD L, H                 ;  1:4
                LD H, B                 ;  1:4

                INC H                   ;  1:4
                LD A, B                 ;  1:4
                XOR H                   ;  1:4
                RET P                   ;  1:11/5

                ; In: B sign
.OVER           LD A, B                 ;  1:4
.OVER_A         OR EXP_MASK             ;  2:7
                LD H, A                 ;  1:4
                LD L, #FF               ;  2:7
            ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING   ;  3:17
            endif
            ifdef CARRY_FLOW_WARNING
                SCF                     ;  1:4          carry = error
            endif
                RET                     ;  1:10

.NOADD          ADD HL, HL              ;  1:11
                ADD HL, HL              ;  1:11

                LD L, H                 ;  1:4
                LD H, B                 ;  1:4        
            ifdef CARRY_FLOW_WARNING
                OR A                    ;  1:4
            endif
                RET                     ;  1:10
        
.FLOW           LD A, H                 ;  1:4
                CPL                     ;  1:4          real sign
                BIT 6, H                ;  2:8          sign+(#00..#3E)=overflow, sign+(#40..#7F)=underflow
                JR Z, .OVER_A           ;  2:12/7

                ADD A, A                ;  1:4          sign out
                JR NZ, .UNDER           ;  2:12/7
                
                RRA                     ;  1:4
                LD B, A                 ;  1:4          s000 0000 
                CALL .HOPE              ;  3:17         exp+1
                LD A, H                 ;  1:4
                DEC H                   ;  1:4          exp-1
                XOR H                   ;  1:4
                RET P                   ;  1:11/5  
                
                XOR H                   ;  1:4          sign
                ADD A, A                ;  1:4          sign out
.UNDER          LD HL, #0100            ;  3:10
                RR H                    ;  2:8          sign in, set carry
            ifdef COLOR_FLOW_WARNING
                CALL UNDER_COL_WARNING  ;  3:17
            endif
                RET                     ;  1:10

                endmodule
