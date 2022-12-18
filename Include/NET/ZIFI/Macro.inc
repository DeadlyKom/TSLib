                ifndef _NET_ZIFI_MACRO_
                define _NET_ZIFI_MACRO_
; -----------------------------------------
; set port Data Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
REG_DR          macro
                LD BC, DR
                endm
; -----------------------------------------
; set port Command Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
REG_CMD         macro
                LD BC, CR
                endm
; -----------------------------------------
; set port Error Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
REG_ER          macro
                LD BC, ER
                endm
; -----------------------------------------
; set port FIFO Used Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
REG_ZIFR        macro
                LD BC, ZIFR
                endm
; -----------------------------------------
; set port FIFO Free Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
REG_ZOFR        macro
                LD BC, ZOFR
                endm
; -----------------------------------------
; set command to Command Register
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_COMMAND     macro CMD?
                LD A, CMD?
                OUT (C), A
                endm
; -----------------------------------------
; get result command
; In:
; Out:
;   A - result
; Corrupt:
; -----------------------------------------
GET_RESULT      macro
                IN A, (C)
                endm
; -----------------------------------------
; input data transfer
; In:
;   HL - pointer input buffer
; Out:
; Corrupt:
; Note:
; -----------------------------------------
INPUT_DATA      macro
                REG_DR
                INIR
                endm
; -----------------------------------------
; sync input data transfer
; In:
;   HL  - pointer destination buffer
;   E   - buffer size
;   WD? - time waiting for data
; Out:
;   E   - remaining buffer space
;   if flag C is clear then timeout
; Corrupt:
; Note:
; -----------------------------------------
SYNC_INPUT_DATA macro WD?
                LD C, LOW ZIFR

.Loop           LD D, WD?
.WaitData       XOR A
                DEC D
                JR Z, .Timeout

                LD B, HIGH ZIFR
                IN B, (C)
                JR Z, .WaitData                                                 ; jump if input FIFO is full

                ; clamp buffer size
                LD A, E
                SUB B
                JR NC, .NotOverflow

                ; buffer overflow, limit number of bytes read by remaining space in buffer
                ; LD B, E
                ; XOR A
.Read           INI
                DEC E
                JR NZ, .Read
                JR .Timeout

.NotOverflow    LD E, A

                ; read data from FIFO
                INIR

                ; check available buffer space
                OR A
                JR NZ, .Loop
                SCF

.Timeout        ;
                endm
;-----------------------------------------
; output data transfer
; In:
;   HL - pointer output buffer
;   BC - 
; Out:
; Corrupt:
;   HL, BC, AF
; Note:
; -----------------------------------------
OUTPUT_DATA     macro
                REG_DR
                OTIR
                endm
; -----------------------------------------
; wait output FIFO is empty
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
WAIT_EMPTY_FIFO_OUTPUT macro
                REG_ZOFR
.Loop           GET_RESULT
                CP HIGH DR
                JR NZ, .Loop                                                    ; jump if output FIFO is full
                endm
; -----------------------------------------
; wait output FIFO is empty
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
WAIT_EMPTY_FIFO_INPUT macro
                REG_ZIFR
.Loop           GET_RESULT
                OR A
                JR NZ, .Loop                                                    ; jump if input FIFO is full
                endm
; -----------------------------------------
; In:
; Out:
; Corrupt:
; -----------------------------------------
CLEAR_RESPONSE  macro
                LD HL, ResponseFlags
                RES RESPONSE_BIT, (HL)
                endm
; -----------------------------------------
; In:
; Out:
; Corrupt:
; -----------------------------------------
SET_RESPONSE    macro
                LD HL, ResponseFlags
                SET RESPONSE_BIT, (HL)
                endm
; -----------------------------------------
; In:
; Out:
; Corrupt:
; -----------------------------------------
CHECK_RESPONSE  macro
                LD HL, ResponseFlags
                BIT RESPONSE_BIT, (HL)
                endm
; -----------------------------------------
; In:
; Out:
; Corrupt:
; -----------------------------------------
WAIT_RESPONSE   macro
.WaitResponse   CALL Net.ZiFi.Response
                LD HL, ResponseFlags
                BIT RESPONSE_BIT, (HL)
                JR Z, .WaitResponse
                endm

                endif ; ~_NET_ZIFI_MACRO_
