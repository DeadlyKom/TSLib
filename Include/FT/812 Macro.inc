
                ifndef _FT812_MACRO_
                define _FT812_MACRO_
; -----------------------------------------
; enabling FT812 to work through the SPI interface
; In :
; Out :
; Corrupt :
;   A
; Note:
; -----------------------------------------
FT_ON           macro
                LD A, SPI_FT_CS_ON
                OUT (SPI_CTRL), A
                endm
; -----------------------------------------
; enabling FT812 to work through the SPI interface
; In :
; Out :
; Corrupt :
;   BC
; Note:
; -----------------------------------------
FT_ON_          macro
                LD BC, (SPI_FT_CS_ON << 8) | SPI_CTRL
                OUT (C), B
                endm
; -----------------------------------------
; disable work with FT812 through the SPI interface
; In :
; Out :
; Corrupt :
;   A
; Note:
; -----------------------------------------
FT_OFF          macro
                LD A, SPI_FT_CS_OFF
                OUT (SPI_CTRL), A
                endm
; -----------------------------------------
; disable work with FT812 through the SPI interface
; In :
; Out :
; Corrupt :
;   BC
; Note:
; -----------------------------------------
FT_OFF_         macro
                LD BC, (SPI_FT_CS_OFF << 8) | SPI_CTRL
                OUT (C), B
                endm
; -----------------------------------------
; switch screen to mode FT812
; In :
; Out :
; Corrupt :
;   A
; Note:
; -----------------------------------------
FT_VMODE 	    macro
                LD A, VID_FT812
                OUT (VCONFIG), A
                endm
; -----------------------------------------
; send FT812 command “ACTIVE”
; In :
; Out :
; Corrupt :
;   AF
; Note:
; -----------------------------------------
FT_ACTIVE       macro 
                FT_ON
                XOR A
                OUT (SPI_DATA), A
                OUT (SPI_DATA), A
                OUT (SPI_DATA), A
                FT_OFF
                endm
; -----------------------------------------
; forced coprocessor reset
; In :
; Out :
; Corrupt :
;   AF
; Note:
; -----------------------------------------
FT_CMD_RESET    macro
                FT_WR_REG8  FT_REG_CPURESET,  1
                FT_WR_REG32 FT_REG_CMD_READ,  0
                FT_WR_REG32 FT_REG_CMD_WRITE, 0
                FT_WR_REG8  FT_REG_CPURESET,  0
                endm
; -----------------------------------------
; send command FT812 1st byte
; In :
;   Command? - 1st byte command transaction
; Out :
; Corrupt :
;   BC, AF
; Note:
; -----------------------------------------
FT_SEND_COMMAND macro Command?
                LD B, Command? & 0xFF
                CALL FT.SendCommand
                endm
; -----------------------------------------
; classic delay
; In :
;   Count? - number of interrupts to skip
; Out :
; Corrupt :
;   B
; Note:
; -----------------------------------------
FT_DELAY        macro Count?
                LD B, Count?
                HALT
                DJNZ $-1
                endm
; -----------------------------------------
; read 8-bit value from register FT812
; In :
;   Address? - lower 16 bits of the register
; Out :
;   A        - read 8-bit value
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
FT_RD_REG8      macro Address?
                PUSH DE
                LD A, (FT_RAM_REG >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read8
                POP DE
                endm
; -----------------------------------------
; read 8-bit value from FT812 memory
; In :
;   Address? - lower 16 bits of the register
; Out :
;   A        - read 8-bit value
; Corrupt :
;   DE, BC, A
; Note:
; -----------------------------------------
FT_RD_8         macro Address?
                LD A, ((Address?) >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read8
                endm
; -----------------------------------------
; read 16-bit value from register FT812
; In :
;   Address? - lower 16 bits of the register
; Out :
;   BC       - read 16-bit value
; Corrupt :
;   DE, BC, A
; Note:
; -----------------------------------------
FT_RD_REG16     macro Address?
                LD A, (FT_RAM_REG >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read16
                endm
; -----------------------------------------
; read 16-bit value from FT812 memory
; In :
;   Address? - 24-bit memory address
; Out :
;   BC       - read 16-bit value
; Corrupt :
;   BC, A
; Note:
; -----------------------------------------
FT_RD_16        macro Address?
                PUSH DE
                LD A, ((Address?) >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read16
                POP DE
                endm
; -----------------------------------------
; read 32-bit value from register FT812
; In :
;   Address? - lower 16 bits of the register
; Out :
;   BCDE     - read 32-bit value
; Corrupt :
;   DE, BC, A
; Note:
; -----------------------------------------
FT_RD_REG32     macro Address?
                LD A, (FT_RAM_REG >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read32
                endm
; -----------------------------------------
; read 32-bit value from FT812 memory
; In :
;   Address? - 24-bit memory address
; Out :
;   BCDE     - read 32-bit value
; Corrupt :
;   DE, BC, A
; Note:
; -----------------------------------------
FT_RD_32        macro Address?
                LD A, ((Address?) >> 16) & 0xFF
                LD DE, (Address?) & 0xFFFF
                CALL FT.Read32
                endm
; -----------------------------------------
; write 8-bit value to register FT812
; In :
;    Address? - lower 16 bits of the register
;    Value?   - 8 bit value
; Out :
; Corrupt :
;   DE, A
; Note:
; -----------------------------------------
FT_WR_REG8      macro Address?, Value?
                LD A, Value? & 0xFF
                LD DE, Address? & 0xFFFF
                CALL FT.WriteReg8
                endm
; -----------------------------------------
; write 16-bit value to register FT812
; In :
;    Address? - lower 16 bits of the register
;    Value?   - 16 bit value
; Out :
; Corrupt :
;   DE, BC, A
; Note:
; -----------------------------------------
FT_WR_REG16     macro Address?, Value?
                LD DE, Address? & 0xFFFF
                LD BC, Value? & 0xFFFF
                CALL FT.WriteReg16
                endm
; -----------------------------------------
; write 32-bit value to the register FT812
; In :
;   Address? - lower 16 bits of the register
;   Value?   - 32 bit value
; Out :
; Corrupt :
;   HL, DE, BC, A
; Note:
; -----------------------------------------
FT_WR_REG32     macro Address?, Value?
                LD DE, Address? & 0xFFFF
                LD HL, (Value? >> 16) & 0xFFFF
                LD BC, Value? & 0xFFFF
                CALL FT.WriteReg32
                endm
; -----------------------------------------
; write 16-bit values to register FT812 from the Z80 memory area
; In :
;   HL        - address source of reading 16-bit values
;   Address?  - lower 16 bits of the register
; Out :
; Corrupt :
;  HL, DE, BC, AF
; Note:
; -----------------------------------------
FT_TAB_LOAD     macro Address?
                LD DE, Address? & 0xFFFF
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                CALL FT.WriteReg16
                endm
; -----------------------------------------
; set the required screen resolution
; In :
;   Resolution? :
;       * VM_640_480_57Hz
;       * VM_640_480_74Hz
;       * VM_640_480_76Hz
;       * VM_800_600_60Hz
;       * VM_800_600_69Hz
;       * VM_800_600_85Hz
;       * VM_1024_768_59Hz
;       * VM_1024_768_67Hz
;       * VM_1024_768_76Hz
; Out :
; Corrupt :
;  HL, DE, BC, AF
; Note:
; -----------------------------------------
; select video resolution
FT_RESOLUTION   macro Resolution?, ResolutionRef?
                if     Resolution? == VM_640_480_57Hz
                LD HL, 640
                LD (ResolutionRef? + 0), HL
                LD HL, 480
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_640_480_74Hz
                LD HL, 640
                LD (ResolutionRef? + 0), HL
                LD HL, 480
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_640_480_76Hz
                LD HL, 640
                LD (ResolutionRef? + 0), HL
                LD HL, 480
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_800_600_60Hz
                LD HL, 800
                LD (ResolutionRef? + 0), HL
                LD HL, 600
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_800_600_69Hz
                LD HL, 800
                LD (ResolutionRef? + 0), HL
                LD HL, 600
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_800_600_85Hz
                LD HL, 800
                LD (ResolutionRef? + 0), HL
                LD HL, 600
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_1024_768_59Hz
                LD HL, 1024
                LD (ResolutionRef? + 0), HL
                LD HL, 768
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_1024_768_67Hz
                LD HL, 1024
                LD (ResolutionRef? + 0), HL
                LD HL, 768
                LD (ResolutionRef? + 2), HL
                elseif Resolution? == VM_1024_768_76Hz
                LD HL, 1024
                LD (ResolutionRef? + 0), HL
                LD HL, 768
                LD (ResolutionRef? + 2), HL
                endif
                LD HL, Resolution?
                CALL FT.Initialize
                endm
; -----------------------------------------
; write a data to memory area of 'Display List' FT812
; In :
;   Address? - lower 16 bits of the FT_RAM_DL address
;   Offset?  - 16-bit destination offset from RAM_DL FT812
;   Size?    - number of bytes to copy
; Out :
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
FT_WR_DL        macro Source?, Offset?, Size?
                LD HL, Source? & 0xFFFF
                LD A, (FT_RAM_DL >> 16) & 0xFF
                LD DE, Offset? & FT_DL_MASK
                LD BC, Size? & FT_DL_MASK
                CALL WriteMem
                endm
; -----------------------------------------
; write a data to the FIFO command i.e. RAM_CMD
; In :
;   Address? - lower 16 bits of the FT_RAM_DL address
;   Size?    - number of bytes to copy
;   if the C flag is set, it is necessary to align the data with 4 bytes
; Out :
; Corrupt :
;   HL, BC, AF
; Note:
; -----------------------------------------
FT_WR_CMD       macro Address?, Size?
                LD HL, Address? & 0xFFFF
                LD BC, Size? & 0xFFFF
                CALL FT.Coprocessor.Write
                endm
; -----------------------------------------
; write a 32-bits value to the FIFO command i.e. RAM_CMD
; In :
;   Value? - 32-bits value
; Out :
;   if the C flag is set, the coprocessor is fault,
;   otherwise the command or data has successfully append to FIFO
; Corrupt :
;   HL, DE, F
; Note:
; -----------------------------------------
FT_WR32_CMD     macro Value?
                LD HL, (Value? >> 16) & 0xFFFF
                LD DE, Value? & 0xFFFF
                CALL FT.Coprocessor.Write32
                endm
; -----------------------------------------
; write a data to memory FT812 by DMA
; In :
;   Source?      - source address (0x0000 - 0x3FFF)
;   SourcePage?  - source number page
;   Destination? - 22-bit destination address FT
;   Size?        - number of bytes to copy
; Out :
; Corrupt :
;  HL, DE, BC, AF
; Note:
; -----------------------------------------
FT_WR_DMA       macro Source?, SourcePage?, Destination?, Size?
                FT_ON

                ; for SPI memory write transactions, the host sends a ‘1’ bit and ‘0’ bit, followed by the 22-bit address. This is followed by the write data.
                LD A, (Destination? >> 16) & 0xFF
                OR #80
                OUT (SPI_DATA), A
                LD A, (Destination? >> 8) & 0xFF
                OUT (SPI_DATA), A
                LD A, (Destination? >> 0) & 0xFF
                OUT (SPI_DATA), A

                ; set source address DMA (RAM)
                DMA_Src SourcePage? & 0xFF, Source? & 0x3FFF

                ; DEBC = data length in bytes
                LD DE, (Size? >> 17) & 0x0007
                LD BC, (Size? >> 1)  & 0xFFFF

                ;
                PUSH BC

                ;
                LD A, E
                OR A
                JR Z, .Less_128kb

.Send128kb      DMA_Size 256, 512
                DMA_Ctrl DMA_RAM_SPI
                DMA_Wait
                DEC E
                JR NZ, .Send128kb

.Less_128kb     POP BC
                LD A, C
                EX AF, AF'

                ;
                LD A, B
                OR A
                JR Z, .Less512b

                ;
                LD BC, DMANUM
                OUT (C), A
                LD B, HIGH DMALEN
                LD A, #FF
                OUT (C), A
                DMA_Ctrl DMA_RAM_SPI
                DMA_Wait

.Less512b       EX AF, AF'
                OR A
                JR Z, .End
                EX AF, AF'
                XOR A
                LD BC, DMANUM
                OUT (C), A
                LD B, HIGH DMALEN
                EX AF, AF'
                OUT (C), A
                DMA_Ctrl DMA_RAM_SPI
                DMA_Wait

.End            FT_OFF
                endm

                endif ; ~_FT812_MACRO_
