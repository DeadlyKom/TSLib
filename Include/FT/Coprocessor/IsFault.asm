
                ifndef _COPROCESSOR_IS_FAULT_
                define _COPROCESSOR_IS_FAULT_
; -----------------------------------------
; check for coprocessor fault
; In :
; Out :
;   if the C flag is set, the coprocessor is faulty
; Corrupt :
;   DE, AF
; Note:
; -----------------------------------------
IsFault:        PUSH HL
                PUSH BC
                FT_RD_REG16 FT_REG_CMD_READ
                LD HL, #F001
                ADD HL, BC
                POP BC
                POP HL
                RET

                endif ; ~_COPROCESSOR_IS_FAULT_
