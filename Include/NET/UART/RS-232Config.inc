
                    ifndef _NET_UART_RS_232_CONFIG_
                    define _NET_UART_RS_232_CONFIG_

; number register DLAB = 0
REG_IO_NUM          EQU 0x00                                                    ; регистр данных
REG_IRQ_ENABLE_NUM  EQU 0x01
REG_IRQ_IDENT_NUM   EQU 0x02
REG_LINE_CTRL_NUM   EQU 0x03                                                    ; управление конфигурацией
REG_MDM_CTRL_NUM    EQU 0x04                                                    ; управление дополнительной линией
REG_LINE_STATUS_NUM EQU 0x05                                                    ; состояние приемопередатчика
REG_MDM_STATUS_NUM  EQU 0x06                                                    ; состояние дополнительной линии
REG_WORK_REG_NUM    EQU 0x07

; number register DLAB = 1
REG_DIV_L_NUM       EQU 0x00                                                    ; младшая часть делителя
REG_DIV_H_NUM       EQU 0x01                                                    ; старшая часть делителя

; port addresses
REG_BASE_ADR        EQU #F8EF                                                   ; базовый адресс
REG_IO              EQU REG_BASE_ADR + REG_IO_NUM * 0x100                       ; адрес регистра данных (RW) [DLAB = 0]
REG_DIV_L           EQU REG_BASE_ADR + REG_DIV_L_NUM * 0x100                    ; адрес регистра младшей части делителя (W) [DLAB = 1]
REG_IRQ_ENABLE      EQU REG_BASE_ADR + REG_IRQ_ENABLE_NUM * 0x100               ; адрес регистра (-) [DLAB = 0]
REG_DIV_H           EQU REG_BASE_ADR + REG_DIV_H_NUM * 0x100                    ; адрес регистра старшей части делителя (W) [DLAB = 1]
REG_IRQ_IDENT       EQU REG_BASE_ADR + REG_IRQ_IDENT_NUM * 0x100                ; адрес регистра (-) [DLAB = 0]
REG_LINE_CTRL       EQU REG_BASE_ADR + REG_LINE_CTRL_NUM * 0x100                ; адрес регистра управления конфигурацией (W) [DLAB = 0]
REG_MDM_CTRL        EQU REG_BASE_ADR + REG_MDM_CTRL_NUM * 0x100                 ; адрес регистра управления дополнительной линией (W) [DLAB = 0]
REG_LINE_STATUS     EQU REG_BASE_ADR + REG_LINE_STATUS_NUM * 0x100              ; адрес регистра состояния приемопередатчика (R) [DLAB = 0]
REG_MDM_STATUS      EQU REG_BASE_ADR + REG_MDM_STATUS_NUM * 0x100               ; адрес регистра состояния дополнительной линии (R) [DLAB = 0]
REG_WORK_REG        EQU REG_BASE_ADR + REG_WORK_REG_NUM * 0x100                 ; адрес регистра (-) [DLAB = 0]

; Line Control Register
DLAB_BIT            EQU 0x07                                                    ; Divisor Latch Access Bit
SETBRK_BIT          EQU 0x06                                                    ; Set Break
STKPAR_BIT          EQU 0x05                                                    ; Stick Parity
EPS_BIT             EQU 0x04                                                    ; Even Parity Select
PEN_BIT             EQU 0x03                                                    ; Parity Enable
STB_BIT             EQU 0x02                                                    ; Number of Stop Bits
WLSB1_BIT           EQU 0x01                                                    ; Word Length Select #1
WLSB0_BIT           EQU 0x00                                                    ; Word Length Select #0
DLAB                EQU 1 << DLAB_BIT                                           ; Divisor Latch Access Bit
SETBRK              EQU 1 << SETBRK_BIT                                         ; Set Break
STKPAR              EQU 1 << STKPAR_BIT                                         ; Stick Parity
EPS                 EQU 1 << EPS_BIT                                            ; Even Parity Select
PEN                 EQU 1 << PEN_BIT                                            ; Parity Enable
STB                 EQU 1 << STB_BIT                                            ; Number of Stop Bits
WLSB1               EQU 1 << WLSB1_BIT                                          ; Word Length Select #1
WLSB0               EQU 1 << WLSB0_BIT                                          ; Word Length Select #0

; Line Status Register
FIFOE_BIT           EQU 0x07                                                    ; Error in Receiver FIFO
TEMT_BIT            EQU 0x06                                                    ; Transmitter Empty
THRE_BIT            EQU 0x05                                                    ; Transmitter Holding Register Empty
BI_BIT              EQU 0x04                                                    ; Break Interrupt (BI)
FE_BIT              EQU 0x03                                                    ; Framing Error (FE)
PE_BIT              EQU 0x02                                                    ; Parity Error (PE)
OE_BIT              EQU 0x01                                                    ; Overrun Error (OE)
DR_BIT              EQU 0x00                                                    ; Data Ready (DR)

; Modem Control Register
RTS_BIT             EQU 0x01                                                    ; Request to Send
DTR_BIT             EQU 0x00                                                    ; Data Terminal Ready

; Modem Status Register
DCD_BIT             EQU 0x07                                                    ; Data Carrier Detect
RI_BIT              EQU 0x06                                                    ; Ring Indicator
DSR_BIT             EQU 0x05                                                    ; Data Set Ready
CTS_BIT             EQU 0x04                                                    ; Clear To Send
DDCD_BIT            EQU 0x03                                                    ; Delta Data Carrier Detect
TERI_BIT            EQU 0x02                                                    ; Trailing Edge Ring Indicator
DDSR_BIT            EQU 0x01                                                    ; Delta Data Set Ready
DCTS_BIT            EQU 0x00                                                    ; Delta Clear To Send

; Baud Rate
BR_115200           EQU (115200 / 115200) & 0xFFFF
BR_57600            EQU (115200 / 57600)  & 0xFFFF
BR_38400            EQU (115200 / 38400)  & 0xFFFF
BR_19200            EQU (115200 / 19200)  & 0xFFFF
BR_9600             EQU (115200 / 9600)   & 0xFFFF
BR_4800             EQU (115200 / 4800)   & 0xFFFF
BR_2400             EQU (115200 / 2400)   & 0xFFFF
BR_1200             EQU (115200 / 1200)   & 0xFFFF

                    endif ; ~_NET_UART_RS_232_CONFIG_
