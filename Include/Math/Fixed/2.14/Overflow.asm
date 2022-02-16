                ifndef _FIXED_2_14_OVERFLOW_
                define _FIXED_2_14_OVERFLOW_
                
                ifdef FIXED_CHECK_OVERFLOW
MinOverflow:    ; set the minimum negative value available
                LD HL, FIXED_214_MIN_N
                ifdef COLOR_FLOW_WARNING
                CALL Warning.OverflowColor
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET
MaxOverflow:    ; set the maximum positive value available
                LD HL, FIXED_214_MAX_P
                ifdef COLOR_FLOW_WARNING
                CALL Warning.OverflowColor
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif

                ifdef FIXED_CHECK_OVERFLOW_VALUE
OverflowValue:  ; set the maximum positive value available
                LD HL, FIXED_214_ONE
                ifdef COLOR_FLOW_WARNING
                CALL Warning.OverflowColor
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif

                endif ; ~_FIXED_2_14_OVERFLOW_
