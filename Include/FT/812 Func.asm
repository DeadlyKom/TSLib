
                ifndef _FT812_FUNC_
                define _FT812_FUNC_
; -----------------------------------------
; FT812 initialization
; In :
;   HL - address of video mode
; Out :
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
Initialize:     FT_SEND_COMMAND FT_CMD_RST_PULSE
                FT_DELAY 18
                FT_SEND_COMMAND FT_CMD_CLKEXT
                FT_DELAY 6
                FT_SEND_COMMAND FT_CMD_SLEEP
                FT_DELAY 6

                LD B, FT_CMD_CLKSEL
                LD A, (HL)
                INC HL
                OR #C0
                LD C, A
                CALL SendCommand.Param

                FT_SEND_COMMAND FT_CMD_ACTIVE
                FT_SEND_COMMAND FT_CMD_ACTIVE
                FT_DELAY 6

                FT_WR_REG8 FT_REG_PCLK, 1
                FT_WR_REG8 FT_REG_PCLK_POL, 0
                FT_WR_REG8 FT_REG_CSPREAD, 0            ; this is critical for correct colors display

                FT_TAB_LOAD FT_REG_HSYNC0
                FT_TAB_LOAD FT_REG_HSYNC1
                FT_TAB_LOAD FT_REG_HOFFSET
                FT_TAB_LOAD FT_REG_HSIZE
                FT_TAB_LOAD FT_REG_HCYCLE
                FT_TAB_LOAD FT_REG_VSYNC0
                FT_TAB_LOAD FT_REG_VSYNC1
                FT_TAB_LOAD FT_REG_VOFFSET
                FT_TAB_LOAD FT_REG_VSIZE
                FT_TAB_LOAD FT_REG_VCYCLE

                RET
; -----------------------------------------
; send command FT812 2-byte (command and parameter)
; In :
;   B - command code
;   C - command parameter
; Out :
; Corrupt :
;   AF
; Note:
; -----------------------------------------
SendCommand:    LD C, #00
.Param          FT_ON

                LD A, B
                OUT (SPI_DATA), A
                LD A, C
                OUT (SPI_DATA), A
                XOR A
                OUT (SPI_DATA), A

                FT_OFF
                RET
; -----------------------------------------
; read 8-bit value from FT812 memory
; In :
;   ADE - 22-bit memory address
; Out :
;   A   - read 8-bit value
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
Read8:          ; enabling FT812 to work through the SPI interface
                FT_ON_

                ; 22-bit memory address transfer
                LD C, SPI_DATA
                OUT (C), A
                OUT (C), D
                OUT (C), E
                OUT (C), E                                          ; dummy

                IN A, (C)                                           ; dummy

                ; read 8-bit value from FT812 memory
                IN A, (C)

                ; disable work with FT812 through the SPI interface
                FT_OFF_

                RET
; -----------------------------------------
; read 16-bit value from FT812 memory
; In :
;   ADE - 22-bit memory address
; Out :
;   BC  - read 16-bit value
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
Read16:         ; enabling FT812 to work through the SPI interface
                FT_ON_

                ; 22-bit memory address transfer
                LD C, SPI_DATA
                OUT (C), A
                OUT (C), D
                OUT (C), E
                OUT (C), E                                          ; dummy

                IN A, (C)                                           ; dummy

                ; read 16-bit value from FT812 memory
                IN A, (C)
                IN B, (C)
                LD C, A

                ; disable work with FT812 through the SPI interface
                FT_OFF
                RET
; -----------------------------------------
; read 32-bit value from FT812 memory
; In :
;   ADE  - 22-bit memory address
; Out :
;   BCDE - read 32-bit value
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
Read32:         ; enabling FT812 to work through the SPI interface
                FT_ON_

                ; 22-bit memory address transfer
                LD C, SPI_DATA
                OUT (C), A
                OUT (C), D
                OUT (C), E
                OUT (C), E                                          ; dummy

                IN A, (C)                                           ; dummy

                ; read 32-bit value from FT812 memory
                IN E, (C)
                IN D, (C)
                IN A, (C)
                IN B, (C)
                LD C, A

                ; disable work with FT812 through the SPI interface
                FT_OFF
                RET
; -----------------------------------------
; read a block data from RAM FT812
; In :
;   HL  - destination address Z80
;   ADE - 22-bit source address FT812
;   BC  - number of bytes
; Out :
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
ReadMem:        PUSH AF
                FT_ON
                POP AF

                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, E
                OUT (SPI_DATA), A
                OUT (SPI_DATA), A    ; dummy
                IN A, (SPI_DATA)     ; dummy

                LD A, B
                LD B, C
                LD C, SPI_DATA

                INIR
                OR A
                JR Z, $+5
                DEC A
                JR $-6

                FT_OFF
                RET
; -----------------------------------------
; write 8-bit value to register FT812
; In :
;   A  - 8 bit value
;   DE - lower 16 bits of the register
; Out :
;   A
; Corrupt :
; Note:
; -----------------------------------------
WriteReg8:      PUSH AF
                FT_ON

                LD A, ((FT_RAM_REG >> 16) & 0xFF) | 0x80
                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, E
                OUT (SPI_DATA), A
                POP AF
                OUT (SPI_DATA), A

                FT_OFF
                RET
; -----------------------------------------
; write 16-bit value to register FT812
; In :
;   DE - lower 16 bits of the register
;   BC - 16 bit value
; Out :
;   A
; Corrupt :
; Note:
; -----------------------------------------
WriteReg16:     FT_ON

                LD A, ((FT_RAM_REG >> 16) & 0xFF) | 0x80
                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, E
                OUT (SPI_DATA), A

                LD A, C
                OUT (SPI_DATA), A
                LD A, B
                OUT (SPI_DATA), A

                FT_OFF
                RET
; -----------------------------------------
; write 32-bit value to register FT812
; In :
;   DE   - lower 16 bits of the register
;   HLBC - 32-bit value
; Out :
;   A
; Corrupt :
; Note:
; -----------------------------------------
WriteReg32:     FT_ON

                LD A, ((FT_RAM_REG >> 16) & 0xFF) | 0x80
                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, E
                OUT (SPI_DATA), A

                LD A, C
                OUT (SPI_DATA), A
                LD A, B
                OUT (SPI_DATA), A
                LD A, L
                OUT (SPI_DATA), A
                LD A, H
                OUT (SPI_DATA), A

                FT_OFF
                RET
; -----------------------------------------
; write a block data to RAM FT812
; In :
;   HL  - source address Z80
;   ADE - 22-bit destination address FT812
;   BC  - number of bytes
; Out :
;   HL  - address + number of bytes
;   ADE - FT812 address + number of bytes
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
WriteMem:       ; TODO add assert if BC not align 4 bytes
                PUSH AF
                FT_ON
                POP AF

                PUSH AF
                OR #80
                OUT (SPI_DATA), A
                LD A, D
                OUT (SPI_DATA), A
                LD A, E
                OUT (SPI_DATA), A
                POP AF

                EX DE, HL
                ADD HL, BC
                EX DE, HL
                ADC A, #00
                PUSH AF

                LD A, C
                OR A
                LD A, B
                LD B, C
                LD C, SPI_DATA
                JR Z, $+7
                OTIR
                OR A
                JR Z, $+7
                OTIR
                DEC A
                JR NZ, $-3

                FT_OFF
                POP AF
                RET
; -----------------------------------------
; write block data to (RAM_DL + offset) FT812
; In :
;   HL - source address Z80
;   DE - 16-bit destination offset from RAM_DL FT812
;   BC - number of bytes
; Out :
;   HL  - address + number of bytes
;   ADE - RAM_DL + offset + number of bytes
; Corrupt :
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
WriteDL:        LD A, (FT_RAM_DL >> 16) & 0xFF
                JR WriteMem

                endif ; ~_FT812_FUNC_
