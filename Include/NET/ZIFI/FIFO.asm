
                ifndef _NET_ZIFI_FIFO_
                define _NET_ZIFI_FIFO_
; -----------------------------------------
; clear input FIFO
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearInput:     SET_COMMAND ZFCLRFIFO_I
                WAIT_EMPTY_FIFO_INPUT
                RET
; -----------------------------------------
; clear output FIFO
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearOutput:    SET_COMMAND ZFCLRFIFO_O
                WAIT_EMPTY_FIFO_OUTPUT
                RET
; -----------------------------------------
; send AT command
; In:
;   HL - pointer to string AT command
;   E  - string length AT command
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SendATCommand:  LD BC, ZOFR

                ; waiting for a suitable AT command size in FIFO
.WaitLoop       IN A, (C)
                CP E
                JR C, .WaitLoop
                
                ; send AT command
                LD B, HIGH DR
.SendLoop       OUTI
                DEC E
                JR NZ, .SendLoop

                CLEAR_RESPONSE
                RET

WaitResponse:   WAIT_RESPONSE
                RET

                endif ; ~_NET_ZIFI_FIFO_
