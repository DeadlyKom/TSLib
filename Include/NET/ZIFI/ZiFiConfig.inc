
                ifndef _WIFI_CONF_
                define _WIFI_CONF_

                module ZIFI

; registers
; receives byte from input FIFO. Input FIFO must not be empty (xIFR > 0)
; sends byte into output FIFO. Output FIFO must not be full (xOFR > 0)
; serves both ZiFi and RS-232. To select required device read correspondent FIFO register
; e.g. if ZIFR was read, ZiFi data will be read from DR

DR              EQU #BFEF                                                       ; [RW]  Data Register (#00EF - #BFEF)
ZIFR            EQU #C0EF                                                       ; [R]   Input ZiFi FIFO Used Register:
                                                                                ;           0   - input FIFO is empty
                                                                                ;           255 - input FIFO is full
ZOFR            EQU #C1EF                                                       ; [R]   Output ZiFi FIFO Free Register:
                                                                                ;           0   - output FIFO is full
                                                                                ;           255 - output FIFO is empty
RIFR            EQU #C2EF                                                       ; [R]   Input RS-232 FIFO Used Register:
                                                                                ;           0   - input FIFO is empty
                                                                                ;           255 - input FIFO is full
ROFR            EQU #C3EF                                                       ; [R]   Output RS-232 FIFO Free Register:
                                                                                ;           0   - output FIFO is full
                                                                                ;           255 - output FIFO is empty
IMR             EQU #C4EF                                                       ; [W]   Interrupt Mask Register.
ISR             EQU #C4EF                                                       ; [R]   Interrupt Source Register.
ZIBTR           EQU #C5EF                                                       ; [RW]  Input Buffer Threshold Register. number of bytes in input buffer which
                                                                                ;       triggers the interrupt if enabled. (Default 0x80)
ZITOR           EQU #C6EF                                                       ; [RW]  Input Buffer Timeout Register. number of milliseconds after last byte arrived in
                                                                                ;       input buffer when interrupt is triggered if enabled. (Default 0x01)
CR              EQU #C7EF                                                       ; [W]   Command Register. command set depends on API mode selected.
ER              EQU #C7EF                                                       ; [R]   Error Register - command execution result code. Depends on command issued.
RIBTR           EQU #C8EF                                                       ; [RW]  Input Buffer Threshold Register. number of bytes in input buffer
                                                                                ;       which triggers the interrupt if enabled. (Default 0x80)
RITOR           EQU #C9EF                                                       ; [RW]  Input Buffer Timeout Register. number of milliseconds after last
                                                                                ;       byte arrived in input buffer when interrupt is triggered if enabled. (Default 0x01)

FIFO_SIZE       EQU #BF

; Command register (CR)

FIFO_INPUT      EQU #01                                                         ; flag, clear input FIFO
FIFO_OUTPUT     EQU #02                                                         ; flag, clear output FIFO

; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | 0  |  0 |  0 |  0 |  0 |  0 |  I |  O |
;   +----+----+----+----+----+----+----+----+
;
;   I       [1]     - flag, clear input FIFO
;   O       [0]     - flag, clear output FIFO
; -----------------------------------------
ZFCLRFIFO       EQU %00000000                                                   ; clear FIFOs for ZiFi

ZFCLRFIFO_I     EQU ZFCLRFIFO | FIFO_INPUT
ZFCLRFIFO_O     EQU ZFCLRFIFO | FIFO_OUTPUT
ZFCLRFIFO_IO    EQU ZFCLRFIFO | FIFO_OUTPUT | FIFO_INPUT

; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | 0  |  0 |  0 |  0 |  1 |  0 |  I |  O |
;   +----+----+----+----+----+----+----+----+
;
;   I       [1]     - flag, clear input FIFO
;   O       [0]     - flag, clear output FIFO
; -----------------------------------------
RSCLRFIFO       EQU %00000100                                                   ; clear FIFOs for RS-232

; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | 1  |  1 |  1 |  1 |  0 | A2 | A1 | A0 |
;   +----+----+----+----+----+----+----+----+
;
;   A2-A0   [2-0]   - API:
;                       000 - API disabled
;                       001 - Transparent mode: all data is sent/received to/from external UART directly
;                       010 - Reserved
;                       011 - Reserved
;                       100 - Reserved
;                       101 - Reserved
;                       110 - Reserved
;                       111 - Reserved
; -----------------------------------------
API             EQU %11110000                                                   ; %11110mmm -> Set API mode or disable API
                                                                                
API_MODE_0      EQU API | 0x00                                                  ; disabled
API_MODE_1      EQU API | 0x01                                                  ; transparent mode
VER             EQU %11111111                                                   ; get version:
                                                                                ; register ER returns highest supported API version
                                                                                ; 0xFF - no API available

; Error register (ER)
RESULT_OK       EQU #00                                                         ; no error
RESULT_REJ      EQU #FF                                                         ; command rejected

                endmodule

                endif ; ~_WIFI_CONF_
