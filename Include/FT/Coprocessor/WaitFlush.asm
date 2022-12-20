
                ifndef _COPROCESSOR_WAIT_FLUSH_
                define _COPROCESSOR_WAIT_FLUSH_
; -----------------------------------------
; wait till command FIFO buffer empty
; In :
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command FIFO buffer is empty
; Corrupt :
;   F
; Note:
; -----------------------------------------
WaitFlush:      PUSH HL
                PUSH DE
                PUSH BC
                PUSH AF
                
.Wait           ; compare two registers REG_CMD_READ and REG_CMD_WRITE,
                ; if the FIFO buffer is empty they will be the same
                FT_RD_REG16 FT_REG_CMD_READ
                PUSH BC
                FT_RD_REG16 FT_REG_CMD_WRITE
                POP HL
                OR A
                SBC HL, BC
                JR NZ, .NotEmpty

                POP AF
                POP BC
                POP DE
                POP HL
                OR A
                RET

.NotEmpty       ; check coprocessor is not fault
                CALL IsFault
                JR NC, .Wait

                ifdef DEBUG_EVE
                POP AF
                POP BC
                POP DE
                POP HL
                JP DisplayError
                else
                POP AF
                POP BC
                POP DE
                POP HL
                endif

                SCF
                RET

                endif ; ~_COPROCESSOR_WAIT_FLUSH_