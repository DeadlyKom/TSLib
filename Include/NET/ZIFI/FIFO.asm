
                ifndef _NET_ZIFI_FIFO_
                define _NET_ZIFI_FIFO_
; -----------------------------------------
; clear input FIFO
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearInput:     SET_COMMAND ZIFI.ZFCLRFIFO_I
                WAIT_EMPTY_FIFO_INPUT
                RET
; -----------------------------------------
; clear output FIFO
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearOutput:    SET_COMMAND ZIFI.ZFCLRFIFO_O
                WAIT_EMPTY_FIFO_OUTPUT
                RET
; -----------------------------------------
; send AT command
; In:
;   HL - pointer AT command
;   DE - pointer read data
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SendATCommand:  ; initialize
                XOR A
                REG_DR
                
                ; send AT command
.SendLoop       OUTI
                CP (HL)
                JR NZ, .SendLoop

                ; read data
                EX DE, HL
                SYNC_INPUT_DATA ZIFI.FIFO_SIZE, #00

                RET

; Command:        ;

;                 LD BC, ZIFI.ZOFR
; .Loop           IN A, (C)
;                 CP E

;                 RET

                endif ; ~_NET_ZIFI_FIFO_
