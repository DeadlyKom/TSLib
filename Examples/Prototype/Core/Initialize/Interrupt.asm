
                ifndef _CORE_INITIALIZE_INTERRUPT_
                define _CORE_INITIALIZE_INTERRUPT_
Interrupt:      LD HL, INT_Handler
                LD (InterruptVA_Frame), HL
                LD A, HIGH InterruptVA
                LD I, A
                IM 2

                ; enable interrupt frame
                INT_Setting INT_MSK_FRAME

                EI
                HALT
                RET

INT_Handler:    EI
                RET

                endif ; ~_CORE_INITIALIZE_INTERRUPT_
