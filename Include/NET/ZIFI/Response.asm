
                ifndef _NET_ZIFI_RESPONSE_
                define _NET_ZIFI_RESPONSE_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Response:       ;
                LD HL, (.Buffer)
                LD A, (.BufferSize)
                LD E, A
                ;   HL  - pointer destination buffer
                ;   E   - buffer size
                SYNC_INPUT_DATA #00
                LD (HL), #00
                ;   E   - remaining buffer space
                ;   if flag C is clear then timeout
                JR NC, .Timeout                                                 ; jump, if timeout

                ; save remaining buffer space
                LD A, E
                OR A
                JR Z, .IsFull
                LD (.BufferSize), A
                LD (.Buffer), HL

                RET

.Timeout        LD B, D
.IsFull         LD A, FIFO_SIZE
                SUB E
                RET Z

                LD C, A

                LD HL, .ResponseBuffer
.NewLine        LD D, H
                LD E, L

                ; end of line detection
.Loop           LD A, (HL)
                CP "\r"
                JR Z, .ReturnChar
.NextChar       INC HL
                DEC C
                JR NZ, .Loop
                JR .EndBuffer

.ReturnChar     LD B, L
.ReturnCharLoop INC HL
                DEC C
                JR Z, .EndBuffer
                LD A, (HL)
                CP "\n"
                JR NZ, .ReturnCharLoop
                DEC C
                
                ; add new response message
                PUSH BC
                PUSH HL

                LD L, B
                LD (HL), "\0"

                ; check empty response
                OR A
                SBC HL, DE
                JR Z, .Next

                EX DE, HL
                PUSH HL
                LD A, Console.Verbose
                CALL Console.Add
                POP HL
                CALL Approve

.Next           POP HL
                INC HL
                POP BC
                LD A, C
                OR A
                JR NZ, .NewLine

                LD A, FIFO_SIZE
                LD HL, .ResponseBuffer
                JR .Set

.EndBuffer      OR A
                SBC HL, DE
                LD B, H
                LD C, L
                LD A, FIFO_SIZE
                SBC L
                LD HL, .ResponseBuffer
                EX DE, HL
                LDIR
                EX DE, HL
.Set            LD (.Buffer), HL
                LD (.BufferSize), A
                RET

.Buffer         DW .ResponseBuffer
.BufferSize     DB FIFO_SIZE
.ResponseBuffer DS FIFO_SIZE + 1, #00
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Approve:        LD (.Response), HL
                LD DE, RESPONSE.OK
                CALL String.Contains
                JR NC, .IsSuccess

                LD HL, (.Response)
                LD DE, RESPONSE.ERROR
                CALL String.Contains
                JR NC, .IsError

                LD HL, (.Response)
                LD DE, RESPONSE.FAIL
                CALL String.Contains
                JR NC, .IsError

                RET
                
.IsSuccess      LD HL, ResponseFlags
                RES RES_OP_BIT, (HL)
                SET RESPONSE_BIT, (HL)
                RET

.IsError        LD HL, ResponseFlags
                SET RES_OP_BIT, (HL)
                SET RESPONSE_BIT, (HL)
                RET

.Response       DW #0000
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------

; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | .. | .. | .. | .. | .. | .. | OP |  R |
;   +----+----+----+----+----+----+----+----+
;
;   R       [0]     - response
;   OP      [1]     - result operation
; -----------------------------------------
ResponseFlags:  DB #00

RESPONSE_BIT    EQU 0x00

RES_OP_BIT      EQU 0x01
RES_OP_OK       EQU 0 << RES_OP_BIT
RES_OP_ERR      EQU 1 << RES_OP_BIT

                endif ; ~_NET_ZIFI_RESPONSE_
