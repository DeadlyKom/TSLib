
                ifndef _EXAMPLE_CORE_ENTRY_POINT_
                define _EXAMPLE_CORE_ENTRY_POINT_
EntryPoint:     LD SP, StackTop
                CALL Initialize
                JP Loop.Main

                endif ; ~_EXAMPLE_CORE_ENTRY_POINT_
