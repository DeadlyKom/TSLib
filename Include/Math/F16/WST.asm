
                module F16

; Store Word. Convert absolute value of a floating-point number into unsigned 16-bit integer.
;  In: HL = floating point to convert
; Out: HL = Word representation, set carry if overflow
; Pollutes: AF, B
WST:            LD A, H                 ;  1:4
                AND EXP_MASK            ;  2:7
                
                CP BIAS + 16            ;  2:7
                JR NC, .OVERFLOW        ;  2:7/12

                SUB BIAS - 1            ;  2:7
                JR C, .ZERO             ;  2:7/12
                                        ;               A = 0..16
        if 0
                LD B, A                 ;  1:4
                LD A, L                 ;  1:4
                LD HL, #0000            ;  3:10
                JR Z, .ROUNDING         ;  2:7/12
                SCF                     ;  1:4
                
.NORM           ADC HL, HL              ;  2:15
                ADD A, A                ;  1:4
                DJNZ .NORM              ;  2:13/8

                RET NC                  ;  1:11/5
.ROUNDING       OR A                    ;  1:4
                RET Z                   ;  1:11/5
                INC  HL                 ;  1:6
                RET                     ;  1:10
        else
                LD H, #01               ;  2:7
                SUB #09                 ;  2:7
                JR NC, ._256PLUS        ;  2:7
                
                DEC HL                  ;  1:6          rounding ( 0.5000 down => 0.4999 down )
                SRL H                   ;  2:8
                RR L                    ;  2:8
                INC A                   ;  1:4
                JR Z, $+7               ;  2:12/7
                SRL L                   ;  2:8
                INC A                   ;  1:4
                JR NZ, $-3              ;  2:12/7
                RET NC                  ;  1:11/5
                INC L                   ;  1:4
            ifdef CARRY_FLOW_WARNING
                OR A                    ;  1:4
            endif
                RET                     ;  1:10

._256PLUS       RET Z                   ;  1:5/11
                LD B, A                 ;  1:4
                ADD HL, HL              ;  1:11
                DJNZ $-1                ;  2:13/8
                RET                     ;  1:10
        endif
    
.OVERFLOW
            ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING   ;  3:17
            endif
                LD HL, #FFFF            ;  3:10
            ifdef CARRY_FLOW_WARNING
                SCF                     ;  1:4
            endif
                RET                     ;  1:10     RET with carry

.ZERO
            ifdef CARRY_FLOW_WARNING
                XOR A                   ;  1:4
                LD H, A                 ;  1:4
                LD L, A                 ;  1:4        
            else
                LD HL, #0000            ;  3:10    
            endif
                RET                     ;  1:10     RET with carry

                endmodule
