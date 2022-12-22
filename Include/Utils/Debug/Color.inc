
                ifndef _DEBUG_COLOR_INCLUDE_
                define _DEBUG_COLOR_INCLUDE_

COLOR:
.GROUND_SCR     EQU %0000 << 4
.GROUND_TEXT    EQU %1000 << 4
.GROUND_HEAD    EQU %0001 << 4
.DUMP_LABLE     EQU 0 + 7       | COLOR.GROUND_HEAD
.DUMP_ADR       EQU 8 + 7       | COLOR.GROUND_SCR
.DUMP_DATA      EQU 8 + 7       | COLOR.GROUND_TEXT
.DUMP_TEXT      EQU 8 + 3       | COLOR.GROUND_TEXT
.ADR            EQU %0111
.REG_LABLE      EQU 0 + 0
.REG_HL         EQU %1001 << 4
.REG_HL_        EQU %0001 << 4
.REG_DE         EQU %1010 << 4
.REG_DE_        EQU %0010 << 4
.REG_BC         EQU %1011 << 4
.REG_BC_        EQU %0011 << 4
.REG_IX         EQU %1100 << 4
.REG_IY         EQU %1101 << 4
.REG_SP         EQU %1110 << 4
.REG_PC         EQU %1111 << 4

                endif ; ~_DEBUG_COLOR_INCLUDE_
