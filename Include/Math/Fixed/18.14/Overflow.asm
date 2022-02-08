                ifndef _FIXED_18_14_OVERFLOW_
                define _FIXED_18_14_OVERFLOW_
                
                ifdef FIXED_CHECK_OVERFLOW
MinOverflow:    ; set the minimum negative value available
                LD HL, (FIXED_1814_MIN_N >> 16) & 0xFFFF
                LD BC, (FIXED_1814_MIN_N >>  0) & 0xFFFF
                ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET
MaxOverflow:    ; set maximum available value
                LD HL, (FIXED_1814_MAX_P >> 16) & 0xFFFF
                LD BC, (FIXED_1814_MAX_P >>  0) & 0xFFFF
                ifdef COLOR_FLOW_WARNING
                CALL OVER_COL_WARNING
                endif
                ifdef CARRY_FLOW_WARNING
                SCF                                                             ; set carry, it's error
                endif
                RET

                endif

                endif ; ~_FIXED_18_14_OVERFLOW_
