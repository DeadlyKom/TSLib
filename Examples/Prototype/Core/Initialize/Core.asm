
                ifndef _CORE_INITIALIZE_CORE_
                define _CORE_INITIALIZE_CORE_
Core:           FMapAddrInit
                System_Setting SYS_ZCLK3_5 | SYS_CACHEEN
                Cache_Setting EN_0000 | EN_4000 | EN_8000

                ; set memory page, not initialize value mapping registers TS Conf
                SetPage1 5
                SetPage2 2
                SetPage3 8

                RET

                endif ; ~_CORE_INITIALIZE_CORE_
