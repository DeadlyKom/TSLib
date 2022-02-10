
                ifndef _EXAMPLE_CORE_INITIALIZE_
                define _EXAMPLE_CORE_INITIALIZE_

Initialize:     CALL Core
                CALL Interrupt
                CALL Video
                RET

                endif ; ~_EXAMPLE_CORE_INITIALIZE_
